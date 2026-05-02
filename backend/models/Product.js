const mongoose = require('mongoose');
const productSchema = new mongoose.Schema({
  shopkeeper: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  name:        { type: String, required: true, trim: true },
  description: { type: String, default: '' },
  sku:         { type: String, unique: true, sparse: true },
  category:    { type: String, required: true },
  price:       { type: Number, required: true, min: 0 },
  stock:       { type: Number, required: true, min: 0, default: 0 },
  lowStockThreshold: { type: Number, default: 10 },
  images:  [{ type: String }],
  unit:    { type: String, default: 'piece' },
  isActive:{ type: Boolean, default: true },
  tags:    [{ type: String }],
}, { timestamps: true });
productSchema.virtual('stockStatus').get(function() {
  if (this.stock === 0) return 'out';
  return this.stock <= this.lowStockThreshold ? 'low' : 'high';
});
productSchema.set('toJSON', { virtuals: true });
module.exports = mongoose.model('Product', productSchema);
