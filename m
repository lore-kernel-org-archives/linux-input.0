From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 2/3] Wacom: Add support for two-finger touch
Date: Wed, 16 Dec 2009 17:58:21 -0500
Message-ID: <1261004302-4858-3-git-send-email-mjg@redhat.com>
References: <1261004302-4858-1-git-send-email-mjg@redhat.com>
 <1261004302-4858-2-git-send-email-mjg@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49478 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763211AbZLPW7J (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Dec 2009 17:59:09 -0500
In-Reply-To: <1261004302-4858-2-git-send-email-mjg@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: pingc@wacom.com, Matthew Garrett <mjg@redhat.com>

From: Ping Cheng <pingc@wacom.com>

Some wacom pads can report events for two-finger touches. Make sure that
these are reported.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/input/tablet/wacom_sys.c |   78 +++++++-----
 drivers/input/tablet/wacom_wac.c |  254 +++++++++++++++++++++-----------------
 drivers/input/tablet/wacom_wac.h |    7 +-
 3 files changed, 188 insertions(+), 151 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index de1562b..02592b6 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -209,6 +209,7 @@ void input_dev_g(struct input_dev *input_dev, struct wacom_wac *wacom_wac)
 	input_dev->keybit[BIT_WORD(BTN_MOUSE)] |= BIT_MASK(BTN_LEFT) |
 		BIT_MASK(BTN_RIGHT) | BIT_MASK(BTN_MIDDLE);
 	input_dev->keybit[BIT_WORD(BTN_DIGI)] |= BIT_MASK(BTN_TOOL_RUBBER) |
+		BIT_MASK(BTN_TOOL_PEN) | BIT_MASK(BTN_STYLUS) |
 		BIT_MASK(BTN_TOOL_MOUSE) | BIT_MASK(BTN_STYLUS2);
 	input_set_abs_params(input_dev, ABS_DISTANCE, 0, wacom_wac->features->distance_max, 0, 0);
 }
@@ -256,6 +257,7 @@ void input_dev_i(struct input_dev *input_dev, struct wacom_wac *wacom_wac)
 		BIT_MASK(BTN_RIGHT) | BIT_MASK(BTN_MIDDLE) |
 		BIT_MASK(BTN_SIDE) | BIT_MASK(BTN_EXTRA);
 	input_dev->keybit[BIT_WORD(BTN_DIGI)] |= BIT_MASK(BTN_TOOL_RUBBER) |
+		BIT_MASK(BTN_TOOL_PEN) | BIT_MASK(BTN_STYLUS) |
 		BIT_MASK(BTN_TOOL_MOUSE) | BIT_MASK(BTN_TOOL_BRUSH) |
 		BIT_MASK(BTN_TOOL_PENCIL) | BIT_MASK(BTN_TOOL_AIRBRUSH) |
 		BIT_MASK(BTN_TOOL_LENS) | BIT_MASK(BTN_STYLUS2);
@@ -269,7 +271,8 @@ void input_dev_i(struct input_dev *input_dev, struct wacom_wac *wacom_wac)
 
 void input_dev_pl(struct input_dev *input_dev, struct wacom_wac *wacom_wac)
 {
-	input_dev->keybit[BIT_WORD(BTN_DIGI)] |= BIT_MASK(BTN_STYLUS2);
+	input_dev->keybit[BIT_WORD(BTN_DIGI)] |= BIT_MASK(BTN_TOOL_PEN) |
+		BIT_MASK(BTN_STYLUS) | BIT_MASK(BTN_STYLUS2);
 }
 
 void input_dev_pt(struct input_dev *input_dev, struct wacom_wac *wacom_wac)
@@ -279,20 +282,24 @@ void input_dev_pt(struct input_dev *input_dev, struct wacom_wac *wacom_wac)
 
 void input_dev_tpc(struct input_dev *input_dev, struct wacom_wac *wacom_wac)
 {
-	input_set_abs_params(input_dev, ABS_RX, 0,
-			     wacom_wac->features->touch_x_max, 4, 0);
-	input_set_abs_params(input_dev, ABS_RY, 0,
-			     wacom_wac->features->touch_y_max, 4, 0);
-	input_set_abs_params(input_dev, ABS_Z, 0,
-			     wacom_wac->features->touch_x_res, 0, 0);
-	input_set_abs_params(input_dev, ABS_RZ, 0,
-			     wacom_wac->features->touch_y_res, 0, 0);
-	input_dev->keybit[BIT_WORD(BTN_DIGI)] |= BIT_MASK(BTN_TOOL_DOUBLETAP);
+	if (wacom_wac->features->device_type == BTN_TOOL_DOUBLETAP) {
+		input_set_abs_params(input_dev, ABS_RX, 0,
+				     wacom_wac->features->x_phy, 0, 0);
+		input_set_abs_params(input_dev, ABS_RY, 0,
+				     wacom_wac->features->y_phy, 0, 0);
+		input_dev->keybit[BIT_WORD(BTN_DIGI)] |=
+			BIT_MASK(BTN_TOOL_DOUBLETAP);
+	}
 }
 
 void input_dev_tpc2fg(struct input_dev *input_dev, struct wacom_wac *wacom_wac)
 {
-	input_dev->keybit[BIT_WORD(BTN_DIGI)] |= BIT_MASK(BTN_TOOL_TRIPLETAP);
+	if (wacom_wac->features->device_type == BTN_TOOL_DOUBLETAP) {
+		input_dev->keybit[BIT_WORD(BTN_DIGI)] |=
+			BIT_MASK(BTN_TOOL_TRIPLETAP);
+		input_dev->evbit[0] |= BIT_MASK(EV_MSC);
+		input_dev->mscbit[0] |= BIT_MASK(MSC_SERIAL);
+	}
 }
 
 static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hid_desc,
@@ -346,15 +353,19 @@ static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hi
 			case HID_USAGE_X:
 				if (usage == WCM_DESKTOP) {
 					if (finger) {
-						features->touch_x_max =
+						features->device_type =
+							BTN_TOOL_DOUBLETAP;
+						features->x_max =
 							wacom_le16_to_cpu(&report[i + 3]);
-						features->touch_x_res =
+						features->x_phy =
 							wacom_le16_to_cpu(&report[i + 6]);
 						features->unit = report[i + 9];
 						features->unitExpo =
 							report[i + 11];
 						i += 12;
 					} else if (pen) {
+						features->device_type =
+							BTN_TOOL_PEN;
 						features->x_max =
 							wacom_le16_to_cpu(&report[i + 3]);
 						i += 4;
@@ -372,21 +383,25 @@ static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hi
 			case HID_USAGE_Y:
 				if (usage == WCM_DESKTOP) {
 					if (finger) {
+						features->device_type =
+							BTN_TOOL_DOUBLETAP;
 						if (strstr(features->name,
 							   "Wacom ISDv4 E")) {
-							features->touch_y_max =
+							features->y_max =
 								wacom_le16_to_cpu(&report[i + 3]);
-							features->touch_y_res =
+							features->y_phy =
 								wacom_le16_to_cpu(&report[i + 6]);
 							i += 7;
 						} else {
-							features->touch_y_max =
-								features->touch_x_max;
-							features->touch_y_res =
+							features->y_max =
+								features->x_max;
+							features->y_phy =
 								wacom_le16_to_cpu(&report[i + 3]);
 							i += 4;
 						}
 					} else if (pen) {
+						features->device_type =
+							BTN_TOOL_PEN;
 						features->y_max =
 							wacom_le16_to_cpu(&report[i + 3]);
 						i += 4;
@@ -507,6 +522,10 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 	wacom_wac->features = features = get_wacom_feature(id);
 	BUG_ON(features->pktlen > WACOM_PKGLEN_MAX);
 
+	/* default device to penabled */
+	if (features->device_type)
+		features->device_type = BTN_TOOL_PEN;
+
 	input_dev->name = wacom_wac->features->name;
 	wacom->wacom_wac = wacom_wac;
 	usb_to_input_id(dev, &input_dev->id);
@@ -520,11 +539,7 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 
 	endpoint = &intf->cur_altsetting->endpoint[0].desc;
 
-	/* Initialize touch_x_max and touch_y_max in case it is not defined in
-	   HID descriptor */
 	if (features->type == TABLETPC || features->type == TABLETPC2FG) {
-		features->touch_x_max = 1023;
-		features->touch_y_max = 1023;
 
 		/* TabletPC need to retrieve the physical and logical maximum
 		   from report descriptor */
@@ -538,21 +553,22 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 		error = wacom_parse_hid(intf, hid_desc, wacom_wac);
 		if (error)
 			goto fail2;
-	} else {
-		features->touch_x_max = 0;
-		features->touch_y_max = 0;
-	}
 
+		/* touch device found but size is not defined. use default */
+		if (features->device_type == BTN_TOOL_DOUBLETAP &&
+		    !features->x_max) {
+			features->x_max = 1023;
+			features->y_max = 1023;
+		}
+	}
 
 	input_dev->evbit[0] |= BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
-	input_dev->keybit[BIT_WORD(BTN_DIGI)] |= BIT_MASK(BTN_TOOL_PEN) |
-		BIT_MASK(BTN_TOUCH) | BIT_MASK(BTN_STYLUS);
+	input_dev->keybit[BIT_WORD(BTN_DIGI)] |= BIT_MASK(BTN_TOUCH);
 
 	input_set_abs_params(input_dev, ABS_X, 0, features->x_max, 4, 0);
-
 	input_set_abs_params(input_dev, ABS_Y, 0, features->y_max, 4, 0);
-
-	input_set_abs_params(input_dev, ABS_PRESSURE, 0, features->pressure_max, 0, 0);
+	input_set_abs_params(input_dev, ABS_PRESSURE, 0,
+			     features->pressure_max, 0, 0);
 	input_dev->absbit[BIT_WORD(ABS_MISC)] |= BIT_MASK(ABS_MISC);
 
 	wacom_init_input_dev(input_dev, wacom_wac);
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index e3dfb14..1937cf1 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -73,9 +73,9 @@ static int wacom_pl_irq(struct wacom_wac *wacom, void *wcombo)
 
 	prox = data[1] & 0x40;
 
-	wacom->id[0] = ERASER_DEVICE_ID;
 	if (prox) {
 
+		wacom->id[0] = ERASER_DEVICE_ID;
 		pressure = (signed char)((data[7] << 1) | ((data[4] >> 2) & 1));
 		if (wacom->features->pressure_max > 255)
 			pressure = (pressure << 1) | ((data[4] >> 6) & 1);
@@ -165,6 +165,7 @@ static int wacom_graphire_irq(struct wacom_wac *wacom, void *wcombo)
 {
 	unsigned char *data = wacom->data;
 	int x, y, rw;
+	static int penData;
 
 	if ((data[0] & 0xff) != 2) {
 		dbg("wacom_graphire_irq: received unknown report #%d", data[0]);
@@ -173,7 +174,7 @@ static int wacom_graphire_irq(struct wacom_wac *wacom, void *wcombo)
 
 	if (data[1] & 0x80) {
 		/* in prox and not a pad data */
-
+		penData = 1;
 		switch ((data[1] >> 5) & 3) {
 
 			case 0:	/* Pen */
@@ -244,7 +245,11 @@ static int wacom_graphire_irq(struct wacom_wac *wacom, void *wcombo)
 	switch (wacom->features->type) {
 	    case WACOM_G4:
 		if (data[7] & 0xf8) {
-			wacom_input_sync(wcombo); /* sync last event */
+			if (penData) {
+				wacom_input_sync(wcombo); /* sync last event */
+				if (!wacom->id[0])
+					penData = 0;
+			}
 			wacom->id[1] = PAD_DEVICE_ID;
 			wacom_report_key(wcombo, BTN_0, (data[7] & 0x40));
 			wacom_report_key(wcombo, BTN_4, (data[7] & 0x80));
@@ -254,10 +259,15 @@ static int wacom_graphire_irq(struct wacom_wac *wacom, void *wcombo)
 			wacom_report_abs(wcombo, ABS_MISC, wacom->id[1]);
 			wacom_input_event(wcombo, EV_MSC, MSC_SERIAL, 0xf0);
 		} else if (wacom->id[1]) {
-			wacom_input_sync(wcombo); /* sync last event */
+			if (penData) {
+				wacom_input_sync(wcombo); /* sync last event */
+				if (!wacom->id[0])
+					penData = 0;
+			}
 			wacom->id[1] = 0;
 			wacom_report_key(wcombo, BTN_0, (data[7] & 0x40));
 			wacom_report_key(wcombo, BTN_4, (data[7] & 0x80));
+			wacom_report_rel(wcombo, REL_WHEEL, 0);
 			wacom_report_key(wcombo, BTN_TOOL_FINGER, 0);
 			wacom_report_abs(wcombo, ABS_MISC, 0);
 			wacom_input_event(wcombo, EV_MSC, MSC_SERIAL, 0xf0);
@@ -265,7 +275,11 @@ static int wacom_graphire_irq(struct wacom_wac *wacom, void *wcombo)
 		break;
 	    case WACOM_MO:
 		if ((data[7] & 0xf8) || (data[8] & 0xff)) {
-			wacom_input_sync(wcombo); /* sync last event */
+			if (penData) {
+				wacom_input_sync(wcombo); /* sync last event */
+				if (!wacom->id[0])
+					penData = 0;
+			}
 			wacom->id[1] = PAD_DEVICE_ID;
 			wacom_report_key(wcombo, BTN_0, (data[7] & 0x08));
 			wacom_report_key(wcombo, BTN_1, (data[7] & 0x20));
@@ -276,7 +290,11 @@ static int wacom_graphire_irq(struct wacom_wac *wacom, void *wcombo)
 			wacom_report_abs(wcombo, ABS_MISC, wacom->id[1]);
 			wacom_input_event(wcombo, EV_MSC, MSC_SERIAL, 0xf0);
 		} else if (wacom->id[1]) {
-			wacom_input_sync(wcombo); /* sync last event */
+			if (penData) {
+				wacom_input_sync(wcombo); /* sync last event */
+				if (!wacom->id[0])
+					penData = 0;
+			}
 			wacom->id[1] = 0;
 			wacom_report_key(wcombo, BTN_0, (data[7] & 0x08));
 			wacom_report_key(wcombo, BTN_1, (data[7] & 0x20));
@@ -623,117 +641,128 @@ static int wacom_intuos_irq(struct wacom_wac *wacom, void *wcombo)
 	return 1;
 }
 
+
+static void wacom_tpc_finger_in(struct wacom_wac *wacom, void *wcombo,
+				char *data, int idx)
+{
+	wacom_report_abs(wcombo, ABS_X,
+		(data[2 + idx * 2] & 0xff) | ((data[3 + idx * 2] & 0x7f) << 8));
+	wacom_report_abs(wcombo, ABS_Y,
+		(data[6 + idx * 2] & 0xff) | ((data[7 + idx * 2] & 0x7f) << 8));
+	wacom_report_abs(wcombo, ABS_MISC, wacom->id[0]);
+	wacom_report_key(wcombo, wacom->tool[idx], 1);
+	if (idx)
+		wacom_input_event(wcombo, EV_MSC, MSC_SERIAL, 0xf0);
+	else
+		wacom_report_key(wcombo, BTN_TOUCH, 1);
+}
+
+static void wacom_tpc_touch_out(struct wacom_wac *wacom, void *wcombo, int idx)
+{
+	wacom_report_abs(wcombo, ABS_X, 0);
+	wacom_report_abs(wcombo, ABS_Y, 0);
+	wacom_report_abs(wcombo, ABS_MISC, 0);
+	wacom_report_key(wcombo, wacom->tool[idx], 0);
+	if (idx)
+		wacom_input_event(wcombo, EV_MSC, MSC_SERIAL, 0xf0);
+	else
+		wacom_report_key(wcombo, BTN_TOUCH, 0);
+	return;
+}
+
 static void wacom_tpc_touch_in(struct wacom_wac *wacom, void *wcombo)
 {
 	char *data = wacom->data;
 	struct urb *urb = ((struct wacom_combo *)wcombo)->urb;
+	static int firstFinger;
+	static int secondFinger;
+
+	wacom->tool[0] = BTN_TOOL_DOUBLETAP;  
+	wacom->id[0] = TOUCH_DEVICE_ID; 
+	wacom->tool[1] = BTN_TOOL_TRIPLETAP;
 
-	wacom->tool[0] = BTN_TOOL_DOUBLETAP;
-	wacom->id[0] = TOUCH_DEVICE_ID;
 	if (urb->actual_length != WACOM_PKGLEN_TPC1FG) {
 		switch (data[0] & 0xff) {
-		case 6:
-			wacom_report_abs(wcombo, ABS_X,
-					 wacom_le16_to_cpu(&data[2]));
-			wacom_report_abs(wcombo, ABS_Y,
-					 wacom_le16_to_cpu(&data[4]));
-			wacom_report_abs(wcombo, ABS_PRESSURE,
-					 wacom_le16_to_cpu(&data[6]));
-			wacom_report_key(wcombo, BTN_TOUCH,
-					 wacom_le16_to_cpu(&data[6]));
-			break;
-		case 13:
-			if (data[1] & 0x01) {
-				if (data[1] & 0x02) {
-					wacom->tool[1] = BTN_TOOL_TRIPLETAP;
-					wacom_report_abs(wcombo, ABS_X,
-							 (data[4] & 0xff) |
-							 ((data[5] & 0x7f) << 8));
-					wacom_report_abs(wcombo, ABS_Y,
-							 (data[8] & 0xff) |
-							 ((data[9] & 0x7f) << 8));
-					wacom_report_abs(wcombo, ABS_MISC,
-							 wacom->id[0]);
-					wacom_report_key(wcombo,
-							 wacom->tool[1], 1);
-					wacom_input_event(wcombo,
-							  EV_MSC, MSC_SERIAL,
-							  0xf0);
-
-					/* sync second finger data */
-					wacom_input_sync(wcombo);
-					}
+			case 6:
 				wacom_report_abs(wcombo, ABS_X,
-						 (data[2] & 0xff) |
-						 ((data[3] & 0x7f) << 8));
+						 wacom_le16_to_cpu(&data[2]));
 				wacom_report_abs(wcombo, ABS_Y,
-						 (data[6] & 0xff) |
-						 ((data[7] & 0x7f) << 8));
+						 wacom_le16_to_cpu(&data[4]));
+				wacom_report_abs(wcombo, ABS_PRESSURE,
+						 wacom_le16_to_cpu(&data[6]));
+				wacom_report_key(wcombo, BTN_TOUCH,
+						 wacom_le16_to_cpu(&data[6]));
+				wacom_report_abs(wcombo, ABS_MISC,
+						 wacom->id[0]);
+				wacom_report_key(wcombo, wacom->tool[0], 1);
+				break;
+			case 13:
+				/* keep this byte to send proper out-prox event */
+				wacom->id[1] = data[1] & 0x03;
+
+				if (data[1] & 0x01) {
+					wacom_tpc_finger_in(wacom, wcombo,
+							    data, 0);
+					firstFinger = 1;
+				} else if (firstFinger) {
+					wacom_tpc_touch_out(wacom, wcombo, 0);
+				}
+
+				if (data[1] & 0x02) {
+					/* sync first finger data */
+					if (firstFinger)
+						wacom_input_sync(wcombo);
+
+					wacom_tpc_finger_in(wacom, wcombo,
+							    data, 1);
+					secondFinger = 1;
+				} else if (secondFinger) {
+					/* sync first finger data */
+					if (firstFinger)
+						wacom_input_sync(wcombo);
+
+					wacom_tpc_touch_out(wacom, wcombo, 1);
+					secondFinger = 0;
 				}
-				wacom_report_key(wcombo, BTN_TOUCH, 1);
+				if (!(data[1] & 0x01))
+					firstFinger = 0;
 				break;
 		}
 	} else {
 		wacom_report_abs(wcombo, ABS_X, wacom_le16_to_cpu(&data[1]));
 		wacom_report_abs(wcombo, ABS_Y, wacom_le16_to_cpu(&data[3]));
 		wacom_report_key(wcombo, BTN_TOUCH, 1);
+		wacom_report_abs(wcombo, ABS_MISC, wacom->id[0]);
+		wacom_report_key(wcombo, wacom->tool[0], 1);
 	}
-	wacom_report_abs(wcombo, ABS_MISC, wacom->id[0]);
-	wacom_report_key(wcombo, wacom->tool[0], 1);
-
-	return;
-}
-
-static void wacom_tpc_touch_out(struct wacom_wac *wacom, void *wcombo)
-{
-	wacom_report_abs(wcombo, ABS_X, 0);
-	wacom_report_abs(wcombo, ABS_Y, 0);
-	wacom_report_abs(wcombo, ABS_MISC, 0);
-	wacom_report_key(wcombo, wacom->tool[0], 0);
-	wacom_report_key(wcombo, BTN_TOUCH, 0);
 	return;
 }
 
 static int wacom_tpc_irq(struct wacom_wac *wacom, void *wcombo)
 {
 	char *data = wacom->data;
-	int prox = 0, pressure;
+	int prox = 0, pressure, idx = -1;
 	static int stylusInProx, touchInProx = 1, touchOut;
 	struct urb *urb = ((struct wacom_combo *)wcombo)->urb;
-	static int secondFingerIn;
 
 	dbg("wacom_tpc_irq: received report #%d", data[0]);
 
 	if (urb->actual_length == WACOM_PKGLEN_TPC1FG ||
 	    ((data[0] & 0xff) == 6)  /* single touch */
-	    || (data[0] & 0xff) == 13) { /* 2FG touch */
+	    || (data[0] & 0xff) == 13 ) { /* 2FG touch */
 		/* with touch */
 		if (urb->actual_length == WACOM_PKGLEN_TPC1FG) {
-			prox = data[0] & 0x03;
+			prox = data[0] & 0x01;
 		} else {  /* with capacity */
-			if ((data[0] & 0xff) == 6)     /* single touch */
+			if ((data[0] & 0xff) == 6)
+				/* single touch */
 				prox = data[1] & 0x01;
-			else			       /* 2FG touch data */
+			else
+				/* 2FG touch data */
 				prox = data[1] & 0x03;
 		}
 
 		if (!stylusInProx) { /* stylus not in prox */
-			if ((data[0] & 0xff) == 13) {
-				if (data[1] & 0x02)
-					secondFingerIn = 1;
-				else if (secondFingerIn == 1) {
-					wacom_report_abs(wcombo, ABS_X, 0);
-					wacom_report_abs(wcombo, ABS_Y, 0);
-					wacom_report_abs(wcombo, ABS_MISC, 0);
-					wacom_report_key(wcombo,
-							 wacom->tool[1], 0);
-					wacom_input_event(wcombo, EV_MSC,
-							  MSC_SERIAL, 0xf0);
-					/* sync second finger data */
-					wacom_input_sync(wcombo);
-					secondFingerIn = 0;
-				}
-			}
 			if (prox) {
 				if (touchInProx) {
 					wacom_tpc_touch_in(wacom, wcombo);
@@ -741,13 +770,30 @@ static int wacom_tpc_irq(struct wacom_wac *wacom, void *wcombo)
 					return 1;
 				}
 			} else {
-				wacom_tpc_touch_out(wacom, wcombo);
+				/* 2FGT out-prox */
+				if ((data[0] & 0xff) == 13) {
+					idx = (wacom->id[1] & 0x01) - 1;
+					if (idx == 0) {
+						wacom_tpc_touch_out(wacom,
+								    wcombo,
+								    idx);
+						/* sync first finger event */
+						if (wacom->id[1] & 0x02)
+							wacom_input_sync(wcombo);
+					}
+					idx = (wacom->id[1] & 0x02) - 1;
+					if (idx == 1)
+						wacom_tpc_touch_out(wacom,
+								    wcombo,
+								    idx);
+				} else /* one finger touch */
+					wacom_tpc_touch_out(wacom, wcombo, 0);
 				touchOut = 0;
 				touchInProx = 1;
 				return 1;
 			}
 		} else if (touchOut || !prox) { /* force touch out-prox */
-			wacom_tpc_touch_out(wacom, wcombo);
+			wacom_tpc_touch_out(wacom, wcombo, 0);
 			touchOut = 0;
 			touchInProx = 1;
 			return 1;
@@ -757,40 +803,14 @@ static int wacom_tpc_irq(struct wacom_wac *wacom, void *wcombo)
 
 		touchInProx = 0;
 
-		wacom->id[0] = ERASER_DEVICE_ID;
-
-		/*
-		 * if going from out of proximity into proximity select between the eraser
-		 * and the pen based on the state of the stylus2 button, choose eraser if
-		 * pressed else choose pen. if not a proximity change from out to in, send
-		 * an out of proximity for previous tool then a in for new tool.
-		 */
 		if (prox) { /* in prox */
-			if (!wacom->id[1]) {
-				/* Going into proximity select tool */
-				wacom->tool[0] = (data[1] & 0x08) ? BTN_TOOL_RUBBER : BTN_TOOL_PEN;
+			if (!wacom->id[0]) {
+				wacom->tool[0] = (data[1] & 0x0c) ?
+					BTN_TOOL_RUBBER : BTN_TOOL_PEN;
 				if (wacom->tool[0] == BTN_TOOL_PEN)
 					wacom->id[0] = STYLUS_DEVICE_ID;
-			} else if (wacom->tool[0] == BTN_TOOL_RUBBER &&
-				   !(data[1] & 0x08)) {
-				/*
-				 * was entered with stylus2 pressed
-				 * report out proximity for previous tool
-				*/
-				wacom_report_abs(wcombo, ABS_MISC,
-						 wacom->id[0]);
-				wacom_report_key(wcombo, wacom->tool[0], 0);
-				wacom_input_sync(wcombo);
-
-				/* set new tool */
-				wacom->tool[0] = BTN_TOOL_PEN;
-				wacom->id[0] = STYLUS_DEVICE_ID;
-				return 0;
-			}
-			if (wacom->tool[1] != BTN_TOOL_RUBBER) {
-				/* Unknown tool selected default to pen tool */
-				wacom->tool[0] = BTN_TOOL_PEN;
-				wacom->id[0] = STYLUS_DEVICE_ID;
+				else
+					wacom->id[0] = ERASER_DEVICE_ID;
 			}
 			wacom_report_key(wcombo, BTN_STYLUS, data[1] & 0x02);
 			wacom_report_key(wcombo, BTN_STYLUS2, data[1] & 0x10);
@@ -800,7 +820,7 @@ static int wacom_tpc_irq(struct wacom_wac *wacom, void *wcombo)
 			if (pressure < 0)
 				pressure = wacom->features->pressure_max + pressure + 1;
 			wacom_report_abs(wcombo, ABS_PRESSURE, pressure);
-			wacom_report_key(wcombo, BTN_TOUCH, pressure);
+			wacom_report_key(wcombo, BTN_TOUCH, data[1] & 0x05);
 		} else {
 			wacom_report_abs(wcombo, ABS_X, 0);
 			wacom_report_abs(wcombo, ABS_Y, 0);
@@ -808,15 +828,13 @@ static int wacom_tpc_irq(struct wacom_wac *wacom, void *wcombo)
 			wacom_report_key(wcombo, BTN_STYLUS, 0);
 			wacom_report_key(wcombo, BTN_STYLUS2, 0);
 			wacom_report_key(wcombo, BTN_TOUCH, 0);
+			wacom->id[0] = 0;
 			/* pen is out so touch can be enabled now */
 			touchInProx = 1;
 		}
 		wacom_report_key(wcombo, wacom->tool[0], prox);
 		wacom_report_abs(wcombo, ABS_MISC, wacom->id[0]);
 		stylusInProx = prox;
-		/* use the prox info to distinguish up-side switch from
-		   eraser */
-		wacom->id[1] = prox;
 		return 1;
 	}
 	return 0;
@@ -898,6 +916,10 @@ void wacom_init_input_dev(struct input_dev *input_dev, struct wacom_wac *wacom_w
 			/* fall through */
 		case TABLETPC:
 			input_dev_tpc(input_dev, wacom_wac);
+			if (wacom_wac->features->device_type ==
+			    BTN_TOOL_DOUBLETAP)
+				break;  /* no need to process stylus stuff */
+
 			/* fall through */
 		case PL:
 		case PTU:
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index a6a86de..37e0eb3 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -48,10 +48,9 @@ struct wacom_features {
 	int pressure_max;
 	int distance_max;
 	int type;
-	int touch_x_res;
-	int touch_y_res;
-	int touch_x_max;
-	int touch_y_max;
+	int device_type;
+	int x_phy;
+	int y_phy;
 	unsigned char unit;
 	unsigned char unitExpo;
 };
-- 
1.6.5.2

