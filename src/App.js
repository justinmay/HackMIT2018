import React, { Component } from 'react';
import { HashRouter, Route, Switch } from "react-router-dom";

//COMPONENTS
import HomePage from './components/HomePage'
import LogInPage from './components/LogInPage'
import error from './components/error';


class App extends Component {
  render() {
    return (
    <div>
      <HashRouter>
        <div>
          <Route exact path='/' component={HomePage} />
          <Route exact path='/login' component={LogInPage} />

        </div>
      </HashRouter>
    </div>
    );
  }
}

export default App;
