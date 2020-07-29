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
            notification_msg = "Ban la nguoi chien thang"
        } else {
            notification_msg = "Ban la nguoi thua cuoc"
        }
        
        return ($("#finish_slide").html(notification_msg));
    }
});