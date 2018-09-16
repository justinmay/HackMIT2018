import React, {Component} from 'react'
import {createUser, logIn} from '../firebase/auth'

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
  handleSubmit = async () => {
    await logIn(this.state.email, this.state.password);
    this.props.history.push('/')
  }

  render() {
    return (
      <div>
        <h3>Relief Institution Log In</h3>
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