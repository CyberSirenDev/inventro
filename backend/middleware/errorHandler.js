module.exports = (err, req, res, next) => {
  let status = res.statusCode === 200 ? 500 : res.statusCode;
  let message = err.message;
  if (err.name === 'CastError') { status = 404; message = 'Resource not found'; }
  if (err.code === 11000)       { status = 400; message = 'Duplicate value'; }
  if (err.name === 'ValidationError') { status = 400; message = Object.values(err.errors).map(e => e.message).join(', '); }
  res.status(status).json({ message, stack: process.env.NODE_ENV === 'production' ? undefined : err.stack });
};
