import 'package:flutter/material.dart';

showFavAlertBox({required BuildContext context, required VoidCallback onPressedSaved}) {
  Widget dia = AlertDialog(
    title: const Text("Save?"),
    content: const Text("Are you sure to save this city for offline data."),
    actions: [
      InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Text("Cancel", style: TextStyle(
            color: Colors.grey,
          ),)),

      Padding(
        padding: const EdgeInsets.only(right: 15.0, left: 15),
        child: InkWell(
            onTap: (){
              Navigator.pop(context);
              onPressedSaved();
            },
            child: const Text("Save", style: TextStyle(color: Colors.blue),)),
      ),
    ],
  );
  showDialog(context: context, builder: (_) => dia);
}

showLoading({required BuildContext context}) {


  Widget dia = AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: const Center(child: CircularProgressIndicator(color: Colors.white,),),
          ),
        ],
      ),
    ),
  );

  showDialog(
  barrierDismissible: false,
      context: context,
      builder: (_) => dia);
}
