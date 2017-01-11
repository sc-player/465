function SetUpRNHandler(id){

  function toggle(o){
    if(o.renaming){
      o.value = "Rename";
      $(o.rename).find("input[type=text]").val(o.namediv.innerHTML.trim());
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
  el.renameButton=$(el.rename).find("input[type=submit]")[0];
  el.renameInput=$(el.rename).find("input[type=text]")[0];
  el.renaming=false; 
  el.onclick = function(){ toggle(el); };
  el.renameButton.onclick = function(){
    el.namediv.innerHTML=el.renameInput.value;
    toggle(el);
  };
};

