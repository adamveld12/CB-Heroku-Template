exports.config = 
  "modules": [
    "copy" 
    "less" 
    "coffeescript" 
    "html-templates"
    "jshint" 
    "csslint" 
    "server" 
    "require" 
    "minify-js" 
    "minify-css" 
    "live-reload" 
    "jade"
    "bower"
  ]
  watch:
    sourceDir: 'priv/assets'
    compiledDir: 'priv/static'
    javascriptDir: 'js'

  vendor:
    javascripts: 'js/vendor'
    stylesheets: 'css/vendor'

  template:
    outputFileName: 'js/templates'

  server:
    defaultServer:
      enabled: true
    port: 3000
    views:
      path: 'src/view'

  require:
    commonConfig: "main"

  liveReload:
    enabled: true
    additionalDirs: [
      'src/view'
      'src/controller'
    ]