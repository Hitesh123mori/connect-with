import express from 'express';
import bodyParser from 'body-parser';
import { usersCollection } from '../database_setup/config.mjs';
import { doc, getDoc } from 'firebase/firestore';

const app = express();
app.use(bodyParser.json());

// Get user information
app.get('/userinformation', async (req, res) => {
    const { userID } = req.query;

    if (!userID) {
        return res.status(400).send({ message: 'Missing userID parameter.' });
    }

    try {
        const userDoc = doc(usersCollection, userID);
        const userSnap = await getDoc(userDoc);

        if (!userSnap.exists()) {
            return res.status(404).send({ message: 'User not found.' });
        }

        const userData = userSnap.data();
        res.status(200).send(userData);
    } catch (error) {
        console.error('Error fetching user information:', error);
        res.status(500).send({ message: 'Internal server error.' });
    }
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
