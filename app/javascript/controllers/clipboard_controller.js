import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="clipboard"
export default class extends Controller {
  static targets = [
    "contactDetails",
    "defaultIcon",
    "successIcon",
    "defaultTooltip",
    "successTooltip",
    "tooltip",
  ];

  copy(event) {
    event.preventDefault();
    const textToCopy = this.contactDetailsTarget.innerText;
    navigator.clipboard
      .writeText(textToCopy)
      .then(() => {
        this.showSuccess();
      })
      .catch((err) => {
        console.error("Error copying text: ", err);
      });
  }

  connect() {}

  showSuccess() {
    this.defaultIconTarget.classList.add("hidden");
    this.successIconTarget.classList.remove("hidden");
    this.defaultTooltipTarget.classList.add("hidden");
    this.successTooltipTarget.classList.remove("hidden");
    setTimeout(() => {
      this.resetToDefault();
    }, 2000);
  }

  resetToDefault() {
    this.defaultIconTarget.classList.remove("hidden");
    this.successIconTarget.classList.add("hidden");
    this.defaultTooltipTarget.classList.remove("hidden");
    this.successTooltipTarget.classList.add("hidden");
  }
}
