# Shiki

TODO

## Environment

See `/.mise.toml`

## Launch
1. Add environments for oauth
```
export TUIST_OAUTH2_CLIENT_ID=******
export TUIST_OAUTH2_CLIENT_SECRET=******
```
  
  You can register the application [here](https://shikimori.one/oauth/applications). The Redirect URI must be `dev.nedstar.shiki://oauth`

2. `tuist install`
3. `tuist generate`
