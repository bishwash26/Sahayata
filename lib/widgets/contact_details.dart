import 'package:flutter/foundation.dart';
import 'package:myapp/widgets/helpers/db_helper.dart';

class Contact with ChangeNotifier {
final String name;
final number;
Contact({
  this.name,this.number
});

static Future<void> addcontacts(Contact value)async{
  await DBhelper.insert("contacts",{'name':value.name,'number':value.number});
}

static Future <List> getdatabase() async{
   final final_list=await DBhelper.getdata("contacts");
   List items=[];
   items=final_list.map(
     (item)=>Contact(
       name:item["name"],
       number:item["number"],
     )).toList();     
     return items;
}
static Future<void> delete(String number) async{
await DBhelper.delete("contacts", number);
}
static Future<void> tabledelete()async{
  await DBhelper.table_delete("contacts");
}
}