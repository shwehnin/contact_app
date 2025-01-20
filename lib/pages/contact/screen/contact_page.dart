import '../widgets/contact_list.dart';
import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:contact_app/data/models/contact_model.dart';
import 'package:contact_app/components/custom_text_field.dart';
import 'package:contact_app/blocs/get/cubit/get_contact_cubit.dart';
import 'package:contact_app/pages/contact/screen/add_contact_page.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact List"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: CustomTextField(
                onSubmit: (query) {
                  context.read<GetContactCubit>().searchContacts(query);
                },
                prefixIcon: Icon(Icons.search),
                hintText: 'Search...',
                controller: _searchController,
                validateText: 'Search something...'),
          ),
        ),
      ),
      body: BlocConsumer<GetContactCubit, GetContactState>(
        listener: (context, state) {
          if (state is GetContactFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is GetContactSuccess) {
            final contactList = state.contactList;

            return LoadMore(
              isFinish: state.isLastpage,
              onLoadMore: () async {
                return await context
                    .read<GetContactCubit>()
                    .getContact(isLoadMore: true);
              },
              textBuilder: (status) {
                switch (status) {
                  case LoadMoreStatus.loading:
                    return "Loading more contacts...";
                  case LoadMoreStatus.nomore:
                    return "No more contacts available.";
                  default:
                    return "Pull to load more";
                }
              },
              child: ListView.builder(
                itemCount: contactList.length,
                itemBuilder: (context, index) {
                  return ContactList(contact: contactList[index]);
                },
              ),
            );
          }

          if (state is GetContactFailure) {
            return Center(child: Text(state.message));
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => AddContactPage()),
          );
          if (result == 'success') {
            context.read<GetContactCubit>().getContact();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
