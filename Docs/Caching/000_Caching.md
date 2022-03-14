# Caching

- 

There are many differents ways to provide caching functionalities in a iOS mobile app at different levels.

- URLCache
- DataResponse cache saving on disk
- Data caching into a db, using CoreData for example
- ...

For the sake of the Take-Home assignment I decided to first provide caching at the level of the network request. 

The first caching functionality uses a custom extension of URLSession that relies on URLCache to return a cached response in case of network request error.

This method relies on the cache-control headers being correctly set up in the backend service and the cache will be deleted if the device memory is full.

As a second and more reliable caching functionality, I integrated a CacheManager that saved the data responses to disk and loads them when the requests are failing.