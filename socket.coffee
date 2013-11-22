mongo = require('mongodb')
monk = require('monk')
db = monk('localhost:27017/ipc-benchmark')
MongoWatch = require('mongo-watch')

io = require('socket.io').listen(9999)

io.sockets.on('connection', (socket)->
	db.get('data').find({}, (e,d) ->
		socket.emit('ShareDataEvent', d)
	)
)

watcher = new MongoWatch({
	format : 'normal'
	db : 'ipc-benchmark'
})

watcher.debug = console.log
# watcher.watch 'ipc-benchmark.data', (event) ->

# 	db.get('data').find({}, (e,d) ->
# 		socket.emit('ShareDataEvent', d)
# 	)
