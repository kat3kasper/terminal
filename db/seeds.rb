require 'factory_bot_rails'

DEVSKILLS = [
  {
    "name": "amazonwebservices",
    "tags": ["cloud", "hosting", "server"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain-wordmark"],
      "font": ["original", "plain-wordmark"]
    }
  },
  {
    "name": "android",
    "tags": ["os", "mobile"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "angularjs",
    "tags": ["framework", "javascript"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "apache",
    "tags": ["php"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark", "line", "line-wordmark"],
      "font": ["plain", "plain-wordmark", "line", "line-wordmark"]
    }
  },
  {
    "name": "appcelerator",
    "tags": ["app", "mobile"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain-wordmark"],
      "font": ["original", "plain-wordmark"]
    }
  },
  {
    "name": "apple",
    "tags": ["brand", "mobile"],
    "versions": {
      "svg": ["original"],
      "font": ["original"]
    }
  },
  {
    "name": "atom",
    "tags": ["editor"],
    "versions": {
      "svg": ["original", "original-wordmark"],
      "font": ["original", "original-wordmark"]
    }
  },

  {
    "name": "babel",
    "tags": ["javascript", "transpiler"],
    "versions": {
      "svg": ["original", "plain"],
      "font": ["plain"]
    }
  },
  {
    "name": "backbonejs",
    "tags": ["javascript", "framework"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "behance",
    "tags": ["social", "website"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "bitbucket",
    "tags": [],
    "versions": {
      "svg": ["original", "original-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "bootstrap",
    "tags": ["css", "framework"],
    "versions": {
      "svg": ["plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "bower",
    "tags": ["package", "manager"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark", "line", "line-wordmark"],
      "font": ["plain", "plain-wordmark", "line", "line-wordmark"]
    }
  },
  {
    "name": "c",
    "tags": ["language"],
    "versions": {
      "svg": ["original", "plain", "line"],
      "font": ["plain", "plain-wordmark", "line", "line-wordmark"]
    }
  },
  {
    "name": "cakephp",
    "tags": ["framework"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "ceylon",
    "tags": ["language"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "chrome",
    "tags": ["browser"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "codeigniter",
    "tags": ["php", "framework"],
    "versions": {
      "svg": ["plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "coffeescript",
    "tags": ["javascript", "language"],
    "versions": {
      "svg": ["original", "original-wordmark"],
      "font": ["original", "original-wordmark"]
    }
  },
  {
    "name": "confluence",
    "tags": [],
    "versions": {
      "svg": ["original", "original-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "couchdb",
    "tags": ["database"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "cplusplus",
    "tags": ["language"],
    "versions": {
      "svg": ["original", "plain", "line"],
      "font": ["plain", "plain-wordmark", "line", "line-wordmark"]
    }
  },
  {
    "name": "csharp",
    "tags": ["language"],
    "versions": {
      "svg": ["original", "plain", "line"],
      "font": ["plain", "plain-wordmark", "line", "line-wordmark"]
    }
  },
  {
    "name": "css3",
    "tags": ["language", "programming"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "cucumber",
    "tags": ["framework"],
    "versions": {
      "svg": ["plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "d3js",
    "tags": [],
    "versions": {
      "svg": ["original", "plain"],
      "font": ["plain"]
    }
  },
  {
    "name": "debian",
    "tags": ["os", "server"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "devicon",
    "tags": ["iconset"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "django",
    "tags": [],
    "versions": {
      "svg": ["original", "plain", "line"],
      "font": ["plain", "plain-wordmark", "line", "line-wordmark"]
    }
  },
  {
    "name": "docker",
    "tags": ["platform", "deploy"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "doctrine",
    "tags": [],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark", "line", "line-wordmark"],
      "font": ["plain", "plain-wordmark", "line", "line-wordmark"]
    }
  },
  {
    "name": "dot-net",
    "tags": ["framework"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "drupal",
    "tags": ["cms"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "electron",
    "tags": ["framework"],
    "versions": {
      "svg": ["original", "original-wordmark"],
      "font": ["original", "original-wordmark"]
    }
  },
  {
    "name": "elm",
    "tags": ["framework"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "ember",
    "tags": ["framework"],
    "versions": {
      "svg": ["original-wordmark"],
      "font": ["original-wordmark"]
    }
  },
  {
    "name": "erlang",
    "tags": [],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "express",
    "tags": ["framework"],
    "versions": {
      "svg": ["original", "original-wordmark"],
      "font": ["original", "original-wordmark"]
    }
  },
  {
    "name": "facebook",
    "tags": ["auth"],
    "versions": {
      "svg": ["original", "plain"],
      "font": ["plain"]
    }
  },
  {
    "name": "firefox",
    "tags": ["browser"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "foundation",
    "tags": ["framework", "css"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "gatling",
    "tags": ["framework", "testing"],
    "versions": {
      "svg": ["plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "gimp",
    "tags": ["graphic"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain"]
    }
  },
  {
    "name": "git",
    "tags": ["version-control"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "github",
    "tags": ["version-control"],
    "versions": {
      "svg": ["original", "original-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "gitlab",
    "tags": ["version-control"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "go",
    "tags": ["language"],
    "versions": {
      "svg": ["original", "plain", "line"],
      "font": ["plain", "line"]
    }
  },
  {
    "name": "google",
    "tags": ["auth"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "gradle",
    "tags": ["task-runner"],
    "versions": {
      "svg": ["plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "grunt",
    "tags": ["task-runner", "nodejs"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark", "line", "line-wordmark"],
      "font": ["plain", "plain-wordmark", "line", "line-wordmark"]
    }
  },
  {
    "name": "gulp",
    "tags": ["task-runner", "nodejs"],
    "versions": {
      "svg": ["plain"],
      "font": ["plain"]
    }
  },
  {
    "name": "handlebars",
    "tags": ["framework"],
    "versions": {
      "svg": ["original", "original-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "heroku",
    "tags": ["cloud"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["original", "original-wordmark", "plain", "plain-wordmark", "line", "line-wordmark"]
    }
  },
  {
    "name": "html5",
    "tags": ["programming", "language"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "ie10",
    "tags": ["browser"],
    "versions": {
      "svg": ["original"],
      "font": ["original"]
    }
  },
  {
    "name": "illustrator",
    "tags": ["editor", "vector"],
    "versions": {
      "svg": ["plain", "line"],
      "font": ["plain", "line"]
    }
  },
  {
    "name": "inkscape",
    "tags": ["editor", "vector"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "intellij",
    "tags": ["editor"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "ionic",
    "tags": ["framework"],
    "versions": {
      "svg": ["original", "original-wordmark"],
      "font": ["original", "original-wordmark"]
    }
  },
  {
    "name": "java",
    "tags": ["programming", "language"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "jasmine",
    "tags": ["testing"],
    "versions": {
      "svg": ["plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "javascript",
    "tags": ["programming", "language"],
    "versions": {
      "svg": ["original", "plain"],
      "font": ["plain"]
    }
  },
  {
    "name": "jeet",
    "tags": ["framework", "css"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "jetbrains",
    "tags": [],
    "versions": {
      "svg": ["original", "plain"],
      "font": ["plain", "plain-wordmark", "line", "line-wordmark"]
    }
  },
  {
    "name": "jquery",
    "tags": ["library", "javascript"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "krakenjs",
    "tags": ["nodejs", "framework"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "laravel",
    "tags": ["php", "framework"],
    "versions": {
      "svg": ["plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "less",
    "tags": ["css", "pre-processor"],
    "versions": {
      "svg": ["plain-wordmark"],
      "font": ["plain-wordmark"]
    }
  },
  {
    "name": "linkedin",
    "tags": ["social", "auth"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "linux",
    "tags": ["os"],
    "versions": {
      "svg": ["original", "plain"],
      "font": ["plain"]
    }
  },
  {
    "name": "meteor",
    "tags": ["javascript"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "mocha",
    "tags": ["testing"],
    "versions": {
      "svg": ["plain"],
      "font": ["plain"]
    }
  },
  {
    "name": "mongodb",
    "tags": ["database"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "moodle",
    "tags": ["platform"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "mysql",
    "tags": ["database", "language"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "nginx",
    "tags": ["server"],
    "versions": {
      "svg": ["original"],
      "font": ["original", "original-wordmark", "plain", "plain-wordmark"]
    }
  },
  {
    "name": "nodejs",
    "tags": ["javascript", "language"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "nodewebkit",
    "tags": [],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark", "line", "line-wordmark"],
      "font": ["plain", "plain-wordmark", "line", "line-wordmark"]
    }
  },
  {
    "name": "npm",
    "tags": ["package", "manager"],
    "versions": {
      "svg": ["original-wordmark"],
      "font": ["original-wordmark"]
    }
  },
  {
    "name": "oracle",
    "tags": ["database"],
    "versions": {
      "svg": ["original"],
      "font": ["original"]
    }
  },
  {
    "name": "photoshop",
    "tags": ["editor", "graphic"],
    "versions": {
      "svg": ["plain", "line"],
      "font": ["plain", "line"]
    }
  },
  {
    "name": "php",
    "tags": ["programming", "language"],
    "versions": {
      "svg": ["original", "plain"],
      "font": ["plain"]
    }
  },
  {
    "name": "phpstorm",
    "tags": ["editor"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "protractor",
    "tags": ["framework", "javascript"],
    "versions": {
      "svg": ["plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "postgresql",
    "tags": ["database"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "python",
    "tags": ["programming", "language"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "pycharm",
    "tags": ["editor"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "rails",
    "tags": ["framework"],
    "versions": {
      "svg": ["original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "react",
    "tags": ["framework"],
    "versions": {
      "svg": ["original", "original-wordmark"],
      "font": ["original", "original-wordmark"]
    }
  },
  {
    "name": "redhat",
    "tags": ["server", "linux"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "redis",
    "tags": ["server"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "ruby",
    "tags": ["programming", "language"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "rubymine",
    "tags": ["editor"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "safari",
    "tags": ["browser"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark", "line-wordmark", "line"],
      "font": ["plain", "plain-wordmark", "line-wordmark", "line"]
    }
  },
  {
    "name": "sass",
    "tags": ["pre-processor", "css"],
    "versions": {
      "svg": ["original"],
      "font": ["original"]
    }
  },
  {
    "name": "sequelize",
    "tags": ["database", "language"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "sketch",
    "tags": ["application"],
    "versions": {
      "svg": ["original", "original-wordmark", "line", "line-wordmark"],
      "font": ["line", "line-wordmark"]
    }
  },
  {
    "name": "slack",
    "tags": ["chat"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "sourcetree",
    "tags": ["version-control"],
    "versions": {
      "svg": ["original", "original-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "ssh",
    "tags": ["security"],
    "versions": {
      "svg": ["original", "original-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "stylus",
    "tags": ["css", "pre-processor"],
    "versions": {
      "svg": ["original"],
      "font": ["original"]
    }
  },
  {
    "name": "swift",
    "tags": ["language"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "symfony",
    "tags": ["framework"],
    "versions": {
      "svg": ["original", "original-wordmark"],
      "font": ["original", "original-wordmark"]
    }
  },
  {
    "name": "tomcat",
    "tags": ["server"],
    "versions": {
      "svg": ["original", "original-wordmark", "line", "line-wordmark"],
      "font": ["line", "line-wordmark"]
    }
  },
  {
    "name": "travis",
    "tags": ["platform", "integration"],
    "versions": {
      "svg": ["plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "trello",
    "tags": ["platform", "organize"],
    "versions": {
      "svg": ["plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "twitter",
    "tags": ["auth"],
    "versions": {
      "svg": ["original"],
      "font": ["plain"]
    }
  },
  {
    "name": "typescript",
    "tags": ["programming", "transpiler"],
    "versions": {
      "svg": ["original", "plain"],
      "font": ["plain"]
    }
  },
  {
    "name": "ubuntu",
    "tags": ["os"],
    "versions": {
      "svg": ["plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "vagrant",
    "tags": ["platform"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "vim",
    "tags": ["editor"],
    "versions": {
      "svg": ["original", "plain"],
      "font": ["plain"]
    }
  },
  {
	  "name": "visualstudio",
	  "tags": ["editor"],
	  "versions": {
		  "svg": ["plain", "plain-wordmark"],
		  "font": ["plain", "plain-wordmark"]
	  }
  },
  {
    "name": "vuejs",
    "tags": ["framework"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark", "line", "line-wordmark"],
      "font": ["plain", "plain-wordmark", "line", "line-wordmark"]
    }
  },
  {
    "name": "webpack",
    "tags": ["package", "manager"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "webstorm",
    "tags": ["editor"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "windows8",
    "tags": ["os"],
    "versions": {
      "svg": ["original", "original-wordmark"],
      "font": ["original", "original-wordmark"]
    }
  },
  {
    "name": "wordpress",
    "tags": ["cms"],
    "versions": {
      "svg": ["original", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "yarn",
    "tags": ["package", "manager"],
    "versions": {
      "svg": ["original", "original-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "yii",
    "tags": ["php", "framework"],
    "versions": {
      "svg": ["original", "original-wordmark", "plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  },
  {
    "name": "zend",
    "tags": ["php", "framework"],
    "versions": {
      "svg": ["plain", "plain-wordmark"],
      "font": ["plain", "plain-wordmark"]
    }
  }
]

EMPLOYMENT_TYPE = [
  'Full time', 'Part time', 'Contracted', 'Casual', 'Seasonal', 'Internship'
].freeze

BENEFITS = [
  'Office Dogs', 'Equity', 'Remote', '30+ Days Parental Leave', '60+ Days Parental Leave',
  '90+ Days Parental Leave', 'Flexible Hours', 'Social Mission', 'Environmental Mission',
  '401(k)', '401(k) Matching', '100% Covered Health Insurance', '80%+ Covered Health Insurance',
  'Dental Insurance', 'Vision Insurance', 'Life Insurance', 'Trans-Inclusive Healthcare',
  'Professional Development Budget', 'Unlimited Vacation', '30+ Days Vacation', 'Lunch Provided',
  'Beach Within 60 Minutes', 'Mountain Within 60 Minutes', 'In-Office Gym', 'Flat Heirarchy',
  'Commuter Coverage'
].freeze

CULTURES = [
  'family-like team', 'Cubicles', 'No cubicles', 'company outings', 'beer on tap', 'ping pong',
  'Game Nights', 'pair programming', 'not pair programming'
].freeze

DEVSKILLS.each do |skill|
  Competence.create(value: skill[:name])
end

p "Created #{Competence.count} competences"

BENEFITS.each do |value|
  Benefit.create(value: value)
end

p "Created #{Benefit.all.count} benefits"

CULTURES.each do |value|
  Culture.create(value: value)
end

p "Created #{Culture.all.count} cultures"

case Rails.env
when "development"
  5.times do
    company = Company.create(
      url: Faker::Internet.url,
      name: Faker::Company.name,
      industry: Faker::Company.industry
    )
    puts "created company #{company.name}"
  end

  5.times do
    r = Recruiter.new(
      email: Faker::Internet.email,
      password: "password",
      company: Company.all.sample,
      confirmed_at: Time.now.utc
    )
    r.save validate: false
  end
  r = Recruiter.new(
    email: 'recruiter@example.com',
    password: "password",
    company: Company.all.sample,
    confirmed_at: Time.now.utc
  )
  r.save validate: false

  PLACES = [
    {city: "Los Angeles", state: "CA", country: "United States"},
    {city: "Chicago", state: "MI", country: "United States"},
    {city: "New York", state: "NY", country: "United States"},
    {city: "San Francisco", state: "CA", country: "United States"}
  ]

  Company.all.each do |company|
    FactoryBot.create :subscriber, company: company

    15.times do
      cultures = []
      benefits = []
      skills = []
      remote = [['remote'], ['office'], %w[remote office]]
      salary = [10_000, 20_000, 30_000, 40_000, 50_000, 60_000]

      rand(2..5).times do
        cultures << Culture.find(rand(1..Culture.count)).value
      end
      rand(2..5).times do
        benefits << Benefit.find(rand(1..Benefit.count)).value
      end

      i = rand(0..3)
      job = Job.new(
        title: Faker::Company.profession,
        description: Faker::Lorem.paragraph(2, false, 4),
        remote: remote.sample,
        city: PLACES[i][:city],
        state: PLACES[i][:state],
        country: PLACES[i][:country],
        employment_type: EMPLOYMENT_TYPE.sample,
        latitude: nil,
        longitude: nil,
        benefits: benefits,
        cultures: cultures,
        can_sponsor: Faker::Boolean.boolean(0.2),
        company: company
      )
      if job.save
        puts "created job #{job.title}"
        job.skills.new(name: Competence.all.sample.value, level: rand(1..4)).save
      end
    end

  end

  p "Creating Developers"

  5.times do
    dev = Developer.new(
      email: Faker::Internet.email,
      password: 'password',
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      city: 'Los Angeles',
      state: 'CA',
      country: 'United States',
      need_us_permit: Faker::Boolean.boolean(0.2),
      min_salary: salary = [10_000, 20_000, 30_000].sample,
      remote: [['remote'], ['office'], %w[remote office]].sample,
    )
    dev.skip_confirmation!
    dev.save validate: false
    p "Developer created: #{dev.email}"
    3.times do
      skill = dev.skills.new(name: Competence.all.sample.value, level: rand(3..5))
      skill.save
    end
    p "3 skills added"
  end

  5.times do
    Application.create(
      match: Match.all.sample,
      message: Faker::Lorem.paragraph
    )
  end

  dev = Developer.new(
    email: "dev@example.com",
    password: "password",
    password_confirmation: 'password',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    city: 'New York',
    state: 'NY',
    country: 'United States',
    need_us_permit: false,
    min_salary: 10_000,
    remote:  ["remote", "office"]
  )
  dev.skip_confirmation!
  dev.save validate: false

  p "adding 40 skills"
  40.times do
    dev = Developer.last.skills.new(name: Competence.all.sample.value, level: rand(3..5))
    dev.save
  end

  p "Create matches"
  Developer.all.each do |developer|
    developer.matched_job.each do |job|
      Match.create(developer_id: developer.id, job_id: job.id)
    end
  end

  Admin.create!(
    email: "admin@findmyflock.com",
    password: 'password'
  )

when 'production'
  Admin.create!(
    email: "info@findmyflock.com",
    password: Rails.application.credentials.admin_password,
    password_confirmation: Rails.application.credentials.admin_password
  )
end

Plan.create(name: "1 Job Posting", stripe_id: "1-job", display_price: (3999.to_f / 100))
Plan.create(name: "3 Job Postings", stripe_id: "3-jobs", display_price: (9999.to_f / 100))

begin
  basic_plan = Stripe::Plan.create(
    amount: 3999,
    interval: "month",
    product: {
      name: "1 Job"
    },
    currency: "usd",
    id: "1-job"
  )
  gold_plan = Stripe::Plan.create(
    amount: 9999,
    interval: "month",
    product: {
      name: "3 Jobs"
    },
    currency: "usd",
    id: "3-jobs"
  )
rescue
  puts 'Plans already exist on Stripe'
end
