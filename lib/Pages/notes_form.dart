import 'package:flutter/material.dart';

class NotesForm extends StatelessWidget {
  final String? title;
  final String? description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  const NotesForm({
    Key? key,
    this.title = '',
    this.description = '',
    required this.onChangedTitle,
    required this.onChangedDescription,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Form(
            child: Column(
              children: [
                buildTitle(),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    maxLines: 5,
                    initialValue: description,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Todo",
                    ),
                    validator: (title) =>
                    title != null && title.isEmpty
                        ? 'Required to fill'
                        : null,
                    onChanged: onChangedDescription,
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        )
    );
  }

  Widget buildTitle() =>
      TextFormField(
        maxLines: 1,
        initialValue: title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Title',
          hintStyle: TextStyle(
              color: Colors.black
          ),
        ),
        validator: (title) =>
        title != null && title.isEmpty ? 'The title cannot be empty' : null,
        onChanged: onChangedTitle,
      );

}

  // @override
  // Widget build(BuildContext context) => SingleChildScrollView(
  //   child: Padding(
  //     padding: const EdgeInsets.all(16),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         buildTitle(),
  //         const SizedBox(height: 8),
  //         buildDescription(),
  //         const SizedBox(height: 16),
  //       ],
  //     ),
  //   ),
  // );



//   Widget buildTitle() => TextFormField(
//     maxLines: 1,
//     initialValue: title,
//     style: const TextStyle(
//       color: Colors.white,
//       fontWeight: FontWeight.bold,
//       fontSize: 24,
//     ),
//     decoration: const InputDecoration(
//       border: InputBorder.none,
//       hintText: 'Title',
//       hintStyle: TextStyle(
//           color: Colors.white
//       ),
//     ),
//     validator: (title) =>
//     title != null && title.isEmpty ? 'The title cannot be empty' : null,
//     onChanged: onChangedTitle,
//   );
//
//   Widget buildDescription() => TextFormField(
//     maxLines: 5,
//     initialValue: description,
//     style: const TextStyle(
//         color: Colors.white,
//         fontSize: 18),
//     decoration: const InputDecoration(
//       border: InputBorder.none,
//       hintText: 'Todo',
//       hintStyle: TextStyle(color: Colors.white),
//     ),
//     validator: (title) => title != null && title.isEmpty
//         ? 'Required to fill'
//         : null,
//     onChanged: onChangedDescription,
//   );
// }
