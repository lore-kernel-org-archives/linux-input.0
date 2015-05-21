From: "Herton R. Krzesinski" <herton@redhat.com>
Subject: [PATCH] HID: usbhid: add Chicony/Pixart usb optical mouse that needs QUIRK_ALWAYS_POLL
Date: Thu, 21 May 2015 15:04:15 -0300
Message-ID: <1432231455-4172-1-git-send-email-herton@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, herton@redhat.com
List-Id: linux-input@vger.kernel.org

I received a report from an user of following mouse which needs this quirk:

usb 1-1.6: USB disconnect, device number 58
usb 1-1.6: new low speed USB device number 59 using ehci_hcd
usb 1-1.6: New USB device found, idVendor=04f2, idProduct=1053
usb 1-1.6: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-1.6: Product: USB Optical Mouse
usb 1-1.6: Manufacturer: PixArt
usb 1-1.6: configuration #1 chosen from 1 choice
input: PixArt USB Optical Mouse as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.6/1-1.6:1.0/input/input5887
generic-usb 0003:04F2:1053.16FE: input,hidraw2: USB HID v1.11 Mouse [PixArt USB Optical Mouse] on usb-0000:00:1a.0-1.6/input0

The quirk was tested by the reporter and it fixed the frequent disconnections etc.

Signed-off-by: Herton R. Krzesinski <herton@redhat.com>
---
 drivers/hid/hid-ids.h           | 1 +
 drivers/hid/usbhid/hid-quirks.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 41f167e..b5ff1d0 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -223,6 +223,7 @@
 #define USB_DEVICE_ID_CHIC_GAMEPAD	0x0014
 
 #define USB_VENDOR_ID_CHICONY		0x04f2
+#define USB_DEVICE_ID_CHICONY_PIXART_USB_OPTICAL_MOUSE	0x1053
 #define USB_DEVICE_ID_CHICONY_TACTICAL_PAD	0x0418
 #define USB_DEVICE_ID_CHICONY_MULTI_TOUCH	0xb19d
 #define USB_DEVICE_ID_CHICONY_WIRELESS	0x0618
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index a775143..b0f7e9f4 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -69,6 +69,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_PRO_PEDALS, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_3AXIS_5BUTTON_STICK, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_AXIS_295, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_PIXART_USB_OPTICAL_MOUSE, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN_009B, HID_QUIRK_ALWAYS_POLL },
-- 
2.1.0
