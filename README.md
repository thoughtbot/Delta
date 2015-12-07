# Delta

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Managing state is hard. Delta aims to make it simple.

Delta takes an app that has custom state management spread throughout all the VCs
and simplifies it by providing a simple interface to change state and subscribe
to its changes.

It can be used standalone or with your choice of reactive framework
plugged in. We recommend using a reactive framework to get the most value.

## Source Compatibility ##

The source on `master` assumes Swift 2.1

## Framework Installation ##

### [Carthage] ###

[Carthage]: https://github.com/Carthage/Carthage

```
github "thoughtbot/Delta"
```

Then run `carthage update`.

Follow the current instructions in [Carthage's README][carthage-installation]
for up to date installation instructions.

[carthage-installation]: https://github.com/Carthage/Carthage#adding-frameworks-to-an-application

## Usage

- [Getting Started]
- [Using Reactive Extensions][Using RX]
- [API Documentation]

[Getting Started]: ./documentation/getting-started.md
[Using RX]: ./documentation/reactive-extensions.md
[API Documentation]: https://thoughtbot.github.io/Delta

## Contributing

See the [CONTRIBUTING] document.
Thank you, [contributors]!

  [CONTRIBUTING]: CONTRIBUTING.md
  [contributors]: https://github.com/thoughtbot/Delta/graphs/contributors

## License

Delta is Copyright (c) 2015 thoughtbot, inc.
It is free software, and may be redistributed
under the terms specified in the [LICENSE] file.

  [LICENSE]: /LICENSE

## About

Delta is maintained by Jake Craige.

![thoughtbot](https://thoughtbot.com/logo.png)

Delta is maintained and funded by thoughtbot, inc.
The names and logos for thoughtbot are trademarks of thoughtbot, inc.

We love open source software!
See [our other projects][community]
or [hire us][hire] to help build your product.

  [community]: https://thoughtbot.com/community?utm_source=github
  [hire]: https://thoughtbot.com/hire-us?utm_source=github
