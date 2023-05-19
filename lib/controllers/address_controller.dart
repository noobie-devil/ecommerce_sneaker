import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_sneaker/shared_preferences_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../models/models.dart';

enum AddressState { loaded, loading, empty, error }

class AddressController extends GetxController {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  late final SharedPreferencesManager _sharedPreferencesManager;
  late final User? currentUser;
  final _fullNameSubject = BehaviorSubject<String>.seeded('');
  final _phoneNumberSubject = BehaviorSubject<String>.seeded('');
  final _addressSubject = BehaviorSubject<String>.seeded("");
  final _addressState = AddressState.loading.obs;
  final RxBool isFormValid = false.obs;
  final RxBool setDefaultAddress = false.obs;
  final _deliveryAddressList = RxList<DeliveryAddress>([]);
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>> listener;

  List<DeliveryAddress> get addressList => _deliveryAddressList;

  get fullNameSubject => _fullNameSubject.stream;

  get phoneNumberSubject => _phoneNumberSubject.stream;

  get addressSubject => _addressSubject.stream;

  Sink<String> get fullNameSink => _fullNameSubject.sink;

  Sink<String> get phoneNumberSink => _phoneNumberSubject.sink;

  Sink<String> get addressSink => _addressSubject.sink;

  Stream<bool> get isFormValidStream =>
      CombineLatestStream.combine3(
          _fullNameSubject.stream,
          _phoneNumberSubject.stream,
          _addressSubject.stream, (fullName, phoneNumber, address) {
        final fullNameValid = validateFullName(fullName) == null;
        final phoneNumberValid = validatePhoneNumber(phoneNumber) == null;
        final addressValid = validateRequired(address) == null;
        return fullNameValid && phoneNumberValid && addressValid;
      });

  setInitFormFieldValue(DeliveryAddress address) {
    fullNameSink.add(address.fullName);
    phoneNumberSink.add(address.phoneNumber);
    addressSink.add(address.address);
  }

  resetInitFormFieldValue() {
    _fullNameSubject.add("");
    _fullNameSubject.addError("");
    _phoneNumberSubject.add("");
    _phoneNumberSubject.addError("");
    _addressSubject.add("");
    _addressSubject.addError("");

    // fullNameSink.add("");
    // phoneNumberSink.add("");
    // addressSink.add("");
    // isFormValid.value = false;
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    _sharedPreferencesManager = await SharedPreferencesManager.instance;
    currentUser = _sharedPreferencesManager.getCurrentUser();
    initListener(currentUser?.uid);
    _fullNameSubject.skip(1).listen((event) {
      final error = validateFullName(event);
      if (error != null) {
        _fullNameSubject.addError(error);
      }
    });
    _phoneNumberSubject.skip(1).listen((event) {
      final error = validatePhoneNumber(event);
      if (error != null) {
        _phoneNumberSubject.addError(error);
      }
    });
    _addressSubject.skip(1).listen((event) {
      final error = validateRequired(event);
      if (error != null) {
        _addressSubject.addError(error);
      }
    });

    isFormValidStream.listen((event) {
      isFormValid.value = event;
    });
    super.onInit();
  }

  Future<void> initListener(String? documentId) async {
    listener = _fireStore
        .collection("User")
        .doc(documentId)
        .collection("DeliveryAddress")
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isEmpty) {
        _addressState.value = AddressState.empty;
      } else {
        _deliveryAddressList.assignAll(
            snapshot.docs.map((e) => DeliveryAddress.fromSnapshot(e)).toList()
        );
        print(_deliveryAddressList.toJson());
        _addressState.value = AddressState.loaded;
      }
    }, onError: (err) {
      print(err);
      _addressState.value = AddressState.error;
    });
  }

  Future<void> refreshListener() async {
    await listener.cancel();
    _addressState.value = AddressState.loading;
    await initListener(currentUser!.uid);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    _fullNameSubject.close();
    _phoneNumberSubject.close();
    _addressSubject.close();
    setDefaultAddress.close();
    listener.cancel();
    super.onClose();
  }

  Future<void> removeAddress(String documentId) async {
    if(currentUser != null && currentUser!.uid != null) {
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        )
      );
      final documentReference = _fireStore.collection("User").doc(currentUser!.uid).collection("DeliveryAddress").doc(documentId);
      documentReference.delete().then((value) {
        Get.back();
        Get.back();
        Get.snackbar("Delete Success", "", snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 2));

      }, onError: (error) {
        Get.back();
        Get.snackbar(
          "Delete Failed",
          error.message ?? "Unknown Error",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      });
    }
  }

  Future<void> updateAddress(bool setAsDefaultAddress, String documentId) async {
    final fullName = _fullNameSubject.value;
    final phoneNumber = _phoneNumberSubject.value;
    final address = _addressSubject.value;
    final currentUser = _sharedPreferencesManager.getCurrentUser();
    final setAsDefault = setAsDefaultAddress;
    if(currentUser != null && currentUser.uid != null) {
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        )
      );
      final deliveryAddressRef = _fireStore.collection("User").doc(currentUser.uid).collection("DeliveryAddress").doc(documentId);
      if(setAsDefault) {
        final snapshot = await _fireStore.collection("User").doc(currentUser.uid).collection('DeliveryAddress').where("is_default", isEqualTo: true).get();
        final batch = _fireStore.batch();
        for(final doc in snapshot.docs) {
          batch.update(doc.reference, {"is_default": false});
        }
        await batch.commit();
      }
      deliveryAddressRef.update({
        'full_name': fullName,
        'phone_number': phoneNumber,
        'address': address,
        'is_default': setAsDefault,
      }).then((_) {
        Get.back();
        Get.back();
        Get.snackbar(
          "Update Success",
          "",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      }).catchError((error) {
        Get.back();
        Get.snackbar(
          "Update Failed",
          error.message ?? "Unknown Error",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      });

    }
  }

  Future<void> addNewAddress(bool setAsDefaultAddress) async {
    final fullName = _fullNameSubject.value;
    final phoneNumber = _phoneNumberSubject.value;
    final address = _addressSubject.value;
    final currentUser = _sharedPreferencesManager.getCurrentUser();
    final setAsDefault = setAsDefaultAddress;
    if (currentUser != null && currentUser.uid != null) {
      Get.dialog(
          const Center(
            child: CircularProgressIndicator(),
          ));
      _fireStore
          .collection("User")
          .doc(currentUser.uid)
          .collection("DeliveryAddress")
          .add({
        'full_name': fullName,
        'phone_number': phoneNumber,
        'address': address,
        'is_default': setAsDefault
      }).then((value) {
        Get.back();
        Get.back();
        Get.snackbar("Add Success", "",
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2));
      }, onError: (error) {
        Get.back();
        Get.snackbar("Add Failed", error.message ?? "Unknown Error",
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2));
      });
    }
  }

  bool isValidFullName(String fullName) {
    final RegExp nameRegex = RegExp(r"^\b[a-zA-Z]{2,}(?:\s[a-zA-Z]+){1,}\b$");
    return nameRegex.hasMatch(fullName);
  }

  String? validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }
    return null;
  }

  String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    } else if (!isValidFullName(value.trim())) {
      return "This full name is invalid";
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    } else if (!RegExp(
        r"^[0-9]{0,2}[\\s-]?[- ]?([0-9]{0,4})[- ]?([0-9]{0,4})[- ]?([0-9]{0,})$")
        .hasMatch(value)) {
      return "Phone number is invalid. (e.x:1-888-364-3577).";
    } else if (!RegExp(
        r"^(?=(?:\D*\d){10,}\D*$)[0-9]{1,2}[- ]?([0-9]{3,4})[- ]?([0-9]{3,4})[- ]?([0-9]{3,10})$")
        .hasMatch(value)) {
      return "Phone numbers must be between 10 and 20 digits.";
    } else {
      return null;
    }
  }
}
