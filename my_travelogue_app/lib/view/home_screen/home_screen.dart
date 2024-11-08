import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_travelogue_app/controller/home_screen_controller.dart';
import 'package:my_travelogue_app/utils/color_constants.dart';
import 'package:my_travelogue_app/view/content_screen/content_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      context.read<HomeScreenController>().getData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ContentScreen()));
        },
        child: Icon(
          Icons.add,
          color: ColorConstants.main_white,
        ),
        backgroundColor: ColorConstants.primary_color,
      ),
      appBar: AppBar(
        title: Text("My Traveloges Dairy",
            style: GoogleFonts.workSans(
                textStyle: TextStyle(
                    color: ColorConstants.primary_color,
                    fontSize: 20,
                    fontWeight: FontWeight.w600))),
        actions: [
          Icon(
            Icons.menu,
            color: ColorConstants.primary_color,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Consumer<HomeScreenController>(
        builder: (context, homeController, child) => homeController
                .travelogedataList.isNotEmpty
            ? ListView.separated(
                itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.all(10),
                      height: 150,
                      width: 250,
                      color: Color.fromARGB(255, 219, 222, 224),
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10),
                            child: Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    homeController.travelogedataList[index]
                                        ["title"],
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                    maxLines: 2,
                                  ),
                                  Text(
                                    homeController.travelogedataList[index]
                                        ["content"],
                                    textAlign: TextAlign.justify,
                                    maxLines: 3,
                                  ),
                                  // if (HomeScreenController.travelogedataList[index]
                                  //         ["image"] !=
                                  //     null)
                                  //   Image.memory(
                                  //     HomeScreenController.travelogedataList[index]
                                  //         ["image"], // Display the image from the database
                                  //     height: 100,
                                  //     width: 100,
                                  //     fit: BoxFit.cover,
                                  //   ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ContentScreen(
                                                    isEdit: true,
                                                    title: homeController
                                                            .travelogedataList[
                                                        index]["title"],
                                                    content: homeController
                                                            .travelogedataList[
                                                        index]["content"],
                                                    id: homeController
                                                            .travelogedataList[
                                                        index]["id"],
                                                  )));
                                    },
                                    child: Container(
                                      height: 20,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          color: ColorConstants.primary_color
                                              .withOpacity(.5),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 17),
                                      child: Text(
                                        "Read",
                                        style: GoogleFonts.workSans(
                                            textStyle: TextStyle(
                                                color:
                                                    ColorConstants.main_white,
                                                fontSize: 12)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                              top: 0,
                              right: 0,
                              child: PopupMenuButton(
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                      onTap: () {
                                        _showDeleteConfirmationDialog(
                                          context,
                                          homeController
                                              .travelogedataList[index]["id"],
                                        );
                                      },
                                      child: Text("Delete")),
                                ],
                                child: Icon(Icons.more_vert),
                              )),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: Text(
                                homeController.travelogedataList[index]
                                        ["date"] ??
                                    "No date",
                                style: TextStyle(
                                    color: ColorConstants.main_black
                                        .withOpacity(.3)),
                              ))
                        ],
                      ),
                    ),
                separatorBuilder: (context, index) => SizedBox(
                      height: 20,
                    ),
                itemCount: homeController.travelogedataList.length)
            : homeController.isLoding
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(child: Text("No content available")),
      ),
    );
  }

  void _showDeleteConfirmationDialog(context, int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                context.read<HomeScreenController>().removeContent(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
