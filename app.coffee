express = require("express")
routes = require("./routes")
http = require("http")
path = require("path")
mongo = require('mongodb')
monk = require('monk')
db = monk('localhost:27017/ipc-benchmark')
app = express()


app
	.set( "port", 3000 )
	.set( "views", __dirname + "/views" )
	.set( "view engine", "jade" )
	.use( express.logger("dev") )
	.use( express.bodyParser() )
	.use( express.methodOverride() )
	.use( app.router )
	.use( express.errorHandler({dumpExceptions: true, showStack: true}) )

	.get( "/", routes.main(db) )
	.options("/timing", routes.opt )
	.put( "/timing", routes.timing(db) )

http.createServer(app).listen app.get("port"), ->
	console.log "Express server listening on port " + app.get("port")