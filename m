From: chris@cnpbagwell.com
Subject: [PATCH 3/4] input: wacom - Add support for Bamboo Pen
Date: Wed,  8 Sep 2010 23:02:31 -0500
Message-ID: <1284004952-12701-4-git-send-email-chris@cnpbagwell.com>
References: <1284004952-12701-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:34641 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab0IIECq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Sep 2010 00:02:46 -0400
Received: by gxk23 with SMTP id 23so424824gxk.19
        for <linux-input@vger.kernel.org>; Wed, 08 Sep 2010 21:02:45 -0700 (PDT)
In-Reply-To: <1284004952-12701-1-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, pingc@wacom.com
Cc: Chris Bagwell <chris@cnpbagwell.com>

From: Chris Bagwell <chris@cnpbagwell.com>

This adds support for Pen on Bamboo Pen and Bamboo Pen&Touch
devices.  Touchpad is handled by previous Bamboo Touch
logic.

Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
---
 drivers/input/tablet/wacom_wac.c |   75 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 2f7ed9a..9cc0cf0 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -904,10 +904,71 @@ static int wacom_bpt_touch(struct wacom_wac *wacom)
 	return 0;
 }
 
+static int wacom_bpt_pen(struct wacom_wac *wacom)
+{
+	struct input_dev *input = wacom->input;
+	unsigned char *data = wacom->data;
+	int prox = 0, x = 0, y = 0, p = 0, d = 0, pen = 0, btn1 = 0, btn2 = 0;
+
+	prox = (data[1] & 0x10) && (data[1] & 0x20);
+
+	/* All reports shared between PEN and RUBBER tool must be
+	 * forced to a known starting value (zero) when transitioning to
+	 * out-of-prox.
+	 *
+	 * If not done then to user it will look like a loss
+	 * of an event if new tool comes in-prox with same
+	 * value as previous tool that went out-of-prox.
+	 *
+	 * Hardware generally forces to zero on its own but
+	 * account for that here to be extra paranoid.
+	 */
+	if (prox) {
+		if (!wacom->shared->stylus_in_proximity) {
+			if (data[1] & 0x08) {
+				wacom->tool[0] = BTN_TOOL_RUBBER;
+				wacom->id[0] = ERASER_DEVICE_ID;
+			} else {
+				wacom->tool[0] = BTN_TOOL_PEN;
+				wacom->id[0] = STYLUS_DEVICE_ID;
+			}
+			wacom->shared->stylus_in_proximity = true;
+		}
+		x = le16_to_cpup((__le16 *)&data[2]);
+		y = le16_to_cpup((__le16 *)&data[4]);
+		p = le16_to_cpup((__le16 *)&data[6]);
+		d = data[8];
+		pen = data[1] & 0x01;
+		btn1 = data[1] & 0x02;
+		btn2 = data[1] & 0x04;
+	}
+
+	input_report_key(input, BTN_TOUCH, pen);
+	input_report_key(input, BTN_STYLUS, btn1);
+	input_report_key(input, BTN_STYLUS2, btn2);
+
+	input_report_abs(input, ABS_X, x);
+	input_report_abs(input, ABS_Y, y);
+	input_report_abs(input, ABS_PRESSURE, p);
+	input_report_abs(input, ABS_DISTANCE, d);
+
+	if (!prox) {
+		wacom->id[0] = 0;
+		wacom->shared->stylus_in_proximity = false;
+	}
+
+	input_report_key(input, wacom->tool[0], prox); /* PEN or RUBBER */
+	input_report_abs(input, ABS_MISC, wacom->id[0]); /* TOOL ID */
+
+	return 1;
+}
+
 static int wacom_bpt_irq(struct wacom_wac *wacom, size_t len)
 {
 	if (len == WACOM_PKGLEN_BBTOUCH)
 		return wacom_bpt_touch(wacom);
+	else if (len == WACOM_PKGLEN_BBFUN)
+		return wacom_bpt_pen(wacom);
 
 	return 0;
 }
@@ -1193,6 +1254,11 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 					     features->pressure_fuzz, 0);
 			input_set_abs_params(input_dev, ABS_MT_TRACKING_ID, 0,
 					     MAX_TRACKING_ID, 0, 0);
+		} else if (features->device_type == BTN_TOOL_PEN) {
+			__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
+			__set_bit(BTN_TOOL_PEN, input_dev->keybit);
+			__set_bit(BTN_STYLUS, input_dev->keybit);
+			__set_bit(BTN_STYLUS2, input_dev->keybit);
 		}
 		break;
 	}
@@ -1334,6 +1400,12 @@ static const struct wacom_features wacom_features_0x47 =
 	{ "Wacom Intuos2 6x8",    WACOM_PKGLEN_INTUOS,    20320, 16240, 1023, 31, INTUOS };
 static struct wacom_features wacom_features_0xD0 =
 	{ "Wacom Bamboo 2FG",     WACOM_PKGLEN_BBFUN,     14720,  9200, 1023, 63, BAMBOO_PT };
+static struct wacom_features wacom_features_0xD1 =
+	{ "Wacom Bamboo 2FG 4x5", WACOM_PKGLEN_BBFUN,     14720,  9200, 1023, 63, BAMBOO_PT };
+static struct wacom_features wacom_features_0xD2 =
+	{ "Wacom Bamboo Craft",   WACOM_PKGLEN_BBFUN,     14720,  9200, 1023, 63, BAMBOO_PT };
+static struct wacom_features wacom_features_0xD3 =
+	{ "Wacom Bamboo 2FG 6x8", WACOM_PKGLEN_BBFUN,     21648, 13530, 1023, 63, BAMBOO_PT };
 
 #define USB_DEVICE_WACOM(prod)					\
 	USB_DEVICE(USB_VENDOR_ID_WACOM, prod),			\
@@ -1399,6 +1471,9 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0xC7) },
 	{ USB_DEVICE_WACOM(0xCE) },
 	{ USB_DEVICE_WACOM(0xD0) },
+	{ USB_DEVICE_WACOM(0xD1) },
+	{ USB_DEVICE_WACOM(0xD2) },
+	{ USB_DEVICE_WACOM(0xD3) },
 	{ USB_DEVICE_WACOM(0xF0) },
 	{ USB_DEVICE_WACOM(0xCC) },
 	{ USB_DEVICE_WACOM(0x90) },
-- 
1.7.2.2

