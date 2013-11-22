(function() {
  var app;

  app = angular.module("PerformanceBenchmark", []);

  app.constant('settings', {
    socketChannelName: 'BenchmarkChannel',
    socketUrl: 'http://' + window.location.hostname + ':9999'
  });

  app.service("DataService", [
    '$q', 'settings', function(q, sttgs) {
      var _channel, _data;
      _channel = null;
      _data = null;
      return {
        connect: function() {
          var defer;
          defer = q.defer();
          RPC.connect(sttgs.socketUrl);
          RPC.loadChannel(sttgs.socketChannelName).then(function(channel) {
            _channel = channel;
            return defer.resolve(true);
          });
          return defer.promise;
        },
        getData: function() {
          var defer;
          defer = q.defer();
          if (_channel != null) {
            _channel.getData().then(function(data) {
              _data = data;
              console.log(data);
              return defer.resolve(_data);
            });
          } else {
            defer.reject('channel not established');
          }
          return defer.promise;
        }
      };
    }
  ]);

  app.controller("MainController", [
    "$scope", "DataService", "settings", function(scope, ds, sttgs) {
      scope.data = null;
      return ds.connect().then(function() {
        return ds.getData().then(function(data) {
          return scope.data = data;
        });
      });
    }
  ]);

  app.directive("idDashboard", [
    function() {
      return {
        restrict: 'A',
        scope: true,
        templateUrl: '/partials/dashboard.tpl.html',
        link: function(scope, element, attrs) {
          return console.log("dashboard");
        }
      };
    }
  ]);

}).call(this);
