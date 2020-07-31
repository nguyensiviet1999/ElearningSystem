import consumer from "./consumer"
consumer.subscriptions.create("LeaveChannel",{
    connected() {
        // Called when the subscription is ready for use on the server
      },
    
      disconnected() {
        // Called when the subscription has been terminated by the server
      },
    received: function(data){
        return ($('#member_count_'+data.chatroom_id).html(data.member_of_room+'/'+data.max_member),
        this.removeOnline(data),
        this.removeFull(data),
        this.checkAllReady(data))
    },
    removeOnline:function(data){
        if (this.checkCurrentChatRoom(data)) {
            var find_online_user = "a[href='/users/"+data.user_id+"']"
            return ($(".online_member li").find(find_online_user).parent().remove());
        }
    },
    removeFull: function(data){
        if ($('#room_button_'+data.chatroom_id).children('#is_full').html()=="Full") {
            var id_room = $('#room_button_'+data.chatroom_id).parent().children().first().html()
            return (alert(data.chatroom_id,id_room),$('#room_button_'+id_room).html(""),$('#room_button_'+id_room).append('<div class="col-md-1 join_chatroom" id_room="'+id_room+'"><a href="/join_rooms/create?id='+id_room+'">Tham gia</a></div>'));
        }
    },
    checkAllReady: function(data){
        if (this.checkCurrentChatRoom(data)) {
            if (data.ready_member == data.member_of_room) {
                return $("#start").removeAttr("hidden")
            }
        }
       
    },
    checkCurrentChatRoom: function(data){
        var current_href = data.root_url + "chatrooms/" + data.chatroom_id
        if (location.href == current_href) {
            return true
        }
        return false
    },
    changeStartedToJoin: function(data){
        ('#room_button_'+data.chatroom_id).children().first().html("")
        ('#room_button_'+data.chatroom_id).children().first().addClass('join_chatroom')
        ('#room_button_'+data.chatroom_id).children().first().attr('id',data.chatroom_id)
        ('#room_button_'+data.chatroom_id).children().first().append('<a href="/join_rooms/create?id='+data.chatroom_id+'">Tham gia</a>')
    }
});