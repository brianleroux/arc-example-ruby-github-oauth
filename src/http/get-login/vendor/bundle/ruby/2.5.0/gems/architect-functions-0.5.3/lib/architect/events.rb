require 'aws-sdk-sns'
require 'net/http'
require 'json'

require_relative 'reflect'

module Arc
  module Events
    ##
    # publish a message to an SNS Topic
    #
    def self.publish(name:, payload:)
      if ENV['NODE_ENV'] == 'testing'
        headers = {'content-type':'application/json'}
        uri = URI('https://localhost:3334/events')
        http = Net::HTTP.new(uri.host, uri.port)
        req = Net::HTTP::Post.new(uri.path, headers)
        req.body = {'name': name, 'payload': payload}.to_json
        http.request(req).read_body
      else
        arc = Arc.reflect
        arn = arc['events'][name]
        sns = Aws::SNS::Client.new
        sns.publish({topic_arn: arn, message: JSON.generate(payload)})
      end
    rescue => e
      "arc.events.publish failed #{e}"
    end
  end
end
