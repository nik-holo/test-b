# README

## Setup
```shell
brew services install redis
brew services start redis

bundle install 

rails s
```

Try specs to make sure we're all set
```shell
rspec
```

Create link:
```shell
curl -X POST http://localhost:3000/links -H "Content-Type: application/json" -d '{"redirect_url": "http://google.com"}'
```
Recieve new link.

Copy and paste it to browser url.
Enjoy!
