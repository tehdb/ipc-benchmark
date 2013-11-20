module.exports.main = (req, res) ->
	res.send("main")

module.exports.timing = (req, res) ->
	res.format
		http : ->
			res.send("404 error")
		json : ->
			res.json( db.getAlbum(req.params.id) )

