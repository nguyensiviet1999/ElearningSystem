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
            return (this.checkFullRoom(data),this.changeMemberOfRoom(),$(".online_member").append(this.renderOnlineMember(data)),$("#start").removeAttr("hidden"))
        }
    },
    renderOnlineMember: function(data){
         return '<li><a title='+data.title+' toggle="tooltip" href="'+data.link_to+'"><img class="card-img-top online_room" title="" src="'+data.avatar+'" data-original-title="'+data.title+'"></a></li>'
    },
    checkFullRoom: function(data){
        if (data.max_number_members == data.member_of_room) {
            var id_room = $('#room_button').parent().children().first().html()
            return ($(".join_chatroom[id_room='"+id_room+"']").remove(),$('#room_button').append('<div class="col-md-2" id="is_full">Full</div>'));
        }
    },
    changeMemberOfRoom: function(){
        var member = "";
        var max_member = "";
        if ( $('#member_count') != null){
             member = parseInt($('#member_count').html().split('/')[0])+1
             max_member = $('#member_count').html().split('/')[1]
        }
       
        if (member>max_member) {
            member = max_member
        }
        return ($('#member_count').html(member+'/'+max_member))
    }

});