From: Laura Abbott <labbott-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org>
Subject: [PATCH] HID: usbhid: Add HID_QUIRK_NOGET for Aten DVI KVM switch
Date: Tue, 12 May 2015 10:00:00 -0700
Message-ID: <1431450000-25236-1-git-send-email-labbott@fedoraproject.org>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: Laura Abbott <labbott-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stephane.tranchemer-85dYgdK1JRdGWvitb5QawA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Like other KVM switches, the Aten DVI KVM switch needs a
quirk to avoid spewing errors:

[791759.606542] usb 1-5.4: input irq status -75 received
[791759.614537] usb 1-5.4: input irq status -75 received
[791759.622542] usb 1-5.4: input irq status -75 received

Add it.

Signed-off-by: Laura Abbott <labbott-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org>
---
 drivers/hid/hid-ids.h           | 1 +
 drivers/hid/usbhid/hid-quirks.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 41f167e..7ce93d9 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -164,6 +164,7 @@
 #define USB_DEVICE_ID_ATEN_2PORTKVM	0x2204
 #define USB_DEVICE_ID_ATEN_4PORTKVM	0x2205
 #define USB_DEVICE_ID_ATEN_4PORTKVMC	0x2208
+#define USB_DEVICE_ID_ATEN_CS682	0x2213
 
 #define USB_VENDOR_ID_ATMEL		0x03eb
 #define USB_DEVICE_ID_ATMEL_MULTITOUCH	0x211c
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index a775143..4696895e 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -61,6 +61,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_2PORTKVM, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVM, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVMC, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_CS682, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_FIGHTERSTICK, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_COMBATSTICK, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_FLIGHT_SIM_ECLIPSE_YOKE, HID_QUIRK_NOGET },
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
