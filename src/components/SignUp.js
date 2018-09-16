import React, {Component} from "react";
import {addReliefCenter} from '../firebase/reliefCenter'
import {addToLat} from '../util/addressToLatLong'
import {validateEmail} from "../util/validation"

export default class SignUp extends Component {
  constructor() {
    super()
    this.state = {
      email: "",
      password: "",
      repassword: "",
      contactName: "",
      institutionName: "",
      institutionLocation: "",
      institutionPhoneNumber: "",
      institutionLatLong: "",
    }
  }
  handleChange = (event) => {
    this.setState({
      [event.target.name]: event.target.value
    }, () => console.log(this.state));
  }
  handleAddress = (event) => {
    this.setState({
      institutionLocation: event.target.value
    }, async () => {
      this.setState({
        institutionLatLong: await addToLat(this.state.institutionLocation)
      })
    })
  }

  finalCheck = () => {
    const checkEmail = validateEmail(this.state.email)
    console.log("email check: ", checkEmail)
    const checkPassword = (this.state.password == this.state.repassword)
    console.log("password check: ", checkPassword)

    if(checkEmail && checkPassword) {
      return true
    }
    else {
      return false
    }
  }  
  handleSubmit = () => {
    const check = this.finalCheck()
    if(check) {
      addReliefCenter(this.state)
      this.props.history.push('/')
    }
    else {
      window.alert('please check your information one more time!')
    }
  }
  render() {
    return (
      <div>
        <h3>Please Fill out the following</h3>
        <form>
        <div>
          <label>E-Mail</label>
          <input type='text' name='email' value={this.state.email} placeholder="Institution Email" onChange={this.handleChange} />
        </div>
        <div>
          <label>Password</label>
          <input type='text' name='password' value={this.state.password} placeholder="Institution Password" onChange={this.handleChange} />
        </div>
        <div>
          <label>Retype Password</label>
          <input type='text' name='repassword' value={this.state.repassword} placeholder="Retype Institution Password" onChange={this.handleChange} />
        </div>
        <div>
          <label>Contact Name</label>
          <input type='text' name='contactName' value={this.state.contactName} placeholder="Contact Name" onChange={this.handleChange}/>
        </div>
        <div>
          <label>Institution Name</label>
          <input type='text' name='institutionName' value={this.state.institutionName} placeholder="Institution Name" onChange={this.handleChange}/>
        </div>
        <div>
          <label>Institution Location</label>
          <input type='text' name='institutionLocation' value={this.state.institutionLocation} placeholder="Institution Location" onChange={this.handleAddress}/>
        </div>
         <div>
          <label>Institution Phone Number</label>
          <input type='tel' name='institutionPhoneNumber' value={this.state.institutionPhoneNumber} placeholder="123-456-7890" onChange={this.handleChange} pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}"
           required />
        </div>
        <button onClick={this.handleSubmit}>Register Relief Center</button>
        </form>
      </div>
    )
  }
}