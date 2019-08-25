require 'cgi'
require 'json'
require 'securerandom'
require 'net/http'
require 'architect/functions'

# performs the oauth handshake and saves the result in dynamodb
# redirects to / setting a cookie for the session
# sessions expire after a week of inactivity
def handler(req)
  params = valid(req)
  if params
    token = getAccessToken(params)
    account = getAccount(token)
    cookie = saveAccount(account)
    home cookie
  else
    home
  end
rescue StandardError=> e
  puts e.message
  puts e.inspect
  home
end

# returns a lambda response
def home(cookie)
  if cookie.nil?
    {statusCode: 302, headers: {location: '/'}}
  else
    {statusCode: 302, headers: {'set-cookie': cookie, 'location': '/'}}
  end
end

# returns {client_id, client_secret, code} OR false
def valid(req)
  qs = req[:event]['queryStringParameters'] and req[:event]['queryStringParameters']['code']
  if qs
    client_id = ENV['GITHUB_CLIENT_ID']
    client_secret = ENV['GITHUB_CLIENT_SECRET']
    code = req[:event]['queryStringParameters']['code']
    {client_id: client_id, client_secret: client_secret , code: code}
  else
    false
  end
end

# read access_token from github
def getAccessToken(params)
  url = 'https://github.com/login/oauth/access_token'
  uri = URI(url)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  req = Net::HTTP::Post.new(uri.path, {'Content-Type':'application/json'})
  req['Accept'] = 'application/json'
  req.body = params.to_json
  res = http.request(req)
  tmp = JSON.parse(res.body)
  tmp['access_token']
end

# read the account from github
# - removes nils and empty strings
# - adds ttl
# - adds accountID
# - adds token
def getAccount(token)
  uri = URI.parse("https://api.github.com/user?access_token=#{token}")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  req = Net::HTTP::Get.new(uri.request_uri, {'Content-Type':'application/json'})
  req['Accept'] = 'application/json'
  res = http.request(req)
  tmp = JSON.parse(res.body)
  # add the access token to the payload
  tmp['token'] = token
  tmp['accountID'] = SecureRandom.uuid
  tmp['ttl'] = Time.now.to_i + 604800 # expire a week from now
  # remove nils
  tmp2 = tmp.delete_if {|k, v| v.nil?}
  # remove empty strings
  tmp2.delete_if {|k, v| v.respond_to?(:empty?)? v.empty? : false}
end

# writes the account to dynamo and returns a cookie string
def saveAccount(account)
  accounts = Arc::Tables.table(tablename: 'accounts')
  accounts.put_item({item: account})
  cookie = CGI::Cookie.new(
    'name'=> 'idx', 
    'value'=> [account['accountID']], 
    'path'=> '/', 
    'expires'=> Time.now + 604800,
    'secure'=> true, 
    'httponly'=> true)
  cookie.to_s
end
