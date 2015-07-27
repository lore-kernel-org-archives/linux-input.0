From: Reilly Grant <reillyg@chromium.org>
Subject: [PATCH] HID: use generic driver for ThingM blink(1) if !CONFIG_HID_THINGM
Date: Mon, 27 Jul 2015 12:17:06 -0700
Message-ID: <1438024626-36448-1-git-send-email-reillyg@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34200 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbbG0TRT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jul 2015 15:17:19 -0400
Received: by pdbbh15 with SMTP id bh15so56675463pdb.1
        for <linux-input@vger.kernel.org>; Mon, 27 Jul 2015 12:17:18 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Reilly Grant <reillyg@chromium.org>

In commit 30ba2fbde1840db44 an LED class driver for this device was
added and at the same time it was blacklisted by the hid-generic
driver. This patch removes the device from the hid-generic driver's
blacklist if the LED class driver is not enabled.

Signed-off-by: Reilly Grant <reillyg@chromium.org>
---
 drivers/hid/hid-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index d9c7cd9..afa744f 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1978,7 +1978,9 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGP_MOUSE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_SRWS1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SUNPLUS, USB_DEVICE_ID_SUNPLUS_WDESKTOP) },
+#if IS_ENABLED(CONFIG_HID_THINGM)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THINGM, USB_DEVICE_ID_BLINK1) },
+#endif
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb300) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb304) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb323) },
-- 
2.5.0.rc2.392.g76e840b

