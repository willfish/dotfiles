R = function(name)
    RELOAD(name)
    return require(name)
end

P = function(v)
    print(vim.inspect(v))
    return v
end

require("willfish")

require('willfish')
