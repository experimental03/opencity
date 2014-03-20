require 'pi_piper'
include PiPiper

class HeatingController
  def initialize
    #@bcm_pin_num_red_led = 22  # physical pin 15 (left red LED)
    @bcm_pin_num_red_led = 10  # physical pin 19 (right red LED)

    @pin_red_led = PiPiper::Pin.new(:pin => @bcm_pin_num_red_led, :direction => :out)
    @heating = false  # the current state
    output
  end

  def output
    @heating ? @pin_red_led.on : @pin_red_led.off
    @heating
  end

  def heating=(state)
    @heating = state
    output
  end

end
