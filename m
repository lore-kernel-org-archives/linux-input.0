From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] HID: logitech: fix Dual Action gamepad support
Date: Sat, 13 Feb 2016 22:41:51 +0200
Message-ID: <1455396111-2511-1-git-send-email-notasas@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37290 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbcBMUl6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Feb 2016 15:41:58 -0500
Received: by mail-wm0-f47.google.com with SMTP id g62so61627878wme.0
        for <linux-input@vger.kernel.org>; Sat, 13 Feb 2016 12:41:57 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Grazvydas Ignotas <notasas@gmail.com>, Vitaly Katraew <zawullon@gmail.com>

The patch that added Logitech Dual Action gamepad support forgot to
update the special driver list for the device. This caused the logitech
driver not to probe unless kernel module load order was favorable.
Update the special driver list to fix it. Thanks to Simon Wood for the
idea.

Cc: Vitaly Katraew <zawullon@gmail.com>
Fixes: 56d0c8b7c8fb ("HID: add support for Logitech Dual Action gamepads")
Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/hid/hid-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index c6f7a69..f16155f5 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1897,6 +1897,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_ELITE_KBD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_CORDLESS_DESKTOP_LX500) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_EXTREME_3D) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_DUAL_ACTION) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WHEEL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD_CORD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD) },
-- 
2.7.0

