import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:contact_app/service_locator.dart';
import 'package:contact_app/data/models/contact_model.dart';
import 'package:contact_app/pages/contact/widgets/contact_form.dart';
import 'package:contact_app/blocs/put/cubit/edit_contact_cubit.dart';

class EditContactPage extends StatelessWidget {
  final ContactModel contact;
  const EditContactPage({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditContactCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Contact"),
        ),
        body: BlocConsumer<EditContactCubit, EditContactState>(
          listener: (context, state) {
            if (state is EditContactSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Edit Contact Successfully!')));
              Navigator.pop(context, 'success');
            }
          },
          builder: (context, state) {
            if (state is EditContactLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is EditContactFailure) {
              Center(
                child: Text('Edit Contact Error: ${state.message}'),
              );
            }
            return ContactForm(
              contact: contact,
            );
          },
        ),
      ),
    );
  }
}
