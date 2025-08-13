import mongoose from 'mongoose';

const salesRepresentativeSchema = new mongoose.Schema({
  username: { type: String, required: true },
  password: { type: String, required: true }
});

// Explicitly set the collection name to 'sales_reps'
const SalesRepresentative = mongoose.model('SalesRepresentative', salesRepresentativeSchema, 'sales_reps');

export default SalesRepresentative;
