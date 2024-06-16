import express from "express";
import bodyParser from "body-parser";
import { auth, createUserWithEmailAndPassword, usersCollection } from "../database_setup/config.mjs";
import { addDoc} from 'firebase/firestore';

const app = express();
app.use(bodyParser.json());




// register/ add user to database api

app.post('/register', async (req, res) => {
  const { userName, email, password } = req.body;
  try {
    const userCredential = await createUserWithEmailAndPassword(auth, email, password);
    const user = userCredential.user;

    const appUser = {
      userID: user.uid,
      email: email,
      userName: userName,
      pronoun: "",
      additionalName: "",
      profilePath: "",
      coverPath: "",
      headLine: "",
      curPosition: "",
      industry: "",
      location: "",
      city: "",
      about: "",
      followers: 0,
      following: 0,
      profileViews: 0,
      searchCount: 0,
      testScores: [],
      skills: [],
      projects: [],
      language: [],
      experiences: [],
      educations: [],
      button: {},
      courses: [],
      certifications: [],
      info: {},
    };

    await addDoc(usersCollection, appUser);

    res.status(201).send({ message: 'User registered successfully'});
  } catch (error) {
    if (error.code === 'auth/email-already-in-use') {
      res.status(400).send({ message: 'The email address is already in use by another account.' });
    } else {
      res.status(400).send({ message: error.message });
    }
  }
});





const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
