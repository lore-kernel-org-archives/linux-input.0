From: Peter Hutterer <peter.hutterer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] HID: add multi-input quirk for NextWindow Touchscreen.
Date: Thu, 3 Dec 2009 15:08:10 +1000
Message-ID: <20091203050810.GA26595@barra.bne.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

These touchscreens are mounted onto HP TouchSmart and the Dell Studio One
19. Without a quirk they report a wrong button set and the x/y coordinates
through ABS_Z/ABS_RX, confusing the higher levels (most notably X.Org's
evdev driver).

Device id 0x003 covers models 1900, 2150, and 2700 [1] though testing could
only be performed on a model 1900.

[1] http://www.nextwindow.com/nextwindow_support/latest_tech_info.html

Signed-off-by: Peter Hutterer <peter.hutterer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/hid/hid-ids.h           |    3 +++
 drivers/hid/usbhid/hid-quirks.c |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index adbef5d..f5144b8 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -346,6 +346,9 @@
 #define USB_VENDOR_ID_NEC		0x073e
 #define USB_DEVICE_ID_NEC_USB_GAME_PAD	0x0301
 
+#define USB_VENDOR_ID_NEXTWINDOW	0x1926
+#define USB_DEVICE_ID_NEXTWINDOW_TOUCHSCREEN	0x0003
+
 #define USB_VENDOR_ID_NTRIG                0x1b96
 #define USB_DEVICE_ID_NTRIG_TOUCH_SCREEN   0x0001
 
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 0d9045a..e987562 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -37,6 +37,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FIGHTING, HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_NATSU, USB_DEVICE_ID_NATSU_GAMEPAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_NEC, USB_DEVICE_ID_NEC_USB_GAME_PAD, HID_QUIRK_BADPAD },
+	{ USB_VENDOR_ID_NEXTWINDOW, USB_DEVICE_ID_NEXTWINDOW_TOUCHSCREEN, HID_QUIRK_MULTI_INPUT},
 	{ USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RUMBLEPAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_TOPMAX, USB_DEVICE_ID_TOPMAX_COBRAPAD, HID_QUIRK_BADPAD },
 
-- 
1.6.5.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
