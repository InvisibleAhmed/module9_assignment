import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {
                // Implement search functionality here
              },
            ),
          ],
        ),
    body: Container(
    color: Colors.grey[200], // Set the background color to gray
    child: MyBagPage(),
    )
      ),
    );
  }
}

class MyBagPage extends StatefulWidget {
  @override
  _MyBagPageState createState() => _MyBagPageState();
}

class _MyBagPageState extends State<MyBagPage> {
  int itemCount = 0; // Initialize with the initial item count
  double itemPrice = 0; // Initialize with the item price

  int pullOverItem = 0;
  int tshirt = 0;
  int sprotDress = 0;

  void showCongratulationSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Congratulations! Your order has been placed.'),
      ),
    );
  }

  void _updateItem(int item, double price) {
    setState(() {
      itemCount += item;
      itemPrice += price;
    });
  }

  Widget _buildProductCard(
      String imageUrl,
      String title,
      String color,
      String size,
      double price,
      int item,
      void Function(int, double) updateItem) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey, width: 1.0),
      ),
      margin: EdgeInsets.all(10),
      child: ListTile(
        contentPadding: EdgeInsets.all(20),
        leading: Image.network(
          imageUrl, // Use the imageUrl for the image
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text("Color: "),
                RichText(
                  text: TextSpan(
                    text: color,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 10),
                Text("Size: "),
                RichText(
                  text: TextSpan(
                    text: size,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    if (item > 0) {
                      updateItem(-1, -price);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    backgroundColor: Colors.white,
                    elevation: 5,
                    shadowColor: Colors.black,
                  ),
                  child: Icon(Icons.remove, color: Colors.black),
                ),
                Text(item.toString()),
                ElevatedButton(
                  onPressed: () {
                    updateItem(1, price);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    backgroundColor: Colors.white,
                    elevation: 5,
                    shadowColor: Colors.black,
                  ),
                  child: Icon(Icons.add, color: Colors.black),
                ),
                Expanded(
                  child: Text(
                    "\$$price",
                    textAlign: TextAlign.right,
                  ),
                )
              ],
            )
          ],
        ),
        trailing: TextButton(
          onPressed: () {},
          child: Icon(
            Icons.more_vert,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            Column(
              children: [
                _buildProductCard(
                  "https://images.unsplash.com/photo-1523381294911-8d3cead13475?ixlib=rb-4.0.3&ixid=M3xMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
                  "Pullover",
                  "Black",
                  "L",
                  70.0,
                  pullOverItem,
                      (int item, double price) {
                    setState(() {
                      pullOverItem += item;
                      itemCount += item;
                      itemPrice += price;
                    });
                  },
                ),
                _buildProductCard(
                  "https://images.unsplash.com/photo-1523381294911-8d3cead13475?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
                  "T-Shirt",
                  "Gray",
                  "L",
                  50.0,
                  tshirt,
                      (int item, double price) {
                    setState(() {
                      tshirt += item;
                      itemCount += item;
                      itemPrice += price;
                    });
                  },
                ),
                _buildProductCard(
                  "https://images.unsplash.com/photo-1598033129183-c4f50c736f10?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1925&q=80",
                  "Sport Dress",
                  "Black",
                  "M",
                  60.0,
                  sprotDress,
                      (int item, double price) {
                    setState(() {
                      sprotDress += item;
                      itemCount += item;
                      itemPrice += price;
                    });
                  },
                ),
              ],
            ),
            // Add more ListTiles or other content as needed
          ],
        ),
        Positioned(
          bottom: 6,
          left: 6,
          right: 6,
          child: Column(
            children: [
              ListTile(
                title: Text("Total Amount"),
                trailing: Text(
                    "\$${itemPrice.toStringAsFixed(2)}"), // Display the total amount
              ),
              InkWell(
                onTap: () {
                  showCongratulationSnackbar(context);
                },
                child: Container(
                  height: 60, // Increase the height as needed
                  decoration: BoxDecoration(
                    color: Colors.red, // Background color of the container
                    borderRadius: BorderRadius.circular(40), // Circular corners
                  ),
                  child: Center(
                    child: Text(
                      "Check Out",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}



