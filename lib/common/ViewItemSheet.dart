import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growcery/services/FirestoreService.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../constants/AppColors.dart';
import 'AddToBasketSheet.dart';

class ViewItemSheet extends ConsumerStatefulWidget {
  const ViewItemSheet({
    required this.name,
    required this.price,
    required this.description,
    required this.stock,
    required this.image,
    required this.id,
    required this.min,
    required this.sellerID,
    Key? key,
  }) : super(key: key);

  final String name;
  final String price;
  final String description;
  final String stock;
  final String image;
  final String id;
  final min;
  final sellerID;

  @override
  ConsumerState createState() => _ViewItemSheetState();
}

class _ViewItemSheetState extends ConsumerState<ViewItemSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      color: AppColors().primaryColor,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Image.network(
                        widget.image,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "${widget.name} - MINIMUM OF ${widget.min}KG",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "PHP ${widget.price}/Kilogram",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Description",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Stocks: ${widget.stock}KG",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    widget.description,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 65,
            color: Colors.white,
            padding: const EdgeInsets.only(left: 20, right: 20,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors().primaryColor,
                    elevation: 0,
                    fixedSize: const Size(150, 40),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  child: Text(
                    "Buy Now",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onPressed: (){
                    if (int.parse(widget.stock) >=int.parse(widget.min)) {
                      showMaterialModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        builder: (context) => AddToBasketSheet(id: widget.id, minimum: widget.min, isNow: true, sellerID: widget.id,),
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: "Insufficient Stocks for minimum order",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                    //FirestoreService().addToBasket(widget.id);
                  },
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors().primaryColor,
                    elevation: 0,
                    fixedSize: const Size(150, 40),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  child: Text(
                    "Add to Basket",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onPressed: (){
                    if (int.parse(widget.stock) >=int.parse(widget.min)) {
                      showMaterialModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        builder: (context) => AddToBasketSheet(id: widget.id, minimum: widget.min, isNow: false, sellerID: widget.sellerID),
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: "Insufficient Stocks for minimum order",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                    //FirestoreService().addToBasket(widget.id);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
