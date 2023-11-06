import 'package:flutter/material.dart';
import 'package:grex_floating_view/grx_floating_view.dart';

class ListPage extends StatelessWidget {
  const ListPage({
    super.key,
    required this.service,
    required this.items,
  });

  final GrxFloatingViewService service;
  final List<int> items;

  Widget _buildListView() {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${items[index]}'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final body = _buildListView();

    return GrxFloatingViewConsumer(
      service: service,
      builder: (context) {
        return !service.showSafeArea
            ? Material(
                child: body,
              )
            : Scaffold(
                appBar: AppBar(
                  title: const Text('List Page'),
                ),
                body: body,
              );
      },
    );
  }
}
