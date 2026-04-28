const jwt = require('jsonwebtoken');
const User = require('../models/User');

const protect = async (req, res, next) => {
  let token;
  if (req.headers.authorization?.startsWith('Bearer')) {
    try {
      token = req.headers.authorization.split(' ')[1];
      const decoded = jwt.verify(token, process.env.JWT_SECRET);
      req.user = await User.findById(decoded.id).select('-password');
      if (!req.user) return res.status(401).json({ message: 'User not found' });
      return next();
    } catch { return res.status(401).json({ message: 'Invalid token' }); }
  }
  if (!token) return res.status(401).json({ message: 'No token' });
};

const shopkeeperOnly = (req, res, next) =>
  req.user?.role === 'shopkeeper' ? next() : res.status(403).json({ message: 'Shopkeeper only' });

const customerOnly = (req, res, next) =>
  req.user?.role === 'customer' ? next() : res.status(403).json({ message: 'Customer only' });

module.exports = { protect, shopkeeperOnly, customerOnly };
