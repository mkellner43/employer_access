import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="clipboard"
export default class extends Controller {
  static targets = [
    "defaultIcon",
    "successIcon",
    "defaultTooltip",
    "successTooltip",
  ];
  connect() {
    const clipboard = FlowbiteInstances.getInstance(
      "CopyClipboard",
      "contact-details"
    );
    const tooltip = FlowbiteInstances.getInstance(
      "Tooltip",
      "tooltip-contact-details"
    );
    clipboard.updateOnCopyCallback((clipboard) => {
      this.showSuccess(tooltip);

      // reset to default state
      setTimeout(() => {
        this.resetToDefault(tooltip);
      }, 2000);
    });
  }

  showSuccess(tooltip) {
    this.defaultIconTarget.classList.add("hidden");
    this.successIconTarget.classList.remove("hidden");
    this.defaultTooltipTarget.classList.add("hidden");
    this.successTooltipTarget.classList.remove("hidden");
    tooltip.show();
  }

  resetToDefault(tooltip) {
    this.defaultIconTarget.classList.remove("hidden");
    this.successIconTarget.classList.add("hidden");
    this.defaultTooltipTarget.classList.remove("hidden");
    this.successTooltipTarget.classList.add("hidden");
    tooltip.hide();
  }
}
