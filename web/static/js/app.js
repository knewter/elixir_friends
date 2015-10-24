import {Socket} from "deps/phoenix/web/static/js/phoenix"

let App = {
}

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
          <h3 className="card-title">
            {this.props.username}
          </h3>
          <p className="card-text">
            {this.props.content}
          </p>
          <p className="card-date">
            <span className="small">
              {this.props.insertedAt}
            </span>
          </p>
        </div>
      </div>
    )
  }
})

window.onload = () => {
  let element = document.getElementById("app")
  React.render(<PostList source="/api/posts" />, element)
}

export default App
