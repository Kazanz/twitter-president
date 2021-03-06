ready = ->
    window.updateMapData = (msg) ->
        if not MAP_DATA[msg.name]
            MAP_DATA[msg.name] = {}
        if not MAP_DATA[msg.name][msg.state]
            MAP_DATA[msg.name][msg.state] = {}
        MAP_DATA[msg.name][msg.state]["sentiment"] = parseFloat(msg.sentiment)
        MAP_DATA[msg.name][msg.state]["total_tweets"] = parseInt(msg.total_tweets)
        if window.current_candidate == msg.name
            window.render_map(msg.name)
        window.render_recent_tweet(msg)
        return MAP_DATA


    window.socket = io.connect('http://' + document.domain + ':' + location.port + NAMESPACE)

    # This function does nothing but is needed to make socketio work.
    window.socket.on('connect', -> return)

    window.socket.on(MSG_NAME, window.updateMapData)


$(document).ready(ready)
$(document).on('page:load', ready)
