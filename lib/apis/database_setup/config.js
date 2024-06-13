const firebase  = require("firebase") ;


export const firebaseConfig = {
  apiKey: "AIzaSyBz3JASiU8stKWEhZscP7psILUhKYPLK1E",
  authDomain: "connect-with-92657.firebaseapp.com",
  projectId: "connect-with-92657",
  storageBucket: "connect-with-92657.appspot.com",
  messagingSenderId: "652406056606",
  appId: "1:652406056606:web:ec3e0a0252dd923a013d8f",
  measurementId: "G-2Y0BHNZL6D"
};

// Initialize Firebase
firebase.initializeApp(firebaseConfig);

export const db = firebase.firestore() ;

export const auth = firebase.auth() ;