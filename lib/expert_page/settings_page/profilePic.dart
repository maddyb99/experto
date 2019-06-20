import 'package:cached_network_image/cached_network_image.dart';
import 'package:experto/expert_authentication/expertData.dart';
import 'package:experto/expert_page/settings_page/Update.dart';
import 'package:experto/utils/authentication_page_utils.dart';
import 'package:flutter/material.dart';
import 'package:experto/utils/bloc/syncDocuments.dart';

class ProfilePicUpdate extends StatefulWidget {
  @override
  _ProfilePicUpdateState createState() => _ProfilePicUpdateState();
}

class _ProfilePicUpdateState extends State<ProfilePicUpdate> {
  ExpertData expert;
  bool uploading;
  final Update update=new Update();

  @override
  void initState() {
    uploading = false;
    super.initState();
  }

  @override
  didChangeDependencies() {
    expert = ExpertDocumentSync.of(context).expert;
    super.didChangeDependencies();
  }

  Future<void > updateData()async{
    setState(() {
      showAuthSnackBar(
        context: context,
        title: "Updating...",
        leading: Icon(Icons.file_upload, size: 23, color: Colors.green),
      );
    });
    expert= await update.updateProfilePic(expert);
    syncDocumentExpert.updateStatusExpert(expert);
    setState(() {
      showAuthSnackBar(
        context: context,
        title: 'Uploaded',
        leading: Icon(Icons.done, color: Colors.green, size: 23),
        persistant: false,
      );
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
              onPressed: updateData,
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ))
        ],
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: uploading == true
            ? CircularProgressIndicator()
            : Hero(
          tag: "profilePic",
          child: expert.detailsData['profilePic'] == null
              ? Icon(
            Icons.person,
            size: 110,
          )
              :  CachedNetworkImage(
            imageBuilder: (context, imageProvider) => Container(
              width: 350.0,
              height: 350.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover),
              ),
            ),
            imageUrl: expert.detailsData['profilePic'],
            placeholder: (context, a) =>
                CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}