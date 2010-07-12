From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 3/3] HID: Force registration of an input device for "VEC footpedal" devices
Date: Mon, 12 Jul 2010 19:28:28 +0200
Message-ID: <1278955708-9428-3-git-send-email-daniel@caiaq.de>
References: <1278955708-9428-1-git-send-email-daniel@caiaq.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:34832 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756168Ab0GLR25 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Jul 2010 13:28:57 -0400
In-Reply-To: <1278955708-9428-1-git-send-email-daniel@caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-usb@vger.kernel.org, Daniel Mack <daniel@caiaq.de>, Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

These devices report a usage page of type "consumer" and a usage of
"Programmable buttons". They are hence ignored by the hid-input layer.

Force the registration of an input device by using the new quirk type
HID_QUIRK_HIDINPUT_FORCE.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-ids.h           |    2 ++
 drivers/hid/usbhid/hid-quirks.c |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 6af77ed..0510cc1 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -505,5 +505,7 @@
 #define USB_DEVICE_ID_KYE_ERGO_525V	0x0087
 #define USB_DEVICE_ID_KYE_GPEN_560	0x5003
 
+#define USB_VENDOR_ID_PI_ENGINEERING	0x05f3
+#define USB_DEVICE_ID_PI_ENGINEERING_VEC_USB_FOOTPEDAL	0xff
 
 #endif
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 5ff8d32..12b38d1 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -73,6 +73,8 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_WISEGROUP_LTD, USB_DEVICE_ID_SMARTJOY_DUAL_PLUS, HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_WISEGROUP_LTD2, USB_DEVICE_ID_SMARTJOY_DUAL_PLUS, HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },
 
+	{ USB_VENDOR_ID_PI_ENGINEERING, USB_DEVICE_ID_PI_ENGINEERING_VEC_USB_FOOTPEDAL, HID_QUIRK_HIDINPUT_FORCE },
+
 	{ 0, 0 }
 };
 
-- 
1.7.1

