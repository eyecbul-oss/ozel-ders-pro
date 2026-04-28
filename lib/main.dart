
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  Intl.defaultLocale = 'tr_TR';
  runApp(const OzelDersProApp());
}

class C {
  static const bg = Color(0xFFFAF9F5);
  static const ink = Color(0xFF171827);
  static const mute = Color(0xFF737080);
  static const purple = Color(0xFF6048E8);
  static const purpleSoft = Color(0xFFF1EEFF);
  static const green = Color(0xFF1DBF84);
  static const greenSoft = Color(0xFFE8FFF5);
  static const orange = Color(0xFFF3A72F);
  static const red = Color(0xFFE65353);
  static const pink = Color(0xFFD95278);
  static const blue = Color(0xFF5E6AF2);
}

class Student {
  final String name;
  final String subject;
  final String phone;
  final String plan;
  final int lessons;
  final double fee;
  final double balance;
  final double collected;
  final Color color;

  const Student({
    required this.name,
    required this.subject,
    required this.phone,
    required this.plan,
    required this.lessons,
    required this.fee,
    required this.balance,
    required this.collected,
    required this.color,
  });
}

class Lesson {
  final String date;
  final String day;
  final String name;
  final String time;
  final String subject;
  final String status;
  final int duration;
  final double amount;

  const Lesson({
    required this.date,
    required this.day,
    required this.name,
    required this.time,
    required this.subject,
    required this.status,
    required this.duration,
    required this.amount,
  });
}

class Payment {
  final String name;
  final String date;
  final String method;
  final double amount;

  const Payment({
    required this.name,
    required this.date,
    required this.method,
    required this.amount,
  });
}

final List<Student> students = [
  const Student(name: 'Ada', subject: 'Yabancı dil', phone: '0505 826 69 49', plan: '4 ders', lessons: 7, fee: 2500, balance: 0, collected: 2500, color: C.orange),
  const Student(name: 'Aslı Bulut', subject: '12. sınıf', phone: '0505 111 22 33', plan: 'Aylık', lessons: 1, fee: 0, balance: 0, collected: 0, color: C.pink),
  const Student(name: 'Azra', subject: 'Yabancı dil', phone: '0505 222 33 44', plan: 'Aylık', lessons: 0, fee: 2500, balance: 0, collected: 0, color: Color(0xFFF27A30)),
  const Student(name: 'Batuhan', subject: '—', phone: '0505 333 44 55', plan: 'Aylık', lessons: 1, fee: 10000, balance: 0, collected: 0, color: Color(0xFF55BC88)),
  const Student(name: 'Beray', subject: 'Yabancı dil', phone: '0505 444 55 66', plan: 'Aylık', lessons: 0, fee: 2000, balance: 0, collected: 0, color: C.blue),
  const Student(name: 'Yağız Asıl', subject: '12. sınıf', phone: '0505 555 66 77', plan: 'Aylık', lessons: 0, fee: 0, balance: 0, collected: 0, color: C.pink),
  const Student(name: 'Duru Oğlakçı', subject: '10. sınıf', phone: '0505 777 88 99', plan: '8 ders', lessons: 0, fee: 10000, balance: 0, collected: 0, color: Color(0xFFF47A2A)),
];

final List<Lesson> lessons = [
  const Lesson(date: '25', day: 'Cmt', name: 'Melih', time: '19:30', subject: '12. sınıf', status: 'Yapılmadı', duration: 60, amount: 1250),
  const Lesson(date: '25', day: 'Cmt', name: 'Duru Oğlakçı', time: '18:30', subject: '10. sınıf', status: 'Yapılmadı', duration: 60, amount: 1250),
  const Lesson(date: '24', day: 'Cum', name: 'Ada', time: '10:30', subject: 'Yabancı dil', status: 'Yapıldı', duration: 60, amount: 2500),
  const Lesson(date: '17', day: 'Cum', name: 'Ada', time: '10:30', subject: 'Yabancı dil', status: 'Yapıldı', duration: 60, amount: 2500),
];

final List<Payment> payments = [
  const Payment(name: 'Ada', date: '26 Nisan 2026', method: 'Nakit', amount: 2500),
];

double get totalCollected => payments.fold(0, (sum, item) => sum + item.amount);
double get totalBalance => students.fold(0, (sum, item) => sum + item.balance);
double get estimatedIncome => 31000;

String tl(num value) {
  final formatter = NumberFormat.currency(locale: 'tr_TR', symbol: '₺', decimalDigits: 0);
  return formatter.format(value);
}

String initials(String name) {
  final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
  if (parts.isEmpty) return '?';
  if (parts.length == 1) return parts.first.characters.first.toUpperCase();
  return (parts[0].characters.first + parts[1].characters.first).toUpperCase();
}

String normalizePhone(String raw) {
  final digits = raw.replaceAll(RegExp(r'[^0-9]'), '');
  if (digits.startsWith('90')) return digits;
  if (digits.startsWith('0') && digits.length >= 11) return '90${digits.substring(1)}';
  if (digits.length == 10) return '90$digits';
  return digits;
}

Future<void> openWhatsApp(BuildContext context, Student s) async {
  final phone = normalizePhone(s.phone);
  final message = Uri.encodeComponent('Merhaba ${s.name}, özel ders programınız hakkında bilgi vermek istiyorum.');
  final candidates = [
    Uri.parse('whatsapp://send?phone=$phone&text=$message'),
    Uri.parse('https://wa.me/$phone?text=$message'),
  ];

  for (final url in candidates) {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
      return;
    }
  }

  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('WhatsApp açılamadı. Telefonda WhatsApp yüklü mü kontrol edin.')),
    );
  }
}

class OzelDersProApp extends StatelessWidget {
  const OzelDersProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Özel Ders Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: C.bg,
        colorScheme: ColorScheme.fromSeed(seedColor: C.purple),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: C.bg,
          foregroundColor: C.ink,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: C.ink),
        ),
        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: C.purpleSoft,
          labelTextStyle: WidgetStatePropertyAll(TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: C.purple,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            textStyle: const TextStyle(fontWeight: FontWeight.w900),
          ),
        ),
      ),
      home: const SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 900), () {
      if (mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Shell()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.purple,
      body: Center(
        child: Container(
          width: 315,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(34)),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 44,
                backgroundColor: C.purpleSoft,
                child: Text('ÖD', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: C.purple)),
              ),
              SizedBox(height: 18),
              Text('Özel Ders Pro', textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
              SizedBox(height: 8),
              Text('by SezR', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: C.purple)),
            ],
          ),
        ),
      ),
    );
  }
}

class Shell extends StatefulWidget {
  const Shell({super.key});

  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      PanoPage(go: (i) => setState(() => index = i)),
      const StudentsPage(),
      const LessonsPage(),
      const PaymentsPage(),
    ];

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        height: 72,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.grid_view_outlined), selectedIcon: Icon(Icons.grid_view), label: 'Pano'),
          NavigationDestination(icon: Icon(Icons.group_outlined), selectedIcon: Icon(Icons.group), label: 'Öğrenciler'),
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: 'Dersler'),
          NavigationDestination(icon: Icon(Icons.credit_card_outlined), selectedIcon: Icon(Icons.credit_card), label: 'Ödemeler'),
        ],
      ),
    );
  }
}

class Top extends StatelessWidget {
  final String small;
  final String big;
  final List<Widget> actions;

  const Top({super.key, required this.small, required this.big, this.actions = const []});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 48, 20, 14),
      child: Row(
        children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(small, style: const TextStyle(fontSize: 14, color: C.mute, fontWeight: FontWeight.w500)),
              Text(big, style: const TextStyle(fontSize: 36, height: .95, fontWeight: FontWeight.w900)),
            ]),
          ),
          ...actions,
        ],
      ),
    );
  }
}

class SoftCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final EdgeInsets padding;

  const SoftCard({
    super.key,
    required this.child,
    this.color = Colors.white,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.black.withOpacity(.06)),
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}

class StatBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;
  final bool filled;

  const StatBox({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = filled ? Colors.white : C.ink;
    return SoftCard(
      color: filled ? color : Colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CircleAvatar(
          backgroundColor: filled ? Colors.white.withOpacity(.18) : color.withOpacity(.13),
          foregroundColor: filled ? Colors.white : color,
          child: Icon(icon, size: 20),
        ),
        const SizedBox(height: 12),
        Text(title, style: TextStyle(color: filled ? Colors.white70 : C.mute, fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        FittedBox(
          alignment: Alignment.centerLeft,
          fit: BoxFit.scaleDown,
          child: Text(value, style: TextStyle(color: textColor, fontSize: 24, fontWeight: FontWeight.w900)),
        ),
      ]),
    );
  }
}

class MenuBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const MenuBox({super.key, required this.icon, required this.title, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: SoftCard(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
          CircleAvatar(backgroundColor: color.withOpacity(.13), foregroundColor: color, child: Icon(icon)),
          const SizedBox(height: 10),
          Text(title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w800)),
        ]),
      ),
    );
  }
}

class PanoPage extends StatelessWidget {
  final void Function(int) go;

  const PanoPage({super.key, required this.go});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        Top(
          small: 'Salı, 28 Nisan',
          big: 'Pano',
          actions: [
            IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportsPage())), icon: const Icon(Icons.description_outlined)),
            IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage())), icon: const Icon(Icons.settings_outlined)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1.18,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              const StatBox(icon: Icons.wb_sunny_outlined, title: 'Bugünkü ders', value: '0', color: C.purple),
              StatBox(icon: Icons.trending_up, title: 'Bu ay tahmini gelir', value: tl(estimatedIncome), color: C.green),
              StatBox(icon: Icons.account_balance_wallet_outlined, title: 'Ödenmemiş bakiye', value: tl(totalBalance), color: C.orange),
              StatBox(icon: Icons.group_outlined, title: 'Aktif öğrenci', value: '${students.length}', color: C.blue),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 22, 20, 10),
          child: Text('Ana menü', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1.55,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              MenuBox(icon: Icons.today_outlined, title: 'Bugünkü Dersler', color: C.purple, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TodayPage()))),
              MenuBox(icon: Icons.person_add_alt, title: 'Öğrenci Ekle', color: C.blue, onTap: () => go(1)),
              MenuBox(icon: Icons.currency_lira, title: 'Ödeme Al', color: C.green, onTap: () => go(3)),
              MenuBox(icon: Icons.calendar_month_outlined, title: 'Haftalık Takvim', color: C.purple, onTap: () => go(2)),
              MenuBox(icon: Icons.bar_chart, title: 'Raporlar', color: C.pink, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportsPage()))),
              MenuBox(icon: Icons.account_balance_wallet, title: 'Bakiyeler', color: C.orange, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BalancePage()))),
              MenuBox(icon: Icons.shield_outlined, title: 'Yedekle ve Geri Yükle', color: C.green, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage()))),
            ],
          ),
        ),
      ],
    );
  }
}

class ChipMini extends StatelessWidget {
  final IconData icon;
  final String text;

  const ChipMini({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(color: const Color(0xFFF0EEF5), borderRadius: BorderRadius.circular(18)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 14, color: C.mute),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 12, color: C.mute, fontWeight: FontWeight.w800)),
      ]),
    );
  }
}

class StudentTile extends StatelessWidget {
  final Student student;

  const StudentTile({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    final paid = student.balance == 0 && student.collected > 0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: SoftCard(
        child: Column(children: [
          InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => StudentDetailPage(student: student))),
            child: Row(children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: student.color,
                child: Text(initials(student.name), style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(student.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                  Text(student.subject, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: C.mute, fontSize: 14)),
                  const SizedBox(height: 8),
                  Wrap(spacing: 6, runSpacing: 6, children: [
                    ChipMini(icon: Icons.menu_book_outlined, text: '${student.lessons} ders'),
                    ChipMini(icon: Icons.currency_lira, text: '${tl(student.fee)} / ${student.plan}'),
                  ]),
                ]),
              ),
              const SizedBox(width: 6),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text(tl(student.balance), style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: paid ? C.green.withOpacity(.75) : C.purpleSoft, borderRadius: BorderRadius.circular(22)),
                  child: Text(paid ? 'Ödendi' : 'Sırada', style: TextStyle(color: paid ? Colors.white : C.ink, fontWeight: FontWeight.w800)),
                ),
              ]),
            ]),
          ),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(child: OutlinedButton.icon(onPressed: () => openWhatsApp(context, student), icon: const Icon(Icons.chat_bubble_outline, size: 18), label: const Text('WhatsApp'))),
            const SizedBox(width: 8),
            Expanded(child: FilledButton.icon(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => StudentDetailPage(student: student))), icon: const Icon(Icons.visibility_outlined, size: 18), label: const Text('Detay'))),
          ]),
        ]),
      ),
    );
  }
}

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = students.where((s) => '${s.name} ${s.subject}'.toLowerCase().contains(query.toLowerCase())).toList();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: C.purple,
        foregroundColor: Colors.white,
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NewStudentPage())),
        child: const Icon(Icons.add, size: 34),
      ),
      body: ListView(padding: const EdgeInsets.only(bottom: 18), children: [
        Top(small: '${students.length} kişi', big: 'Öğrenciler'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: TextField(
            onChanged: (value) => setState(() => query = value),
            decoration: InputDecoration(
              hintText: 'İsim, ders veya veli ara',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
            ),
          ),
        ),
        const SizedBox(height: 14),
        for (final s in filtered) StudentTile(student: s),
      ]),
    );
  }
}

class StudentDetailPage extends StatelessWidget {
  final Student student;

  const StudentDetailPage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    final myLessons = lessons.where((lesson) => lesson.name == student.name).toList();

    return Scaffold(
      appBar: AppBar(title: Text(student.name), actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined))]),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Row(children: [
          CircleAvatar(
            radius: 34,
            backgroundColor: student.color,
            child: Text(initials(student.name), style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(student.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
              Text(student.subject, style: const TextStyle(color: C.mute)),
              const SizedBox(height: 6),
              ChipMini(icon: Icons.check, text: student.balance == 0 ? 'Ödendi' : 'Bakiye var'),
            ]),
          ),
        ]),
        const SizedBox(height: 14),
        SoftCard(
          child: Row(children: [
            const CircleAvatar(backgroundColor: C.purpleSoft, foregroundColor: C.purple, child: Icon(Icons.currency_lira)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Ödeme planı', style: TextStyle(fontWeight: FontWeight.w900)),
                Text('${student.lessons} ders sonunda ödeme • ${tl(student.fee)}', style: const TextStyle(color: C.mute)),
              ]),
            ),
            const Text('Düzenle', style: TextStyle(color: C.purple, fontWeight: FontWeight.w900)),
          ]),
        ),
        const SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.25,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            StatBox(icon: Icons.menu_book, title: 'Toplam ders', value: '${student.lessons}', color: C.purple),
            StatBox(icon: Icons.payments, title: 'Tahsilat', value: tl(student.collected), color: C.green),
            StatBox(icon: Icons.trending_up, title: 'Kazanç', value: tl(student.fee), color: C.orange),
            StatBox(icon: Icons.wallet, title: 'Bakiye', value: tl(student.balance), color: C.green, filled: true),
          ],
        ),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: FilledButton.icon(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NewLessonPage())), icon: const Icon(Icons.add), label: const Text('Ders ekle'))),
          const SizedBox(width: 8),
          Expanded(child: OutlinedButton.icon(onPressed: () => openWhatsApp(context, student), icon: const Icon(Icons.chat_bubble_outline), label: const Text('WhatsApp'))),
        ]),
        const SizedBox(height: 12),
        const Text('Dersler', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
        for (final l in myLessons) LessonLine(lesson: l),
        if (myLessons.isEmpty) const SoftCard(child: Text('Bu öğrenci için henüz ders kaydı yok.')),
        const SizedBox(height: 14),
        FilledButton.icon(
          style: FilledButton.styleFrom(backgroundColor: C.red),
          onPressed: () {},
          icon: const Icon(Icons.delete_outline),
          label: const Text('Öğrenciyi sil'),
        ),
      ]),
    );
  }
}

class LessonsPage extends StatefulWidget {
  const LessonsPage({super.key});

  @override
  State<LessonsPage> createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> {
  bool week = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: C.purple,
        foregroundColor: Colors.white,
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NewLessonPage())),
        child: const Icon(Icons.add, size: 34),
      ),
      body: ListView(padding: const EdgeInsets.only(bottom: 22), children: [
        Top(small: week ? 'Haftalık plan' : 'Nisan 2026', big: 'Dersler'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(color: C.purpleSoft, borderRadius: BorderRadius.circular(22)),
            child: Row(children: [
              Expanded(child: SegButton(active: !week, text: 'Liste', icon: Icons.list, onTap: () => setState(() => week = false))),
              Expanded(child: SegButton(active: week, text: 'Hafta', icon: Icons.calendar_month, onTap: () => setState(() => week = true))),
            ]),
          ),
        ),
        const SizedBox(height: 14),
        if (!week) const LessonListView() else const WeekView(),
      ]),
    );
  }
}

class SegButton extends StatelessWidget {
  final bool active;
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const SegButton({super.key, required this.active, required this.text, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: 48,
        decoration: BoxDecoration(color: active ? Colors.white : Colors.transparent, borderRadius: BorderRadius.circular(18)),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontWeight: FontWeight.w900)),
        ]),
      ),
    );
  }
}

class LessonListView extends StatelessWidget {
  const LessonListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Column(children: [
      Row(children: [
        const Expanded(child: StatBox(icon: Icons.check_circle_outline, title: 'Yapılan', value: '4/29', color: C.purple)),
        const SizedBox(width: 10),
        Expanded(child: StatBox(icon: Icons.trending_up, title: 'Aylık kazanç', value: tl(10000), color: C.purple, filled: true)),
      ]),
      const SizedBox(height: 8),
      const Row(children: [
        FilterPill(text: 'Tümü', active: true),
        SizedBox(width: 8),
        FilterPill(text: 'Yapıldı', active: false),
        SizedBox(width: 8),
        FilterPill(text: 'Yapılmadı', active: false),
      ]),
      const SizedBox(height: 10),
      const DateHeader(day: '25', title: 'Nisan 2026', sub: 'Cmt • 2 ders'),
      for (final l in lessons.take(2)) LessonLine(lesson: l),
      const DateHeader(day: '24', title: 'Nisan 2026', sub: 'Cum • 7 ders'),
      for (final l in lessons.skip(2)) LessonLine(lesson: l),
    ]));
  }
}

class FilterPill extends StatelessWidget {
  final String text;
  final bool active;

  const FilterPill({super.key, required this.text, required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(color: active ? C.purple : C.purpleSoft, borderRadius: BorderRadius.circular(20)),
      child: Text(text, style: TextStyle(color: active ? Colors.white : C.ink, fontWeight: FontWeight.w900)),
    );
  }
}

class DateHeader extends StatelessWidget {
  final String day;
  final String title;
  final String sub;

  const DateHeader({super.key, required this.day, required this.title, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Row(children: [
      Container(
        width: 42,
        height: 42,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: C.ink, borderRadius: BorderRadius.circular(14)),
        child: Text(day, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
      ),
      const SizedBox(width: 12),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
        Text(sub, style: const TextStyle(color: C.mute)),
      ]),
    ]));
  }
}

class LessonLine extends StatelessWidget {
  final Lesson lesson;

  const LessonLine({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    final failed = lesson.status == 'Yapılmadı';
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: SoftCard(
        child: Row(children: [
          CircleAvatar(
            backgroundColor: C.purple.withOpacity(.85),
            child: Text(initials(lesson.name), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
          ),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(lesson.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
            Text('${lesson.time} • ${lesson.duration} dk • ${lesson.subject}', maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: C.mute)),
          ])),
          const SizedBox(width: 6),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(tl(lesson.amount), style: const TextStyle(fontWeight: FontWeight.w900)),
            Text(failed ? '× Yapılmadı' : '✓ Yapıldı', style: TextStyle(color: failed ? C.red : C.green, fontWeight: FontWeight.w800)),
          ]),
        ]),
      ),
    );
  }
}

class WeekView extends StatelessWidget {
  const WeekView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Column(children: [
      const SoftCard(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Icon(Icons.chevron_left),
          Text('27 Nisan – 3 Mayıs 2026\nBu haftaya dön', textAlign: TextAlign.center, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
          Icon(Icons.chevron_right),
        ]),
      ),
      const SizedBox(height: 10),
      SizedBox(width: double.infinity, height: 58, child: FilledButton.icon(onPressed: null, icon: const Icon(Icons.calendar_month), label: const Text('Bu haftanın 26 dersini oluştur'))),
      const SizedBox(height: 14),
      const DateHeader(day: '27', title: 'Pazartesi • Bugün', sub: '0 ders • 7 planlı'),
      for (final s in ['Berra Helvacı', 'Batuhan', 'Nil Feride', 'İpek'])
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SoftCard(child: Row(children: [
            const CircleAvatar(backgroundColor: C.purpleSoft, foregroundColor: C.purple, child: Icon(Icons.repeat)),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(s, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
              const Text('09:30 • 60 dk • Planlı', style: TextStyle(color: C.mute)),
            ])),
            const Icon(Icons.add, color: C.purple),
          ])),
        ),
    ]));
  }
}

class FieldBox extends StatelessWidget {
  final String label;
  final String value;

  const FieldBox({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(bottom: 14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(color: C.mute, fontWeight: FontWeight.w900)),
      const SizedBox(height: 6),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: Colors.black.withOpacity(.06))),
        child: Text(value, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
      ),
    ]));
  }
}

class NewLessonPage extends StatelessWidget {
  const NewLessonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Yeni Ders')),
      body: ListView(padding: const EdgeInsets.all(16), children: const [
        FieldBox(label: 'Öğrenci *', value: 'Yağız Asıl\n12. sınıf'),
        FieldBox(label: 'Tarih ve Saat *', value: '28 Nisan 2026 • 12:52'),
        Text('Süre', style: TextStyle(color: C.mute, fontWeight: FontWeight.w900)),
        SizedBox(height: 8),
        Wrap(spacing: 6, runSpacing: 6, children: [
          FilterPill(text: '30 dk', active: false),
          FilterPill(text: '45 dk', active: false),
          FilterPill(text: '60 dk', active: true),
          FilterPill(text: '90 dk', active: false),
        ]),
        SizedBox(height: 12),
        FieldBox(label: 'Ücret (₺) *', value: '0'),
        FieldBox(label: 'Not', value: 'Konu, ödev, sebep...'),
        SizedBox(height: 16),
        SizedBox(height: 58, child: FilledButton.icon(onPressed: null, icon: Icon(Icons.check), label: Text('Dersi Ekle'))),
      ]),
    );
  }
}

class NewStudentPage extends StatelessWidget {
  const NewStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Yeni Öğrenci')),
      body: ListView(padding: const EdgeInsets.all(16), children: const [
        FieldBox(label: 'Ad Soyad *', value: 'Örn. Ayşe Yılmaz'),
        FieldBox(label: 'Ders / Sınıf *', value: 'Örn. Matematik (10. sınıf)'),
        FieldBox(label: 'Telefon', value: '05xx xxx xx xx'),
        FieldBox(label: 'Paket Ücreti (₺) *', value: '8000'),
        Text('Ödeme Planı', style: TextStyle(color: C.mute, fontWeight: FontWeight.w900)),
        SizedBox(height: 8),
        SoftCard(color: C.purpleSoft, child: Text('Otomatik (programdan)\nHaftalık ders sayısına göre otomatik seçilir.', style: TextStyle(fontWeight: FontWeight.w800))),
        SoftCard(child: Text('4 ders sonunda ödeme\nHer 4 yapılan ders sonunda ücret tahakkuk eder.')),
        SoftCard(child: Text('8 ders sonunda ödeme\nHer 8 yapılan ders sonunda ücret tahakkuk eder.')),
        SoftCard(child: Text('Aylık ödeme\nAyda en az bir ders yapıldıysa o ay tahakkuk eder.')),
        SizedBox(height: 14),
        SizedBox(height: 58, child: FilledButton.icon(onPressed: null, icon: Icon(Icons.check), label: Text('Öğrenciyi Kaydet'))),
      ]),
    );
  }
}

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: C.purple,
        foregroundColor: Colors.white,
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NewPaymentPage())),
        child: const Icon(Icons.add, size: 34),
      ),
      body: ListView(padding: const EdgeInsets.only(bottom: 22), children: [
        Top(small: 'Nisan 2026', big: 'Ödemeler'),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Column(children: [
          const SoftCard(child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Icon(Icons.chevron_left),
            Text('Nisan 2026', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
            Icon(Icons.chevron_right),
          ])),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(child: StatBox(icon: Icons.calendar_month, title: 'Bu ay', value: tl(totalCollected), color: C.green, filled: true)),
            const SizedBox(width: 10),
            Expanded(child: StatBox(icon: Icons.inventory_2_outlined, title: '2026 toplam', value: tl(totalCollected), color: C.purple)),
          ]),
          const SizedBox(height: 12),
          for (final p in payments)
            SoftCard(child: Row(children: [
              CircleAvatar(radius: 28, backgroundColor: C.orange, child: Text(initials(p.name), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900))),
              const SizedBox(width: 14),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(p.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                Text('${p.date} • ${p.method}', style: const TextStyle(color: C.mute)),
              ])),
              Text('↙ ${tl(p.amount)}', style: const TextStyle(color: C.green, fontWeight: FontWeight.w900, fontSize: 18)),
            ])),
        ])),
      ]),
    );
  }
}

class NewPaymentPage extends StatelessWidget {
  const NewPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Yeni Ödeme')),
      body: ListView(padding: const EdgeInsets.all(16), children: const [
        FieldBox(label: 'Öğrenci *', value: 'Yağız Asıl\n12. sınıf'),
        FieldBox(label: 'Tarih *', value: '28 Nisan 2026'),
        FieldBox(label: 'Tutar (₺) *', value: '0'),
        Text('Yöntem', style: TextStyle(color: C.mute, fontWeight: FontWeight.w900)),
        SizedBox(height: 8),
        Wrap(spacing: 8, runSpacing: 8, children: [
          FilterPill(text: 'Nakit', active: true),
          FilterPill(text: 'Havale', active: false),
          FilterPill(text: 'Kart', active: false),
          FilterPill(text: 'Diğer', active: false),
        ]),
        SizedBox(height: 12),
        FieldBox(label: 'Not', value: 'Açıklama...'),
        SizedBox(height: 16),
        SizedBox(height: 58, child: FilledButton.icon(onPressed: null, icon: Icon(Icons.check), label: Text('Ödemeyi Ekle'))),
      ]),
    );
  }
}

class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bugünkü Dersler')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(26),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text('27 Nisan 2026', style: TextStyle(color: C.mute, fontSize: 16)),
            const Text('Bugün 0 ders', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900)),
            const SizedBox(height: 70),
            const CircleAvatar(radius: 46, backgroundColor: C.purpleSoft, child: Icon(Icons.coffee, size: 38, color: C.mute)),
            const SizedBox(height: 22),
            const Text('Bugün ders yok', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            const Text('Bugün için planlanmış dersiniz bulunmuyor.', textAlign: TextAlign.center, style: TextStyle(color: C.mute, fontSize: 16)),
            const SizedBox(height: 22),
            FilledButton.icon(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NewLessonPage())), icon: const Icon(Icons.add), label: const Text('Yeni ders ekle')),
          ]),
        ),
      ),
    );
  }
}

class BalancePage extends StatelessWidget {
  const BalancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bakiyeler')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Row(children: [
          Expanded(child: StatBox(icon: Icons.error_outline, title: 'Toplam alacak', value: tl(totalBalance), color: C.orange, filled: true)),
          const SizedBox(width: 10),
          Expanded(child: StatBox(icon: Icons.check, title: 'Tahsilat', value: tl(totalCollected), color: C.green, filled: true)),
        ]),
        const SizedBox(height: 12),
        for (final s in students)
          SoftCard(child: Column(children: [
            Row(children: [
              CircleAvatar(radius: 28, backgroundColor: s.color, child: Text(initials(s.name), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900))),
              const SizedBox(width: 14),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(s.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                Text('${s.plan} • Tahakkuk ${tl(s.fee)} • Tahsilat ${tl(s.collected)}', style: const TextStyle(color: C.mute)),
              ])),
              Text(tl(s.balance), style: const TextStyle(color: C.green, fontWeight: FontWeight.w900, fontSize: 18)),
            ]),
            const Divider(),
            SizedBox(width: double.infinity, child: TextButton.icon(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NewPaymentPage())), icon: const Icon(Icons.currency_lira), label: const Text('Ödeme ekle'))),
          ])),
      ]),
    );
  }
}

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Raporlar')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        const Text('Aylık Rapor', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
        const SizedBox(height: 12),
        SoftCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('NİSAN 2026', style: TextStyle(color: C.mute, fontWeight: FontWeight.w900)),
          const SizedBox(height: 12),
          const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            ReportStat(title: 'Yapılan Ders', value: '4'),
            ReportStat(title: 'Kazanç', value: '10.000 ₺'),
            ReportStat(title: 'Tahsilat', value: '2.500 ₺'),
          ]),
          const SizedBox(height: 14),
          Row(children: const [
            Expanded(child: FilledButton(onPressed: null, child: Text('PDF'))),
            SizedBox(width: 10),
            Expanded(child: OutlinedButton(onPressed: null, child: Text('Excel/CSV'))),
          ]),
        ])),
        const SizedBox(height: 22),
        const Text('Öğrenci Bazında', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
        const SizedBox(height: 10),
        for (final s in students)
          SoftCard(child: Row(children: [
            CircleAvatar(radius: 28, backgroundColor: s.color, child: Text(initials(s.name), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900))),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(s.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
              Text('${s.lessons} ders • ${tl(s.fee)} kazanç', style: const TextStyle(color: C.mute)),
            ])),
            const Icon(Icons.picture_as_pdf, color: C.purple),
          ])),
      ]),
    );
  }
}

class ReportStat extends StatelessWidget {
  final String title;
  final String value;

  const ReportStat({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title.toUpperCase(), style: const TextStyle(color: C.mute, fontSize: 12, fontWeight: FontWeight.w900)),
      Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
    ]);
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ayarlar')),
      body: ListView(padding: const EdgeInsets.all(16), children: const [
        Text('Veri Yedekleme', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
        SizedBox(height: 12),
        SoftCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Cihazınızda güvenli', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
          Text('Tüm veriler yalnızca telefonunuzda saklanır. Düzenli yedek almanız önerilir.', style: TextStyle(color: C.mute)),
          SizedBox(height: 12),
          Row(children: [
            Expanded(child: FilledButton(onPressed: null, child: Text('Yedek Al'))),
            SizedBox(width: 10),
            Expanded(child: OutlinedButton(onPressed: null, child: Text('Yedek Yükle'))),
          ]),
        ])),
        SizedBox(height: 22),
        Text('Hakkında', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
        SizedBox(height: 12),
        SoftCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Özel Ders Pro', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
          SizedBox(height: 8),
          Text('Sürüm: 2.0.0'),
          Text('Geliştirici: Sezer Bulut'),
          Text('Telefon: (505) 826 69 49'),
          Text('E-posta: sezerbulut@hotmail.com'),
          SizedBox(height: 10),
          Align(alignment: Alignment.centerRight, child: Text('by SezR', style: TextStyle(color: C.purple, fontWeight: FontWeight.w900))),
        ])),
      ]),
    );
  }
}
