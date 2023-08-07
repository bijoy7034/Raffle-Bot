const { default: mongoose } = require("mongoose");

const emailGroupModel = new mongoose.Schema({
    GroupName: {
        type: String,
        required: true,
        unique : true
    },
    EmailLists : {
        type: [mongoose.Schema.Types.ObjectId],
        ref: 'EmailList',
        required: false,
    },
    createdBy: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Users',
    required: true
  },

},{timestamps: true})

module.exports = mongoose.model('EmailGroup', emailGroupModel)