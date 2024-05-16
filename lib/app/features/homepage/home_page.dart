import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_flow/app/core/constant.dart';
import 'package:note_flow/app/core/enums.dart';
import 'package:note_flow/app/features/add_note/add_note_page.dart';
import 'package:note_flow/app/features/homepage/cubit/home_cubit.dart';
import 'package:note_flow/app/features/homepage/widgets/floating_button.dart';
import 'package:note_flow/app/features/homepage/widgets/note_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Notes',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: true,
      ),
      floatingActionButton: const FloatingButton(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: kGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final notes = state.items;
            final errorMessage = state.errorMessage ?? 'Unknown error';
            if (state.status == Status.error) {
              return Center(
                child: Text(errorMessage),
              );
            }

            if (state.status == Status.loading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              );
            }

            if (notes.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.note_add,
                      color: Color(0xFFFBEEDE),
                      size: 50,
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Your Notes List is Empty',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              );
            }

            if (state.status == Status.success) {
              return ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) => NoteWidget(
                  noteModel: notes[index],
                  onTap: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddNotePage(
                          noteModel: notes[index],
                        ),
                      ),
                    );
                  },
                  onLongPress: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(
                              'Are you sure you want to delete this note?'),
                          actions: [
                            ElevatedButton(
                              onPressed: () async {
                                context.read<HomeCubit>().delete(notes[index]);

                                Navigator.pop(context);
                              },
                              child: const Text('Yes'),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('No'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
