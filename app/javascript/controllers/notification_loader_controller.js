import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="notification-loader"
export default class extends Controller {
  static targets = ["loader"];
  connect() {}

  show(e) {
    if (e.detail.url.toString().includes("/notifications")) {
      this.loaderTarget.classList.add("flex");
      this.loaderTarget.classList.remove("hidden");
    }
  }
}
