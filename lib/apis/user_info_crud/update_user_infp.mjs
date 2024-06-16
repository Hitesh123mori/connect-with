import express from "express";
import bodyParser from "body-parser";
import { auth, createUserWithEmailAndPassword, usersCollection } from "../database_setup/config.mjs";
import { addDoc, doc, updateDoc } from 'firebase/firestore';

const app = express();
app.use(bodyParser.json());


// updation api


app.put('/userinformation/update', async (req, res) => {
    const { userID, fieldName, fieldValue } = req.body;

    if (!userID || !fieldName || typeof fieldValue === 'undefined') {
        return res.status(400).send({ message: 'Missing required parameters.' });
    }

    try {
        const userDoc = doc(usersCollection, userID);
        await updateDoc(userDoc, {
            [fieldName]: fieldValue
        });

        res.status(200).send({ message: 'User information updated successfully' });
    } catch (error) {
        res.status(400).send({ message: error.message });
    }
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
