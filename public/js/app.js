(function() {
  var app;

  app = angular.module("PerformanceBenchmark", []);

  app.constant('settings', {
    socketChannelName: 'BenchmarkChannel',
    socketUrl: 'http://' + window.location.hostname + ':9999'
  });

  app.service("DataService", [
    'settings', '$q', '$timeout', function(sttgs, q, t) {
      var _channel, _data;
      _channel = null;
      _data = null;
      return {
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
    "$scope", "settings", "$timeout", function(scope, sttgs, to) {
      var _connectToSocket, _prepareData;
      scope.data = null;
      _prepareData = function(data) {
        var browser, dataCount, eIdx, edIdx, entry, entryData, timing, _i, _j, _len, _len1, _ref;
        for (eIdx = _i = 0, _len = data.length; _i < _len; eIdx = ++_i) {
          entry = data[eIdx];
          dataCount = entry.data.length;
          browser = 0;
          _ref = entry.data;
          for (edIdx = _j = 0, _len1 = _ref.length; _j < _len1; edIdx = ++_j) {
            entryData = _ref[edIdx];
            timing = entryData.timing;
            browser += timing.loadEventEnd - timing.navigationStart;
          }
          data[eIdx].average = {
            browser: browser / dataCount
          };
        }
        return to(function() {
          return scope.data = data;
        }, 0);
      };
      return (_connectToSocket = function() {
        var socket;
        socket = io.connect(sttgs.socketUrl);
        return socket.on('ShareDataEvent', function(data) {
          return _prepareData(data);
        });
      })();
    }
  ]);

  app.filter("sec", function() {
    return function(val) {
      var res;
      res = parseInt(val, 10) / 1000;
      res = 'Ø ' + res + ' sek';
      res = res.replace('.', ',');
      return res;
    };
  });

  app.directive("idDashboard", [
    function() {
      return {
        restrict: 'A',
        scope: true,
        templateUrl: '/partials/dashboard.tpl.html',
        link: function(scope, element, attrs) {}
      };
    }
  ]);

}).call(this);
