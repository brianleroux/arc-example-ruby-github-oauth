require 'aws-sdk-sqs'
require 'net/http'
require 'json'

require_relative 'reflect'

module Arc
  module Queues 
    ##
    # publish a message to an SQS Queue
    #
    def self.publish(name:, payload:)
      if ENV['NODE_ENV'] == 'testing'
        headers = {'content-type':'application/json'}
        uri = URI('https://localhost:3334/queues')
        http = Net::HTTP.new(uri.host, uri.port)
        req = Net::HTTP::Post.new(uri.path, headers)
        req.body = {'name': name, 'payload': payload}.to_json
        http.request(req).read_body
      else
        arc = Arc.reflect
        url = arc['queues'][name]
        sqs = Aws::SQS::Client.new
        sqs.send_message({
          queue_url: url, 
          delay_seconds: 0, 
          message_body: JSON.generate(payload)
        })
      end
    end
  end
end
