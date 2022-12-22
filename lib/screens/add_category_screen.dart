import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';
import '../cubits/admin_cubit.dart';
import '../cubits/admin_states.dart';
import 'add_furniture_screen.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({Key? key}) : super(key: key);

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

final _formKey = GlobalKey<FormState>();

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  TextEditingController nameController = TextEditingController();
  FileOrURL imageController = FileOrURL(urlController: TextEditingController());

  getFile(FileOrURL shared,{isImage=false}) async {
    FilePickerResult? filePicker;
    if(isImage==true){
      filePicker= await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ['png','jpg','jpeg']);

    }else {
      filePicker= await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ['glb']);
    }
    if (filePicker != null) {
      setState(() {
        shared.file = filePicker!.files.first.bytes!;
        shared.urlController.text = filePicker.files.first.name;
      });
      print(shared.urlController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state){
        if (state is AddedCategory) {
          Navigator.pop(context);
        }
      },
      builder: (context, state){
        return state is LoadingAllData || state is AddingCategory
            ?  Center(
          child: CircularProgressIndicator(),
        ): Scaffold(
          body: Container(
            decoration: BoxDecoration(),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height / 3,
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Add Category",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: (MediaQuery.of(context).size.width > 800)?20: (MediaQuery.of(context).size.width < 220) ? 7:11),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: nameController,
                              validator: (value) {
                                if (!RegExp(r"^([a-z A-Z']+)$")
                                    .hasMatch(value.toString())) {
                                  return 'Please enter a valid category name';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  hintText: "Category Name",
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.grey)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey))),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (imageController.file == null) {
                                        if (!Uri.parse(imageController.urlController.text).isAbsolute) {
                                          return "Please enter a url or upload an image";
                                        }
                                      }
                                      return null;
                                    },
                                    enabled: imageController.file == null ? true : false,
                                    controller: imageController.urlController,
                                    decoration: const InputDecoration(
                                        hintText: "Image link or upload",
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey)),
                                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () async {
                                      await getFile(imageController, isImage:true);
                                    },
                                    icon: const Icon(Icons.attach_file)),
                                if (imageController.file != null)
                                  IconButton(
                                      onPressed: () async {
                                        setState(() {
                                          imageController.file = null;
                                          imageController.urlController.text = "";
                                        });
                                      },
                                      icon: const Icon(Icons.delete)),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(50, 50),
                                    backgroundColor: primaryColor,
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await BlocProvider.of<AdminCubit>(context).addCategory(context, categoryName: nameController.text, categoryImage: imageController);
                                    }
                                  },
                                  child: const Text("Add Category")),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

