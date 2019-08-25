# arc-example-ruby-oauth

Example app combining backend Ruby Lambdas for Github oAuth with a vanilla static app.

### Step 0: prereq

Change the `bucket` in `.arc` and run `arc deploy` to establish the redirect urls. Cloudfront can take a few minutes so be patient.

### Step 1: register the app and get creds

https://developer.github.com/apps/building-oauth-apps/

### Step 2: save creds as env vars
```
arc env staging GITHUB_CLIENT_ID 111xxx
arc env staging GITHUB_CLIENT_SECRET 222xxx
arc env staging GITHUB_REDIRECT https://xxx.cloudfront.net/login
```

### Step 3: redeploy

Redploy by running `arc deploy` to see the new env variables take effect.
