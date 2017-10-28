From: Mustafa Kuscu <mustafakuscu@gmail.com>
Subject: [PATCH] add backlight level quirk for Asus ROG laptops
Date: Sat, 28 Oct 2017 10:31:40 +0300
Message-ID: <20171028073140.12807-1-mustafakuscu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org, Mustafa C Kuscu <mustafakuscu@gmail.com>
List-Id: linux-input@vger.kernel.org

On laptops such as Asus GL553VD, setting keyboard backlight levels 
does not work. This change enables F3/F4 keys to set backlight levels 
(from 0 to 3, total 4 levels) on such laptops. 

It is intended only to the following device: 0x0b05 1854:
P: Vendor=0b05 ProdID=1854 Rev=03.02
S: Manufacturer=ITE Tech. Inc.
S: Product=ITE Device(8910)

Note: Just reloading the hid_asus module would not suffice, reload 
the whole thing or reboot, you know.

Signed-off-by: Mustafa C Kuscu <mustafakuscu@gmail.com>
diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index a4a3c38bc145..39068eddc03c 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -593,7 +593,7 @@ static const struct hid_device_id asus_devices[] = {
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
 		USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD), I2C_TOUCHPAD_QUIRKS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
-		USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1) },
+		USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1), QUIRK_USE_KBD_BACKLIGHT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 		USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2), QUIRK_USE_KBD_BACKLIGHT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
