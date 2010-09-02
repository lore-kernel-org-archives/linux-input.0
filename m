From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 3/3] input: wacom: Add support for the Bamboo Touch trackpad (rev2)
Date: Thu,  2 Sep 2010 20:18:37 +0200
Message-ID: <1283451517-1711-4-git-send-email-rydberg@euromail.se>
References: <1283451517-1711-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:60039 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753264Ab0IBSTj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 2 Sep 2010 14:19:39 -0400
In-Reply-To: <1283451517-1711-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ping Cheng <pingc@wacom.com>, Chris Bagwell <chris@cnpbagwell.com>, linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

Add support for the Bamboo Touch trackpad, and make it work well with
both the Synaptics X Driver and the Multitouch X Driver. The device
uses MT slots internally, so the choice of protocol is a given.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/input/tablet/wacom_sys.c |    6 +++
 drivers/input/tablet/wacom_wac.c |   83 ++++++++++++++++++++++++++++++++++++++
 drivers/input/tablet/wacom_wac.h |    3 +
 3 files changed, 92 insertions(+), 0 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 76e15d7..ccc2d93 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -203,6 +203,10 @@ static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hi
 								get_unaligned_le16(&report[i + 5]);
 							features->x_max =
 								get_unaligned_le16(&report[i + 8]);
+							if (features->x_max == 480) {
+								features->x_scale = 32;
+								features->pressure_fuzz = 16;
+							}
 							i += 15;
 						} else {
 							features->x_max =
@@ -257,6 +261,8 @@ static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hi
 								get_unaligned_le16(&report[i + 3]);
 							features->y_max =
 								get_unaligned_le16(&report[i + 6]);
+							if (features->y_max == 320)
+								features->y_scale = 32;
 							i += 12;
 						} else {
 							features->y_max =
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index bfe5654..8f93358 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -855,6 +855,57 @@ static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
 	return retval;
 }
 
+static int wacom_bpt_irq(struct wacom_wac *wacom, size_t len)
+{
+	static int trkid;
+	struct wacom_features *features = &wacom->features;
+	struct input_dev *input = wacom->input;
+	unsigned char *data = wacom->data;
+	int sp = 0, sx = 0, sy = 0, count = 0;
+	int i;
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
+			x *= features->x_scale;
+			y *= features->y_scale;
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
+	input_report_key(input, BTN_MIDDLE, (data[1] & 0x04) != 0);
+	input_report_key(input, BTN_4, (data[1] & 0x02) != 0);
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
@@ -900,6 +951,10 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 		sync = wacom_tpc_irq(wacom_wac, len);
 		break;
 
+	case BAMBOO_PT:
+		sync = wacom_bpt_irq(wacom_wac, len);
+		break;
+
 	default:
 		sync = false;
 		break;
@@ -1079,6 +1134,31 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 	case PENPARTNER:
 		__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
 		break;
+
+	case BAMBOO_PT:
+		__clear_bit(ABS_MISC, input_dev->absbit);
+
+		if (features->device_type != BTN_TOOL_TRIPLETAP)
+			break;
+
+		__set_bit(BTN_LEFT, input_dev->keybit);
+		__set_bit(BTN_MIDDLE, input_dev->keybit);
+		__set_bit(BTN_RIGHT, input_dev->keybit);
+		__set_bit(BTN_4, input_dev->keybit);
+
+		__set_bit(BTN_TOOL_FINGER, input_dev->keybit);
+		__set_bit(BTN_TOOL_DOUBLETAP, input_dev->keybit);
+
+		input_mt_create_slots(input_dev, 2);
+		input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0, features->x_max,
+				     features->x_fuzz, 0);
+		input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0, features->y_max,
+				     features->y_fuzz, 0);
+		input_set_abs_params(input_dev, ABS_MT_PRESSURE, 0, features->pressure_max,
+				     features->pressure_fuzz, 0);
+		input_set_abs_params(input_dev, ABS_MT_TRACKING_ID, 0,
+				     MAX_TRACKING_ID, 0, 0);
+		break;
 	}
 }
 
@@ -1216,6 +1296,8 @@ static const struct wacom_features wacom_features_0xE3 =
 	{ "Wacom ISDv4 E3",       WACOM_PKGLEN_TPC2FG,    26202, 16325,  255,  0, TABLETPC2FG };
 static const struct wacom_features wacom_features_0x47 =
 	{ "Wacom Intuos2 6x8",    WACOM_PKGLEN_INTUOS,    20320, 16240, 1023, 31, INTUOS };
+static struct wacom_features wacom_features_0xD0 =
+	{ "Wacom Bamboo 2FG",     WACOM_PKGLEN_BBFUN,     14720,  9200, 1023, 63, BAMBOO_PT };
 
 #define USB_DEVICE_WACOM(prod)					\
 	USB_DEVICE(USB_VENDOR_ID_WACOM, prod),			\
@@ -1280,6 +1362,7 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0xC6) },
 	{ USB_DEVICE_WACOM(0xC7) },
 	{ USB_DEVICE_WACOM(0xCE) },
+	{ USB_DEVICE_WACOM(0xD0) },
 	{ USB_DEVICE_WACOM(0xF0) },
 	{ USB_DEVICE_WACOM(0xCC) },
 	{ USB_DEVICE_WACOM(0x90) },
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index ff22e34..d070417 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -38,6 +38,9 @@
 #define WACOM_REPORT_TPC1FG		6
 #define WACOM_REPORT_TPC2FG		13
 
+/* largest reported tracking id */
+#define MAX_TRACKING_ID			0xfff
+
 enum {
 	PENPARTNER = 0,
 	GRAPHIRE,
-- 
1.7.1

