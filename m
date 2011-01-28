From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 2/3] Input: add support for DragonRise PID 0011 gamepad
Date: Fri, 28 Jan 2011 14:50:52 +0300
Message-ID: <1296215454-2586-3-git-send-email-spbnick@gmail.com>
References: <1296215454-2586-1-git-send-email-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:33977 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754749Ab1A1LvR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jan 2011 06:51:17 -0500
Received: by mail-ew0-f46.google.com with SMTP id 5so1444229ewy.19
        for <linux-input@vger.kernel.org>; Fri, 28 Jan 2011 03:51:16 -0800 (PST)
In-Reply-To: <1296215454-2586-1-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Vladislav Naumov <vnaum@vnaum.com>, Nikolai Kondrashov <spbnick@gmail.com>

Add support for DragonRise Inc. gamepad with USB PID 0x0011 by fixing its report
descriptor. This mainly removes spurious axis.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
---
 drivers/hid/hid-core.c |    1 +
 drivers/hid/hid-dr.c   |  117 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 117 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index d678cf3..75af1f8 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1328,6 +1328,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_MOUSE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_TRUETOUCH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, 0x0006) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, 0x0011) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH2) },
diff --git a/drivers/hid/hid-dr.c b/drivers/hid/hid-dr.c
index afcf3d6..61eece4 100644
--- a/drivers/hid/hid-dr.c
+++ b/drivers/hid/hid-dr.c
@@ -145,6 +145,110 @@ static inline int drff_init(struct hid_device *hid)
 }
 #endif
 
+/*
+ * The original descriptor of joystick with PID 0x0011, represented by DVTech PC
+ * JS19. It seems both copied from another device and a result of confusion
+ * either about the specification or about the program used to create the
+ * descriptor. In any case, it's a wonder it works on Windows.
+ *
+ *  Usage Page (Desktop),             ; Generic desktop controls (01h)
+ *  Usage (Joystik),                  ; Joystik (04h, application collection)
+ *  Collection (Application),
+ *    Collection (Logical),
+ *      Report Size (8),
+ *      Report Count (5),
+ *      Logical Minimum (0),
+ *      Logical Maximum (255),
+ *      Physical Minimum (0),
+ *      Physical Maximum (255),
+ *      Usage (X),                    ; X (30h, dynamic value)
+ *      Usage (X),                    ; X (30h, dynamic value)
+ *      Usage (X),                    ; X (30h, dynamic value)
+ *      Usage (X),                    ; X (30h, dynamic value)
+ *      Usage (Y),                    ; Y (31h, dynamic value)
+ *      Input (Variable),
+ *      Report Size (4),
+ *      Report Count (1),
+ *      Logical Maximum (7),
+ *      Physical Maximum (315),
+ *      Unit (Degrees),
+ *      Usage (00h),
+ *      Input (Variable, Null State),
+ *      Unit,
+ *      Report Size (1),
+ *      Report Count (10),
+ *      Logical Maximum (1),
+ *      Physical Maximum (1),
+ *      Usage Page (Button),          ; Button (09h)
+ *      Usage Minimum (01h),
+ *      Usage Maximum (0Ah),
+ *      Input (Variable),
+ *      Usage Page (FF00h),           ; FF00h, vendor-defined
+ *      Report Size (1),
+ *      Report Count (10),
+ *      Logical Maximum (1),
+ *      Physical Maximum (1),
+ *      Usage (01h),
+ *      Input (Variable),
+ *    End Collection,
+ *    Collection (Logical),
+ *      Report Size (8),
+ *      Report Count (4),
+ *      Physical Maximum (255),
+ *      Logical Maximum (255),
+ *      Usage (02h),
+ *      Output (Variable),
+ *    End Collection,
+ *  End Collection
+ */
+
+/* Size of the original descriptor of the PID 0x0011 joystick */
+#define PID0011_RDESC_ORIG_SIZE	101
+
+/* Fixed report descriptor for PID 0x011 joystick */
+static __u8 pid0011_rdesc_fixed[] = {
+	0x05, 0x01,         /*  Usage Page (Desktop),           */
+	0x09, 0x04,         /*  Usage (Joystik),                */
+	0xA1, 0x01,         /*  Collection (Application),       */
+	0xA1, 0x02,         /*      Collection (Logical),       */
+	0x14,               /*          Logical Minimum (0),    */
+	0x75, 0x08,         /*          Report Size (8),        */
+	0x95, 0x03,         /*          Report Count (3),       */
+	0x81, 0x01,         /*          Input (Constant),       */
+	0x26, 0xFF, 0x00,   /*          Logical Maximum (255),  */
+	0x95, 0x02,         /*          Report Count (2),       */
+	0x09, 0x30,         /*          Usage (X),              */
+	0x09, 0x31,         /*          Usage (Y),              */
+	0x81, 0x02,         /*          Input (Variable),       */
+	0x75, 0x01,         /*          Report Size (1),        */
+	0x95, 0x04,         /*          Report Count (4),       */
+	0x81, 0x01,         /*          Input (Constant),       */
+	0x25, 0x01,         /*          Logical Maximum (1),    */
+	0x95, 0x0A,         /*          Report Count (10),      */
+	0x05, 0x09,         /*          Usage Page (Button),    */
+	0x19, 0x01,         /*          Usage Minimum (01h),    */
+	0x29, 0x0A,         /*          Usage Maximum (0Ah),    */
+	0x81, 0x02,         /*          Input (Variable),       */
+	0x95, 0x0A,         /*          Report Count (10),      */
+	0x81, 0x01,         /*          Input (Constant),       */
+	0xC0,               /*      End Collection,             */
+	0xC0                /*  End Collection                  */
+};
+
+static __u8 *dr_report_fixup(struct hid_device *hdev, __u8 *rdesc,
+				unsigned int *rsize)
+{
+	switch (hdev->product) {
+	case 0x0011:
+		if (*rsize == PID0011_RDESC_ORIG_SIZE) {
+			rdesc = pid0011_rdesc_fixed;
+			*rsize = sizeof(pid0011_rdesc_fixed);
+		}
+		break;
+	}
+	return rdesc;
+}
+
 static int dr_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int ret;
@@ -163,7 +267,16 @@ static int dr_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto err;
 	}
 
-	drff_init(hdev);
+	switch (hdev->product) {
+	case 0x0006:
+		ret = drff_init(hdev);
+		if (ret) {
+			dev_err(&hdev->dev, "force feedback init failed\n");
+			hid_hw_stop(hdev);
+			goto err;
+		}
+		break;
+	}
 
 	return 0;
 err:
@@ -172,6 +285,7 @@ err:
 
 static const struct hid_device_id dr_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, 0x0006),  },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, 0x0011),  },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, dr_devices);
@@ -179,6 +293,7 @@ MODULE_DEVICE_TABLE(hid, dr_devices);
 static struct hid_driver dr_driver = {
 	.name = "dragonrise",
 	.id_table = dr_devices,
+	.report_fixup = dr_report_fixup,
 	.probe = dr_probe,
 };
 
-- 
1.7.2.3

