<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

This package helps in the bagging process when receiving data from the Internet, reduces the number of requests, and get data that fits on one page.

## Support

 **Android**
 **IOS**
 **Web**

## Features

A Pagination Library for Flutter (with Web Support).

[//]: # (## Getting started)
## Installation
To install **flutter_pagination_data**, add the following line to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_pagination_data: ^1.0.0
```

Import the package and use it in your Flutter App.

```dart

import 'package:flutter_pagination_data/flutter_pagination_data.dart';


```

## Usage
```dart
class CustomPaginationWidget extends StatelessWidget {
  const CustomPaginationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPagination<NewsData>(
      separatorWidget: SizedBox(
        height: 10.0,
      ),
      itemBuilder: (BuildContext context, item) {
        return ListTile(
          title:
          Text(item.title),
          subtitle: Text(item.description),
          leading: IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () => print(item.id),
          ),
          onTap: () => print(item.source),
          trailing: Icon(
            Icons.add,
          ),
        );
      },
      fetchMethod: fetchMethod,
      onError: (error) => Center(
        child: Text('Error'),
      ),
      onEmpty: Center(
        child: Text('Empty'),
      ),
    );
  }
}
```
## Properties

<table>
  <tr style="background-color: #FFFFFF;">
    <th>itemBuilder</th>
    <th>Widget Function</th>
    <th>null</th>
    <th>items list to retrive it</th>
  </tr>
  <tr style="background-color: #F0F0F0;">
    <td>onError</td>
    <td>Widget Function</td>
    <td>null</td>
    <td>show widget when error.</td>
  </tr>
  <tr style="background-color: #FFFFFF;">
    <td>onEmpty</td>
    <td>Widget</td>
    <td>null</td>
    <td>show widget when empty.</td>
  </tr>
  <tr style="background-color: #F0F0F0;">
    <td>separatorWidget</td>
    <td>Widget</td>
    <td>null</td>
    <td>space between widgets.</td>
  </tr>
  <tr style="background-color: #FFFFFF;">
    <th>onPageLoading</th>
    <th>Widget</th>
    <th>Circle Progress</th>
    <th>show widget when page loading.</th>
  </tr>
  <tr style="background-color: #F0F0F0;">
    <td>onLoading</td>
    <td>Widget</td>
    <td>Circle</td>
    <td>show widget when loading new item.</td>
  </tr>
  <tr style="background-color: #FFFFFF;">
    <td>fetchMethod</td>
    <td>PaginationBuilder</td>
    <td>null</td>
    <td>method to fetch listed data.</td>
  </tr>
  <tr style="background-color: #F0F0F0;">
    <td>initialData</td>
    <td>List</td>
    <td>null</td>
    <td>initial data to show it.</td>
  </tr>
  <tr style="background-color: #FFFFFF;">
    <th>scrollDirection</th>
    <th>Axis</th>
    <th>Vertical</th>
    <th>scroll axis , horiz | vertical .</th>
  </tr>
  <tr style="background-color: #F0F0F0;">
    <td>physics</td>
    <td>ScrollPhysics</td>
    <td>null</td>
    <td>need to scroll or not.</td>
  </tr>
  <tr style="background-color: #FFFFFF;">
    <td>shrinkWrap</td>
    <td>bool</td>
    <td>true</td>
    <td>shrinkWrap items.</td>
  </tr>
  <tr style="background-color: #F0F0F0;">
    <td>isGridView</td>
    <td>bool</td>
    <td>false</td>
    <td>support show data as gridView.</td>
  </tr>
  <tr style="background-color: #FFFFFF;">
    <th>crossAxisCount</th>
    <th>int</th>
    <th>1</th>
    <th>crossAxisCount when use gridView.</th>
  </tr>
  <tr style="background-color: #F0F0F0;">
    <td>mainAxisExtent</td>
    <td>double</td>
    <td>100</td>
    <td>item height when use gridView.</td>
  </tr>
  <tr style="background-color: #FFFFFF;">
    <td>mainAxisSpacing</td>
    <td>double</td>
    <td>10.0</td>
    <td>main axis space when use gridView.</td>
  </tr>
  <tr style="background-color: #F0F0F0;">
    <td>crossAxisSpacing</td>
    <td>double</td>
    <td>10.0</td>
    <td>cross axis space when use gridView.</td>
  </tr>

</table> 

