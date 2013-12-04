
app.service( "DataService", ['settings', '$q', '$http', '$log', '$timeout' , (sttgs, q, h, l, t) ->
	_channel = null
	_data = null


	_prepareData = (data) ->
		for entry, eIdx in data		
			dataCount = entry.data.length
			browser = 0
			entry.url = 'http://' + entry.url

			for entryData, edIdx in entry.data
				timing = entryData.timing

				if timing.loadEventEnd > 0
					browser += timing.loadEventEnd - timing.navigationStart
				else 
					dataCount--

			data[eIdx].average = {
				browser : browser / dataCount
			}

		return data

	return {
		getData : () ->
			defer = q.defer()
			h(
				method : 'GET'
				url : sttgs.dataServiceUrl
			).success((data, status, headers, config) ->
				defer.resolve( _prepareData(data) )
			).error((data, status, headers, config ) ->
				l.warn( "HTTP-GET-Error: ", data, status, headers, config )
				defer.reject(false)

			)
			return defer.promise
	}

# getData : () -> 
# 	defer = q.defer()
# 	if _channel?
# 		_channel.getData().then((data)->
# 			_data = data

# 			console.log data 
			
# 			defer.resolve( _data )
# 		)
# 	else
# 		defer.reject('channel not established')
# 	return defer.promise
])

