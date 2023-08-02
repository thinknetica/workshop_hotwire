# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "https://ga.jspm.io/npm:@hotwired/turbo-rails@7.3.0/app/javascript/turbo/index.js"
pin "@hotwired/turbo", to: "https://ga.jspm.io/npm:@hotwired/turbo@7.3.0/dist/turbo.es2017-esm.js"
pin "@rails/actioncable/src", to: "https://ga.jspm.io/npm:@rails/actioncable@7.0.6/src/index.js"
pin "morphdom", to: "https://ga.jspm.io/npm:morphdom@2.7.0/dist/morphdom-esm.js"
pin "turbo-morphdom", to: "turbo-morphdom.js"
pin "fake_audio", to: "fake_audio.js"
pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.2.1/dist/stimulus.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@rails/request.js", to: "https://ga.jspm.io/npm:@rails/request.js@0.0.8/src/index.js"
pin "@anycable/turbo-stream", to: "https://ga.jspm.io/npm:@anycable/turbo-stream@0.3.2/index.js"
pin "@anycable/core", to: "https://ga.jspm.io/npm:@anycable/core@0.7.1/index.js"
pin "nanoevents", to: "https://ga.jspm.io/npm:nanoevents@7.0.1/index.js"
pin "@anycable/web", to: "https://ga.jspm.io/npm:@anycable/web@0.7.0/index.js"
pin "@turbo-boost/commands", to: "https://ga.jspm.io/npm:@turbo-boost/commands@0.0.11/app/assets/builds/@turbo-boost/commands.js"
pin "@rails/actioncable", to: "actioncable.esm.js"
pin_all_from "app/javascript/channels", under: "channels"
