From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH] input: Add support for the Bamboo Touch trackpad
Date: Sun, 22 Aug 2010 16:10:41 +0200
Message-ID: <1282486241-8855-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:56172 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752093Ab0HVOLE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 22 Aug 2010 10:11:04 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ping Cheng <pingc@wacom.com>, linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

Add support for the Bamboo Touch trackpad, and make it work well with
both the Synaptics X Driver and the Multitouch X Driver. The device
uses MT slots internally, so the choice of protocol is a given.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
Hi Dmitry, Ping,

Here is a small patch which adds trackpad support for the Bamboo Touch. There are a couple if things to discuss:

1) It uses the MT slot protocol
2) It creates two input devices, but only one is useful
3) It works well with the synaptics and multitouch X drivers
4) It does not work well with the wacom X driver (!)

In particular the last point may seem upsetting, but my reasoning is
simply that the wacom X driver really supports tablets and not
trackpads. I might be convinced otherwise. :-)

Cheers,
Henrik

 drivers/input/tablet/wacom_wac.c |   76 ++++++++++++++++++++++++++++++++++++++
 drivers/input/tablet/wacom_wac.h |    6 +++
 2 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 40d77ba..61dbd5d 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -855,6 +855,52 @@ static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
 	return retval;
 }
 
+static int wacom_bbt_irq(struct wacom_wac *wacom, size_t len)
+{
+	static int trkid;
+	struct input_dev *input = wacom->input;
+	unsigned char *data = wacom->data;
+	int i, sp = 0, sx = 0, sy = 0, count = 0;
+
+	if (len != WACOM_PKGLEN_BBTOUCH)
+		return 0;
+
+	for (i = 0; i < 2; i++) {
+		int p = data[9 * i + 2];
+		input_mt_slot(input, i);
+		if (p) {
+			int x = get_unaligned_be16(&data[9 * i + 3]) & 0x7ff;
+			int y = get_unaligned_be16(&data[9 * i + 5]) & 0x7ff;
+			input_report_abs(input, ABS_MT_PRESSURE, p);
+			input_report_abs(input, ABS_MT_POSITION_X, x);
+			input_report_abs(input, ABS_MT_POSITION_Y, y);
+			if (wacom->id[i] < 0)
+				wacom->id[i] = trkid++ & MAX_TRACKING_ID;
+			if (!count++)
+				sp = p, sx = x, sy = y;
+		} else {
+			wacom->id[i] = -1;
+		}
+		input_report_abs(input, ABS_MT_TRACKING_ID, wacom->id[i]);
+	}
+
+	input_report_key(input, BTN_TOUCH, count > 0);
+	input_report_key(input, BTN_TOOL_FINGER, count == 1);
+	input_report_key(input, BTN_TOOL_DOUBLETAP, count == 2);
+
+	input_report_abs(input, ABS_PRESSURE, sp);
+	input_report_abs(input, ABS_X, sx);
+	input_report_abs(input, ABS_Y, sy);
+
+	input_report_key(input, BTN_LEFT, (data[1] & 0x08) != 0);
+	input_report_key(input, BTN_MIDDLE, (data[1] & 0x06) != 0);
+	input_report_key(input, BTN_RIGHT, (data[1] & 0x01) != 0);
+
+	input_sync(input);
+
+	return 0;
+}
+
 void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 {
 	bool sync;
@@ -900,6 +946,10 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 		sync = wacom_tpc_irq(wacom_wac, len);
 		break;
 
+	case BAMBOO_TOUCH:
+		sync = wacom_bbt_irq(wacom_wac, len);
+		break;
+
 	default:
 		sync = false;
 		break;
@@ -1076,6 +1126,22 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 	case PENPARTNER:
 		__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
 		break;
+
+	case BAMBOO_TOUCH:
+		__clear_bit(ABS_MISC, input_dev->absbit);
+		__set_bit(BTN_LEFT, input_dev->keybit);
+		__set_bit(BTN_MIDDLE, input_dev->keybit);
+		__set_bit(BTN_RIGHT, input_dev->keybit);
+
+		__set_bit(BTN_TOOL_FINGER, input_dev->keybit);
+		__set_bit(BTN_TOOL_DOUBLETAP, input_dev->keybit);
+
+		input_mt_create_slots(input_dev, 2);
+		input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0, features->x_max, 4, 0);
+		input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0, features->y_max, 4, 0);
+		input_set_abs_params(input_dev, ABS_MT_PRESSURE, 0, features->pressure_max, 16, 0);
+		input_set_abs_params(input_dev, ABS_MT_TRACKING_ID, 0, MAX_TRACKING_ID, 0, 0);
+		break;
 	}
 }
 
@@ -1213,11 +1279,19 @@ static const struct wacom_features wacom_features_0xE3 =
 	{ "Wacom ISDv4 E3",       WACOM_PKGLEN_TPC2FG,    26202, 16325,  255,  0, TABLETPC2FG };
 static const struct wacom_features wacom_features_0x47 =
 	{ "Wacom Intuos2 6x8",    WACOM_PKGLEN_INTUOS,    20320, 16240, 1023, 31, INTUOS };
+static const struct wacom_features wacom_features_0xD0_0 =
+	{ "Wacom Bamboo Touch",   WACOM_PKGLEN_BBTOUCH,   480,  320, 255, 0, BAMBOO_TOUCH };
+static const struct wacom_features wacom_features_0xD0_2 =
+	{ "Wacom Bamboo Boot",   WACOM_PKGLEN_BBFUN,     480,  320, 255, 0, BAMBOO_BOOT };
 
 #define USB_DEVICE_WACOM(prod)					\
 	USB_DEVICE(USB_VENDOR_ID_WACOM, prod),			\
 	.driver_info = (kernel_ulong_t)&wacom_features_##prod
 
+#define USB_DEVICE_WACOM_PROTO(prod, pr)				\
+	USB_DEVICE_INTERFACE_PROTOCOL(USB_VENDOR_ID_WACOM, prod, pr),	\
+	.driver_info = (kernel_ulong_t)&wacom_features_##prod##_##pr
+
 const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x00) },
 	{ USB_DEVICE_WACOM(0x10) },
@@ -1277,6 +1351,8 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0xC6) },
 	{ USB_DEVICE_WACOM(0xC7) },
 	{ USB_DEVICE_WACOM(0xCE) },
+	{ USB_DEVICE_WACOM_PROTO(0xD0, 0) },
+	{ USB_DEVICE_WACOM_PROTO(0xD0, 2) },
 	{ USB_DEVICE_WACOM(0xF0) },
 	{ USB_DEVICE_WACOM(0xCC) },
 	{ USB_DEVICE_WACOM(0x90) },
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index 99e1a54..770909c 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -21,6 +21,7 @@
 #define WACOM_PKGLEN_INTUOS	10
 #define WACOM_PKGLEN_TPC1FG	 5
 #define WACOM_PKGLEN_TPC2FG	14
+#define WACOM_PKGLEN_BBTOUCH	20
 
 /* device IDs */
 #define STYLUS_DEVICE_ID	0x02
@@ -37,6 +38,9 @@
 #define WACOM_REPORT_TPC1FG		6
 #define WACOM_REPORT_TPC2FG		13
 
+/* largest reported tracking id */
+#define MAX_TRACKING_ID			0xfff
+
 enum {
 	PENPARTNER = 0,
 	GRAPHIRE,
@@ -57,6 +61,8 @@ enum {
 	WACOM_MO,
 	TABLETPC,
 	TABLETPC2FG,
+	BAMBOO_TOUCH,
+	BAMBOO_BOOT,
 	MAX_TYPE
 };
 
-- 
1.7.1

