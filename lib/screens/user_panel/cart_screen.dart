// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:thegarments/controller/subtotal_controller.dart';

import 'package:thegarments/models/cart_model.dart';
import 'package:thegarments/screens/user_panel/checkout_screen.dart';

import 'package:thegarments/utils/app_constant.dart';

class CartScreen extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;
  final SubtotalController subtotalController = Get.put(SubtotalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppConstant.primeryColor,
        title: Text('Your Cart'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Cart')
            .doc(user!.uid)
            .collection('CartItem')
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> documentsnapshot) {
          if (documentsnapshot.hasError) {
            return Container(
              child: Center(
                child: Text('Some error Occured'),
              ),
            );
          }
          if (documentsnapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          if (documentsnapshot == null || documentsnapshot.data!.docs.isEmpty) {
            return Container(
              child: Center(
                child: Text('No Cart Item found'),
              ),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: documentsnapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final cartdata = documentsnapshot.data!.docs[index];
              CartModel cartModel = CartModel(
                  ProductId: cartdata['ProductId'],
                  CategoryId: cartdata['CategoryId'],
                  ProductName: cartdata['ProductName'],
                  CategoryName: cartdata['CategoryName'],
                  SalePrice: cartdata['SalePrice'],
                  FullPrice: cartdata['FullPrice'],
                  ProductImg: cartdata['ProductImg'],
                  DeliveryTime: cartdata['DeliveryTime'],
                  issale: cartdata['issale'],
                  ProductDescription: cartdata['ProductDescription'],
                  CreatedAt: cartdata['CreatedAt'],
                  UpdatedAt: cartdata['UpdatedAt'],
                  ProductQuantity: cartdata['ProductQuantity'],
                  ProductTotalPrice: cartdata['ProductTotalPrice']);
              return SwipeActionCell(
                key: ObjectKey(cartModel.ProductId),
                trailingActions: [
                  SwipeAction(
                      onTap: (CompletionHandler handler) async {
                        print('Deleted');
                        await FirebaseFirestore.instance
                            .collection('Cart')
                            .doc(user!.uid)
                            .collection('CartItem')
                            .doc(cartModel.ProductId)
                            .delete();
                      },
                      title: 'Delete',
                      forceAlignmentToBoundary: true,
                      performsFirstActionWithFullSwipe: true)
                ],
                child: Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(cartModel.ProductImg),
                    ),
                    title: Text(
                      cartModel.ProductName,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          'Total: ${cartModel.ProductTotalPrice.toString()}-pkr',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (cartModel.ProductQuantity > 1) {
                              await FirebaseFirestore.instance
                                  .collection('Cart')
                                  .doc(user!.uid)
                                  .collection('CartItem')
                                  .doc(cartModel.ProductId)
                                  .update({
                                'ProductQuantity':
                                    cartModel.ProductQuantity - 1,
                                'ProductTotalPrice': (double.parse(
                                        cartModel.issale
                                            ? cartModel.SalePrice
                                            : cartModel.FullPrice) *
                                    (cartModel.ProductQuantity - 1))
                              });
                            }
                          },
                          child: CircleAvatar(
                            backgroundColor: AppConstant.secondaryColor,
                            radius: 17,
                            child: Text(
                              '-',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (cartModel.ProductQuantity > 0) {
                              await FirebaseFirestore.instance
                                  .collection('Cart')
                                  .doc(user!.uid)
                                  .collection('CartItem')
                                  .doc(cartModel.ProductId)
                                  .update({
                                'ProductQuantity':
                                    cartModel.ProductQuantity + 1,
                                'ProductTotalPrice': (double.parse(
                                        cartModel.issale
                                            ? cartModel.SalePrice
                                            : cartModel.FullPrice) +
                                    double.parse(cartModel.issale
                                            ? cartModel.SalePrice
                                            : cartModel.FullPrice) *
                                        (cartModel.ProductQuantity))
                              });
                            }
                          },
                          child: CircleAvatar(
                            backgroundColor: AppConstant.secondaryColor,
                            radius: 17,
                            child: Text(
                              '+',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Chip(
                    shadowColor: AppConstant.secondaryColor,
                    label: Text(
                        'SubTotal: ${subtotalController.subtotal.value}-pkr ')),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => CheckoutScreen());
                },
                child: Text(
                  'CheckOut',
                  style: TextStyle(
                      color: AppConstant.textColor,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstant.secondaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
