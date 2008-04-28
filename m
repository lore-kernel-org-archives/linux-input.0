From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 2/2] appletouch: simplify touchpad type detection
Date: Mon, 28 Apr 2008 23:02:11 +0200
Message-ID: <1209416531.3960.4.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:54160 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531AbYD2L57 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Apr 2008 07:57:59 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Sven Anders <anders@anduras.de>

From: Sven Anders <anders@anduras.de>

This patch simplifies type detection and removed uncessary code.

Signed-off-by: Sven Anders <anders@anduras.de>
[jberg: don't typedef, checkpatch clean, remove useless comments, ...]
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 drivers/input/mouse/appletouch.c |  165 +++++++++++++--------------------------
 1 file changed, 58 insertions(+), 107 deletions(-)

--- everything.orig/drivers/input/mouse/appletouch.c	2008-04-28 22:52:42.000000000 +0200
+++ everything/drivers/input/mouse/appletouch.c	2008-04-28 22:53:56.000000000 +0200
@@ -35,79 +35,59 @@
 #include <linux/module.h>
 #include <linux/usb/input.h>
 
-/* Apple has powerbooks which have the keyboard with different Product IDs */
-#define APPLE_VENDOR_ID		0x05AC
-
-/* These names come from Info.plist in AppleUSBTrackpad.kext */
-
-/* PowerBooks Feb 2005 / iBooks */
-#define FOUNTAIN_ANSI_PRODUCT_ID	0x020E
-#define FOUNTAIN_ISO_PRODUCT_ID		0x020F
-
-#define FOUNTAIN_TP_ONLY_PRODUCT_ID	0x030A
-
-#define GEYSER1_TP_ONLY_PRODUCT_ID	0x030B
-
-/* PowerBooks Oct 2005 */
-#define GEYSER2_ANSI_PRODUCT_ID		0x0214
-#define GEYSER2_ISO_PRODUCT_ID		0x0215
-#define GEYSER2_JIS_PRODUCT_ID		0x0216
-
-/* MacBook devices */
-#define GEYSER3_ANSI_PRODUCT_ID		0x0217
-#define GEYSER3_ISO_PRODUCT_ID		0x0218
-#define GEYSER3_JIS_PRODUCT_ID		0x0219
-
-/*
- * Geyser IV: same as Geyser III according to Info.plist in OSX's
- * AppleUSBTrackpad.kext
- * -> same IOClass (AppleUSBGrIIITrackpad), same acceleration tables
- */
-#define GEYSER4_ANSI_PRODUCT_ID		0x021A
-#define GEYSER4_ISO_PRODUCT_ID		0x021B
-#define GEYSER4_JIS_PRODUCT_ID		0x021C
-
-/* Macbook3,1 devices */
-#define GEYSER4_HF_ANSI_PRODUCT_ID	0x0229
-#define GEYSER4_HF_ISO_PRODUCT_ID	0x022A
-#define GEYSER4_HF_JIS_PRODUCT_ID	0x022B
+/* Type of touchpad */
+enum atp_touchpad_type {
+	ATP_FOUNTAIN,
+	ATP_GEYSER1,
+	ATP_GEYSER2,
+	ATP_GEYSER3,
+	ATP_GEYSER4
+};
 
-#define ATP_DEVICE(prod)					\
+#define ATP_DEVICE(prod, type)					\
+{								\
 	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |		\
 		       USB_DEVICE_ID_MATCH_INT_CLASS |		\
 		       USB_DEVICE_ID_MATCH_INT_PROTOCOL,	\
-	.idVendor = APPLE_VENDOR_ID,				\
+	.idVendor = 0x05ac, /* Apple */				\
 	.idProduct = (prod),					\
 	.bInterfaceClass = 0x03,				\
-	.bInterfaceProtocol = 0x02
+	.bInterfaceProtocol = 0x02,				\
+	.driver_info = ATP_ ## type,				\
+}
+
+/*
+ * Table of devices (Product IDs) that work with this driver.
+ * (The names come from Info.plist in AppleUSBTrackpad.kext,
+ *  According to Info.plist Geyser IV is the same as Geyser III.)
+ */
 
-/* table of devices that work with this driver */
 static struct usb_device_id atp_table [] = {
 	/* PowerBooks Feb 2005, iBooks G4 */
-	{ ATP_DEVICE(FOUNTAIN_ANSI_PRODUCT_ID) },
-	{ ATP_DEVICE(FOUNTAIN_ISO_PRODUCT_ID) },
-	{ ATP_DEVICE(FOUNTAIN_TP_ONLY_PRODUCT_ID) },
-	{ ATP_DEVICE(GEYSER1_TP_ONLY_PRODUCT_ID) },
+	ATP_DEVICE(0x020e, FOUNTAIN),	/* FOUNTAIN ANSI */
+	ATP_DEVICE(0x020f, FOUNTAIN),	/* FOUNTAIN ISO */
+	ATP_DEVICE(0x030a, FOUNTAIN),	/* FOUNTAIN TP ONLY */
+	ATP_DEVICE(0x030b, GEYSER1),	/* GEYSER 1 TP ONLY */
 
 	/* PowerBooks Oct 2005 */
-	{ ATP_DEVICE(GEYSER2_ANSI_PRODUCT_ID) },
-	{ ATP_DEVICE(GEYSER2_ISO_PRODUCT_ID) },
-	{ ATP_DEVICE(GEYSER2_JIS_PRODUCT_ID) },
+	ATP_DEVICE(0x0214, GEYSER2),	/* GEYSER 2 ANSI */
+	ATP_DEVICE(0x0215, GEYSER2),	/* GEYSER 2 ISO */
+	ATP_DEVICE(0x0216, GEYSER2),	/* GEYSER 2 JIS */
 
 	/* Core Duo MacBook & MacBook Pro */
-	{ ATP_DEVICE(GEYSER3_ANSI_PRODUCT_ID) },
-	{ ATP_DEVICE(GEYSER3_ISO_PRODUCT_ID) },
-	{ ATP_DEVICE(GEYSER3_JIS_PRODUCT_ID) },
+	ATP_DEVICE(0x0217, GEYSER3),	/* GEYSER 3 ANSI */
+	ATP_DEVICE(0x0218, GEYSER3),	/* GEYSER 3 ISO */
+	ATP_DEVICE(0x0219, GEYSER3),	/* GEYSER 3 JIS */
 
 	/* Core2 Duo MacBook & MacBook Pro */
-	{ ATP_DEVICE(GEYSER4_ANSI_PRODUCT_ID) },
-	{ ATP_DEVICE(GEYSER4_ISO_PRODUCT_ID) },
-	{ ATP_DEVICE(GEYSER4_JIS_PRODUCT_ID) },
+	ATP_DEVICE(0x021a, GEYSER4),	/* GEYSER 4 ANSI */
+	ATP_DEVICE(0x021b, GEYSER4),	/* GEYSER 4 ISO */
+	ATP_DEVICE(0x021c, GEYSER4),	/* GEYSER 4 JIS */
 
 	/* Core2 Duo MacBook3,1 */
-	{ ATP_DEVICE(GEYSER4_HF_ANSI_PRODUCT_ID) },
-	{ ATP_DEVICE(GEYSER4_HF_ISO_PRODUCT_ID) },
-	{ ATP_DEVICE(GEYSER4_HF_JIS_PRODUCT_ID) },
+	ATP_DEVICE(0x0229, GEYSER4),	/* GEYSER 4 HF ANSI */
+	ATP_DEVICE(0x022a, GEYSER4),	/* GEYSER 4 HF ISO */
+	ATP_DEVICE(0x022b, GEYSER4),	/* GEYSER 4 HF JIS */
 
 	/* Terminating entry */
 	{ }
@@ -132,9 +112,13 @@ MODULE_DEVICE_TABLE(usb, atp_table);
  * We try to keep the touchpad aspect ratio while still doing only simple
  * arithmetics.
  * The factors below give coordinates like:
- *	0 <= x <  960 on 12" and 15" Powerbooks
- *	0 <= x < 1600 on 17" Powerbooks
- *	0 <= y <  646
+ *
+ *      0 <= x <  960 on 12" and 15" Powerbooks
+ *      0 <= x < 1600 on 17" Powerbooks and 17" MacBook Pro
+ *      0 <= x < 1216 on MacBooks and 15" MacBook Pro
+ *
+ *      0 <= y <  646 on all Powerbooks
+ *      0 <= y <  774 on all MacBooks
  */
 #define ATP_XFACT	64
 #define ATP_YFACT	43
@@ -159,6 +143,7 @@ struct atp {
 	struct urb 		*urb;		/* usb request block */
 	signed char 		*data;		/* transferred data */
 	struct input_dev 	*input;		/* input dev */
+	enum atp_touchpad_type	type;		/* type of touchpad */
 	bool			open;
 	bool			valid;		/* are the samples valid? */
 	bool			size_detect_done;
@@ -209,40 +194,6 @@ static int debug;
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Activate debugging output");
 
-static inline int atp_is_fountain(struct atp *dev)
-{
-	u16 productId = le16_to_cpu(dev->udev->descriptor.idProduct);
-
-	return productId == FOUNTAIN_ANSI_PRODUCT_ID ||
-	       productId == FOUNTAIN_ISO_PRODUCT_ID ||
-	       productId == FOUNTAIN_TP_ONLY_PRODUCT_ID;
-}
-
-/* Checks if the device a Geyser 2 (ANSI, ISO, JIS) */
-static inline int atp_is_geyser_2(struct atp *dev)
-{
-	u16 productId = le16_to_cpu(dev->udev->descriptor.idProduct);
-
-	return (productId == GEYSER2_ANSI_PRODUCT_ID) ||
-		(productId == GEYSER2_ISO_PRODUCT_ID) ||
-		(productId == GEYSER2_JIS_PRODUCT_ID);
-}
-
-static inline int atp_is_geyser_3(struct atp *dev)
-{
-	u16 productId = le16_to_cpu(dev->udev->descriptor.idProduct);
-
-	return (productId == GEYSER3_ANSI_PRODUCT_ID) ||
-		(productId == GEYSER3_ISO_PRODUCT_ID) ||
-		(productId == GEYSER3_JIS_PRODUCT_ID) ||
-		(productId == GEYSER4_ANSI_PRODUCT_ID) ||
-		(productId == GEYSER4_ISO_PRODUCT_ID) ||
-		(productId == GEYSER4_JIS_PRODUCT_ID) ||
-		(productId == GEYSER4_HF_ANSI_PRODUCT_ID) ||
-		(productId == GEYSER4_HF_ISO_PRODUCT_ID) ||
-		(productId == GEYSER4_HF_JIS_PRODUCT_ID);
-}
-
 /*
  * By default newer Geyser devices send standard USB HID mouse
  * packets (Report ID 2). This code changes device mode, so it
@@ -421,7 +372,7 @@ static void atp_complete(struct urb *urb
 	}
 
 	/* reorder the sensors values */
-	if (atp_is_geyser_3(dev)) {
+	if ((dev->type == ATP_GEYSER3) || (dev->type == ATP_GEYSER4)) {
 		memset(dev->xy_cur, 0, sizeof(dev->xy_cur));
 
 		/*
@@ -440,7 +391,7 @@ static void atp_complete(struct urb *urb
 			dev->xy_cur[ATP_XSENSORS + i] = dev->data[j + 1];
 			dev->xy_cur[ATP_XSENSORS + i + 1] = dev->data[j + 2];
 		}
-	} else if (atp_is_geyser_2(dev)) {
+	} else if (dev->type == ATP_GEYSER2) {
 		memset(dev->xy_cur, 0, sizeof(dev->xy_cur));
 
 		/*
@@ -484,17 +435,17 @@ static void atp_complete(struct urb *urb
 		memcpy(dev->xy_old, dev->xy_cur, sizeof(dev->xy_old));
 
 		if (dev->size_detect_done ||
-		    atp_is_geyser_3(dev)) /* No 17" Macbooks (yet) */
+		    dev->type == ATP_GEYSER3) /* No 17" Macbooks (yet) */
 			goto exit;
 
 		/* 17" Powerbooks have extra X sensors */
-		for (i = (atp_is_geyser_2(dev) ? 15 : 16);
+		for (i = (dev->type == ATP_GEYSER2 ? 15 : 16);
 		     i < ATP_XSENSORS; i++) {
 			if (!dev->xy_cur[i])
 				continue;
 
 			printk(KERN_INFO "appletouch: 17\" model detected.\n");
-			if (atp_is_geyser_2(dev))
+			if (dev->type == ATP_GEYSER2)
 				input_set_abs_params(dev->input, ABS_X, 0,
 						     (20 - 1) *
 						     ATP_XFACT - 1,
@@ -574,7 +525,7 @@ static void atp_complete(struct urb *urb
 	 * several hundred times a second. Re-initialization does not
 	 * work on Fountain touchpads.
 	 */
-	if (!atp_is_fountain(dev)) {
+	if (dev->type != ATP_FOUNTAIN) {
 		/*
 		 * Button must not be pressed when entering suspend,
 		 * otherwise we will never release the button.
@@ -655,15 +606,15 @@ static int atp_probe(struct usb_interfac
 
 	dev->udev = udev;
 	dev->input = input_dev;
+	dev->type = id->driver_info;
 	dev->overflow_warned = false;
-	if (atp_is_geyser_3(dev))
-		dev->datalen = 64;
-	else if (atp_is_geyser_2(dev))
-		dev->datalen = 64;
-	else
+	if ((dev->type == ATP_FOUNTAIN) ||
+	    (dev->type == ATP_GEYSER1))
 		dev->datalen = 81;
+	else
+		dev->datalen = 64;
 
-	if (!atp_is_fountain(dev)) {
+	if (dev->type != ATP_FOUNTAIN) {
 		/* switch to raw sensor mode */
 		if (atp_geyser_init(udev))
 			goto err_free_devs;
@@ -699,7 +650,7 @@ static int atp_probe(struct usb_interfac
 
 	set_bit(EV_ABS, input_dev->evbit);
 
-	if (atp_is_geyser_3(dev)) {
+	if ((dev->type == ATP_GEYSER3) || (dev->type == ATP_GEYSER4)) {
 		/*
 		 * MacBook have 20 X sensors, 10 Y sensors
 		 */
@@ -707,7 +658,7 @@ static int atp_probe(struct usb_interfac
 				     ((20 - 1) * ATP_XFACT) - 1, ATP_FUZZ, 0);
 		input_set_abs_params(input_dev, ABS_Y, 0,
 				     ((10 - 1) * ATP_YFACT) - 1, ATP_FUZZ, 0);
-	} else if (atp_is_geyser_2(dev)) {
+	} else if (dev->type == ATP_GEYSER2) {
 		/*
 		 * Oct 2005 15" PowerBooks have 15 X sensors, 17" are detected
 		 * later.


