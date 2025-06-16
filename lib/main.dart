// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Wisata Indonesia',
//       theme: ThemeData(
//         primarySwatch: Colors.teal,
//       ),
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   final List<Map<String, String>> wisataList = [
//     {
//       'nama': 'Candi Borobudur',
//       'deskripsi': 'Candi Borobudur adalah candi Buddha terbesar di dunia yang terletak di Magelang, Jawa Tengah. Dibangun pada abad ke-8 oleh Dinasti Syailendra, candi ini memiliki lebih dari 2.600 panel relief dan 500 lebih arca Buddha yang menggambarkan perjalanan spiritual menuju pencerahan. Candi ini menjadi salah satu situs warisan dunia UNESCO. Waktu terbaik untuk berkunjung adalah pagi hari saat matahari terbit, agar bisa menikmati suasana tenang dan pemandangan alam sekitar.'
//     },
//     {
//       'nama': 'Pantai Kuta',
//       'deskripsi': 'Pantai Kuta merupakan destinasi wisata paling populer di Bali yang terkenal dengan pasir putihnya yang lembut dan ombak yang cocok untuk berselancar, terutama bagi pemula. Selain itu, Pantai Kuta juga menjadi tempat favorit untuk menikmati matahari terbenam yang memukau. Di sepanjang pantai tersedia banyak hotel, restoran, bar, dan pusat perbelanjaan, menjadikan kawasan ini sangat ramai dan hidup, terutama saat sore dan malam hari.'
//     },
//     {
//       'nama': 'Raja Ampat',
//       'deskripsi': 'Raja Ampat terletak di Papua Barat dan merupakan salah satu destinasi menyelam terbaik di dunia. Kepulauan ini memiliki lebih dari 1.500 pulau kecil dan menjadi rumah bagi keanekaragaman hayati laut yang sangat tinggi. Air lautnya jernih, terumbu karangnya masih alami, dan terdapat berbagai spesies laut yang langka. Selain menyelam dan snorkeling, pengunjung juga bisa mendaki bukit untuk menikmati pemandangan pulau-pulau dari atas. Raja Ampat sangat cocok bagi wisatawan pencinta alam dan petualangan.'
//     },
//     {
//       'nama': 'Danau Toba',
//       'deskripsi': 'Danau Toba adalah danau vulkanik terbesar di Asia Tenggara, terletak di Sumatera Utara. Di tengah danau ini terdapat Pulau Samosir, yang merupakan pusat kebudayaan Batak. Pengunjung bisa menikmati keindahan danau yang luas, udara sejuk, serta keramahan masyarakat lokal. Aktivitas yang bisa dilakukan antara lain naik sepeda keliling pulau, mengunjungi desa adat Batak, atau sekadar bersantai di tepi danau. Danau Toba menawarkan pengalaman wisata alam sekaligus budaya yang kaya.'
//     },
//     {
//       'nama': 'Taman Nasional Bromo',
//       'deskripsi': 'Taman Nasional Bromo Tengger Semeru merupakan kawasan wisata alam di Jawa Timur yang terkenal dengan panorama Gunung Bromo yang aktif dan pemandangan matahari terbitnya yang spektakuler. Pengunjung biasanya naik jeep menuju Bukit Penanjakan untuk menyaksikan sunrise, lalu melanjutkan perjalanan menyusuri Lautan Pasir dan mendaki anak tangga menuju kawah Bromo. Suhu di pagi hari cukup dingin, jadi disarankan membawa jaket. Tempat ini sangat cocok bagi pecinta alam dan fotografi.`'
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Daftar Objek Wisata')),
//       body: ListView.builder(
//         itemCount: wisataList.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(wisataList[index]['nama']!),
//             trailing: Icon(Icons.arrow_forward),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => DetailPage(
//                     nama: wisataList[index]['nama']!,
//                     deskripsi: wisataList[index]['deskripsi']!,
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class DetailPage extends StatelessWidget {
//   final String nama;
//   final String deskripsi;

//   DetailPage({required this.nama, required this.deskripsi});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(nama)),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Text(
//           deskripsi,
//           style: TextStyle(fontSize: 18),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'database.dart'; // Import the DatabaseHelper class
import 'user.dart'; // Import the User class

void main() async {
  // Initialize the database and insert users
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.initDb();
  await DatabaseHelper.instance.initializeUsers();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Management',
      home: UserList(),
    );
  }
}

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    final userMaps = await DatabaseHelper.instance.queryAllUsers();
    setState(() {
      _users = userMaps.map((userMap) => User.fromMap(userMap)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('daftar destinasi wisata'),
        backgroundColor: Colors.lightGreen,
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          return ListTile(
            judul: Text(_users[index].judul),
            deskripsi: Text(_users[index].deskripsi),
          );
        },
      ),
    );
  }
}