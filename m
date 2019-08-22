From: Pedro Vanzella <pedro@pedrovanzella.com>
Subject: [PATCH v3 1/4] hid-logitech-hidpp: add quirk to handle battery voltage
Date: Thu, 22 Aug 2019 16:18:45 -0400
Message-ID: <20190822201849.28924-2-pedro@pedrovanzella.com>
References: <20190822201849.28924-1-pedro@pedrovanzella.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190822201849.28924-1-pedro@pedrovanzella.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: lains@archlinux.org, Pedro Vanzella <pedro@pedrovanzella.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This quirk allows us to pick which devices support the 0x1001 hidpp
feature to read the battery voltage.

Signed-off-by: Pedro Vanzella <pedro@pedrovanzella.com>
---
 drivers/hid/hid-logitech-hidpp.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 0179f7ed77e5..402ddba93adc 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -59,7 +59,8 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_QUIRK_CLASS_G920			BIT(3)
 #define HIDPP_QUIRK_CLASS_K750			BIT(4)
 
-/* bits 2..20 are reserved for classes */
+/* bits 2..1f are reserved for classes */
+#define HIDPP_QUIRK_BATTERY_VOLTAGE_X1001	BIT(20)
 /* #define HIDPP_QUIRK_CONNECT_EVENTS		BIT(21) disabled */
 #define HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS	BIT(22)
 #define HIDPP_QUIRK_NO_HIDINPUT			BIT(23)
@@ -3732,6 +3733,13 @@ static const struct hid_device_id hidpp_devices[] = {
 	  LDJ_DEVICE(0xb30b),
 	  .driver_data = HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS },
 
+	{ /* Logitech G403 Gaming Mouse over Lightspeed */
+	  LDJ_DEVICE(0x405d),
+	  .driver_data = HIDPP_QUIRK_BATTERY_VOLTAGE_X1001 },
+	{ /* Logitech G900 Gaming Mouse over Lightspeed */
+	  LDJ_DEVICE(0x4053),
+	  .driver_data = HIDPP_QUIRK_BATTERY_VOLTAGE_X1001 },
+
 	{ LDJ_DEVICE(HID_ANY_ID) },
 
 	{ /* Keyboard LX501 (Y-RR53) */
@@ -3750,13 +3758,15 @@ static const struct hid_device_id hidpp_devices[] = {
 	{ L27MHZ_DEVICE(HID_ANY_ID) },
 
 	{ /* Logitech G403 Wireless Gaming Mouse over USB */
-	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC082) },
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC082),
+	  .driver_data = HIDPP_QUIRK_BATTERY_VOLTAGE_X1001 },
 	{ /* Logitech G703 Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC087) },
 	{ /* Logitech G703 Hero Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC090) },
 	{ /* Logitech G900 Gaming Mouse over USB */
-	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC081) },
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC081),
+	  .driver_data = HIDPP_QUIRK_BATTERY_VOLTAGE_X1001 },
 	{ /* Logitech G903 Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC086) },
 	{ /* Logitech G903 Hero Gaming Mouse over USB */
-- 
2.23.0
