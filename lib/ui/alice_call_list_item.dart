import 'package:alice/model/alice_http_call.dart';
import 'package:alice/model/alice_http_response.dart';
import 'package:flutter/material.dart';

class AliceCallListItem extends StatelessWidget {
  final AliceHttpCall call;
  final Function itemClickAction;

  const AliceCallListItem(this.call, this.itemClickAction);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        itemClickAction(call);
      },
      child: Column(children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Text(call.method, style: TextStyle(fontSize: 16)),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                        ),
                        Flexible(
                            child: Container(
                                child: Text(call.endpoint,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 16))))
                      ]),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                      ),
                      Row(children: [
                        _getSecuredConnectionIcon(call.secure),
                        Expanded(
                          child: Text(
                            call.server,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ]),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                      ),
                      Row(children: [
                        Text(_formatTime(call.request.time),
                            style: TextStyle(
                              fontSize: 12,
                            )),
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Text("${call.duration} ms",
                            style: TextStyle(fontSize: 12)),
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Text("${call.request.size}B / ${call.response.size}B",
                            style: TextStyle(fontSize: 12))
                      ]),
                    ],
                  ),
                ),
                _getResponseColumn(context, call)
              ],
            ),
          ),
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(horizontal: 10),
          )
        ]),
    );
  }

  String _formatTime(DateTime time) {
    return "${formatTimeUnit(time.hour)}:${formatTimeUnit(time.minute)}:${formatTimeUnit(time.second)}:${formatTimeUnit(time.millisecond)}";
  }

  String formatTimeUnit(int timeUnit) {
    return (timeUnit < 10) ? "0$timeUnit" : "$timeUnit";
  }

  Column _getResponseColumn(BuildContext context, AliceHttpCall call) {
    List<Widget> widgets = List();
    if (call.loading) {
      widgets.add(SizedBox(
        child: CircularProgressIndicator(),
        width: 20,
        height: 20,
      ));
    }
    widgets.add(Text(getStatus(call.response),
        style: TextStyle(
            fontSize: 16,
            color: _getStatusTextColor(context, call.response.status))));
    return Column(children: widgets);
  }

  Color _getStatusTextColor(BuildContext context, int status) {
    if (status == -1) {
      return Colors.red;
    } else if (status < 200) {
      return Theme.of(context).textTheme.bodyText1.color;
    } else if (status >= 200 && status < 300) {
      return Colors.green;
    } else if (status >= 300 && status < 400) {
      return Colors.orange;
    } else if (status >= 400 && status < 600) {
      return Colors.red;
    } else {
      return Theme.of(context).textTheme.bodyText1.color;
    }
  }

  String getStatus(AliceHttpResponse response) {
    if (response.status == -1) {
      return "ERR";
    } else if (response.status == 0) {
      return "???";
    } else {
      return "${response.status}";
    }
  }

  Widget _getSecuredConnectionIcon(bool secure) {
    IconData iconData;
    Color iconColor;
    if (secure) {
      iconData = Icons.lock_outline;
      iconColor = Colors.green;
    } else {
      iconData = Icons.lock_open;
      iconColor = Colors.red;
    }
    return Padding(
      padding: EdgeInsets.only(right: 3),
      child: Icon(
        iconData,
        color: iconColor,
        size: 12,
      ),
    );
  }
}
