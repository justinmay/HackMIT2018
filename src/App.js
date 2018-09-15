import React, { Component } from 'react';
import { HashRouter, Route, Switch } from "react-router-dom";

//COMPONENTS
import HomePage from './components/HomePage'
import LogInPage from './components/LogInPage';


class App extends Component {
  render() {
    return (
    <div>
      <HashRouter>
        <div>
          <Route path='/' component={HomePage} />
          <Route path='/login' component={LogInPage} />
        </div>
      </HashRouter>
    </div>
    );
  }
}

export default App;
