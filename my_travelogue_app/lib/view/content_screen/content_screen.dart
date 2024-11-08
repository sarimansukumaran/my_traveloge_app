import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:my_travelogue_app/controller/home_screen_controller.dart';
import 'package:my_travelogue_app/utils/color_constants.dart';
import 'package:provider/provider.dart';

class ContentScreen extends StatefulWidget {
  ContentScreen(
      {this.isEdit = false, this.title, this.content, this.id, super.key});
  final bool isEdit;
  final String? title;
  final String? content;
  // final Uint8List? image;
  int? id;

  @override
  State<ContentScreen> createState() => _ContentScreenState();
//  final ImagePicker picker = ImagePicker();
}

class _ContentScreenState extends State<ContentScreen> {
  String? imagePath;
  // Uint8List? imageBytes;
  List<String>? imagePaths = [];
  // List<Uint8List>? imageBytesList = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      context.read<HomeScreenController>().getData();
    });
    if (widget.isEdit == true) {
      titleController.text = widget.title ?? "";
      contentController.text = widget.content ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () async {
            final homeScreenController = context.read<HomeScreenController>();
            String title = titleController.text.trim();
            String content = contentController.text.trim();

            if (widget.isEdit) {
              homeScreenController.updateContent(title, content, widget.id!);
            } else {
              //Uint8List image = imageBytesList!.first;
              if (title.isNotEmpty || content.isNotEmpty) {
                homeScreenController.addData(title, content);
              }
            }
            Navigator.pop(context);
          },
        ),
        title: Text("My Travelogue Dairy",
            style: GoogleFonts.workSans(
                textStyle: TextStyle(
                    color: ColorConstants.primary_color,
                    fontSize: 20,
                    fontWeight: FontWeight.w600))),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: () async {
                    // final ImagePicker picker = ImagePicker();
                    // final List<XFile>? pickedImages =
                    //     await picker.pickMultiImage();
                    // if (pickedImages != null && pickedImages.isNotEmpty) {
                    //   imagePaths =
                    //       pickedImages.map((image) => image.path).toList();
                    //   List<Uint8List> imageBytesTemp = [];
                    //   for (var image in pickedImages) {
                    //     final bytes = await image.readAsBytes();
                    //     imageBytesTemp.add(bytes);
                    //   }
                    //   setState(() {
                    //     imageBytesList = imageBytesTemp;
                    //   });
                    // }
                  },
                  // value: 'Add Image',
                  child: Text('Add Image'),
                ),
              ];
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: TextField(
                decoration: InputDecoration(hintText: "Title"),
                controller: titleController,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Start typing...",
                    ),
                    maxLines: null, // Allows multi-line input
                    keyboardType: TextInputType.multiline,
                    controller: contentController,
                  ),
                  // imageBytesList!.isNotEmpty
                  //     ? ListView.builder(
                  //         shrinkWrap: true,
                  //         physics: NeverScrollableScrollPhysics(),
                  //         itemCount: imageBytesList!.length,
                  //         itemBuilder: (context, index) {
                  //           return Padding(
                  //             padding: const EdgeInsets.all(8.0),
                  //             child: Image.memory(
                  //               imageBytesList![index],
                  //               height: 200,
                  //               width: 200,
                  //               fit: BoxFit.cover,
                  //             ),
                  //           );
                  //         },
                  //       )
                  //     : Text("")
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
