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
  const { name, lastname, email, phone_number, password, security_question } = req.body;

  if (!name || !lastname || !email || !phone_number || !password || !security_question) {
    return res.status(400).json({ error: 'Name, email, and password are required' });
  }

  try {
    const result = await pool.query(
      'INSERT INTO \"User\" (name, lastname, email, phone_number, password, security_question) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *',
      [name, lastname, email, phone_number, password, security_question]
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
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

exports.login = async (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.status(400).json({ error: 'Email and password are required' });
  }

  try {
    const result = await pool.query('SELECT * FROM \"User\" WHERE email = $1', [email]);

    if (result.rowCount === 0) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }

    const user = result.rows[0];

    if (user.password === password) {
      res.status(200).json({ message: 'success', username: user.name });
    } else {
      return res.status(401).json({ error: 'Invalid credentials' });
    }
  } catch (error) {
    console.error('Error during login:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

exports.forgotPassword = async (req, res) => {
  const { email } = req.body;

  if (!email) {
    return res.status(400).json({ error: 'Email is required' });
  }

  try {
    const result = await pool.query('SELECT * FROM "User" WHERE email = $1', [email]);

    if (result.rowCount === 0) {
      return res.status(404).json({ error: 'Email not found' });
    }

    res.status(200).json({ message: 'Password reset instructions have been sent to your email' });
  } catch (error) {
    console.error('Error during forgot password process:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};


exports.verifyIdentity = async (req, res) => {
  const { email, phone_number, security_answer } = req.body;

  if (!email || !phone_number || !security_answer) {
    return res.status(400).json({ error: 'Email, phone number, and security answer are required' });
  }

  try {
    const result = await pool.query(
      'SELECT * FROM "User" WHERE email = $1 AND phone_number = $2 AND security_question = $3',
      [email, phone_number, security_answer]
    );

    if (result.rowCount === 0) {
      return res.status(404).json({ error: 'Identity verification failed' });
    }

    res.status(200).json({ message: 'Identity verification successful' });
  } catch (error) {
    console.error('Error during identity verification:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

exports.resetPassword = async (req, res) => {
  const { email, new_password } = req.body;

  if (!email || !new_password) {
    return res.status(400).json({ error: 'Email and new password are required' });
  }

  try {
    const result = await pool.query('UPDATE "User" SET password = $1 WHERE email = $2 RETURNING *', [new_password, email]);

    if (result.rowCount === 0) {
      return res.status(404).json({ error: 'User not found' });
    }

    res.status(200).json({ message: 'Password successfully updated', user: result.rows[0] });
  } catch (error) {
    console.error('Error updating password:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

exports.updateUser = async (req, res) => {
  const { name, lastname, email, phone_number } = req.body;

  if (!name || !lastname || !email || !phone_number) {
    return res.status(400).json({ error: 'All fields are required' });
  }

  try {
    const result = await pool.query(
      'UPDATE \"User\" SET name = $1, lastname = $2, email = $3, phone_number = $4 WHERE email = $3 RETURNING *',
      [name, lastname, email, phone_number]
    );

    if (result.rowCount === 0) {
      return res.status(404).json({ error: 'User not found' });
    }

    res.status(200).json({ message: 'User data updated successfully', user: result.rows[0] });
  } catch (error) {
    console.error('Error updating user:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

exports.getUser = async (req, res) => {
  const { email } = req.params;
  console.log(req.params);

  try {
    const result = await pool.query('SELECT * FROM \"User\" WHERE email = $1', [email]);

    if (result.rowCount === 0) {
      return res.status(404).json({ error: 'User not found' });
    }

    res.status(200).json(result.rows[0]);
  } catch (error) {
    console.error('Error fetching user:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};
