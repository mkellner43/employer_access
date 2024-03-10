import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="clear-form"
export default class extends Controller {
  connect() {}

  clearForm() {
    document.getElementById("message_content").value = "";
  }
}
