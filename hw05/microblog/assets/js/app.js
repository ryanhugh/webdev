// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

import socket from "./socket"

let handlebars = require("handlebars");

$(function() {
  if (!$("#likes-template").length > 0) {
    return;
  }

  let tt = $($("#likes-template")[0]);
  let code = tt.html();
  let tmpl = handlebars.compile(code);

  let dd = $($("#post-likes")[0]);
  let path = dd.data('path');
  let p_id = dd.data('post_id');

  let bb = $($("#like-add-button")[0]);
  let u_id = bb.data('user-id');

  let likesData = []
  let likeMap = {}

  function fetch_likes() {
    function got_likes(data) {
      console.log(data);
      likesData = data;

      likeMap={}

      for (var i = 0; i < data.data.length; i++) {
        likeMap[data.data[i].user_email] = data.data[i]
      }

      data.data = Object.values(likeMap)

      if (likeMap[window.currUserEmail]) {
       $("#unlike-button").show()
      $("#like-add-button").hide() 
      }
      else {
        $("#unlike-button").hide()
        $("#like-add-button").show()
      }

      let html = tmpl(data); 
      dd.html(html);
    }

    $.ajax({
      url: path,
      data: {liked_post_id: p_id},
      contentType: "application/json",
      dataType: "json",
      method: "GET",
      success: got_likes,
    });
  }

  function add_like() {
    let data = {like: {liked_post_id: p_id, user_id: u_id}};


    $("#like-add-button").hide()
    $("#unlike-button").show()

    $.ajax({
      url: path,
      data: JSON.stringify(data),
      contentType: "application/json",
      dataType: "json",
      method: "POST",
      success: fetch_likes,
    });

  }

  function delete_like() {

    $("#unlike-button").hide()
    $("#like-add-button").show()


    $.ajax({
      url: path + '/' + likeMap[window.currUserEmail].id,
      contentType: "application/json",
      dataType: "json",
      method: "DELETE",
      success: fetch_likes,
    });

  }

  bb.click(add_like);

  $("#unlike-button").click(delete_like)

  fetch_likes();
});
