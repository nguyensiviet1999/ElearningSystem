import consumer from "./consumer"
consumer.subscriptions.create("LeaveChannel",{
    connected() {
        // Called when the subscription is ready for use on the server
      },
    
      disconnected() {
        // Called when the subscription has been terminated by the server
      },
    received: function(data){
        return ($('#member_count').html(data.member_of_room+'/'+data.max_member),this.removeOnline(data),this.removeFull())
    },
    removeOnline:function(data){
        var find_online_user = "a[href='"+data.user_url+"']"
        $(".online_member li").find(find_online_user).parent().remove()
    },
    removeFull: function(){
        if ($('#room_button').children('#is_full').html()=="Full") {
            var id_room = $('#room_button').parent().children().first().html()
            $('#room_button').html("")
            $('#room_button').append('<div class="col-md-1 join_chatroom" id_room="'+id_room+'"><a href="/join_rooms/create?id='+id_room+'">Tham gia</a></div>')
        }
        
    }
});