require 'cgi'
require 'json'
require 'architect/functions'

def headers
  {'cache-control': 'no-cache, no-store, must-revalidate, max-age=0, s-maxage=0',
  'content-type': 'application/json'}
end

# looks up the account by the idx cookie
def handler(req)
  cookie = req[:event]['headers'] and req[:event]['headers']['Cookie']
  if cookie
    raw = CGI::parse(req[:event]['headers']['Cookie'])
    idx = raw.key?('idx')
    if idx
      accountID = raw['idx'][0]
      authorized(accountID)
    else
      unauthorized()
    end
  else
    unauthorized()
  end
rescue StandardError=> e
  puts e.message
  unauthorized()
end

# returns the account
def authorized(accountID)
  accounts = Arc::Tables.table(tablename: 'accounts')
  result = accounts.get_item({key: {accountID: accountID}})
  account = result.item.to_h
  account.delete('token')
  {statusCode: 200, headers: headers, body: account.to_json}
end

# returns href to the login url
def unauthorized
  client_id = ENV['GITHUB_CLIENT_ID']
  redirect_uri = ENV['GITHUB_REDIRECT']
  base = "https://github.com/login/oauth/authorize"
  href = "#{base}?client_id=#{client_id}&redirect_uri=#{redirect_uri}" 
  res = {href: href} 
  {statusCode: 403, headers: headers, body: res.to_json}
end
