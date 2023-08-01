import { Application } from "@hotwired/stimulus";
import PasswordVisibility from 'stimulus-password-visibility'

const application = Application.start();

application.register('password-visibility', PasswordVisibility)

// Configure Stimulus development experience
application.debug = document.documentElement.classList.contains("debug");
window.Stimulus = application;

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";
eagerLoadControllersFrom("controllers", application);
