const router  = require('express').Router();
const Product = require('../models/Product');
const { protect, shopkeeperOnly } = require('../middleware/auth');

router.get('/list', async (req, res) => {
  try {
    const { category, search, page = 1, limit = 20, shopkeeperId } = req.query;
    const q = { isActive: true };
    if (category)    q.category   = category;
    if (search)      q.name       = { $regex: search, $options: 'i' };
    if (shopkeeperId) q.shopkeeper = shopkeeperId;
    const products = await Product.find(q).populate('shopkeeper','name email').limit(limit*1).skip((page-1)*limit).sort({ createdAt: -1 });
    const count    = await Product.countDocuments(q);
    res.json({ products, totalPages: Math.ceil(count/limit), currentPage: page });
  } catch (e) { res.status(500).json({ message: e.message }); }
});

router.post('/add', protect, shopkeeperOnly, async (req, res) => {
  try { res.status(201).json(await Product.create({ ...req.body, shopkeeper: req.user._id })); }
  catch (e) { res.status(500).json({ message: e.message }); }
});

router.put('/update/:id', protect, shopkeeperOnly, async (req, res) => {
  try {
    const p = await Product.findOneAndUpdate({ _id: req.params.id, shopkeeper: req.user._id }, req.body, { new: true });
    if (!p) return res.status(404).json({ message: 'Not found' });
    res.json(p);
  } catch (e) { res.status(500).json({ message: e.message }); }
});

router.delete('/delete/:id', protect, shopkeeperOnly, async (req, res) => {
  try {
    const p = await Product.findOneAndDelete({ _id: req.params.id, shopkeeper: req.user._id });
    if (!p) return res.status(404).json({ message: 'Not found' });
    res.json({ message: 'Product deleted' });
  } catch (e) { res.status(500).json({ message: e.message }); }
});

module.exports = router;
