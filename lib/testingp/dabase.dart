// @Entity()
// class User {
//   int id;
//   String name;
//   String email;
//   String password;
//   String preferences;
//   ToMany<TravelHistory> travelHistory;

//   User({this.id = 0, required this.name, required this.email, required this.password, this.preferences = ''});
// }

// @Entity()
// class Bus {
//   int id;
//   String busNumber;
//   String direction;
//   int capacity;
//   ToOne<Location> currentLocation;
//   String status;

//   Bus({this.id = 0, required this.busNumber, required this.capacity, required this.currentLocation, this.status = 'active'});
// }

// @Entity()
// class Route {
//   int id;
//   String routeName;
//   String stops;
//   double distance;
//   double estimatedTravelTime;

//   Route({this.id = 0, required this.routeName, required this.stops, required this.distance, required this.estimatedTravelTime});
// }

// @Entity()
// class Schedule {
//   int id;
//   ToOne<Route> routeId;
//   ToOne<Bus> busId;
//   DateTime departureTime;
//   DateTime arrivalTime;

//   Schedule({this.id = 0, required this.routeId, required this.busId, required this.departureTime, required this.arrivalTime});
// }

// @Entity()
// class Location {
//   int id;
//   double latitude;
//   double longitude;
//   DateTime timestamp;

//   Location({this.id = 0, required this.latitude, required this.longitude, required this.timestamp});
// }

// final store = Store(getObjectBoxModel());

// final userBox = store.box<User>();
// final busBox = store.box<Bus>();
// final routeBox = store.box<Route>();
// final scheduleBox = store.box<Schedule>();
// final locationBox = store.box<Location>();

// // Example: Adding a new user
// userBox.put(User(name: 'John Doe', email: 'john@example.com', password: 'password123'));
