class ConvertReportTracker
  constructor: ->
    @bindClickEvents()

  bindClickEvents: ->
    links = @findLinks()

    for link in links
      do (link) =>
        @addEventToNode link, 'click', @trackClick

    forms = @findForms()

    for form in forms
      do (form) =>
        @addEventToNode form, 'submit', @trackClick

  addEventToNode: (node, event, callback)->
    if node.addEventListener
      node.addEventListener event, callback, true
    else if node.attachEvent
      node.attachEvent "on#{event}", callback

  findLinks: ->
    document.querySelectorAll 'a[data-cr-id]'

  findForms: ->
    document.querySelectorAll 'form[data-cr-id]'

  trackClick: (e)->
    id = e.target.attributes["data-cr-id"]?.value
    return unless id?

    request = new XMLHttpRequest
    request.open "post", "@@PROTOCOL://@@HOST/conversions", false
    request.setRequestHeader "Content-Type", "application/json;charset=UTF-8"
    request.send JSON.stringify { conversion: { tracking_id: id} }

window.onload = (e)->
  new ConvertReportTracker
