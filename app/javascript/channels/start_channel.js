import consumer from "./consumer"
consumer.subscriptions.create("StartChannel",{
    connected() {
        // Called when the subscription is ready for use on the server
      },
    
      disconnected() {
        // Called when the subscription has been terminated by the server
      },
    received: function(data){
        
            return (this.countdown(data))
        
    },
    countdown: function(data){
        var count = 5
        var id = setInterval(() => {
            count--;
            $('#countdown').removeAttr('hidden')
            $('#countdown').html(count)
            if (count == 0) {
                clearInterval(id)
            }
        }, 1000);
    }

});