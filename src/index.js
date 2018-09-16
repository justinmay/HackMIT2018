import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import registerServiceWorker from './registerServiceWorker';
import * as firebase from 'firebase'
import {AuthProvider} from 'fireview'
ReactDOM.render(<AuthProvider auth={firebase.auth()}><App /></AuthProvider>, document.getElementById('root'));
registerServiceWorker();
