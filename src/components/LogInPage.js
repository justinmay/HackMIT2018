import React, {Component} from 'react'
import {createUser, logIn} from '../firebase/index.js'

class LogInPage extends Component {
  constructor() {
    super() 
    this.state = {
      email: "", 
      password: ""
    }
  }

  handleChange = (event) => {
    this.setState({
      [event.target.name]: event.target.value
    }, () => {
      console.log(this.state)
    })
  }
  handleSubmit = () => {
    console.log("submit!")
  }
  render() {
    return (
      <div>
        <h3>Please Log In</h3>
        <div>
          <input name="email" type="text" placeholder="e-mail" onChange={this.handleChange} />
          <input name="password" type="text" placeholder="password..." onChange={this.handleChange} />
        </div>
        <button onClick={this.handleSubmit}>Log In</button>
      </div>
    )
  }
}

export default LogInPage