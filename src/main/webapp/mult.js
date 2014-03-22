$(document).ready(function(){
        $(".around").hover(function(){
                $(".blackCoat",this).fadeToggle(200);
        });
});

function showExplanation(){
    document.getElementById("explanation").style.visibility="visible";
}


function hideExplanation(){
    document.getElementById("explanation").style.visibility="hidden";
}