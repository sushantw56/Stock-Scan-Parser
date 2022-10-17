# Stock Scan Parser

A Stock Scan Parser project created in flutter using Getx and MVC architecture. Stock Scan Parser supports mobile application.

## How to Use 

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/sushantw56/Stock-Scan-Parser.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

## Stock Scan Parser Features:

* Home
* API integration using http
* State Management using Getx
* MVC Architecture

### Libraries & Tools Used

* [http](https://pub.dev/packages/http) (To Make API Calls)
* [get](https://pub.dev/packages/get) (State Management)
* [fluttertoast](https://pub.dev/packages/fluttertoast) (Show Toast Messages)
* [quicktype.io](https://quicktype.io/) (Generate models and serializers from JSON)

### Folder Structure
Here is the core folder structure which flutter provides.

```
stock_scan_parser/
|- android
|- build
|- ios
|- lib
|- test
```

Here is the folder structure we have been using in this project

```
lib/
|- api/
|- bindings/
|- controllers/
|- models/
|- utils/
|- views/
|- main.dart
```

Now, lets dive into the lib folder which has the main code for the application.

```
1- api - All the network requests are handled in the folder.
2- bindings - Dcouples dependency injection, while "binding" routes to the state manager and dependency manager.
3- controllers - All the business logic is written in this folder.
4- models - Generated classes for the json data received form network requests.
5- util  - Contains the utilities/routes/common functions for the appliction.
6- views- Contains the UI files.
7- main.dart - This is the starting point of the application. All the application level configurations are defined in this file.
```

### API

This directory contains the network requets required for the application. The files in this folder are mentioned below:

```
api/
|- stocks_api.dart
```

### Bindings

Depenedency injections and bindings to a page are in this folder.

```
bindings/
|- home_binding.dart
```

### Controllers

The Business logic is written in the files in this folder.

```
controllers/
|- stocks_controller.dart
```

### Models

Dart Classes are generated from json data and stored in this folder.

```
models/
|- stocks_data_model.dart
```

### Utils

Contains the utilities/routes/common functions for the appliction. The folder structure is as follows:

```
utils/
|- dotted_divider.dart
|- enum.dart
|- http_service.dart
|- routes.dart
|- theme.dart
```

### Views

Contains the UI files. The folder Structure is as follows:

```
views/
|- home_view.dart
|- indicator_type_view.dart
|- stock_details_view.dart
|- value_type_view.dart
```

### Main

This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stock_scan_parser/utils/theme.dart';

import 'utils/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]) //this is to setup device orientation of the app
      .then((_) {
    runApp(const Root());
  });
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialRoute: AppRoutes.home,
      getPages: listOfPages,
      theme: customTheme(),
    );
  }
}
```
