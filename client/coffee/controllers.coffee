app.controller("MainController", ["$scope", "DataService" ,"settings", (scope, ds, sttgs) ->

	scope.data = null

	ds.connect().then( ->
		ds.getData().then( (data)->
			scope.data = data
		)
	)
])