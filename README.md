# DogsClient
A SwiftUI architectural research project that consumes https://dog.ceo/dog-api/

Basically an MVVMR architecture.

In a nutshell, MVVMR attempts complete separation of the view logic from business logic and navigational logic, while maintaining an experience as close as possible to vanilla SwiftUI navigation and data management.

The main components are: 

 - **View** - Describes the UI, should not contain any business logic at all
 - **ViewModel** - Defines data points for the view and the business logic,
   interacts with various services to access the necessary data
 - **Router** - Assembles the view and the view-model for a specified route 
 - **Services** - Encapsulate related logic relevant for a specific topic, like data
   fetching from a remote or local storage

![diagram (1)](https://user-images.githubusercontent.com/19331105/194241822-3d00c24b-d1af-4640-a547-4a08c5917618.jpg)

The View should depend on the RouterProtocol(or a more specialised protocol) and the ViewModelProtocol(or a more specialised protocol) not on the actual implementations to populate it with data and to define its destination(s).

### Routing
The routing UI is written in the View since the routing behaviour is tightly coupled with the view structure in SwiftUI.

The destination View for any route is defined in the Router together with its corresponding ViewModel.
So if, for example, ViewA wants to navigate to the ViewB, it asks RouterA for a view without explicitly knowing the type of the destination. 
The Router knows what view to return based on a Route, an enum describing the possible destinations. A route can optionally carry with it some data from ViewA to ViewB as its associated value.

So in order to have a working navigation 3 steps are required.

 1. Describe the navigation *UI* in the *View* (for example by adding a *NavigationStackView* or a *sheet* modifier to the view)
 2. Add a route *enum* conforming to the *RouteProtocol*
 3. Create a Router for your view and implement the necessary router protocol (NavigationRouterProtocol, ModalRouterProtocol or *TabRouterProtocol*)

### Dependencies
The dependencies are managed by a DIContainer. We can register dependencies in the DIContainer based on their corresponding protocol and resolve them from anywhere by accessing the singleton container DIContainer.shared. The DIContainer defined in this app, wraps [Swinject](https://github.com/Swinject/Swinject)'s Container.

The app registers all of the dependencies at launch using a Registerer. There are two types of registerers, one for the normal mode and another for the UITesting mode. 

![diagram (2)](https://user-images.githubusercontent.com/19331105/194247635-09536aff-2dec-4492-a8f7-60b9af1f5e15.jpg)

The app invokes a registerer based on the launch arguments (which would include "uitesting" in case of UITests)
