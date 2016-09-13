From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 7/9] HID: uclogic: Support UGTizer GP0610 partially
Date: Tue, 13 Sep 2016 17:08:41 +0300
Message-ID: <20160913140843.25567-8-spbnick@gmail.com>
References: <20160913140843.25567-1-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33907 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbcIMOJN (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Sep 2016 10:09:13 -0400
Received: by mail-wm0-f66.google.com with SMTP id g141so7500459wmd.1
        for <linux-input@vger.kernel.org>; Tue, 13 Sep 2016 07:09:13 -0700 (PDT)
In-Reply-To: <20160913140843.25567-1-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, Nikolai Kondrashov <spbnick@gmail.com>

Add partial support for the UGTizer GP0610 tablet (aka iBall PF1064U,
aka UGTizer GT1060) to the hid-uclogic.c driver.

The pen input is supported fully, but frame buttons and wheel don't work
yet.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
---
 drivers/hid/hid-ids.h     |  3 +++
 drivers/hid/hid-uclogic.c | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 6ef9dbf..15067a9 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1089,4 +1089,7 @@
 #define USB_DEVICE_ID_RAPHNET_2NES2SNES	0x0002
 #define USB_DEVICE_ID_RAPHNET_4NES4SNES	0x0003
 
+#define USB_VENDOR_ID_UGTIZER			0x2179
+#define USB_DEVICE_ID_UGTIZER_TABLET_GP0610	0x0053
+
 #endif
diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
index f4377c4..72778b3 100644
--- a/drivers/hid/hid-uclogic.c
+++ b/drivers/hid/hid-uclogic.c
@@ -974,6 +974,19 @@ static int uclogic_probe(struct hid_device *hdev,
 			drvdata->ignore_pen_usage = true;
 		}
 		break;
+	case USB_DEVICE_ID_UGTIZER_TABLET_GP0610:
+		/* If this is the pen interface */
+		if (intf->cur_altsetting->desc.bInterfaceNumber == 1) {
+			rc = uclogic_tablet_enable(hdev);
+			if (rc) {
+				hid_err(hdev, "tablet enabling failed\n");
+				return rc;
+			}
+			drvdata->invert_pen_inrange = true;
+		} else {
+			drvdata->ignore_pen_usage = true;
+		}
+		break;
 	}
 
 	rc = hid_parse(hdev);
@@ -1031,6 +1044,7 @@ static const struct hid_device_id uclogic_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UGEE_TABLET_81) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UGEE_TABLET_45) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_DRAWIMAGE_G3) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_UGTIZER, USB_DEVICE_ID_UGTIZER_TABLET_GP0610) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, uclogic_devices);
-- 
2.9.3

