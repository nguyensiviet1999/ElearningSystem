import consumer from "./consumer"
consumer.subscriptions.create("ReadyChannel",{
    connected() {
        // Called when the subscription is ready for use on the server
      },
    
      disconnected() {
        // Called when the subscription has been terminated by the server
      },
    received: function(data){
        if (parseInt(data.ready_member)==parseInt(data.member_of_room)) {
            return ($("#start").removeAttr("hidden"),$("#ready").attr("hidden",true))
        }
    },

});