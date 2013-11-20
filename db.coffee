db = []

exports.getData = ->
	return db

exports.putData = (data) ->
	console.log "db", data 
	db.push( data )
