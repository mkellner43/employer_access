import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["darkIcon", "lightIcon", "toggleBtn"];

  connect() {
    this.toggle();
  }

  toggle() {
    const { darkIconTarget, lightIconTarget, toggleBtnTarget } = this;

    // Change the icons inside the button based on previous settings
    if (localStorage.getItem("color-theme") === "dark") {
      document.documentElement.classList.add("dark");
      darkIconTarget.classList.remove("hidden");
    } else {
      lightIconTarget.classList.remove("hidden");
    }
    document.body.classList.remove("opacity-0", "duration-300");

    toggleBtnTarget.addEventListener("click", () => {
      // Toggle icons inside button
      darkIconTarget.classList.toggle("hidden");
      lightIconTarget.classList.toggle("hidden");

      // Toggle dark mode
      if (localStorage.getItem("color-theme") === "dark") {
        document.documentElement.classList.remove("dark");
        localStorage.removeItem("color-theme");
      } else {
        document.documentElement.classList.add("dark");
        localStorage.setItem("color-theme", "dark");
      }
    });
  }
}
