const express = require('express');
const router = express.Router();
const userController = require('../controllers/userControllers');

router.get('/users', userController.getAllUsers);
router.post('/user/set', userController.setUser);
router.delete('/user/delete/:id', userController.deleteUser);

module.exports = router;