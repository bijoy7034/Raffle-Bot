const express = require("express");
const { login, create, logout } = require("../controllers/usersController");

const userRouter = express.Router();

userRouter.post("/login", login);
userRouter.post("/create", create);
userRouter.post("/logout", logout);

module.exports = userRouter;
