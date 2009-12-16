From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 3/3] wacom: Improve support for Penabled devices
Date: Wed, 16 Dec 2009 17:58:22 -0500
Message-ID: <1261004302-4858-4-git-send-email-mjg@redhat.com>
References: <1261004302-4858-1-git-send-email-mjg@redhat.com>
 <1261004302-4858-2-git-send-email-mjg@redhat.com>
 <1261004302-4858-3-git-send-email-mjg@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49480 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763348AbZLPW7K (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Dec 2009 17:59:10 -0500
In-Reply-To: <1261004302-4858-3-git-send-email-mjg@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: pingc@wacom.com, Matthew Garrett <mjg@redhat.com>

From: Ping Cheng <pingc@wacom.com>

Refactor the code somewhat in order to provide better support for
Penabled devices.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/input/tablet/wacom_sys.c |  144 ++++++++++++++++++++++++--------------
 drivers/input/tablet/wacom_wac.c |   24 ++-----
 drivers/input/tablet/wacom_wac.h |    9 +++
 3 files changed, 108 insertions(+), 69 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 02592b6..9fc4244 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -1,7 +1,7 @@
 /*
  * drivers/input/tablet/wacom_sys.c
  *
- *  USB Wacom Graphire and Wacom Intuos tablet support - system specific code
+ *  USB Wacom tablet support - system specific code
  */
 
 /*
@@ -282,7 +282,8 @@ void input_dev_pt(struct input_dev *input_dev, struct wacom_wac *wacom_wac)
 
 void input_dev_tpc(struct input_dev *input_dev, struct wacom_wac *wacom_wac)
 {
-	if (wacom_wac->features->device_type == BTN_TOOL_DOUBLETAP) {
+	if ((wacom_wac->features->device_type == BTN_TOOL_DOUBLETAP) ||
+	    (wacom_wac->features->device_type == BTN_TOOL_TRIPLETAP)) {
 		input_set_abs_params(input_dev, ABS_RX, 0,
 				     wacom_wac->features->x_phy, 0, 0);
 		input_set_abs_params(input_dev, ABS_RY, 0,
@@ -294,7 +295,7 @@ void input_dev_tpc(struct input_dev *input_dev, struct wacom_wac *wacom_wac)
 
 void input_dev_tpc2fg(struct input_dev *input_dev, struct wacom_wac *wacom_wac)
 {
-	if (wacom_wac->features->device_type == BTN_TOOL_DOUBLETAP) {
+	if (wacom_wac->features->device_type == BTN_TOOL_TRIPLETAP) {
 		input_dev->keybit[BIT_WORD(BTN_DIGI)] |=
 			BIT_MASK(BTN_TOOL_TRIPLETAP);
 		input_dev->evbit[0] |= BIT_MASK(EV_MSC);
@@ -303,10 +304,9 @@ void input_dev_tpc2fg(struct input_dev *input_dev, struct wacom_wac *wacom_wac)
 }
 
 static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hid_desc,
-		struct wacom_wac *wacom_wac)
+		struct wacom_features *features)
 {
 	struct usb_device *dev = interface_to_usbdev(intf);
-	struct wacom_features *features = wacom_wac->features;
 	char limit = 0;
 	int i = 0, usage = WCM_UNDEFINED, finger = 0, pen = 0, result = 0;
 	unsigned char *report;
@@ -355,6 +355,14 @@ static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hi
 					if (finger) {
 						features->device_type =
 							BTN_TOOL_DOUBLETAP;
+						if (features->type ==
+						    TABLETPC2FG) {
+							/* need to reset back */
+							features->pktlen =
+								WACOM_PKGLEN_TPC2FG;
+							features->device_type =
+								BTN_TOOL_TRIPLETAP;
+						}
 						features->x_max =
 							wacom_le16_to_cpu(&report[i + 3]);
 						features->x_phy =
@@ -364,6 +372,11 @@ static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hi
 							report[i + 11];
 						i += 12;
 					} else if (pen) {
+						/* penabled only accepts exact bytes of data */
+						if (features->type ==
+						    TABLETPC2FG)
+							features->pktlen =
+								WACOM_PKGLEN_PENABLED;
 						features->device_type =
 							BTN_TOOL_PEN;
 						features->x_max =
@@ -385,8 +398,13 @@ static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hi
 					if (finger) {
 						features->device_type =
 							BTN_TOOL_DOUBLETAP;
-						if (strstr(features->name,
-							   "Wacom ISDv4 E")) {
+						if (features->type ==
+						    TABLETPC2FG) {
+							/* need to reset back */
+							features->pktlen =
+								WACOM_PKGLEN_TPC2FG;
+							features->device_type =
+								BTN_TOOL_TRIPLETAP;
 							features->y_max =
 								wacom_le16_to_cpu(&report[i + 3]);
 							features->y_phy =
@@ -400,6 +418,11 @@ static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hi
 							i += 4;
 						}
 					} else if (pen) {
+						/* penabled only accepts exact bytes of data */
+						if (features->type ==
+						    TABLETPC2FG)
+							features->pktlen =
+								WACOM_PKGLEN_PENABLED;
 						features->device_type =
 							BTN_TOOL_PEN;
 						features->y_max =
@@ -441,19 +464,20 @@ static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hi
 	return result;
 }
 
-static int wacom_query_tablet_data(struct usb_interface *intf,
-				   struct wacom_features *features)
+static int wacom_reset_report(struct usb_interface *intf,
+			      struct wacom_features *features)
 {
-	unsigned char *rep_data;
-	int limit = 0;
-	int error;
-	int report_id = 2;
+	char *rep_data, limit = 0, report_id = 2;
+	int error = -ENOMEM;
 
 	rep_data = kmalloc(4, GFP_KERNEL);
-	if (!rep_data)
-		return -ENOMEM;
 
-	if (features->type == TABLETPC2FG) {
+	/*
+	 * Ask to report tablet data if it is 2FGT or not a Tablet PC.
+	 * Repeat 3 times since on some systems the first 2 may fail.
+	 */
+
+	if (features->device_type == BTN_TOOL_TRIPLETAP) {
 		do {
 			rep_data[0] = 3;
 			rep_data[1] = 4;
@@ -466,7 +490,8 @@ static int wacom_query_tablet_data(struct usb_interface *intf,
 						       report_id,
 						       rep_data, 3);
 		} while ((error < 0 || rep_data[1] != 4) && limit++ < 3);
-	} else if (features->type != TABLETPC) {
+	} else if ((features->type != TABLETPC) &&
+		   (features->type != TABLETPC2FG)) {
 		do {
 			rep_data[0] = 2;
 			rep_data[1] = 2;
@@ -482,7 +507,44 @@ static int wacom_query_tablet_data(struct usb_interface *intf,
 
 	kfree(rep_data);
 
-	return error < 0 ? error : 0;
+	return error;
+}
+
+static int wacom_retrieve_hid_descriptor(struct usb_interface *intf,
+					 struct wacom_features *features)
+{
+	int error = 0;
+	struct usb_host_interface *interface = intf->cur_altsetting;
+	struct hid_descriptor *hid_desc;
+
+	/* default device to penabled */
+	features->device_type = BTN_TOOL_PEN;
+
+	/* only Tablet PCs need to retrieve the info */
+	if ((features->type != TABLETPC) && (features->type != TABLETPC2FG))
+		goto out;
+
+	if (usb_get_extra_descriptor(interface, HID_DEVICET_HID, &hid_desc)) {
+		if (usb_get_extra_descriptor(&interface->endpoint[0],
+					     HID_DEVICET_REPORT, &hid_desc)) {
+			printk(KERN_ERR
+			       "wacom: can not retrieve extra class descriptor\n");
+			error = 1;
+			goto out;
+		}
+	}
+	error = wacom_parse_hid(intf, hid_desc, features);
+	if (error)
+		goto out;
+
+	/* touch device found but size is not defined. use default */
+	if (features->device_type == BTN_TOOL_DOUBLETAP && !features->x_max) {
+		features->x_max = 1023;
+		features->y_max = 1023;
+	}
+
+out:
+	return error;
 }
 
 static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *id)
@@ -522,10 +584,6 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 	wacom_wac->features = features = get_wacom_feature(id);
 	BUG_ON(features->pktlen > WACOM_PKGLEN_MAX);
 
-	/* default device to penabled */
-	if (features->device_type)
-		features->device_type = BTN_TOOL_PEN;
-
 	input_dev->name = wacom_wac->features->name;
 	wacom->wacom_wac = wacom_wac;
 	usb_to_input_id(dev, &input_dev->id);
@@ -539,28 +597,10 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 
 	endpoint = &intf->cur_altsetting->endpoint[0].desc;
 
-	if (features->type == TABLETPC || features->type == TABLETPC2FG) {
-
-		/* TabletPC need to retrieve the physical and logical maximum
-		   from report descriptor */
-		if (usb_get_extra_descriptor(interface, HID_DEVICET_HID, &hid_desc)) {
-			if (usb_get_extra_descriptor(&interface->endpoint[0],
-						     HID_DEVICET_REPORT, &hid_desc)) {
-				printk("wacom: can not retrive extra class descriptor\n");
-				goto fail2;
-			}
-		}
-		error = wacom_parse_hid(intf, hid_desc, wacom_wac);
-		if (error)
-			goto fail2;
-
-		/* touch device found but size is not defined. use default */
-		if (features->device_type == BTN_TOOL_DOUBLETAP &&
-		    !features->x_max) {
-			features->x_max = 1023;
-			features->y_max = 1023;
-		}
-	}
+	/* Retrieve the physical and logical size for OEM devices */
+	error = wacom_retrieve_hid_descriptor(intf, features);
+	if (error)
+		goto fail2;
 
 	input_dev->evbit[0] |= BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
 	input_dev->keybit[BIT_WORD(BTN_DIGI)] |= BIT_MASK(BTN_TOUCH);
@@ -584,12 +624,8 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 	if (error)
 		goto fail3;
 
-	/*
-	 * Ask the tablet to report tablet data if it is not a Tablet PC.
-	 * Note that if query fails it is not a hard failure.
-	 */
-	if (wacom_wac->features->type != TABLETPC)
-		wacom_query_tablet_data(intf, features);
+	/* switch to wacom mode if needed */
+	wacom_reset_report(intf, features);
 
 	usb_set_intfdata(intf, wacom);
 	return 0;
@@ -631,12 +667,16 @@ static int wacom_suspend(struct usb_interface *intf, pm_message_t message)
 static int wacom_resume(struct usb_interface *intf)
 {
 	struct wacom *wacom = usb_get_intfdata(intf);
+	struct wacom_features *features = wacom->wacom_wac->features;
 	int rv;
 
 	mutex_lock(&wacom->lock);
-	if (wacom->open)
+	if (wacom->open) {
 		rv = usb_submit_urb(wacom->irq, GFP_NOIO);
-	else
+		/* switch to wacom mode if needed */
+		if (!wacom_retrieve_hid_descriptor(intf, features))
+			wacom_reset_report(intf, features);
+	} else
 		rv = 0;
 	mutex_unlock(&wacom->lock);
 
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 1937cf1..781b115 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1,7 +1,7 @@
 /*
  * drivers/input/tablet/wacom_wac.c
  *
- *  USB Wacom Graphire and Wacom Intuos tablet support - Wacom specific code
+ *  USB Wacom tablet support - Wacom specific code
  *
  */
 
@@ -14,14 +14,6 @@
 #include "wacom.h"
 #include "wacom_wac.h"
 
-/* packet length for individual models */
-#define WACOM_PKGLEN_PENPRTN	 7
-#define WACOM_PKGLEN_GRAPHIRE 	 8
-#define WACOM_PKGLEN_BBFUN 	 9
-#define WACOM_PKGLEN_INTUOS 	10
-#define WACOM_PKGLEN_TPC1FG	 5
-#define WACOM_PKGLEN_TPC2FG 	14
-
 static int wacom_penpartner_irq(struct wacom_wac *wacom, void *wcombo)
 {
 	unsigned char *data = wacom->data;
@@ -869,7 +861,6 @@ int wacom_wac_irq(struct wacom_wac *wacom_wac, void *wcombo)
 			return wacom_intuos_irq(wacom_wac, wcombo);
 
 		case TABLETPC:
-
 		case TABLETPC2FG:
 			return wacom_tpc_irq(wacom_wac, wcombo);
 
@@ -916,8 +907,7 @@ void wacom_init_input_dev(struct input_dev *input_dev, struct wacom_wac *wacom_w
 			/* fall through */
 		case TABLETPC:
 			input_dev_tpc(input_dev, wacom_wac);
-			if (wacom_wac->features->device_type ==
-			    BTN_TOOL_DOUBLETAP)
+			if (wacom_wac->features->device_type != BTN_TOOL_PEN)
 				break;  /* no need to process stylus stuff */
 
 			/* fall through */
@@ -988,11 +978,11 @@ static struct wacom_features wacom_features[] = {
 	{ "Wacom Cintiq 21UX",        WACOM_PKGLEN_INTUOS,    87200, 65600, 1023, 63, CINTIQ },
 	{ "Wacom Cintiq 20WSX",       WACOM_PKGLEN_INTUOS,    86680, 54180, 1023, 63, WACOM_BEE },
 	{ "Wacom Cintiq 12WX",        WACOM_PKGLEN_INTUOS,    53020, 33440, 1023, 63, WACOM_BEE },
-	{ "Wacom DTU1931",            WACOM_PKGLEN_GRAPHIRE,  37832, 30305,  511,  0, PL },
-	{ "Wacom ISDv4 90",           WACOM_PKGLEN_GRAPHIRE,  26202, 16325,  255,  0, TABLETPC },
-	{ "Wacom ISDv4 93",           WACOM_PKGLEN_GRAPHIRE,  26202, 16325,  255,  0, TABLETPC },
-	{ "Wacom ISDv4 9A",           WACOM_PKGLEN_GRAPHIRE,  26202, 16325,  255,  0, TABLETPC },
-	{ "Wacom ISDv4 9F",           WACOM_PKGLEN_GRAPHIRE,  26202, 16325,  255,  0, TABLETPC },
+	{ "Wacom DTU1931",            WACOM_PKGLEN_PENABLED,  37832, 30305,  511,  0, PL },
+	{ "Wacom ISDv4 90",           WACOM_PKGLEN_PENABLED,  26202, 16325,  255,  0, TABLETPC },
+	{ "Wacom ISDv4 93",           WACOM_PKGLEN_PENABLED,  26202, 16325,  255,  0, TABLETPC },
+	{ "Wacom ISDv4 9A",           WACOM_PKGLEN_PENABLED,  26202, 16325,  255,  0, TABLETPC },
+	{ "Wacom ISDv4 9F",           WACOM_PKGLEN_PENABLED,  26202, 16325,  255,  0, TABLETPC },
 	{ "Wacom ISDv4 E2",           WACOM_PKGLEN_TPC2FG,    26202, 16325,  255,  0, TABLETPC2FG },
 	{ "Wacom ISDv4 E3",           WACOM_PKGLEN_TPC2FG,    26202, 16325,  255,  0, TABLETPC2FG },
 	{ "Wacom Intuos2 6x8",        WACOM_PKGLEN_INTUOS,    20320, 16240, 1023, 31, INTUOS },
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index 37e0eb3..39c2516 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -12,6 +12,15 @@
 /* maximum packet length for USB devices */
 #define WACOM_PKGLEN_MAX	32
 
+/* packet length for individual models */
+#define WACOM_PKGLEN_PENPRTN	 7
+#define WACOM_PKGLEN_GRAPHIRE	 8
+#define WACOM_PKGLEN_BBFUN 	 9
+#define WACOM_PKGLEN_INTUOS 	10
+#define WACOM_PKGLEN_PENABLED	 8
+#define WACOM_PKGLEN_TPC1FG	 5
+#define WACOM_PKGLEN_TPC2FG 	14
+
 /* device IDs */
 #define STYLUS_DEVICE_ID	0x02
 #define TOUCH_DEVICE_ID		0x03
-- 
1.6.5.2

