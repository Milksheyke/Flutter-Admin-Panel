import 'package:admin/constants.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/storage_details.dart';
import 'package:admin/screens/main/components/header.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class FileItem {
  final String name;
  final String type;
  final int size; // Size in KB/MB/GB
  final String iconUrl;

  FileItem(
      {required this.name,
      required this.type,
      required this.size,
      required this.iconUrl});
}

class MyFiles extends StatelessWidget {
  final List<FileItem> files = [
    // Sample files. Replace with your actual data
    FileItem(
        name: 'Document',
        type: 'PDF',
        size: 500,
        iconUrl: 'assets/icons/doc_file.svg'),
    FileItem(
        name: 'Image',
        type: 'Image',
        size: 300,
        iconUrl: 'assets/icons/image_file.svg'),
    // Add more files
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: files.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // Adjust the number of columns
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemBuilder: (context, index) {
          return _buildFileItem(files[index]);
        },
      ),
    );
  }

  Widget _buildFileItem(FileItem file) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Assuming you're using SVG icons; you can use Image.network for actual images
          //SvgPicture.asset(file.iconUrl),
          SizedBox(height: 8),
          Text(file.name, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('${file.size} KB'),
        ],
      ),
    );
  }
}

class Item {
  final String photoUrl;
  final String name;
  final double price;

  Item({required this.photoUrl, required this.name, required this.price});
  // Add other properties and methods as needed
}

class ItemsManagerScreen extends StatelessWidget {
  final List<Item> items = [
    // Here, add some sample items or fetch from your database
    Item(
        photoUrl: 'https://example.com/photo1.jpg',
        name: 'Item 1',
        price: 10.0),
    Item(
        photoUrl: 'https://example.com/photo2.jpg',
        name: 'Item 2',
        price: 15.0),
    // Add more items
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      MyFiles(),
                      SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) StorageDetails(),
                      SizedBox(height: defaultPadding),
                      ItemsManager(items: items), // Add the Items Manager here
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: StorageDetails(),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ItemsManager extends StatelessWidget {
  final List<Item> items;

  ItemsManager({required this.items});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Photo')),
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Price')),
        ],
        rows: items
            .map(
              (item) => DataRow(cells: [
                DataCell(Image.network(
                    item.photoUrl)), // Assuming you're using URLs for images
                DataCell(Text(item.name)),
                DataCell(Text('\$${item.price.toStringAsFixed(2)}')),
              ]),
            )
            .toList(),
      ),
    );
  }
}
