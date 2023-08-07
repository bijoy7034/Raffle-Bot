const { default: mongoose } = require("mongoose");
const proxyGroupModel = require("../models/Proxies/proxyGroup");
const proxyListsModel = require("../models/Proxies/proxyListModal");
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

      const emailList = await proxyGroupModel.find({ createdBy: req.user.id });
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
    const emailList = await proxyGroupModel.findOneAndUpdate(
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

      const email = await proxyGroupModel.create({ GroupName, createdBy });
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
    const email = await proxyGroupModel.findOneAndDelete({ _id: id });
    if (!email) {
      return res.status(400).json("not deleted");
    }

    const emailGroup = await proxyListsModel.deleteMany({
      _id: { $in: email.ProxyLists },
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
      const Proxies = req.body.Proxies;
      const ProxyGroup = id;

      const email = await proxyListsModel.create({
        ListName,
        Proxies,
        ProxyGroup,
        createdBy,
      });
      if (!email) {
        return res.status(400).json({ mssg: "No created" });
      }
      if (!mongoose.Types.ObjectId.isValid(id)) {
        res.status(404).json({ mssg: "No record found" });
      }
      const emailGroup = await proxyGroupModel.findOneAndUpdate(
        { _id: id },
        { $push: { ProxyLists: email._id } }
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
    const email = await proxyListsModel.findOneAndDelete({ _id: id });
    if (!email) {
      return res.status(400).json("not deleted");
    }

    const emailGroup = await proxyGroupModel.findOneAndUpdate(
      { _id: email.ProxyGroup },
      { $pull: { ProxyLists: email._id } },
      { new: true }
    );
    if (!emailGroup) {
      return res.status(400).json("not deleted");
    }
    const combinedData = {
      mssg: "Deleted",
      email_List: email,
      email_Group: emailGroup,
      id: email.ProxyGroup,
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
    const emailList = await proxyListsModel.findOneAndUpdate(
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
    const emailList = await proxyListsModel.find({});
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
