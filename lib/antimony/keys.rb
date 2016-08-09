module Antimony
  module Keys

    def enter
      send_key("\n")
    end

    def tab
      send_key("\t")
    end

    def backspace(count = 1)
      send_key("\177", count)
    end

    def arrow_up(count = 1)
      send_key("\e[A", count)
    end

    def arrow_down(count = 1)
      send_key("\e[B", count)
    end

    def arrow_right(count = 1)
      send_key("\e[C", count)
    end

    def arrow_left(count = 1)
      send_key("\e[D", count)
    end

    def f1(count = 1)
      send_key("\x1B\x31", count)
    end

    def f2(count = 1)
      send_key("\x1B\x32", count)
    end

    def f3(count = 1)
      send_key("\x1B\x33", count)
    end

    def f4(count = 1)
      send_key("\x1B\x34", count)
    end

    def f5(count = 1)
      send_key("\x1B\x35", count)
    end

    def f6(count = 1)
      send_key("\x1B\x36", count)
    end

    def f7(count = 1)
      send_key("\x1B\x37", count)
    end

    def f8(count = 1)
      send_key("\x1B\x38", count)
    end

    def f9(count = 1)
      send_key("\x1B\x39", count)
    end

    def f10(count = 1)
      send_key("\x1B\x30", count)
    end

    def f11(count = 1)
      send_key("\x1B\x2D", count)
    end

    def f12(count = 1)
      send_key("\x1B\x3D", count)
    end

    def f13(count = 1)
      send_key("\x1B\x21", count)
    end

    def f14(count = 1)
      send_key("\x1B\x40", count)
    end

    def f15(count = 1)
      send_key("\x1B\x23", count)
    end

    def f16(count = 1)
      send_key("\x1B\x24", count)
    end

    def f17(count = 1)
      send_key("\x1B\x25", count)
    end

    def f18(count = 1)
      send_key("\x1B\x5E", count)
    end

    def f19(count = 1)
      send_key("\x1B\x26", count)
    end

    def f20(count = 1)
      send_key("\x1B\x2A", count)
    end

    def f21(count = 1)
      send_key("\x1B\x28", count)
    end

    def f22(count = 1)
      send_key("\x1B\x29", count)
    end

    def f23(count = 1)
      send_key("\x1B\x5F", count)
    end

    def f24(count = 1)
      send_key("\x1B\x2B", count)
    end

  end
end