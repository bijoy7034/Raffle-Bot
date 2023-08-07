const { default: mongoose } = require("mongoose");

const emailListModel = new mongoose.Schema({
    ListName: {
        type: String,
        required: true,
        unique : true
    },
    Emails : {
        type: [String],
        required: true,
    },
    EmailGroup : {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'EmailGroup',
        required : true
    },
    createdBy: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Users',
    required: false
  },

},{timestamps: true})

module.exports = mongoose.model('EmailLists', emailListModel)