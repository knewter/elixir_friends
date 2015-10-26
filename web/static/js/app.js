import {Socket} from "deps/phoenix/web/static/js/phoenix"

let App = React.createClass({
  render() {
    return (
      <div>
        <Header />
        <PostList source="/api/posts" />
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
            Create and share together
          </h2>
        </div>
      </header>
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
        <img className="card-image" src={this.props.imageUrl} />
        <div className="card-content">
          <p className="card-text">
            {this.props.content}
          </p>
          <div className='card-meta'>
            <TwitterHandle user={this.props.username} />
            <span> - </span>
            <PostedAt date={this.props.insertedAt} />
          </div>
        </div>
      </div>
    )
  }
})

const TwitterHandle = React.createClass({
  propTypes: {
    user: React.PropTypes.string.isRequired
  },

  render() {
    return (
      <a href={`https://twitter.com/${this.props.user}`}>
        @{this.props.user}
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
      <span className="small">
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
