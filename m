From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH] HID: usbhid: enable NO_INIT_REPORTS quirk for Semico USB Keykoard2
Date: Thu, 10 Mar 2016 14:17:58 -0300
Message-ID: <62d658ca26c60f0f1ab9d4bb6f4e2687e8bf05c1.1457629721.git.bristot@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42581 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752563AbcCJRSX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Mar 2016 12:18:23 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, Torez Smith <torez@redhat.com>

The device which identifies itself as a "USB Keykoard" (no typo)
with VID:PID 1a2c:0027 does not seem to be handling the reports
initialization very well.

This results in a "usb_submit_urb(ctrl) failed: -1" message from the
kernel when connected, and a delay before its initialization. It can
also cause the hang the system.

This patch adds the  quirk for this device, which causes the delay
to disappear. It is named as "USB Keykoard2" because the "USB Keykoard"
already exists.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 drivers/hid/hid-ids.h           | 1 +
 drivers/hid/usbhid/hid-quirks.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b6ff6e7..cae8f01 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -839,6 +839,7 @@
 
 #define USB_VENDOR_ID_SEMICO			0x1a2c
 #define USB_DEVICE_ID_SEMICO_USB_KEYKOARD	0x0023
+#define USB_DEVICE_ID_SEMICO_USB_KEYKOARD2	0x0027
 
 #define USB_VENDOR_ID_SENNHEISER	0x1395
 #define USB_DEVICE_ID_SENNHEISER_BTD500USB	0x002c
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 7dd0953..d289264 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -140,6 +140,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_PENSKETCH_M912, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_DUOSENSE, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_SEMICO, USB_DEVICE_ID_SEMICO_USB_KEYKOARD, HID_QUIRK_NO_INIT_REPORTS },
+	{ USB_VENDOR_ID_SEMICO, USB_DEVICE_ID_SEMICO_USB_KEYKOARD2, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_LTS1, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_LTS2, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_HD, HID_QUIRK_NO_INIT_REPORTS },
-- 
2.5.0

