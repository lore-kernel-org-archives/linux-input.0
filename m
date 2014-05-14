From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v2] Input: wacom: Add support for three new ISDv4 sensors
Date: Wed, 14 May 2014 15:31:52 -0700
Message-ID: <1400106712-14297-1-git-send-email-killertofu@gmail.com>
References: <20140514184624.GH30089@core.coreip.homeip.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:37083 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937AbaENWb4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 May 2014 18:31:56 -0400
Received: by mail-pb0-f47.google.com with SMTP id rp16so184858pbb.20
        for <linux-input@vger.kernel.org>; Wed, 14 May 2014 15:31:56 -0700 (PDT)
In-Reply-To: <20140514184624.GH30089@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pingc@wacom.com, dmitry.torokhov@gmail.com
Cc: Jason Gerecke <killertofu@gmail.com>

This patch adds support for the 0x4004, 0x5000, and 0x5002 sensors found
on what should be the Motion R12, Fujitsu Q704, and Fujitsu T904. These
tablets use a new report ID (3) for their touch packets and a slightly
different HID descriptor format, but are otherwise largely identical in
protocol to the "MTTPC" tablets.

Note:
 * The R12 uses its 0x4004 sensor for touch input only. A pen interface
   is not present in its HID descriptor, though its possible a 0x4004
   may be used for pen input by other tablet PCs in the future.

 * The 0x5002 sensor appears to use a new report ID (8) for its pen
   packets. The other sensors continue to use the traditional report
   ID (2).

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
Changes from v1:
 * None; rebased.

 drivers/input/tablet/wacom_sys.c | 19 +++++++++++++++++++
 drivers/input/tablet/wacom_wac.c | 20 +++++++++++++++++++-
 drivers/input/tablet/wacom_wac.h |  3 +++
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index b16ebef..0056a6d 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -364,6 +364,7 @@ static int wacom_parse_hid(struct usb_interface *intf,
 							break;
 
 						case MTTPC:
+						case MTTPC_B:
 							features->pktlen = WACOM_PKGLEN_MTTPC;
 							break;
 
@@ -395,6 +396,16 @@ static int wacom_parse_hid(struct usb_interface *intf,
 							i += 12;
 							break;
 
+						case MTTPC_B:
+							features->x_max =
+								get_unaligned_le16(&report[i + 3]);
+							features->x_phy =
+								get_unaligned_le16(&report[i + 6]);
+							features->unit = report[i - 5];
+							features->unitExpo = report[i - 3];
+							i += 9;
+							break;
+
 						default:
 							features->x_max =
 								get_unaligned_le16(&report[i + 3]);
@@ -447,6 +458,14 @@ static int wacom_parse_hid(struct usb_interface *intf,
 							i += 12;
 							break;
 
+						case MTTPC_B:
+							features->y_max =
+								get_unaligned_le16(&report[i + 3]);
+							features->y_phy =
+								get_unaligned_le16(&report[i + 6]);
+							i += 9;
+							break;
+
 						default:
 							features->y_max =
 								features->x_max;
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 5baab92..1c779a6 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1022,7 +1022,7 @@ static int wacom_mt_touch(struct wacom_wac *wacom)
 	int x_offset = 0;
 
 	/* MTTPC does not support Height and Width */
-	if (wacom->features.type == MTTPC)
+	if (wacom->features.type == MTTPC || wacom->features.type == MTTPC_B)
 		x_offset = -4;
 
 	/*
@@ -1179,6 +1179,9 @@ static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
 	case WACOM_PKGLEN_TPC2FG:
 		return wacom_tpc_mt_touch(wacom);
 
+	case WACOM_PKGLEN_PENABLED:
+		return wacom_tpc_pen(wacom);
+
 	default:
 		switch (data[0]) {
 		case WACOM_REPORT_TPC1FG:
@@ -1188,6 +1191,7 @@ static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
 			return wacom_tpc_single_touch(wacom, len);
 
 		case WACOM_REPORT_TPCMT:
+		case WACOM_REPORT_TPCMT2:
 			return wacom_mt_touch(wacom);
 
 		case WACOM_REPORT_PENABLED:
@@ -1530,6 +1534,7 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 	case TABLETPC2FG:
 	case MTSCREEN:
 	case MTTPC:
+	case MTTPC_B:
 		sync = wacom_tpc_irq(wacom_wac, len);
 		break;
 
@@ -1871,6 +1876,7 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 
 	case MTSCREEN:
 	case MTTPC:
+	case MTTPC_B:
 	case TABLETPC2FG:
 		if (features->device_type == BTN_TOOL_FINGER) {
 			unsigned int flags = INPUT_MT_DIRECT;
@@ -2308,6 +2314,15 @@ static const struct wacom_features wacom_features_0x116 =
 static const struct wacom_features wacom_features_0x4001 =
 	{ "Wacom ISDv4 4001",      WACOM_PKGLEN_MTTPC,     26202, 16325,  255,
 	  0, MTTPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+static const struct wacom_features wacom_features_0x4004 =
+	{ "Wacom ISDv4 4004",      WACOM_PKGLEN_MTTPC,     11060, 6220,  255,
+	  0, MTTPC_B, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+static const struct wacom_features wacom_features_0x5000 =
+	{ "Wacom ISDv4 5000",      WACOM_PKGLEN_MTTPC,     27848, 15752,  1023,
+	  0, MTTPC_B, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+static const struct wacom_features wacom_features_0x5002 =
+	{ "Wacom ISDv4 5002",      WACOM_PKGLEN_MTTPC,     29576, 16724,  1023,
+	  0, MTTPC_B, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x47 =
 	{ "Wacom Intuos2 6x8",    WACOM_PKGLEN_INTUOS,    20320, 16240, 1023,
 	  31, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
@@ -2530,6 +2545,9 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_DETAILED(0x315, USB_CLASS_HID, 0, 0) },
 	{ USB_DEVICE_DETAILED(0x317, USB_CLASS_HID, 0, 0) },
 	{ USB_DEVICE_WACOM(0x4001) },
+	{ USB_DEVICE_WACOM(0x4004) },
+	{ USB_DEVICE_WACOM(0x5000) },
+	{ USB_DEVICE_WACOM(0x5002) },
 	{ USB_DEVICE_WACOM(0x47) },
 	{ USB_DEVICE_WACOM(0xF4) },
 	{ USB_DEVICE_WACOM(0xF8) },
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index adf73cb..84013a7 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -31,6 +31,7 @@
 #define WACOM_PKGLEN_MTOUCH	62
 #define WACOM_PKGLEN_MTTPC	40
 #define WACOM_PKGLEN_DTUS	68
+#define WACOM_PKGLEN_PENABLED	 8
 
 /* wacom data size per MT contact */
 #define WACOM_BYTES_PER_MT_PACKET	11
@@ -53,6 +54,7 @@
 #define WACOM_REPORT_TPC1FG		6
 #define WACOM_REPORT_TPC2FG		13
 #define WACOM_REPORT_TPCMT		13
+#define WACOM_REPORT_TPCMT2		3
 #define WACOM_REPORT_TPCHID		15
 #define WACOM_REPORT_TPCST		16
 #define WACOM_REPORT_DTUS		17
@@ -106,6 +108,7 @@ enum {
 	TABLETPC2FG,
 	MTSCREEN,
 	MTTPC,
+	MTTPC_B,
 	MAX_TYPE
 };
 
-- 
1.9.2

