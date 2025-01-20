import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:contact_app/service_locator.dart';
import 'package:contact_app/pages/contact/widgets/contact_form.dart';
import 'package:contact_app/blocs/post/cubit/post_contact_cubit.dart';

class AddContactPage extends StatelessWidget {
  const AddContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostContactCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Contact Page"),
        ),
        body: BlocConsumer<PostContactCubit, PostContactState>(
          listener: (context, state) {
            if (state is PostContactSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Add Contact Successfully!")));
              Navigator.pop(context, 'success');
            }
          },
          builder: (context, state) {
            if (state is PostContactLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PostContactFailure) {
              return Center(
                child: Text(state.message),
              );
            }
            return ContactForm();
          },
        ),
      ),
    );
  }
}
