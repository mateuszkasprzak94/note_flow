import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_flow/app/core/constant.dart';
import 'package:note_flow/app/features/homepage/cubit/home_cubit.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: kGradient,
          ),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
          ),
        ),
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, bottom: 25),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 70,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('assets/logo_foreground.png'),
            ),
            const SizedBox(height: 15),
            Text(
              'NoteFlow',
              style: GoogleFonts.lora(
                letterSpacing: 1,
                fontSize: MediaQuery.of(context).size.width * 0.09,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Wrap(
          runSpacing: 15,
          children: [
            ListTile(
              leading: const Icon(
                Icons.notes,
                color: Colors.black,
              ),
              title: const Text(
                'All Notes',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                context.read<HomeCubit>().start();
                Navigator.pop(context);
              },
            ),
            const Divider(
              color: Colors.black,
              thickness: 1,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Labes',
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.lightbulb_outline_sharp,
                color: Colors.black,
              ),
              title: const Text(
                'Inspiration',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                context.read<HomeCubit>().filterByTag('inspirationTag');

                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.favorite_border,
                color: Colors.black,
              ),
              title: const Text(
                'Personal',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                context.read<HomeCubit>().filterByTag('personalTag');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.business_center_outlined,
                color: Colors.black,
              ),
              title: const Text(
                'Work',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                context.read<HomeCubit>().filterByTag('workTag');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
}
