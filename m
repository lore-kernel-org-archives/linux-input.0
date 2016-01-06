From: Kristian Evensen <kristian.evensen@gmail.com>
Subject: [PATCH] usb: hid: Add new PID for Microchip Pick16F1454
Date: Wed,  6 Jan 2016 15:08:53 +0100
Message-ID: <1452089333-32671-1-git-send-email-kristian.evensen@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Kristian Evensen <kristian.evensen@gmail.com>
List-Id: linux-input@vger.kernel.org

From: Kristian Evensen <kristian.evensen@gmail.com>

There seems to be a new version of the Microchip Pick16F1454 with a
different PID (0xf2f7). This device should also be ignored by the HID
driver. The PID was observed with the second version of the Yepkit Ykush
USB hub.

Signed-off-by: Kristian Evensen <kristian.evensen@gmail.com>
---
 drivers/hid/hid-core.c | 1 +
 drivers/hid/hid-ids.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index c6f7a69..ab3b86c 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2408,6 +2408,7 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_PICKIT1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_PICKIT2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_PICK16F1454) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_PICK16F1454_V2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_NATIONAL_SEMICONDUCTOR, USB_DEVICE_ID_N_S_HARMONY) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 20) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 8b78a7f..16d3077 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -664,6 +664,7 @@
 #define USB_DEVICE_ID_PICOLCD		0xc002
 #define USB_DEVICE_ID_PICOLCD_BOOTLOADER	0xf002
 #define USB_DEVICE_ID_PICK16F1454	0x0042
+#define USB_DEVICE_ID_PICK16F1454_V2	0xf2f7
 
 #define USB_VENDOR_ID_MICROSOFT		0x045e
 #define USB_DEVICE_ID_SIDEWINDER_GV	0x003b
-- 
2.5.0
