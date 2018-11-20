From: Sebastian Parschauer <sparschauer@suse.de>
Subject: [PATCH] HID: Add quirk for Primax PIXART OEM mice
Date: Tue, 20 Nov 2018 07:25:08 +0100
Message-ID: <20181120062508.4567-1-sparschauer@suse.de>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Sebastian Parschauer <sparschauer@suse.de>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The PixArt OEM mice are known for disconnecting every minute in
runlevel 1 or 3 if they are not always polled. So add quirk
ALWAYS_POLL for two Primax mice as well.

0x4e22 is the Dell MS111-P and 0x4d0f is the unbranded HP Portia
mouse HP 697738-001. Both were built until approx. 2014.
Those were the standard mice from those vendors and are still
around - even as new old stock.

Reference: https://github.com/sriemer/fix-linux-mouse/issues/11

Signed-off-by: Sebastian Parschauer <sparschauer@suse.de>
CC: stable@vger.kernel.org
---
 drivers/hid/hid-ids.h    | 2 ++
 drivers/hid/hid-quirks.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 2114ac647bef..ed35c9a9a110 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1210,6 +1210,8 @@
 #define USB_DEVICE_ID_PRIMAX_MOUSE_4D22	0x4d22
 #define USB_DEVICE_ID_PRIMAX_KEYBOARD	0x4e05
 #define USB_DEVICE_ID_PRIMAX_REZEL	0x4e72
+#define USB_DEVICE_ID_PRIMAX_PIXART_MOUSE_4D0F	0x4d0f
+#define USB_DEVICE_ID_PRIMAX_PIXART_MOUSE_4E22	0x4e22
 
 
 #define USB_VENDOR_ID_RISO_KAGAKU	0x1294	/* Riso Kagaku Corp. */
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index d82e5ab48837..c85a79986b6a 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -130,6 +130,8 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_USB_OPTICAL_MOUSE), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_MOUSE_4D22), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_PIXART_MOUSE_4D0F), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_PIXART_MOUSE_4E22), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PRODIGE, USB_DEVICE_ID_PRODIGE_CORDLESS), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3001), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3003), HID_QUIRK_NOGET },
-- 
2.13.7
