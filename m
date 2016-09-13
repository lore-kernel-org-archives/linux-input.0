From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 6/9] HID: uclogic: Add support for several more tablets
Date: Tue, 13 Sep 2016 17:08:40 +0300
Message-ID: <20160913140843.25567-7-spbnick@gmail.com>
References: <20160913140843.25567-1-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33774 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755296AbcIMOJM (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Sep 2016 10:09:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id b187so18455778wme.0
        for <linux-input@vger.kernel.org>; Tue, 13 Sep 2016 07:09:12 -0700 (PDT)
In-Reply-To: <20160913140843.25567-1-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, Nikolai Kondrashov <spbnick@gmail.com>

Add more product IDs to hid-uclogic.c driver to support several more
tablet models, including:

	UC-Logic DrawImage G3
	aka Ugee G3
	UC-Logic SP1001
	aka Ugee SP1001
	aka Yiynova UC-Logic SP-1001
	Ugee 1000L
	Ugee M708
	Yiynova DP10U
	aka Yiynova DP10U+
	Yiynova MSP19U
	Yiynova MSP19U+
	Yiynova MVP10U
	aka Yiynova MVP10U IPS
	Yiynova MVP10UHD+IPS
	Yiynova MVP22U+

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
---
 drivers/hid/hid-ids.h     | 4 ++++
 drivers/hid/hid-uclogic.c | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 5963cf1..6ef9dbf 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -996,6 +996,10 @@
 #define USB_DEVICE_ID_UCLOGIC_TABLET_WP1062	0x0064
 #define USB_DEVICE_ID_UCLOGIC_WIRELESS_TABLET_TWHL850	0x0522
 #define USB_DEVICE_ID_UCLOGIC_TABLET_TWHA60	0x0781
+#define USB_DEVICE_ID_UCLOGIC_DRAWIMAGE_G3	0x3031
+#define USB_DEVICE_ID_UGEE_TABLET_81		0x0081
+#define USB_DEVICE_ID_UGEE_TABLET_45		0x0045
+#define USB_DEVICE_ID_YIYNOVA_TABLET		0x004d
 
 #define USB_VENDOR_ID_UNITEC	0x227d
 #define USB_DEVICE_ID_UNITEC_USB_TOUCH_0709	0x0709
diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
index 73c040d..f4377c4 100644
--- a/drivers/hid/hid-uclogic.c
+++ b/drivers/hid/hid-uclogic.c
@@ -955,6 +955,10 @@ static int uclogic_probe(struct hid_device *hdev,
 
 	switch (id->product) {
 	case USB_DEVICE_ID_HUION_TABLET:
+	case USB_DEVICE_ID_YIYNOVA_TABLET:
+	case USB_DEVICE_ID_UGEE_TABLET_81:
+	case USB_DEVICE_ID_UCLOGIC_DRAWIMAGE_G3:
+	case USB_DEVICE_ID_UGEE_TABLET_45:
 		/* If this is the pen interface */
 		if (intf->cur_altsetting->desc.bInterfaceNumber == 0) {
 			rc = uclogic_tablet_enable(hdev);
@@ -1023,6 +1027,10 @@ static const struct hid_device_id uclogic_devices[] = {
 				USB_DEVICE_ID_UCLOGIC_TABLET_TWHA60) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HUION, USB_DEVICE_ID_HUION_TABLET) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_HUION_TABLET) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_YIYNOVA_TABLET) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UGEE_TABLET_81) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UGEE_TABLET_45) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_DRAWIMAGE_G3) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, uclogic_devices);
-- 
2.9.3

