import consumer from "./consumer"
consumer.subscriptions.create("CheckRoomStatusChannel",{
    connected() {
        // Called when the subscription is ready for use on the server
      },
    
      disconnected() {
        // Called when the subscription has been terminated by the server
      },
    received: function(data){
        if (parseInt(data.ready_member)==parseInt(data.member_of_room)) {
            return (this.checkFullRoom(data),this.changeMemberOfRoom(),$("#start").attr("hidden",true),$(".online_member").append(this.renderOnlineMember(data)))
        }
        else{
            return (this.checkFullRoom(data),this.changeMemberOfRoom(),$(".online_member").append(this.renderOnlineMember(data)))
        }
    },
    renderOnlineMember: function(data){
         return '<li><a title='+data.title+' toggle="tooltip" href="'+data.link_to+'"><img class="card-img-top online_room" title="" src="'+data.avatar+'" data-original-title="'+data.title+'"></a></li>'
    },
    checkFullRoom: function(data){
        if (data.max_number_members == data.member_count) {
            return $('#join_chatroom').attr("hidden",true);
        }
    },
    changeMemberOfRoom: function(){
        var member = parseInt($('#member_count').html().split('/')[0])+1
        var max_member = $('#member_count').html().split('/')[1]
        return ($('#member_count').html(member+'/'+max_member))
    }

});