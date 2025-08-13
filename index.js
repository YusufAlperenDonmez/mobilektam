import express, { json, urlencoded } from "express";
import { connect } from "mongoose";
import SalesRepresentative from './salesRepresentative.js';

const app = express();
app.use(json());
app.use(urlencoded({ extended: true }));

connect("mongodb+srv://alperendonmez:FDtiyWc5ZHphArdF@alperen-dev.yhsnjpo.mongodb.net/app_data")
  .then(() => {
    console.log("MongoDB connected successfully");

    app.get('/health', (req, res) => {
        const isConnected = !!(connect.connections && connect.connections[0] && connect.connections[0].readyState === 1);
        if (isConnected) {
            res.status(200).json({ status: 'Server is running', db: 'connected' });
        } else {
            res.status(503).json({ status: 'Server is running', db: 'not connected' });
        }
    });

    // GET function to fetch all sales representatives
    app.get('/sales-representatives', async (req, res) => {
      try {
        const reps = await SalesRepresentative.find();
        res.json(reps);
      } catch (err) {
        res.status(500).json({ error: 'Failed to fetch sales representatives' });
      }
    });

    // GET function to check if a sales representative exists by username and password in query params
    app.get('/sales-representatives/check-user', async (req, res) => {
      const { username, password } = req.query;
      if (!username || !password) {
        return res.status(400).json({ error: 'Username and password are required' });
      }
      try {
        const rep = await SalesRepresentative.findOne({ username, password });
        if (rep) {
          res.json(rep);
        } else {
          res.status(404).json({ error: 'Sales representative not found' });
        }
      } catch (err) {
        res.status(500).json({ error: 'Error checking sales representative' });
      }
    });

    app.listen(2000, () => {
      console.log('Server is running on port 2000');
    });

    // app.listen(process.env.PORT, () => {
    //   console.log(`Server is running on port ${process.env.PORT}`);
    // });
  })
  .catch((err) => {
    console.error("MongoDB connection error:", err);
  });

