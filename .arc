@app
rubyoauth

@aws
runtime ruby2.5
bucket cf-sam-deployments-east

@cdn
@static
@http
get /login
post /logout
get /account

@tables
accounts
  accountID *String
  ttl TTL
