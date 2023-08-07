const { default: mongoose } = require("mongoose");

const proxyGroupModel = new mongoose.Schema(
  {
    GroupName: {
      type: String,
      required: true,
      unique: true,
    },
    ProxyLists: {
      type: [mongoose.Schema.Types.ObjectId],
      ref: "ProxyList",
      required: false,
    },
    createdBy: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Users",
      required: true,
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("ProxyGroup", proxyGroupModel);
