
import consumer from "./consumer"
consumer.subscriptions.create("JoinChatroomChannel",{
    connected() {
        // Called when the subscription is ready for use on the server
      },
    
      disconnected() {
        // Called when the subscription has been terminated by the server
      },
    received: function(data){
        return ($("#member_count").html(parseInt($("#member_count").html)+1),checkFullRoom(data));
    },
    checkFullRoom: function(data){
        if (data.max_number_members == data.member_count) {
            return $('#join_chatroom').attr("hidden",true);
        }
    }
});