import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:qlqn/src/modules/editMenuPage/updateProductPage/components/CardModalUpdate.dart';
import '../../../models/product.dart';

class CardProductEdit extends StatelessWidget {
  CardProductEdit({super.key, required this.isDelete,required this.deleteProduct,required this.product});
  Function deleteProduct;
  Product product;
  bool isDelete ;

  @override
  Widget build(BuildContext context) {
    void updateProduct() {
      showModalBottomSheet(
          context:context ,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
        isScrollControlled: true,
        builder: (BuildContext context) {
          return CardModelUpdate(product: product,);
        },
      );
    }
    return Container(
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF492803),
          width: 2,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Image.network(
                product.imageUrl,
                width: 150,
                height: 99,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: 200,
            height: 30,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Color(0xFF492803),
                  width: 2,
                ),
                bottom: BorderSide(
                  color: Color(0xFF492803),
                  width: 2,
                ),
              ),
            ),
            child: Text(
              product.unitPrice.toString() ,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF492803),
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left:10),
                  child: Text(
                    product.name,
                    maxLines: 2,
                    style: const TextStyle(
                      color: Color(0xFF492803),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF492803),
                  fixedSize: const Size(30, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ),
                child: Icon(
                  isDelete?Icons.delete_sharp:Icons.edit_sharp,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed:() async{
                  if(isDelete){
                  if(await confirm(context)){
                    deleteProduct(product);
                  }
                  }else{
                    updateProduct();
                  }
                },
              ),

            ],
          ),
        ],
      ),
    );
  }
}
