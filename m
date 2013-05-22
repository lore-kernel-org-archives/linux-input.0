From: Vincent Palatin <vpalatin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] HID: usbhid: ignore Jabra speakerphones HID interface
Date: Wed, 22 May 2013 14:17:54 -0700
Message-ID: <1369257474-26389-1-git-send-email-vpalatin@chromium.org>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Olof Johansson <olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Vincent Palatin <vpalatin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Add a quirk to ignore Jabra speakerphone 410 and 510 devices HID
interface.
On those devices, the USB audio interface is working nicely,
but the HID interface is not working with the kernel usbhid driver,
and it requires a specific userspace program.
We could unbind it from userspace but just attaching the usbhid driver has
sometimes nasty effects:
either confusing the device state machine or triggering a storm of volume key
events making eventual sound UI blinking like crazy.

Signed-off-by: Vincent Palatin <vpalatin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/hid/hid-ids.h           | 4 ++++
 drivers/hid/usbhid/hid-quirks.c | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 38535c9..533815b 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -447,6 +447,10 @@
 #define USB_VENDOR_ID_IRTOUCHSYSTEMS	0x6615
 #define USB_DEVICE_ID_IRTOUCH_INFRARED_USB	0x0070
 
+#define USB_VENDOR_ID_JABRA		0x0b0e
+#define USB_DEVICE_ID_JABRA_SPEAK_410	0x0412
+#define USB_DEVICE_ID_JABRA_SPEAK_510	0x0420
+
 #define USB_VENDOR_ID_JESS		0x0c45
 #define USB_DEVICE_ID_JESS_YUREX	0x1010
 
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 19b8360..d8c9aaf 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -109,6 +109,9 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_SIGMA_MICRO, USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M610X, HID_QUIRK_MULTI_INPUT },
+
+	{ USB_VENDOR_ID_JABRA, USB_DEVICE_ID_JABRA_SPEAK_410, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_JABRA, USB_DEVICE_ID_JABRA_SPEAK_510, HID_QUIRK_IGNORE },
 	{ 0, 0 }
 };
 
-- 
1.8.2.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
