import 'package:ar_furniture_admin_panel/constants.dart';
import 'package:ar_furniture_admin_panel/cubits/admin_cubit.dart';
import 'package:ar_furniture_admin_panel/cubits/admin_states.dart';
import 'package:ar_furniture_admin_panel/models/furniture_model.dart';
import 'package:ar_furniture_admin_panel/screens/dashboard_screen.dart';
import 'package:ar_furniture_admin_panel/screens/furniture_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_furniture_screen.dart';

class OffersScreen extends StatefulWidget {
  FurnitureModel furniture;
  OffersScreen(this.furniture);

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  final nController = TextEditingController();
  FileOrURL offerImage = FileOrURL(urlController: TextEditingController());

  List<SharedProperties> sharedProperties = [];

  getFile(FileOrURL shared, {isImage = false}) async {
    FilePickerResult? filePicker;

    if (isImage == true) {
      filePicker = await FilePicker.platform.pickFiles(
          type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg']);
    } else {
      filePicker = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['glb']);
    }
    if (filePicker != null) {
      setState(() {
        shared.file = filePicker!.files.first.bytes!;
        shared.urlController.text = filePicker.files.first.name;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.furniture.shared.forEach((element) {
      sharedProperties.add(SharedProperties(
        model: FileOrURL(urlController: TextEditingController()),
        color: TextEditingController(),
        colorName: TextEditingController(),
        discount: TextEditingController(),
        image: FileOrURL(urlController: TextEditingController()),
        price: TextEditingController(),
        quantity: TextEditingController(),
      ));

      sharedProperties.last.color.text = element.color;
      sharedProperties.last.colorName.text = element.colorName;
      sharedProperties.last.discount.text = element.discount;
      sharedProperties.last.image.urlController.text = element.image;
      sharedProperties.last.model.urlController.text = element.model;
      sharedProperties.last.price.text = element.price;
      sharedProperties.last.quantity.text = element.quantity;
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {
        if (state is AddedOffer) {
          sharedProperties = [
            SharedProperties(
              model:FileOrURL(urlController: TextEditingController()),
              color: TextEditingController(),
              colorName: TextEditingController(),
              discount: TextEditingController(),
              image: FileOrURL(urlController: TextEditingController()),
              price: TextEditingController(),
              quantity: TextEditingController(),
            ),
          ];
        }
      },
      builder: (context, state) {
        return state is LoadingAllData
            ? const Center(child: CircularProgressIndicator())
            : Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.keyboard_backspace,color: Colors.black,),
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  body: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: 500,
                      height: MediaQuery.of(context).size.height / 1.5,
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
                                  children: const [
                                    Text(
                                      "Adding Offer",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  widget.furniture.name,
                                  style: const TextStyle(fontFamily: "Montserrat", fontSize: 20),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        validator: (value) {
                                          if (offerImage.file == null) {
                                            if (!Uri.parse(offerImage.urlController.text).isAbsolute) {
                                              return "Please enter a url or upload an image";
                                            }
                                          }
                                          return null;
                                        },
                                        enabled: offerImage.file == null ? true : false,
                                        controller: offerImage.urlController,
                                        decoration: const InputDecoration(
                                          hintText: "uploading discount picture",
                                          enabledBorder:
                                              OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey)),
                                          focusedBorder:
                                              OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey)),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          await getFile(offerImage, isImage: true);
                                        },
                                        icon: const Icon(Icons.attach_file)),
                                    if (offerImage.file != null)
                                      IconButton(
                                          onPressed: () async {
                                            setState(() {
                                              offerImage.file = null;
                                              offerImage.urlController.text = "";
                                            });
                                          },
                                          icon: const Icon(Icons.delete)),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 150,
                                        // width: 100,
                                        child: ListView.builder(
                                          itemBuilder: (context, index) {
                                            return buildExpansionTile(
                                                sharedProperties[index]
                                                    .colorName
                                                    .text,
                                                sharedProperties[index],
                                                index);
                                          },
                                          itemCount: sharedProperties.length,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                state is AddingOffer
                                    ? const Center(child: CircularProgressIndicator())
                                    : ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: const Size(50, 50),
                                          backgroundColor: primaryColor,
                                        ),
                                        onPressed: () async {
                                          print("yessssssssssssssssssssssssssssssssssss offer");
                                          List<String> color = [];
                                          int flag = 0;
                                          for (int i = 0; i < sharedProperties.length; i++) {
                                            if (  (widget.furniture.shared[i].discount != sharedProperties[i].discount.text)) {
                                              flag = 1;
                                              color.add(sharedProperties[i].colorName.text);
                                            }
                                          }
                                          print(flag);
                                          if (_formKey.currentState!.validate() && flag == 1) {
                                            await BlocProvider.of<AdminCubit>(context).addOffer(context, category: widget.furniture.category, furnID: widget.furniture.furnitureId, color: color, image: offerImage);
                                            await BlocProvider.of<AdminCubit>(context).updateFurniture(context,
                                                    furnitureName: widget.furniture.name,
                                                    furnitureDescription: widget.furniture.description.toString(),
                                                    myShared: sharedProperties,
                                                    oldFurniture: widget.furniture,isOffer:true);
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FurnitureScreen()));

                                          }
                                        },
                                        child: const Text("Add Offer"))
                              ],
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

  Widget buildExpansionTile(variant, sharedProperty, index) {
    return ExpansionTile(
      maintainState: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(variant),
          if (sharedProperties.length != 1 &&
              index >= widget.furniture.shared.length)
            IconButton(
                splashRadius: 15,
                onPressed: () {
                  if (sharedProperties.length != 1) {
                    setState(() {
                      sharedProperties.removeAt(index);
                    });
                  }
                },
                icon: const Icon(Icons.delete))
        ],
      ),
      children: [
        TextFormField(
          validator: (value) {
            if (value.toString().isEmpty) {
              return "Please enter a valid discount";
            }
            if (int.parse(value.toString()) > 100) {
              return "Please enter a valid discount which is less than 100";
            }
            return null;
          },
          controller: sharedProperty.discount,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
              hintText: "Discount ex:25",
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
        ),
      ],
    );
  }

}
