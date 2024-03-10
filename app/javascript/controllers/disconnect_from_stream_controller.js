import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="disconnect-from-stream"
export default class extends Controller {
  static targets = ["stream"];
  connect() {
    console.log('controller connected')
  }

  hide() {
    console.log('hide')
    this.streamTarget.style.display = "none";
  }

  show() {
    console.log('show')
    this.streamTarget.style.display = "block";
  }
}
