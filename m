From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 1/1] Input: inline macros for MODULE_LICENSE, etc
Date: Tue, 26 Dec 2017 18:05:05 +0100
Message-ID: <1514307905-3486-2-git-send-email-Julia.Lawall@lip6.fr>
References: <1514307905-3486-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1514307905-3486-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-input@vger.kernel.org

Inline macro for MODULE_LICENSE to make the license information easy to
find, eg with grep.  Inline the other module-related macros at the same
time.

A simplified version of the semantic patch for the MODULE_LICENSE
case is as follows: (http://coccinelle.lip6.fr/)

// <smpl>
@s@
identifier i; expression e;
@@
#define i e

@@
declarer name MODULE_LICENSE;
identifier s.i;
expression s.e;
@@
MODULE_LICENSE(
- i
+ e
 );
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/input/misc/keyspan_remote.c |    9 +++------
 drivers/input/tablet/acecad.c       |    9 +++------
 drivers/input/tablet/hanwang.c      |   10 +++-------
 drivers/input/tablet/kbtab.c        |    9 +++------
 4 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/input/misc/keyspan_remote.c b/drivers/input/misc/keyspan_remote.c
index 77c47d6..594d2f84 100644
--- a/drivers/input/misc/keyspan_remote.c
+++ b/drivers/input/misc/keyspan_remote.c
@@ -18,9 +18,6 @@
 #include <linux/usb/input.h>
 
 #define DRIVER_VERSION	"v0.1"
-#define DRIVER_AUTHOR	"Michael Downey <downey@zymeta.com>"
-#define DRIVER_DESC	"Driver for the USB Keyspan remote control."
-#define DRIVER_LICENSE	"GPL"
 
 /* Parameters that can be passed to the driver. */
 static int debug;
@@ -590,6 +587,6 @@ static void keyspan_disconnect(struct usb_interface *interface)
 module_usb_driver(keyspan_driver);
 
 MODULE_DEVICE_TABLE(usb, keyspan_table);
-MODULE_AUTHOR(DRIVER_AUTHOR);
-MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE(DRIVER_LICENSE);
+MODULE_AUTHOR("Michael Downey <downey@zymeta.com>");
+MODULE_DESCRIPTION("Driver for the USB Keyspan remote control.");
+MODULE_LICENSE("GPL");
diff --git a/drivers/input/tablet/acecad.c b/drivers/input/tablet/acecad.c
index aebb3f9..4b68549 100644
--- a/drivers/input/tablet/acecad.c
+++ b/drivers/input/tablet/acecad.c
@@ -34,13 +34,10 @@
  * Version Information
  */
 #define DRIVER_VERSION "v3.2"
-#define DRIVER_DESC    "USB Acecad Flair tablet driver"
-#define DRIVER_LICENSE "GPL"
-#define DRIVER_AUTHOR  "Edouard TISSERANT <edouard.tisserant@wanadoo.fr>"
 
-MODULE_AUTHOR(DRIVER_AUTHOR);
-MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE(DRIVER_LICENSE);
+MODULE_AUTHOR("Edouard TISSERANT <edouard.tisserant@wanadoo.fr>");
+MODULE_DESCRIPTION("USB Acecad Flair tablet driver");
+MODULE_LICENSE("GPL");
 
 #define USB_VENDOR_ID_ACECAD	0x0460
 #define USB_DEVICE_ID_FLAIR	0x0004
diff --git a/drivers/input/tablet/hanwang.c b/drivers/input/tablet/hanwang.c
index df4bea9..4042c41 100644
--- a/drivers/input/tablet/hanwang.c
+++ b/drivers/input/tablet/hanwang.c
@@ -28,13 +28,9 @@
 #include <linux/module.h>
 #include <linux/usb/input.h>
 
-#define DRIVER_AUTHOR   "Xing Wei <weixing@hanwang.com.cn>"
-#define DRIVER_DESC     "USB Hanwang tablet driver"
-#define DRIVER_LICENSE  "GPL"
-
-MODULE_AUTHOR(DRIVER_AUTHOR);
-MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE(DRIVER_LICENSE);
+MODULE_AUTHOR("Xing Wei <weixing@hanwang.com.cn>");
+MODULE_DESCRIPTION("USB Hanwang tablet driver");
+MODULE_LICENSE("GPL");
 
 #define USB_VENDOR_ID_HANWANG		0x0b57
 #define HANWANG_TABLET_INT_CLASS	0x0003
diff --git a/drivers/input/tablet/kbtab.c b/drivers/input/tablet/kbtab.c
index a41c3ff..831fbec 100644
--- a/drivers/input/tablet/kbtab.c
+++ b/drivers/input/tablet/kbtab.c
@@ -13,13 +13,10 @@
  */
 
 #define DRIVER_VERSION "v0.0.2"
-#define DRIVER_AUTHOR "Josh Myer <josh@joshisanerd.com>"
-#define DRIVER_DESC "USB KB Gear JamStudio Tablet driver"
-#define DRIVER_LICENSE "GPL"
 
-MODULE_AUTHOR(DRIVER_AUTHOR);
-MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE(DRIVER_LICENSE);
+MODULE_AUTHOR("Josh Myer <josh@joshisanerd.com>");
+MODULE_DESCRIPTION("USB KB Gear JamStudio Tablet driver");
+MODULE_LICENSE("GPL");
 
 #define USB_VENDOR_ID_KBGEAR	0x084e
 
