# flutter_walkthrough

Exploring Serialization and Widgets In Flutter.

## Getting Started

An Application built with [flutter](https://flutter.io/). Lately a package built_value was released which with help of source generation makes an immutable class for JSON serialization. The application consists of two parts for now and each part fetches data from 
API. Part-I named Earthquake catalog fetches live earthquake readings from all around the world and display them in ListView. Part-II named HackerNews fetchs data from [HackerNews](https://github.com/HackerNews/API) API and uses built_value package to generate part file [article_parsing.g.dart](https://github.com/trevor-iqbal/flutter-walkthrough/blob/master/lib/src/article_parsing.g.dart) in order to manipulate it in every possile way.

## Why this exists

This was written to help me to make my grip strong on flutter, as it's an open source example. The tech used includes:

- [BuiltValue](https://github.com/google/built_value.dart) Package
- [FutureBuilder](https://docs.flutter.io/flutter/widgets/FutureBuilder-class.html) Widget

If you spot an error, feel free to file an issue report.
