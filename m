From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 1/2] appletouch: prepare for geyser 3/4 handling
Date: Tue, 29 Jul 2008 13:11:09 +0200
Message-ID: <20080729111222.906971000@sipsolutions.net>
References: <20080729111108.070166000@sipsolutions.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:35495 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753982AbYG2LS5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jul 2008 07:18:57 -0400
Content-Disposition: inline; filename=appletouch.c.2.6.27-step1.patch
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Sven Anders <anders@anduras.de>

From: Sven Anders <anders@anduras.de>

Split complete function into separate functions 
for GEYSER1/2 and GEYSER 3/4.

Signed-off-by: Sven Anders <anders@anduras.de>
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

---
 drivers/input/mouse/appletouch.c |  265 ++++++++++++++++++++++++++++-----------
 1 file changed, 196 insertions(+), 69 deletions(-)

--- everything.orig/drivers/input/mouse/appletouch.c	2008-07-26 16:47:17.000000000 +0200
+++ everything/drivers/input/mouse/appletouch.c	2008-07-29 10:01:41.000000000 +0200
@@ -327,11 +327,14 @@ static inline void atp_report_fingers(st
 	input_report_key(input, BTN_TOOL_TRIPLETAP, fingers > 2);
 }
 
-static void atp_complete(struct urb *urb)
+/* Check URB status and for correct length of data package */
+
+#define ATP_URB_STATUS_SUCCESS		0
+#define ATP_URB_STATUS_ERROR		1
+#define ATP_URB_STATUS_ERROR_FATAL	2
+
+static int atp_status_check(struct urb *urb)
 {
-	int x, y, x_z, y_z, x_f, y_f;
-	int retval, i, j;
-	int key;
 	struct atp *dev = urb->context;
 
 	switch (urb->status) {
@@ -351,11 +354,12 @@ static void atp_complete(struct urb *urb
 		/* This urb is terminated, clean up */
 		dbg("atp_complete: urb shutting down with status: %d",
 		    urb->status);
-		return;
+		return ATP_URB_STATUS_ERROR_FATAL;
+
 	default:
 		dbg("atp_complete: nonzero urb status received: %d",
 		    urb->status);
-		goto exit;
+		return ATP_URB_STATUS_ERROR;
 	}
 
 	/* drop incomplete datasets */
@@ -363,30 +367,33 @@ static void atp_complete(struct urb *urb
 		dprintk("appletouch: incomplete data package"
 			" (first byte: %d, length: %d).\n",
 			dev->data[0], dev->urb->actual_length);
-		goto exit;
+		return ATP_URB_STATUS_ERROR;
 	}
 
-	/* reorder the sensors values */
-	if (dev->type == ATP_GEYSER3 || dev->type == ATP_GEYSER4) {
-		memset(dev->xy_cur, 0, sizeof(dev->xy_cur));
+	return ATP_URB_STATUS_SUCCESS;
+}
 
-		/*
-		 * The values are laid out like this:
-		 * -, Y1, Y2, -, Y3, Y4, -, ..., -, X1, X2, -, X3, X4, ...
-		 * '-' is an unused value.
-		 */
+/*
+ * USB interrupt callback functions
+ */
 
-		/* read X values */
-		for (i = 0, j = 19; i < 20; i += 2, j += 3) {
-			dev->xy_cur[i] = dev->data[j + 1];
-			dev->xy_cur[i + 1] = dev->data[j + 2];
-		}
-		/* read Y values */
-		for (i = 0, j = 1; i < 9; i += 2, j += 3) {
-			dev->xy_cur[ATP_XSENSORS + i] = dev->data[j + 1];
-			dev->xy_cur[ATP_XSENSORS + i + 1] = dev->data[j + 2];
-		}
-	} else if (dev->type == ATP_GEYSER2) {
+/* Interrupt function for older touchpads: FOUNTAIN/GEYSER1/GEYSER2 */
+
+static void atp_complete_geyser_1_2(struct urb *urb)
+{
+	int x, y, x_z, y_z, x_f, y_f;
+	int retval, i, j;
+	int key;
+	struct atp *dev = urb->context;
+	int status = atp_status_check(urb);
+
+	if (status == ATP_URB_STATUS_ERROR_FATAL)
+		return;
+	else if (status == ATP_URB_STATUS_ERROR)
+		goto exit;
+
+	/* reorder the sensors values */
+	if (dev->type == ATP_GEYSER2) {
 		memset(dev->xy_cur, 0, sizeof(dev->xy_cur));
 
 		/*
@@ -427,33 +434,145 @@ static void atp_complete(struct urb *urb
 		/* first sample */
 		dev->valid = true;
 		dev->x_old = dev->y_old = -1;
+
+		/* Store first sample */
 		memcpy(dev->xy_old, dev->xy_cur, sizeof(dev->xy_old));
 
-		if (dev->size_detect_done ||
-		    dev->type == ATP_GEYSER3) /* No 17" Macbooks (yet) */
+		/* Perform size detection, if not done already */
+		if (!dev->size_detect_done) {
+
+			/* 17" Powerbooks have extra X sensors */
+			for (i = (dev->type == ATP_GEYSER2 ? 15 : 16);
+			     i < ATP_XSENSORS; i++) {
+				if (!dev->xy_cur[i])
+					continue;
+
+				printk(KERN_INFO "appletouch: 17\" model "
+				       "detected.\n");
+				if (dev->type == ATP_GEYSER2)
+					input_set_abs_params(dev->input, ABS_X,
+							     0,
+							     (20 - 1) *
+							     ATP_XFACT - 1,
+							     ATP_FUZZ, 0);
+				else
+					input_set_abs_params(dev->input, ABS_X,
+							     0,
+							     (26 - 1)*
+							     ATP_XFACT - 1,
+							     ATP_FUZZ, 0);
+				break;
+			}
+
+			dev->size_detect_done = 1;
 			goto exit;
+		}
+	}
 
-		/* 17" Powerbooks have extra X sensors */
-		for (i = (dev->type == ATP_GEYSER2 ? 15 : 16);
-		     i < ATP_XSENSORS; i++) {
-			if (!dev->xy_cur[i])
-				continue;
-
-			printk(KERN_INFO "appletouch: 17\" model detected.\n");
-			if (dev->type == ATP_GEYSER2)
-				input_set_abs_params(dev->input, ABS_X, 0,
-						     (20 - 1) *
-						     ATP_XFACT - 1,
-						     ATP_FUZZ, 0);
-			else
-				input_set_abs_params(dev->input, ABS_X, 0,
-						     (ATP_XSENSORS - 1) *
-						     ATP_XFACT - 1,
-						     ATP_FUZZ, 0);
-			break;
+	for (i = 0; i < ATP_XSENSORS + ATP_YSENSORS; i++) {
+		/* accumulate the change */
+		signed char change = dev->xy_old[i] - dev->xy_cur[i];
+		dev->xy_acc[i] -= change;
+
+		/* prevent down drifting */
+		if (dev->xy_acc[i] < 0)
+			dev->xy_acc[i] = 0;
+	}
+
+	memcpy(dev->xy_old, dev->xy_cur, sizeof(dev->xy_old));
+
+	dbg_dump("accumulator", dev->xy_acc);
+
+	x = atp_calculate_abs(dev->xy_acc, ATP_XSENSORS,
+			      ATP_XFACT, &x_z, &x_f);
+	y = atp_calculate_abs(dev->xy_acc + ATP_XSENSORS, ATP_YSENSORS,
+			      ATP_YFACT, &y_z, &y_f);
+	key = dev->data[dev->datalen - 1] & 1;
+
+	if (x && y) {
+		if (dev->x_old != -1) {
+			x = (dev->x_old * 3 + x) >> 2;
+			y = (dev->y_old * 3 + y) >> 2;
+			dev->x_old = x;
+			dev->y_old = y;
+
+			if (debug > 1)
+				printk(KERN_DEBUG "appletouch: X: %3d Y: %3d "
+				       "Xz: %3d Yz: %3d\n",
+				       x, y, x_z, y_z);
+
+			input_report_key(dev->input, BTN_TOUCH, 1);
+			input_report_abs(dev->input, ABS_X, x);
+			input_report_abs(dev->input, ABS_Y, y);
+			input_report_abs(dev->input, ABS_PRESSURE,
+					 min(ATP_PRESSURE, x_z + y_z));
+			atp_report_fingers(dev->input, max(x_f, y_f));
 		}
+		dev->x_old = x;
+		dev->y_old = y;
+
+	} else if (!x && !y) {
+
+		dev->x_old = dev->y_old = -1;
+		input_report_key(dev->input, BTN_TOUCH, 0);
+		input_report_abs(dev->input, ABS_PRESSURE, 0);
+		atp_report_fingers(dev->input, 0);
+
+		/* reset the accumulator on release */
+		memset(dev->xy_acc, 0, sizeof(dev->xy_acc));
+	}
+
+	input_report_key(dev->input, BTN_LEFT, key);
+	input_sync(dev->input);
+
+ exit:
+	retval = usb_submit_urb(dev->urb, GFP_ATOMIC);
+	if (retval)
+		err("atp_complete: usb_submit_urb failed with result %d",
+		    retval);
+}
+
+/* Interrupt function for older touchpads: GEYSER3/GEYSER4 */
+
+static void atp_complete_geyser_3_4(struct urb *urb)
+{
+	int x, y, x_z, y_z, x_f, y_f;
+	int retval, i, j;
+	int key;
+	struct atp *dev = urb->context;
+	int status = atp_status_check(urb);
+
+	if (status == ATP_URB_STATUS_ERROR_FATAL)
+		return;
+	else if (status == ATP_URB_STATUS_ERROR)
+		goto exit;
+
+	/* Reorder the sensors values:
+	 *
+	 * The values are laid out like this:
+	 * -, Y1, Y2, -, Y3, Y4, -, ..., -, X1, X2, -, X3, X4, ...
+	 * '-' is an unused value.
+	 */
+
+	/* read X values */
+	for (i = 0, j = 19; i < 20; i += 2, j += 3) {
+		dev->xy_cur[i] = dev->data[j + 1];
+		dev->xy_cur[i + 1] = dev->data[j + 2];
+	}
+	/* read Y values */
+	for (i = 0, j = 1; i < 9; i += 2, j += 3) {
+		dev->xy_cur[ATP_XSENSORS + i] = dev->data[j + 1];
+		dev->xy_cur[ATP_XSENSORS + i + 1] = dev->data[j + 2];
+	}
+
+	dbg_dump("sample", dev->xy_cur);
+
+	if (!dev->valid) {
+		/* first sample */
+		dev->valid = true;
+		dev->x_old = dev->y_old = -1;
+		memcpy(dev->xy_old, dev->xy_cur, sizeof(dev->xy_old));
 
-		dev->size_detect_done = 1;
 		goto exit;
 	}
 
@@ -514,28 +633,26 @@ static void atp_complete(struct urb *urb
 	input_sync(dev->input);
 
 	/*
-	 * Many Geysers will continue to send packets continually after
+	 * Geysers 3/4 will continue to send packets continually after
 	 * the first touch unless reinitialised. Do so if it's been
 	 * idle for a while in order to avoid waking the kernel up
-	 * several hundred times a second. Re-initialization does not
-	 * work on Fountain touchpads.
+	 * several hundred times a second.
 	 */
-	if (dev->type != ATP_FOUNTAIN) {
-		/*
-		 * Button must not be pressed when entering suspend,
-		 * otherwise we will never release the button.
-		 */
-		if (!x && !y && !key) {
-			dev->idlecount++;
-			if (dev->idlecount == 10) {
-				dev->valid = false;
-				schedule_work(&dev->work);
-				/* Don't resubmit urb here, wait for reinit */
-				return;
-			}
-		} else
-			dev->idlecount = 0;
-	}
+
+	/*
+	 * Button must not be pressed when entering suspend,
+	 * otherwise we will never release the button.
+	 */
+	if (!x && !y && !key) {
+		dev->idlecount++;
+		if (dev->idlecount == 10) {
+			dev->valid = false;
+			schedule_work(&dev->work);
+			/* Don't resubmit urb here, wait for reinit */
+			return;
+		}
+	} else
+		dev->idlecount = 0;
 
  exit:
 	retval = usb_submit_urb(dev->urb, GFP_ATOMIC);
@@ -632,9 +749,19 @@ static int atp_probe(struct usb_interfac
 	if (!dev->data)
 		goto err_free_urb;
 
-	usb_fill_int_urb(dev->urb, udev,
-			 usb_rcvintpipe(udev, int_in_endpointAddr),
-			 dev->data, dev->datalen, atp_complete, dev, 1);
+	/* Select the USB complete (callback) function */
+	if (dev->type == ATP_FOUNTAIN ||
+	    dev->type == ATP_GEYSER1 ||
+	    dev->type == ATP_GEYSER2)
+		usb_fill_int_urb(dev->urb, udev,
+				 usb_rcvintpipe(udev, int_in_endpointAddr),
+				 dev->data, dev->datalen,
+				 atp_complete_geyser_1_2, dev, 1);
+	else
+		usb_fill_int_urb(dev->urb, udev,
+				 usb_rcvintpipe(udev, int_in_endpointAddr),
+				 dev->data, dev->datalen,
+				 atp_complete_geyser_3_4, dev, 1);
 
 	error = atp_handle_geyser(dev);
 	if (error)

-- 

