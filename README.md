# Msig

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/msig`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'msig'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install msig

## Usage

```
$ bundle exec exe/msig /path/to/lockfile_service.json
```

produces:
```
METHOD get
# ==== Description
#
# Calling the method to acquire a new lock with a random uuid that will has an
# expiration date of 5 hours
#
# ==== Signature
#
# @author thomasf1234
# @return [PuppetUnit::Lock] a new lock object that expires in 5 hours


METHOD write
# ==== Description
#
# Serializes and writes a Lock instance to a file in marshal format.
#
# ==== Signature
#
# @author thomasf1234
# @arg1   [PuppetUnit::Lock]  lock instance to serialize to file
# @arg2   [String]            file path to write lockfile
# @return [Integer]           number of bytes written to lockfile_path
# @see    LockfileService#get


METHOD read
# ==== Description
#
# Call to read a lockfile created using LockfileService#write
#
# ==== Signature
#
# @author thomasf1234
# @arg1   [String]              file path to the lockfile
# @return [PuppetUnit::Lock]    the lock object that was serialized at lockfile_path
# @see    LockfileService#write


```

for lockfile_service.json:
```
{
  "methods":[
    {
      "name":"get",
      "description":
      [
        "Calling the method to acquire a new lock with",
        "a random uuid that will has an expiration date of 5 hours"
      ],
      "return":
      [
        {"type":"PuppetUnit::Lock", "description":"a new lock object that expires in 5 hours"}
      ],
      "author":"thomasf1234"
    },

    {
      "name":"write",
      "description":
      [
        "Serializes and writes a Lock instance to a file in marshal format."
      ],
      "args":
      [
        {"name": "lock", "type":"PuppetUnit::Lock", "description": "lock instance to serialize to file"},
        {"name": "lockfile_path", "type":"String", "description": "file path to write lockfile"}
      ],
      "return":
      [
        {"type":"Integer", "description":"number of bytes written to lockfile_path"}
      ],
      "author":"thomasf1234",
      "see":[
        "LockfileService#get"
      ]
    },

    {
      "name":"read",
      "description":
      [
        "Call to read a lockfile created using LockfileService#write"
      ],
      "args":
      [
        {"name": "lockfile_path", "type":"String", "description": "file path to the lockfile"}
      ],
      "return":
      [
        {"type":"PuppetUnit::Lock", "description":"the lock object that was serialized at lockfile_path"}
      ],
      "author":"thomasf1234",
      "see":[
        "LockfileService#write"
      ]
    }
  ]
}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/msig.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
# msig
