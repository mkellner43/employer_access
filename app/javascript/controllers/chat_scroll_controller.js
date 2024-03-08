import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="chat-scroll"
export default class extends Controller {
  connect() {
    this.scroll();
    document.addEventListener("turbo:after-stream-render", () => this.scroll());
  }

  disconnect() {
    document.removeEventListener("turbo:after-stream-render", () =>
      this.scroll()
    );
  }

  scroll() {
    this.element.scrollTop = this.element.scrollHeight;
  }
}
