From: Peter Stein <peter@stuntstein.dk>
Subject: [PATCH] Fix for out of range for THT 2P arcade controller.
Date: Fri, 17 Feb 2017 00:00:50 -0800
Message-ID: <1487318450-11136-1-git-send-email-peter@stuntstein.dk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35547 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753744AbdBQICm (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 17 Feb 2017 03:02:42 -0500
Received: by mail-pg0-f65.google.com with SMTP id y6so3209951pgy.2
        for <linux-input@vger.kernel.org>; Fri, 17 Feb 2017 00:02:42 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org, linux-input@vger.kernel.org
Cc: trivial@kernel.org, Peter Stein <peter@stuntstein.dk>

There is a new clone of the XIN MO arcade controller which has same issue with out of range like the original.
This fix will solve the issue where 2 directions on the joystick are not recognized by the new THT 2P arcade controller with device ID 0x75e1.
In details the new device ID is added the hid-id list and the hid-xinmo source code.

Signed-off-by: Peter Stein <peter@stuntstein.dk>
{sent from git}

---
 drivers/hid/hid-core.c  | 1 +
 drivers/hid/hid-ids.h   | 1 +
 drivers/hid/hid-xinmo.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 936960202cf4..24586876d43e 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2052,6 +2052,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_SIRIUS_BATTERY_FREE_TABLET) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_X_TENSIONS, USB_DEVICE_ID_SPEEDLINK_VAD_CEZANNE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_XIN_MO, USB_DEVICE_ID_XIN_MO_DUAL_ARCADE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_XIN_MO, USB_DEVICE_ID_THT_2P_ARCADE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0005) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0030) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ZYDACRON, USB_DEVICE_ID_ZYDACRON_REMOTE_CONTROL) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index e37030624165..5e985046b255 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1014,6 +1014,7 @@
 
 #define USB_VENDOR_ID_XIN_MO			0x16c0
 #define USB_DEVICE_ID_XIN_MO_DUAL_ARCADE	0x05e1
+#define USB_DEVICE_ID_THT_2P_ARCADE		0x75e1
 
 #define USB_VENDOR_ID_XIROKU		0x1477
 #define USB_DEVICE_ID_XIROKU_SPX	0x1006
diff --git a/drivers/hid/hid-xinmo.c b/drivers/hid/hid-xinmo.c
index 7df5227a7e61..9ad7731d2e10 100644
--- a/drivers/hid/hid-xinmo.c
+++ b/drivers/hid/hid-xinmo.c
@@ -46,6 +46,7 @@ static int xinmo_event(struct hid_device *hdev, struct hid_field *field,
 
 static const struct hid_device_id xinmo_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_XIN_MO, USB_DEVICE_ID_XIN_MO_DUAL_ARCADE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_XIN_MO, USB_DEVICE_ID_THT_2P_ARCADE) },
 	{ }
 };
 
-- 
2.7.4

