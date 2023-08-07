const { default: mongoose } = require("mongoose");
const emailListModal = require("../models/Email/emailListModal");
const emailGroupModel = require("../models/Email/emailModal");
const jwt = require("jsonwebtoken");

//Email Gorup
const getAllGroup = async (req, res) => {
  try {
    const token = req.headers.authorization.split(" ")[1];
    if (!token) {
      return res.status(401).json({ mssg: "You are not authenticated" });
    }

    jwt.verify(token, "secret_key", async (err, user) => {
      if (err) return res.status(403).json({ mssg: "Token not valid" });
      req.user = user;

      const emailList = await emailGroupModel.find({ createdBy: req.user.id });
      if (!emailList) {
        return res.status(400).json({ mssg: "Error" });
      }
      res.status(200).json(emailList);
    });
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

const editEmailGroup = async (req, res) => {
  try {
    const { id } = req.params;
    if (!mongoose.Types.ObjectId.isValid(id)) {
      return res.status(400).json({ error: "No such workout" });
    }
    const emailList = await emailGroupModel.findOneAndUpdate(
      { _id: id },
      { ...req.body }
    );
    if (!emailList) return res.status(400).json({ mssg: "Not Updated" });
    return res.status(200).json(emailList);
  } catch (err) {
    return res.status(400).json({ error: err.message });
  }
};

const createEmailGroup = async (req, res) => {
  try {
    const token = req.headers.authorization.split(" ")[1];
    if (!token) {
      return res.status(401).json({ mssg: "You are not authenticated" });
    }

    jwt.verify(token, "secret_key", async (err, user) => {
      if (err) return res.status(403).json({ mssg: "Token not valid" });
      req.user = user;

      const GroupName = req.body.GroupName;
      const createdBy = req.user.id;

      const email = await emailGroupModel.create({ GroupName, createdBy });
      if (!email) {
        return res.status(400).json({ mssg: "Creation failed" });
      }
      return res.status(200).json(email);
    });
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

const deleteEmailGroup = async (req, res) => {
  try {
    const { id } = req.params;
    if (!mongoose.Types.ObjectId.isValid(id)) {
      return res.status(404).json({ mssg: "No record found" });
    }
    const email = await emailGroupModel.findOneAndDelete({ _id: id });
    if (!email) {
      return res.status(400).json("not deleted");
    }

    const emailGroup = await emailListModal.deleteMany({
      _id: { $in: email.EmailLists },
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

//emailList

const createEmailList = async (req, res) => {
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
      const Emails = req.body.Emails;
      const EmailGroup = id;

      const email = await emailListModal.create({
        ListName,
        Emails,
        EmailGroup,
        createdBy,
      });
      if (!email) {
        return res.status(400).json({ mssg: "No created" });
      }
      if (!mongoose.Types.ObjectId.isValid(id)) {
        res.status(404).json({ mssg: "No record found" });
      }
      const emailGroup = await emailGroupModel.findOneAndUpdate(
        { _id: id },
        { $push: { EmailLists: email._id } }
      );
      if (!emailGroup) {
        return res.status(400).json({ mssg: "No created" });
      }
      const combinedData = {
        email_List: email,
        email_Group: emailGroup,
      };
      return res.status(200).json(combinedData);
    });
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

const deleteEmailList = async (req, res) => {
  try {
    const { id } = req.params;
    if (!mongoose.Types.ObjectId.isValid(id)) {
      return res.status(404).json({ mssg: "No record found" });
    }
    const email = await emailListModal.findOneAndDelete({ _id: id });
    if (!email) {
      return res.status(400).json("not deleted");
    }

    const emailGroup = await emailGroupModel.findOneAndUpdate(
      { _id: email.EmailGroup },
      { $pull: { EmailLists: email._id } },
      { new: true }
    );
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

const editEmailList = async (req, res) => {
  try {
    const { id } = req.params;
    if (!mongoose.Types.ObjectId.isValid(id)) {
      return res.status(400).json({ error: "No such workout" });
    }
    const emailList = await emailListModal.findOneAndUpdate(
      { _id: id },
      { ...req.body }
    );
    if (!emailList) return res.status(400).json({ mssg: "Not Updated" });
    return res.status(200).json(emailList);
  } catch (err) {
    return res.status(400).json({ error: err.message });
  }
};

const getAllList = async (req, res) => {
  try {
    const { id } = req.params;
    const emailList = await emailListModal.find({});
    if (!emailList) {
      return res.status(400).json({ mssg: "Error" });
    }
    const combinedData = {
      email_List: emailList,
    };

    res.status(200).json(combinedData);
  } catch (err) {
    return res.status(400).json({ error: err.message });
  }
};

module.exports = {
  createEmailGroup,
  createEmailList,
  deleteEmailList,
  getAllList,
  getAllGroup,
  deleteEmailGroup,
  editEmailList,
  editEmailGroup,
};
