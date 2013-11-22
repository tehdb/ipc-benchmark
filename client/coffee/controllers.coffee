app.controller("MainController", ["$scope", "settings", "$timeout", (scope, sttgs, to ) ->

	scope.data = null


	_prepareData = (data) ->
		for entry, eIdx in data
			
			dataCount = entry.data.length
			
			browser = 0

			for entryData, edIdx in entry.data
				timing = entryData.timing
				browser += timing.loadEventEnd - timing.navigationStart

			data[eIdx].average = {
				browser : browser / dataCount

			}

		to(->
			scope.data = data
		,0)




	do _connectToSocket = ->
		socket = io.connect(  sttgs.socketUrl )
		socket.on('ShareDataEvent', (data)->
			_prepareData( data )
		)

])