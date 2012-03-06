From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 3/3] HID: waltop: Add support for tablet with PID 0038
Date: Tue,  6 Mar 2012 09:54:24 +0200
Message-ID: <1331020464-3962-3-git-send-email-spbnick@gmail.com>
References: <1331020464-3962-1-git-send-email-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:41298 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758365Ab2CFHyu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Mar 2012 02:54:50 -0500
Received: by wibhm2 with SMTP id hm2so2435067wib.19
        for <linux-input@vger.kernel.org>; Mon, 05 Mar 2012 23:54:48 -0800 (PST)
In-Reply-To: <1331020464-3962-1-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>, Nikolai Kondrashov <spbnick@gmail.com>

Add support for unknown Waltop tablet with product ID 0x0038.
This tablet is sold as Genius G-Pen F509.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
---
 drivers/hid/hid-core.c   |    1 +
 drivers/hid/hid-ids.h    |    1 +
 drivers/hid/hid-waltop.c |  148 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 6d923bd..02e32c1 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1568,6 +1568,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_SLIM_TABLET_5_8_INCH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_SLIM_TABLET_12_1_INCH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_Q_PAD) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_PID_0038) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_MEDIA_TABLET_10_6_INCH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_MEDIA_TABLET_14_1_INCH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_XAT, USB_DEVICE_ID_XAT_CSR) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 0ce075b..c583077 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -718,6 +718,7 @@
 #define USB_DEVICE_ID_WALTOP_SLIM_TABLET_5_8_INCH	0x0032
 #define USB_DEVICE_ID_WALTOP_SLIM_TABLET_12_1_INCH	0x0034
 #define USB_DEVICE_ID_WALTOP_Q_PAD			0x0037
+#define USB_DEVICE_ID_WALTOP_PID_0038			0x0038
 #define USB_DEVICE_ID_WALTOP_MEDIA_TABLET_10_6_INCH	0x0501
 #define USB_DEVICE_ID_WALTOP_MEDIA_TABLET_14_1_INCH	0x0500
 
diff --git a/drivers/hid/hid-waltop.c b/drivers/hid/hid-waltop.c
index c1dce51..2cfd95c 100644
--- a/drivers/hid/hid-waltop.c
+++ b/drivers/hid/hid-waltop.c
@@ -211,6 +211,64 @@ static __u8 q_pad_rdesc_fixed[] = {
 };
 
 /*
+ * See description, device and HID report descriptors of tablet with PID 0038 at
+ * http://sf.net/apps/mediawiki/digimend/?title=Waltop_PID_0038
+ */
+
+/* Size of the original report descriptor of tablet with PID 0038 */
+#define PID_0038_RDESC_ORIG_SIZE	241
+
+/*
+ * Fixed report descriptor for tablet with PID 0038.
+ */
+static __u8 pid_0038_rdesc_fixed[] = {
+	0x05, 0x0D,         /*  Usage Page (Digitizer),             */
+	0x09, 0x02,         /*  Usage (Pen),                        */
+	0xA1, 0x01,         /*  Collection (Application),           */
+	0x85, 0x10,         /*      Report ID (16),                 */
+	0x09, 0x20,         /*      Usage (Stylus),                 */
+	0xA0,               /*      Collection (Physical),          */
+	0x09, 0x42,         /*          Usage (Tip Switch),         */
+	0x09, 0x44,         /*          Usage (Barrel Switch),      */
+	0x09, 0x46,         /*          Usage (Tablet Pick),        */
+	0x15, 0x01,         /*          Logical Minimum (1),        */
+	0x25, 0x03,         /*          Logical Maximum (3),        */
+	0x75, 0x04,         /*          Report Size (4),            */
+	0x95, 0x01,         /*          Report Count (1),           */
+	0x80,               /*          Input,                      */
+	0x09, 0x32,         /*          Usage (In Range),           */
+	0x14,               /*          Logical Minimum (0),        */
+	0x25, 0x01,         /*          Logical Maximum (1),        */
+	0x75, 0x01,         /*          Report Size (1),            */
+	0x95, 0x01,         /*          Report Count (1),           */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x95, 0x03,         /*          Report Count (3),           */
+	0x81, 0x03,         /*          Input (Constant, Variable), */
+	0x75, 0x10,         /*          Report Size (16),           */
+	0x95, 0x01,         /*          Report Count (1),           */
+	0x14,               /*          Logical Minimum (0),        */
+	0xA4,               /*          Push,                       */
+	0x05, 0x01,         /*          Usage Page (Desktop),       */
+	0x65, 0x13,         /*          Unit (Inch),                */
+	0x55, 0xFD,         /*          Unit Exponent (-3),         */
+	0x34,               /*          Physical Minimum (0),       */
+	0x09, 0x30,         /*          Usage (X),                  */
+	0x46, 0x2E, 0x22,   /*          Physical Maximum (8750),    */
+	0x26, 0x00, 0x46,   /*          Logical Maximum (17920),    */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x09, 0x31,         /*          Usage (Y),                  */
+	0x46, 0x82, 0x14,   /*          Physical Maximum (5250),    */
+	0x26, 0x00, 0x2A,   /*          Logical Maximum (10752),    */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0xB4,               /*          Pop,                        */
+	0x09, 0x30,         /*          Usage (Tip Pressure),       */
+	0x26, 0xFF, 0x03,   /*          Logical Maximum (1023),     */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0xC0,               /*      End Collection,                 */
+	0xC0                /*  End Collection                      */
+};
+
+/*
  * See Media Tablet 10.6 inch description, device and HID report descriptors at
  * http://sf.net/apps/mediawiki/digimend/?title=Waltop_Media_Tablet_10.6%22
  */
@@ -444,6 +502,47 @@ static __u8 media_tablet_14_1_inch_rdesc_fixed[] = {
 	0xC0                /*  End Collection                      */
 };
 
+struct waltop_state {
+	u8 pressure0;
+	u8 pressure1;
+};
+
+static int waltop_probe(struct hid_device *hdev,
+			const struct hid_device_id *id)
+{
+	int ret;
+	struct waltop_state *s;
+
+	s = kzalloc(sizeof(*s), GFP_KERNEL);
+	if (s == NULL) {
+		hid_err(hdev, "can't allocate device state\n");
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	s->pressure0 = 0;
+	s->pressure1 = 0;
+
+	hid_set_drvdata(hdev, s);
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "parse failed\n");
+		goto err;
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret) {
+		hid_err(hdev, "hw start failed\n");
+		goto err;
+	}
+
+	return 0;
+err:
+	kfree(s);
+	return ret;
+}
+
 static __u8 *waltop_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
@@ -466,6 +565,12 @@ static __u8 *waltop_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 			*rsize = sizeof(q_pad_rdesc_fixed);
 		}
 		break;
+	case USB_DEVICE_ID_WALTOP_PID_0038:
+		if (*rsize == PID_0038_RDESC_ORIG_SIZE) {
+			rdesc = pid_0038_rdesc_fixed;
+			*rsize = sizeof(pid_0038_rdesc_fixed);
+		}
+		break;
 	case USB_DEVICE_ID_WALTOP_MEDIA_TABLET_10_6_INCH:
 		if (*rsize == MEDIA_TABLET_10_6_INCH_RDESC_ORIG_SIZE) {
 			rdesc = media_tablet_10_6_inch_rdesc_fixed;
@@ -482,6 +587,44 @@ static __u8 *waltop_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	return rdesc;
 }
 
+static int waltop_raw_event(struct hid_device *hdev, struct hid_report *report,
+		     u8 *data, int size)
+{
+	/* If this is a pen input report of a tablet with PID 0038 */
+	if (hdev->product == USB_DEVICE_ID_WALTOP_PID_0038 &&
+	    report->type == HID_INPUT_REPORT &&
+	    report->id == 16 &&
+	    size == 8) {
+		struct waltop_state *s = hid_get_drvdata(hdev);
+
+		/*
+		 * Ignore maximum pressure reported when a barrel button is
+		 * pressed.
+		 */
+
+		/* If a barrel button is pressed */
+		if ((data[1] & 0xF) > 1) {
+			/* Use the last known pressure */
+			data[6] = s->pressure0;
+			data[7] = s->pressure1;
+		} else {
+			/* Remember reported pressure */
+			s->pressure0 = data[6];
+			s->pressure1 = data[7];
+		}
+	}
+
+	return 0;
+}
+
+static void waltop_remove(struct hid_device *hdev)
+{
+	struct waltop_state *s = hid_get_drvdata(hdev);
+
+	hid_hw_stop(hdev);
+	kfree(s);
+}
+
 static const struct hid_device_id waltop_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP,
 				USB_DEVICE_ID_WALTOP_SLIM_TABLET_5_8_INCH) },
@@ -490,6 +633,8 @@ static const struct hid_device_id waltop_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP,
 				USB_DEVICE_ID_WALTOP_Q_PAD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP,
+				USB_DEVICE_ID_WALTOP_PID_0038) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP,
 				USB_DEVICE_ID_WALTOP_MEDIA_TABLET_10_6_INCH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP,
 				USB_DEVICE_ID_WALTOP_MEDIA_TABLET_14_1_INCH) },
@@ -500,7 +645,10 @@ MODULE_DEVICE_TABLE(hid, waltop_devices);
 static struct hid_driver waltop_driver = {
 	.name = "waltop",
 	.id_table = waltop_devices,
+	.probe = waltop_probe,
 	.report_fixup = waltop_report_fixup,
+	.raw_event = waltop_raw_event,
+	.remove = waltop_remove,
 };
 
 static int __init waltop_init(void)
-- 
1.7.9

