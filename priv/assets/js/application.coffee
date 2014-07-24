define ['angular', 'templates'], (ng, templates) ->
  'use strict'
  module = ng.module 'application', [
    'ngRoute'
    'ngAnimate-animate.css'
  ]

  module.config ['$routeProvider', '$locationProvider', (rp, lp) ->
    lp.html5Mode true
    rp.when '/hello', { controller: 'HelloController', template: templates.hello }

    rp.otherwise redirectTo: '/hello'
  ]

  module.controller 'HelloController', ['$scope', '$http', 'routes', ($scope, $http, routes) -> 
    $scope.valid = -> $scope.name && $scope.name != "" && $scope.name != null
    $scope.name = ""
    $scope.response = null
    $scope.responseCompleted = false
    $scope.submit = ->
      $scope.responseCompleted = false
      if $scope.valid()
        $http.get routes.landing.sayHello({name: $scope.name})
             .success (data) ->
                if (data.result == "success")
                  $scope.responseCompleted = true
                  $scope.response = data.data.response
                else
                  $scope.response = null
      else
        $scope.responseCompleted = true
  ]

  module.factory 'routes', [->
    landing:
      sayHello: (queryObj) ->
        url = "/landing/sayhello"
        if queryObj
          url += "?"
          for k,v of queryObj
            url += "#{k}=#{v}&"
          url
  ]

  module
