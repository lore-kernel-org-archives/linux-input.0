From: Kristian Evensen <kristian.evensen@gmail.com>
Subject: [PATCH] usb: hid: Do not bind to Microchip Pick16F1454
Date: Tue, 20 Jan 2015 17:55:03 +0100
Message-ID: <1421772903-27746-1-git-send-email-kristian.evensen@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:37600 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755228AbbATRDS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Jan 2015 12:03:18 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, linux-input@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Kristian Evensen <kristian.evensen@gmail.com>

The Microchip Pick16F1454 is exported as a HID device and is used by for example
the Yepkit YKUSH three-port switchable USB hub. However, it is not an actual
HID-device. On the Yepkit, it is used to power up/down the ports on the hub. The
HID driver should ignore this device.

Signed-off-by: Kristian Evensen <kristian.evensen@gmail.com>
---
 drivers/hid/hid-core.c | 1 +
 drivers/hid/hid-ids.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 8b63879..77afffc 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2328,6 +2328,7 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MCC, USB_DEVICE_ID_MCC_PMD1208LS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_PICKIT1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_PICKIT2) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_PICK16F1454) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_NATIONAL_SEMICONDUCTOR, USB_DEVICE_ID_N_S_HARMONY) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 20) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 9243359..8df4744 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -638,6 +638,7 @@
 #define USB_DEVICE_ID_PICKIT2		0x0033
 #define USB_DEVICE_ID_PICOLCD		0xc002
 #define USB_DEVICE_ID_PICOLCD_BOOTLOADER	0xf002
+#define USB_DEVICE_ID_PICK16F1454	0x0042
 
 #define USB_VENDOR_ID_MICROSOFT		0x045e
 #define USB_DEVICE_ID_SIDEWINDER_GV	0x003b
-- 
2.1.0

