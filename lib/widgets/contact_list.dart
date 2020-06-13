import 'package:flutter/material.dart';
import 'package:myapp/widgets/contact_details.dart';



class Contactlist extends StatelessWidget {
  final List<Contact> contacts_list;
  final Function deleteTx;

 Contactlist(this.contacts_list,this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.63,
       child: contacts_list.isEmpty
          ?Padding(
            padding: const EdgeInsets.only(top:15.0),
            child: Text("Its lonely here add some contacts",
            style: TextStyle(
              fontSize: 28
            ),),
          ):
       ListView.builder(
        itemBuilder: (ctx, index){
          return Card(
             elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child:ListTile(
                    title: Text(
                    '${contacts_list[index].name}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => deleteTx(contacts_list[index].number),
                    ),
                     subtitle:Text(
                      contacts_list[index].number.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ),            
          );      
        },
      itemCount: contacts_list.length, 
      )

          );
        }      
}

    

