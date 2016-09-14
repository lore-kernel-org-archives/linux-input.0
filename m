From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 7/9] HID: uclogic: Support UGTizer GP0610 partially
Date: Wed, 14 Sep 2016 21:38:18 +0300
Message-ID: <20160914183820.20737-8-spbnick@gmail.com>
References: <20160914101531.GJ25951@mail.corp.redhat.com>
 <20160914183820.20737-1-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33126 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759045AbcINSiq (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Sep 2016 14:38:46 -0400
Received: by mail-wm0-f66.google.com with SMTP id b187so3752974wme.0
        for <linux-input@vger.kernel.org>; Wed, 14 Sep 2016 11:38:46 -0700 (PDT)
In-Reply-To: <20160914183820.20737-1-spbnick@gmail.com>
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
 drivers/hid/hid-core.c    |  1 +
 drivers/hid/hid-ids.h     |  3 +++
 drivers/hid/hid-uclogic.c | 14 ++++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index df2770a..e21ac0b 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2087,6 +2087,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UGEE_TABLET_81) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UGEE_TABLET_45) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_DRAWIMAGE_G3) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_UGTIZER, USB_DEVICE_ID_UGTIZER_TABLET_GP0610) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_SMARTJOY_PLUS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_SUPER_JOY_BOX_3) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_DUAL_USB_JOYPAD) },
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

