
app.service( "DataService", ['settings', '$q', '$timeout' , (sttgs, q, t) ->
	_channel = null
	_data = null


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

