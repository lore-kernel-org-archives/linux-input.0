From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 5/5] Input: wacom - Add touch sensor support for Cintiq 24HD touch
Date: Thu,  6 Sep 2012 15:53:30 -0700
Message-ID: <1346972010-1330-5-git-send-email-killertofu@gmail.com>
References: <1346972010-1330-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51702 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754885Ab2IFWxt (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Sep 2012 18:53:49 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so3164584pbb.19
        for <linux-input@vger.kernel.org>; Thu, 06 Sep 2012 15:53:48 -0700 (PDT)
In-Reply-To: <1346972010-1330-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, pinglinux@gmail.com, chris@cnpbagwell.com
Cc: Jason Gerecke <killertofu@gmail.com>

Decode multitouch reports from the touch sensor of the Cintiq
24HD touch.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/input/tablet/wacom_sys.c | 19 ++++++++-
 drivers/input/tablet/wacom_wac.c | 84 +++++++++++++++++++++++++++++++++++++++-
 drivers/input/tablet/wacom_wac.h |  3 ++
 3 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index b34a92b..e99f33f 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -389,7 +389,7 @@ static int wacom_parse_hid(struct usb_interface *intf,
 							features->pktlen = WACOM_PKGLEN_TPC2FG;
 						}
 
-						if (features->type == MTSCREEN)
+						if (features->type == MTSCREEN || WACOM_24HDT)
 							features->pktlen = WACOM_PKGLEN_MTOUCH;
 
 						if (features->type == BAMBOO_PT) {
@@ -400,6 +400,14 @@ static int wacom_parse_hid(struct usb_interface *intf,
 							features->x_max =
 								get_unaligned_le16(&report[i + 8]);
 							i += 15;
+						} else if (features->type == WACOM_24HDT) {
+							features->x_max =
+								get_unaligned_le16(&report[i + 3]);
+							features->x_phy =
+								get_unaligned_le16(&report[i + 8]);
+							features->unit = report[i - 1];
+							features->unitExpo = report[i - 3];
+							i += 12;
 						} else {
 							features->x_max =
 								get_unaligned_le16(&report[i + 3]);
@@ -432,6 +440,12 @@ static int wacom_parse_hid(struct usb_interface *intf,
 							features->y_phy =
 								get_unaligned_le16(&report[i + 6]);
 							i += 7;
+						} else if (type == WACOM_24HDT) {
+							features->y_max =
+								get_unaligned_le16(&report[i + 3]);
+							features->y_phy =
+								get_unaligned_le16(&report[i - 2]);
+							i += 7;
 						} else if (type == BAMBOO_PT) {
 							features->y_phy =
 								get_unaligned_le16(&report[i + 3]);
@@ -539,6 +553,9 @@ static int wacom_query_tablet_data(struct usb_interface *intf, struct wacom_feat
 			/* MT Tablet PC touch */
 			return wacom_set_device_mode(intf, 3, 4, 4);
 		}
+		else if (features->type == WACOM_24HDT) {
+			return wacom_set_device_mode(intf, 18, 3, 2);
+		}
 	} else if (features->device_type == BTN_TOOL_PEN) {
 		if (features->type <= BAMBOO_PT && features->type != WIRELESS) {
 			return wacom_set_device_mode(intf, 2, 2, 2);
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 9f52ba0..da9adee 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -801,6 +801,69 @@ static int find_slot_from_contactid(struct wacom_wac *wacom, int contactid)
 	return -1;
 }
 
+static int int_dist(int x1, int y1, int x2, int y2)
+{
+	int x = x2 - x1;
+	int y = y2 - y1;
+	return int_sqrt(x*x + y*y);
+}
+
+static int wacom_24hdt_irq(struct wacom_wac *wacom)
+{
+	struct input_dev *input = wacom->input;
+	char *data = wacom->data;
+	int i;
+	int current_num_contacts = data[61];
+	int contacts_to_send = 0;
+
+	/*
+	 * First packet resets the counter since only the first
+	 * packet in series will have non-zero current_num_contacts.
+	 */
+	if (current_num_contacts)
+		wacom->num_contacts_left = current_num_contacts;
+
+	/* There are at most 4 contacts per packet */
+	contacts_to_send = min(4, wacom->num_contacts_left);
+
+	for (i = 0; i < contacts_to_send; i++) {
+		int offset = (WACOM_BYTES_PER_24HDT_PACKET * i) + 1;
+		bool touch = data[offset] & 0x1 && !wacom->shared->stylus_in_proximity;
+		int id = data[offset + 1];
+		int slot = find_slot_from_contactid(wacom, id);
+
+		if (slot < 0)
+			continue;
+		input_mt_slot(input, slot);
+		input_mt_report_slot_state(input, MT_TOOL_FINGER, touch);
+
+		if (touch) {
+			int t_x = le16_to_cpup((__le16 *)&data[offset + 2]);
+			int c_x = le16_to_cpup((__le16 *)&data[offset + 4]);
+			int t_y = le16_to_cpup((__le16 *)&data[offset + 6]);
+			int c_y = le16_to_cpup((__le16 *)&data[offset + 8]);
+			int w = le16_to_cpup((__le16 *)&data[offset + 10]);
+			int h = le16_to_cpup((__le16 *)&data[offset + 12]);
+
+			input_report_abs(input, ABS_MT_POSITION_X, t_x);
+			input_report_abs(input, ABS_MT_POSITION_Y, t_y);
+			input_report_abs(input, ABS_MT_TOUCH_MAJOR, min(w,h));
+			input_report_abs(input, ABS_MT_WIDTH_MAJOR, min(w, h) + int_dist(t_x, t_y, c_x, c_y));
+			input_report_abs(input, ABS_MT_WIDTH_MINOR, min(w, h));
+			input_report_abs(input, ABS_MT_ORIENTATION, w > h);
+		}
+		wacom->slots[slot] = touch ? id : -1;
+	}
+
+	input_mt_report_pointer_emulation(input, true);
+
+	wacom->num_contacts_left -= contacts_to_send;
+	if (wacom->num_contacts_left <= 0)
+		wacom->num_contacts_left = 0;
+
+	return 1;
+}
+
 static int wacom_mt_touch(struct wacom_wac *wacom)
 {
 	struct input_dev *input = wacom->input;
@@ -1242,6 +1305,10 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 		sync = wacom_intuos_irq(wacom_wac);
 		break;
 
+	case WACOM_24HDT:
+		sync = wacom_24hdt_irq(wacom_wac);
+		break;
+
 	case INTUOS5S:
 	case INTUOS5:
 	case INTUOS5L:
@@ -1561,6 +1628,15 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
 		break;
 
+	case WACOM_24HDT:
+		if (features->device_type == BTN_TOOL_FINGER) {
+			input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, features->x_max, 0, 0);
+			input_set_abs_params(input_dev, ABS_MT_WIDTH_MAJOR, 0, features->x_max, 0, 0);
+			input_set_abs_params(input_dev, ABS_MT_WIDTH_MINOR, 0, features->y_max, 0, 0);
+			input_set_abs_params(input_dev, ABS_MT_ORIENTATION, 0, 1, 0, 0);
+		}
+		/* fall through */
+
 	case MTSCREEN:
 		if (features->device_type == BTN_TOOL_FINGER) {
 			wacom_wac->slots = kmalloc(features->touch_max *
@@ -1852,8 +1928,11 @@ static const struct wacom_features wacom_features_0xF4 =
 	{ "Wacom Cintiq 24HD",       WACOM_PKGLEN_INTUOS,   104480, 65600, 2047,
 	  63, WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
 static const struct wacom_features wacom_features_0xF8 =
-	{ "Wacom Cintiq 24HD touch", WACOM_PKGLEN_INTUOS,   104480, 65600, 2047,
-	  63, WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+	{ "Wacom Cintiq 24HD touch", WACOM_PKGLEN_INTUOS,   104480, 65600, 2047, /* Pen */
+	  63, WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, .oVid = USB_VENDOR_ID_WACOM, .oPid = 0xf6 };
+static const struct wacom_features wacom_features_0xF6 =
+	{ "Wacom Cintiq 24HD touch", .type = WACOM_24HDT, /* Touch */
+	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0xf8, .touch_max = 10 };
 static const struct wacom_features wacom_features_0x3F =
 	{ "Wacom Cintiq 21UX",    WACOM_PKGLEN_INTUOS,    87200, 65600, 1023,
 	  63, CINTIQ, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
@@ -2096,6 +2175,7 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x47) },
 	{ USB_DEVICE_WACOM(0xF4) },
 	{ USB_DEVICE_WACOM(0xF8) },
+	{ USB_DEVICE_WACOM(0xF6) },
 	{ USB_DEVICE_WACOM(0xFA) },
 	{ USB_DEVICE_LENOVO(0x6004) },
 	{ }
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index 3f926ec..345f1e7 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -29,6 +29,7 @@
 
 /* wacom data size per MT contact */
 #define WACOM_BYTES_PER_MT_PACKET	11
+#define WACOM_BYTES_PER_24HDT_PACKET	14
 
 /* device IDs */
 #define STYLUS_DEVICE_ID	0x02
@@ -49,6 +50,7 @@
 #define WACOM_REPORT_TPCHID		15
 #define WACOM_REPORT_TPCST		16
 #define WACOM_REPORT_TPC1FGE		18
+#define WACOM_REPORT_24HDT		1
 
 /* device quirks */
 #define WACOM_QUIRK_MULTI_INPUT		0x0001
@@ -81,6 +83,7 @@ enum {
 	WACOM_MO,
 	WIRELESS,
 	BAMBOO_PT,
+	WACOM_24HDT,
 	TABLETPC,   /* add new TPC below */
 	TABLETPCE,
 	TABLETPC2FG,
-- 
1.7.12

