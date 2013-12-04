app = angular.module("PerformanceBenchmark", [])

app.constant('settings', {
	dataServiceUrl : "#{window.location.protocol}//#{window.location.hostname}:#{window.location.port}/timing"
	# socketChannelName : 'BenchmarkChannel'
	# socketUrl : 'http://' + window.location.hostname + ':9999'
})