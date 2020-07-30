import consumer from "./consumer"
consumer.subscriptions.create("LeaveChannel",{
    connected() {
        // Called when the subscription is ready for use on the server
      },
    
      disconnected() {
        // Called when the subscription has been terminated by the server
      },
    received: function(data){
        return ($('#member_count').html('<div class="col-md-2" id="member_count">'+data.member_of_room+'/'+data.max_member+'</div>'),this.removeOnline(data))
    },
    removeOnline:function(data){
        var find_online_user = "a[href='"+data.user_url+"']"
        $(".online_member li").find(find_online_user).parent().remove()
    }
});