From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 1/3] wacom: Add support for extra USB tablets
Date: Wed, 16 Dec 2009 17:58:20 -0500
Message-ID: <1261004302-4858-2-git-send-email-mjg@redhat.com>
References: <1261004302-4858-1-git-send-email-mjg@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49476 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763319AbZLPW7J (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Dec 2009 17:59:09 -0500
In-Reply-To: <1261004302-4858-1-git-send-email-mjg@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: pingc@wacom.com, Matthew Garrett <mjg@redhat.com>

From: Ping Cheng <pingc@wacom.com>

Add support for Tablet PCs with IDs 0xE2 and 0xE3 as well as touch-only
tablet 0x9F.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/input/tablet/wacom.h     |    2 +
 drivers/input/tablet/wacom_sys.c |  138 +++++++++++-----
 drivers/input/tablet/wacom_wac.c |  327 +++++++++++++++++++++++++-------------
 drivers/input/tablet/wacom_wac.h |    9 +
 4 files changed, 328 insertions(+), 148 deletions(-)

diff --git a/drivers/input/tablet/wacom.h b/drivers/input/tablet/wacom.h
index 9114ae1..cdf4c0a 100644
--- a/drivers/input/tablet/wacom.h
+++ b/drivers/input/tablet/wacom.h
@@ -135,6 +135,8 @@ extern void input_dev_pl(struct input_dev *input_dev, struct wacom_wac *wacom_wa
 extern void input_dev_pt(struct input_dev *input_dev, struct wacom_wac *wacom_wac);
 extern void input_dev_mo(struct input_dev *input_dev, struct wacom_wac *wacom_wac);
 extern void input_dev_bee(struct input_dev *input_dev, struct wacom_wac *wacom_wac);
+extern void input_dev_tpc(struct input_dev *input_dev, struct wacom_wac *wacom_wac);
+extern void input_dev_tpc2fg(struct input_dev *input_dev, struct wacom_wac *wacom_wac);
 extern __u16 wacom_le16_to_cpu(unsigned char *data);
 extern __u16 wacom_be16_to_cpu(unsigned char *data);
 extern struct wacom_features *get_wacom_feature(const struct usb_device_id *id);
diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index ea30c98..de1562b 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -277,13 +277,31 @@ void input_dev_pt(struct input_dev *input_dev, struct wacom_wac *wacom_wac)
 	input_dev->keybit[BIT_WORD(BTN_DIGI)] |= BIT_MASK(BTN_TOOL_RUBBER);
 }
 
+void input_dev_tpc(struct input_dev *input_dev, struct wacom_wac *wacom_wac)
+{
+	input_set_abs_params(input_dev, ABS_RX, 0,
+			     wacom_wac->features->touch_x_max, 4, 0);
+	input_set_abs_params(input_dev, ABS_RY, 0,
+			     wacom_wac->features->touch_y_max, 4, 0);
+	input_set_abs_params(input_dev, ABS_Z, 0,
+			     wacom_wac->features->touch_x_res, 0, 0);
+	input_set_abs_params(input_dev, ABS_RZ, 0,
+			     wacom_wac->features->touch_y_res, 0, 0);
+	input_dev->keybit[BIT_WORD(BTN_DIGI)] |= BIT_MASK(BTN_TOOL_DOUBLETAP);
+}
+
+void input_dev_tpc2fg(struct input_dev *input_dev, struct wacom_wac *wacom_wac)
+{
+	input_dev->keybit[BIT_WORD(BTN_DIGI)] |= BIT_MASK(BTN_TOOL_TRIPLETAP);
+}
+
 static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hid_desc,
-			   struct wacom_wac *wacom_wac)
+		struct wacom_wac *wacom_wac)
 {
 	struct usb_device *dev = interface_to_usbdev(intf);
 	struct wacom_features *features = wacom_wac->features;
-	char limit = 0, result = 0;
-	int i = 0, usage = WCM_UNDEFINED, finger = 0, pen = 0;
+	char limit = 0;
+	int i = 0, usage = WCM_UNDEFINED, finger = 0, pen = 0, result = 0;
 	unsigned char *report;
 
 	report = kzalloc(hid_desc->wDescriptorLength, GFP_KERNEL);
@@ -329,11 +347,13 @@ static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hi
 				if (usage == WCM_DESKTOP) {
 					if (finger) {
 						features->touch_x_max =
-							features->touch_y_max =
 							wacom_le16_to_cpu(&report[i + 3]);
-						features->x_max =
+						features->touch_x_res =
 							wacom_le16_to_cpu(&report[i + 6]);
-						i += 7;
+						features->unit = report[i + 9];
+						features->unitExpo =
+							report[i + 11];
+						i += 12;
 					} else if (pen) {
 						features->x_max =
 							wacom_le16_to_cpu(&report[i + 3]);
@@ -350,10 +370,28 @@ static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hi
 				break;
 
 			case HID_USAGE_Y:
-				if (usage == WCM_DESKTOP)
-					features->y_max =
-						wacom_le16_to_cpu(&report[i + 3]);
-				i += 4;
+				if (usage == WCM_DESKTOP) {
+					if (finger) {
+						if (strstr(features->name,
+							   "Wacom ISDv4 E")) {
+							features->touch_y_max =
+								wacom_le16_to_cpu(&report[i + 3]);
+							features->touch_y_res =
+								wacom_le16_to_cpu(&report[i + 6]);
+							i += 7;
+						} else {
+							features->touch_y_max =
+								features->touch_x_max;
+							features->touch_y_res =
+								wacom_le16_to_cpu(&report[i + 3]);
+							i += 4;
+						}
+					} else if (pen) {
+						features->y_max =
+							wacom_le16_to_cpu(&report[i + 3]);
+						i += 4;
+					}
+				}
 				break;
 
 			case HID_USAGE_FINGER:
@@ -376,7 +414,7 @@ static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hi
 			break;
 
 		case HID_COLLECTION:
-			/* reset UsagePage ans Finger */
+			/* reset UsagePage and Finger */
 			finger = usage = 0;
 			break;
 		}
@@ -388,26 +426,44 @@ static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hi
 	return result;
 }
 
-static int wacom_query_tablet_data(struct usb_interface *intf)
+static int wacom_query_tablet_data(struct usb_interface *intf,
+				   struct wacom_features *features)
 {
 	unsigned char *rep_data;
 	int limit = 0;
 	int error;
+	int report_id = 2;
 
-	rep_data = kmalloc(2, GFP_KERNEL);
+	rep_data = kmalloc(4, GFP_KERNEL);
 	if (!rep_data)
 		return -ENOMEM;
 
-	do {
-		rep_data[0] = 2;
-		rep_data[1] = 2;
-		error = usb_set_report(intf, WAC_HID_FEATURE_REPORT,
-					2, rep_data, 2);
-		if (error >= 0)
-			error = usb_get_report(intf,
-						WAC_HID_FEATURE_REPORT, 2,
-						rep_data, 2);
-	} while ((error < 0 || rep_data[1] != 2) && limit++ < 5);
+	if (features->type == TABLETPC2FG) {
+		do {
+			rep_data[0] = 3;
+			rep_data[1] = 4;
+			report_id = 3;
+			error = usb_set_report(intf, WAC_HID_FEATURE_REPORT,
+					       report_id, rep_data, 2);
+			if (error >= 0)
+				error = usb_get_report(intf,
+						       WAC_HID_FEATURE_REPORT,
+						       report_id,
+						       rep_data, 3);
+		} while ((error < 0 || rep_data[1] != 4) && limit++ < 3);
+	} else if (features->type != TABLETPC) {
+		do {
+			rep_data[0] = 2;
+			rep_data[1] = 2;
+			error = usb_set_report(intf, WAC_HID_FEATURE_REPORT,
+					       report_id, rep_data, 2);
+			if (error >= 0)
+				error = usb_get_report(intf,
+						       WAC_HID_FEATURE_REPORT,
+						       report_id,
+						       rep_data, 2);
+		} while ((error < 0 || rep_data[1] != 2) && limit++ < 3);
+	}
 
 	kfree(rep_data);
 
@@ -432,7 +488,8 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 	if (!wacom || !input_dev || !wacom_wac)
 		goto fail1;
 
-	wacom_wac->data = usb_buffer_alloc(dev, 10, GFP_KERNEL, &wacom->data_dma);
+	wacom_wac->data = usb_buffer_alloc(dev, WACOM_PKGLEN_MAX, GFP_KERNEL,
+					   &wacom->data_dma);
 	if (!wacom_wac->data)
 		goto fail1;
 
@@ -448,7 +505,7 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 	strlcat(wacom->phys, "/input0", sizeof(wacom->phys));
 
 	wacom_wac->features = features = get_wacom_feature(id);
-	BUG_ON(features->pktlen > 10);
+	BUG_ON(features->pktlen > WACOM_PKGLEN_MAX);
 
 	input_dev->name = wacom_wac->features->name;
 	wacom->wacom_wac = wacom_wac;
@@ -463,17 +520,14 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 
 	endpoint = &intf->cur_altsetting->endpoint[0].desc;
 
-	/* Initialize touch_x_max and touch_y_max in case it is not defined */
-	if (wacom_wac->features->type == TABLETPC) {
+	/* Initialize touch_x_max and touch_y_max in case it is not defined in
+	   HID descriptor */
+	if (features->type == TABLETPC || features->type == TABLETPC2FG) {
 		features->touch_x_max = 1023;
 		features->touch_y_max = 1023;
-	} else {
-		features->touch_x_max = 0;
-		features->touch_y_max = 0;
-	}
 
-	/* TabletPC need to retrieve the physical and logical maximum from report descriptor */
-	if (wacom_wac->features->type == TABLETPC) {
+		/* TabletPC need to retrieve the physical and logical maximum
+		   from report descriptor */
 		if (usb_get_extra_descriptor(interface, HID_DEVICET_HID, &hid_desc)) {
 			if (usb_get_extra_descriptor(&interface->endpoint[0],
 						     HID_DEVICET_REPORT, &hid_desc)) {
@@ -484,26 +538,28 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 		error = wacom_parse_hid(intf, hid_desc, wacom_wac);
 		if (error)
 			goto fail2;
+	} else {
+		features->touch_x_max = 0;
+		features->touch_y_max = 0;
 	}
 
+
 	input_dev->evbit[0] |= BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
 	input_dev->keybit[BIT_WORD(BTN_DIGI)] |= BIT_MASK(BTN_TOOL_PEN) |
 		BIT_MASK(BTN_TOUCH) | BIT_MASK(BTN_STYLUS);
+
 	input_set_abs_params(input_dev, ABS_X, 0, features->x_max, 4, 0);
+
 	input_set_abs_params(input_dev, ABS_Y, 0, features->y_max, 4, 0);
+
 	input_set_abs_params(input_dev, ABS_PRESSURE, 0, features->pressure_max, 0, 0);
-	if (features->type == TABLETPC) {
-		input_dev->keybit[BIT_WORD(BTN_DIGI)] |= BIT_MASK(BTN_TOOL_DOUBLETAP);
-		input_set_abs_params(input_dev, ABS_RX, 0, features->touch_x_max, 4, 0);
-		input_set_abs_params(input_dev, ABS_RY, 0, features->touch_y_max, 4, 0);
-	}
 	input_dev->absbit[BIT_WORD(ABS_MISC)] |= BIT_MASK(ABS_MISC);
 
 	wacom_init_input_dev(input_dev, wacom_wac);
 
 	usb_fill_int_urb(wacom->irq, dev,
 			 usb_rcvintpipe(dev, endpoint->bEndpointAddress),
-			 wacom_wac->data, wacom_wac->features->pktlen,
+			 wacom_wac->data, features->pktlen,
 			 wacom_sys_irq, wacom, endpoint->bInterval);
 	wacom->irq->transfer_dma = wacom->data_dma;
 	wacom->irq->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
@@ -517,7 +573,7 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 	 * Note that if query fails it is not a hard failure.
 	 */
 	if (wacom_wac->features->type != TABLETPC)
-		wacom_query_tablet_data(intf);
+		wacom_query_tablet_data(intf, features);
 
 	usb_set_intfdata(intf, wacom);
 	return 0;
@@ -539,7 +595,7 @@ static void wacom_disconnect(struct usb_interface *intf)
 	usb_kill_urb(wacom->irq);
 	input_unregister_device(wacom->dev);
 	usb_free_urb(wacom->irq);
-	usb_buffer_free(interface_to_usbdev(intf), 10,
+	usb_buffer_free(interface_to_usbdev(intf), WACOM_PKGLEN_MAX,
 			wacom->wacom_wac->data, wacom->data_dma);
 	kfree(wacom->wacom_wac);
 	kfree(wacom);
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index c896d6a..e3dfb14 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -14,11 +14,19 @@
 #include "wacom.h"
 #include "wacom_wac.h"
 
+/* packet length for individual models */
+#define WACOM_PKGLEN_PENPRTN	 7
+#define WACOM_PKGLEN_GRAPHIRE 	 8
+#define WACOM_PKGLEN_BBFUN 	 9
+#define WACOM_PKGLEN_INTUOS 	10
+#define WACOM_PKGLEN_TPC1FG	 5
+#define WACOM_PKGLEN_TPC2FG 	14
+
 static int wacom_penpartner_irq(struct wacom_wac *wacom, void *wcombo)
 {
 	unsigned char *data = wacom->data;
 
-	switch (data[0]) {
+	switch (data[0] & 0xff) {
 		case 1:
 			if (data[5] & 0x80) {
 				wacom->tool[0] = (data[5] & 0x20) ? BTN_TOOL_RUBBER : BTN_TOOL_PEN;
@@ -58,7 +66,7 @@ static int wacom_pl_irq(struct wacom_wac *wacom, void *wcombo)
 	unsigned char *data = wacom->data;
 	int prox, pressure;
 
-	if (data[0] != 2) {
+	if ((data[0] & 0xff) != 2) {
 		dbg("wacom_pl_irq: received unknown report #%d", data[0]);
 		return 0;
 	}
@@ -103,8 +111,10 @@ static int wacom_pl_irq(struct wacom_wac *wacom, void *wcombo)
 		}
 		wacom_report_key(wcombo, wacom->tool[1], prox); /* report in proximity for tool */
 		wacom_report_abs(wcombo, ABS_MISC, wacom->id[0]); /* report tool id */
-		wacom_report_abs(wcombo, ABS_X, data[3] | (data[2] << 7) | ((data[1] & 0x03) << 14));
-		wacom_report_abs(wcombo, ABS_Y, data[6] | (data[5] << 7) | ((data[4] & 0x03) << 14));
+		wacom_report_abs(wcombo, ABS_X, (data[3] & 0xff) |
+				 (data[2] << 7) | ((data[1] & 0x03) << 14));
+		wacom_report_abs(wcombo, ABS_Y, (data[6] & 0xff) |
+				 (data[5] << 7) | ((data[4] & 0x03) << 14));
 		wacom_report_abs(wcombo, ABS_PRESSURE, pressure);
 
 		wacom_report_key(wcombo, BTN_TOUCH, data[4] & 0x08);
@@ -128,7 +138,7 @@ static int wacom_ptu_irq(struct wacom_wac *wacom, void *wcombo)
 {
 	unsigned char *data = wacom->data;
 
-	if (data[0] != 2) {
+	if ((data[0] & 0xff) != 2) {
 		printk(KERN_INFO "wacom_ptu_irq: received unknown report #%d\n", data[0]);
 		return 0;
 	}
@@ -156,7 +166,7 @@ static int wacom_graphire_irq(struct wacom_wac *wacom, void *wcombo)
 	unsigned char *data = wacom->data;
 	int x, y, rw;
 
-	if (data[0] != 2) {
+	if ((data[0] & 0xff) != 2) {
 		dbg("wacom_graphire_irq: received unknown report #%d", data[0]);
 		return 0;
 	}
@@ -203,7 +213,9 @@ static int wacom_graphire_irq(struct wacom_wac *wacom, void *wcombo)
 		wacom_report_abs(wcombo, ABS_X, x);
 		wacom_report_abs(wcombo, ABS_Y, y);
 		if (wacom->tool[0] != BTN_TOOL_MOUSE) {
-			wacom_report_abs(wcombo, ABS_PRESSURE, data[6] | ((data[7] & 0x01) << 8));
+			wacom_report_abs(wcombo, ABS_PRESSURE,
+					 (data[6] & 0xff) |
+					 ((data[7] & 0x01) << 8));
 			wacom_report_key(wcombo, BTN_TOUCH, data[1] & 0x01);
 			wacom_report_key(wcombo, BTN_STYLUS, data[1] & 0x02);
 			wacom_report_key(wcombo, BTN_STYLUS2, data[1] & 0x04);
@@ -432,7 +444,8 @@ static int wacom_intuos_irq(struct wacom_wac *wacom, void *wcombo)
 	unsigned int t;
 	int idx = 0, result;
 
-	if (data[0] != 2 && data[0] != 5 && data[0] != 6 && data[0] != 12) {
+	if ((data[0] & 0xff) != 2 && (data[0] & 0xff) != 5 &&
+	    (data[0] & 0xff) != 6 && (data[0] & 0xff) != 12) {
 		dbg("wacom_intuos_irq: received unknown report #%d", data[0]);
                 return 0;
 	}
@@ -442,7 +455,7 @@ static int wacom_intuos_irq(struct wacom_wac *wacom, void *wcombo)
 		idx = data[1] & 0x01;
 
 	/* pad packets. Works as a second tool and is always in prox */
-	if (data[0] == 12) {
+	if ((data[0] & 0xff) == 12) {
 		/* initiate the pad as a device */
 		if (wacom->tool[1] != BTN_TOOL_FINGER)
 			wacom->tool[1] = BTN_TOOL_FINGER;
@@ -486,10 +499,12 @@ static int wacom_intuos_irq(struct wacom_wac *wacom, void *wcombo)
 			wacom_report_abs(wcombo, ABS_RX, ((data[1] & 0x1f) << 8) | data[2]);
 			wacom_report_abs(wcombo, ABS_RY, ((data[3] & 0x1f) << 8) | data[4]);
 
-			if ((data[5] & 0x1f) | (data[6] & 0x1f) | (data[1] & 0x1f) |
-				data[2] | (data[3] & 0x1f) | data[4]) {
+			if ((data[5] & 0x1f) | (data[6] & 0x1f) |
+			    (data[1] & 0x1f) | (data[2] & 0xff) |
+			    (data[3] & 0x1f) | (data[4] & 0xff)) {
 				wacom_report_key(wcombo, wacom->tool[1], 1);
-				wacom_report_abs(wcombo, ABS_MISC, PAD_DEVICE_ID);
+				wacom_report_abs(wcombo, ABS_MISC,
+						 PAD_DEVICE_ID);
 			} else {
 				wacom_report_key(wcombo, wacom->tool[1], 0);
 				wacom_report_abs(wcombo, ABS_MISC, 0);
@@ -608,59 +623,136 @@ static int wacom_intuos_irq(struct wacom_wac *wacom, void *wcombo)
 	return 1;
 }
 
+static void wacom_tpc_touch_in(struct wacom_wac *wacom, void *wcombo)
+{
+	char *data = wacom->data;
+	struct urb *urb = ((struct wacom_combo *)wcombo)->urb;
+
+	wacom->tool[0] = BTN_TOOL_DOUBLETAP;
+	wacom->id[0] = TOUCH_DEVICE_ID;
+	if (urb->actual_length != WACOM_PKGLEN_TPC1FG) {
+		switch (data[0] & 0xff) {
+		case 6:
+			wacom_report_abs(wcombo, ABS_X,
+					 wacom_le16_to_cpu(&data[2]));
+			wacom_report_abs(wcombo, ABS_Y,
+					 wacom_le16_to_cpu(&data[4]));
+			wacom_report_abs(wcombo, ABS_PRESSURE,
+					 wacom_le16_to_cpu(&data[6]));
+			wacom_report_key(wcombo, BTN_TOUCH,
+					 wacom_le16_to_cpu(&data[6]));
+			break;
+		case 13:
+			if (data[1] & 0x01) {
+				if (data[1] & 0x02) {
+					wacom->tool[1] = BTN_TOOL_TRIPLETAP;
+					wacom_report_abs(wcombo, ABS_X,
+							 (data[4] & 0xff) |
+							 ((data[5] & 0x7f) << 8));
+					wacom_report_abs(wcombo, ABS_Y,
+							 (data[8] & 0xff) |
+							 ((data[9] & 0x7f) << 8));
+					wacom_report_abs(wcombo, ABS_MISC,
+							 wacom->id[0]);
+					wacom_report_key(wcombo,
+							 wacom->tool[1], 1);
+					wacom_input_event(wcombo,
+							  EV_MSC, MSC_SERIAL,
+							  0xf0);
+
+					/* sync second finger data */
+					wacom_input_sync(wcombo);
+					}
+				wacom_report_abs(wcombo, ABS_X,
+						 (data[2] & 0xff) |
+						 ((data[3] & 0x7f) << 8));
+				wacom_report_abs(wcombo, ABS_Y,
+						 (data[6] & 0xff) |
+						 ((data[7] & 0x7f) << 8));
+				}
+				wacom_report_key(wcombo, BTN_TOUCH, 1);
+				break;
+		}
+	} else {
+		wacom_report_abs(wcombo, ABS_X, wacom_le16_to_cpu(&data[1]));
+		wacom_report_abs(wcombo, ABS_Y, wacom_le16_to_cpu(&data[3]));
+		wacom_report_key(wcombo, BTN_TOUCH, 1);
+	}
+	wacom_report_abs(wcombo, ABS_MISC, wacom->id[0]);
+	wacom_report_key(wcombo, wacom->tool[0], 1);
+
+	return;
+}
+
+static void wacom_tpc_touch_out(struct wacom_wac *wacom, void *wcombo)
+{
+	wacom_report_abs(wcombo, ABS_X, 0);
+	wacom_report_abs(wcombo, ABS_Y, 0);
+	wacom_report_abs(wcombo, ABS_MISC, 0);
+	wacom_report_key(wcombo, wacom->tool[0], 0);
+	wacom_report_key(wcombo, BTN_TOUCH, 0);
+	return;
+}
+
 static int wacom_tpc_irq(struct wacom_wac *wacom, void *wcombo)
 {
 	char *data = wacom->data;
 	int prox = 0, pressure;
 	static int stylusInProx, touchInProx = 1, touchOut;
 	struct urb *urb = ((struct wacom_combo *)wcombo)->urb;
+	static int secondFingerIn;
 
 	dbg("wacom_tpc_irq: received report #%d", data[0]);
 
-	if (urb->actual_length == 5 || data[0] == 6) { /* Touch data */
-		if (urb->actual_length == 5) {  /* with touch */
+	if (urb->actual_length == WACOM_PKGLEN_TPC1FG ||
+	    ((data[0] & 0xff) == 6)  /* single touch */
+	    || (data[0] & 0xff) == 13) { /* 2FG touch */
+		/* with touch */
+		if (urb->actual_length == WACOM_PKGLEN_TPC1FG) {
 			prox = data[0] & 0x03;
 		} else {  /* with capacity */
-			prox = data[1] & 0x03;
+			if ((data[0] & 0xff) == 6)     /* single touch */
+				prox = data[1] & 0x01;
+			else			       /* 2FG touch data */
+				prox = data[1] & 0x03;
 		}
 
 		if (!stylusInProx) { /* stylus not in prox */
+			if ((data[0] & 0xff) == 13) {
+				if (data[1] & 0x02)
+					secondFingerIn = 1;
+				else if (secondFingerIn == 1) {
+					wacom_report_abs(wcombo, ABS_X, 0);
+					wacom_report_abs(wcombo, ABS_Y, 0);
+					wacom_report_abs(wcombo, ABS_MISC, 0);
+					wacom_report_key(wcombo,
+							 wacom->tool[1], 0);
+					wacom_input_event(wcombo, EV_MSC,
+							  MSC_SERIAL, 0xf0);
+					/* sync second finger data */
+					wacom_input_sync(wcombo);
+					secondFingerIn = 0;
+				}
+			}
 			if (prox) {
 				if (touchInProx) {
-					wacom->tool[1] = BTN_TOOL_DOUBLETAP;
-					wacom->id[0] = TOUCH_DEVICE_ID;
-					if (urb->actual_length != 5) {
-						wacom_report_abs(wcombo, ABS_X, wacom_le16_to_cpu(&data[2]));
-						wacom_report_abs(wcombo, ABS_Y, wacom_le16_to_cpu(&data[4]));
-						wacom_report_abs(wcombo, ABS_PRESSURE, wacom_le16_to_cpu(&data[6]));
-						wacom_report_key(wcombo, BTN_TOUCH, wacom_le16_to_cpu(&data[6]));
-					} else {
-						wacom_report_abs(wcombo, ABS_X, wacom_le16_to_cpu(&data[1]));
-						wacom_report_abs(wcombo, ABS_Y, wacom_le16_to_cpu(&data[3]));
-						wacom_report_key(wcombo, BTN_TOUCH, 1);
-					}
-					wacom_report_abs(wcombo, ABS_MISC, wacom->id[0]);
-					wacom_report_key(wcombo, wacom->tool[1], prox & 0x01);
+					wacom_tpc_touch_in(wacom, wcombo);
 					touchOut = 1;
 					return 1;
 				}
 			} else {
-				wacom_report_abs(wcombo, ABS_MISC, wacom->id[0]);
-				wacom_report_key(wcombo, wacom->tool[1], prox & 0x01);
-				wacom_report_key(wcombo, BTN_TOUCH, 0);
+				wacom_tpc_touch_out(wacom, wcombo);
 				touchOut = 0;
 				touchInProx = 1;
 				return 1;
 			}
 		} else if (touchOut || !prox) { /* force touch out-prox */
-			wacom_report_abs(wcombo, ABS_MISC, TOUCH_DEVICE_ID);
-			wacom_report_key(wcombo, wacom->tool[1], 0);
-			wacom_report_key(wcombo, BTN_TOUCH, 0);
+			wacom_tpc_touch_out(wacom, wcombo);
 			touchOut = 0;
 			touchInProx = 1;
 			return 1;
 		}
-	} else if (data[0] == 2) { /* Penabled */
+	} else if ((data[0] & 0xff) == 2) { /* Penabled */
 		prox = data[1] & 0x20;
 
 		touchInProx = 0;
@@ -674,28 +766,30 @@ static int wacom_tpc_irq(struct wacom_wac *wacom, void *wcombo)
 		 * an out of proximity for previous tool then a in for new tool.
 		 */
 		if (prox) { /* in prox */
-			if (!wacom->tool[0]) {
+			if (!wacom->id[1]) {
 				/* Going into proximity select tool */
-				wacom->tool[1] = (data[1] & 0x08) ? BTN_TOOL_RUBBER : BTN_TOOL_PEN;
-				if (wacom->tool[1] == BTN_TOOL_PEN)
+				wacom->tool[0] = (data[1] & 0x08) ? BTN_TOOL_RUBBER : BTN_TOOL_PEN;
+				if (wacom->tool[0] == BTN_TOOL_PEN)
 					wacom->id[0] = STYLUS_DEVICE_ID;
-			} else if (wacom->tool[1] == BTN_TOOL_RUBBER && !(data[1] & 0x08)) {
+			} else if (wacom->tool[0] == BTN_TOOL_RUBBER &&
+				   !(data[1] & 0x08)) {
 				/*
 				 * was entered with stylus2 pressed
 				 * report out proximity for previous tool
 				*/
-				wacom_report_abs(wcombo, ABS_MISC, wacom->id[0]);
-				wacom_report_key(wcombo, wacom->tool[1], 0);
+				wacom_report_abs(wcombo, ABS_MISC,
+						 wacom->id[0]);
+				wacom_report_key(wcombo, wacom->tool[0], 0);
 				wacom_input_sync(wcombo);
 
 				/* set new tool */
-				wacom->tool[1] = BTN_TOOL_PEN;
+				wacom->tool[0] = BTN_TOOL_PEN;
 				wacom->id[0] = STYLUS_DEVICE_ID;
 				return 0;
 			}
 			if (wacom->tool[1] != BTN_TOOL_RUBBER) {
 				/* Unknown tool selected default to pen tool */
-				wacom->tool[1] = BTN_TOOL_PEN;
+				wacom->tool[0] = BTN_TOOL_PEN;
 				wacom->id[0] = STYLUS_DEVICE_ID;
 			}
 			wacom_report_key(wcombo, BTN_STYLUS, data[1] & 0x02);
@@ -708,15 +802,21 @@ static int wacom_tpc_irq(struct wacom_wac *wacom, void *wcombo)
 			wacom_report_abs(wcombo, ABS_PRESSURE, pressure);
 			wacom_report_key(wcombo, BTN_TOUCH, pressure);
 		} else {
+			wacom_report_abs(wcombo, ABS_X, 0);
+			wacom_report_abs(wcombo, ABS_Y, 0);
 			wacom_report_abs(wcombo, ABS_PRESSURE, 0);
 			wacom_report_key(wcombo, BTN_STYLUS, 0);
 			wacom_report_key(wcombo, BTN_STYLUS2, 0);
 			wacom_report_key(wcombo, BTN_TOUCH, 0);
+			/* pen is out so touch can be enabled now */
+			touchInProx = 1;
 		}
-		wacom_report_key(wcombo, wacom->tool[1], prox);
+		wacom_report_key(wcombo, wacom->tool[0], prox);
 		wacom_report_abs(wcombo, ABS_MISC, wacom->id[0]);
 		stylusInProx = prox;
-		wacom->tool[0] = prox;
+		/* use the prox info to distinguish up-side switch from
+		   eraser */
+		wacom->id[1] = prox;
 		return 1;
 	}
 	return 0;
@@ -751,6 +851,8 @@ int wacom_wac_irq(struct wacom_wac *wacom_wac, void *wcombo)
 			return wacom_intuos_irq(wacom_wac, wcombo);
 
 		case TABLETPC:
+
+		case TABLETPC2FG:
 			return wacom_tpc_irq(wacom_wac, wcombo);
 
 		default:
@@ -791,9 +893,14 @@ void wacom_init_input_dev(struct input_dev *input_dev, struct wacom_wac *wacom_w
 			input_dev_i4s(input_dev, wacom_wac);
 			input_dev_i(input_dev, wacom_wac);
 			break;
+		case TABLETPC2FG:
+			input_dev_tpc2fg(input_dev, wacom_wac);
+			/* fall through */
+		case TABLETPC:
+			input_dev_tpc(input_dev, wacom_wac);
+			/* fall through */
 		case PL:
 		case PTU:
-		case TABLETPC:
 			input_dev_pl(input_dev, wacom_wac);
 			/* fall through */
 		case PENPARTNER:
@@ -804,66 +911,69 @@ void wacom_init_input_dev(struct input_dev *input_dev, struct wacom_wac *wacom_w
 }
 
 static struct wacom_features wacom_features[] = {
-	{ "Wacom Penpartner",    7,   5040,  3780,  255,  0, PENPARTNER },
-        { "Wacom Graphire",      8,  10206,  7422,  511, 63, GRAPHIRE },
-	{ "Wacom Graphire2 4x5", 8,  10206,  7422,  511, 63, GRAPHIRE },
-	{ "Wacom Graphire2 5x7", 8,  13918, 10206,  511, 63, GRAPHIRE },
-	{ "Wacom Graphire3",     8,  10208,  7424,  511, 63, GRAPHIRE },
-	{ "Wacom Graphire3 6x8", 8,  16704, 12064,  511, 63, GRAPHIRE },
-	{ "Wacom Graphire4 4x5", 8,  10208,  7424,  511, 63, WACOM_G4 },
-	{ "Wacom Graphire4 6x8", 8,  16704, 12064,  511, 63, WACOM_G4 },
-	{ "Wacom BambooFun 4x5", 9,  14760,  9225,  511, 63, WACOM_MO },
-	{ "Wacom BambooFun 6x8", 9,  21648, 13530,  511, 63, WACOM_MO },
-	{ "Wacom Bamboo1 Medium",8,  16704, 12064,  511, 63, GRAPHIRE },
-	{ "Wacom Volito",        8,   5104,  3712,  511, 63, GRAPHIRE },
-	{ "Wacom PenStation2",   8,   3250,  2320,  255, 63, GRAPHIRE },
-	{ "Wacom Volito2 4x5",   8,   5104,  3712,  511, 63, GRAPHIRE },
-	{ "Wacom Volito2 2x3",   8,   3248,  2320,  511, 63, GRAPHIRE },
-	{ "Wacom PenPartner2",   8,   3250,  2320,  511, 63, GRAPHIRE },
-	{ "Wacom Bamboo",        9,  14760,  9225,  511, 63, WACOM_MO },
-	{ "Wacom Bamboo1",       8,   5104,  3712,  511, 63, GRAPHIRE },
-	{ "Wacom Intuos 4x5",   10,  12700, 10600, 1023, 31, INTUOS },
-	{ "Wacom Intuos 6x8",   10,  20320, 16240, 1023, 31, INTUOS },
-	{ "Wacom Intuos 9x12",  10,  30480, 24060, 1023, 31, INTUOS },
-	{ "Wacom Intuos 12x12", 10,  30480, 31680, 1023, 31, INTUOS },
-	{ "Wacom Intuos 12x18", 10,  45720, 31680, 1023, 31, INTUOS },
-	{ "Wacom PL400",         8,   5408,  4056,  255,  0, PL },
-	{ "Wacom PL500",         8,   6144,  4608,  255,  0, PL },
-	{ "Wacom PL600",         8,   6126,  4604,  255,  0, PL },
-	{ "Wacom PL600SX",       8,   6260,  5016,  255,  0, PL },
-	{ "Wacom PL550",         8,   6144,  4608,  511,  0, PL },
-	{ "Wacom PL800",         8,   7220,  5780,  511,  0, PL },
-	{ "Wacom PL700",         8,   6758,  5406,  511,  0, PL },
-	{ "Wacom PL510",         8,   6282,  4762,  511,  0, PL },
-	{ "Wacom DTU710",        8,  34080, 27660,  511,  0, PL },
-	{ "Wacom DTF521",        8,   6282,  4762,  511,  0, PL },
-	{ "Wacom DTF720",        8,   6858,  5506,  511,  0, PL },
-	{ "Wacom DTF720a",       8,   6858,  5506,  511,  0, PL },
-	{ "Wacom Cintiq Partner",8,  20480, 15360,  511,  0, PTU },
-	{ "Wacom Intuos2 4x5",   10, 12700, 10600, 1023, 31, INTUOS },
-	{ "Wacom Intuos2 6x8",   10, 20320, 16240, 1023, 31, INTUOS },
-	{ "Wacom Intuos2 9x12",  10, 30480, 24060, 1023, 31, INTUOS },
-	{ "Wacom Intuos2 12x12", 10, 30480, 31680, 1023, 31, INTUOS },
-	{ "Wacom Intuos2 12x18", 10, 45720, 31680, 1023, 31, INTUOS },
-	{ "Wacom Intuos3 4x5",   10, 25400, 20320, 1023, 63, INTUOS3S },
-	{ "Wacom Intuos3 6x8",   10, 40640, 30480, 1023, 63, INTUOS3 },
-	{ "Wacom Intuos3 9x12",  10, 60960, 45720, 1023, 63, INTUOS3 },
-	{ "Wacom Intuos3 12x12", 10, 60960, 60960, 1023, 63, INTUOS3L },
-	{ "Wacom Intuos3 12x19", 10, 97536, 60960, 1023, 63, INTUOS3L },
-	{ "Wacom Intuos3 6x11",  10, 54204, 31750, 1023, 63, INTUOS3 },
-	{ "Wacom Intuos3 4x6",   10, 31496, 19685, 1023, 63, INTUOS3S },
-	{ "Wacom Intuos4 4x6",   10, 31496, 19685, 2047, 63, INTUOS4S },
-	{ "Wacom Intuos4 6x9",   10, 44704, 27940, 2047, 63, INTUOS4 },
-	{ "Wacom Intuos4 8x13",  10, 65024, 40640, 2047, 63, INTUOS4L },
-	{ "Wacom Intuos4 12x19", 10, 97536, 60960, 2047, 63, INTUOS4L },
-	{ "Wacom Cintiq 21UX",   10, 87200, 65600, 1023, 63, CINTIQ },
-	{ "Wacom Cintiq 20WSX",  10, 86680, 54180, 1023, 63, WACOM_BEE },
-	{ "Wacom Cintiq 12WX",   10, 53020, 33440, 1023, 63, WACOM_BEE },
-	{ "Wacom DTU1931",        8, 37832, 30305,  511,  0, PL },
-	{ "Wacom ISDv4 90",       8, 26202, 16325,  255,  0, TABLETPC },
-	{ "Wacom ISDv4 93",       8, 26202, 16325,  255,  0, TABLETPC },
-	{ "Wacom ISDv4 9A",       8, 26202, 16325,  255,  0, TABLETPC },
-	{ "Wacom Intuos2 6x8",   10, 20320, 16240, 1023, 31, INTUOS },
+	{ "Wacom Penpartner",         WACOM_PKGLEN_PENPRTN,    5040,  3780,  255,  0, PENPARTNER },
+	{ "Wacom Graphire",           WACOM_PKGLEN_GRAPHIRE,  10206,  7422,  511, 63, GRAPHIRE },
+	{ "Wacom Graphire2 4x5",      WACOM_PKGLEN_GRAPHIRE,  10206,  7422,  511, 63, GRAPHIRE },
+	{ "Wacom Graphire2 5x7",      WACOM_PKGLEN_GRAPHIRE,  13918, 10206,  511, 63, GRAPHIRE },
+	{ "Wacom Graphire3",          WACOM_PKGLEN_GRAPHIRE,  10208,  7424,  511, 63, GRAPHIRE },
+	{ "Wacom Graphire3 6x8",      WACOM_PKGLEN_GRAPHIRE,  16704, 12064,  511, 63, GRAPHIRE },
+	{ "Wacom Graphire4 4x5",      WACOM_PKGLEN_GRAPHIRE,  10208,  7424,  511, 63, WACOM_G4 },
+	{ "Wacom Graphire4 6x8",      WACOM_PKGLEN_GRAPHIRE,  16704, 12064,  511, 63, WACOM_G4 },
+	{ "Wacom BambooFun 4x5",      WACOM_PKGLEN_BBFUN,     14760,  9225,  511, 63, WACOM_MO },
+	{ "Wacom BambooFun 6x8",      WACOM_PKGLEN_BBFUN,     21648, 13530,  511, 63, WACOM_MO },
+	{ "Wacom Bamboo1 Medium",     WACOM_PKGLEN_GRAPHIRE,  16704, 12064,  511, 63, GRAPHIRE },
+	{ "Wacom Volito",             WACOM_PKGLEN_GRAPHIRE,   5104,  3712,  511, 63, GRAPHIRE },
+	{ "Wacom PenStation2",        WACOM_PKGLEN_GRAPHIRE,   3250,  2320,  255, 63, GRAPHIRE },
+	{ "Wacom Volito2 4x5",        WACOM_PKGLEN_GRAPHIRE,   5104,  3712,  511, 63, GRAPHIRE },
+	{ "Wacom Volito2 2x3",        WACOM_PKGLEN_GRAPHIRE,   3248,  2320,  511, 63, GRAPHIRE },
+	{ "Wacom PenPartner2",        WACOM_PKGLEN_GRAPHIRE,   3250,  2320,  511, 63, GRAPHIRE },
+	{ "Wacom Bamboo",             WACOM_PKGLEN_BBFUN,     14760,  9225,  511, 63, WACOM_MO },
+	{ "Wacom Bamboo1",            WACOM_PKGLEN_GRAPHIRE,   5104,  3712,  511, 63, GRAPHIRE },
+	{ "Wacom Intuos 4x5",         WACOM_PKGLEN_INTUOS,    12700, 10600, 1023, 31, INTUOS },
+	{ "Wacom Intuos 6x8",         WACOM_PKGLEN_INTUOS,    20320, 16240, 1023, 31, INTUOS },
+	{ "Wacom Intuos 9x12",        WACOM_PKGLEN_INTUOS,    30480, 24060, 1023, 31, INTUOS },
+	{ "Wacom Intuos 12x12",       WACOM_PKGLEN_INTUOS,    30480, 31680, 1023, 31, INTUOS },
+	{ "Wacom Intuos 12x18",       WACOM_PKGLEN_INTUOS,    45720, 31680, 1023, 31, INTUOS },
+	{ "Wacom PL400",              WACOM_PKGLEN_GRAPHIRE,   5408,  4056,  255,  0, PL },
+	{ "Wacom PL500",              WACOM_PKGLEN_GRAPHIRE,   6144,  4608,  255,  0, PL },
+	{ "Wacom PL600",              WACOM_PKGLEN_GRAPHIRE,   6126,  4604,  255,  0, PL },
+	{ "Wacom PL600SX",            WACOM_PKGLEN_GRAPHIRE,   6260,  5016,  255,  0, PL },
+	{ "Wacom PL550",              WACOM_PKGLEN_GRAPHIRE,   6144,  4608,  511,  0, PL },
+	{ "Wacom PL800",              WACOM_PKGLEN_GRAPHIRE,   7220,  5780,  511,  0, PL },
+	{ "Wacom PL700",              WACOM_PKGLEN_GRAPHIRE,   6758,  5406,  511,  0, PL },
+	{ "Wacom PL510",              WACOM_PKGLEN_GRAPHIRE,   6282,  4762,  511,  0, PL },
+	{ "Wacom DTU710",             WACOM_PKGLEN_GRAPHIRE,  34080, 27660,  511,  0, PL },
+	{ "Wacom DTF521",             WACOM_PKGLEN_GRAPHIRE,   6282,  4762,  511,  0, PL },
+	{ "Wacom DTF720",             WACOM_PKGLEN_GRAPHIRE,   6858,  5506,  511,  0, PL },
+	{ "Wacom DTF720a",            WACOM_PKGLEN_GRAPHIRE,   6858,  5506,  511,  0, PL },
+	{ "Wacom Cintiq Partner",     WACOM_PKGLEN_GRAPHIRE,  20480, 15360,  511,  0, PTU },
+	{ "Wacom Intuos2 4x5",        WACOM_PKGLEN_INTUOS,    12700, 10600, 1023, 31, INTUOS },
+	{ "Wacom Intuos2 6x8",        WACOM_PKGLEN_INTUOS,    20320, 16240, 1023, 31, INTUOS },
+	{ "Wacom Intuos2 9x12",       WACOM_PKGLEN_INTUOS,    30480, 24060, 1023, 31, INTUOS },
+	{ "Wacom Intuos2 12x12",      WACOM_PKGLEN_INTUOS,    30480, 31680, 1023, 31, INTUOS },
+	{ "Wacom Intuos2 12x18",      WACOM_PKGLEN_INTUOS,    45720, 31680, 1023, 31, INTUOS },
+	{ "Wacom Intuos3 4x5",        WACOM_PKGLEN_INTUOS,    25400, 20320, 1023, 63, INTUOS3S },
+	{ "Wacom Intuos3 6x8",        WACOM_PKGLEN_INTUOS,    40640, 30480, 1023, 63, INTUOS3 },
+	{ "Wacom Intuos3 9x12",       WACOM_PKGLEN_INTUOS,    60960, 45720, 1023, 63, INTUOS3 },
+	{ "Wacom Intuos3 12x12",      WACOM_PKGLEN_INTUOS,    60960, 60960, 1023, 63, INTUOS3L },
+	{ "Wacom Intuos3 12x19",      WACOM_PKGLEN_INTUOS,    97536, 60960, 1023, 63, INTUOS3L },
+	{ "Wacom Intuos3 6x11",       WACOM_PKGLEN_INTUOS,    54204, 31750, 1023, 63, INTUOS3 },
+	{ "Wacom Intuos3 4x6",        WACOM_PKGLEN_INTUOS,    31496, 19685, 1023, 63, INTUOS3S },
+	{ "Wacom Intuos4 4x6",        WACOM_PKGLEN_INTUOS,    31496, 19685, 2047, 63, INTUOS4S },
+	{ "Wacom Intuos4 6x9",        WACOM_PKGLEN_INTUOS,    44704, 27940, 2047, 63, INTUOS4 },
+	{ "Wacom Intuos4 8x13",       WACOM_PKGLEN_INTUOS,    65024, 40640, 2047, 63, INTUOS4L },
+	{ "Wacom Intuos4 12x19",      WACOM_PKGLEN_INTUOS,    97536, 60960, 2047, 63, INTUOS4L },
+	{ "Wacom Cintiq 21UX",        WACOM_PKGLEN_INTUOS,    87200, 65600, 1023, 63, CINTIQ },
+	{ "Wacom Cintiq 20WSX",       WACOM_PKGLEN_INTUOS,    86680, 54180, 1023, 63, WACOM_BEE },
+	{ "Wacom Cintiq 12WX",        WACOM_PKGLEN_INTUOS,    53020, 33440, 1023, 63, WACOM_BEE },
+	{ "Wacom DTU1931",            WACOM_PKGLEN_GRAPHIRE,  37832, 30305,  511,  0, PL },
+	{ "Wacom ISDv4 90",           WACOM_PKGLEN_GRAPHIRE,  26202, 16325,  255,  0, TABLETPC },
+	{ "Wacom ISDv4 93",           WACOM_PKGLEN_GRAPHIRE,  26202, 16325,  255,  0, TABLETPC },
+	{ "Wacom ISDv4 9A",           WACOM_PKGLEN_GRAPHIRE,  26202, 16325,  255,  0, TABLETPC },
+	{ "Wacom ISDv4 9F",           WACOM_PKGLEN_GRAPHIRE,  26202, 16325,  255,  0, TABLETPC },
+	{ "Wacom ISDv4 E2",           WACOM_PKGLEN_TPC2FG,    26202, 16325,  255,  0, TABLETPC2FG },
+	{ "Wacom ISDv4 E3",           WACOM_PKGLEN_TPC2FG,    26202, 16325,  255,  0, TABLETPC2FG },
+	{ "Wacom Intuos2 6x8",        WACOM_PKGLEN_INTUOS,    20320, 16240, 1023, 31, INTUOS },
 	{ }
 };
 
@@ -927,6 +1037,9 @@ static struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x90) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x93) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x9A) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x9F) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0xE2) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0xE3) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x47) },
 	{ }
 };
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index c10235a..a6a86de 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -9,6 +9,10 @@
 #ifndef WACOM_WAC_H
 #define WACOM_WAC_H
 
+/* maximum packet length for USB devices */
+#define WACOM_PKGLEN_MAX	32
+
+/* device IDs */
 #define STYLUS_DEVICE_ID	0x02
 #define TOUCH_DEVICE_ID		0x03
 #define CURSOR_DEVICE_ID	0x06
@@ -32,6 +36,7 @@ enum {
 	WACOM_BEE,
 	WACOM_MO,
 	TABLETPC,
+	TABLETPC2FG,
 	MAX_TYPE
 };
 
@@ -43,8 +48,12 @@ struct wacom_features {
 	int pressure_max;
 	int distance_max;
 	int type;
+	int touch_x_res;
+	int touch_y_res;
 	int touch_x_max;
 	int touch_y_max;
+	unsigned char unit;
+	unsigned char unitExpo;
 };
 
 struct wacom_wac {
-- 
1.6.5.2

