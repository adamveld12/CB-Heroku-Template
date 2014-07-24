(function($require, $window, $document){
  "use strict";
  var config = {
    // urlArgs: (new Date()).getTime(),
    baseUrl: "/static/js",
    paths:{
      "jquery":"vendor/jquery/jquery",
      "bootstrap":"vendor/bootstrap/bootstrap",
      "lodash": "vendor/lodash/lodash.compat",
      "angular":"vendor/angular/angular",
      "ngRoute":"vendor/angular-route/angular-route",
      "ngAnimate":"vendor/angular-animate/angular-animate",
      "ngAnimate-css":"vendor/ngAnimate-animate.css/animate",
      "application":"application"
    },
    shim:{
     "angular": { exports:"angular" },
     "bootstrap": { deps:["jquery"] },
     "ngAnimate": { deps:["angular"] },
     "ngRoute": { deps:["angular"] },
     "ngAnimate-css": { deps:["angular", "ngAnimate"] },
     "application": { 
       deps: ["angular", "ngAnimate-css", "ngRoute", "bootstrap"]
     }
    }
  };

  $window.name = "NG_DEFER_BOOSTRAP!";
  requirejs.config(config);

  $require(["angular", "application"], function(ng, app){
    ng.element($document).ready(function(){
      ng.bootstrap($document, [app.name]);
    });
  });

}(require, window, document)); // <- no dog balls #douglasCrockford
