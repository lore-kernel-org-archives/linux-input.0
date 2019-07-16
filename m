From: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@archlinux.org>
Subject: [PATCH] hid-logitech-hidpp: add USB PID for some mice
Date: Tue, 16 Jul 2019 08:37:26 +0100
Message-ID: <20190716073726.6726-1-lains@archlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: nlopezcasad@logitech.com, =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@archlinux.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Signed-off-by: Filipe Laíns <lains@archlinux.org>
---
 drivers/hid/hid-logitech-hidpp.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index e3b6245bf4b2..21268c9fa71a 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3749,15 +3749,45 @@ static const struct hid_device_id hidpp_devices[] = {
 
 	{ L27MHZ_DEVICE(HID_ANY_ID) },
 
-	{ /* Logitech G403 Gaming Mouse over USB */
+	{ /* Logitech G203/Prodigy Gaming Mouse */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC084) },
+	{ /* Logitech G302 Gaming Mouse */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC07F) },
+	{ /* Logitech G303 Gaming Mouse */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC080) },
+	{ /* Logitech G400 Gaming Mouse */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC07E) },
+	{ /* Logitech G403 Wireless Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC082) },
+	{ /* Logitech G403 Gaming Mouse */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC083) },
+	{ /* Logitech G403 Hero Gaming Mouse over USB */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC08F) },
+	{ /* Logitech G502 Proteus Core Gaming Mouse */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC07D) },
+	{ /* Logitech G502 Proteus Spectrum Gaming Mouse over USB */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC332) },
+	{ /* Logitech G502 Hero Gaming Mouse over USB */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC08B) },
 	{ /* Logitech G700 Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC06B) },
+	{ /* Logitech G700s Gaming Mouse over USB */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC07C) },
+	{ /* Logitech G703 Gaming Mouse over USB */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC087) },
+	{ /* Logitech G703 Hero Gaming Mouse over USB */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC090) },
 	{ /* Logitech G900 Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC081) },
+	{ /* Logitech G903 Gaming Mouse over USB */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC086) },
+	{ /* Logitech G903 Hero Gaming Mouse over USB */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC091) },
 	{ /* Logitech G920 Wheel over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL),
 		.driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
+	{ /* Logitech G Pro Gaming Mouse over USB */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC088) },
 
 	{ /* MX5000 keyboard over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb305),
-- 
2.22.0
