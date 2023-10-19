import 'package:amazon_flutter/constants/utils.dart';
import 'package:amazon_flutter/features/address/services/address_services.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'package:amazon_flutter/common/widgets/custom_textfield.dart';
import 'package:amazon_flutter/constants/global_variables.dart';
import 'package:amazon_flutter/providers/user_provider.dart';

// const String applePayConfigString = '''
// {
//     "provider": "apple_pay",
//     "data": {
//       "merchantIdentifier": "merchant.com.sams.fish",
//       "displayName": "Sam's Fish",
//       "merchantCapabilities": ["3DS", "debit", "credit"],
//       "supportedNetworks": ["amex", "visa", "discover", "masterCard"],
//       "countryCode": "US",
//       "currencyCode": "USD",
//       "requiredBillingContactFields": ["post"],
//       "requiredShippingContactFields": ["post", "phone", "email", "name"],
//       "shippingMethods": [
//         {
//           "amount": "0.00",
//           "detail": "Available within an hour",
//           "identifier": "in_store_pickup",
//           "label": "In-Store Pickup"
//         },
//         {
//           "amount": "4.99",
//           "detail": "5-8 Business Days",
//           "identifier": "flat_rate_shipping_id_2",
//           "label": "UPS Ground"
//         },
//         {
//           "amount": "29.99",
//           "detail": "1-3 Business Days",
//           "identifier": "flat_rate_shipping_id_1",
//           "label": "FedEx Priority Mail"
//         }
//       ]
//     }
//   }
// ''';

const String gPayConfigString = '''
{
    "provider": "google_pay",
    "data": {
      "environment": "TEST",
      "apiVersion": 2,
      "apiVersionMinor": 0,
      "allowedPaymentMethods": [
        {
          "type": "CARD",
          "tokenizationSpecification": {
            "type": "PAYMENT_GATEWAY",
            "parameters": {
              "gateway": "example",
              "gatewayMerchantId": "gatewayMerchantId"
            }
          },
          "parameters": {
            "allowedCardNetworks": ["VISA", "MASTERCARD"],
            "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
            "billingAddressRequired": true,
            "billingAddressParameters": {
              "format": "FULL",
              "phoneNumberRequired": true
            }
          }
        }
      ],
      "merchantInfo": {
        "merchantId": "01234567890123456789",
        "merchantName": "Example Merchant Name"
      },
      "transactionInfo": {
        "countryCode": "US",
        "currencyCode": "USD"
      }
    }
  }
''';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  String addressToBeUsed = "";
  List<PaymentItem> paymentItems = [];
  final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    super.initState();
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  void onApplePayResult(res) {
    if (Provider.of<UserProvider>(context).user.address.isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  // void onGooglePayResult(res) {
  //   if (Provider.of<UserProvider>(context)
  //       .user
  //       .address
  //       .isEmpty) {
  //     addressServices.saveUserAddress(
  //         context: context, address: addressToBeUsed);
  //   }
  //   addressServices.placeOrder(
  //     context: context,
  //     address: addressToBeUsed,
  //     totalSum: double.parse(widget.totalAmount),
  //   );
  // }

  void onGooglePayResult(res) {
    if (res == 'success') {
      if (Provider.of<UserProvider>(context).user.address.isEmpty) {
        addressServices.saveUserAddress(
            context: context, address: addressToBeUsed);
      }
      addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: double.parse(widget.totalAmount),
      );
    } else {
      // Handle the case when Google Pay is not successful
      // You can show an error message or take appropriate action here
    }
  }

  // void payPressed(String addressFromProvider) {
  //   addressToBeUsed = "";

  //   bool isForm = flatBuildingController.text.isNotEmpty ||
  //       areaController.text.isNotEmpty ||
  //       pincodeController.text.isNotEmpty ||
  //       cityController.text.isNotEmpty;

  //   if (isForm) {
  //     if (_addressFormKey.currentState!.validate()) {
  //       addressToBeUsed =
  //           '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
  //     } else {
  //       throw Exception('Please enter all the values!');
  //     }
  //   } else if (addressFromProvider.isNotEmpty) {
  //     addressToBeUsed = addressFromProvider;
  //   } else {
  //     showSnackBar(context, 'ERROR');
  //   }
  // }
//  void saveAddress()  {
//   bool isForm = flatBuildingController.text.isNotEmpty ||
//       areaController.text.isNotEmpty ||
//       pincodeController.text.isNotEmpty ||
//       cityController.text.isNotEmpty;

//   if (isForm) {
//     if (_addressFormKey.currentState!.validate()) {
//       addressToBeUsed =
//           '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
//       final result =  addressServices.saveUserAddress(
//         context: context,
//         address: addressToBeUsed,
//       );

//       if (result) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Address saved successfully.'),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to save address. Please try again.'),
//           ),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Please enter all the values!'),
//         ),
//       );
//     }
//   } else {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Please enter all the values!'),
//       ),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: flatBuildingController,
                      hintText: 'Flat, House no, Building',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: areaController,
                      hintText: 'Area, Street',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: pincodeController,
                      hintText: 'Pincode',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: cityController,
                      hintText: 'Town/City',
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              // ApplePayButton(
              //   width: double.infinity,
              //   style: ApplePayButtonStyle.whiteOutline,
              //   type: ApplePayButtonType.buy,
              //     paymentConfiguration: PaymentConfiguration.fromJsonString(applePayConfigString),
              //   paymentItems: paymentItems,
              //   onPaymentResult: onApplePayResult,
              //   height: 50,
              //   margin: const EdgeInsets.only(top: 15.0),
              //   onPressed: () => payPressed(address),
              //   // loadingIndicator: const Center(
              //   //   child: CircularProgressIndicator(),
              //   // ),
              // ),
              const SizedBox(height: 10),
              // GooglePayButton(
              //   onPressed: () => payPressed(address),
              //   paymentConfiguration: PaymentConfiguration.fromJsonString(gPayConfigString),
              //   paymentItems: paymentItems,
              //   height: 50,
              //   type: GooglePayButtonType.buy,
              //   margin: const EdgeInsets.only(top: 15.0),
              //   onPaymentResult: onGooglePayResult,
              //   loadingIndicator: const Center(
              //     child: CircularProgressIndicator(),
              //   ),
              // ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
