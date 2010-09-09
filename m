From: "Xing Wei" <weixing@hanwang.com.cn>
Subject: [PATCH v1] input: Hanwang tablet using xf86-input-wacom driver
Date: Thu, 9 Sep 2010 21:35:58 +0800
Message-ID: <201009092135586874801@hanwang.com.cn>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hanwang.com.cn ([221.122.51.51]:42853 "EHLO mail.hanwang.com.cn"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754356Ab0IINf4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 9 Sep 2010 09:35:56 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "dmitry.torokhov" <dmitry.torokhov@gmail.com>
Cc: "peter.hutterer" <peter.hutterer@who-t.net>, linux-input <linux-input@vger.kernel.org>, houyun <houyun@hanwang.com.cn>

From: Xing Wei  <weixing@hanwang.com.cn>

This patch make Hanwang Art Master III tablet handled by xf86-input-wacom driver in the X system.

Signed-off-by: Xing Wei <weixing@hanwang.com.cn>

---

 drivers/input/tablet/hanwang.c |   37 +++++++++++++++++++++++++++++++++----
 1 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/input/tablet/hanwang.c b/drivers/input/tablet/hanwang.c
index 3554e30..0701d94 100644
--- a/drivers/input/tablet/hanwang.c
+++ b/drivers/input/tablet/hanwang.c
@@ -44,6 +44,13 @@ MODULE_LICENSE(DRIVER_LICENSE);
 
 #define ART_MASTERIII_PKGLEN_MAX	10
 
+/* device IDs */
+#define STYLUS_DEVICE_ID	0x02
+#define TOUCH_DEVICE_ID		0x03
+#define CURSOR_DEVICE_ID	0x06
+#define ERASER_DEVICE_ID	0x0A
+#define PAD_DEVICE_ID		0x0F
+
 /* match vendor and interface info  */
 #define HANWANG_TABLET_DEVICE(vend, cl, sc, pr) \
 	.match_flags = USB_DEVICE_ID_MATCH_VENDOR \
@@ -61,6 +68,7 @@ struct hanwang {
 	struct urb *irq;
 	const struct hanwang_features *features;
 	unsigned int current_tool;
+	unsigned int current_id;
 	char name[64];
 	char phys[32];
 };
@@ -86,16 +94,22 @@ static const struct hanwang_features features_array[] = {
 };
 
 static const int hw_eventtypes[] = {
-	EV_KEY, EV_ABS,
+	EV_KEY, EV_ABS, EV_MSC,
 };
 
 static const int hw_absevents[] = {
-	ABS_X, ABS_Y, ABS_TILT_X, ABS_TILT_Y, ABS_WHEEL, ABS_PRESSURE,
+	ABS_X, ABS_Y, ABS_TILT_X, ABS_TILT_Y, ABS_WHEEL,
+	ABS_PRESSURE, ABS_MISC,
 };
 
 static const int hw_btnevents[] = {
-	BTN_STYLUS, BTN_STYLUS2, BTN_TOOL_PEN, BTN_TOOL_RUBBER, BTN_TOOL_MOUSE,
-	BTN_0, BTN_1, BTN_2, BTN_3, BTN_4, BTN_5, BTN_6, BTN_7, BTN_8
+	BTN_STYLUS, BTN_STYLUS2, BTN_TOOL_PEN, BTN_TOOL_RUBBER,
+	BTN_TOOL_MOUSE, BTN_TOOL_FINGER,
+	BTN_0, BTN_1, BTN_2, BTN_3, BTN_4, BTN_5, BTN_6, BTN_7, BTN_8,
+};
+
+static const int hw_mscevents[] = {
+	MSC_SERIAL,
 };
 
 static void hanwang_parse_packet(struct hanwang *hanwang)
@@ -109,20 +123,24 @@ static void hanwang_parse_packet(struct hanwang *hanwang)
 	case 0x02:	/* data packet */
 		switch (data[1]) {
 		case 0x80:	/* tool prox out */
+			hanwang->current_id = 0;
 			input_report_key(input_dev, hanwang->current_tool, 0);
 			break;
 
 		case 0xc2:	/* first time tool prox in */
 			switch (data[3] & 0xf0) {
 			case 0x20:
+				hanwang->current_id = STYLUS_DEVICE_ID;
 				hanwang->current_tool = BTN_TOOL_PEN;
 				input_report_key(input_dev, BTN_TOOL_PEN, 1);
 				break;
 			case 0xa0:
+				hanwang->current_id = ERASER_DEVICE_ID;
 				hanwang->current_tool = BTN_TOOL_RUBBER;
 				input_report_key(input_dev, BTN_TOOL_RUBBER, 1);
 				break;
 			default:
+				hanwang->current_id = 0;
 				dev_dbg(&dev->dev,
 					"unknown tablet tool %02x ", data[0]);
 				break;
@@ -144,15 +162,23 @@ static void hanwang_parse_packet(struct hanwang *hanwang)
 			input_report_key(input_dev, BTN_STYLUS2, data[1] & 0x04);
 			break;
 		}
+		input_report_abs(input_dev, ABS_MISC, hanwang->current_id);
+		input_event(input_dev, EV_MSC, MSC_SERIAL,
+				hanwang->features->pid);
 		break;
 
 	case 0x0c:
 		/* roll wheel */
+		hanwang->current_id = PAD_DEVICE_ID;
+		input_report_key(input_dev, BTN_TOOL_FINGER, data[1] ||
+						data[2] || data[3]);
 		input_report_abs(input_dev, ABS_WHEEL, data[1]);
 		input_report_key(input_dev, BTN_0, data[2]);
 		for (i = 0; i < 8; i++)
 			input_report_key(input_dev,
 					 BTN_1 + i, data[3] & (1 << i));
+		input_report_abs(input_dev, ABS_MISC, hanwang->current_id);
+		input_event(input_dev, EV_MSC, MSC_SERIAL, 0xffffffff);
 		break;
 
 	default:
@@ -287,6 +313,9 @@ static int hanwang_probe(struct usb_interface *intf, const struct usb_device_id
 	for (i = 0; i < ARRAY_SIZE(hw_btnevents); ++i)
 		__set_bit(hw_btnevents[i], input_dev->keybit);
 
+	for (i = 0; i < ARRAY_SIZE(hw_mscevents); ++i)
+		__set_bit(hw_mscevents[i], input_dev->mscbit);
+
 	input_set_abs_params(input_dev, ABS_X,
 			     0, hanwang->features->max_x, 4, 0);
 	input_set_abs_params(input_dev, ABS_Y,

