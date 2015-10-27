import {Socket} from "deps/phoenix/web/static/js/phoenix"

let App = React.createClass({
  render() {
    return (
      <div>
        <Header />
        <PostList source="/api/posts" />
        <Footer />
      </div>
    )
  }
})

const Header = React.createClass({
  render() {
    return (
      <header className="header">
        <div className='header-container'>
          <h1 className="header-title">
            #ElixirFriends
          </h1>
          <h2 className="header-tagline">
            Create and share together.
          </h2>
        </div>
      </header>
    )
  }
})

const Footer = React.createClass({
  render() {
    return (
      <footer className="footer">
        <p>
          Made by <TwitterLink username='elixirsips' />, <TwitterLink username='knewter' /> and <TwitterLink username='ChrisKeathley' />.
          <span> </span>
          Comments, Pull Requests, and Issues are welcome on <a href="https://github.com/knewter/elixir_friends">Github.</a>
        </p>
      </footer>
    )
  }
})

let PostList = React.createClass({
  getInitialState() {
    return {
      posts: []
    }
  },
  componentDidMount() {
    $.get(this.props.source, result => {
      result = JSON.parse(result)
      this.setState({
        posts: result.entries
      })
    })
    this.subscribeToNewPosts()
  },
  subscribeToNewPosts() {
    let socket = new Socket("/socket")
    socket.connect()
    let channel = socket.channel("posts:new", {})
    channel.join().receive("ok", chan => {
      console.log("joined")
    })
    channel.on("new:post", post => {
      this.injectNewPost(post)
    })
  },
  injectNewPost(post) {
    this.setState({
      posts: [post].concat(this.state.posts)
    })
  },
  render() {
    return(
      <div className="post-list">
        {this.state.posts.map(function(post){
          return <Post imageUrl={post.image_url} username={post.username} insertedAt={post.inserted_at} content={post.content} />
        })}
      </div>
    )
  }
})

let Post = React.createClass({
  render() {
    return(
      <div className="card">
        <div className='card-meta'>
          <TwitterLink username={this.props.username} />
          <PostedAt date={this.props.insertedAt} />
        </div>
        <img className="card-image" src={this.props.imageUrl} />
        <div className="card-content">
          <p className="card-text">
            {this.props.content}
          </p>
        </div>
      </div>
    )
  }
})

const TwitterLink = React.createClass({
  propTypes: {
    username: React.PropTypes.string.isRequired
  },

  render() {
    var props     = this.props
      , className = classNames(props.className, 'twitter-handle')
      , username  = props.username
      , link      = `https://twitter.com/${username}`

    return (
      <a className={className} href={link}>
        @{this.props.username}
      </a>
    )
  }
})

const PostedAt = React.createClass({
  propTypes: {
    date: React.PropTypes.string.isRequired
  },

  render() {
    let timeSince = moment(this.props.date).fromNow()

    return (
      <span className="card-date">
        {timeSince}
      </span>
    )
  }
})

window.onload = () => {
  let element = document.getElementById("app")
  React.render(<App />, element)
}

export default App
