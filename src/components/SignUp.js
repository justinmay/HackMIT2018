import React, {Component} from "react";

export default class SignUp extends Component {
  constructor() {
    super()
    this.state = {
      institutionName: "",

    }
  }

  render() {
    return (
      <div>
        <h3>Please Fill out the following</h3>
        <div>
          <label>Institution Name</label>
          <input type='text' name='institutionName' value={this.state.institutionName} placeholder="Institution Name" onChange={this.handleChange}/>
        </div>
      </div>
    )
  }
}