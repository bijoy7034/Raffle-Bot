const express = require("express");
const { getAllGroup, createTaskGroup, editTaskGroup, createTaskList, getTaskList, deleteTaskGroup, addComments, getComments } = require("../controllers/taskController");
const taskRoute = express.Router();


taskRoute.get('/all',getAllGroup)
taskRoute.post('/createTask', createTaskGroup)
taskRoute.patch('/group/edit/:id', editTaskGroup)
taskRoute.delete('/delete/:id', deleteTaskGroup)

//list
taskRoute.get('/list/all',getTaskList)
taskRoute.post('/list/create/:id', createTaskList)

taskRoute.patch('/comment/add/:id', addComments)


module.exports = taskRoute