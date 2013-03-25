# Redlink

A gem providing a ruby API for controlling Honeywell Redlink-based home heating and cooling products.

# Status

Basic location & thermostat discovery functional. Ability to refresh thermostat data functional. Super alpha quality code.

# Prerequisites

* A valid Redlink App ID. You'll have to find one on your own.
* A valid login at https://rs.alarmnet.com/TotalConnectComfort/.

# Getting Started

1. Clone the gem with `gem install redlink`.
2. Initialize your environment with the app id via `redlink init 9RS79360-PO1R-4P6S-O20S-7N5Q37N028PO`. _(Note: not a real app id)_
3. Provide credentials to the environment via `redlink login username@host.com password`.

# Usage

Redlink provides a basic CLI experience as well as a growing set of APIs for actual manipulation.

`redlink locations` - returns a list of locations and thermostats connected to your account

```
redlink$ redlink locations

309 Alden St - 50° NightPartlyCloudy
  Office - 68° / 62.0°
  Media Room - 73° / 73.0° (heating via override)
  Front Room - 69° / 62.0°
  Dining Room - 70° / 70.0°
  Bedroom - 74° / 74.0°
```

# TODO

* Documentation
* Testing
* Ability to set thermostats
* Ability to alter schedules
* Vacation mode

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
