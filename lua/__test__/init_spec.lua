local lima = dofile('lua/lima/init.lua')

describe('Init tests', function()
    local function test_delay(value, exp_value)
        lima.setup({ delay = value })
        assert(lima.delay == exp_value)
    end

    it('Setup test', function()
        test_delay(nil, 500)
        test_delay(1000, 1000)
        test_delay('foo', 1000)
    end)
end)
