<img src="/Resources/Icon.png" width="470" />

For a detail information about using "Cacher", checkout the article ["Caching anything in iOS"](https://medium.com/ios-os-x-development/caching-anything-in-ios-102176e46eba).

## Installation

### Manual

Drag and drop the `Cacher/` folder into your project.

### Carthage

Add the following to your Cartfile:

``` ruby
github "raulriera/Cacher"
```

## How to use them

For a quick TL;DR check out the sample project at `CacherDemo`. It will guide you with the simplest caching possible, persisting string values.

If you like to get your hands dirty, continue reading as we are going to go into detail about how this works.

``` swift
public protocol Cachable {
	var fileName: String { get }
	func transform() -> Data
}
```

It all comes down to this simple protocol, that has only two requirements `fileName` which represents the unique name to store in the filesystem, and `transform` which is the `Data` representation of what you wish to import. Using the magic of Swift 4 `Codable`, we can skip the `transform` implementation and use the implicit one declared [right here](/blob/master/Cacher/Cacher.swift#L83).

After we implement conform to `Cachable` and `Codable`, anything can be stored in the filesystem using the `persist:item:completion` method.

But, let's see a more complex example

```swift
struct CachableMovies: Cachable, Codable {
	let store: String
	let movies: [Movie]

	var fileName: String {
		return "movies-\(store)"
	}

	init(store: String, movies: [Movie]) {
		self.store = store
		self.movies = movies
	}
}

struct Movie: Codable {
  enum CodingKeys : String, CodingKey {
  		case title = "movie_title"
  		case description = "movie_description"
  		case url = "movie_url"
  }

  let title: String
  let description: String
  let url: URL
}
```

The previous code is all we need to store a collection of movies into the filesystem. 🎉

## Created by
Raul Riera, [@raulriera](http://twitter.com/raulriera)
