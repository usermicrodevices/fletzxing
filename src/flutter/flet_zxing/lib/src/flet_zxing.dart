import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zxing/flutter_zxing.dart';

import 'package:flet/flet.dart';


class FletZxingControl extends StatelessWidget {
  final String version = zx.version();
  var glcontext;
  Code? result;
  Codes? multiResult;
  bool isMultiScan = false;
  int successScans = 0;
  int failedScans = 0;

  final Control? parent;
  final Control control;
  final bool isCameraSupported = defaultTargetPlatform == TargetPlatform.iOS ||
  defaultTargetPlatform == TargetPlatform.android;
  final FletControlBackend backend;

  FletZxingControl({
    super.key,
    required this.parent,
    required this.control,
    required this.backend
  });

  @override
  Widget build(BuildContext context) {
    //zx.setLogEnabled(kDebugMode);
    this.glcontext = context;
    //Color actionButtonsBackgroundColor = control.attrColor('actionButtonsBackgroundColor', context)!;
    this.isMultiScan = control.attrBool('isMultiScan', false)!;
    //debugPrint("🪻ZXing version:🏡 $version 🪻");
    Widget readerControl = ReaderWidget(onScan: _onScanSuccess,
        onScanFailure: _onScanFailure,
        onMultiScan: _onMultiScanSuccess,
        onMultiScanFailure: _onMultiScanFailure,
        onMultiScanModeChanged: _onMultiScanModeChanged,
        onControllerCreated: _onControllerCreated,
        isMultiScan: this.isMultiScan,
        scanDelay: Duration(milliseconds: this.isMultiScan ? 50 : 500),
        resolution: ResolutionPreset.high,
        lensDirection: CameraLensDirection.back,
        flashOnIcon: const Icon(Icons.flash_on),
        flashOffIcon: const Icon(Icons.flash_off),
        flashAlwaysIcon: const Icon(Icons.flash_on),
        flashAutoIcon: const Icon(Icons.flash_auto),
        galleryIcon: const Icon(Icons.photo_library),
        toggleCameraIcon: const Icon(Icons.switch_camera),
        actionButtonsBackgroundBorderRadius: BorderRadius.circular(control.attrDouble('actionButtonsBackgroundBorderRadius', 10)!),
        //actionButtonsBackgroundColor: actionButtonsBackgroundColor,
        actionButtonsBackgroundColor: Colors.black.withOpacity(0.5),
    );
    //backend.updateControlState(control.id, {"version": version});
    //debugPrint("🏡✅Camera is supported: $isCameraSupported ✅🏡");
    //return baseControl(context, readerControl, parent, control);
    return constrainedControl(context, readerControl, parent, control);
  }

  void _onControllerCreated(_, Exception? error) {
    backend.updateControlState(control.id, {"version": version});
    debugPrint("🪻✅ZXing version: $version ✅🪻");
    if (!isCameraSupported) {
      //_showMessage(this.glcontext, 'Camera not supported on this platform');
      const Center(child: Text('Camera not supported on this platform'));
      debugPrint("🏡Camera not supported on this platform🏡");
    }
    if (error != null) {
      // Handle permission or unknown errors
      _showMessage(this.glcontext, 'Error: $error');
    }
  }

  _onScanSuccess(Code? code) {
    debugPrint("${control.id} successScans!");
    successScans++;
    result = code;
    backend.triggerControlEvent(control.id, "OnScanSuccess", json.encode({'value':code != null && code?.isValid == true ? code?.text : 'ERROR'}));
  }

  _onScanFailure(Code? code) {
    failedScans++;
    result = code;
    if (code?.error?.isNotEmpty == true) {
      _showMessage(this.glcontext, 'Error: ${code?.error}');
    }
  }

  _onMultiScanSuccess(Codes codes) {
    successScans++;
    multiResult = codes;
  }

  _onMultiScanFailure(Codes result) {
    failedScans++;
    multiResult = result;
    if (result.codes.isNotEmpty == true) {
      _showMessage(this.glcontext, 'Error: ${result.codes.first.error}');
    }
  }

  _onMultiScanModeChanged(bool isMultiScan) {
    this.isMultiScan = isMultiScan;
    backend.updateControlState(control.id, {"version": version});
    backend.triggerControlEvent(control.id, "OnMultiScanModeChanged", json.encode({'isMultiScan':isMultiScan}));
    debugPrint("🪻✅ FletControlBackend: ${backend} ✅🪻");
    debugPrint("🪻✅ ${control.id} isMultiScan: ${this.isMultiScan} ✅🪻");
  }

  _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  _onReset() {
    successScans = 0;
    failedScans = 0;
  }

}
