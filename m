From: Paul Walmsley <paul@booyaka.com>
Subject: [PATCH 1/6] usbhid: create hid-quirks.h
Date: Wed, 11 Apr 2007 12:55:59 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0704111255130.28726@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org


From: Paul Walmsley <paul@booyaka.com>

Move the HID quirks #defines from hid.h into their own header file,
hid-quirks.h.


Signed-off-by: Paul Walmsley <paul@booyaka.com>

---
  drivers/hid/usbhid/hid-core.c |    1 +
  drivers/hid/usbhid/hiddev.c   |    1 +
  include/linux/hid-quirks.h    |   32 ++++++++++++++++++++++++++++++++
  include/linux/hid.h           |   28 ----------------------------
  net/bluetooth/hidp/core.c     |    1 +
  5 files changed, 35 insertions(+), 28 deletions(-)

Index: hid/include/linux/hid-quirks.h
===================================================================
--- /dev/null
+++ hid/include/linux/hid-quirks.h
@@ -0,0 +1,32 @@
+#ifndef __HID_QUIRKS_H
+#define __HID_QUIRKS_H
+
+/*
+ * HID device quirks.
+ */
+
+#define HID_QUIRK_INVERT			0x00000001
+#define HID_QUIRK_NOTOUCH			0x00000002
+#define HID_QUIRK_IGNORE			0x00000004
+#define HID_QUIRK_NOGET				0x00000008
+#define HID_QUIRK_HIDDEV			0x00000010
+#define HID_QUIRK_BADPAD			0x00000020
+#define HID_QUIRK_MULTI_INPUT			0x00000040
+#define HID_QUIRK_2WHEEL_MOUSE_HACK_7		0x00000080
+#define HID_QUIRK_2WHEEL_MOUSE_HACK_5		0x00000100
+#define HID_QUIRK_2WHEEL_MOUSE_HACK_ON		0x00000200
+#define HID_QUIRK_MIGHTYMOUSE			0x00000400
+#define HID_QUIRK_CYMOTION			0x00000800
+#define HID_QUIRK_POWERBOOK_HAS_FN		0x00001000
+#define HID_QUIRK_POWERBOOK_FN_ON		0x00002000
+#define HID_QUIRK_INVERT_HWHEEL			0x00004000
+#define HID_QUIRK_POWERBOOK_ISO_KEYBOARD        0x00008000
+#define HID_QUIRK_BAD_RELATIVE_KEYS		0x00010000
+#define HID_QUIRK_SKIP_OUTPUT_REPORTS		0x00020000
+#define HID_QUIRK_IGNORE_MOUSE			0x00040000
+#define HID_QUIRK_SONY_PS3_CONTROLLER		0x00080000
+#define HID_QUIRK_LOGITECH_DESCRIPTOR		0x00100000
+#define HID_QUIRK_DUPLICATE_USAGES		0x00200000
+#define HID_QUIRK_RESET_LEDS			0x00400000
+
+#endif
Index: hid/include/linux/hid.h
===================================================================
--- hid.orig/include/linux/hid.h
+++ hid/include/linux/hid.h
@@ -244,34 +244,6 @@ struct hid_item {
  #define HID_FEATURE_REPORT	2

  /*
- * HID device quirks.
- */
-
-#define HID_QUIRK_INVERT			0x00000001
-#define HID_QUIRK_NOTOUCH			0x00000002
-#define HID_QUIRK_IGNORE			0x00000004
-#define HID_QUIRK_NOGET				0x00000008
-#define HID_QUIRK_HIDDEV			0x00000010
-#define HID_QUIRK_BADPAD			0x00000020
-#define HID_QUIRK_MULTI_INPUT			0x00000040
-#define HID_QUIRK_2WHEEL_MOUSE_HACK_7		0x00000080
-#define HID_QUIRK_2WHEEL_MOUSE_HACK_5		0x00000100
-#define HID_QUIRK_2WHEEL_MOUSE_HACK_ON		0x00000200
-#define HID_QUIRK_MIGHTYMOUSE			0x00000400
-#define HID_QUIRK_CYMOTION			0x00000800
-#define HID_QUIRK_POWERBOOK_HAS_FN		0x00001000
-#define HID_QUIRK_POWERBOOK_FN_ON		0x00002000
-#define HID_QUIRK_INVERT_HWHEEL			0x00004000
-#define HID_QUIRK_POWERBOOK_ISO_KEYBOARD        0x00008000
-#define HID_QUIRK_BAD_RELATIVE_KEYS		0x00010000
-#define HID_QUIRK_SKIP_OUTPUT_REPORTS		0x00020000
-#define HID_QUIRK_IGNORE_MOUSE			0x00040000
-#define HID_QUIRK_SONY_PS3_CONTROLLER		0x00080000
-#define HID_QUIRK_LOGITECH_DESCRIPTOR		0x00100000
-#define HID_QUIRK_DUPLICATE_USAGES		0x00200000
-#define HID_QUIRK_RESET_LEDS			0x00400000
-
-/*
   * This is the global environment of the parser. This information is
   * persistent for main-items. The global environment can be saved and
   * restored with PUSH/POP statements.
Index: hid/drivers/hid/usbhid/hid-core.c
===================================================================
--- hid.orig/drivers/hid/usbhid/hid-core.c
+++ hid/drivers/hid/usbhid/hid-core.c
@@ -32,6 +32,7 @@
  #include <linux/hid.h>
  #include <linux/hiddev.h>
  #include <linux/hid-debug.h>
+#include <linux/hid-quirks.h>
  #include <linux/hidraw.h>
  #include "usbhid.h"

Index: hid/net/bluetooth/hidp/core.c
===================================================================
--- hid.orig/net/bluetooth/hidp/core.c
+++ hid/net/bluetooth/hidp/core.c
@@ -39,6 +39,7 @@

  #include <linux/input.h>
  #include <linux/hid.h>
+#include <linux/hid-quirks.h>

  #include <net/bluetooth/bluetooth.h>
  #include <net/bluetooth/hci_core.h>
Index: hid/drivers/hid/usbhid/hiddev.c
===================================================================
--- hid.orig/drivers/hid/usbhid/hiddev.c
+++ hid/drivers/hid/usbhid/hiddev.c
@@ -34,6 +34,7 @@
  #include <linux/usb.h>
  #include <linux/hid.h>
  #include <linux/hiddev.h>
+#include <linux/hid-quirks.h>
  #include "usbhid.h"

  #ifdef CONFIG_USB_DYNAMIC_MINORS
