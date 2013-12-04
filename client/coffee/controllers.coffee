app.controller("MainController", ["$scope", "settings", "$timeout", "DataService", (scope, sttgs, to, ds ) ->
	scope.data = null
	scope.sortTerm = "default"
	scope.sortRev = true
	scope.searchText = ''

	scope.sortBy = ( val ) ->
		scope.sortRev = false if scope.sortTerm is 'default'


		if scope.sortTerm is val
			scope.sortRev = not scope.sortRev
		else
			scope.sortRev = false
			scope.sortTerm = val

	do refreshData = () ->
		ds.getData().then( (data) ->
			scope.data = data
		)

	# _prepareData = (data) ->
	# 	for entry, eIdx in data
			
	# 		dataCount = entry.data.length
			
	# 		browser = 0

	# 		for entryData, edIdx in entry.data
	# 			timing = entryData.timing
	# 			browser += timing.loadEventEnd - timing.navigationStart

	# 		data[eIdx].average = {
	# 			browser : browser / dataCount

	# 		}

	# 	to(->
	# 		scope.data = data
	# 		console.log data
	# 	,0)




	# do _connectToSocket = ->
	# 	socket = io.connect(  sttgs.socketUrl )
	# 	socket.on('ShareDataEvent', (data)->
	# 		_prepareData( data )
	# 	)

]) 