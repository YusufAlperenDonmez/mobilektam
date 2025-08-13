import mongoose from "mongoose";

const productSchema = new mongoose.Schema({
  description: { type: String, required: true },
  product: { type: String },
  code: { type: String },
  price: { type: Number },
  physicalQuantity: { type: Number },
  actualQuantity: { type: Number }
});

const Product = mongoose.model("Product", productSchema);

export default Product;
