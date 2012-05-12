From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/2] input - wacom : add two new devices (0xed and 0xef)
Date: Fri, 11 May 2012 18:25:20 -0700
Message-ID: <1336785920-2397-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39283 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757039Ab2ELBZ0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 May 2012 21:25:26 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so3730507dad.19
        for <linux-input@vger.kernel.org>; Fri, 11 May 2012 18:25:25 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

0xed supports pen and one finger touch; 0xef is pen only.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c |   13 ++++++++++++-
 drivers/input/tablet/wacom_wac.h |    2 ++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index c40dcb7..fd0cf4d3 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -888,7 +888,7 @@ static int wacom_tpc_single_touch(struct wacom_wac *wacom, size_t len)
 			prox = data[0] & 0x01;
 			x = get_unaligned_le16(&data[1]);
 			y = get_unaligned_le16(&data[3]);
-		} else { /* with capacity */
+		} else {
 			prox = data[1] & 0x01;
 			x = le16_to_cpup((__le16 *)&data[2]);
 			y = le16_to_cpup((__le16 *)&data[4]);
@@ -961,6 +961,7 @@ static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
 		case WACOM_REPORT_TPC1FG:
 		case WACOM_REPORT_TPCHID:
 		case WACOM_REPORT_TPCST:
+		case WACOM_REPORT_TPC1FGE:
 			return wacom_tpc_single_touch(wacom, len);
 
 		case WACOM_REPORT_TPCMT:
@@ -1244,6 +1245,7 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 		break;
 
 	case TABLETPC:
+	case TABLETPCE:
 	case TABLETPC2FG:
 	case MTSCREEN:
 		sync = wacom_tpc_irq(wacom_wac, len);
@@ -1569,6 +1571,7 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 		/* fall through */
 
 	case TABLETPC:
+	case TABLETPCE:
 		__clear_bit(ABS_MISC, input_dev->absbit);
 
 		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
@@ -1886,6 +1889,12 @@ static const struct wacom_features wacom_features_0xE6 =
 static const struct wacom_features wacom_features_0xEC =
 	{ "Wacom ISDv4 EC",       WACOM_PKGLEN_GRAPHIRE,  25710, 14500,  255,
 	  0, TABLETPC,    WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+static const struct wacom_features wacom_features_0xED =
+	{ "Wacom ISDv4 ED",       WACOM_PKGLEN_GRAPHIRE,  26202, 16325,  255,
+	  0, TABLETPCE, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+static const struct wacom_features wacom_features_0xEF =
+	{ "Wacom ISDv4 EF",       WACOM_PKGLEN_GRAPHIRE,  26202, 16325,  255,
+	  0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x47 =
 	{ "Wacom Intuos2 6x8",    WACOM_PKGLEN_INTUOS,    20320, 16240, 1023,
 	  31, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
@@ -2060,6 +2069,8 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0xE5) },
 	{ USB_DEVICE_WACOM(0xE6) },
 	{ USB_DEVICE_WACOM(0xEC) },
+	{ USB_DEVICE_WACOM(0xED) },
+	{ USB_DEVICE_WACOM(0xEF) },
 	{ USB_DEVICE_WACOM(0x47) },
 	{ USB_DEVICE_WACOM(0xF4) },
 	{ USB_DEVICE_LENOVO(0x6004) },
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index 8708043..bd5d37b 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -48,6 +48,7 @@
 #define WACOM_REPORT_TPCMT		13
 #define WACOM_REPORT_TPCHID		15
 #define WACOM_REPORT_TPCST		16
+#define WACOM_REPORT_TPC1FGE		18
 
 /* device quirks */
 #define WACOM_QUIRK_MULTI_INPUT		0x0001
@@ -80,6 +81,7 @@ enum {
 	WIRELESS,
 	BAMBOO_PT,
 	TABLETPC,   /* add new TPC below */
+	TABLETPCE,
 	TABLETPC2FG,
 	MTSCREEN,
 	MAX_TYPE
-- 
1.7.9.5

