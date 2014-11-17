From: Oliver Neukum <oneukum@suse.de>
Subject: [PATCH] HID: yet another buggy ELAN touchscreen
Date: Mon, 17 Nov 2014 17:11:42 +0100
Message-ID: <1416240702-28988-1-git-send-email-oneukum@suse.de>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: jkosina@suse.cz, linux-input@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.de>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The touchscreen needs the same quirk as the other models.

Signed-off-by: Oliver Neukum <oneukum@suse.de>
Reported-by: Bryan Poling <poli0048@umn.edu>
CC: stable@vger.kernel.org
---
 drivers/hid/hid-ids.h           | 1 +
 drivers/hid/usbhid/hid-quirks.c | 1 +
 drivers/usb/core/quirks.c       | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index e23ab8b..282ffbe 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -299,6 +299,7 @@
 #define USB_VENDOR_ID_ELAN		0x04f3
 #define USB_DEVICE_ID_ELAN_TOUCHSCREEN	0x0089
 #define USB_DEVICE_ID_ELAN_TOUCHSCREEN_009B	0x009b
+#define USB_DEVICE_ID_ELAN_TOUCHSCREEN_010c	0x010c
 #define USB_DEVICE_ID_ELAN_TOUCHSCREEN_016F	0x016f
 
 #define USB_VENDOR_ID_ELECOM		0x056e
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 5014bb5..08b9626 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -72,6 +72,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN_009B, HID_QUIRK_ALWAYS_POLL },
+	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN_010c, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN_016F, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2700, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_FORMOSA, USB_DEVICE_ID_FORMOSA_IR_RECEIVER, HID_QUIRK_NO_INIT_REPORTS },
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 39b4081..8e8bc4f 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -100,6 +100,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x04f3, 0x009b), .driver_info =
 			USB_QUIRK_DEVICE_QUALIFIER },
 
+	{ USB_DEVICE(0x04f3, 0x010c), .driver_info =
+			USB_QUIRK_DEVICE_QUALIFIER },
+
 	{ USB_DEVICE(0x04f3, 0x016f), .driver_info =
 			USB_QUIRK_DEVICE_QUALIFIER },
 
-- 
1.8.4.5
