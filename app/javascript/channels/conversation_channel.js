import consumer from "./consumer"

consumer.subscriptions.create("ConversationChannel", {
	connected() {
    // Called when the subscription is ready for use on the server
},

disconnected() {
    // Called when the subscription has been terminated by the server
},

received(data) {
  var conversation = document.getElementById('conversation_' + data['conversation_id']);
  if (conversation === null) {
    document.getElementById('conversations_list').innerHTML = data['conversations_content'];
  } else {
    var message = document.createElement('span');
    message.innerHTML = data['message'];
    conversation.appendChild(message);
    document.getElementById('message-body').value = '';
    var messages_list = document.querySelector('.messages-list')
    var scrollPosition = messages_list.scrollHeight;
    messages_list.scrollTo(0, scrollPosition);
    this.send({ message_id: data.message_id });
  }
}


});
