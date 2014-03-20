
require 'pi_piper'
include PiPiper
require 'rubygems'
require 'json'
require 'net/https'
require './authenticate.rb'
require './eyehub_api.rb'
require './heating_manager.rb'
require './heating_controller.rb'

# PiPiper uses the BCM GPIO pin numbering scheme;
#   see https://projects.drogon.net/raspberry-pi/wiringpi/pins/

PIR_ON_THRESHOLD = 6
bcm_pin_num_pir     =  4  # GPIO7 physical pin  7
 
@pir     = PiPiper::Pin.new(:pin => bcm_pin_num_pir, :direction => :in, :pull => :up)

@heating_controller = HeatingController.new
@heating_manager = HeatingManager.new(@heating_controller)

90.times do |min|
  is_on_seconds = 0
  60.times do |s|
    is_on = 0
    10.times do |sub_s|
      @pir.read
      is_on = 1  if @pir.value == 1
      sleep(0.1)
    end
    is_on_seconds += is_on
    print "#{is_on == 1 ? '*' : '.'} "
    @heating_manager.heating_requested = File.exist?('./req')
  end
  if is_on_seconds >= PIR_ON_THRESHOLD
     print "sending event (payload: #{is_on_seconds})"
     send_event("person_sensor02", INPUT, is_on_seconds)
  end
  @heating_manager.person_present = (is_on_seconds >= PIR_ON_THRESHOLD)
  puts
end


