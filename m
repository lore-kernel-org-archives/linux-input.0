From: chris@cnpbagwell.com
Subject: [PATCH 1/2] input : wacom - retrieve maximum number of touch points
Date: Tue, 31 Jan 2012 22:03:50 -0600
Message-ID: <1328069031-16873-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:34119 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752570Ab2BAED5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Jan 2012 23:03:57 -0500
Received: by obcva7 with SMTP id va7so766754obc.19
        for <linux-input@vger.kernel.org>; Tue, 31 Jan 2012 20:03:57 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: Ping Cheng <pinglinux@gmail.com>, Chris Bagwell <chris@cnpbagwell.com>, Ping Cheng <pingc@wacom.com>

From: Ping Cheng <pinglinux@gmail.com>

>From the HID usage table when it is supported.

Tested-by: Chris Bagwell <chris@cnpbagwell.com>
Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
Signed-off-by: Ping Cheng <pingc@wacom.com>
---

These two patches were originally in a set of 4 from Ping.
2 of those 4 have already been committed to next branch.

The change between this version and Ping's last version is
making use of features to set the new touch_max value.
The 2nd patch is unmodified.

 drivers/input/tablet/wacom_sys.c |   26 +++++++++++++++++-
 drivers/input/tablet/wacom_wac.c |   55 +++++++++++++++++++++++--------------
 drivers/input/tablet/wacom_wac.h |    1 +
 3 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index c9588ee..5004a75 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -28,6 +28,7 @@
 #define HID_USAGE_Y_TILT		0x3e
 #define HID_USAGE_FINGER		0x22
 #define HID_USAGE_STYLUS		0x20
+#define HID_USAGE_CONTACTMAX		0x55
 #define HID_COLLECTION			0xa1
 #define HID_COLLECTION_LOGICAL		0x02
 #define HID_COLLECTION_END		0xc0
@@ -196,6 +197,24 @@ static int wacom_parse_logical_collection(unsigned char *report,
 	return length;
 }
 
+static void wacom_retrieve_report_data(struct usb_interface *intf,
+				       struct wacom_features *features)
+{
+	int result = 0;
+	unsigned char *rep_data;
+
+	rep_data = kmalloc(2, GFP_KERNEL);
+	if (!rep_data)
+		return;
+
+	rep_data[0] = 12;
+	result = wacom_get_report(intf, WAC_HID_FEATURE_REPORT,
+		 rep_data[0], rep_data, 2, WAC_MSG_RETRIES);
+
+	if ((result >= 0) && (rep_data[1] > 2))
+		features->touch_max = rep_data[1];
+}
+
 /*
  * Interface Descriptor of wacom devices can be incomplete and
  * inconsistent so wacom_features table is used to store stylus
@@ -369,6 +388,11 @@ static int wacom_parse_hid(struct usb_interface *intf,
 				pen = 1;
 				i++;
 				break;
+
+			case HID_USAGE_CONTACTMAX:
+				wacom_retrieve_report_data(intf, features);
+				i++;
+				break;
 			}
 			break;
 
@@ -873,7 +897,7 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 
 	endpoint = &intf->cur_altsetting->endpoint[0].desc;
 
-	/* Retrieve the physical and logical size for OEM devices */
+	/* Retrieve the physical and logical size for touch devices */
 	error = wacom_retrieve_hid_descriptor(intf, features);
 	if (error)
 		goto fail3;
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 9283507..c56d577 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -830,7 +830,8 @@ static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
 {
 	char *data = wacom->data;
 
-	dbg("wacom_tpc_irq: received report #%d", data[0]);
+	dbg("wacom_tpc_irq: received report #%d with %d contacts",
+	     data[0], wacom->features.touch_max);
 
 	switch (len) {
 	case WACOM_PKGLEN_TPC1FG:
@@ -1331,7 +1332,7 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 	case TABLETPC2FG:
 		if (features->device_type == BTN_TOOL_FINGER) {
 
-			input_mt_init_slots(input_dev, 2);
+			input_mt_init_slots(input_dev, features->touch_max);
 			input_set_abs_params(input_dev, ABS_MT_TOOL_TYPE,
 					0, MT_TOOL_MAX, 0, 0);
 			input_set_abs_params(input_dev, ABS_MT_POSITION_X,
@@ -1386,6 +1387,7 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 
 			__set_bit(BTN_TOOL_FINGER, input_dev->keybit);
 			__set_bit(BTN_TOOL_DOUBLETAP, input_dev->keybit);
+			input_mt_init_slots(input_dev, features->touch_max);
 
 			if (features->pktlen == WACOM_PKGLEN_BBTOUCH3) {
 				__set_bit(BTN_TOOL_TRIPLETAP,
@@ -1393,13 +1395,9 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 				__set_bit(BTN_TOOL_QUADTAP,
 					  input_dev->keybit);
 
-				input_mt_init_slots(input_dev, 16);
-
 				input_set_abs_params(input_dev,
 						     ABS_MT_TOUCH_MAJOR,
 						     0, 255, 0, 0);
-			} else {
-				input_mt_init_slots(input_dev, 2);
 			}
 
 			input_set_abs_params(input_dev, ABS_MT_POSITION_X,
@@ -1615,40 +1613,48 @@ static const struct wacom_features wacom_features_0x90 =
 	  0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x93 =
 	{ "Wacom ISDv4 93",       WACOM_PKGLEN_GRAPHIRE,  26202, 16325,  255,
-	  0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+	  0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
+	  .touch_max = 1 };
 static const struct wacom_features wacom_features_0x97 =
 	{ "Wacom ISDv4 97",       WACOM_PKGLEN_GRAPHIRE,  26202, 16325,  511,
 	  0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x9A =
 	{ "Wacom ISDv4 9A",       WACOM_PKGLEN_GRAPHIRE,  26202, 16325,  255,
-	  0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+	  0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
+	  .touch_max = 1 };
 static const struct wacom_features wacom_features_0x9F =
 	{ "Wacom ISDv4 9F",       WACOM_PKGLEN_GRAPHIRE,  26202, 16325,  255,
 	  0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xE2 =
 	{ "Wacom ISDv4 E2",       WACOM_PKGLEN_TPC2FG,    26202, 16325,  255,
-	  0, TABLETPC2FG, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+	  0, TABLETPC2FG, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
+	  .touch_max = 2 };
 static const struct wacom_features wacom_features_0xE3 =
 	{ "Wacom ISDv4 E3",       WACOM_PKGLEN_TPC2FG,    26202, 16325,  255,
-	  0, TABLETPC2FG, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+	  0, TABLETPC2FG, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
+	  .touch_max = 2 };
 static const struct wacom_features wacom_features_0xE6 =
 	{ "Wacom ISDv4 E6",       WACOM_PKGLEN_TPC2FG,    27760, 15694,  255,
-	  0, TABLETPC2FG, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+	  0, TABLETPC2FG, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
+	  .touch_max = 2 };
 static const struct wacom_features wacom_features_0x47 =
 	{ "Wacom Intuos2 6x8",    WACOM_PKGLEN_INTUOS,    20320, 16240, 1023,
 	  31, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xD0 =
 	{ "Wacom Bamboo 2FG",     WACOM_PKGLEN_BBFUN,     14720,  9200, 1023,
-	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
+	  .touch_max = 2 };
 static const struct wacom_features wacom_features_0xD1 =
 	{ "Wacom Bamboo 2FG 4x5", WACOM_PKGLEN_BBFUN,     14720,  9200, 1023,
-	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
+	  .touch_max = 2 };
 static const struct wacom_features wacom_features_0xD2 =
 	{ "Wacom Bamboo Craft",   WACOM_PKGLEN_BBFUN,     14720,  9200, 1023,
 	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xD3 =
 	{ "Wacom Bamboo 2FG 6x8", WACOM_PKGLEN_BBFUN,     21648, 13700, 1023,
-	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
+	  .touch_max = 2 };
 static const struct wacom_features wacom_features_0xD4 =
 	{ "Wacom Bamboo Pen",     WACOM_PKGLEN_BBFUN,     14720,  9200, 1023,
 	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
@@ -1657,28 +1663,35 @@ static const struct wacom_features wacom_features_0xD5 =
 	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xD6 =
 	{ "Wacom BambooPT 2FG 4x5", WACOM_PKGLEN_BBFUN,   14720,  9200, 1023,
-	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
+	  .touch_max = 2 };
 static const struct wacom_features wacom_features_0xD7 =
 	{ "Wacom BambooPT 2FG Small", WACOM_PKGLEN_BBFUN, 14720,  9200, 1023,
-	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
+	  .touch_max = 2 };
 static const struct wacom_features wacom_features_0xD8 =
 	{ "Wacom Bamboo Comic 2FG", WACOM_PKGLEN_BBFUN,   21648, 13700, 1023,
-	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
+	  .touch_max = 2 };
 static const struct wacom_features wacom_features_0xDA =
 	{ "Wacom Bamboo 2FG 4x5 SE", WACOM_PKGLEN_BBFUN,  14720,  9200, 1023,
-	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
+	  .touch_max = 2 };
 static struct wacom_features wacom_features_0xDB =
 	{ "Wacom Bamboo 2FG 6x8 SE", WACOM_PKGLEN_BBFUN,  21648, 13700, 1023,
-	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
+	  .touch_max = 2 };
 static const struct wacom_features wacom_features_0xDD =
         { "Wacom Bamboo Connect", WACOM_PKGLEN_BBPEN,     14720,  9200, 1023,
           31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xDE =
         { "Wacom Bamboo 16FG 4x5", WACOM_PKGLEN_BBPEN,    14720,  9200, 1023,
-          31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+          31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
+	  .touch_max = 16 };
 static const struct wacom_features wacom_features_0xDF =
         { "Wacom Bamboo 16FG 6x8", WACOM_PKGLEN_BBPEN,    21648, 13700, 1023,
-          31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+          31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
+	  .touch_max = 16 };
 static const struct wacom_features wacom_features_0x6004 =
 	{ "ISD-V4",               WACOM_PKGLEN_GRAPHIRE,  12800,  8000,  255,
 	  0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index 4f0ba21..1c9dc3e 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -91,6 +91,7 @@ struct wacom_features {
 	int pressure_fuzz;
 	int distance_fuzz;
 	unsigned quirks;
+	unsigned touch_max;
 };
 
 struct wacom_shared {
-- 
1.7.7.4

