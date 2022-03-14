# Walkthrough

A Project Walkthrough to learn the structure of the project, in order to be able to navigate between the different modules and to find easily the wanted components.

We start from the project App class, "KrakenDemoAppApp". The app shows a LaunchScreen view while behind of it the main app composition root class, "AppCompositionRoot", started already the composition of the app by building a TabBar view with the injected tabs.

The first tab is the home view, "KrakenHomeView". This file can be found under "Presentation/Scenes/Home" together with its sub views, its view model and its DI container assembler.

The assembler creates and injects all the dependencies for the scene: 

- creates an api client ("KrakenApi") 
- injects the api client into the repository gateway ("KrakenRepository")
- injects the gateway into the use cases ("LoadTradingAssetPairsUseCase" and "LoadTickerUseCase")
- injects the use cases into the view model ("KrakenHomeViewModel")
- injects the view model into the view ("KrakenHomeView")
- finally returns the created view object

The view model setups the presentation logic by running the redux "transform" method that configures the "output" dependencies from the "input" triggered events.



<sub>[**back**](https://github.com/CS-Development/KrakenDemo)</sub>