express = require("express")
routes = require("./routes")
http = require("http")
path = require("path")
mongo = require('mongodb')
monk = require('monk')
db = monk('localhost:27017/ipc-benchmark')
#io = require('socket.io').listen(9999)
app = express()

app
	.set( "port", 3000 )
	.set( "views", __dirname + "/views" )
	.set( "view engine", "jade" )
	.use( express.logger("dev") )
	.use( express.bodyParser() )
	.use( express.methodOverride() )
	.use( app.router )
	.use( express.static(path.join(__dirname, "public")) )
	.use( express.errorHandler({dumpExceptions: true, showStack: true}) )
	.get( "/", routes.main(db) )
	.options("/timing", routes.opt )
	.put( "/timing", routes.timing(db) )

http.createServer(app).listen app.get("port"), ->
	console.log "Express server listening on port " + app.get("port")





###


_when = require('when')
rpc = require('socket.io-rpc')

rpc.createServer(io, app)

rpc.expose('BenchmarkChannel', {
	getData : ->
		deffered = _when.defer()
		db.get('data').find({}, {}, (e,docs) ->
			deffered.resolve( docs )
		)
		return deffered.promise
})
###

# io.sockets.on('connection', function (socket) {
#     rpc.loadClientChannel(socket,'ClientChannel').then(function (fns) {
        
#         setTimeout(function(){
#                 fns.fnOnClient("calling client ").then(function (ret) {
#                     console.log("client returned: " + ret);
#                 });
#         }, 4000);

#     });
# }); 