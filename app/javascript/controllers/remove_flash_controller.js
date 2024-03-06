import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="remove-flash"
export default class extends Controller {
  static targets = ["flashMessage"];

  connect() {
    // Set a timeout to remove the element after 3 seconds
    this.timer = setTimeout(() => {
      this.removeElement();
    }, 3000);
  }

  disconnect() {
    // Clear the timeout when the controller is disconnected
    clearTimeout(this.timer);
  }

  removeElement(event) {
    // Check if the event is triggered by a click or timeout
    if (event || !this.element.dataset.removeOnClick) {
      this.flashMessageTarget.remove();
    }
  }
}
