import {Socket} from "phoenix"
import $ from 'jquery'
import React from 'react'
import ReactDOM from 'react-dom'
import ReactCSSTransitionGroup from 'react-addons-css-transition-group'
import classNames from 'classnames'
import moment from 'moment'

require('css/app')

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

    function correctDate(post) {
      post.inserted_at = post.inserted_at || Date.now().toString()
      return post
    }
  },
  injectNewPost(post) {
    this.setState({
      posts: [post].concat(this.state.posts)
    })
  },
  render() {
    let posts = this.state.posts.map((post) => {
      return (
        <Post imageUrl={post.image_url}
          key={post.id+post.inserted_at+post.content}
          username={post.username}
          insertedAt={post.inserted_at}
          content={post.content} />
      )
    })
    return(
      <div className="post-list">
        <ReactCSSTransitionGroup transitionName='post' transitionEnterTimeout={500} transitionLeaveTimeout={300} transitionAppear={true} transitionAppearTimeout={500}>
          {posts}
        </ReactCSSTransitionGroup>
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
    date: React.PropTypes.string
  },

  render() {
    let timeSince = (this.props.date ? moment(this.props.date) : moment()).fromNow()

    return (
      <span className="card-date">
        {timeSince}
      </span>
    )
  }
})

window.onload = () => {
  let element = document.getElementById("app")
  ReactDOM.render(<App />, element)
}

export default App
