import React, { Component } from 'react';
import { HashRouter, Route, Switch } from "react-router-dom";
import {user} from './firebase/auth'
import * as firebase from 'firebase'
import {withAuth} from 'fireview'

//COMPONENTS
import HomePage from './components/HomePage'
import SignUp from "./components/SignUp"

class App extends Component {
  constructor(props) {
    super(props)
  }
  render() {
    return (
      <HashRouter>
        <div>
          <Route exact path='/' render={(props) => <HomePage user={this.props._user}/>} />
          <Route exact path='/signup' component={SignUp} />
        </div>
    </HashRouter>
    );
  }
}

export default withAuth(App);
