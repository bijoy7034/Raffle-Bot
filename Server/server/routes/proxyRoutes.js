const express = require("express");
const { getAllGroup, createEmailGroup, editEmailGroup, deleteEmailList, getAllList, createEmailList, deleteEmailGroup, editEmailList } = require("../controllers/proxyController");

const proxyRoutes = express.Router();


proxyRoutes.get("/all", getAllGroup)
proxyRoutes.post("/createGroup", createEmailGroup)
proxyRoutes.patch("/edit/Group/:id", editEmailGroup)
proxyRoutes.delete("/deleteList/:id", deleteEmailList)


proxyRoutes.get('/list/all', getAllList)
proxyRoutes.post('/createList/:id', createEmailList)
proxyRoutes.delete('/delete/list/:id', deleteEmailGroup)
proxyRoutes.patch("/list/update/:id", editEmailList)

module.exports = proxyRoutes;
