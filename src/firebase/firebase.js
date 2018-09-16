import * as firebase from 'firebase'
require("firebase/firestore");

var config = {
  apiKey: "AIzaSyAMjAwqYhemFLaMeFg_vfFsRrL3hvkcvqQ",
  authDomain: "hackmit2018-b67a1.firebaseapp.com",
  databaseURL: "https://hackmit2018-b67a1.firebaseio.com",
  projectId: "hackmit2018-b67a1",
  storageBucket: "hackmit2018-b67a1.appspot.com",
  messagingSenderId: "567774515333"
  };

firebase.initializeApp(config);


const auth = firebase.auth();
const firestore = firebase.firestore()

export {
  auth, firestore
}
