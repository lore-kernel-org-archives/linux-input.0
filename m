From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 2/2] appletouch: handle geyser 3/4 status bits
Date: Tue, 29 Jul 2008 13:11:10 +0200
Message-ID: <20080729111223.529520000@sipsolutions.net>
References: <20080729111108.070166000@sipsolutions.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:35502 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755796AbYG2LTA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jul 2008 07:19:00 -0400
Content-Disposition: inline; filename=appletouch.c.2.6.27-step2.patch
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Sven Anders <anders@anduras.de>

From: Sven Anders <anders@anduras.de>

Implement support for status bits on Geyser 3/4.

Signed-off-by: Sven Anders <anders@anduras.de>
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

---
 drivers/input/mouse/appletouch.c |   54 ++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 18 deletions(-)

--- everything.orig/drivers/input/mouse/appletouch.c	2008-07-29 09:57:56.000000000 +0200
+++ everything/drivers/input/mouse/appletouch.c	2008-07-29 09:58:01.000000000 +0200
@@ -136,12 +136,28 @@ MODULE_DEVICE_TABLE(usb, atp_table);
 #define ATP_GEYSER_MODE_REQUEST_INDEX		0
 #define ATP_GEYSER_MODE_VENDOR_VALUE		0x04
 
+/**
+ * enum atp_status_bits - status bit meanings
+ *
+ * These constants represent the meaning of the status bits.
+ * (only Geyser 3/4)
+ *
+ * @ATP_STATUS_BUTTON: The button was pressed
+ * @ATP_STATUS_BASE_UPDATE: Update of the base values (untouched pad)
+ * @ATP_STATUS_FROM_RESET: Reset previously performed
+ */
+enum atp_status_bits {
+	ATP_STATUS_BUTTON	= BIT(0),
+	ATP_STATUS_BASE_UPDATE	= BIT(2),
+	ATP_STATUS_FROM_RESET	= BIT(4),
+};
+
 /* Structure to hold all of our device specific stuff */
 struct atp {
 	char			phys[64];
 	struct usb_device	*udev;		/* usb device */
 	struct urb		*urb;		/* usb request block */
-	signed char		*data;		/* transferred data */
+	u8			*data;		/* transferred data */
 	struct input_dev	*input;		/* input dev */
 	enum atp_touchpad_type	type;		/* type of touchpad */
 	bool			open;
@@ -251,8 +267,6 @@ static void atp_reinit(struct work_struc
 	int retval;
 
 	dprintk("appletouch: putting appletouch to sleep (reinit)\n");
-	dev->idlecount = 0;
-
 	atp_geyser_init(udev);
 
 	retval = usb_submit_urb(dev->urb, GFP_ATOMIC);
@@ -487,7 +501,7 @@ static void atp_complete_geyser_1_2(stru
 			      ATP_XFACT, &x_z, &x_f);
 	y = atp_calculate_abs(dev->xy_acc + ATP_XSENSORS, ATP_YSENSORS,
 			      ATP_YFACT, &y_z, &y_f);
-	key = dev->data[dev->datalen - 1] & 1;
+	key = dev->data[dev->datalen - 1] & ATP_STATUS_BUTTON;
 
 	if (x && y) {
 		if (dev->x_old != -1) {
@@ -567,34 +581,39 @@ static void atp_complete_geyser_3_4(stru
 
 	dbg_dump("sample", dev->xy_cur);
 
-	if (!dev->valid) {
-		/* first sample */
-		dev->valid = true;
-		dev->x_old = dev->y_old = -1;
-		memcpy(dev->xy_old, dev->xy_cur, sizeof(dev->xy_old));
+	/* Just update the base values (i.e. touchpad in untouched state) */
+	if (dev->data[dev->datalen-1] & ATP_STATUS_BASE_UPDATE) {
+
+		if (debug)
+			printk(KERN_DEBUG "appletouch: updated base values\n");
 
+		memcpy(dev->xy_old, dev->xy_cur, sizeof(dev->xy_old));
 		goto exit;
 	}
 
 	for (i = 0; i < ATP_XSENSORS + ATP_YSENSORS; i++) {
-		/* accumulate the change */
-		signed char change = dev->xy_old[i] - dev->xy_cur[i];
-		dev->xy_acc[i] -= change;
+		/* calculate the change */
+		dev->xy_acc[i] = dev->xy_cur[i] - dev->xy_old[i];
+
+		/* this is a round-robin value, so couple with that */
+		if (dev->xy_acc[i] > 127)
+			dev->xy_acc[i] -= 256;
+
+		if (dev->xy_acc[i] < -127)
+			dev->xy_acc[i] += 256;
 
 		/* prevent down drifting */
 		if (dev->xy_acc[i] < 0)
 			dev->xy_acc[i] = 0;
 	}
 
-	memcpy(dev->xy_old, dev->xy_cur, sizeof(dev->xy_old));
-
 	dbg_dump("accumulator", dev->xy_acc);
 
 	x = atp_calculate_abs(dev->xy_acc, ATP_XSENSORS,
 			      ATP_XFACT, &x_z, &x_f);
 	y = atp_calculate_abs(dev->xy_acc + ATP_XSENSORS, ATP_YSENSORS,
 			      ATP_YFACT, &y_z, &y_f);
-	key = dev->data[dev->datalen - 1] & 1;
+	key = dev->data[dev->datalen - 1] & ATP_STATUS_BUTTON;
 
 	if (x && y) {
 		if (dev->x_old != -1) {
@@ -646,7 +665,8 @@ static void atp_complete_geyser_3_4(stru
 	if (!x && !y && !key) {
 		dev->idlecount++;
 		if (dev->idlecount == 10) {
-			dev->valid = false;
+			dev->x_old = dev->y_old = -1;
+			dev->idlecount = 0;
 			schedule_work(&dev->work);
 			/* Don't resubmit urb here, wait for reinit */
 			return;
@@ -878,8 +898,6 @@ static int atp_suspend(struct usb_interf
 	struct atp *dev = usb_get_intfdata(iface);
 
 	usb_kill_urb(dev->urb);
-	dev->valid = false;
-
 	return 0;
 }
 

-- 

