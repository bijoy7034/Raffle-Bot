const { default: mongoose } = require("mongoose");

const proxyListsModel = new mongoose.Schema(
  {
    ListName: {
      type: String,
      required: true,
      unique: true,
    },
    Proxies: {
      type: [String],
      required: true,
    },
    ProxyGroup: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "ProxyGroup",
      required: true,
    },
    createdBy: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Users",
      required: false,
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("proxyList", proxyListsModel);
