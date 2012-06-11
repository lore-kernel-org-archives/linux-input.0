From: weixing <weixing@hanwang.com.cn>
Subject: [PATCH] Input: hanwang - add support for Art Master II tablet
Date: Mon, 11 Jun 2012 22:10:39 +0800
Message-ID: <1339423839-9716-1-git-send-email-weixing@hanwang.com.cn>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hanwang.com.cn ([221.122.51.51]:45509 "EHLO mail.hanwang.com.cn"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754994Ab2FKORs (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jun 2012 10:17:48 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, weixing@hanwang.com.cn

this adds support for old hanwang Art master II tablet

Signed-off-by: weixing <weixing@hanwang.com.cn>
---
 drivers/input/tablet/hanwang.c |   63 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/input/tablet/hanwang.c b/drivers/input/tablet/hanwang.c
index b2db3cf..4154c1d 100644
--- a/drivers/input/tablet/hanwang.c
+++ b/drivers/input/tablet/hanwang.c
@@ -63,6 +63,7 @@ MODULE_LICENSE(DRIVER_LICENSE);
 enum hanwang_tablet_type {
 	HANWANG_ART_MASTER_III,
 	HANWANG_ART_MASTER_HD,
+	HANWANG_ART_MASTER_II,
 };
 
 struct hanwang {
@@ -99,6 +100,8 @@ static const struct hanwang_features features_array[] = {
 	  ART_MASTER_PKGLEN_MAX, 0x7f00, 0x4f60, 0x3f, 0x7f, 2048 },
 	{ 0x8401, "Hanwang Art Master HD 5012", HANWANG_ART_MASTER_HD,
 	  ART_MASTER_PKGLEN_MAX, 0x678e, 0x4150, 0x3f, 0x7f, 1024 },
+	{ 0x8503, "Hanwang Art Master II", HANWANG_ART_MASTER_II,
+	  ART_MASTER_PKGLEN_MAX, 0x27de, 0x1cfe, 0x3f, 0x7f, 1024 },
 };
 
 static const int hw_eventtypes[] = {
@@ -120,6 +123,55 @@ static const int hw_mscevents[] = {
 	MSC_SERIAL,
 };
 
+static void hanwang_parse_ArtmasterII_packet(struct hanwang *hanwang)
+{
+	unsigned char *data = hanwang->data;
+	struct input_dev *input_dev = hanwang->dev;
+	struct usb_device *dev = hanwang->usbdev;
+	u16 x, y, p;
+
+	hanwang->current_tool = BTN_TOOL_PEN;
+
+	switch (data[0]) {
+	case 0x02:	/* correct report id */
+		switch (data[1]) {
+		case 0x00:	/* pen leave */
+			hanwang->current_id = 0;
+			input_report_key(input_dev, hanwang->current_tool, 0);
+			break;
+		default:
+			hanwang->current_id = STYLUS_DEVICE_ID;
+			x = (data[2] << 8) | data[3];
+			y = (data[4] << 8) | data[5];
+			p = (data[7] >> 6) | (data[6] << 2);
+
+			input_report_key(input_dev, BTN_TOOL_PEN, 1);
+			input_report_abs(input_dev, ABS_X,
+						le16_to_cpup((__le16 *)&x));
+			input_report_abs(input_dev, ABS_Y,
+						le16_to_cpup((__le16 *)&y));
+			input_report_abs(input_dev, ABS_PRESSURE,
+						le16_to_cpup((__le16 *)&p));
+			input_report_abs(input_dev, ABS_TILT_X, data[7] & 0x3f);
+			input_report_abs(input_dev, ABS_TILT_Y, data[8] & 0x7f);
+			input_report_key(input_dev, BTN_STYLUS2,
+						data[1] & 0x02);
+			break;
+		}
+
+		input_report_abs(input_dev, ABS_MISC, hanwang->current_id);
+		input_event(input_dev, EV_MSC, MSC_SERIAL,
+				hanwang->features->pid);
+		break;
+
+	default:
+		dev_dbg(&dev->dev, "unknown report id  %02x\n", data[0]);
+		break;
+	}
+
+	input_sync(input_dev);
+}
+
 static void hanwang_parse_packet(struct hanwang *hanwang)
 {
 	unsigned char *data = hanwang->data;
@@ -129,6 +181,11 @@ static void hanwang_parse_packet(struct hanwang *hanwang)
 	int i;
 	u16 x, y, p;
 
+	if (type == HANWANG_ART_MASTER_II) {
+		hanwang_parse_ArtmasterII_packet(hanwang);
+		return;
+	}
+
 	switch (data[0]) {
 	case 0x02:	/* data packet */
 		switch (data[1]) {
@@ -154,7 +211,7 @@ static void hanwang_parse_packet(struct hanwang *hanwang)
 			default:
 				hanwang->current_id = 0;
 				dev_dbg(&dev->dev,
-					"unknown tablet tool %02x ", data[0]);
+					"unknown tablet tool %02x\n", data[0]);
 				break;
 			}
 			break;
@@ -227,6 +284,8 @@ static void hanwang_parse_packet(struct hanwang *hanwang)
 					 BTN_5 + i, data[6] & (1 << i));
 			}
 			break;
+		default:
+			break;
 		}
 
 		input_report_abs(input_dev, ABS_MISC, hanwang->current_id);
@@ -234,7 +293,7 @@ static void hanwang_parse_packet(struct hanwang *hanwang)
 		break;
 
 	default:
-		dev_dbg(&dev->dev, "error packet  %02x ", data[0]);
+		dev_dbg(&dev->dev, "error packet  %02x\n", data[0]);
 		break;
 	}
 
-- 
1.7.4.1

