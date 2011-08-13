From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 5/5] input: wacom - retrieve maximum number of contacts
Date: Fri, 12 Aug 2011 17:10:05 -0700
Message-ID: <1313194205-5098-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:64181 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343Ab1HMAI0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Aug 2011 20:08:26 -0400
Received: by yie30 with SMTP id 30so2323815yie.19
        for <linux-input@vger.kernel.org>; Fri, 12 Aug 2011 17:08:26 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

Retrieve it from the HID descriptor when it is available

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_sys.c |   23 ++++++++++++++++++++++-
 drivers/input/tablet/wacom_wac.h |    1 +
 2 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 958b4eb..6fb292d 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -28,6 +28,7 @@
 #define HID_USAGE_Y_TILT		0x3e
 #define HID_USAGE_FINGER		0x22
 #define HID_USAGE_STYLUS		0x20
+#define HID_MT_CONTACTMAX		0x55
 #define HID_COLLECTION			0xc0
 
 enum {
@@ -151,11 +152,16 @@ static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hi
 	int result = 0;
 	int i = 0, usage = WCM_UNDEFINED, finger = 0, pen = 0;
 	unsigned char *report;
+	unsigned char *rep_data;
 
 	report = kzalloc(hid_desc->wDescriptorLength, GFP_KERNEL);
 	if (!report)
 		return -ENOMEM;
 
+	rep_data = kmalloc(2, GFP_KERNEL);
+	if (!rep_data)
+		return -ENOMEM;
+
 	/* retrive report descriptors */
 	do {
 		result = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
@@ -284,6 +290,19 @@ static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hi
 				pen = 1;
 				i++;
 				break;
+
+			case HID_MT_CONTACTMAX:
+				do {
+					rep_data[0] = 12;
+					result = usb_get_report(intf,
+						WAC_HID_FEATURE_REPORT, rep_data[0],
+						rep_data, 2);
+				} while ((result < 0) && (limit++ < WAC_MSG_RETRIES));
+
+				if ((result >= 0) && (rep_data[1] > 2))
+					features->touch_max = rep_data[1];
+				i++;
+				break;
 			}
 			break;
 
@@ -297,6 +316,7 @@ static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hi
  out:
 	result = 0;
 	kfree(report);
+	kfree(rep_data);
 	return result;
 }
 
@@ -505,7 +525,8 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 
 	endpoint = &intf->cur_altsetting->endpoint[0].desc;
 
-	/* Retrieve the physical and logical size for OEM devices */
+	/* Retrieve the physical and logical size for touch devices */
+	features->touch_max = 0;
 	error = wacom_retrieve_hid_descriptor(intf, features);
 	if (error)
 		goto fail3;
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index 53eb71b..e19e435 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -86,6 +86,7 @@ struct wacom_features {
 	int pressure_fuzz;
 	int distance_fuzz;
 	unsigned quirks;
+	unsigned touch_max;
 };
 
 struct wacom_shared {
-- 
1.7.6

