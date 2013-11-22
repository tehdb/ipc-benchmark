app = angular.module("PerformanceBenchmark", [])

app.constant('settings', {
	socketChannelName : 'BenchmarkChannel'
	socketUrl : 'http://' + window.location.hostname + ':9999'
})