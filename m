From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 9/9] HID: uclogic: Add support for UC-Logic TWHA60 v3
Date: Wed, 14 Sep 2016 21:38:20 +0300
Message-ID: <20160914183820.20737-10-spbnick@gmail.com>
References: <20160914101531.GJ25951@mail.corp.redhat.com>
 <20160914183820.20737-1-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33947 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761880AbcINSit (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Sep 2016 14:38:49 -0400
Received: by mail-wm0-f66.google.com with SMTP id g141so3783073wmd.1
        for <linux-input@vger.kernel.org>; Wed, 14 Sep 2016 11:38:49 -0700 (PDT)
In-Reply-To: <20160914183820.20737-1-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, Nikolai Kondrashov <spbnick@gmail.com>

Add support for the third version of UC-Logic TWHA60, which has
three interfaces and responds to initialization.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
---
 drivers/hid/hid-uclogic.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
index 64abd8d..1509d72 100644
--- a/drivers/hid/hid-uclogic.c
+++ b/drivers/hid/hid-uclogic.c
@@ -938,6 +938,7 @@ static int uclogic_probe(struct hid_device *hdev,
 {
 	int rc;
 	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
+	struct usb_device *udev = hid_to_usb_dev(hdev);
 	struct uclogic_drvdata *drvdata;
 
 	/*
@@ -988,6 +989,28 @@ static int uclogic_probe(struct hid_device *hdev,
 			drvdata->ignore_pen_usage = true;
 		}
 		break;
+	case USB_DEVICE_ID_UCLOGIC_TABLET_TWHA60:
+		/*
+		 * If it is the three-interface version, which is known to
+		 * respond to initialization.
+		 */
+		if (udev->config->desc.bNumInterfaces == 3) {
+			/* If it is the pen interface */
+			if (intf->cur_altsetting->desc.bInterfaceNumber == 0) {
+				rc = uclogic_tablet_enable(hdev);
+				if (rc) {
+					hid_err(hdev, "tablet enabling failed\n");
+					return rc;
+				}
+				drvdata->invert_pen_inrange = true;
+
+				rc = uclogic_button_enable(hdev);
+				drvdata->has_virtual_pad_interface = !rc;
+			} else {
+				drvdata->ignore_pen_usage = true;
+			}
+		}
+		break;
 	}
 
 	rc = hid_parse(hdev);
-- 
2.9.3

