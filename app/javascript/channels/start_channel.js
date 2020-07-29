import consumer from "./consumer"
consumer.subscriptions.create("StartChannel",{
    connected() {
        // Called when the subscription is ready for use on the server
      },
    
      disconnected() {
        // Called when the subscription has been terminated by the server
      },
    received: function(data){
        
            return (this.countdown(data), $('#start').attr('hidden',true))
        
    },
    countdown: function(data){
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
                $('#countdown').attr('hidden',true)
                document.getElementById('show_match').click()
            }
        }, 1000);
    }

});