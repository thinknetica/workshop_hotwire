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
pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.2.1/dist/stimulus.js"
pin "stimulus-use/hotkeys", to: "https://ga.jspm.io/npm:stimulus-use@0.52.0/dist/hotkeys.js"
pin 'hotkeys-js', to: "https://ga.jspm.io/npm:hotkeys-js@3.11.2/dist/hotkeys.esm.js"
pin_all_from "app/javascript/controllers", under: "controllers"
