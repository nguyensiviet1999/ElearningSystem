import consumer from "./consumer"
consumer.subscriptions.create("StartChannel", {
    connected() {
        // Called when the subscription is ready for use on the server
    },

    disconnected() {
        // Called when the subscription has been terminated by the server
    },
    received: function (data) {
        if (this.checkCurrentChatRoom(data)) {
            return (this.countdown(data))
        }
        else{
            return(this.changeStartedToJoin(data))
        }
    },
    countdown: function (data) {
        if (this.checkCurrentChatRoom(data)) {
            $('#start').attr('hidden', true)
            var count = 5
            var id = setInterval(() => {

                $('#countdown').removeAttr('hidden')
                $('#countdown').html(count)
                count--;
                if (count == -1) {
                    $('#countdown').html("bat dau")
                }
                if (count == -2) {
                    clearInterval(id)
                    $('#countdown').attr('hidden', true)
                    document.getElementById('show_match').click()
                }
            }, 1000);
        }
    },
    checkCurrentChatRoom: function(data){
        var current_href = data.root_url + "chatrooms/" + data.id_room
        if (location.href == current_href) {
            return true
        }
        return false
    },
    changeStartedToJoin: function(data){
        return $('#room_button_'+data.id_room).children().first().html("Started");
    }

});