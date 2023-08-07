const { default: mongoose } = require("mongoose");
const jwt = require("jsonwebtoken");
const taskGroupModel = require('../models/Tasks/taskModel')
const taskListModel = require('../models/Tasks/taskList');
const { json } = require("body-parser");

//taskGroup

const getAllGroup = async (req, res) => {
    try {
      const token = req.headers.authorization.split(" ")[1];
      if (!token) {
        return res.status(401).json({ mssg: "You are not authenticated" });
      }
  
      jwt.verify(token, "secret_key", async (err, user) => {
        if (err) return res.status(403).json({ mssg: "Token not valid" });
        req.user = user;
  
        const tasks = await taskGroupModel.find({ createdBy: req.user.id });
        if (!tasks) {
          return res.status(400).json({ mssg: "Error" });
        }
        res.status(200).json(tasks);
      });
    } catch (err) {
      res.status(400).json({ error: err.message });
    }
  };

  
  //create

  const createTaskGroup = async (req, res) => {
    try {
      const token = req.headers.authorization.split(" ")[1];
      if (!token) {
        return res.status(401).json({ mssg: "You are not authenticated" });
      }
  
      jwt.verify(token, "secret_key", async (err, user) => {
        if (err) return res.status(403).json({ mssg: "Token not valid" });
        req.user = user;
  
        const TaskName = req.body.TaskName;
        const createdBy = req.user.id;
  
        const email = await taskGroupModel.create({ TaskName, createdBy });
        if (!email) {
          return res.status(400).json({ mssg: "Creation failed" });
        }
        return res.status(200).json(email);
      });
    } catch (err) {a
      res.status(400).json({ error: err.message });
    }
  };

  //edit
  const editTaskGroup = async (req, res) => {
    try {
      const { id } = req.params;
      if (!mongoose.Types.ObjectId.isValid(id)) {
        return res.status(400).json({ error: "No such workout" });
      }
      const tasks = await taskGroupModel.findOneAndUpdate(
        { _id: id },
        { ...req.body }
      );
      if (!tasks) return res.status(400).json({ mssg: "Not Updated" });
      return res.status(200).json(tasks);
    } catch (err) {
      return res.status(400).json({ error: err.message });
    }
  };

  //delete
  const deleteTaskGroup = async (req, res) => {
    try {
      const { id } = req.params;
      if (!mongoose.Types.ObjectId.isValid(id)) {
        return res.status(404).json({ mssg: "No record found" });
      }
      const email = await taskGroupModel.findOneAndDelete({ _id: id });
      if (!email) {
        return res.status(400).json("not deleted");
      }
  
      const emailGroup = await taskListModel.deleteMany({
        _id: { $in: email.TaskList },
      });
      if (!emailGroup) {
        return res.status(400).json("not deleted");
      }
      const combinedData = {
        mssg: "Deleted",
        email_List: email,
        email_Group: emailGroup,
        id: email.EmailGroup,
      };
      return res.status(200).json(combinedData);
    } catch (err) {
      return res.status(400).json({ error: err.message });
    }
  };


//lists
const createTaskList = async (req, res) => {
    try {
      const token = req.headers.authorization.split(" ")[1];
      if (!token) {
        return res.status(401).json({ mssg: "You are not authenticated" });
      }
  
      jwt.verify(token, "secret_key", async (err, user) => {
        if (err) return res.status(403).json({ mssg: "Token not valid" });
        req.user = user;
  
        const { id } = req.params;
        const ListName = req.body.ListName;
        const createdBy = req.user.id;
        const TaskGroup = id;
        const EmailList = req.body.EmailList
        const ProxyList = req.body.ProxyList
        const EmailListName = req.body.EmailListName
        const ProxyListName = req.body.ProxyListName
        // const AddressList = req.body.AddressList
  
        const email = await taskListModel.create({
          ListName,
          TaskGroup,
          EmailList,
          EmailListName,
          ProxyList,
          ProxyListName,
          createdBy,
        });
        if (!email) {
          return res.status(400).json({ mssg: "No created" });
        }
        if (!mongoose.Types.ObjectId.isValid(id)) {
          res.status(404).json({ mssg: "No record found" });
        }
        const emailGroup = await taskGroupModel.findOneAndUpdate(
          { _id: id },
          { $push: { TaskList: email._id } }
        );
        if (!emailGroup) {
          return res.status(400).json({ mssg: "No created" });
        }
        const combinedData = {
          Task_List: email,
          Task_Group: emailGroup,
        };
        return res.status(200).json(combinedData);
      });
    } catch (err) {
      res.status(400).json({ error: err.message });
    }
}
const addComments = async(req, res)=>{
  try{
    const { id }= req.params
    if (!mongoose.Types.ObjectId.isValid(id)) {
      return res.status(400).json({ message: 'Invalid taskId' });
    }
    const comment = req.body.comment
    const updatedTaskGroup = await taskGroupModel.findOneAndUpdate(
      { _id: id },
      { $push: { Comments: comment } },
      { new: true }
    );

    if (!updatedTaskGroup) {
      return res.status(404).json({ message: 'TaskGroup not found' });
    }

    return res.status(200).json(updatedTaskGroup);
  }
  catch(err){
    res.status(400).json({ error: err.message });
  }
}

const getComments = async (req, res) => {
  try {
    const { taskId } = req.params; // Assuming taskId is the ID of the TaskGroup

    const taskGroup = await taskGroupModel.findById(taskId);
    if (!taskGroup) {
      return res.status(404).json({ message: 'TaskGroup not found' });
    }

    // Extract the comments from the taskGroup object
    const { Comments } = taskGroup;

    return res.status(200).json({ Comments });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};



const getTaskList = async(req,res)=>{
  try {
    const token = req.headers.authorization.split(" ")[1];
    if (!token) {
      return res.status(401).json({ mssg: "You are not authenticated" });
    }

    jwt.verify(token, "secret_key", async (err, user) => {
      if (err) return res.status(403).json({ mssg: "Token not valid" });
      req.user = user;

      const tasks = await taskListModel.find({ createdBy: req.user.id });
      if (!tasks) {
        return res.status(400).json({ mssg: "Error" });
      }
      const combinedData = {
        email_List: tasks,
      };
      res.status(200).json(combinedData);
    });
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
}


  module.exports = {
    getAllGroup,
    createTaskGroup,
    editTaskGroup,
    deleteTaskGroup,
    createTaskList,
    getTaskList,
    addComments,
    getComments

  }