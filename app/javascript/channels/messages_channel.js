import consumer from "./consumer"
consumer.subscriptions.create("MessagesChannel",{
    connected() {
        // Called when the subscription is ready for use on the server
      },
    
      disconnected() {
        // Called when the subscription has been terminated by the server
      },
    received: function(data){
        $("#messages").removeClass("hidden")
        
        return ($("#messages").append(this.renderMessage(data)));
    },
    renderMessage: function(data){
        return "<p class='chatMessages' ><b>"+ data.user + " :</b>" + data.message + "</p>";
    },
    scrollToBot: function(data){
      var l = document.getElementsByClassName("chatMessages").length;
        document.getElementsByClassName("chatMessages")[l-1].scrollIntoView();
  }
});