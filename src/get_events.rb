#!/usr/bin/ruby
# Simple example script to retrieve the events for the device
# named in DEVICE_ID using the EyeHub API

require 'rubygems'
require './authenticate.rb'
require './eyehub_api.rb'
require 'pp'

def display_event(uri_string)
  #puts uri_string
  event = get_uri(uri_string)
  #pp event
  puts " #{event["id"]}, #{event["displayTimeStamp"]}, #{event["source"]}, #{event["payload"]}, #{event["type"]<=0.01 ?"output":"input" }"
end

# Now let's get a list of just the events
uri = "https://hub.flexeye.com/v1/iot_Default/dms/#{DEVICE_MANAGER_ID}/devices/#{DEVICE_ID}/events"
puts "Retrieving a list of events from\n #{uri} ..."
event_details = get_uri(uri)

puts "Number of events found: "+event_details["events"].count.to_s
# And output some info for each event we found
event_details["events"].each do |event|
  display_event(event["uri"])
end

