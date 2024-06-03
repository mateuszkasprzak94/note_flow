import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_flow/app/core/constant.dart';
import 'package:note_flow/app/core/enums.dart';
import 'package:note_flow/app/features/homepage/cubit/home_cubit.dart';
import 'package:note_flow/app/features/homepage/widgets/floating_button.dart';
import 'package:note_flow/app/features/homepage/widgets/home_page_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Notes',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: true,
        shadowColor: Colors.black,
        elevation: 10,
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
            final pinnedNotes = state.pinnedNotes;
            final otherNotes = state.otherNotes;
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
                  color: kPrimaryIcon,
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
                      color: kPrimaryIcon,
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
              return HomePageBodyWidget(
                  pinnedNotes: pinnedNotes, otherNotes: otherNotes);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
