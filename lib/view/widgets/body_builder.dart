import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poke_api/util/api_request_status.dart';
import 'package:poke_api/view/widgets/my_error_widget.dart';

class BodyBuilder extends StatelessWidget {
  final APIRequestStatus apiRequestStatus;
  final Widget? child;
  final Widget? loadingWidget;
  final Function() reload;

  BodyBuilder({
        required this.apiRequestStatus,
        this.child,
        this.loadingWidget,
        required this.reload,
        super.key});

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget getLoadingWidget(){
    return loadingWidget != null
        ? loadingWidget!
        : Center(child: CircularProgressIndicator());
  }

  Widget getChild() {
    return child != null
        ? child!
        : Container();
  }
  Widget _buildBody() {
    if (WidgetsBinding.instance.window.viewInsets.bottom > 0.0) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }
    switch (apiRequestStatus) {
      case APIRequestStatus.loading:
        return getLoadingWidget();
      case APIRequestStatus.unInitialized:
        return getLoadingWidget();
      case APIRequestStatus.connectionError:
        return MyErrorWidget(refreshCallBack: reload, isConnection: true);
      case APIRequestStatus.error:
        return MyErrorWidget(refreshCallBack: reload);
      case APIRequestStatus.loaded:
        return getChild();
      default:
        return getLoadingWidget();
    }
  }
}