local result = get("result")

local width = 40
local height = 20
local snake = {{10, 10}, {10, 9}, {10, 8}}
local direction = {0, 1}
local food = {5, 5}
local function clear_screen()
    result.set_content("")
end
print(0)
local clock = os.clock
print(1)
function sleep(n)
    print(2)
    local t0 = clock()
    print(3)
    while clock() - t0 <= n do end
end

function wait(seconds)
    local start = os.time()
    repeat until os.time() > start + seconds
end
local function print_board()
    clear_screen()
    for y = 0, height - 1 do
        for x = 0, width - 1 do
            local is_snake = false
            for _, segment in ipairs(snake) do
                if segment[1] == y and segment[2] == x then
                    is_snake = true
                    break
                end
            end
            if is_snake then
                result.set_content(result.get_content() .. "#")
            elseif y == food[1] and x == food[2] then
                result.set_content(result.get_content() .. "*")
            else
                result.set_content(result.get_content() .. " ")
            end
        end
        result.set_content(result.get_content() .. "\n")
    end
end

local function update_snake()
    local new_head = {snake[1][1] + direction[1], snake[1][2] + direction[2]}
    if new_head[1] < 0 or new_head[1] >= height or new_head[2] < 0 or new_head[2] >= width then
        result.set_content("Game Over!\n")
        os.exit()
    end
    for _, segment in ipairs(snake) do
        if segment[1] == new_head[1] and segment[2] == new_head[2] then
            result.set_content("Game Over!\n")
            os.exit()
        end
    end
    table.insert(snake, 1, new_head)
    if new_head[1] == food[1] and new_head[2] == food[2] then
        food = {math.random(height) - 1, math.random(width) - 1}
    else
        table.remove(snake)
    end
end

local function change_direction(new_direction)
    if new_direction[1] == -direction[1] and new_direction[2] == -direction[2] then
        return
    end
    direction = new_direction
end



local key_to_direction = {
    w = {-1, 0},
    s = {1, 0},
    a = {0, -1},
    d = {0, 1}
}

clear_screen()
while true do
    print(2)
    print_board()
    update_snake()
    sleep(0.5)
end
