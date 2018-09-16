import React, { Component } from 'react'
import { HashRouter, Route, Switch } from "react-router-dom"
import {auth} from './firebase/index'
import {withAuth} from 'fireview'
import store from "./store/index"
import { Provider } from "react-redux"
import firebase from 'firebase'

//COMPONENTS
import HomePage from './components/HomePage'
import SignUp from "./components/SignUp"

class App extends Component {
  constructor(props) {
    super(props)
  }
  
  render() {
    return (
      <Provider store={store}>
        <HashRouter>
          <div>
            <Route exact path='/' component={HomePage} />
            <Route exact path='/signup' component={SignUp} />
          </div>
        </HashRouter>
      </Provider>
    );
  }
}

export default withAuth(App);
