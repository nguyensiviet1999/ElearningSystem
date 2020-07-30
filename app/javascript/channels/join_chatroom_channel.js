
import consumer from "./consumer"
consumer.subscriptions.create("JoinChatroomChannel",{
    connected() {
        // Called when the subscription is ready for use on the server
      },
    
      disconnected() {
        // Called when the subscription has been terminated by the server
      },
    received: function(data){
        
        return (checkFullRoom(data),this.changeMemberOfRoom());
    },
    checkFullRoom: function(data){
        if (data.max_number_members == data.member_count) {
            return $('#join_chatroom').attr("hidden",true);
        }
    },
    changeMemberOfRoom: function(){
        var member = parseInt($('#member_count').html.split('/')[0])+1
        var max_member = $('#member_count').html.split('/')[1]
        return ($('#member_count').html(member.toString+'/'+max_member))
    }
});