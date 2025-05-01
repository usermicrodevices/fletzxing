import 'package:flet/flet.dart';

import 'flet_zxing.dart';

CreateControlFactory createControl = (CreateControlArgs args) {
  switch (args.control.type) {
    case "flet_zxing":
      return FletZxingControl(
        parent: args.parent,
        control: args.control,
        backend: args.backend,
      );
    default:
      return null;
  }
};

void ensureInitialized() {
  // nothing to initialize
}
