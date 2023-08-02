// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo";
import "@turbo-boost/commands";
import "turbo-morphdom";
import "controllers";
import { createCable } from "@anycable/web";
import { start } from "@anycable/turbo-stream";

const logLevel = document.documentElement.classList.contains("debug")
  ? "debug"
  : "error";

const cable = createCable({
  protocol: "actioncable-v1-ext-json",
  logLevel,
});

start(cable);
import "channels"
