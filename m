From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] input: remove unneeded DRIVER_LICENSE #defines
Date: Fri, 17 Nov 2017 15:17:20 +0100
Message-ID: <20171117141720.GB17880@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:34912 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932708AbdKQORQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 17 Nov 2017 09:17:16 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: linux-kernel@vger.kernel.org, Philippe Ombredanne <pombredanne@nexb.com>, linux-input@vger.kernel.org

There is no need to #define the license of the driver, just put it in
the MODULE_LICENSE() line directly as a text string.

This allows tools that check that the module license matches the source
code license to work properly, as there is no need to unwind the
unneeded dereference.  For some of these drivers, the #define is just a
few lines above the MODULE_LICENSE() line, which is extra pointless.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
Reported-by: Philippe Ombredanne <pombredanne@nexb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/misc/keyspan_remote.c | 3 +--
 drivers/input/tablet/acecad.c       | 3 +--
 drivers/input/tablet/hanwang.c      | 3 +--
 drivers/input/tablet/kbtab.c        | 3 +--
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/input/misc/keyspan_remote.c b/drivers/input/misc/keyspan_remote.c
index 77c47d6325fe..4f13b2f7bf4f 100644
--- a/drivers/input/misc/keyspan_remote.c
+++ b/drivers/input/misc/keyspan_remote.c
@@ -20,7 +20,6 @@
 #define DRIVER_VERSION	"v0.1"
 #define DRIVER_AUTHOR	"Michael Downey <downey@zymeta.com>"
 #define DRIVER_DESC	"Driver for the USB Keyspan remote control."
-#define DRIVER_LICENSE	"GPL"
 
 /* Parameters that can be passed to the driver. */
 static int debug;
@@ -592,4 +591,4 @@ module_usb_driver(keyspan_driver);
 MODULE_DEVICE_TABLE(usb, keyspan_table);
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE(DRIVER_LICENSE);
+MODULE_LICENSE("GPL");
diff --git a/drivers/input/tablet/acecad.c b/drivers/input/tablet/acecad.c
index aebb3f9090cd..fcb67c7cd86b 100644
--- a/drivers/input/tablet/acecad.c
+++ b/drivers/input/tablet/acecad.c
@@ -35,12 +35,11 @@
  */
 #define DRIVER_VERSION "v3.2"
 #define DRIVER_DESC    "USB Acecad Flair tablet driver"
-#define DRIVER_LICENSE "GPL"
 #define DRIVER_AUTHOR  "Edouard TISSERANT <edouard.tisserant@wanadoo.fr>"
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE(DRIVER_LICENSE);
+MODULE_LICENSE("GPL");
 
 #define USB_VENDOR_ID_ACECAD	0x0460
 #define USB_DEVICE_ID_FLAIR	0x0004
diff --git a/drivers/input/tablet/hanwang.c b/drivers/input/tablet/hanwang.c
index df4bea96d7ed..70cb26bbfe1d 100644
--- a/drivers/input/tablet/hanwang.c
+++ b/drivers/input/tablet/hanwang.c
@@ -30,11 +30,10 @@
 
 #define DRIVER_AUTHOR   "Xing Wei <weixing@hanwang.com.cn>"
 #define DRIVER_DESC     "USB Hanwang tablet driver"
-#define DRIVER_LICENSE  "GPL"
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE(DRIVER_LICENSE);
+MODULE_LICENSE("GPL");
 
 #define USB_VENDOR_ID_HANWANG		0x0b57
 #define HANWANG_TABLET_INT_CLASS	0x0003
diff --git a/drivers/input/tablet/kbtab.c b/drivers/input/tablet/kbtab.c
index a41c3ff7c9af..bee18e33e261 100644
--- a/drivers/input/tablet/kbtab.c
+++ b/drivers/input/tablet/kbtab.c
@@ -15,11 +15,10 @@
 #define DRIVER_VERSION "v0.0.2"
 #define DRIVER_AUTHOR "Josh Myer <josh@joshisanerd.com>"
 #define DRIVER_DESC "USB KB Gear JamStudio Tablet driver"
-#define DRIVER_LICENSE "GPL"
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE(DRIVER_LICENSE);
+MODULE_LICENSE("GPL");
 
 #define USB_VENDOR_ID_KBGEAR	0x084e
 
-- 
2.15.0

