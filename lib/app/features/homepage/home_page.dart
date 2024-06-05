import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_flow/app/core/constant.dart';
import 'package:note_flow/app/core/enums.dart';
import 'package:note_flow/app/features/homepage/cubit/home_cubit.dart';
import 'package:note_flow/app/features/homepage/widgets/floating_button.dart';
import 'package:note_flow/app/features/homepage/widgets/home_page_body.dart';
import 'package:note_flow/app/features/homepage/widgets/searchbar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() => setState(() {}));
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color(0xFF63686B),
          title: Text(
            'Notes',
            style: GoogleFonts.lato(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 35),
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
          child: Column(
            children: [
              SearchBarWidget(controller: _controller),
              Expanded(
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
                        searchTerm: _controller.text,
                        pinnedNotes: pinnedNotes,
                        otherNotes: otherNotes,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
