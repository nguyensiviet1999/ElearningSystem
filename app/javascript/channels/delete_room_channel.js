import consumer from "./consumer"
consumer.subscriptions.create("DeleteRoomChannel",{
    connected() {
        // Called when the subscription is ready for use on the server
      },
    
      disconnected() {
        // Called when the subscription has been terminated by the server
      },
    received: function(data){
        var id_target = "#room_" + data.id_room
        return ($(id_target).remove(),this.checkUserAtDeletedRoom(data));
    },
    checkUserAtDeletedRoom: function(data){
        var current_href = data.root_url + "chatrooms/" + data.id_room
        if (location.href == current_href) {
            window.location.href = data.root_url + "chatrooms";
        }
    }
});