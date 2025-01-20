import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:contact_app/data/models/contact_model.dart';
import 'package:contact_app/components/custom_text_field.dart';
import 'package:contact_app/blocs/put/cubit/edit_contact_cubit.dart';
import 'package:contact_app/blocs/post/cubit/post_contact_cubit.dart';

class ContactForm extends StatefulWidget {
  final ContactModel? contact;
  const ContactForm({
    super.key,
    this.contact,
  });

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController jobController = TextEditingController();

  @override
  void initState() {
    if (widget.contact != null) {
      nameController.text = widget.contact?.name ?? '';
      ageController.text = widget.contact?.age?.toString() ?? '';
      jobController.text = widget.contact?.job ?? '';
    }
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    jobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          children: [
            CustomTextField(
              hintText: 'Enter your name',
              controller: nameController,
              validateText: 'Name is required',
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hintText: 'Enter your age',
              controller: ageController,
              validateText: 'Age is required',
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hintText: 'Enter your job',
              controller: jobController,
              validateText: 'Job is required',
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  if (widget.contact != null) {
                    _updateContact();
                  } else {
                    _addContact();
                  }
                }
              },
              child: Text('Submit'),
            )
          ],
        ));
  }

  void _addContact() {
    ContactModel contact = ContactModel(
      name: nameController.text.trim(),
      age: int.tryParse(ageController.text),
      job: jobController.text.trim(),
    );
    context.read<PostContactCubit>().postContact(contact);
  }

  void _updateContact() {
    ContactModel contact = ContactModel(
      id: widget.contact?.id,
      name: nameController.text.trim(),
      job: jobController.text.trim(),
      age: int.parse(ageController.text),
    );
    context
        .read<EditContactCubit>()
        .editContact(widget.contact!.id.toString(), contact);
  }
}
