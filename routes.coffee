db = require('./db')

exports.main = (req, res) ->
	res.render "index",
		title: "ipc-benchmark"
		data : db.getData()

exports.timing = (req, res) ->
	res.header('Access-Control-Allow-Origin', '*')
	res.header('Access-Control-Allow-Methods', 'PUT, GET, POST, DELETE, OPTIONS')
	res.header('Access-Control-Allow-Headers', 'Content-Type')

	res.format
		http : ->
			res.send("http req")
		json : ->
			db.putData( req.body )
			res.send("")

exports.opt = (req, res) ->
	res.header('Access-Control-Allow-Origin', '*')
	res.header('Access-Control-Allow-Methods', 'PUT, GET, POST, DELETE, OPTIONS')
	res.header('Access-Control-Allow-Headers', 'Content-Type')
	res.end()