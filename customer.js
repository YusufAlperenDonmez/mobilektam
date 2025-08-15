import mongoose from "mongoose";

const customerSchema = new mongoose.Schema({
  companyName: { type: String, required: true },
  customerCode: { type: String, required: true },
  b: { type: Number },
  a: { type: Number },
  bk: { type: Number },
  email: { type: String },
  phone: { type: String }
});

const Customer = mongoose.model("Customer", customerSchema, "customers");

export default Customer;
