# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "trix", to: "trix_v2.1.1.js"
pin "@rails/actiontext", to: "actiontext.js"
pin "bootstrap", to: "bootstrap.min.js", preload: true
