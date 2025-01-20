import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/contact_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:contact_app/blocs/get/cubit/get_contact_cubit.dart';
import 'package:contact_app/pages/contact/screen/edit_contact_page.dart';

class ContactList extends StatelessWidget {
  const ContactList({
    super.key,
    required this.contact,
  });

  final ContactModel contact;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Slidable(
        startActionPane: ActionPane(
          motion: BehindMotion(),
          children: [
            SlidableAction(
              onPressed: (value) async {
                var result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => EditContactPage(contact: contact)));
                if (result != null && result == 'success') {
                  BlocProvider.of<GetContactCubit>(context).getContact();
                }
              },
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: "Edit",
            )
          ],
        ),
        endActionPane: ActionPane(motion: BehindMotion(), children: [
          SlidableAction(
            onPressed: (value) {
              BlocProvider.of<GetContactCubit>(context)
                  .deleteContact(contact.id.toString());
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Contact Deleted Successfully!')));
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          )
        ]),
        child: ListTile(
          title: Text(contact.name ?? ""),
          subtitle: Text(contact.job ?? ""),
          trailing: Text("Age is ${contact.age}"),
        ),
      ),
    );
  }
}
