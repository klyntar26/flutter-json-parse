import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:taskone/Screens/userhome.dart';
// Screens
// import 'package:taskone/Screens/userhome.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _items = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('sample.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["users"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'JSON Parse',
        ),
        elevation: 15,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Load Data'),
              onPressed: readJson,
            ),

            // Display the data loaded from sample.json
            _items.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  
                  return Card(
                    elevation: 20,
                    margin: const EdgeInsets.only(bottom: 10,right: 5, left: 5),
                    child: ListTile(
                      leading: Text("ID "+_items[index]["id"], style: TextStyle(fontSize: 15),),
                      title: Text("Name: "+_items[index]["name"], style: TextStyle(fontSize: 21, color: Colors.black87),),
                      subtitle: Text("Position: "+_items[index]["atype"], style: TextStyle(fontSize: 16, color: Colors.grey),),
                      onTap: () => _popDialog(context),
                    ),
                  );
                },
              ),
            )
                : Container()
          ],
        ),
      ),
    );
  }

  void _popDialog(BuildContext context){
    TextEditingController _age = TextEditingController();
    TextEditingController _gender = TextEditingController();

    String genderdefault = 'Female';
    String gender=genderdefault;

    var items=[
      'Female',
      'Male',
      'Transgender'
    ];

    showDialog(context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Enter Details'),
            content: Text('Success!'),
            
            actions: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton(
                      value: genderdefault,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items){
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(), onChanged: (String? newValue) {
                      setState(
                        ()
                       {
                        genderdefault = newValue.toString();
                      });
                    },
                  
                    ),

                    
                    TextField(
                      controller: _age,
                      decoration: InputDecoration(border: OutlineInputBorder(),
                      labelText: 'Enter your age',
                      hintText: '18',
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 15))
                  ],
                ),
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>userHome()));
                  },
                  child: Text('Save')),
            ],
          );
        });
  }

}