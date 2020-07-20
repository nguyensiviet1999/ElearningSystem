$('.speech').click(function(){
    console.log($(this).data("text"));
    textToSpeech($(this).data("text"));
  })
  function textToSpeech(text){
    if ('speechSynthesis' in window) {
      // Speech Synthesis supported 🎉
      var msg = new SpeechSynthesisUtterance();
      msg.text = text;
      window.speechSynthesis.speak(msg);
     }else{
       // Speech Synthesis Not Supported 😣
       alert("Sorry, your browser doesn't support text to speech!");
     }
    }