# Jackal

A simple tool to list all the PRs available in certain repositories.
Saves you time when you are working on/has to be aware of several projects at the same time.


## Installation

Install it yourself as:

    $ gem install merrow


## Configuration

Jackal reads a list of repositories and an access tocken from the ~/.merrow.yml file.
The file looks like this:

---
repos:
- mdsol/kender
- Railsmania/capistrano3-copy
- rails/rails
access_token: mylongaccesstokenwouldbewrittendowninhere


Add as many repos as you want, if you do not know how to make an access token, do not worry about that. Only add your repos, Jackal will generate one and write it down in the config file for you the first time it is executed

## Usage

Hopefully binaries of your gems are in your PATH, then just execute:

```
merrow
```


## Contributing

1. Fork it ( https://github.com/JordiPolo/merrow/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
