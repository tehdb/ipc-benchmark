(function() {
  var app;

  app = angular.module("PerformanceBenchmark", []);

  app.constant('settings', {
    dataServiceUrl: "" + window.location.protocol + "//" + window.location.hostname + ":" + window.location.port + "/timing"
  });

  app.service("DataService", [
    'settings', '$q', '$http', '$log', '$timeout', function(sttgs, q, h, l, t) {
      var _channel, _data, _prepareData;
      _channel = null;
      _data = null;
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
            if (timing.loadEventEnd > 0) {
              browser += timing.loadEventEnd - timing.navigationStart;
            } else {
              dataCount--;
            }
          }
          data[eIdx].average = {
            browser: browser / dataCount
          };
        }
        return data;
      };
      return {
        getData: function() {
          var defer;
          defer = q.defer();
          h({
            method: 'GET',
            url: sttgs.dataServiceUrl
          }).success(function(data, status, headers, config) {
            return defer.resolve(_prepareData(data));
          }).error(function(data, status, headers, config) {
            l.warn("HTTP-GET-Error: ", data, status, headers, config);
            return defer.reject(false);
          });
          return defer.promise;
        }
      };
    }
  ]);

  app.controller("MainController", [
    "$scope", "settings", "$timeout", "DataService", function(scope, sttgs, to, ds) {
      var refreshData;
      scope.data = null;
      scope.sortTerm = "default";
      scope.sortRev = true;
      scope.searchText = '';
      scope.sortBy = function(val) {
        if (scope.sortTerm === 'default') {
          scope.sortRev = false;
        }
        if (scope.sortTerm === val) {
          return scope.sortRev = !scope.sortRev;
        } else {
          scope.sortRev = false;
          return scope.sortTerm = val;
        }
      };
      return (refreshData = function() {
        return ds.getData().then(function(data) {
          return scope.data = data;
        });
      })();
    }
  ]);

  app.filter("sec", function() {
    return function(val) {
      var res;
      res = parseInt(val, 10) / 1000;
      res = 'Ø ' + res + ' sec';
      res = res.replace('.', ',');
      return res;
    };
  });

  app.filter("sortlbl", function() {
    return function(val) {
      var res;
      res = '';
      switch (val) {
        case 'default':
          res = 'unsorted ';
          break;
        case 'title':
          res = 'sort by title ';
          break;
        case 'average.browser':
          res = 'sort by load time ';
      }
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
