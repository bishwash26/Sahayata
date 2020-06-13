
import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './contact_details.dart';

import './http_exception.dart';
class Contacts with ChangeNotifier {
  List<Contact> items = [];
   final String authToken;
  final String userId;
  Contacts({this.authToken,this.userId,this.items});

  List<Contact> get friends {
    return [...items];
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    var url =
        'https://flutter-update.firebaseio.com/contacts.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Contact> loadedContacts = [];
      extractedData.forEach((contactname, contactno) {
        loadedContacts.add(Contact(
         name: contactname,
         number: contactno,
        ));
      });
      items = loadedContacts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addContact(Contact contact) async {
    final url =
        'https://flutter-update.firebaseio.com/contacts.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'name': contact.name,
          'number':contact.number,
        }),
      );
      
      final newContact = Contact(
        name: contact.name,
        number: contact.number,
      );
      items.add(newContact);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
