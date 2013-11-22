
exports.main = (db) ->
	return (req, res) ->
		db.get('data').find({}, (e,d) ->
			res.render( "index", {
				title: "ipc-benchmark",
				data : d
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
				rb = req.body
				
				db.get('data').findOne({ url : rb.reqUrl }, (e, d)->
					urlEntry = null

					if not d
						urlEntry = {
							url : rb.reqUrl
							title : rb.title
							data : [] 	
						}

					else
						urlEntry = d

					urlEntry.data.push({
						timing : rb.timing
						memory : rb.memory
						reqTime : rb.reqTime
						userAgent : rb.userAgent
					})


					if not d
						db.get('data').insert( urlEntry )
					else
						db.get('data').update( {}, urlEntry )

					
					res.send()
				)


exports.opt = (req, res) ->
	res.header('Access-Control-Allow-Origin', '*')
	res.header('Access-Control-Allow-Methods', 'PUT, GET, POST, DELETE, OPTIONS')
	res.header('Access-Control-Allow-Headers', 'Content-Type')
	res.end()
