const pool = require('../config/db');

exports.getAllUsers = async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM \"User\"');
    res.status(200).json(result.rows);
  } catch (error) {
    console.error('Error fetching users:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

exports.setUser = async (req, res) => {
  const { name, lastname, email, phone_number, password } = req.body;

  if (!name || !lastname || !email || !phone_number || !password) {
    return res.status(400).json({ error: 'Name, email, and password are required' });
  }

  try {
    const result = await pool.query(
      'INSERT INTO \"User\" (name, lastname, email, phone_number, password) VALUES ($1, $2, $3, $4, $5) RETURNING *',
      [name, lastname, email, phone_number, password]
    );
    res.status(201).json(result.rows[0]);
  } catch (error) {
    console.error('Error creating user:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

exports.deleteUser = async (req, res) => {
  const userId = req.params.id;

  try {
    const result = await pool.query('DELETE FROM \"User\" WHERE id = $1 RETURNING *', [userId]);
    if (result.rowCount === 0) {
      return res.status(404).json({ error: 'User not found' });
    }
    res.status(200).json({ message: 'User deleted successfully', user: result.rows[0] });
  } catch (error) {
    console.error('Error deleting user:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

exports.login = async (req, res) => {
  const { email, password } = req.body;

  // Input validation
  if (!email || !password) {
    return res.status(400).json({ error: 'Email and password are required' });
  }

  try {
    // Query the database to find the user by email
    const result = await pool.query('SELECT * FROM \"User\" WHERE email = $1', [email]);

    if (result.rowCount === 0) {
      // If no user found with the provided email
      return res.status(401).json({ error: 'Invalid credentials' });
    }

    const user = result.rows[0];

    // Compare provided password with stored password
    if (user.password === password) {
      // If password matches
      res.status(200).json({ message: 'success'});
      console.log(email, password);
    } else {
      // If password does not match
      return (
        res.status(401).json({ error: 'Invalid credentials' }),
        console.log(email, password)
      );
      
    }
  } catch (error) {
    // Handle any other errors
    console.error('Error during login:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

