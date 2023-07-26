import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static classes = ["playing"];
  static values = { id: Number };

  disconnect() {
    this.element.classList.remove(this.playingClass);
  }

  togglePlayingIfMatch(id) {
    if (this.idValue == id) {
      this.element.classList.add(this.playingClass);
    } else {
      this.element.classList.remove(this.playingClass);
    }
  }
}
