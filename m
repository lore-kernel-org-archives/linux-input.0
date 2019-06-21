From: Oleksandr Natalenko <oleksandr@redhat.com>
Subject: [PATCH] hid: add another quirk for Chicony PixArt mouse
Date: Fri, 21 Jun 2019 11:17:36 +0200
Message-ID: <20190621091736.14503-1-oleksandr@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Sebastian Parschauer <sparschauer@suse.de>, Dave Young <dyoung@redhat.com>, "Herton R . Krzesinski" <herton@redhat.com>, Oliver Neukum <oneukum@suse.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

I've spotted another Chicony PixArt mouse in the wild, which requires
HID_QUIRK_ALWAYS_POLL quirk, otherwise it disconnects each minute.

USB ID of this device is 0x04f2:0x0939.

We've introduced quirks like this for other models before, so lets add
this mouse too.

Link: https://github.com/sriemer/fix-linux-mouse#usb-mouse-disconnectsreconnects-every-minute-on-linux
Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 drivers/hid/hid-ids.h    | 1 +
 drivers/hid/hid-quirks.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index eac0c54c5970..69f0553d9d95 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -269,6 +269,7 @@
 #define USB_DEVICE_ID_CHICONY_MULTI_TOUCH	0xb19d
 #define USB_DEVICE_ID_CHICONY_WIRELESS	0x0618
 #define USB_DEVICE_ID_CHICONY_PIXART_USB_OPTICAL_MOUSE	0x1053
+#define USB_DEVICE_ID_CHICONY_PIXART_USB_OPTICAL_MOUSE2	0x0939
 #define USB_DEVICE_ID_CHICONY_WIRELESS2	0x1123
 #define USB_DEVICE_ID_ASUS_AK1D		0x1125
 #define USB_DEVICE_ID_CHICONY_TOSHIBA_WT10A	0x1408
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index e5ca6fe2ca57..671a285724f9 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -42,6 +42,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_UC100KM), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_MULTI_TOUCH), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_PIXART_USB_OPTICAL_MOUSE), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_PIXART_USB_OPTICAL_MOUSE2), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_WIRELESS), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHIC, USB_DEVICE_ID_CHIC_GAMEPAD), HID_QUIRK_BADPAD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_3AXIS_5BUTTON_STICK), HID_QUIRK_NOGET },
-- 
2.22.0
