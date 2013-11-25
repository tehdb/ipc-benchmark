app = angular.module("PerformanceBenchmark", [])

app.constant('settings', {
	dataServiceUrl : 'http://ws204011:3000/timing'
	# socketChannelName : 'BenchmarkChannel'
	# socketUrl : 'http://' + window.location.hostname + ':9999'
})