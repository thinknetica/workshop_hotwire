import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="removeable"
export default class extends Controller {
  static values = { after: Number };

  connect() {
    if (this.afterValue) {
      this.removeTid = setTimeout(() => this.remove(), this.afterValue * 1000);
    }
  }

  disconnect() {
    if (this.removeTid) clearTimeout(this.removeTid);
  }

  remove() {
    this.element.remove();
  }
}
