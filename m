From: "Xing Wei" <weixing@hanwang.com.cn>
Subject: [PATCH v1] input: add support for hanwang electromagnetic tablet
Date: Sun, 26 Sep 2010 21:14:52 +0800
Message-ID: <201009262114522345565@hanwang.com.cn>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hanwang.com.cn ([221.122.51.51]:51645 "EHLO mail.hanwang.com.cn"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757673Ab0IZNOw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 26 Sep 2010 09:14:52 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "dmitry.torokhov" <dmitry.torokhov@gmail.com>
Cc: houyun <houyun@hanwang.com.cn>, linux-input <linux-input@vger.kernel.org>

From: Xing Wei  <weixing@hanwang.com.cn>

Add support for hanwang Art Master HD 5012 electromagnetic tablet.

Signed-off-by: Xing Wei <weixing@hanwang.com.cn>

---

 drivers/input/tablet/hanwang.c |   79 +++++++++++++++++++++++++++++-----------
 1 files changed, 58 insertions(+), 21 deletions(-)

diff --git a/drivers/input/tablet/hanwang.c b/drivers/input/tablet/hanwang.c
index 0701d94..d4b8267 100644
--- a/drivers/input/tablet/hanwang.c
+++ b/drivers/input/tablet/hanwang.c
@@ -42,7 +42,7 @@ MODULE_LICENSE(DRIVER_LICENSE);
 #define HANWANG_TABLET_INT_SUB_CLASS	0x0001
 #define HANWANG_TABLET_INT_PROTOCOL	0x0002
 
-#define ART_MASTERIII_PKGLEN_MAX	10
+#define ART_MASTER_PKGLEN_MAX	10
 
 /* device IDs */
 #define STYLUS_DEVICE_ID	0x02
@@ -60,6 +60,11 @@ MODULE_LICENSE(DRIVER_LICENSE);
 	.bInterfaceSubClass = (sc), \
 	.bInterfaceProtocol = (pr)
 
+enum hanwang_tablet_type {
+	HANWANG_ART_MASTER_III,
+	HANWANG_ART_MASTER_HD,
+};
+
 struct hanwang {
 	unsigned char *data;
 	dma_addr_t data_dma;
@@ -76,6 +81,7 @@ struct hanwang {
 struct hanwang_features {
 	unsigned short pid;
 	char *name;
+	enum hanwang_tablet_type type;
 	int pkg_len;
 	int max_x;
 	int max_y;
@@ -85,12 +91,14 @@ struct hanwang_features {
 };
 
 static const struct hanwang_features features_array[] = {
-	{ 0x8528, "Hanwang Art Master III 0906",
-	  ART_MASTERIII_PKGLEN_MAX, 0x5757, 0x3692, 0x3f, 0x7f, 2048 },
-	{ 0x8529, "Hanwang Art Master III 0604",
-	  ART_MASTERIII_PKGLEN_MAX, 0x3d84, 0x2672, 0x3f, 0x7f, 2048 },
-	{ 0x852a, "Hanwang Art Master III 1308",
-	  ART_MASTERIII_PKGLEN_MAX, 0x7f00, 0x4f60, 0x3f, 0x7f, 2048 },
+	{ 0x8528, "Hanwang Art Master III 0906", HANWANG_ART_MASTER_III,
+	  ART_MASTER_PKGLEN_MAX, 0x5757, 0x3692, 0x3f, 0x7f, 2048 },
+	{ 0x8529, "Hanwang Art Master III 0604", HANWANG_ART_MASTER_III,
+	  ART_MASTER_PKGLEN_MAX, 0x3d84, 0x2672, 0x3f, 0x7f, 2048 },
+	{ 0x852a, "Hanwang Art Master III 1308", HANWANG_ART_MASTER_III,
+	  ART_MASTER_PKGLEN_MAX, 0x7f00, 0x4f60, 0x3f, 0x7f, 2048 },
+	{ 0x8401, "Hanwang Art Master HD 5012", HANWANG_ART_MASTER_HD,
+	  ART_MASTER_PKGLEN_MAX, 0x678e, 0x4150, 0x3f, 0x7f, 1024 },
 };
 
 static const int hw_eventtypes[] = {
@@ -99,7 +107,7 @@ static const int hw_eventtypes[] = {
 
 static const int hw_absevents[] = {
 	ABS_X, ABS_Y, ABS_TILT_X, ABS_TILT_Y, ABS_WHEEL,
-	ABS_PRESSURE, ABS_MISC,
+	ABS_RX, ABS_RY, ABS_PRESSURE, ABS_MISC,
 };
 
 static const int hw_btnevents[] = {
@@ -117,7 +125,9 @@ static void hanwang_parse_packet(struct hanwang *hanwang)
 	unsigned char *data = hanwang->data;
 	struct input_dev *input_dev = hanwang->dev;
 	struct usb_device *dev = hanwang->usbdev;
+	enum hanwang_tablet_type type = hanwang->features->type;
 	int i;
+	u16 x, y, p;
 
 	switch (data[0]) {
 	case 0x02:	/* data packet */
@@ -129,12 +139,14 @@ static void hanwang_parse_packet(struct hanwang *hanwang)
 
 		case 0xc2:	/* first time tool prox in */
 			switch (data[3] & 0xf0) {
-			case 0x20:
+			case 0x20:	/* art_master III */
+			case 0x30:	/* art_master_HD */
 				hanwang->current_id = STYLUS_DEVICE_ID;
 				hanwang->current_tool = BTN_TOOL_PEN;
 				input_report_key(input_dev, BTN_TOOL_PEN, 1);
 				break;
-			case 0xa0:
+			case 0xa0:	/* art_master III */
+			case 0xb0:	/* art_master_HD */
 				hanwang->current_id = ERASER_DEVICE_ID;
 				hanwang->current_tool = BTN_TOOL_RUBBER;
 				input_report_key(input_dev, BTN_TOOL_RUBBER, 1);
@@ -148,14 +160,22 @@ static void hanwang_parse_packet(struct hanwang *hanwang)
 			break;
 
 		default:	/* tool data packet */
+			x = (data[2] << 8) | data[3];
+			y = (data[4] << 8) | data[5];
+			if (type ==  HANWANG_ART_MASTER_III) {
+				p =  (data[6] << 3) |
+					((data[7] & 0xc0) >> 5) |
+					(data[1] & 0x01);
+			} else if (type == HANWANG_ART_MASTER_HD)
+				p = (data[7] >> 6) | (data[6] << 2);
+			else
+				p = 0;
 			input_report_abs(input_dev, ABS_X,
-					 (data[2] << 8) | data[3]);
+						le16_to_cpup((__le16 *)&x));
 			input_report_abs(input_dev, ABS_Y,
-					 (data[4] << 8) | data[5]);
+						le16_to_cpup((__le16 *)&y));
 			input_report_abs(input_dev, ABS_PRESSURE,
-					 (data[6] << 3) |
-					 ((data[7] & 0xc0) >> 5) |
-					 (data[1] & 0x01));
+						le16_to_cpup((__le16 *)&p));
 			input_report_abs(input_dev, ABS_TILT_X, data[7] & 0x3f);
 			input_report_abs(input_dev, ABS_TILT_Y, data[8] & 0x7f);
 			input_report_key(input_dev, BTN_STYLUS, data[1] & 0x02);
@@ -170,13 +190,30 @@ static void hanwang_parse_packet(struct hanwang *hanwang)
 	case 0x0c:
 		/* roll wheel */
 		hanwang->current_id = PAD_DEVICE_ID;
-		input_report_key(input_dev, BTN_TOOL_FINGER, data[1] ||
-						data[2] || data[3]);
-		input_report_abs(input_dev, ABS_WHEEL, data[1]);
-		input_report_key(input_dev, BTN_0, data[2]);
-		for (i = 0; i < 8; i++)
-			input_report_key(input_dev,
+		if (type ==  HANWANG_ART_MASTER_III) {
+			input_report_key(input_dev, BTN_TOOL_FINGER, data[1] ||
+							data[2] || data[3]);
+			input_report_abs(input_dev, ABS_WHEEL, data[1]);
+			input_report_key(input_dev, BTN_0, data[2]);
+			for (i = 0; i < 8; i++)
+				input_report_key(input_dev,
 					 BTN_1 + i, data[3] & (1 << i));
+		} else if (type == HANWANG_ART_MASTER_HD) {
+			input_report_key(input_dev, BTN_TOOL_FINGER, data[1] ||
+					data[2] || data[3] || data[4] ||
+					data[5] || data[6]);
+			input_report_abs(input_dev, ABS_RX,
+					((data[1] & 0x1f) << 8) | data[2]);
+			input_report_abs(input_dev, ABS_RY,
+					((data[3] & 0x1f) << 8) | data[4]);
+			input_report_key(input_dev, BTN_0, data[5] & 0x01);
+			for (i = 0; i < 4; i++) {
+				input_report_key(input_dev,
+					 BTN_1 + i, data[5] & (1 << i));
+				input_report_key(input_dev,
+					 BTN_5 + i, data[6] & (1 << i));
+			}
+		}
 		input_report_abs(input_dev, ABS_MISC, hanwang->current_id);
 		input_event(input_dev, EV_MSC, MSC_SERIAL, 0xffffffff);
 		break;

