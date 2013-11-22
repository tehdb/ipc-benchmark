
app.service( "DataService", ['$q', 'settings', (q, sttgs) ->
	_channel = null
	_data = null

	# connect to socket
	connect : ()->
		defer = q.defer()
		RPC.connect( sttgs.socketUrl )
		RPC.loadChannel(sttgs.socketChannelName).then( (channel) ->
			_channel = channel
			defer.resolve( true )
		)
		return defer.promise


	getData : () -> 
		defer = q.defer()
		if _channel?
			_channel.getData().then((data)->
				_data = data

				console.log data 
				
				defer.resolve( _data )
			)
		else
			defer.reject('channel not established')
		return defer.promise
])

