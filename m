From: weixing <weixing@hanwang.com.cn>
Subject: [PATCH 1/1] Input: hanwang - add support for Art Master II tablet
Date: Fri, 29 Jun 2012 22:14:06 +0800
Message-ID: <1340979246-2941-1-git-send-email-weixing@hanwang.com.cn>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hanwang.com.cn ([221.122.51.51]:53274 "EHLO mail.hanwang.com.cn"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887Ab2F2OOi (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Jun 2012 10:14:38 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, xing_wei777@126.com, weixing <weixing@hanwang.com.cn>

this adds support for old hanwang Art master II tablet

Signed-off-by: weixing <weixing@hanwang.com.cn>
---
 drivers/input/tablet/hanwang.c |   50 ++++++++++++++++++++++++++++------------
 1 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/input/tablet/hanwang.c b/drivers/input/tablet/hanwang.c
index b2db3cf..b652de3 100644
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
@@ -127,16 +130,30 @@ static void hanwang_parse_packet(struct hanwang *hanwang)
 	struct usb_device *dev = hanwang->usbdev;
 	enum hanwang_tablet_type type = hanwang->features->type;
 	int i;
-	u16 x, y, p;
+	u16 p;
+
+	if (type == HANWANG_ART_MASTER_II) {
+		hanwang->current_tool = BTN_TOOL_PEN;
+		hanwang->current_id = STYLUS_DEVICE_ID;
+	}
 
 	switch (data[0]) {
 	case 0x02:	/* data packet */
 		switch (data[1]) {
 		case 0x80:	/* tool prox out */
-			hanwang->current_id = 0;
-			input_report_key(input_dev, hanwang->current_tool, 0);
+			if (type != HANWANG_ART_MASTER_II) {
+				hanwang->current_id = 0;
+				input_report_key(input_dev,
+					hanwang->current_tool, 0);
+			}
+			break;
+		case 0x00:	/* artmaster ii pen leave */
+			if (type == HANWANG_ART_MASTER_II) {
+				hanwang->current_id = 0;
+				input_report_key(input_dev,
+					hanwang->current_tool, 0);
+			}
 			break;
-
 		case 0xc2:	/* first time tool prox in */
 			switch (data[3] & 0xf0) {
 			case 0x20:	/* art_master III */
@@ -154,23 +171,20 @@ static void hanwang_parse_packet(struct hanwang *hanwang)
 			default:
 				hanwang->current_id = 0;
 				dev_dbg(&dev->dev,
-					"unknown tablet tool %02x ", data[0]);
+					"unknown tablet tool %02x\n", data[0]);
 				break;
 			}
 			break;
 
 		default:	/* tool data packet */
-			x = (data[2] << 8) | data[3];
-			y = (data[4] << 8) | data[5];
-
 			switch (type) {
 			case HANWANG_ART_MASTER_III:
 				p = (data[6] << 3) |
 				    ((data[7] & 0xc0) >> 5) |
 				    (data[1] & 0x01);
 				break;
-
 			case HANWANG_ART_MASTER_HD:
+			case HANWANG_ART_MASTER_II:
 				p = (data[7] >> 6) | (data[6] << 2);
 				break;
 
@@ -180,15 +194,18 @@ static void hanwang_parse_packet(struct hanwang *hanwang)
 			}
 
 			input_report_abs(input_dev, ABS_X,
-						le16_to_cpup((__le16 *)&x));
+					be16_to_cpup((__be16 *)&data[2]));
 			input_report_abs(input_dev, ABS_Y,
-						le16_to_cpup((__le16 *)&y));
-			input_report_abs(input_dev, ABS_PRESSURE,
-						le16_to_cpup((__le16 *)&p));
+					be16_to_cpup((__be16 *)&data[4]));
+			input_report_abs(input_dev, ABS_PRESSURE, p);
 			input_report_abs(input_dev, ABS_TILT_X, data[7] & 0x3f);
 			input_report_abs(input_dev, ABS_TILT_Y, data[8] & 0x7f);
 			input_report_key(input_dev, BTN_STYLUS, data[1] & 0x02);
-			input_report_key(input_dev, BTN_STYLUS2, data[1] & 0x04);
+			if (type != HANWANG_ART_MASTER_II)
+				input_report_key(input_dev, BTN_STYLUS2,
+						data[1] & 0x04);
+			else
+				input_report_key(input_dev, BTN_TOOL_PEN, 1);
 			break;
 		}
 		input_report_abs(input_dev, ABS_MISC, hanwang->current_id);
@@ -227,6 +244,9 @@ static void hanwang_parse_packet(struct hanwang *hanwang)
 					 BTN_5 + i, data[6] & (1 << i));
 			}
 			break;
+		case HANWANG_ART_MASTER_II:
+			dev_dbg(&dev->dev, "error packet  %02x\n", data[0]);
+			return;
 		}
 
 		input_report_abs(input_dev, ABS_MISC, hanwang->current_id);
@@ -234,7 +254,7 @@ static void hanwang_parse_packet(struct hanwang *hanwang)
 		break;
 
 	default:
-		dev_dbg(&dev->dev, "error packet  %02x ", data[0]);
+		dev_dbg(&dev->dev, "error packet  %02x\n", data[0]);
 		break;
 	}
 
-- 
1.7.4.1

