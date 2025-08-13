import express, { json, urlencoded } from "express";
import mongoose, { connect } from "mongoose";
import SalesRepresentative from './salesRepresentative.js';
import Product from './product.js';
import dotenv from "dotenv";

dotenv.config({ path: './server.env' }); // Load variables from .env

const app = express();
app.use(json());
app.use(urlencoded({ extended: true }));

connect(process.env.MONGODB_URI)
  .then(() => {
    console.log("MongoDB connected successfully");
  })
  .catch((err) => {
    console.error("MongoDB connection error:", err);
  });

    // Health check endpoint
    app.get('/health', (req, res) => {
    const isConnected = mongoose.connection.readyState === 1;
    if (isConnected) {
      console.log('Health check successful: DB connected');
      res.status(200).json({ status: 'Server is running', db: 'connected' });
    } else {
      console.log('Health check: DB not connected');
      res.status(503).json({ status: 'Server is running', db: 'not connected' });
    }
    });

    // GET function to fetch all sales representatives
    app.get('/sales-representatives', async (req, res) => {
      try {
        const reps = await SalesRepresentative.find();
        console.log('Fetched all sales representatives');
        res.json(reps);
      } catch (err) {
        res.status(500).json({ error: 'Failed to fetch sales representatives' });
      }
    });

    // GET function to fetch all products
    app.get('/products', async (req, res) => {
      try {
        const products = await Product.find();
        console.log('Fetched all products');
        res.json(products);
      } catch (err) {
        res.status(500).json({ error: 'Failed to fetch products' });
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
            console.log(`Sales representative login successful: ${username}`);
            res.json(rep);
          } else {
            console.log(`Sales representative login failed for username: ${username}`);
            res.status(404).json({ error: 'Sales representative not found' });
          }
      } catch (err) {
        res.status(500).json({ error: 'Error checking sales representative' });
      }
    });

    app.listen(process.env.PORT, () => {
      console.log(`Server is running on port ${process.env.PORT}`);
    });

    // app.listen(process.env.PORT, () => {
    //   console.log(`Server is running on port ${process.env.PORT}`);
    // });


