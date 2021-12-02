local nakama = require("nakama")
local world_match = {}

local NakamaCodes = {
    hello = 1,
    movement = 2,
    action = 3,
    syncScreenLinkGet = 4,
    speed = 5,
    voiceAnimation = 6,
    voiceId = 7,
    syncScreenLinkSet = 8,
    fly = 9,
    broadcastVoice = 10,
    teleport = 11,
    marker = 12,
    summonAsk = 13,
    summonReject = 14,
    startscriptableevent = 15
}

local VideoState = {
    none = 1,
    play = 2,
    stop = 3
}

local commands = {}

function world_match.match_init(context, setupstate)
  local state = {
    presences = {},
    screens = {}
  }

  local label = {
        world = setupstate.label
  }

  local tickrate = 5
  local isAuthoritative = true
  local match_label = nakama.json_encode(label)
  local limit = setupstate.limit
  local min_size = setupstate.min_size
  local max_size = setupstate.max_size
  return state, tickrate, match_label
end

function world_match.match_join_attempt(context, dispatcher, tick, state, presence, metadata)
  if state.presences[presence.user_id] ~= nil then
	return state, false, "User already connected."
  end
  return state, true
end

function world_match.match_join(context, dispatcher, tick, state, presences)
  return state
end

function world_match.match_leave(context, dispatcher, tick, state, presences)
  return state
end

function world_match.match_loop(context, dispatcher, tick, state, messages)
  for _, message in ipairs(messages) do
    local code = message.op_code
    
    local decoded = nakama.json_decode(message.data)

    if code == NakamaCodes.hello then

        local presences = nil
        dispatcher.broadcast_message(NakamaCodes.hello, message.data, presences, message.sender)
    end

    if code == NakamaCodes.speed then

        local presences = nil
        dispatcher.broadcast_message(NakamaCodes.speed, message.data, presences, message.sender)
    end

    if code == NakamaCodes.movement then

        local presences = nil
        dispatcher.broadcast_message(NakamaCodes.movement, message.data, presences, message.sender)
    end

    if code == NakamaCodes.action then

        local presences = nil
        dispatcher.broadcast_message(NakamaCodes.action, message.data, presences, message.sender)
    end

    if code == NakamaCodes.voiceAnimation then

        local presences = nil
        dispatcher.broadcast_message(NakamaCodes.voiceAnimation, message.data, presences, message.sender)
    end

    if code == NakamaCodes.syncScreenLinkGet then

        for _, screen in ipairs(state.screens) do
            screen.CurrentNexusData.videodata.TimeCode = (nakama.time() - screen.CurrentNexusData.videodata.StartPlayTime) / 1000
        end
        
        local encoded = nakama.json_encode(state.screens)
        
        dispatcher.broadcast_message(NakamaCodes.syncScreenLinkGet, encoded, {message.sender}, message.sender)
    end

    if code == NakamaCodes.syncScreenLinkSet then

        state.screens[decoded.ScreenId] =  decoded
        state.screens[decoded.ScreenId].CurrentNexusData.videodata.StartPlayTime = nakama.time()
        state.screens[decoded.ScreenId].CurrentNexusData.videodata.State = decoded.CurrentNexusData.videodata.State
        local presences = nil
        dispatcher.broadcast_message(NakamaCodes.syncScreenLinkSet, message.data, presences, message.sender)
    end

    if code == NakamaCodes.voiceId then

        local presences = nil
        dispatcher.broadcast_message(NakamaCodes.voiceId, message.data, presences, message.sender)
    end

    if code == NakamaCodes.fly then
        local presences = nil
        dispatcher.broadcast_message(NakamaCodes.fly, message.data, presences, message.sender)
    end

    if code == NakamaCodes.broadcastVoice then
        local presences = nil
        dispatcher.broadcast_message(NakamaCodes.broadcastVoice, message.data, presences, message.sender)
    end

    if code == NakamaCodes.teleport then

        local presences = nil
        dispatcher.broadcast_message(NakamaCodes.teleport, message.data, presences, message.sender)
    end

    if code == NakamaCodes.marker then

        local presences = nil
        dispatcher.broadcast_message(NakamaCodes.marker, message.data, presences, message.sender)
    end

    if code == NakamaCodes.summonAsk then

        local presences = nil
        dispatcher.broadcast_message(NakamaCodes.summonAsk, message.data, presences, message.sender)
    end

    if code == NakamaCodes.summonReject then

        local presences = nil
        dispatcher.broadcast_message(NakamaCodes.summonReject, message.data, presences, message.sender)
    end
    
    if code == NakamaCodes.startscriptableevent then

        local presences = nil
        dispatcher.broadcast_message(NakamaCodes.startscriptableevent, message.data, presences, message.sender)
    end

  end
  return state
end

function world_match.match_terminate(context, dispatcher, tick, state, grace_seconds)
  screens = nil
  return state
end

return world_match