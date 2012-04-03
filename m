From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v3 1/4] input: wacom: Intuos5 basic support
Date: Tue,  3 Apr 2012 14:48:59 -0700
Message-ID: <1333489742-29901-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51439 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754866Ab2DCVtM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Apr 2012 17:49:12 -0400
Received: by obbtb18 with SMTP id tb18so233630obb.19
        for <linux-input@vger.kernel.org>; Tue, 03 Apr 2012 14:49:11 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linuxwacom-devel@lists.sourceforge.net, dmitry.torokhov@gmail.com, pinglinux@gmail.com, chris@cnpbagwell.com, tjaalton@ubuntu.com
Cc: Jason Gerecke <killertofu@gmail.com>

This patch adds support for the basic pen functions of Intuos5
tablets.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>
Reviewed-by: Ping Cheng <pingc@wacom.com>
Tested-by: Timo Aaltonen <tjaalton@ubuntu.com>
---
No changes to patch; added signed-off-by and other tags

 drivers/input/tablet/wacom_wac.c |   36 +++++++++++++++++++++++++++++++++---
 drivers/input/tablet/wacom_wac.h |    3 +++
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 9283507..35efc64 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -452,6 +452,7 @@ static void wacom_intuos_general(struct wacom_wac *wacom)
 	if ((data[1] & 0xb8) == 0xa0) {
 		t = (data[6] << 2) | ((data[7] >> 6) & 3);
 		if ((features->type >= INTUOS4S && features->type <= INTUOS4L) ||
+                    (features->type >= INTUOS5S && features->type <= INTUOS5L) ||
 		    features->type == WACOM_21UX2 || features->type == WACOM_24HD) {
 			t = (t << 1) | (data[1] & 1);
 		}
@@ -632,7 +633,9 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 	    (features->type == INTUOS3 ||
 	     features->type == INTUOS3S ||
 	     features->type == INTUOS4 ||
-	     features->type == INTUOS4S)) {
+	     features->type == INTUOS4S ||
+	     features->type == INTUOS5 ||
+	     features->type == INTUOS5S)) {
 
 		return 0;
 	}
@@ -685,7 +688,8 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 
 		} else if (wacom->tool[idx] == BTN_TOOL_MOUSE) {
 			/* I4 mouse */
-			if (features->type >= INTUOS4S && features->type <= INTUOS4L) {
+			if ((features->type >= INTUOS4S && features->type <= INTUOS4L) ||
+			    (features->type >= INTUOS5S && features->type <= INTUOS5L)) {
 				input_report_key(input, BTN_LEFT,   data[6] & 0x01);
 				input_report_key(input, BTN_MIDDLE, data[6] & 0x02);
 				input_report_key(input, BTN_RIGHT,  data[6] & 0x04);
@@ -712,7 +716,7 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 				}
 			}
 		} else if ((features->type < INTUOS3S || features->type == INTUOS3L ||
-				features->type == INTUOS4L) &&
+				features->type == INTUOS4L || features->type == INTUOS5L) &&
 			   wacom->tool[idx] == BTN_TOOL_LENS) {
 			/* Lens cursor packets */
 			input_report_key(input, BTN_LEFT,   data[8] & 0x01);
@@ -1078,6 +1082,9 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 	case INTUOS4S:
 	case INTUOS4:
 	case INTUOS4L:
+	case INTUOS5S:
+	case INTUOS5:
+	case INTUOS5L:
 	case CINTIQ:
 	case WACOM_BEE:
 	case WACOM_21UX2:
@@ -1312,12 +1319,15 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 		wacom_setup_intuos(wacom_wac);
 		break;
 
+	case INTUOS5:
+	case INTUOS5L:
 	case INTUOS4:
 	case INTUOS4L:
 		__set_bit(BTN_7, input_dev->keybit);
 		__set_bit(BTN_8, input_dev->keybit);
 		/* fall through */
 
+	case INTUOS5S:
 	case INTUOS4S:
 		for (i = 0; i < 7; i++)
 			__set_bit(BTN_0 + i, input_dev->keybit);
@@ -1586,6 +1596,21 @@ static const struct wacom_features wacom_features_0xBB =
 static const struct wacom_features wacom_features_0xBC =
 	{ "Wacom Intuos4 WL",     WACOM_PKGLEN_INTUOS,    40840, 25400, 2047,
 	  63, INTUOS4, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+static const struct wacom_features wacom_features_0x26 =
+        { "Wacom Intuos5 touch S", WACOM_PKGLEN_INTUOS,  31496, 19685, 2047,
+          63, INTUOS5S, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+static const struct wacom_features wacom_features_0x27 =
+        { "Wacom Intuos5 touch M", WACOM_PKGLEN_INTUOS,  44704, 27940, 2047,
+          63, INTUOS5, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+static const struct wacom_features wacom_features_0x28 =
+        { "Wacom Intuos5 touch L", WACOM_PKGLEN_INTUOS, 65024, 40640, 2047,
+          63, INTUOS5L, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+static const struct wacom_features wacom_features_0x29 =
+        { "Wacom Intuos5 S", WACOM_PKGLEN_INTUOS,  31496, 19685, 2047,
+          63, INTUOS5S, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+static const struct wacom_features wacom_features_0x2A =
+        { "Wacom Intuos5 M", WACOM_PKGLEN_INTUOS,  44704, 27940, 2047,
+          63, INTUOS5, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
 static const struct wacom_features wacom_features_0xF4 =
 	{ "Wacom Cintiq 24HD",    WACOM_PKGLEN_INTUOS,   104480, 65600, 2047,
 	  63, WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
@@ -1752,6 +1777,11 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0xBA) },
 	{ USB_DEVICE_WACOM(0xBB) },
 	{ USB_DEVICE_WACOM(0xBC) },
+	{ USB_DEVICE_WACOM(0x26) },
+	{ USB_DEVICE_WACOM(0x27) },
+	{ USB_DEVICE_WACOM(0x28) },
+	{ USB_DEVICE_WACOM(0x29) },
+	{ USB_DEVICE_WACOM(0x2A) },
 	{ USB_DEVICE_WACOM(0x3F) },
 	{ USB_DEVICE_WACOM(0xC5) },
 	{ USB_DEVICE_WACOM(0xC6) },
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index 4f0ba21..5eb10c5 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -61,6 +61,9 @@ enum {
 	INTUOS4S,
 	INTUOS4,
 	INTUOS4L,
+	INTUOS5S,
+	INTUOS5,
+	INTUOS5L,
 	WACOM_24HD,
 	WACOM_21UX2,
 	CINTIQ,
-- 
1.7.9.1

