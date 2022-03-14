# Caching

There are many differents ways to provide caching functionalities in a iOS mobile app at different levels.

- URLCache
- DataResponse cache saving on disk
- Data caching into a db, using CoreData for example
- ...

For the sake of the Take-Home assignment I decided to first provide caching at the level of the network request. 

The first caching functionality uses a custom extension of URLSession that relies on URLCache to return a cached response in case of network request error.

This method relies on the cache-control headers being correctly set up in the backend service and the cache will be deleted if the device memory is full.

As a second and more reliable caching functionality, I integrated a CacheManager that saves the data responses to disk and loads them when the requests are failing.



## Other possible solutions

If we had other requirements, if we needed for example to cache also user's data, then we could have implemented a persistance layer with Core Data and used it to save the businness objects to the db. A syncing policy would have then allowed to keep the remote data and the local data in sync. For example, just wiping out the local cache when a new remote collection of data comes, or merging the two.

In such a case an elegant solition is to use a mix of the **Repository** and of the **Composition** patterns.

#### Repository pattern

With the Repository pattern we have basically a single interface, the Repository gateway. Then we have to concrete implementations, a remote repository and a local repository, that are conforming to the same interface. In this way the client doesn't know where the data are coming from, they can be either from one or the other.

protocol RepositoryType {

​	func fetchData() -> Publisher<Data, Error>

}

class RemoteRepository: ReposityType {

​	func fetchData() -> Publisher<Data, Error> {

​			// return a publisher of remote fetched Data

​	}

}

class LocalRepository: ReposityType {
	var cache: Data

​	func fetchData() -> Publisher<Data, Error> {

​			// return a publisher of local fetched Data

​	}

}

#### Composition pattern

With the Composition pattern we can combine the two repository and decide the strategy to use. For example, loading first from remote and from local only if the remote fails.

class RemoteThanLocal: ReposityType {

​	let local: LocalRepository
​	let remote: RemoteRepository

​	func fetchData() -> Publisher<Data, Error> {

​			return Publishers.Concatenate(
​					prefix: remote.fetchData()

​							.handleEvents(receiveOutput: {

​								self.local.cache = data

​							}),
​					suffix: local.fetchData()
​			).eraseToAnyPublisher()

​	}

}





<sub>[**back**](https://github.com/CS-Development/KrakenDemo)</sub>

