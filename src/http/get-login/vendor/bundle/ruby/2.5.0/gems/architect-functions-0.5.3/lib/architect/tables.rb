require 'aws-sdk-dynamodb'

require_relative 'reflect'

module Arc
  module Tables

    ## 
    # returns Aws::DynamoDB::Table
    # https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/DynamoDB/Table.html
    #
    def self.table(tablename:)
      ddb = if ENV['NODE_ENV'] == 'testing' 
              Aws::DynamoDB::Resource.new :endpoint=> 'http://localhost:5000'
            else
              Aws::DynamoDB::Resource.new
            end
      ddb.table(Arc::Tables.name(tablename: tablename))
    end

    ## 
    # returns the physicalID for the given table name
    #
    def self.name(tablename:)
      if ENV['NODE_ENV'] == 'testing'
        tmp = "staging-#{tablename}"
        db = Aws::DynamoDB::Resource.new :endpoint=> 'http://localhost:5000'
        tbl = db.tables().detect {|e| e.name.include?(tmp)}
        tbl.name
      else
        arc = Arc.reflect
        arc['tables'][tablename]
      end
    end
  end
end
