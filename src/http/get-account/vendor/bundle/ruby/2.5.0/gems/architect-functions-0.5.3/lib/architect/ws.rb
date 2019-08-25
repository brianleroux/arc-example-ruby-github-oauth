require 'aws-sdk-apigateway'
require 'net/http'
require 'json'

require_relative 'reflect'

module Arc
  module WS 
    ##
    # send a message to a web socket
    #
    def self.send(id:, payload:)
      if ENV['NODE_ENV'] == 'testing'
        headers = {'content-type':'application/json'}
        uri = URI('https://localhost:3333/__arc')
        http = Net::HTTP.new(uri.host, uri.port)
        req = Net::HTTP::Post.new(uri.path, headers)
        req.body = payload.to_json
        http.request(req).read_body
      else
        arc = Arc.reflect
        url = arc['ws']['https']
        api = Aws::ApiGatewayManagementApi::Client.new({endpoint: url})
        api.postToConnection({
          connection_id: id,
          data: JSON.stringify(payload)
        })
      end
    end
  end
end
