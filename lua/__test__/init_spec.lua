local lima = dofile('lua/lima/init.lua')

describe('Init tests', function()
    local function test_delay(value, exp_value)
        lima.setup({ delay = value })
        assert(lima.delay == exp_value)
    end

    it('Setup test', function()
        test_delay(nil, 300)
        test_delay(500, 500)
        test_delay('foo', 500)
    end)
end)
