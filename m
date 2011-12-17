From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/4] input : wacom - retrieve maximum number of touch points
Date: Fri, 16 Dec 2011 16:37:44 -0800
Message-ID: <1324082264-32724-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61312 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab1LQAfr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Dec 2011 19:35:47 -0500
Received: by iaeh11 with SMTP id h11so5096969iae.19
        for <linux-input@vger.kernel.org>; Fri, 16 Dec 2011 16:35:47 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

>From the HID usage table when it is supported.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_sys.c |   36 +++++++++++++++++++++++++++++++-----
 drivers/input/tablet/wacom_wac.c |   10 ++++------
 drivers/input/tablet/wacom_wac.h |    1 +
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index c9588ee..b9736fb 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -31,6 +31,7 @@
 #define HID_COLLECTION			0xa1
 #define HID_COLLECTION_LOGICAL		0x02
 #define HID_COLLECTION_END		0xc0
+#define HID_MT_CONTACTMAX		0x55
 
 enum {
 	WCM_UNDEFINED = 0,
@@ -191,6 +192,7 @@ static int wacom_parse_logical_collection(unsigned char *report,
 		features->x_max = features->y_max =
 			get_unaligned_le16(&report[10]);
 
+		features->touch_max = 16;
 		length = 11;
 	}
 	return length;
@@ -239,11 +241,18 @@ static int wacom_parse_hid(struct usb_interface *intf,
 	int result = 0;
 	int i = 0, usage = WCM_UNDEFINED, finger = 0, pen = 0;
 	unsigned char *report;
+	unsigned char *rep_data;
 
 	report = kzalloc(hid_desc->wDescriptorLength, GFP_KERNEL);
 	if (!report)
 		return -ENOMEM;
 
+	rep_data = kmalloc(2, GFP_KERNEL);
+	if (!rep_data) {
+		result = -ENOMEM;
+		goto out1;
+	}
+
 	/* retrive report descriptors */
 	do {
 		result = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
@@ -258,7 +267,7 @@ static int wacom_parse_hid(struct usb_interface *intf,
 
 	/* No need to parse the Descriptor. It isn't an error though */
 	if (result < 0)
-		goto out;
+		goto out2;
 
 	for (i = 0; i < hid_desc->wDescriptorLength; i++) {
 
@@ -286,16 +295,19 @@ static int wacom_parse_hid(struct usb_interface *intf,
 						if (features->type == TABLETPC2FG) {
 							/* need to reset back */
 							features->pktlen = WACOM_PKGLEN_TPC2FG;
+							features->touch_max = 2;
 						}
 						if (features->type == BAMBOO_PT) {
 							/* need to reset back */
 							features->pktlen = WACOM_PKGLEN_BBTOUCH;
+							features->touch_max = 2;
 							features->x_phy =
 								get_unaligned_le16(&report[i + 5]);
 							features->x_max =
 								get_unaligned_le16(&report[i + 8]);
 							i += 15;
 						} else {
+							features->touch_max = 1;
 							features->x_max =
 								get_unaligned_le16(&report[i + 3]);
 							features->x_phy =
@@ -369,6 +381,19 @@ static int wacom_parse_hid(struct usb_interface *intf,
 				pen = 1;
 				i++;
 				break;
+
+			case HID_MT_CONTACTMAX:
+				do {
+					rep_data[0] = 12;
+					result = wacom_get_report(intf,
+						WAC_HID_FEATURE_REPORT, rep_data[0],
+						rep_data, 2, 1);
+				} while (result < 0 && limit++ < WAC_MSG_RETRIES);
+
+				if ((result >= 0) && (rep_data[1] > 2))
+					features->touch_max = rep_data[1];
+				i++;
+				break;
 			}
 			break;
 
@@ -389,9 +414,9 @@ static int wacom_parse_hid(struct usb_interface *intf,
 		}
 	}
 
- out:
-	result = 0;
-	kfree(report);
+ out2:	result = 0;
+	kfree(rep_data);
+ out1:	kfree(report);
 	return result;
 }
 
@@ -873,7 +898,8 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 
 	endpoint = &intf->cur_altsetting->endpoint[0].desc;
 
-	/* Retrieve the physical and logical size for OEM devices */
+	/* Retrieve the physical and logical size for touch devices */
+	features->touch_max = 0;
 	error = wacom_retrieve_hid_descriptor(intf, features);
 	if (error)
 		goto fail3;
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index e18f362..33a4359 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -830,7 +830,8 @@ static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
 {
 	char *data = wacom->data;
 
-	dbg("wacom_tpc_irq: received report #%d", data[0]);
+	dbg("wacom_tpc_irq: received report #%d with %d contacts",
+	     data[0], wacom->features.touch_max);
 
 	if (len == WACOM_PKGLEN_TPC1FG || data[0] == WACOM_REPORT_TPC1FG)
 		return wacom_tpc_single_touch(wacom, len);
@@ -1319,7 +1320,7 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 	case TABLETPC2FG:
 		if (features->device_type == BTN_TOOL_FINGER) {
 
-			input_mt_init_slots(input_dev, 2);
+			input_mt_init_slots(input_dev, features->touch_max);
 			input_set_abs_params(input_dev, ABS_MT_TOOL_TYPE,
 					0, MT_TOOL_MAX, 0, 0);
 			input_set_abs_params(input_dev, ABS_MT_POSITION_X,
@@ -1374,6 +1375,7 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 
 			__set_bit(BTN_TOOL_FINGER, input_dev->keybit);
 			__set_bit(BTN_TOOL_DOUBLETAP, input_dev->keybit);
+			input_mt_init_slots(input_dev, features->touch_max);
 
 			if (features->pktlen == WACOM_PKGLEN_BBTOUCH3) {
 				__set_bit(BTN_TOOL_TRIPLETAP,
@@ -1381,13 +1383,9 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
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
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index 050acae..6ddd2e4 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -89,6 +89,7 @@ struct wacom_features {
 	int pressure_fuzz;
 	int distance_fuzz;
 	unsigned quirks;
+	unsigned touch_max;
 };
 
 struct wacom_shared {
-- 
1.7.6.4

