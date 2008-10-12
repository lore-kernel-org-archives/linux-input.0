From: Stelian Pop <stelian@popies.net>
Subject: [PATCH v3] Input: appletouch - driver refactoring
Date: Sun, 12 Oct 2008 18:03:41 +0200
Message-ID: <1223827421.11389.5.camel@galileo>
References: <1223542147.6130.14.camel@galileo>
	 <20081011032120.GB22499@anvil.corenet.prv>
	 <1223822468.9733.1.camel@galileo>  <1223822674.9733.5.camel@galileo>
	 <1223823289.10176.9.camel@johannes.berg> <1223827257.11389.1.camel@galileo>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sd-11162.dedibox.fr ([88.191.70.230]:53267 "EHLO
	sd-11162.dedibox.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122AbYJLQDq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Oct 2008 12:03:46 -0400
In-Reply-To: <1223827257.11389.1.camel@galileo>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

The appletouch driver has grown up from supporting only a couple of
touchpads into supporting many touchpads, which can have different
number of sensors, different aspect ratios etc.

This patch cleans up the current driver code and makes it easy to
support the features of each different touchpad.

As a side effect, this patch also modifies the 'Y' multiplication factor
of the 'geyser3' and 'geyser4' touchpads (found on Core Duo and Core2
Duo MacBook and MacBook Pro laptops) in order to make the touchpad
output match the aspect ratio of the touchpad (Y factor changed from 43
to 64).

Signed-off-by: Stelian Pop <stelian@popies.net>
---

This patch applies on top of the 'next' branch of the linux-input
git tree.

This is the third iteration of the patch, which removes the atp_touchpad_type
enumeration completely.

 drivers/input/mouse/appletouch.c |  245 +++++++++++++++++++-------------------
 1 files changed, 120 insertions(+), 125 deletions(-)

diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
index 079816e..ea36f14 100644
--- a/drivers/input/mouse/appletouch.c
+++ b/drivers/input/mouse/appletouch.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2001-2004 Greg Kroah-Hartman (greg@kroah.com)
  * Copyright (C) 2005-2008 Johannes Berg (johannes@sipsolutions.net)
- * Copyright (C) 2005      Stelian Pop (stelian@popies.net)
+ * Copyright (C) 2005-2008 Stelian Pop (stelian@popies.net)
  * Copyright (C) 2005      Frank Arnold (frank@scirocco-5v-turbo.de)
  * Copyright (C) 2005      Peter Osterlund (petero2@telia.com)
  * Copyright (C) 2005      Michael Hanselmann (linux-kernel@hansmi.ch)
@@ -35,16 +35,70 @@
 #include <linux/module.h>
 #include <linux/usb/input.h>
 
-/* Type of touchpad */
-enum atp_touchpad_type {
-	ATP_FOUNTAIN,
-	ATP_GEYSER1,
-	ATP_GEYSER2,
-	ATP_GEYSER3,
-	ATP_GEYSER4
+/*
+ * Note: We try to keep the touchpad aspect ratio while still doing only
+ * simple arithmetics:
+ *	0 <= x <= (xsensors - 1) * xfact
+ *	0 <= y <= (ysensors - 1) * yfact
+ */
+struct atp_info {
+	int xsensors;				/* number of X sensors */
+	int ysensors;				/* number of Y sensors */
+	int xfact;				/* X multiplication factor */
+	int yfact;				/* Y multiplication factor */
+	int datalen;				/* size of USB transfers */
+	void (*callback)(struct urb *);		/* callback function */
+};
+
+static void atp_complete_geyser_1_2(struct urb *urb);
+static void atp_complete_geyser_3_4(struct urb *urb);
+
+static struct atp_info fountain_info = {
+	.xsensors	= 16,		/* will be set to 26 on 17" */
+	.ysensors	= 16,
+	.xfact		= 64,
+	.yfact		= 43,
+	.datalen	= 81,
+	.callback	= atp_complete_geyser_1_2,
+};
+
+static struct atp_info geyser1_info = {
+	.xsensors	= 16,		/* will be set to 26 on 17" */
+	.ysensors	= 16,
+	.xfact		= 64,
+	.yfact		= 43,
+	.datalen	= 81,
+	.callback	= atp_complete_geyser_1_2,
 };
 
-#define ATP_DEVICE(prod, type)					\
+static struct atp_info geyser2_info = {
+	.xsensors	= 15,		/* will be set to 20 on 17" */
+	.ysensors	= 9,
+	.xfact		= 64,
+	.yfact		= 43,
+	.datalen	= 64,
+	.callback	= atp_complete_geyser_1_2,
+};
+
+static struct atp_info geyser3_info = {
+	.xsensors	= 20,
+	.ysensors	= 10,
+	.xfact		= 64,
+	.yfact		= 64,
+	.datalen	= 64,
+	.callback	= atp_complete_geyser_3_4,
+};
+
+static struct atp_info geyser4_info = {
+	.xsensors	= 20,
+	.ysensors	= 10,
+	.xfact		= 64,
+	.yfact		= 64,
+	.datalen	= 64,
+	.callback	= atp_complete_geyser_3_4,
+};
+
+#define ATP_DEVICE(prod, info)					\
 {								\
 	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |		\
 		       USB_DEVICE_ID_MATCH_INT_CLASS |		\
@@ -53,7 +107,7 @@ enum atp_touchpad_type {
 	.idProduct = (prod),					\
 	.bInterfaceClass = 0x03,				\
 	.bInterfaceProtocol = 0x02,				\
-	.driver_info = ATP_ ## type,				\
+	.driver_info = (unsigned long) &info,			\
 }
 
 /*
@@ -62,43 +116,39 @@ enum atp_touchpad_type {
  *  According to Info.plist Geyser IV is the same as Geyser III.)
  */
 
-static struct usb_device_id atp_table [] = {
+static struct usb_device_id atp_table[] = {
 	/* PowerBooks Feb 2005, iBooks G4 */
-	ATP_DEVICE(0x020e, FOUNTAIN),	/* FOUNTAIN ANSI */
-	ATP_DEVICE(0x020f, FOUNTAIN),	/* FOUNTAIN ISO */
-	ATP_DEVICE(0x030a, FOUNTAIN),	/* FOUNTAIN TP ONLY */
-	ATP_DEVICE(0x030b, GEYSER1),	/* GEYSER 1 TP ONLY */
+	ATP_DEVICE(0x020e, fountain_info),	/* FOUNTAIN ANSI */
+	ATP_DEVICE(0x020f, fountain_info),	/* FOUNTAIN ISO */
+	ATP_DEVICE(0x030a, fountain_info),	/* FOUNTAIN TP ONLY */
+	ATP_DEVICE(0x030b, geyser1_info),	/* GEYSER 1 TP ONLY */
 
 	/* PowerBooks Oct 2005 */
-	ATP_DEVICE(0x0214, GEYSER2),	/* GEYSER 2 ANSI */
-	ATP_DEVICE(0x0215, GEYSER2),	/* GEYSER 2 ISO */
-	ATP_DEVICE(0x0216, GEYSER2),	/* GEYSER 2 JIS */
+	ATP_DEVICE(0x0214, geyser2_info),	/* GEYSER 2 ANSI */
+	ATP_DEVICE(0x0215, geyser2_info),	/* GEYSER 2 ISO */
+	ATP_DEVICE(0x0216, geyser2_info),	/* GEYSER 2 JIS */
 
 	/* Core Duo MacBook & MacBook Pro */
-	ATP_DEVICE(0x0217, GEYSER3),	/* GEYSER 3 ANSI */
-	ATP_DEVICE(0x0218, GEYSER3),	/* GEYSER 3 ISO */
-	ATP_DEVICE(0x0219, GEYSER3),	/* GEYSER 3 JIS */
+	ATP_DEVICE(0x0217, geyser3_info),	/* GEYSER 3 ANSI */
+	ATP_DEVICE(0x0218, geyser3_info),	/* GEYSER 3 ISO */
+	ATP_DEVICE(0x0219, geyser3_info),	/* GEYSER 3 JIS */
 
 	/* Core2 Duo MacBook & MacBook Pro */
-	ATP_DEVICE(0x021a, GEYSER4),	/* GEYSER 4 ANSI */
-	ATP_DEVICE(0x021b, GEYSER4),	/* GEYSER 4 ISO */
-	ATP_DEVICE(0x021c, GEYSER4),	/* GEYSER 4 JIS */
+	ATP_DEVICE(0x021a, geyser4_info),	/* GEYSER 4 ANSI */
+	ATP_DEVICE(0x021b, geyser4_info),	/* GEYSER 4 ISO */
+	ATP_DEVICE(0x021c, geyser4_info),	/* GEYSER 4 JIS */
 
 	/* Core2 Duo MacBook3,1 */
-	ATP_DEVICE(0x0229, GEYSER4),	/* GEYSER 4 HF ANSI */
-	ATP_DEVICE(0x022a, GEYSER4),	/* GEYSER 4 HF ISO */
-	ATP_DEVICE(0x022b, GEYSER4),	/* GEYSER 4 HF JIS */
+	ATP_DEVICE(0x0229, geyser4_info),	/* GEYSER 4 HF ANSI */
+	ATP_DEVICE(0x022a, geyser4_info),	/* GEYSER 4 HF ISO */
+	ATP_DEVICE(0x022b, geyser4_info),	/* GEYSER 4 HF JIS */
 
 	/* Terminating entry */
 	{ }
 };
 MODULE_DEVICE_TABLE(usb, atp_table);
 
-/*
- * number of sensors. Note that only 16 instead of 26 X (horizontal)
- * sensors exist on 12" and 15" PowerBooks. All models have 16 Y
- * (vertical) sensors.
- */
+/* maximum number of sensors */
 #define ATP_XSENSORS	26
 #define ATP_YSENSORS	16
 
@@ -107,21 +157,6 @@ MODULE_DEVICE_TABLE(usb, atp_table);
 
 /* maximum pressure this driver will report */
 #define ATP_PRESSURE	300
-/*
- * multiplication factor for the X and Y coordinates.
- * We try to keep the touchpad aspect ratio while still doing only simple
- * arithmetics.
- * The factors below give coordinates like:
- *
- *      0 <= x <  960 on 12" and 15" Powerbooks
- *      0 <= x < 1600 on 17" Powerbooks and 17" MacBook Pro
- *      0 <= x < 1216 on MacBooks and 15" MacBook Pro
- *
- *      0 <= y <  646 on all Powerbooks
- *      0 <= y <  774 on all MacBooks
- */
-#define ATP_XFACT	64
-#define ATP_YFACT	43
 
 /*
  * Threshold for the touchpad sensors. Any change less than ATP_THRESHOLD is
@@ -159,7 +194,7 @@ struct atp {
 	struct urb		*urb;		/* usb request block */
 	u8			*data;		/* transferred data */
 	struct input_dev	*input;		/* input dev */
-	enum atp_touchpad_type	type;		/* type of touchpad */
+	struct atp_info		*info;		/* touchpad model */
 	bool			open;
 	bool			valid;		/* are the samples valid? */
 	bool			size_detect_done;
@@ -169,7 +204,6 @@ struct atp {
 	signed char		xy_cur[ATP_XSENSORS + ATP_YSENSORS];
 	signed char		xy_old[ATP_XSENSORS + ATP_YSENSORS];
 	int			xy_acc[ATP_XSENSORS + ATP_YSENSORS];
-	int			datalen;	/* size of USB transfer */
 	int			idlecount;	/* number of empty packets */
 	struct work_struct	work;
 };
@@ -359,7 +393,7 @@ static int atp_status_check(struct urb *urb)
 		if (!dev->overflow_warned) {
 			printk(KERN_WARNING "appletouch: OVERFLOW with data "
 				"length %d, actual length is %d\n",
-				dev->datalen, dev->urb->actual_length);
+				dev->info->datalen, dev->urb->actual_length);
 			dev->overflow_warned = true;
 		}
 	case -ECONNRESET:
@@ -377,7 +411,7 @@ static int atp_status_check(struct urb *urb)
 	}
 
 	/* drop incomplete datasets */
-	if (dev->urb->actual_length != dev->datalen) {
+	if (dev->urb->actual_length != dev->info->datalen) {
 		dprintk("appletouch: incomplete data package"
 			" (first byte: %d, length: %d).\n",
 			dev->data[0], dev->urb->actual_length);
@@ -407,7 +441,7 @@ static void atp_complete_geyser_1_2(struct urb *urb)
 		goto exit;
 
 	/* reorder the sensors values */
-	if (dev->type == ATP_GEYSER2) {
+	if (dev->info == &geyser2_info) {
 		memset(dev->xy_cur, 0, sizeof(dev->xy_cur));
 
 		/*
@@ -437,8 +471,8 @@ static void atp_complete_geyser_1_2(struct urb *urb)
 				dev->xy_cur[i + 24] = dev->data[5 * i + 44];
 
 			/* Y values */
-			dev->xy_cur[i + 26] = dev->data[5 * i +  1];
-			dev->xy_cur[i + 34] = dev->data[5 * i +  3];
+			dev->xy_cur[ATP_XSENSORS + i] = dev->data[5 * i +  1];
+			dev->xy_cur[ATP_XSENSORS + i + 8] = dev->data[5 * i + 3];
 		}
 	}
 
@@ -456,26 +490,22 @@ static void atp_complete_geyser_1_2(struct urb *urb)
 		if (!dev->size_detect_done) {
 
 			/* 17" Powerbooks have extra X sensors */
-			for (i = (dev->type == ATP_GEYSER2 ? 15 : 16);
-			     i < ATP_XSENSORS; i++) {
+			for (i = dev->info->xsensors; i < ATP_XSENSORS; i++) {
 				if (!dev->xy_cur[i])
 					continue;
 
 				printk(KERN_INFO
 					"appletouch: 17\" model detected.\n");
 
-				if (dev->type == ATP_GEYSER2)
-					input_set_abs_params(dev->input, ABS_X,
-							     0,
-							     (20 - 1) *
-							     ATP_XFACT - 1,
-							     ATP_FUZZ, 0);
+				if (dev->info == &geyser2_info)
+					dev->info->xsensors = 20;
 				else
-					input_set_abs_params(dev->input, ABS_X,
-							     0,
-							     (26 - 1) *
-							     ATP_XFACT - 1,
-							     ATP_FUZZ, 0);
+					dev->info->xsensors = 26;
+
+				input_set_abs_params(dev->input, ABS_X, 0,
+						     (dev->info->xsensors - 1) *
+						     dev->info->xfact - 1,
+						     ATP_FUZZ, 0);
 				break;
 			}
 
@@ -499,10 +529,10 @@ static void atp_complete_geyser_1_2(struct urb *urb)
 	dbg_dump("accumulator", dev->xy_acc);
 
 	x = atp_calculate_abs(dev->xy_acc, ATP_XSENSORS,
-			      ATP_XFACT, &x_z, &x_f);
+			      dev->info->xfact, &x_z, &x_f);
 	y = atp_calculate_abs(dev->xy_acc + ATP_XSENSORS, ATP_YSENSORS,
-			      ATP_YFACT, &y_z, &y_f);
-	key = dev->data[dev->datalen - 1] & ATP_STATUS_BUTTON;
+			      dev->info->yfact, &y_z, &y_f);
+	key = dev->data[dev->info->datalen - 1] & ATP_STATUS_BUTTON;
 
 	if (x && y) {
 		if (dev->x_old != -1) {
@@ -583,7 +613,7 @@ static void atp_complete_geyser_3_4(struct urb *urb)
 	dbg_dump("sample", dev->xy_cur);
 
 	/* Just update the base values (i.e. touchpad in untouched state) */
-	if (dev->data[dev->datalen - 1] & ATP_STATUS_BASE_UPDATE) {
+	if (dev->data[dev->info->datalen - 1] & ATP_STATUS_BASE_UPDATE) {
 
 		dprintk(KERN_DEBUG "appletouch: updated base values\n");
 
@@ -610,10 +640,10 @@ static void atp_complete_geyser_3_4(struct urb *urb)
 	dbg_dump("accumulator", dev->xy_acc);
 
 	x = atp_calculate_abs(dev->xy_acc, ATP_XSENSORS,
-			      ATP_XFACT, &x_z, &x_f);
+			      dev->info->xfact, &x_z, &x_f);
 	y = atp_calculate_abs(dev->xy_acc + ATP_XSENSORS, ATP_YSENSORS,
-			      ATP_YFACT, &y_z, &y_f);
-	key = dev->data[dev->datalen - 1] & ATP_STATUS_BUTTON;
+			      dev->info->yfact, &y_z, &y_f);
+	key = dev->data[dev->info->datalen - 1] & ATP_STATUS_BUTTON;
 
 	if (x && y) {
 		if (dev->x_old != -1) {
@@ -705,7 +735,7 @@ static int atp_handle_geyser(struct atp *dev)
 {
 	struct usb_device *udev = dev->udev;
 
-	if (dev->type != ATP_FOUNTAIN) {
+	if (dev->info != &fountain_info) {
 		/* switch to raw sensor mode */
 		if (atp_geyser_init(udev))
 			return -EIO;
@@ -726,6 +756,7 @@ static int atp_probe(struct usb_interface *iface,
 	struct usb_endpoint_descriptor *endpoint;
 	int int_in_endpointAddr = 0;
 	int i, error = -ENOMEM;
+	struct atp_info *info = (struct atp_info *)id->driver_info;
 
 	/* set up the endpoint information */
 	/* use only the first interrupt-in endpoint */
@@ -753,35 +784,22 @@ static int atp_probe(struct usb_interface *iface,
 
 	dev->udev = udev;
 	dev->input = input_dev;
-	dev->type = id->driver_info;
+	dev->info = info;
 	dev->overflow_warned = false;
-	if (dev->type == ATP_FOUNTAIN || dev->type == ATP_GEYSER1)
-		dev->datalen = 81;
-	else
-		dev->datalen = 64;
 
 	dev->urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!dev->urb)
 		goto err_free_devs;
 
-	dev->data = usb_buffer_alloc(dev->udev, dev->datalen, GFP_KERNEL,
+	dev->data = usb_buffer_alloc(dev->udev, dev->info->datalen, GFP_KERNEL,
 				     &dev->urb->transfer_dma);
 	if (!dev->data)
 		goto err_free_urb;
 
-	/* Select the USB complete (callback) function */
-	if (dev->type == ATP_FOUNTAIN ||
-	    dev->type == ATP_GEYSER1 ||
-	    dev->type == ATP_GEYSER2)
-		usb_fill_int_urb(dev->urb, udev,
-				 usb_rcvintpipe(udev, int_in_endpointAddr),
-				 dev->data, dev->datalen,
-				 atp_complete_geyser_1_2, dev, 1);
-	else
-		usb_fill_int_urb(dev->urb, udev,
-				 usb_rcvintpipe(udev, int_in_endpointAddr),
-				 dev->data, dev->datalen,
-				 atp_complete_geyser_3_4, dev, 1);
+	usb_fill_int_urb(dev->urb, udev,
+			 usb_rcvintpipe(udev, int_in_endpointAddr),
+			 dev->data, dev->info->datalen,
+			 dev->info->callback, dev, 1);
 
 	error = atp_handle_geyser(dev);
 	if (error)
@@ -802,35 +820,12 @@ static int atp_probe(struct usb_interface *iface,
 
 	set_bit(EV_ABS, input_dev->evbit);
 
-	if (dev->type == ATP_GEYSER3 || dev->type == ATP_GEYSER4) {
-		/*
-		 * MacBook have 20 X sensors, 10 Y sensors
-		 */
-		input_set_abs_params(input_dev, ABS_X, 0,
-				     ((20 - 1) * ATP_XFACT) - 1, ATP_FUZZ, 0);
-		input_set_abs_params(input_dev, ABS_Y, 0,
-				     ((10 - 1) * ATP_YFACT) - 1, ATP_FUZZ, 0);
-	} else if (dev->type == ATP_GEYSER2) {
-		/*
-		 * Oct 2005 15" PowerBooks have 15 X sensors, 17" are detected
-		 * later.
-		 */
-		input_set_abs_params(input_dev, ABS_X, 0,
-				     ((15 - 1) * ATP_XFACT) - 1, ATP_FUZZ, 0);
-		input_set_abs_params(input_dev, ABS_Y, 0,
-				     ((9 - 1) * ATP_YFACT) - 1, ATP_FUZZ, 0);
-	} else {
-		/*
-		 * 12" and 15" Powerbooks only have 16 x sensors,
-		 * 17" models are detected later.
-		 */
-		input_set_abs_params(input_dev, ABS_X, 0,
-				     (16 - 1) * ATP_XFACT - 1,
-				     ATP_FUZZ, 0);
-		input_set_abs_params(input_dev, ABS_Y, 0,
-				     (ATP_YSENSORS - 1) * ATP_YFACT - 1,
-				     ATP_FUZZ, 0);
-	}
+	input_set_abs_params(input_dev, ABS_X, 0,
+			     (dev->info->xsensors - 1) * dev->info->xfact - 1,
+			     ATP_FUZZ, 0);
+	input_set_abs_params(input_dev, ABS_Y, 0,
+			     (dev->info->ysensors - 1) * dev->info->yfact - 1,
+			     ATP_FUZZ, 0);
 	input_set_abs_params(input_dev, ABS_PRESSURE, 0, ATP_PRESSURE, 0, 0);
 
 	set_bit(EV_KEY, input_dev->evbit);
@@ -852,7 +847,7 @@ static int atp_probe(struct usb_interface *iface,
 	return 0;
 
  err_free_buffer:
-	usb_buffer_free(dev->udev, dev->datalen,
+	usb_buffer_free(dev->udev, dev->info->datalen,
 			dev->data, dev->urb->transfer_dma);
  err_free_urb:
 	usb_free_urb(dev->urb);
@@ -871,7 +866,7 @@ static void atp_disconnect(struct usb_interface *iface)
 	if (dev) {
 		usb_kill_urb(dev->urb);
 		input_unregister_device(dev->input);
-		usb_buffer_free(dev->udev, dev->datalen,
+		usb_buffer_free(dev->udev, dev->info->datalen,
 				dev->data, dev->urb->transfer_dma);
 		usb_free_urb(dev->urb);
 		kfree(dev);
-- 
1.5.4.3



