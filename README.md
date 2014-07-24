Chicago Boss Heroku Project Template
====================================

#### What this is? ####

  This is a project template to help get you up and running with Chicago Boss, Mimosajs, and Rake (weird build stack, I know).
  This project is setup as an angular app using coffee and html templates. 
  Checkout a running version of it [here] (http://cb-template.herokuapp.com/).

#### What you'll need ####

1. [Heroku Toolbelt] (Heroku Toolbelt)

2. [Node] (Node)

3. [Ruby] (Ruby)

#### How to use ####

Do this in a terminal:
``` sh
heroku apps:create <appname> --buildpack https://github.com/ddollar/heroku-buildpack-multi.git
    bundle install
    rake 
```

#### Notes ####

  This uses a slightly customized version of the [Chicago Boss Buildpack] (Chicago Boss Buildpack) that supports mongoDb and postgres. 
  More coming if I'm bothered enough.


#### License ####

MIT 

[Chicago Boss Buildpack]:[https://github.com/adamveld12/heroku-buildpack-chicagoboss]
[Heroku Toolbelt]:[https://toolbelt.heroku.com/]
[Node]:[http://nodejs.org/]
[Ruby]:[https://www.ruby-lang.org/en/]
