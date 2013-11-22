app.directive( "idDashboard", [ () ->
	restrict: 'A'
	scope : true
	templateUrl : '/partials/dashboard.tpl.html'
	link : (scope, element, attrs ) ->
		console.log("dashboard")
])