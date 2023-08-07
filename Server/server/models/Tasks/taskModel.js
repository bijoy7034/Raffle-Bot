const { default: mongoose } = require("mongoose");

const taskGroupModel = new mongoose.Schema({
    TaskName : {
        type: String,
        required:true,
        unique : true
    },
    TaskList:{
        type:[mongoose.Schema.Types.ObjectId],
        ref:'TaskList',
        required:false
    },
    Comments: {
        type: String,
        default: ' ',
        required: false
    },
    site : {
        type: String,
        required: true,
        default: " "
    },
    Running : {
        type: Number,
        default: 0,
        required: false

    },
    Successful : {
        type: Number,
        default: 0,
        required: false

    },
    Failed : {
        type: Number,
        default: 0,
        required: false

    },
    createdBy: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Users',
        required: true
      },
    
})
module.exports = mongoose.model('TaskGroup', taskGroupModel)