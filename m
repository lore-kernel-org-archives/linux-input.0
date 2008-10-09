From: Stelian Pop <stelian@popies.net>
Subject: [PATCH] appletouch driver refactoring
Date: Thu, 09 Oct 2008 10:49:07 +0200
Message-ID: <1223542147.6130.14.camel@galileo>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sd-11162.dedibox.fr ([88.191.70.230]:52577 "EHLO
	sd-11162.dedibox.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbYJIJSF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Oct 2008 05:18:05 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dtor@mail.ru>

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
 appletouch.c |  218 +++++++++++++++++++++++++++++++----------------------------
 1 file changed, 115 insertions(+), 103 deletions(-)

diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
index 1f41ae9..988dd98 100644
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
@@ -44,7 +44,67 @@ enum atp_touchpad_type {
 	ATP_GEYSER4
 };
 
-#define ATP_DEVICE(prod, type)					\
+/*
+ * Note: We try to keep the touchpad aspect ratio while still doing only
+ * simple arithmetics:
+ *	0 <= x <= (xsensors - 1) * xfact
+ *	0 <= y <= (ysensors - 1) * yfact
+ */
+struct atp_info {
+	enum atp_touchpad_type type;		/* see above */
+	int xsensors;				/* number of X sensors */
+	int ysensors;				/* number of Y sensors */
+	int xfact;				/* X multiplication factor */
+	int yfact;				/* Y multiplication factor */
+	int datalen;				/* size of USB transfers */
+};
+
+static struct atp_info fountain_info = {
+	.type		= ATP_FOUNTAIN,
+	.xsensors	= 16,		/* will be set to 26 on 17" */
+	.ysensors	= 16,
+	.xfact		= 64,
+	.yfact		= 43,
+	.datalen	= 81,
+};
+
+static struct atp_info geyser1_info = {
+	.type		= ATP_GEYSER1,
+	.xsensors	= 16,		/* will be set to 26 on 17" */
+	.ysensors	= 16,
+	.xfact		= 64,
+	.yfact		= 43,
+	.datalen	= 81,
+};
+
+static struct atp_info geyser2_info = {
+	.type		= ATP_GEYSER2,
+	.xsensors	= 15,		/* will be set to 20 on 17" */
+	.ysensors	= 9,
+	.xfact		= 64,
+	.yfact		= 43,
+	.datalen	= 64,
+};
+
+static struct atp_info geyser3_info = {
+	.type		= ATP_GEYSER3,
+	.xsensors	= 20,
+	.ysensors	= 10,
+	.xfact		= 64,
+	.yfact		= 64,
+	.datalen	= 64,
+};
+
+static struct atp_info geyser4_info = {
+	.type		= ATP_GEYSER4,
+	.xsensors	= 20,
+	.ysensors	= 10,
+	.xfact		= 64,
+	.yfact		= 64,
+	.datalen	= 64,
+};
+
+#define ATP_DEVICE(prod, info)					\
 {								\
 	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |		\
 		       USB_DEVICE_ID_MATCH_INT_CLASS |		\
@@ -53,7 +113,7 @@ enum atp_touchpad_type {
 	.idProduct = (prod),					\
 	.bInterfaceClass = 0x03,				\
 	.bInterfaceProtocol = 0x02,				\
-	.driver_info = ATP_ ## type,				\
+	.driver_info = (unsigned long) &info,			\
 }
 
 /*
@@ -62,43 +122,39 @@ enum atp_touchpad_type {
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
 
@@ -107,21 +163,6 @@ MODULE_DEVICE_TABLE(usb, atp_table);
 
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
@@ -143,7 +184,7 @@ struct atp {
 	struct urb		*urb;		/* usb request block */
 	signed char		*data;		/* transferred data */
 	struct input_dev	*input;		/* input dev */
-	enum atp_touchpad_type	type;		/* type of touchpad */
+	struct atp_info		*info;		/* touchpad model */
 	bool			open;
 	bool			valid;		/* are the samples valid? */
 	bool			size_detect_done;
@@ -153,7 +194,6 @@ struct atp {
 	signed char		xy_cur[ATP_XSENSORS + ATP_YSENSORS];
 	signed char		xy_old[ATP_XSENSORS + ATP_YSENSORS];
 	int			xy_acc[ATP_XSENSORS + ATP_YSENSORS];
-	int			datalen;	/* size of USB transfer */
 	int			idlecount;	/* number of empty packets */
 	struct work_struct	work;
 };
@@ -342,7 +382,7 @@ static void atp_complete(struct urb *urb)
 		if (!dev->overflow_warned) {
 			printk(KERN_WARNING "appletouch: OVERFLOW with data "
 				"length %d, actual length is %d\n",
-				dev->datalen, dev->urb->actual_length);
+				dev->info->datalen, dev->urb->actual_length);
 			dev->overflow_warned = true;
 		}
 	case -ECONNRESET:
@@ -359,7 +399,7 @@ static void atp_complete(struct urb *urb)
 	}
 
 	/* drop incomplete datasets */
-	if (dev->urb->actual_length != dev->datalen) {
+	if (dev->urb->actual_length != dev->info->datalen) {
 		dprintk("appletouch: incomplete data package"
 			" (first byte: %d, length: %d).\n",
 			dev->data[0], dev->urb->actual_length);
@@ -367,7 +407,7 @@ static void atp_complete(struct urb *urb)
 	}
 
 	/* reorder the sensors values */
-	if (dev->type == ATP_GEYSER3 || dev->type == ATP_GEYSER4) {
+	if (dev->info->type == ATP_GEYSER3 || dev->info->type == ATP_GEYSER4) {
 		memset(dev->xy_cur, 0, sizeof(dev->xy_cur));
 
 		/*
@@ -386,7 +426,7 @@ static void atp_complete(struct urb *urb)
 			dev->xy_cur[ATP_XSENSORS + i] = dev->data[j + 1];
 			dev->xy_cur[ATP_XSENSORS + i + 1] = dev->data[j + 2];
 		}
-	} else if (dev->type == ATP_GEYSER2) {
+	} else if (dev->info->type == ATP_GEYSER2) {
 		memset(dev->xy_cur, 0, sizeof(dev->xy_cur));
 
 		/*
@@ -416,8 +456,8 @@ static void atp_complete(struct urb *urb)
 				dev->xy_cur[i + 24] = dev->data[5 * i + 44];
 
 			/* Y values */
-			dev->xy_cur[i + 26] = dev->data[5 * i +  1];
-			dev->xy_cur[i + 34] = dev->data[5 * i +  3];
+			dev->xy_cur[ATP_XSENSORS + i] = dev->data[5 * i +  1];
+			dev->xy_cur[ATP_XSENSORS + i + 8] = dev->data[5 * i + 3];
 		}
 	}
 
@@ -430,26 +470,24 @@ static void atp_complete(struct urb *urb)
 		memcpy(dev->xy_old, dev->xy_cur, sizeof(dev->xy_old));
 
 		if (dev->size_detect_done ||
-		    dev->type == ATP_GEYSER3) /* No 17" Macbooks (yet) */
+		    dev->info->type == ATP_GEYSER3) /* No 17" Macbooks (yet) */
 			goto exit;
 
 		/* 17" Powerbooks have extra X sensors */
-		for (i = (dev->type == ATP_GEYSER2 ? 15 : 16);
-		     i < ATP_XSENSORS; i++) {
+		for (i = dev->info->xsensors; i < ATP_XSENSORS; i++) {
 			if (!dev->xy_cur[i])
 				continue;
 
 			printk(KERN_INFO "appletouch: 17\" model detected.\n");
-			if (dev->type == ATP_GEYSER2)
-				input_set_abs_params(dev->input, ABS_X, 0,
-						     (20 - 1) *
-						     ATP_XFACT - 1,
-						     ATP_FUZZ, 0);
+			if (dev->info->type == ATP_GEYSER2)
+				dev->info->xsensors = 20;
 			else
-				input_set_abs_params(dev->input, ABS_X, 0,
-						     (ATP_XSENSORS - 1) *
-						     ATP_XFACT - 1,
-						     ATP_FUZZ, 0);
+				dev->info->xsensors = 26;
+
+			input_set_abs_params(dev->input, ABS_X, 0,
+					     (dev->info->xsensors - 1) *
+					     dev->info->xfact - 1,
+					     ATP_FUZZ, 0);
 			break;
 		}
 
@@ -472,10 +510,10 @@ static void atp_complete(struct urb *urb)
 	dbg_dump("accumulator", dev->xy_acc);
 
 	x = atp_calculate_abs(dev->xy_acc, ATP_XSENSORS,
-			      ATP_XFACT, &x_z, &x_f);
+			      dev->info->xfact, &x_z, &x_f);
 	y = atp_calculate_abs(dev->xy_acc + ATP_XSENSORS, ATP_YSENSORS,
-			      ATP_YFACT, &y_z, &y_f);
-	key = dev->data[dev->datalen - 1] & 1;
+			      dev->info->yfact, &y_z, &y_f);
+	key = dev->data[dev->info->datalen - 1] & 1;
 
 	if (x && y) {
 		if (dev->x_old != -1) {
@@ -520,7 +558,7 @@ static void atp_complete(struct urb *urb)
 	 * several hundred times a second. Re-initialization does not
 	 * work on Fountain touchpads.
 	 */
-	if (dev->type != ATP_FOUNTAIN) {
+	if (dev->info->type != ATP_FOUNTAIN) {
 		/*
 		 * Button must not be pressed when entering suspend,
 		 * otherwise we will never release the button.
@@ -568,7 +606,7 @@ static int atp_handle_geyser(struct atp *dev)
 {
 	struct usb_device *udev = dev->udev;
 
-	if (dev->type != ATP_FOUNTAIN) {
+	if (dev->info->type != ATP_FOUNTAIN) {
 		/* switch to raw sensor mode */
 		if (atp_geyser_init(udev))
 			return -EIO;
@@ -589,6 +627,7 @@ static int atp_probe(struct usb_interface *iface,
 	struct usb_endpoint_descriptor *endpoint;
 	int int_in_endpointAddr = 0;
 	int i, error = -ENOMEM;
+	struct atp_info *info = (struct atp_info *)id->driver_info;
 
 	/* set up the endpoint information */
 	/* use only the first interrupt-in endpoint */
@@ -616,25 +655,21 @@ static int atp_probe(struct usb_interface *iface,
 
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
 
 	usb_fill_int_urb(dev->urb, udev,
 			 usb_rcvintpipe(udev, int_in_endpointAddr),
-			 dev->data, dev->datalen, atp_complete, dev, 1);
+			 dev->data, dev->info->datalen, atp_complete, dev, 1);
 
 	error = atp_handle_geyser(dev);
 	if (error)
@@ -655,35 +690,12 @@ static int atp_probe(struct usb_interface *iface,
 
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
@@ -705,7 +717,7 @@ static int atp_probe(struct usb_interface *iface,
 	return 0;
 
  err_free_buffer:
-	usb_buffer_free(dev->udev, dev->datalen,
+	usb_buffer_free(dev->udev, dev->info->datalen,
 			dev->data, dev->urb->transfer_dma);
  err_free_urb:
 	usb_free_urb(dev->urb);
@@ -724,7 +736,7 @@ static void atp_disconnect(struct usb_interface *iface)
 	if (dev) {
 		usb_kill_urb(dev->urb);
 		input_unregister_device(dev->input);
-		usb_buffer_free(dev->udev, dev->datalen,
+		usb_buffer_free(dev->udev, dev->info->datalen,
 				dev->data, dev->urb->transfer_dma);
 		usb_free_urb(dev->urb);
 		kfree(dev);

-- 
Stelian Pop <stelian@popies.net>

