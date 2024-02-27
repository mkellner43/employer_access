import { Controller } from "@hotwired/stimulus";
import consumer from "channels/consumer";
// Connects to data-controller="chat"
export default class extends Controller {
  connect() {
    console.log("connected!");
    let chatId = this.element.dataset;
    console.log(chatId)
    this.sub = this.createActionCableChannel(chatId);

    console.log(this.sub);
  }

  createActionCableChannel(chatId) {
    return consumer.subscriptions.create(
      { channel: "ChatChannel", chat_id: chatId },
      {
        connected() {
          // Called when the subscription is ready for use on the server
          console.log("ChatChannel connected");
          this.perform("get_user_data");
        },

        disconnected() {
          // Called when the subscription has been terminated by the server
          console.log("ChatChannel disconnected");
        },

        received(data) {
          // Called when there's incoming data on the websocket for this channel
          console.log("ChatChannel received:", data.email);
        },
      }
    );
  }
}
