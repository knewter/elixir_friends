import {Socket} from "phoenix"

// let socket = new Socket("/ws")
// socket.connect()
// let chan = socket.chan("topic:subtopic", {})
// chan.join().receive("ok", chan => {
//   console.log("Success!")
// })

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
  },
  render() {
    return(
      <div className="ui grid stackable">
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
      <div className="four wide column">
        <div className="ui card">
          <div className="image">
            <img src={this.props.imageUrl} />
          </div>
          <div className="content">
            <div className="header">
              {this.props.username}
            </div>
            <div className="meta">
              <span className="date">{this.props.insertedAt}</span>
            </div>
            <div className="description">
              {this.props.content}
            </div>
          </div>
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
