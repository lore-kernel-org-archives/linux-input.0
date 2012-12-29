From: Nicholas Santos <nicholas.santos-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/1] [PATCH] HID: usbhid: Quirk for Formosa IR receiver
Date: Fri, 28 Dec 2012 22:07:02 -0500
Message-ID: <1356750422-13372-1-git-send-email-nicholas.santos@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Nicholas Santos <nicholas.santos-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Patch to add the Formosa Industrial Computing, Inc. Infrared Receiver [IR605A/Q] to
hid-ids.h and hid-quirks.c.  This IR receiver causes about a 10 second timeout when the
usbhid driver attempts to initialze the device.  Adding this device to the quirks list with
HID_QUIRK_NO_INIT_REPORTS removes the delay.

Signed-off-by: Nicholas Santos <nicholas.santos-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/hid/hid-ids.h           |    3 +++
 drivers/hid/usbhid/hid-quirks.c |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 4dfa605..34e2547 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -306,6 +306,9 @@
 #define USB_VENDOR_ID_EZKEY		0x0518
 #define USB_DEVICE_ID_BTC_8193		0x0002

+#define USB_VENDOR_ID_FORMOSA          0x147a
+#define USB_DEVICE_ID_FORMOSA_IR_RECEIVER      0xe03e
+
 #define USB_VENDOR_ID_FREESCALE		0x15A2
 #define USB_DEVICE_ID_FREESCALE_MX28	0x004F

diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index ac9e352..90b4a38 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -72,6 +72,7 @@ static const struct hid_blacklist {
	{ USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2700, HID_QUIRK_NOGET },
	{ USB_VENDOR_ID_FREESCALE, USB_DEVICE_ID_FREESCALE_MX28, HID_QUIRK_NOGET },
	{ USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_FORMOSA, USB_DEVICE_ID_FORMOSA_IR_RECEIVER, HID_QUIRK_NO_INIT_REPORTS },
	{ USB_VENDOR_ID_NOVATEK, USB_DEVICE_ID_NOVATEK_MOUSE, HID_QUIRK_NO_INIT_REPORTS },
	{ USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN, HID_QUIRK_NO_INIT_REPORTS },
	{ USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN1, HID_QUIRK_NO_INIT_REPORTS },
--
1.7.8.6
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
