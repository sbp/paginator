$ ->
  cache = ->
    children = body.children().detach()
    content = $("<div>").append(children)
  uncache = ->
    body.append content.children()
    content = false
  add_page = ->
    page = $("[data-id=" + location.hash + "]", content)
    return uncache()  unless page.size()
    body.append page.clone(true)
    $(window).scrollTop 0
  delete_page = ->
    body.empty()
  body = $("body")
  content = false
  $(window).hashchange ->
    source = (if content then "page" else "body")
    dest = (if location.hash then "page" else "body")
    switch [ source, dest ].toString()
      when [ "body", "page" ].toString()
        cache()
        add_page()
      when [ "page", "page" ].toString()
        delete_page()
        add_page()
      when [ "page", "body" ].toString()
        delete_page()
        uncache()

  $("[id]").each ->
    e = $(this)
    e.attr("data-id", "#" + e.attr("id")).removeAttr "id"

  $(window).hashchange()
