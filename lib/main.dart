// 1. import package
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/products/product_page.dart';
import './tabbarview/tabbarview1.dart' as home;
import './tabbarview/tabbarview2.dart' as gallery;
import './tabbarview/tabbarview3.dart' as account;

// 2. void main
void main() {
  // runApp(MyApp());
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.red),
    title: 'Flutter First App',
    home: const MyApp(), // stateful
  )); // entry point
}

/* 
  3. deklarasi class
    2 jenis widget class :
    > Stateless widget  > widget dgn nilai statis
    > Stateful widget   > widget dgn nilai dinamis  

*/


// StatefulWidget widget
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

// Stateless widget
class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {

  static const TextStyle titleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle letterStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(70, 132, 153, 1),
  );

  TabController? controller;

  // initState adalah fungsi utk inisialisasi nilai awal, pasti dijalankan 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Material App
    // kalo widget harus huruf besar karena class/ widget, kalau huruf kecil adalah atribute/properties
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false, // debug
    //   theme: ThemeData(
    //     primarySwatch: Colors.red // warna tema dasar
    //   ),
    //   title: "Flutter First App",
    //   home: Scaffold(
    //     // appBar: AppBar(
    //     //   title: const Text('Homepage'),
    //     //   titleSpacing: -10,
    //     //   backgroundColor: const Color.fromRGBO(53,178,206, 1),
    //     //   leading: const Icon(Icons.home), 
    //     //   /* 
    //     //     leading : didepan
    //     //     actions : dibelakang

    //     //     Icon : tdk bisa mengeluarkan action
    //     //     IconButton : bisa mengeluarkan action / ditekan
    //     //   */
    //     //   actions: <Widget>[
    //     //     IconButton(
    //     //       onPressed: () => print("Search Page"), 
    //     //       icon: const Icon(Icons.search)
    //     //     ), IconButton(
    //     //       onPressed: () => print("Setting Page"), 
    //     //       icon: const Icon(Icons.settings)
    //     //     )
    //     //   ],
    //     // ),
    //     drawer: Drawer(
    //       // ListView adalah widget yg bisa menampilkan isi dari list
    //       child: ListView(
    //         padding: EdgeInsets.zero,
    //         children:  <Widget>[
    //           myCustomDrawerHeader(),
    //           const Divider(),
    //           ListTile(
    //             title: const Text("Home", style: letterStyle),
    //             leading: const Icon(Icons.home),
    //             onTap: () => print("Homepage is opened"),
    //           ),
    //           ListTile(
    //             title: const Text("Products", style: letterStyle),
    //             leading: const Icon(Icons.shopify),
    //             // onTap: () => print("Productpage is opened"),
    //             onTap: () {
    //               // open ProductPage()
    //               Navigator.push(context, MaterialPageRoute(
    //                 builder: (context) => ProductPage(),
    //                 )
    //               );
    //             },
    //           ),
    //           ListTile(
    //             title: const Text("Account", style: letterStyle),
    //             leading: const Icon(Icons.person),
    //             onTap: () => print("Accountpage is opened"),
    //           )
    //         ],
    //       ),
    //     ),
    //     body: NestedScrollView(
    //       headerSliverBuilder: (context, innerBoxIsScrolled) {
    //         return <Widget>[
    //           /* SliverAppBar 
    //           */
    //           SliverAppBar(
    //             expandedHeight: 200,
    //             floating: true,
    //             snap: true,
    //             pinned: true,
    //             backgroundColor: const Color.fromRGBO(53,178,206, 1),
    //             leading: 
    //             IconButton(
    //               // onPressed: () => print("Open Menu"), 
    //               onPressed: () => Scaffold.of(context).openDrawer(), 
    //               icon: const Icon(Icons.menu),
    //             ), 
    //             actions: <Widget>[
    //               IconButton(
    //                 onPressed: () => print("Search Page"), 
    //                 icon: const Icon(Icons.search)
    //               ), IconButton(
    //                 onPressed: () => print("Setting Page"), 
    //                 icon: const Icon(Icons.settings)
    //               )
    //             ],
    //             flexibleSpace: const FlexibleSpaceBar(
    //               centerTitle: true,
    //               title: Text('Custom AppBar'),
    //               background: Image(
    //                 image: NetworkImage('https://cdn.pixabay.com/photo/2017/04/11/15/55/animals-2222007_960_720.jpg'),
    //                 fit: BoxFit.cover,
    //               ),
    //             ),
    //           )
    //         ];
    //       }, 
    //       // body: Center(
    //       //     child:Column(
    //       //       mainAxisAlignment: MainAxisAlignment.center,
    //       //       children: const <Widget>[
    //       //         Text('Custom Appbar with Sliver')
    //       //       ],
    //       //     )
    //       // )
    //       body: TabBarView(
    //         controller: controller,
    //         children: const <Widget>[
    //             home.TabBarView1(),
    //             gallery.TabBarView2(),
    //             account.TabBarView3()
    //           ]
    //         ),
    //     ),
    //     // bottomNavigationBar: BottomNavigationBar(
    //     //   items: const <BottomNavigationBarItem> [
    //     //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    //     //       BottomNavigationBarItem(icon: Icon(Icons.camera), label: 'Gallery'),
    //     //       BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
    //     //   ],
    //     // ),
    //     bottomNavigationBar: Material(
    //       color: const Color.fromRGBO(53,178,206, 1),
    //       child: TabBar(
    //         controller: controller,
    //         tabs: const <Tab>[
    //           Tab(icon: Icon(Icons.home)),
    //           Tab(icon: Icon(Icons.photo)),
    //           Tab(icon: Icon(Icons.person)),
    //         ]
    //         ),
    //     ),
    //     // body: Center(
    //     //   /* child : 1 widget
    //     //    children : banyak widget */
    //     //   child: Column(
    //     //     mainAxisAlignment: MainAxisAlignment.center,
    //     //     children: const <Widget>[
    //     //       Image(
    //     //         // image: NetworkImage('https://pixabay.com/id/photos/anjing-corgi-imut-satwa-4988986/'),
    //     //         image: AssetImage('images/image-1.jpg'),
    //     //         width: 250,
    //     //         height: 250
    //     //       ),
    //     //       Text('Simple App', style: TextStyle(
    //     //         fontSize: 24,
    //     //         fontWeight: FontWeight.bold,
    //     //         color: Colors.red
    //     //       )),
    //     //       Text('Learn Flutter from Scratch'),
    //     //       Text('Flutter by Inixindo')
    //     //     ],
    //     //   ),
    //     // ),
        
    //   ),
    // );
    return Scaffold(
      drawer: Drawer(child: getListView(context)),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200,
              floating: true,
              snap: true,
              pinned: true,
              backgroundColor: const Color.fromRGBO(70, 132, 153, 1),
              leading: IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: const Icon(Icons.menu)),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => print("Open search"),
                ),
              ],
              flexibleSpace: const FlexibleSpaceBar(
                centerTitle: true,
                title: Text('Custom Appbar'),
                background: Image(
                  image: NetworkImage(
                      'https://cdn.pixabay.com/photo/2015/02/02/11/09/office-620822_960_720.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            )
          ];
        },
        body: TabBarView(
          controller: controller,
          children: const <Widget>[
            home.TabBarView1(),
            gallery.TabBarView2(),
            account.TabBarView3(),
          ],
        ),
      ),
      bottomNavigationBar: Material(
        color: const Color.fromRGBO(70, 132, 153, 1),
        child: TabBar(
          controller: controller,
          tabs: const <Tab>[
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.photo)),
            Tab(icon: Icon(Icons.person)),
          ],
        ),
      ),
    );
  }

   // buat widget getListView()
  Widget getListView(BuildContext context) {
    var listView = ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        myCustomDrawerHeader(),
        const Divider(),
        ListTile(
          title: const Text('Home', style: letterStyle),
          leading: const Icon(Icons.home),
          onTap: () => print('Homepage is opened'),
        ),
        ListTile(
          title: const Text('Products', style: letterStyle),
          leading: const Icon(Icons.shopify),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductPage(),
              ),
            );
            print("Membuka ProductPage");
          },
        ),
        ListTile(
          title: const Text('Account', style: letterStyle),
          leading: const Icon(Icons.person),
          onTap: () => print('Accountpage is opened'),
        ),
      ],
    );
    return listView;
  }

  // widget harus ada return, class tdk 
  Widget myCustomDrawerHeader() {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('/images/image-3.jpg'),
          fit: BoxFit.fill
        ),
      ),
      child: Stack(
        children: const <Widget>[
          Positioned(
            left: 20,
            bottom:  90,
            child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                'https://cdn.pixabay.com/photo/2022/05/18/17/50/dog-7205842_960_720.jpg'
              ),
            ),
          ),
          Positioned(
            left: 20,
            bottom:  30,
            child: Text("Custom Header Drawer", style: titleStyle,),
          )
        ],
      ),
    );
  }
}

