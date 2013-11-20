express = require("express")
routes = require("./routes")
http = require("http")
path = require("path")
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

	.get( "/", routes.main )
	.options("/timing", routes.opt )
	.put( "/timing", routes.timing )

http.createServer(app).listen app.get("port"), ->
	console.log "Express server listening on port " + app.get("port")