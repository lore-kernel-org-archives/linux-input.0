From: Grant Grundler <grundler@chromium.org>
Subject: [PATCH] HID: remove use of DRIVER_LICENSE
Date: Thu,  5 Jan 2017 11:07:04 -0800
Message-ID: <20170105190704.56654-1-grundler@google.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:32935 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030458AbdAETHM (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 5 Jan 2017 14:07:12 -0500
Received: by mail-pf0-f178.google.com with SMTP id d2so89068122pfd.0
        for <linux-input@vger.kernel.org>; Thu, 05 Jan 2017 11:07:12 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dtor@chromium.org>, linux-input <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-usb <linux-usb@vger.kernel.org>, Grant Grundler <grundler@google.com>

Local "#define DRIVER_LICENSE" obfuscates which license is used
in MODULE_LICENSE().  "fgrep -R MODULE_LICENSE" is more informative
when the string is hard coded in MODULE_LICENSE.

Signed-off-by: Grant Grundler <grundler@google.com>
---
Most of the kernel already uses hard coded strings.
The few places that don't are easy to fix.

 drivers/hid/hid-core.c        | 3 +--
 drivers/hid/usbhid/hid-core.c | 3 +--
 drivers/hid/usbhid/usbkbd.c   | 3 +--
 drivers/hid/usbhid/usbmouse.c | 3 +--
 drivers/hid/wacom.h           | 1 -
 drivers/hid/wacom_sys.c       | 2 +-
 6 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 08f53c7fd513..996b45dff76d 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -43,7 +43,6 @@
  */
 
 #define DRIVER_DESC "HID core driver"
-#define DRIVER_LICENSE "GPL"
 
 int hid_debug = 0;
 module_param_named(debug, hid_debug, int, 0600);
@@ -2848,5 +2847,5 @@ module_exit(hid_exit);
 MODULE_AUTHOR("Andreas Gal");
 MODULE_AUTHOR("Vojtech Pavlik");
 MODULE_AUTHOR("Jiri Kosina");
-MODULE_LICENSE(DRIVER_LICENSE);
+MODULE_LICENSE("GPL");
 
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index ae83af649a60..1847f64ac7dc 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -43,7 +43,6 @@
  */
 
 #define DRIVER_DESC "USB HID core driver"
-#define DRIVER_LICENSE "GPL"
 
 /*
  * Module parameters.
@@ -1660,4 +1659,4 @@ MODULE_AUTHOR("Andreas Gal");
 MODULE_AUTHOR("Vojtech Pavlik");
 MODULE_AUTHOR("Jiri Kosina");
 MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE(DRIVER_LICENSE);
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/usbhid/usbkbd.c b/drivers/hid/usbhid/usbkbd.c
index 9a332e683db7..7fb2d1e4f5dd 100644
--- a/drivers/hid/usbhid/usbkbd.c
+++ b/drivers/hid/usbhid/usbkbd.c
@@ -39,11 +39,10 @@
 #define DRIVER_VERSION ""
 #define DRIVER_AUTHOR "Vojtech Pavlik <vojtech@ucw.cz>"
 #define DRIVER_DESC "USB HID Boot Protocol keyboard driver"
-#define DRIVER_LICENSE "GPL"
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE(DRIVER_LICENSE);
+MODULE_LICENSE("GPL");
 
 static const unsigned char usb_kbd_keycode[256] = {
 	  0,  0,  0,  0, 30, 48, 46, 32, 18, 33, 34, 35, 23, 36, 37, 38,
diff --git a/drivers/hid/usbhid/usbmouse.c b/drivers/hid/usbhid/usbmouse.c
index bf16d72dc370..dd911c5241d8 100644
--- a/drivers/hid/usbhid/usbmouse.c
+++ b/drivers/hid/usbhid/usbmouse.c
@@ -42,11 +42,10 @@
 #define DRIVER_VERSION "v1.6"
 #define DRIVER_AUTHOR "Vojtech Pavlik <vojtech@ucw.cz>"
 #define DRIVER_DESC "USB HID Boot Protocol mouse driver"
-#define DRIVER_LICENSE "GPL"
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE(DRIVER_LICENSE);
+MODULE_LICENSE("GPL");
 
 struct usb_mouse {
 	char name[128];
diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index 4681a65a4579..eb24bf823252 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -100,7 +100,6 @@
 #define DRIVER_VERSION "v2.00"
 #define DRIVER_AUTHOR "Vojtech Pavlik <vojtech@ucw.cz>"
 #define DRIVER_DESC "USB Wacom tablet driver"
-#define DRIVER_LICENSE "GPL"
 
 #define USB_VENDOR_ID_WACOM	0x056a
 #define USB_VENDOR_ID_LENOVO	0x17ef
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 499cc8213cfe..f79627df9597 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1959,4 +1959,4 @@ module_hid_driver(wacom_driver);
 MODULE_VERSION(DRIVER_VERSION);
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE(DRIVER_LICENSE);
+MODULE_LICENSE("GPL");
-- 
2.11.0.390.gc69c2f50cf-goog

