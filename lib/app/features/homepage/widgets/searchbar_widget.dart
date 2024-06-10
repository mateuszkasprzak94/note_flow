import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_flow/app/features/homepage/cubit/home_cubit.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
    required TextEditingController controller,
  }) : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    final dh = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Container(
          color: Colors.transparent,
          width: double.infinity,
          height: dh * 0.086,
        ),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            color: Color(0xFF63686B),
          ),
          width: double.infinity,
          height: dh * 0.06,
        ),
        Positioned(
          top: 20,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              style: const TextStyle(color: Colors.black),
              controller: _controller,
              onChanged: (query) {
                context.read<HomeCubit>().searchNotes(query);
              },
              maxLines: 1,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(5),
                fillColor: Colors.white,
                filled: true,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                suffixIcon: _controller.text.isEmpty
                    ? Container(width: 0)
                    : IconButton(
                        onPressed: () {
                          _controller.clear();
                          context.read<HomeCubit>().start();
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      ),
                hintText: 'Search your notes',
                hintStyle: const TextStyle(
                  color: Colors.black87,
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 0.75,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
