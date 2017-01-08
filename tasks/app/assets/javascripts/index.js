function SetUpRNHandler(id){

  function toggle(o){
    if(o.renaming){
      o.value = "Rename";
      el.rename
    } else {
      o.value = "Cancel";
    } 
    o.namediv.style.display = o.renaming ? 'inline' : 'none';
    o.rename.style.display = o.renaming ? 'none' : 'inline';
    o.renaming=!o.renaming;
  };
  var el = $('#rbutton'+id)[0];
  el.namediv = $('#name'+id)[0];
  el.rename = $('#rename'+id)[0];
  el.renaming=false; 
  el.onclick = function(){ toggle(el); };
};

