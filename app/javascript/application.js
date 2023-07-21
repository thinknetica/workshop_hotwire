// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import morphdom from "morphdom";

let prevPath = window.location.pathname;

document.addEventListener("turbo:before-render", (event) => {
  Turbo.navigator.currentVisit.scrolled = prevPath === window.location.pathname;
  prevPath = window.location.pathname;
  event.detail.render = async (prevEl, newEl) => {
    await new Promise((resolve) => setTimeout(() => resolve(), 0));
    morphdom(prevEl, newEl);
  };

  if (document.startViewTransition) {
    event.preventDefault();

    document.startViewTransition(() => {
      event.detail.resume();
    });
  }
});
