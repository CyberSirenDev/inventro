const router = require('express').Router();
const jwt    = require('jsonwebtoken');
const User   = require('../models/User');
const { protect } = require('../middleware/auth');

const mkToken = id => jwt.sign({ id }, process.env.JWT_SECRET, { expiresIn: '30d' });

router.post('/register', async (req, res) => {
  try {
    const { name, email, password, role } = req.body;
    if (await User.findOne({ email })) return res.status(400).json({ message: 'User already exists' });
    const user = await User.create({ name, email, password, role });
    res.status(201).json({ _id: user._id, name: user.name, email: user.email, role: user.role, token: mkToken(user._id) });
  } catch (e) { res.status(500).json({ message: e.message }); }
});

router.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ email });
    if (user && await user.matchPassword(password))
      return res.json({ _id: user._id, name: user.name, email: user.email, role: user.role, token: mkToken(user._id) });
    res.status(401).json({ message: 'Invalid credentials' });
  } catch (e) { res.status(500).json({ message: e.message }); }
});

router.get('/profile', protect, (req, res) => res.json(req.user));

router.put('/profile', protect, async (req, res) => {
  try {
    const user = await User.findById(req.user._id);
    user.name  = req.body.name  || user.name;
    user.phone = req.body.phone || user.phone;
    if (req.body.password) user.password = req.body.password;
    const u = await user.save();
    res.json({ _id: u._id, name: u.name, email: u.email, role: u.role, token: mkToken(u._id) });
  } catch (e) { res.status(500).json({ message: e.message }); }
});

module.exports = router;
