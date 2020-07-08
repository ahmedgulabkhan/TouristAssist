# TouristAssist
## About
TouristAssist is an app made using Flutter and Firebase which helps tourists to book local guides according to the current city they are present in. It shows a map of their current location and all the guides present in that area.

## Snapshots of the application

![Screenshots](/snapshots/snapshot2.jpeg)
![Screenshots](/snapshots/snapshot1.jpeg)
![Screenshots](/snapshots/snapshot4.jpeg)
![Screenshots](/snapshots/snapshot3.jpeg)

## Configuration Steps
1. Cloning the repository:

```
$ git clone https://github.com/ahmedgulabkhan/TouristAssist.git
```

2. Open the project and install dependencies (using terminal):

```
$ cd TouristAssist
$ flutter pub get
```
This installs all the required dependencies like cloud_firestore, firebase_auth, shared_preferences, flutter_map, geolocator, etc...

3. Make an android project on your firebase account, follow the mentioned steps and you're good to go.

4. Now run the app on your connected device (using terminal):

`$ flutter run`