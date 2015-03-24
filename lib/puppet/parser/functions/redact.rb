module Puppet::Parser::Functions
  newfunction(:redact) do |args|
    require "net/http"

    node_certname = args[0]
    fact_name = args[1]
    fact_value = "<REDACTED>"

    uri = URI.parse("http://localhost:8080")
    params = "{\"command\":\"replace facts\",\"version\":3,\"payload\":{\"name\":\"#{node_certname}\",\"environment\":\"DOES NOT MATTER\",\"values\":{\"#{fact_name}\":\"#{fact_value}\"}}}"
    net = Net::HTTP.new(uri.host, uri.port)

    request = Net::HTTP::Post.new("/v3/commands",
	 initheader = {'Content-Type' =>'application/json','Accept' => 'application/json'})
    request.set_form_data('payload'=>"#{params}")

    #net.set_debug_output $stdout #useful for debugging
    response = net.start do |http|
      http.request(request)
    end
  end
end
