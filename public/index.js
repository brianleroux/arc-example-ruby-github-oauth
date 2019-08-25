async function main() {
  try {
    let path = window.location.pathname
    let base = path === '/staging' || path === '/production'? window.location.pathname : ''
    let url = `${base}/account`
    let res = await fetch(url)
    if (res.status === 403) {
      let {href} = await res.json()
      await Login(href) 
    }
    else if (res.status === 200) {
      let account = await res.json()
      await Account(account) 
    }
    else {
      throw Error('unknown')
    }
  }
  catch(e) {
    console.log('failed!', e)
  }
}

async function Login(href) {
  document.querySelector('main').innerHTML = `<a href=${href}>login</a>`
}

async function Account(account) {
  document.querySelector('main').innerHTML = `
    <h2>${account.name || account.login}</h2>
    <img src=${account.avatar_url}>
    <form method=post action=/logout>
      <button type=submit>logout</button>
    </form>
  `
}

main()
