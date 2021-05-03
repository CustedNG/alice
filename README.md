<p align="center">
<img src="https://raw.githubusercontent.com/jhomlala/alice/master/media/logo.png">
</p>

# Alice

[![pub package](https://img.shields.io/pub/v/alice.svg)](https://pub.dartlang.org/packages/alice)
[![pub package](https://img.shields.io/github/license/jhomlala/alice.svg?style=flat)](https://github.com/jhomlala/alice)
[![pub package](https://img.shields.io/badge/platform-flutter-blue.svg)](https://github.com/jhomlala/alice)

Alice is an HTTP Inspector tool for Flutter which helps debugging http requests. It catches and stores http requests and responses, which can be viewed via simple UI. It is inspired from Chuck ( https://github.com/jgilfelt/chuck ).


<p align="center">
</p>
<table>
  <tr>
    <td>
		<img width="250px" src="https://raw.githubusercontent.com/jhomlala/alice/master/media/1.png">
    </td>
    <td>
       <img width="250px" src="https://raw.githubusercontent.com/jhomlala/alice/master/media/2.png">
    </td>
    <td>
       <img width="250px" src="https://raw.githubusercontent.com/jhomlala/alice/master/media/3.png">
    </td>
    <td>
       <img width="250px" src="https://raw.githubusercontent.com/jhomlala/alice/master/media/4.png">
    </td>
     <td>
       <img width="250px" src="https://raw.githubusercontent.com/jhomlala/alice/master/media/5.png">
    </td>
    <td>
       <img width="250px" src="https://raw.githubusercontent.com/jhomlala/alice/master/media/6.png">
    </td>
  </tr>
</table>

**Suported Dart http client plugins:**

- Dio
- HttpClient from dart:io package
- Http from http/http package

**Features:**  
✔️ Automatic dark theme  
✔️ Detailed logs for each HTTP calls (HTTP Request, HTTP Response)  
✔️ Inspector UI for viewing HTTP calls  
✔️ Save HTTP calls to file  
✔️ Statistics  
✔️ Notification on HTTP call  
✔️ Support for top used HTTP clients in Dart  
✔️ Error handling  
✔️ No useless functions

## Install

1. Add this to your **pubspec.yaml** file:

```yaml
dependencies:
  alice:
    git:
      url: https://github.com/CustedNG/alice.git
      ref: master
```

2. Install it

```bash
$ flutter packages get
```

3. Import it

```dart
import 'package:alice/alice.dart';
```

## Usage
### Alice configuration
Create Alice instance:

```dart
Alice alice = Alice();
```


Add navigator key to your application:

```dart
MaterialApp( navigatorKey: alice.getNavigatorKey(), home: ...)
```

You need to add this navigator key in order to show inspector UI.
You can use also your navigator key in Alice:

```dart
Alice alice = Alice(navigatorKey: yourNavigatorKeyHere);
```


### HTTP Client configuration
If you're using Dio, you just need to add interceptor.

```dart
Dio dio = Dio();
dio.interceptors.add(alice.getDioInterceptor());
```


If you're using HttpClient from dart:io package:

```dart
httpClient
	.getUrl(Uri.parse("https://jsonplaceholder.typicode.com/posts"))
	.then((request) async {
		alice.onHttpClientRequest(request);
		var httpResponse = await request.close();
		var responseBody = await httpResponse.transform(utf8.decoder).join();
		alice.onHttpClientResponse(httpResponse, request, body: responseBody);
 });
```

If you're using http from http/http package:

```dart
http.get('https://jsonplaceholder.typicode.com/posts').then((response) {
    alice.onHttpResponse(response);
});
```


To show inspector manually:

```dart
alice.showInspector();
```

## Saving calls

Alice supports saving logs to your mobile device storage. In order to make save feature works, you need to add in your Android application manifest:

```xml
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
```

## Example

See complete example here: https://github.com/jhomlala/alice/blob/master/example/lib/main.dart
