import { initializeApp } from 'firebase/app';
import { getAuth, createUserWithEmailAndPassword ,signInWithEmailAndPassword} from 'firebase/auth';
import { getFirestore, collection } from 'firebase/firestore';
import { addDoc } from 'firebase/firestore';

const firebaseConfig = {
  apiKey: "AIzaSyBz3JASiU8stKWEhZscP7psILUhKYPLK1E",
  authDomain: "connect-with-92657.firebaseapp.com",
  projectId: "connect-with-92657",
  storageBucket: "connect-with-92657.appspot.com",
  messagingSenderId: "652406056606",
  appId: "1:652406056606:web:ec3e0a0252dd923a013d8f",
  measurementId: "G-2Y0BHNZL6D"
};

const app = initializeApp(firebaseConfig);
const auth = getAuth(app);
const db = getFirestore(app);
const usersCollection = collection(db, "users");

export { app,auth,addDoc ,createUserWithEmailAndPassword, signInWithEmailAndPassword,usersCollection };
