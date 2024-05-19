import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  final double totalPrice;

  const PaymentPage({Key? key, required this.totalPrice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ödeme Yap'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Toplam Tutar: \$${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Ödeme işlemleri burada gerçekleştirilebilir
                  // Örneğin: Ödeme API'si çağrılır, ödeme onaylanır vs.
                  // Burada ödeme işlemleri senkronize olarak gerçekleştirilmediği için ödemenin başarılı olduğu kabul edilir.
                  // Ödeme işlemi başarıyla gerçekleştikten sonra alışverişi tamamladığınıza dair bir mesaj gösterebilirsiniz.
                  Navigator.pop(context,
                      true); // Ödeme başarılı olduğunda true değerini döndür
                  // Navigator.popUntil(context, ModalRoute.withName('/home'));
                },
                child: Text('Ödemeyi Tamamla'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
