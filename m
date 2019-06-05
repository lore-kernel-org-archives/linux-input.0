From: Pedro Vanzella <pedro@pedrovanzella.com>
Subject: [PATCH v2 1/4] HID: hid-logitech-hidpp: add quirk to handle battery voltage
Date: Wed,  5 Jun 2019 15:45:30 -0400
Message-ID: <20190605194533.18717-2-pedro@pedrovanzella.com>
References: <20190605194533.18717-1-pedro@pedrovanzella.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190605194533.18717-1-pedro@pedrovanzella.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Pedro Vanzella <pedro@pedrovanzella.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

By adding this quirk we're able to handle battery voltage for devices
in both wired and wireless modes.

Signed-off-by: Pedro Vanzella <pedro@pedrovanzella.com>
---
 drivers/hid/hid-logitech-hidpp.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 72fc9c0566db..8b38c14725b8 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -63,7 +63,8 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_QUIRK_CLASS_G920			BIT(3)
 #define HIDPP_QUIRK_CLASS_K750			BIT(4)
 
-/* bits 2..20 are reserved for classes */
+/* bits 2..1f are reserved for classes */
+#define HIDPP_QUIRK_BATTERY_VOLTAGE_X1001	BIT(20)
 /* #define HIDPP_QUIRK_CONNECT_EVENTS		BIT(21) disabled */
 #define HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS	BIT(22)
 #define HIDPP_QUIRK_NO_HIDINPUT			BIT(23)
@@ -3733,6 +3734,13 @@ static const struct hid_device_id hidpp_devices[] = {
 	  LDJ_DEVICE(0xb305),
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
@@ -3752,7 +3760,8 @@ static const struct hid_device_id hidpp_devices[] = {
 	{ /* Logitech G700 Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC06B) },
 	{ /* Logitech G900 Gaming Mouse over USB */
-	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC081) },
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC081),
+	  .driver_data = HIDPP_QUIRK_BATTERY_VOLTAGE_X1001 },
 	{ /* Logitech G920 Wheel over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL),
 		.driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
-- 
2.21.0
