const mongoose = require('mongoose');
const orderSchema = new mongoose.Schema({
  orderId:   { type: String, unique: true },
  customer:  { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  shopkeeper:{ type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  items: [{
    product:  { type: mongoose.Schema.Types.ObjectId, ref: 'Product' },
    name:     String,
    quantity: Number,
    price:    Number,
  }],
  subtotal:    { type: Number, required: true },
  tax:         { type: Number, default: 0 },
  deliveryFee: { type: Number, default: 0 },
  total:       { type: Number, required: true },
  status:      { type: String, enum: ['pending','accepted','packed','transit','delivered','rejected'], default: 'pending' },
  deliveryType:{ type: String, enum: ['delivery','pickup'], default: 'delivery' },
  deliveryAddress: { type: String, default: '' },
  paymentMethod:   { type: String, default: 'cod' },
  paymentStatus:   { type: String, enum: ['pending','paid','failed'], default: 'pending' },
}, { timestamps: true });
orderSchema.pre('save', function(next) {
  if (!this.orderId) this.orderId = 'INV-' + Math.floor(1000 + Math.random() * 9000);
  next();
});
module.exports = mongoose.model('Order', orderSchema);
