import React, {Component} from 'react'
import LogInPage from "./LogInPage"
import {Link} from 'react-router-dom'

export default class HomePage extends Component {
  constructor(props) {
    super(props)
  }
  render() {
    console.log(this.props)
    return (
      <div>
      <h1>ResQ Emergency Relief Center</h1>
        {(this.props.user)?(<h1>User Logged In!</h1>):(
        <div>
          <LogInPage history={this.props.history}/>
          <p>Not registered with us? Register your relief center <Link to="/signup">here</Link>!</p>
       </div>)}
    </div> 
    )
  }
}
