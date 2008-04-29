From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 1/2] appletouch: miscellaneous code cleanups
Date: Tue, 29 Apr 2008 10:57:44 +0200
Message-ID: <1209459464.3960.24.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:54176 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbYD2L6Q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Apr 2008 07:58:16 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Sven Anders <anders@anduras.de>

This patch does some code cleanups in appletouch:
 * useless comment removal
 * make almost checkpatch clean
 * make sparse clean

Signed-off-by: Sven Anders <anders@anduras.de>
[jberg: most of the changes including removing much of the original patch]
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 drivers/input/mouse/appletouch.c |  178 +++++++++++++++++++++++----------------
 1 file changed, 105 insertions(+), 73 deletions(-)

--- everything.orig/drivers/input/mouse/appletouch.c	2008-04-28 21:46:43.000000000 +0200
+++ everything/drivers/input/mouse/appletouch.c	2008-04-29 10:56:39.000000000 +0200
@@ -2,12 +2,13 @@
  * Apple USB Touchpad (for post-February 2005 PowerBooks and MacBooks) driver
  *
  * Copyright (C) 2001-2004 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (C) 2005      Johannes Berg (johannes@sipsolutions.net)
+ * Copyright (C) 2005-2008 Johannes Berg (johannes@sipsolutions.net)
  * Copyright (C) 2005      Stelian Pop (stelian@popies.net)
  * Copyright (C) 2005      Frank Arnold (frank@scirocco-5v-turbo.de)
  * Copyright (C) 2005      Peter Osterlund (petero2@telia.com)
  * Copyright (C) 2005      Michael Hanselmann (linux-kernel@hansmi.ch)
  * Copyright (C) 2006      Nicolas Boichat (nicolas@boichat.ch)
+ * Copyright (C) 2007-2008 Sven Anders (anders@anduras.de)
  *
  * Thanks to Alex Harper <basilisk@foobox.net> for his inputs.
  *
@@ -38,6 +39,8 @@
 #define APPLE_VENDOR_ID		0x05AC
 
 /* These names come from Info.plist in AppleUSBTrackpad.kext */
+
+/* PowerBooks Feb 2005 / iBooks */
 #define FOUNTAIN_ANSI_PRODUCT_ID	0x020E
 #define FOUNTAIN_ISO_PRODUCT_ID		0x020F
 
@@ -45,9 +48,10 @@
 
 #define GEYSER1_TP_ONLY_PRODUCT_ID	0x030B
 
-#define GEYSER_ANSI_PRODUCT_ID		0x0214
-#define GEYSER_ISO_PRODUCT_ID		0x0215
-#define GEYSER_JIS_PRODUCT_ID		0x0216
+/* PowerBooks Oct 2005 */
+#define GEYSER2_ANSI_PRODUCT_ID		0x0214
+#define GEYSER2_ISO_PRODUCT_ID		0x0215
+#define GEYSER2_JIS_PRODUCT_ID		0x0216
 
 /* MacBook devices */
 #define GEYSER3_ANSI_PRODUCT_ID		0x0217
@@ -55,13 +59,15 @@
 #define GEYSER3_JIS_PRODUCT_ID		0x0219
 
 /*
- * Geyser IV: same as Geyser III according to Info.plist in AppleUSBTrackpad.kext
+ * Geyser IV: same as Geyser III according to Info.plist in OSX's
+ * AppleUSBTrackpad.kext
  * -> same IOClass (AppleUSBGrIIITrackpad), same acceleration tables
  */
-#define GEYSER4_ANSI_PRODUCT_ID	0x021A
-#define GEYSER4_ISO_PRODUCT_ID	0x021B
-#define GEYSER4_JIS_PRODUCT_ID	0x021C
+#define GEYSER4_ANSI_PRODUCT_ID		0x021A
+#define GEYSER4_ISO_PRODUCT_ID		0x021B
+#define GEYSER4_JIS_PRODUCT_ID		0x021C
 
+/* Macbook3,1 devices */
 #define GEYSER4_HF_ANSI_PRODUCT_ID	0x0229
 #define GEYSER4_HF_ISO_PRODUCT_ID	0x022A
 #define GEYSER4_HF_JIS_PRODUCT_ID	0x022B
@@ -77,15 +83,16 @@
 
 /* table of devices that work with this driver */
 static struct usb_device_id atp_table [] = {
+	/* PowerBooks Feb 2005, iBooks G4 */
 	{ ATP_DEVICE(FOUNTAIN_ANSI_PRODUCT_ID) },
 	{ ATP_DEVICE(FOUNTAIN_ISO_PRODUCT_ID) },
 	{ ATP_DEVICE(FOUNTAIN_TP_ONLY_PRODUCT_ID) },
 	{ ATP_DEVICE(GEYSER1_TP_ONLY_PRODUCT_ID) },
 
 	/* PowerBooks Oct 2005 */
-	{ ATP_DEVICE(GEYSER_ANSI_PRODUCT_ID) },
-	{ ATP_DEVICE(GEYSER_ISO_PRODUCT_ID) },
-	{ ATP_DEVICE(GEYSER_JIS_PRODUCT_ID) },
+	{ ATP_DEVICE(GEYSER2_ANSI_PRODUCT_ID) },
+	{ ATP_DEVICE(GEYSER2_ISO_PRODUCT_ID) },
+	{ ATP_DEVICE(GEYSER2_JIS_PRODUCT_ID) },
 
 	/* Core Duo MacBook & MacBook Pro */
 	{ ATP_DEVICE(GEYSER3_ANSI_PRODUCT_ID) },
@@ -97,6 +104,7 @@ static struct usb_device_id atp_table []
 	{ ATP_DEVICE(GEYSER4_ISO_PRODUCT_ID) },
 	{ ATP_DEVICE(GEYSER4_JIS_PRODUCT_ID) },
 
+	/* Core2 Duo MacBook3,1 */
 	{ ATP_DEVICE(GEYSER4_HF_ANSI_PRODUCT_ID) },
 	{ ATP_DEVICE(GEYSER4_HF_ISO_PRODUCT_ID) },
 	{ ATP_DEVICE(GEYSER4_HF_JIS_PRODUCT_ID) },
@@ -104,7 +112,7 @@ static struct usb_device_id atp_table []
 	/* Terminating entry */
 	{ }
 };
-MODULE_DEVICE_TABLE (usb, atp_table);
+MODULE_DEVICE_TABLE(usb, atp_table);
 
 /*
  * number of sensors. Note that only 16 instead of 26 X (horizontal)
@@ -147,43 +155,45 @@ MODULE_DEVICE_TABLE (usb, atp_table);
 /* Structure to hold all of our device specific stuff */
 struct atp {
 	char			phys[64];
-	struct usb_device *	udev;		/* usb device */
-	struct urb *		urb;		/* usb request block */
-	signed char *		data;		/* transferred data */
-	struct input_dev *	input;		/* input dev */
-	unsigned char		open;		/* non-zero if opened */
-	unsigned char		valid;		/* are the sensors valid ? */
-	unsigned char		size_detect_done;
-	unsigned char		overflowwarn;	/* overflow warning printed? */
+	struct usb_device 	*udev;		/* usb device */
+	struct urb 		*urb;		/* usb request block */
+	signed char 		*data;		/* transferred data */
+	struct input_dev 	*input;		/* input dev */
+	bool			open;
+	bool			valid;		/* are the samples valid? */
+	bool			size_detect_done;
+	bool			overflow_warned;
 	int			x_old;		/* last reported x/y, */
 	int			y_old;		/* used for smoothing */
-						/* current value of the sensors */
 	signed char		xy_cur[ATP_XSENSORS + ATP_YSENSORS];
-						/* last value of the sensors */
 	signed char		xy_old[ATP_XSENSORS + ATP_YSENSORS];
-						/* accumulated sensors */
 	int			xy_acc[ATP_XSENSORS + ATP_YSENSORS];
-	int			datalen;	/* size of an USB urb transfer */
-	int			idlecount;      /* number of empty packets */
-	struct work_struct      work;
+	int			datalen;	/* size of USB transfer */
+	int			idlecount;	/* number of empty packets */
+	struct work_struct	work;
 };
 
 #define dbg_dump(msg, tab) \
 	if (debug > 1) {						\
-		int i;							\
-		printk("appletouch: %s %lld", msg, (long long)jiffies); \
-		for (i = 0; i < ATP_XSENSORS + ATP_YSENSORS; i++)	\
-			printk(" %02x", tab[i]);			\
+		int __i;						\
+		printk(KERN_DEBUG "appletouch: %s", msg);		\
+		for (__i = 0; __i < ATP_XSENSORS + ATP_YSENSORS; __i++)	\
+			printk(" %02x", tab[__i]);			\
 		printk("\n");						\
 	}
 
 #define dprintk(format, a...)						\
 	do {								\
-		if (debug) printk(KERN_DEBUG format, ##a);		\
+		if (debug)						\
+			printk(KERN_DEBUG format, ##a);			\
 	} while (0)
 
-MODULE_AUTHOR("Johannes Berg, Stelian Pop, Frank Arnold, Michael Hanselmann");
-MODULE_DESCRIPTION("Apple PowerBooks USB touchpad driver");
+MODULE_AUTHOR("Johannes Berg");
+MODULE_AUTHOR("Stelian Pop");
+MODULE_AUTHOR("Frank Arnold");
+MODULE_AUTHOR("Michael Hanselmann");
+MODULE_AUTHOR("Sven Anders");
+MODULE_DESCRIPTION("Apple PowerBook and MacBook USB touchpad driver");
 MODULE_LICENSE("GPL");
 
 /*
@@ -191,9 +201,11 @@ MODULE_LICENSE("GPL");
  */
 static int threshold = ATP_THRESHOLD;
 module_param(threshold, int, 0644);
-MODULE_PARM_DESC(threshold, "Discards any change in data from a sensor (trackpad has hundreds of these sensors) less than this value");
+MODULE_PARM_DESC(threshold, "Discard any change in data from a sensor"
+			    " (the trackpad has many of these sensors)"
+			    " less than this value.");
 
-static int debug = 1;
+static int debug;
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Activate debugging output");
 
@@ -211,9 +223,9 @@ static inline int atp_is_geyser_2(struct
 {
 	u16 productId = le16_to_cpu(dev->udev->descriptor.idProduct);
 
-	return (productId == GEYSER_ANSI_PRODUCT_ID) ||
-		(productId == GEYSER_ISO_PRODUCT_ID) ||
-		(productId == GEYSER_JIS_PRODUCT_ID);
+	return (productId == GEYSER2_ANSI_PRODUCT_ID) ||
+		(productId == GEYSER2_ISO_PRODUCT_ID) ||
+		(productId == GEYSER2_JIS_PRODUCT_ID);
 }
 
 static inline int atp_is_geyser_3(struct atp *dev)
@@ -248,8 +260,14 @@ static int atp_geyser_init(struct usb_de
 			ATP_GEYSER_MODE_REQUEST_INDEX, &data, 8, 5000);
 
 	if (size != 8) {
-		err("Could not do mode read request from device"
-		    " (Geyser Raw mode)");
+		if (debug) {
+			int i;
+			printk(KERN_DEBUG "atp_geyser_init: read error\n");
+			for (i = 0; i < 8; i++)
+				printk(KERN_DEBUG "appletouch[%d]: %d\n",
+				       i, data[i]);
+		}
+		err("Failed to read mode from device.");
 		return -EIO;
 	}
 
@@ -263,8 +281,14 @@ static int atp_geyser_init(struct usb_de
 			ATP_GEYSER_MODE_REQUEST_INDEX, &data, 8, 5000);
 
 	if (size != 8) {
-		err("Could not do mode write request to device"
-		    " (Geyser Raw mode)");
+		if (debug) {
+			int i;
+			printk(KERN_DEBUG "atp_geyser_init: write error\n");
+			for (i = 0; i < 8; i++)
+				printk(KERN_DEBUG "appletouch[%d]: %d\n",
+				       i, data[i]);
+		}
+		err("Failed to request geyser raw mode");
 		return -EIO;
 	}
 	return 0;
@@ -280,15 +304,15 @@ static void atp_reinit(struct work_struc
 	struct usb_device *udev = dev->udev;
 	int retval;
 
+	dprintk("appletouch: putting appletouch to sleep (reinit)\n");
 	dev->idlecount = 0;
 
 	atp_geyser_init(udev);
 
 	retval = usb_submit_urb(dev->urb, GFP_ATOMIC);
-	if (retval) {
-		err("%s - usb_submit_urb failed with result %d",
-		    __FUNCTION__, retval);
-	}
+	if (retval)
+		err("atp_reinit: usb_submit_urb failed with error %d",
+		    retval);
 }
 
 static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact,
@@ -323,7 +347,8 @@ static int atp_calculate_abs(int *xy_sen
 		 *
 		 * - Jason Parekh <jasonparekh@gmail.com>
 		 */
-		if (i < 1 || (!is_increasing && xy_sensors[i - 1] < xy_sensors[i])) {
+		if (i < 1 ||
+		    (!is_increasing && xy_sensors[i - 1] < xy_sensors[i])) {
 			(*fingers)++;
 			is_increasing = 1;
 		} else if (i > 0 && xy_sensors[i - 1] >= xy_sensors[i]) {
@@ -331,11 +356,11 @@ static int atp_calculate_abs(int *xy_sen
 		}
 
 		/*
-		 * Subtracts threshold so a high sensor that just passes the threshold
-		 * won't skew the calculated absolute coordinate.  Fixes an issue
-		 * where slowly moving the mouse would occassionaly jump a number of
-		 * pixels (let me restate--slowly moving the mouse makes this issue
-		 * most apparent).
+		 * Subtracts threshold so a high sensor that just passes the
+		 * threshold won't skew the calculated absolute coordinate.
+		 * Fixes an issue where slowly moving the mouse would
+		 * occasionally jump a number of pixels (slowly moving the
+		 * finger makes this issue most apparent.)
 		 */
 		pcum += (xy_sensors[i] - threshold) * i;
 		psum += (xy_sensors[i] - threshold);
@@ -356,7 +381,7 @@ static inline void atp_report_fingers(st
 	input_report_key(input, BTN_TOOL_TRIPLETAP, fingers > 2);
 }
 
-static void atp_complete(struct urb* urb)
+static void atp_complete(struct urb *urb)
 {
 	int x, y, x_z, y_z, x_f, y_f;
 	int retval, i, j;
@@ -368,22 +393,22 @@ static void atp_complete(struct urb* urb
 		/* success */
 		break;
 	case -EOVERFLOW:
-		if(!dev->overflowwarn) {
+		if (!dev->overflow_warned) {
 			printk(KERN_WARNING "appletouch: OVERFLOW with data "
 				"length %d, actual length is %d\n",
 				dev->datalen, dev->urb->actual_length);
-			dev->overflowwarn = 1;
+			dev->overflow_warned = true;
 		}
 	case -ECONNRESET:
 	case -ENOENT:
 	case -ESHUTDOWN:
 		/* This urb is terminated, clean up */
-		dbg("%s - urb shutting down with status: %d",
-		    __FUNCTION__, urb->status);
+		dbg("atp_complete: urb shutting down with status: %d",
+		    urb->status);
 		return;
 	default:
-		dbg("%s - nonzero urb status received: %d",
-		    __FUNCTION__, urb->status);
+		dbg("atp_complete: nonzero urb status received: %d",
+		    urb->status);
 		goto exit;
 	}
 
@@ -438,7 +463,7 @@ static void atp_complete(struct urb* urb
 	} else {
 		for (i = 0; i < 8; i++) {
 			/* X values */
-			dev->xy_cur[i     ] = dev->data[5 * i +  2];
+			dev->xy_cur[i +  0] = dev->data[5 * i +  2];
 			dev->xy_cur[i +  8] = dev->data[5 * i +  4];
 			dev->xy_cur[i + 16] = dev->data[5 * i + 42];
 			if (i < 2)
@@ -454,7 +479,7 @@ static void atp_complete(struct urb* urb
 
 	if (!dev->valid) {
 		/* first sample */
-		dev->valid = 1;
+		dev->valid = true;
 		dev->x_old = dev->y_old = -1;
 		memcpy(dev->xy_old, dev->xy_cur, sizeof(dev->xy_old));
 
@@ -463,7 +488,8 @@ static void atp_complete(struct urb* urb
 			goto exit;
 
 		/* 17" Powerbooks have extra X sensors */
-		for (i = (atp_is_geyser_2(dev) ? 15 : 16); i < ATP_XSENSORS; i++) {
+		for (i = (atp_is_geyser_2(dev) ? 15 : 16);
+		     i < ATP_XSENSORS; i++) {
 			if (!dev->xy_cur[i])
 				continue;
 
@@ -549,10 +575,14 @@ static void atp_complete(struct urb* urb
 	 * work on Fountain touchpads.
 	 */
 	if (!atp_is_fountain(dev)) {
+		/*
+		 * Button must not be pressed when entering suspend,
+		 * otherwise we will never release the button.
+		 */
 		if (!x && !y && !key) {
 			dev->idlecount++;
 			if (dev->idlecount == 10) {
-				dev->valid = 0;
+				dev->valid = false;
 				schedule_work(&dev->work);
 				/* Don't resubmit urb here, wait for reinit */
 				return;
@@ -561,12 +591,11 @@ static void atp_complete(struct urb* urb
 			dev->idlecount = 0;
 	}
 
-exit:
+ exit:
 	retval = usb_submit_urb(dev->urb, GFP_ATOMIC);
-	if (retval) {
-		err("%s - usb_submit_urb failed with result %d",
-		    __FUNCTION__, retval);
-	}
+	if (retval)
+		err("atp_complete: usb_submit_urb failed with result %d",
+		    retval);
 }
 
 static int atp_open(struct input_dev *input)
@@ -589,7 +618,8 @@ static void atp_close(struct input_dev *
 	dev->open = 0;
 }
 
-static int atp_probe(struct usb_interface *iface, const struct usb_device_id *id)
+static int atp_probe(struct usb_interface *iface,
+		     const struct usb_device_id *id)
 {
 	struct atp *dev;
 	struct input_dev *input_dev;
@@ -625,7 +655,7 @@ static int atp_probe(struct usb_interfac
 
 	dev->udev = udev;
 	dev->input = input_dev;
-	dev->overflowwarn = 0;
+	dev->overflow_warned = false;
 	if (atp_is_geyser_3(dev))
 		dev->datalen = 64;
 	else if (atp_is_geyser_2(dev))
@@ -692,9 +722,11 @@ static int atp_probe(struct usb_interfac
 		 * 17" models are detected later.
 		 */
 		input_set_abs_params(input_dev, ABS_X, 0,
-				     (16 - 1) * ATP_XFACT - 1, ATP_FUZZ, 0);
+				     (16 - 1) * ATP_XFACT - 1,
+				     ATP_FUZZ, 0);
 		input_set_abs_params(input_dev, ABS_Y, 0,
-				     (ATP_YSENSORS - 1) * ATP_YFACT - 1, ATP_FUZZ, 0);
+				     (ATP_YSENSORS - 1) * ATP_YFACT - 1,
+				     ATP_FUZZ, 0);
 	}
 	input_set_abs_params(input_dev, ABS_PRESSURE, 0, ATP_PRESSURE, 0, 0);
 
@@ -749,7 +781,7 @@ static int atp_suspend(struct usb_interf
 	struct atp *dev = usb_get_intfdata(iface);
 
 	usb_kill_urb(dev->urb);
-	dev->valid = 0;
+	dev->valid = false;
 
 	return 0;
 }


