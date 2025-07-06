import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:octopus/octopus.dart';

enum Routes with OctopusRoute {
  catalog('catalog', title: 'Catalog'),
  product('product', title: 'Product');

  const Routes(this.name, {this.title});

  @override
  final String name;

  @override
  final String? title;

  @override
  Widget builder(BuildContext context, OctopusState state, OctopusNode node) =>
      switch (this) {
        Routes.catalog => const CatalogScreen(),
        Routes.product => ProductScreen(id: node.arguments['id']),
      };
}

final router = Octopus(routes: Routes.values, defaultRoute: Routes.catalog);

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 89, 20, 216),
        ),
      ),
      routerConfig: router.config,
    );
  }
}

class ProductScreen extends StatelessWidget {
  final String? id;
  const ProductScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Product $id')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://cdn-img.poizonapp.com/pro-img/cut-img/20250201/a474097220b047b68f4e6474541defcc.jpg?x-oss-process=image/format,webp/resize,w_800",
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => SizedBox(
                            height: 300,
                            child: Center(
                              child: CircularProgressIndicator(
                                value: downloadProgress.progress,
                              ),
                            ),
                          ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text('Item $id', style: TextStyle(fontSize: 16)),
                      Spacer(),
                      Text(
                        '${100 * int.parse(id!)}\$',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: FilledButton(onPressed: () {}, child: Text('Buy')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Deeplink Sandbox')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView.separated(
          itemBuilder:
              (cotnext, index) => Card.filled(
                elevation: 0,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    context.octopus.push(
                      Routes.product,
                      arguments: {"id": '$index'},
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://cdn-img.poizonapp.com/pro-img/cut-img/20250201/a474097220b047b68f4e6474541defcc.jpg?x-oss-process=image/format,webp/resize,w_800",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => SizedBox(
                                  height: 300,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      value: downloadProgress.progress,
                                    ),
                                  ),
                                ),
                            errorWidget:
                                (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text('Item $index', style: TextStyle(fontSize: 16)),
                            Spacer(),
                            Text(
                              '${100 * (index + 1)}\$',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          separatorBuilder: (cotnext, index) => SizedBox(height: 20),
          itemCount: 5,
        ),
      ),
    );
  }
}
