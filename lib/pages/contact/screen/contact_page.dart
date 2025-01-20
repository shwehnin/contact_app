import '../widgets/contact_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:contact_app/data/models/contact_model.dart';
import 'package:contact_app/blocs/get/cubit/get_contact_cubit.dart';
import 'package:contact_app/pages/contact/screen/add_contact_page.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact List"),
      ),
      body: BlocConsumer<GetContactCubit, GetContactState>(
          listener: (context, state) {
        if (state is GetContactFailure) {
          Center(child: Text("Failed to load contacts"));
        }
      }, builder: (context, state) {
        if (state is GetContactSuccess) {
          List<ContactModel> contactList = state.contactList;
          return ListView.builder(
              itemCount: contactList.length,
              itemBuilder: (context, index) {
                return ContactList(contact: contactList[index]);
              });
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddContactPage()));
          if (result != null && result == 'success') {
            BlocProvider.of<GetContactCubit>(context).getContact();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
