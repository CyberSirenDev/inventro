const router = require('express').Router();
const Order  = require('../models/Order');
const { protect, shopkeeperOnly, customerOnly } = require('../middleware/auth');

router.post('/create', protect, customerOnly, async (req, res) => {
  try { res.status(201).json(await Order.create({ ...req.body, customer: req.user._id })); }
  catch (e) { res.status(500).json({ message: e.message }); }
});

router.get('/history', protect, async (req, res) => {
  try {
    const q = req.user.role === 'customer' ? { customer: req.user._id } : { shopkeeper: req.user._id };
    const orders = await Order.find(q).populate('customer','name email').sort({ createdAt: -1 });
    res.json(orders);
  } catch (e) { res.status(500).json({ message: e.message }); }
});

router.put('/:id/status', protect, shopkeeperOnly, async (req, res) => {
  try {
    const o = await Order.findOneAndUpdate({ _id: req.params.id, shopkeeper: req.user._id }, { status: req.body.status }, { new: true });
    if (!o) return res.status(404).json({ message: 'Not found' });
    res.json(o);
  } catch (e) { res.status(500).json({ message: e.message }); }
});

module.exports = router;
