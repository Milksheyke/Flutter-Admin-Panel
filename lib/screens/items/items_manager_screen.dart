import 'package:admin/constants_and_variables.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/storage_details.dart';
import 'package:admin/screens/items/items_manager_bloc.dart';
import 'package:admin/screens/main/components/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

// class MyFiles extends StatelessWidget {
//   final List<FileItem> files = [
//     // Sample files. Replace with your actual data
//     FileItem(
//         name: 'Document',
//         type: 'PDF',
//         size: 500,
//         iconUrl: 'assets/icons/doc_file.svg'),
//     FileItem(
//         name: 'Image',
//         type: 'Image',
//         size: 300,
//         iconUrl: 'assets/icons/image_file.svg'),
//     // Add more files
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(8.0),
//       child: GridView.builder(
//         shrinkWrap: true,
//         itemCount: files.length,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 4, // Adjust the number of columns
//           crossAxisSpacing: 8.0,
//           mainAxisSpacing: 8.0,
//         ),
//         itemBuilder: (context, index) {
//           return _buildFileItem(files[index]);
//         },
//       ),
//     );
//   }

//   Widget _buildFileItem(FileItem file) {
//     return Card(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           // Assuming you're using SVG icons; you can use Image.network for actual images
//           //SvgPicture.asset(file.iconUrl),
//           SizedBox(height: 8),
//           Text(file.name, style: TextStyle(fontWeight: FontWeight.bold)),
//           SizedBox(height: 8),
//           Text('${file.size} KB'),
//         ],
//       ),
//     );
//   }
// }

class ItemsManagerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuAppBloc, MenuAppState>(builder: (context, state) {
      return SafeArea(
        child: SingleChildScrollView(
            primary: false,
            padding: EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                Header(),
                SizedBox(height: defaultPadding),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  BlocProvider.value(
                    value: ItemsManagerBloc(),
                    child: Expanded(
                      flex: 5,
                      child: BlocBuilder<ItemsManagerBloc, ItemsManagerState>(
                          builder: (context, state) {
                        return Column(
                          children: [
                            SizedBox(height: defaultPadding),
                            if (Responsive.isMobile(context))
                              SizedBox(height: defaultPadding),
                            BlocProvider.value(
                              value: ItemsManagerBloc(),
                              child: ItemsManager(),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ]),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: StorageDetails(),
                  ),
              ],
            )),
      );
    });
  }
}

class ItemsManager extends StatefulWidget {
  final ItemsManagerBloc _itemsManagerBloc;

  ItemsManager() : _itemsManagerBloc = ItemsManagerBloc();

  @override
  State<ItemsManager> createState() => _ItemsManagerState();
}

class _ItemsManagerState extends State<ItemsManager> {
  @override
  void initState() {
    BlocProvider.of<ItemsManagerBloc>(context).add(FetchItemsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemsManagerBloc, ItemsManagerState>(
        builder: (context, state) {
      if (state is ItemsManagerInitial || state is ItemsManagerLoading) {
        return CircularProgressIndicator();
      }
      if (state is ItemsManagerLoaded)
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Photo')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Price')),
              DataColumn(label: Text('Action')),
            ],
            rows: state.items
                .map(
                  (item) => DataRow(cells: [
                    DataCell(item.photoUrl == null
                        ? SvgPicture.network(placeholderImage)
                        : Image.network(item.photoUrl!)),
                    DataCell(Text(item.name)),
                    DataCell(Text('\$${item.price.toStringAsFixed(2)}')),
                    DataCell(TextButton(
                      child: Text(editText),
                      onPressed: () {},
                    )),
                  ]),
                )
                .toList(),
          ),
        );
      else {
        return Text('An error occurred while fetching data.');
      }
    });
  }
}
