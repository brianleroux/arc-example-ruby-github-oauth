def handler(req)
  cookie = 'idx=deleted; path=/; expires=Thu, 01 Jan 1970 00:00:00 GMT'
  {statusCode: 302, headers: {'location': '/', 'set-cookie': cookie}}
end
