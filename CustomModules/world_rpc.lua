local nakama = require("nakama")

local function find_or_create_match( context, payload )

    local json = nakama.json_decode(payload)
	local matches = nakama.match_list(json.limit, true, nil, json.min_size, json.max_size, json.query)

    if (#matches > 0) then
        table.sort(
            matches,
            function(a, b)
                return a.size > b.size
            end
        )
        return matches[1].match_id
    else
        print('Could not find matching matches.')
        return nakama.match_create("world_match", json)
    end
end

nakama.register_rpc(find_or_create_match, "find_or_create_match")