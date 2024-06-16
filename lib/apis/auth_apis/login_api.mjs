import { auth, signInWithEmailAndPassword, usersCollection } from '../database_setup/config.mjs';
import { getDoc, doc } from 'firebase/firestore';
import express from 'express';
import bodyParser from 'body-parser';

const app = express();
app.use(bodyParser.json());

app.post('/login', async (req, res) => {
    const { email, password } = req.body;
    try {
        const userCredential = await signInWithEmailAndPassword(auth, email, password);
        const user = userCredential.user;
        
        console.log(`User UID: ${user.uid}`);

        const userDocRef = doc(usersCollection, user.uid);
        const userDoc = await getDoc(userDocRef);
        
        if (userDoc.exists()) {
            res.status(200).send({ message: 'Login successful' });
        } else {
            res.status(404).send({ message: 'User data not found' });
        }
    } catch (error) {
        if (error.code === 'auth/user-not-found') {
            res.status(400).send({ message: 'User not found' });
        } else if (error.code === 'auth/wrong-password') {
            res.status(400).send({ message: 'Incorrect password' });
        } else {
            res.status(400).send({ message: error.message });
        }
    }
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
