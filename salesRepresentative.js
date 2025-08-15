import mongoose from 'mongoose';

// Define the schema for a sales representative
const salesRepresentativeSchema = new mongoose.Schema({
  username: { type: String, required: true },
  password: { type: String, required: true }
});

// Explicitly set the collection name to 'sales_reps'
const SalesRepresentative = mongoose.model(
  'SalesRepresentative',       // Mongoose model name
  salesRepresentativeSchema,   // Schema
  'sales_reps'                 // Collection name in MongoDB
);

export default SalesRepresentative;
