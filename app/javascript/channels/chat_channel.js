import consumer from "./consumer"

consumer.subscriptions.create("ChatChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("ChatChannel connected")
    this.perform("get_user_data")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log("ChatChannel disconnected")
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log("ChatChannel received:", data.email )
  }
});
