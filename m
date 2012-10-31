From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/2] input - wacom: Add support to 0x100 and 0x100
Date: Wed, 31 Oct 2012 10:39:37 -0700
Message-ID: <1351705177-14397-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:64618 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934683Ab2JaRjp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Oct 2012 13:39:45 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so742983dak.19
        for <linux-input@vger.kernel.org>; Wed, 31 Oct 2012 10:39:45 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>, Ping Cheng <pinglinux@gmail.com>

Two new multi-touch tablets.

Signed-off-by: Ping Cheng <pinglinux@gmail.com>
---
 drivers/input/tablet/wacom_sys.c |    5 +++++
 drivers/input/tablet/wacom_wac.c |   22 +++++++++++++++++++---
 drivers/input/tablet/wacom_wac.h |    2 ++
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 67442f4..f92d34f 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -397,6 +397,10 @@ static int wacom_parse_hid(struct usb_interface *intf,
 							features->pktlen = WACOM_PKGLEN_MTOUCH;
 							break;
 
+						case MTTPC:
+							features->pktlen = WACOM_PKGLEN_MTTPC;
+							break;
+
 						case BAMBOO_PT:
 							features->pktlen = WACOM_PKGLEN_BBTOUCH;
 							break;
@@ -453,6 +457,7 @@ static int wacom_parse_hid(struct usb_interface *intf,
 						switch (features->type) {
 						case TABLETPC2FG:
 						case MTSCREEN:
+						case MTTPC:
 							features->y_max =
 								get_unaligned_le16(&report[i + 3]);
 							features->y_phy =
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index aa60101..6e567e3 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -877,6 +877,12 @@ static int wacom_mt_touch(struct wacom_wac *wacom)
 	int i;
 	int current_num_contacts = data[2];
 	int contacts_to_send = 0;
+	int x_offset = 0;
+
+	/* MTTPC does not support Height and Width */
+	if (wacom->features.type == MTTPC) {
+		x_offset = -4;
+	}
 
 	/*
 	 * First packet resets the counter since only the first
@@ -889,7 +895,7 @@ static int wacom_mt_touch(struct wacom_wac *wacom)
 	contacts_to_send = min(5, wacom->num_contacts_left);
 
 	for (i = 0; i < contacts_to_send; i++) {
-		int offset = (WACOM_BYTES_PER_MT_PACKET * i) + 3;
+		int offset = ((WACOM_BYTES_PER_MT_PACKET + x_offset)* i) + 3;
 		bool touch = data[offset] & 0x1;
 		int id = le16_to_cpup((__le16 *)&data[offset + 1]);
 		int slot = find_slot_from_contactid(wacom, id);
@@ -900,8 +906,8 @@ static int wacom_mt_touch(struct wacom_wac *wacom)
 		input_mt_slot(input, slot);
 		input_mt_report_slot_state(input, MT_TOOL_FINGER, touch);
 		if (touch) {
-			int x = le16_to_cpup((__le16 *)&data[offset + 7]);
-			int y = le16_to_cpup((__le16 *)&data[offset + 9]);
+			int x = le16_to_cpup((__le16 *)&data[offset + x_offset + 7]);
+			int y = le16_to_cpup((__le16 *)&data[offset + x_offset + 9]);
 			input_report_abs(input, ABS_MT_POSITION_X, x);
 			input_report_abs(input, ABS_MT_POSITION_Y, y);
 		}
@@ -1336,6 +1342,7 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 	case TABLETPCE:
 	case TABLETPC2FG:
 	case MTSCREEN:
+	case MTTPC:
 		sync = wacom_tpc_irq(wacom_wac, len);
 		break;
 
@@ -1654,6 +1661,7 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 		/* fall through */
 
 	case MTSCREEN:
+	case MTTPC:
 		if (features->device_type == BTN_TOOL_FINGER) {
 			wacom_wac->slots = kmalloc(features->touch_max *
 							sizeof(int),
@@ -2015,6 +2023,12 @@ static const struct wacom_features wacom_features_0xED =
 static const struct wacom_features wacom_features_0xEF =
 	{ "Wacom ISDv4 EF",       WACOM_PKGLEN_GRAPHIRE,  26202, 16325,  255,
 	  0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+static const struct wacom_features wacom_features_0x100 =
+	{ "Wacom ISDv4 100",      WACOM_PKGLEN_MTTPC,     26202, 16325,  255,
+	  0, MTTPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+static const struct wacom_features wacom_features_0x101 =
+	{ "Wacom ISDv4 101",      WACOM_PKGLEN_MTTPC,     26202, 16325,  255,
+	  0, MTTPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x47 =
 	{ "Wacom Intuos2 6x8",    WACOM_PKGLEN_INTUOS,    20320, 16240, 1023,
 	  31, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
@@ -2191,6 +2205,8 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0xEC) },
 	{ USB_DEVICE_WACOM(0xED) },
 	{ USB_DEVICE_WACOM(0xEF) },
+	{ USB_DEVICE_WACOM(0x100) },
+	{ USB_DEVICE_WACOM(0x101) },
 	{ USB_DEVICE_WACOM(0x47) },
 	{ USB_DEVICE_WACOM(0xF4) },
 	{ USB_DEVICE_WACOM(0xF8) },
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index 345f1e7..9396d77 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -26,6 +26,7 @@
 #define WACOM_PKGLEN_BBPEN	10
 #define WACOM_PKGLEN_WIRELESS	32
 #define WACOM_PKGLEN_MTOUCH	62
+#define WACOM_PKGLEN_MTTPC	40
 
 /* wacom data size per MT contact */
 #define WACOM_BYTES_PER_MT_PACKET	11
@@ -88,6 +89,7 @@ enum {
 	TABLETPCE,
 	TABLETPC2FG,
 	MTSCREEN,
+	MTTPC,
 	MAX_TYPE
 };
 
-- 
1.7.9.5

