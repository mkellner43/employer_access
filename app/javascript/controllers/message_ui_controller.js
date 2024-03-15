import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="message-ui"
export default class extends Controller {
  static targets = ["messageSection", "messageSpan", "messageImg"];
  connect() {
    this.updateUi();
  }

  updateUi() {
    // data
    let current_user = document.getElementById("messages").dataset.currentUser;
    let message_sender = this.element.dataset.userId;
    // ui
    let message_container = this.element;
    let message_section = this.messageSectionTarget;
    let message_span = this.messageSpanTarget;
    let message_img = this.messageImgTarget;

    if (message_sender == current_user) {
      message_container.classList.add("justify-end");
      message_section.classList.add("order-1", "items-end");
      message_span.classList.add("bg-blue-600", "text-white");
      message_img.classList.add("order-2");
    } else {
      message_section.classList.add("order-2", "items-start");
      message_span.classList.add("bg-gray-300", "text-gray-600");
      message_img.classList.add("order-1");
    }
  }
}

// <%= message.user.id == user.id ? 'justify-end' : '' %>
// <%= message.user.id == user.id ? 'order-1 items-end' : 'order-2 items-start' %>
// <%= message.user.id == user.id ? 'bg-blue-600 text-white' : 'bg-gray-300 text-gray-600' %>"
// <%= message.user.id == user.id ? 'order-2' : 'order-1' %>
