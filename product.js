import mongoose from 'mongoose';

// Define the schema for a product
const productSchema = new mongoose.Schema({
  name: { type: String, required: true },
  price: { type: Number, required: true },
  description: { type: String },       // optional
  stock: { type: Number, default: 0 }  // optional
});

// Explicitly set the collection name to 'products'
const Product = mongoose.model(
  'Product',      // Mongoose model name
  productSchema,  // Schema
  'products'      // Collection name in MongoDB
);

export default Product;
