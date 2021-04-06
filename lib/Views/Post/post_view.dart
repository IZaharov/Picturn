import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picturn/ViewModels/post_view_model.dart';
import 'package:picturn/Views/CustomWidgets/zoom_overlay.dart';
import 'package:picturn/Views/Post/post_title_view.dart';

import 'like_view.dart';

class PostView extends StatefulWidget {
  PostViewModel postViewModel;

  PostView(this.postViewModel);

  @override
  _PostView createState() => _PostView(postViewModel);
}

class _PostView extends State<PostView> {
  TransformationController transformController = TransformationController();
  PostViewModel postViewModel;
  final FlareControls flareControls = FlareControls();

  _PostView(this.postViewModel);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Divider(
        thickness: 2,
        height: 0,
      ),
      PostTitleView(postViewModel: this.postViewModel),
      GestureDetector(
        onDoubleTap: () {
          setState(() {
            this.postViewModel.trySetLike();
            flareControls.play("like");
          });
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ZoomOverlay(
                minScale: 1, // optional
                maxScale: 3.0, // optional
                twoTouchOnly: true,
                child:  FutureBuilder(
                    future: this.postViewModel.getImagePath,
                    builder: (context, snapshot) {
                      if (snapshot.hasData){
                        print('huihuihuhiuhiuhi');
                        return Image.network(snapshot.data);}
                      else
                        return Image.asset('res/images/post_bg.jpg');
                    }),
            ),
            Container(
                child: SizedBox(
                    width: 80,
                    height: 80,
                    child: FlareActor(
                      'res/animations/instagram_like.flr',
                      controller: flareControls,
                      animation: 'idle',
                    )))
          ],
        ),
      ),
      LikeView(postViewModel: this.postViewModel)
    ]);
  }
}
