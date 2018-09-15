import firebase from 'firebase'

firebase.initializeApp({
  apiKey: "AIzaSyAMjAwqYhemFLaMeFg_vfFsRrL3hvkcvqQ",
    authDomain: "hackmit2018-b67a1.firebaseapp.com",
  projectId: "hackmit2018-b67a1",
});

// Initialize Cloud Firestore through Firebase
var db = firebase.firestore();

// Disable deprecated features
db.settings({
  timestampsInSnapshots: true
});

export default db;