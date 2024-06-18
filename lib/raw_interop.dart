@JS()
library flutter_medellin_extension;

import 'dart:js_interop';

@JS()
external JSPromise<JSString> getTabInfo();

@JS()
external JSPromise<JSString> getAllTabInfo();
