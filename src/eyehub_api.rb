require 'json'
require 'net/https'

def get_uri(uri_string)
  uri = URI.parse(uri_string)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  request = Net::HTTP::Get.new(uri.request_uri)
  request.basic_auth(EYEHUB_USERNAME, EYEHUB_PASSWORD)
  event_data = http.request(request)
  # The response is formatted in JSON
  JSON.parse(event_data.body)
end

def send_to_uri(uri_string, action, request_params = nil)
  # action: POST (or DELETE, TBD)
  uri = URI.parse(uri_string)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  request = Net::HTTP::Post.new(uri.request_uri)
  request.basic_auth(EYEHUB_USERNAME, EYEHUB_PASSWORD)
  # Add the parameters to the request, formatted as JSON
  request.body = request_params.to_json  if request_params
  # And tell the server that the data we're sending is formatted as JSON
  request["Content-Type"] = "application/json"
  # Now call the server
  http.request(request)
end
  
INPUT  = "1.0"
OUTPUT = "0.0"

def send_event(sensor, inOrOut, payload)
  request_params = {}
  request_params["source"] = sensor  # "/dms/#{DEVICE_MANAGER_ID}/devices/#{DEVICE_ID}/#{sensor}"
  request_params["payload"] = payload
  request_params["type"] = inOrOut   # INPUT or OUTPUT

  # Now call the EyeHub API
  event_direction = "events"  # "inEvents", "outEvents" or "events"
  uri_string = "https://hub.flexeye.com/v1/iot_Default/dms/#{DEVICE_MANAGER_ID}/devices/#{DEVICE_ID}/#{event_direction}"
  creation_result = send_to_uri(uri_string, "POST", request_params)
end


