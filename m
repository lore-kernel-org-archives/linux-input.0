From: chris@cnpbagwell.com
Subject: [PATCH v3 7/7] input: wacom - add 0xE5 (MT device) support
Date: Sat, 11 Feb 2012 15:55:34 -0600
Message-ID: <1328997334-24140-8-git-send-email-chris@cnpbagwell.com>
References: <1328997334-24140-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:61504 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752446Ab2BKVzv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 11 Feb 2012 16:55:51 -0500
Received: by mail-tul01m020-f174.google.com with SMTP id va7so5156955obc.19
        for <linux-input@vger.kernel.org>; Sat, 11 Feb 2012 13:55:51 -0800 (PST)
In-Reply-To: <1328997334-24140-1-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Ping Cheng <pinglinux@gmail.com>
Cc: Ping Cheng <pingc@wacom.com>

From: Ping Cheng <pinglinux@gmail.com>

And getting rid of duplicate code since X/Y will always be present.

Tested-by: Chris Bagwell <chris@cnpbagwell.com>
Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>
Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_sys.c |   57 ++++++++++++------------
 drivers/input/tablet/wacom_wac.c |   89 ++++++++++++++++++++++++++++++++++++-
 drivers/input/tablet/wacom_wac.h |    8 +++
 3 files changed, 123 insertions(+), 31 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 950af65..9441589 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -307,6 +307,10 @@ static int wacom_parse_hid(struct usb_interface *intf,
 							/* need to reset back */
 							features->pktlen = WACOM_PKGLEN_TPC2FG;
 						}
+
+						if (features->type == MTSCREEN)
+							features->pktlen = WACOM_PKGLEN_MTOUCH;
+
 						if (features->type == BAMBOO_PT) {
 							/* need to reset back */
 							features->pktlen = WACOM_PKGLEN_BBTOUCH;
@@ -339,18 +343,15 @@ static int wacom_parse_hid(struct usb_interface *intf,
 			case HID_USAGE_Y:
 				if (usage == WCM_DESKTOP) {
 					if (finger) {
-						features->device_type = BTN_TOOL_FINGER;
-						if (features->type == TABLETPC2FG) {
-							/* need to reset back */
-							features->pktlen = WACOM_PKGLEN_TPC2FG;
+						int type = features->type;
+
+						if (type == TABLETPC2FG || type == MTSCREEN) {
 							features->y_max =
 								get_unaligned_le16(&report[i + 3]);
 							features->y_phy =
 								get_unaligned_le16(&report[i + 6]);
 							i += 7;
-						} else if (features->type == BAMBOO_PT) {
-							/* need to reset back */
-							features->pktlen = WACOM_PKGLEN_BBTOUCH;
+						} else if (type == BAMBOO_PT) {
 							features->y_phy =
 								get_unaligned_le16(&report[i + 3]);
 							features->y_max =
@@ -364,10 +365,6 @@ static int wacom_parse_hid(struct usb_interface *intf,
 							i += 4;
 						}
 					} else if (pen) {
-						/* penabled only accepts exact bytes of data */
-						if (features->type == TABLETPC2FG)
-							features->pktlen = WACOM_PKGLEN_GRAPHIRE;
-						features->device_type = BTN_TOOL_PEN;
 						features->y_max =
 							get_unaligned_le16(&report[i + 3]);
 						i += 4;
@@ -430,25 +427,29 @@ static int wacom_query_tablet_data(struct usb_interface *intf, struct wacom_feat
 	if (!rep_data)
 		return error;
 
-	/* ask to report tablet data if it is MT Tablet PC or
-	 * not a Tablet PC */
-	if (features->type == TABLETPC2FG) {
-		do {
-			rep_data[0] = 3;
-			rep_data[1] = 4;
-			rep_data[2] = 0;
-			rep_data[3] = 0;
-			report_id = 3;
-			error = wacom_set_report(intf, WAC_HID_FEATURE_REPORT,
+	/* ask to report Wacom data */
+	if (features->device_type == BTN_TOOL_FINGER) {
+		/* if it is an MT Tablet PC touch */
+		if ((features->type == TABLETPC2FG) ||
+		    (features->type == MTSCREEN)) {
+			do {
+				rep_data[0] = 3;
+				rep_data[1] = 4;
+				rep_data[2] = 0;
+				rep_data[3] = 0;
+				report_id = 3;
+				error = wacom_set_report(intf,
+						 WAC_HID_FEATURE_REPORT,
 						 report_id, rep_data, 4, 1);
-			if (error >= 0)
-				error = wacom_get_report(intf,
+				if (error >= 0)
+					error = wacom_get_report(intf,
 						WAC_HID_FEATURE_REPORT,
 						report_id, rep_data, 4, 1);
-		} while ((error < 0 || rep_data[1] != 4) && limit++ < WAC_MSG_RETRIES);
+			} while ((error < 0 || rep_data[1] != 4) &&
+				 limit++ < WAC_MSG_RETRIES);
+		}
 	} else if (features->type != TABLETPC &&
-		   features->type != BAMBOO_WIRELESS &&
-		   features->device_type == BTN_TOOL_PEN) {
+		   features->type != BAMBOO_WIRELESS) {
 		do {
 			rep_data[0] = 2;
 			rep_data[1] = 2;
@@ -495,9 +496,9 @@ static int wacom_retrieve_hid_descriptor(struct usb_interface *intf,
 		}
 	}
 
-	/* only Tablet PCs and Bamboo P&T need to retrieve the info */
+	/* only devices that support touch need to retrieve the info */
 	if ((features->type != TABLETPC) && (features->type != TABLETPC2FG) &&
-	    (features->type != BAMBOO_PT))
+	    (features->type != BAMBOO_PT) && (features->type != MTSCREEN))
 		goto out;
 
 	if (usb_get_extra_descriptor(interface, HID_DEVICET_HID, &hid_desc)) {
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index c8eede1..99d7e4e 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -729,6 +729,75 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 	return 1;
 }
 
+static int wacom_mt_touch(struct wacom_wac *wacom)
+{
+	struct wacom_features *features = &wacom->features;
+	struct input_dev *input = wacom->input;
+	char *data = wacom->data;
+	struct input_mt_slot *mt;
+	int i, id = -1, j = 0, k = 4;
+	int x = 0, y = 0;
+	int current_num_contacts = data[2];
+	int contacts_to_send = 0;
+	bool touch = false;
+
+	/* reset the counter by the first packet since only the first
+	 * packet in series will have non-zero current_num_contacts
+	 */
+	if (current_num_contacts) {
+		features->num_contacts = current_num_contacts;
+		features->num_contacts_left = current_num_contacts;
+	}
+
+	/* There are at most 5 contacts per packet */
+	contacts_to_send = min(5, (int)features->num_contacts_left);
+
+	for (i = 0; i < contacts_to_send; i++) {
+		id = le16_to_cpup((__le16 *)&data[k]);
+
+		/* is there an existing slot for this contact? */
+		for (j = 0; j < features->touch_max; j++) {
+			mt = &input->mt[j];
+			if (input_mt_get_value(mt, ABS_MT_TRACKING_ID) == id )
+				break;
+		}
+
+		/* no. then find an unused slot to fill */
+		if (j >= features->touch_max) {
+			for (j = 0; j < features->touch_max; j++) {
+				mt = &input->mt[j];
+				if (input_mt_get_value(mt, ABS_MT_TRACKING_ID) == -1 )
+					break;
+			}
+		}
+
+		touch = data[k - 1] & 0x1;
+		input_mt_slot(input, j);
+		if (touch) {
+			x = le16_to_cpup((__le16 *)&data[k + 6]);
+			y = le16_to_cpup((__le16 *)&data[k + 8]);
+
+			input_report_abs(input, ABS_MT_POSITION_X, x);
+			input_report_abs(input, ABS_MT_POSITION_Y, y);
+		} else
+			id = -1;
+
+		/* keep the id from firmware since we need
+		 * it to process future events
+		 */
+		input_report_abs(input, ABS_MT_TRACKING_ID, id);
+
+		k += WACOM_BYTES_PER_MT_PACKET;
+	}
+
+	input_mt_report_pointer_emulation(input, true);
+
+	features->num_contacts_left -= contacts_to_send;
+	if (features->num_contacts_left < 0)
+		features->num_contacts_left = 0;
+	return 1;
+}
+
 static int wacom_tpc_mt_touch(struct wacom_wac *wacom)
 {
 	struct input_dev *input = wacom->input;
@@ -767,6 +836,10 @@ static int wacom_tpc_single_touch(struct wacom_wac *wacom, size_t len)
 	bool prox;
 	int x = 0, y = 0;
 
+	if ((wacom->features.touch_max > 1) ||
+				(len > WACOM_PKGLEN_TPC2FG))
+		return 0;
+
 	if (!wacom->shared->stylus_in_proximity) {
 		if (len == WACOM_PKGLEN_TPC1FG) {
 			prox = data[0] & 0x01;
@@ -835,10 +908,10 @@ static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
 
 	switch (len) {
 	case WACOM_PKGLEN_TPC1FG:
-		 return wacom_tpc_single_touch(wacom, len);
+		return wacom_tpc_single_touch(wacom, len);
 
 	case WACOM_PKGLEN_TPC2FG:
- 		return wacom_tpc_mt_touch(wacom);
+		return wacom_tpc_mt_touch(wacom);
 
 	default:
 		switch (data[0]) {
@@ -847,6 +920,9 @@ static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
 		case WACOM_REPORT_TPCST:
 			return wacom_tpc_single_touch(wacom, len);
 
+		case WACOM_REPORT_TPCMT:
+			return wacom_mt_touch(wacom);
+
 		case WACOM_REPORT_PENABLED:
 			return wacom_tpc_pen(wacom);
 		}
@@ -1117,6 +1193,7 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 
 	case TABLETPC:
 	case TABLETPC2FG:
+	case MTSCREEN:
 		sync = wacom_tpc_irq(wacom_wac, len);
 		break;
 
@@ -1189,7 +1266,8 @@ void wacom_setup_device_quirks(struct wacom_features *features)
 
 	/* these device have multiple inputs */
 	if (features->type == TABLETPC || features->type == TABLETPC2FG ||
-	    features->type == BAMBOO_PT || features->type == BAMBOO_WIRELESS)
+	    features->type == BAMBOO_PT || features->type == BAMBOO_WIRELESS ||
+	    features->type == MTSCREEN)
 		features->quirks |= WACOM_QUIRK_MULTI_INPUT;
 
 	/* quirk for bamboo touch with 2 low res touches */
@@ -1373,6 +1451,7 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 		break;
 
 	case TABLETPC2FG:
+	case MTSCREEN:
 		if (features->device_type == BTN_TOOL_FINGER) {
 
 			input_mt_init_slots(input_dev, features->touch_max);
@@ -1676,6 +1755,9 @@ static const struct wacom_features wacom_features_0xE3 =
 	{ "Wacom ISDv4 E3",       WACOM_PKGLEN_TPC2FG,    26202, 16325,  255,
 	  0, TABLETPC2FG, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
 	  .touch_max = 2 };
+static const struct wacom_features wacom_features_0xE5 =
+	{ "Wacom ISDv4 E5",       WACOM_PKGLEN_MTOUCH,    26202, 16325,  255,
+	  0, MTSCREEN, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xE6 =
 	{ "Wacom ISDv4 E6",       WACOM_PKGLEN_TPC2FG,    27760, 15694,  255,
 	  0, TABLETPC2FG, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
@@ -1846,6 +1928,7 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x9F) },
 	{ USB_DEVICE_WACOM(0xE2) },
 	{ USB_DEVICE_WACOM(0xE3) },
+	{ USB_DEVICE_WACOM(0xE5) },
 	{ USB_DEVICE_WACOM(0xE6) },
 	{ USB_DEVICE_WACOM(0x47) },
 	{ USB_DEVICE_WACOM(0xF4) },
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index a0a5b1a..8174a79 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -25,6 +25,10 @@
 #define WACOM_PKGLEN_BBTOUCH3	64
 #define WACOM_PKGLEN_BBPEN	10
 #define WACOM_PKGLEN_WIRELESS	32
+#define WACOM_PKGLEN_MTOUCH	62
+
+/* wacom data size per MT contact */
+#define WACOM_BYTES_PER_MT_PACKET	11
 
 /* device IDs */
 #define STYLUS_DEVICE_ID	0x02
@@ -40,6 +44,7 @@
 #define WACOM_REPORT_INTUOSPAD		12
 #define WACOM_REPORT_TPC1FG		6
 #define WACOM_REPORT_TPC2FG		13
+#define WACOM_REPORT_TPCMT		13
 #define WACOM_REPORT_TPCHID		15
 #define WACOM_REPORT_TPCST		16
 
@@ -72,6 +77,7 @@ enum {
 	WACOM_MO,
 	TABLETPC,
 	TABLETPC2FG,
+	MTSCREEN,
 	MAX_TYPE
 };
 
@@ -96,6 +102,8 @@ struct wacom_features {
 	int distance_fuzz;
 	unsigned quirks;
 	unsigned touch_max;
+	unsigned num_contacts;
+	unsigned num_contacts_left;
 };
 
 struct wacom_shared {
-- 
1.7.7.6

