import React, {Component} from 'react'
import {Link} from 'react-router-dom'
import {  connect } from "react-redux"
import LogInPage from "./LogInPage"
import GoogleMap from "./map/GoogleMap"
import firebase from 'firebase'
/////
import {getCenterThunk } from '../store/reliefCenterReducer'

class HomePage extends Component {
  constructor() {
    super() 
    this.state = {
      logIn: ""
    }
  }
  setTrue = () => {
    this.setState({
      logIn: true
    })
  }
  setFalse = () => {
    this.setState( {
      login:false
    })
  }

  render() {
    firebase.auth().onAuthStateChanged((user) => {
      if (user) {
        this.setTrue()
      } else {
        this.setFalse()
      }
    });
    return (
      <div>
      <h1>ResQ Emergency Relief Center</h1>
      <div>
        <GoogleMap />
      </div>
        {(this.state.logIn)?(<h1>User Logged In!</h1>):(
        <div>
          <LogInPage history={this.props.history}/>
          <p>Not registered with us? Register your relief center <Link to="/signup">here</Link>!</p>
       </div>)}
    </div> 
    )
  }
}
 
const mapState = (state) => {
  return {
    centers: state.relief
  }
}

const mapDispatch = dispatch => {
  return {
    getCenter: async (email) => {
      await dispatch(getCenterThunk(email))
    }
  }
}

const connectedHomePage = connect(mapState, mapDispatch)

export default connectedHomePage(HomePage)