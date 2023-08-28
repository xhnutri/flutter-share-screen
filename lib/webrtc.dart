import 'package:flutter/material.dart';
import './peerdart/peerdart.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import './peerdart/src/dataconnection.dart';
import 'package:flutter/services.dart';
// import './main.dart';

class WebrtcPage extends StatefulWidget {
  const WebrtcPage({Key? key}) : super(key: key);

  @override
  State<WebrtcPage> createState() => _WebrtcPageState();
}

class _WebrtcPageState extends State<WebrtcPage> {
  final TextEditingController _controller = TextEditingController();
  // final Peer peer = Peer();
  final Peer peer = Peer(
      id: "1234678",
      options: PeerOptions(
          debug: LogLevel.All,
          // host: "34.175.24.194",
          host: "192.168.1.95",
          port: 9000,
          path: "/",
          secure: false));
  final _localRenderer = RTCVideoRenderer();
  final _remoteRenderer = RTCVideoRenderer();
  bool inCall = false;
  String? peerId;

  @override
  void initState() {
    super.initState();
    _localRenderer.initialize();
    _remoteRenderer.initialize();
    // DataConnection peer = DataConnection().initPeerClient();
/*
    peer.on("open").listen((id) {
      setState(() {
        peerId = peer.id;
      });
    });
    peer.on("binary").listen((id) {
      print("id " + id);
    });
    peer.on("binary").listen((id) {
      print("ninary " + id);
    });
    peer.on<String>("message").listen((message) async {});
    peer.on<String>("data").listen((message) {
      print("Conexcions Data------------------------------------------------");
      print("Message Received: " + message);
    });
    */
    peer.on<MediaConnection>("call").listen((call) async {
      var sources = await desktopCapturer.getSources(
          types: [SourceType.Screen, SourceType.Window],
          thumbnailSize: ThumbnailSize(320, 180));
      DesktopCapturerSource? selectedSource;
      sources.forEach((item) => {
            // print item.id, item.title
            // display thumbnail
            selectedSource = item, print(item.name)
          });
      var mediaStream = await navigator.mediaDevices.getDisplayMedia({
        "video": {
          "deviceId": {"exact": selectedSource!.id},
          "mandatory": {"minWidth": 360, "minHeight": 720, "frameRate": 30.0}
        }
      });
      call.answer(mediaStream);
      call.on("close").listen((event) {
        setState(() {
          inCall = false;
        });
      });
      // _remoteRenderer.srcObject = mediaStream;
      // _localRenderer.srcObject = mediaStream;
      call.on<MediaStream>("stream").listen((event) {
        print("=====================================");
        _localRenderer.srcObject = mediaStream;
        _remoteRenderer.srcObject = event;

        setState(() {
          inCall = true;
        });
      });
    });
  }

  @override
  void dispose() {
    peer.dispose();
    _controller.dispose();
    // _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  void disconnectr() {
    peer.dispose();
    _controller.dispose();
    // _localRenderer.dispose();
    _remoteRenderer.dispose();
  }

  void src() async {
    peer.emit('message', "HOla");
    // var sources = await desktopCapturer.getSources(
    //     types: [SourceType.Screen, SourceType.Window],
    //     thumbnailSize: ThumbnailSize(320, 180));

    // DesktopCapturerSource? selectedSource;
    // sources.forEach((item) {
    //   // print item.id, item.title
    //   // display thumbnail
    //   print("-");
    //   if (item.name ==
    //       "Ver Twisted Metal Temporada 1 Episodio 8 Online - PelisplusHD - Brave") {
    //     selectedSource = item;
    //     print("1232");
    //   }

    //   print("${item.id}  --- ${item.name}");
    //   print("+");
    // });
  }

  void connect() async {
    print(
        "---------------------" + _controller.text + "-----------------------");
    // final mediaStream =
    //     await mediaDevices.getUserMedia({"video": true, "audio": false});
    var sources = await desktopCapturer.getSources(
        types: [SourceType.Screen, SourceType.Window],
        thumbnailSize: ThumbnailSize(320, 180));

    DesktopCapturerSource? selectedSource;
    sources.forEach((item) => {
          // print item.id, item.title
          // display thumbnail
          selectedSource = item
        });
    var mediaStream = await navigator.mediaDevices.getDisplayMedia({
      "video": {
        "deviceId": {"exact": sources[3].id},
        "mandatory": {"minWidth": 360, "minHeight": 720, "frameRate": 30.0}
      }
    });
    final conn = peer.call("R3L86OS", mediaStream);

    conn.on('open').listen((id) {
      print("IDfg  ------------ : " + id.toString());
    });
    conn.on("close").listen((event) {
      setState(() {
        inCall = false;
      });
    });

    conn.on<MediaStream>("stream").listen((event) {
      print("----------ebcjbxjksk=========");
      print(event);
      print("----------end=========");
      _remoteRenderer.srcObject = event;
      // _localRenderer.srcObject = mediaStream;

      setState(() {
        inCall = true;
      });
    });

    // });
    // peer.on<MediaConnection>("call").listen((call) async {
    //   final mediaStream = await navigator.mediaDevices
    //       .getUserMedia({"video": true, "audio": false});

    //   call.answer(mediaStream);

    //   // on peer closed
    //   call.on("close").listen((event) {
    //     setState(() {
    //       inCall = false;
    //     });
    //   });

    //   // Get peer stream
    //   call.on<MediaStream>("stream").listen((event) {
    //     _localRenderer.srcObject = mediaStream;
    //     _remoteRenderer.srcObject = event;

    //     setState(() {
    //       inCall = true;
    //     });
    //   });
    // });
  }

  void connect2() async {
    print(
        "---------------------" + _controller.text + "-----------------------");
    // final mediaStream =
    //     await mediaDevices.getUserMedia({"video": true, "audio": false});
    var sources = await desktopCapturer.getSources(
        types: [SourceType.Screen, SourceType.Window],
        thumbnailSize: ThumbnailSize(320, 180));

    DesktopCapturerSource? selectedSource;
    sources.forEach((item) => {
          // print item.id, item.title
          // display thumbnail
          selectedSource = item
        });
    var mediaStream = await navigator.mediaDevices.getDisplayMedia({
      "video": {
        "deviceId": {"exact": sources[3].id},
        "mandatory": {"minWidth": 360, "minHeight": 720, "frameRate": 30.0}
      }
    });
    final conn = peer.call("R3L86OS2", mediaStream);

    conn.on('open').listen((id) {
      print("IDfg  ------------ : " + id.toString());
    });
    conn.on("close").listen((event) {
      setState(() {
        inCall = false;
      });
    });

    conn.on<MediaStream>("stream").listen((event) {
      print("----------ebcjbxjksk=========");
      print(event);
      print("----------end=========");
      _remoteRenderer.srcObject = event;
      // _localRenderer.srcObject = mediaStream;

      setState(() {
        inCall = true;
      });
    });

    // });
    // peer.on<MediaConnection>("call").listen((call) async {
    //   final mediaStream = await navigator.mediaDevices
    //       .getUserMedia({"video": true, "audio": false});

    //   call.answer(mediaStream);

    //   // on peer closed
    //   call.on("close").listen((event) {
    //     setState(() {
    //       inCall = false;
    //     });
    //   });

    //   // Get peer stream
    //   call.on<MediaStream>("stream").listen((event) {
    //     _localRenderer.srcObject = mediaStream;
    //     _remoteRenderer.srcObject = event;

    //     setState(() {
    //       inCall = true;
    //     });
    //   });
    // });
  }

  void sendCall() async {
    print(
        "=-----------=-=-=-=Conexcions------------------------------------------------");
    // print("Message Received: " + message);
    var sources = await desktopCapturer.getSources(
        types: [SourceType.Screen, SourceType.Window],
        thumbnailSize: ThumbnailSize(320, 180));

    DesktopCapturerSource? selectedSource;
    sources.forEach((item) => {
          // print item.id, item.title
          // display thumbnail
          selectedSource = item, print(item.name)
        });
    var mediaStream = await navigator.mediaDevices.getDisplayMedia({
      "video": {
        "deviceId": {"exact": selectedSource!.id},
        "mandatory": {"minWidth": 360, "minHeight": 720, "frameRate": 30.0}
      }
    });
    peer.call("client2", mediaStream);
    peer.on("close").listen((event) {
      setState(() {
        inCall = false;
      });
    });
  }

  void connects() async {
    var sources = await desktopCapturer.getSources(
        types: [SourceType.Screen], thumbnailSize: ThumbnailSize(400, 400));
    DesktopCapturerSource? selectedSource;
    sources.forEach((item) => {
          // print item.id, item.title
          // display thumbnail
          selectedSource = item, print(item.name)
        });
    var mediaStream = await navigator.mediaDevices.getDisplayMedia({
      "video": {
        "deviceId": {"exact": selectedSource!.id},
        "mandatory": {"minWidth": 400, "minHeight": 400, "frameRate": 30.0}
      }
    });

    // final mediaStream = await navigator.mediaDevices
    //     .getUserMedia({"video": true, "audio": false});
    final conn = peer.call("client2", mediaStream);

    conn.on("close").listen((event) {
      setState(() {
        inCall = false;
      });
    });

    conn.on<MediaStream>("stream").listen((event) {
      _remoteRenderer.srcObject = mediaStream;
      _localRenderer.srcObject = event;

      setState(() {
        inCall = true;
      });
    });
  }

  void connects2() async {
    var sources = await desktopCapturer.getSources(
        types: [SourceType.Screen], thumbnailSize: ThumbnailSize(400, 400));
    DesktopCapturerSource? selectedSource;
    sources.forEach((item) => {
          // print item.id, item.title
          // display thumbnail
          selectedSource = item, print(item.name)
        });
    var mediaStream = await navigator.mediaDevices.getDisplayMedia({
      "video": {
        "deviceId": {"exact": selectedSource!.id},
        "mandatory": {"minWidth": 400, "minHeight": 400, "frameRate": 30.0}
      }
    });

    // final mediaStream = await navigator.mediaDevices
    //     .getUserMedia({"video": true, "audio": false});
    final conn = peer.call("cliente222222", mediaStream);

    conn.on("close").listen((event) {
      setState(() {
        inCall = false;
      });
    });

    conn.on<MediaStream>("stream").listen((event) {
      _remoteRenderer.srcObject = mediaStream;
      _localRenderer.srcObject = event;

      setState(() {
        inCall = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // return ExampleWEBRTC();
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            _renderState(),
            // const Text(
            //   'Connection ID:',
            // ),
            SelectableText(peerId ?? ""),
            // TextField(
            //   controller: _controller,
            // ),
            Positioned(
                top: 30,
                left: 200,
                child: ElevatedButton(
                    onPressed: connects, child: const Text("connect"))),
            Positioned(
                top: 30 + (40 * 3),
                child: ElevatedButton(
                    onPressed: connects2, child: const Text("connect2"))),
            Positioned(
                top: 70,
                child: ElevatedButton(
                    onPressed: disconnectr, child: const Text("disconnectr"))),
            Positioned(
                top: 110,
                child: ElevatedButton(
                    onPressed: sendCall, child: const Text("send"))),
            Positioned(
                top: 160,
                left: 200,
                child: ElevatedButton(
                    onPressed: () => {
                          SystemChannels.platform
                              .invokeMethod('SystemNavigator.pop')
                        },
                    child: const Text("Minimizar"))),
            // ElevatedButton(onPressed: send, child: const Text("send message")),
            if (inCall)
              Container(
                width: 100,
                height: 100,
                child: RTCVideoView(
                  _localRenderer,
                ),
              ),

            if (inCall)
              Container(
                width: 100,
                height: 100,
                child: RTCVideoView(
                  _remoteRenderer,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _renderState() {
    Color bgColor = inCall ? Colors.green : Colors.grey;
    Color txtColor = Colors.white;
    String txt = inCall ? "Connected" : "Standby";
    return Container(
      decoration: BoxDecoration(color: bgColor),
      child: Text(
        txt,
        style:
            Theme.of(context).textTheme.titleLarge?.copyWith(color: txtColor),
      ),
    );
  }
}
