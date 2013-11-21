
exports.main = (db) ->
	return (req, res) ->
		db.get('data').find({}, {}, (e,docs) ->
			res.render( "index", {
				title: "ipc-benchmark",
				data : docs
				}
			)
		)


exports.timing = (db) ->
	(req, res) ->
		res.header('Access-Control-Allow-Origin', '*')
		res.header('Access-Control-Allow-Methods', 'PUT, GET, POST, DELETE, OPTIONS')
		res.header('Access-Control-Allow-Headers', 'Content-Type')

		res.format
			http : ->
				res.send("http req")
			json : ->
				db.get( 'data' ).insert( req.body ) #.close()
				res.send()


exports.opt = (req, res) ->
	res.header('Access-Control-Allow-Origin', '*')
	res.header('Access-Control-Allow-Methods', 'PUT, GET, POST, DELETE, OPTIONS')
	res.header('Access-Control-Allow-Headers', 'Content-Type')
	res.end()
