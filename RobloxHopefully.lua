local function reverse(array)

    for i = 1, #array do
        array[i-#array] = array[i]
    end

    return array
end

local result = reverse({1, 2, 3})

for i, v in pairs(result) do
    print(i.."\n"..v)
end
