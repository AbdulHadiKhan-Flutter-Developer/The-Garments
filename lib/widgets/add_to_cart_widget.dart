import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thegarments/models/cart_model.dart';
import 'package:thegarments/models/products_model.dart';

class AddToCartWidget {
  ProductsModel productmodel;
  final String UId;

  AddToCartWidget({required this.productmodel, required this.UId});
  Future<void> checkexistingproduct({UId, int quantityincrement = 1}) async {
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Cart')
        .doc(UId)
        .collection('CartItem')
        .doc(productmodel.ProductId);

    DocumentSnapshot snapshot = await documentReference.get();

    if (snapshot.exists) {
      int currentquantity = snapshot['ProductQuantity'];
      int updatedquantity = currentquantity + quantityincrement;
      double totalPrice = double.parse(productmodel.issale
              ? productmodel.SalePrice
              : productmodel.FullPrice) *
          updatedquantity;
      await documentReference.update({
        'ProductQuantity': updatedquantity,
        'ProductTotalPrice': totalPrice
      });
      print('Product Exist');
    } else {
      await FirebaseFirestore.instance.collection('Cart').doc(UId).set({
        'UId': UId,
        'CreatedAt': DateTime.now(),
      });
      CartModel cartModel = CartModel(
        ProductId: productmodel.ProductId,
        CategoryId: productmodel.CategoryId,
        ProductName: productmodel.ProductName,
        CategoryName: productmodel.CategoryName,
        SalePrice: productmodel.SalePrice,
        FullPrice: productmodel.FullPrice,
        ProductImg: productmodel.ProductImg,
        DeliveryTime: productmodel.DeliveryTime,
        issale: productmodel.issale,
        ProductDescription: productmodel.ProductDescription,
        CreatedAt: DateTime.now(),
        UpdatedAt: DateTime.now(),
        ProductQuantity: 1,
        ProductTotalPrice: double.parse(productmodel.issale
            ? productmodel.SalePrice
            : productmodel.FullPrice),
      );

      await documentReference.set(
        cartModel.toMap(),
      );
    }
  }
}
