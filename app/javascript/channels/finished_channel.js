import consumer from "./consumer"
consumer.subscriptions.create("FinishedChannel",{
    connected() {
        // Called when the subscription is ready for use on the server
      },
    
      disconnected() {
        // Called when the subscription has been terminated by the server
      },
    received: function(data){
        var notification_msg=""
        if (data.winner_id == $('#finished').attr('current_user_id')) {
            notification_msg = "Ban la nguoi chien thang<div><a href=''>Dau lai</a><a href='/chatrooms'>Chon phong khac</a></div>"
        } else {
            
            notification_msg = "Ban la nguoi thua cuoc<div><a href=''>Dau lai</a><a href='/chatrooms'>Chon phong khac</a></div>"
        }
        return ($(".carousel-item").removeClass("active"),$("#finish_slide").html(notification_msg),$("#finish_slide").addClass('active'),document.getElementById('stopTime').click(),this.removeStarted(data));
    },
    removeStarted:function(data){
        $('#room_button_'+data.chatroom_id).children().first().html("")
        $('#room_button_'+data.chatroom_id).children().first().addClass('join_chatroom')
        $('#room_button_'+data.chatroom_id).children().first().attr('id',data.chatroom_id)
        $('#room_button_'+data.chatroom_id).children().first().append('<a href="/join_rooms/create?id='+data.chatroom_id+'">Tham gia</a>')
    }
});