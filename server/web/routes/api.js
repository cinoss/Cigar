var express = require('express');
var router = express.Router();

var master = null;
router.setMaster = function(_master) {
	master = _master
};
var callCommand = function(args, cb) {
	var execute = master.commands[args[0]];
	console.log('got command: ',args);
	if (execute) {
	    execute(master, args);
	    cb('ok');
	} else {
	    console.log(master.getName() + " Invalid command!");
	    cb(master.getName() + " Invalid command!");
	}
}
/* GET home page. */
router.get('/add', function (req, res, next) {
	// console.log(req)
	var args = ['add',req.query.ip, req.query.port, req.query.region];
	callCommand(args, function(msg) {
		res.end(msg);
	});
});

module.exports = router;
