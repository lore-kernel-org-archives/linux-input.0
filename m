From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 3/7] Revert "HID: logitech: Use LDJ_DEVICE macro for existing Logitech mice"
Date: Wed, 21 Nov 2018 16:27:08 +0100
Message-ID: <20181121152712.6770-4-benjamin.tissoires@redhat.com>
References: <20181121152712.6770-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121152712.6770-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Harry Cutts <hcutts@chromium.org>, Peter Hutterer <peter.hutterer@who-t.net>, torvalds@linux-foundation.org
Cc: Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

This reverts commit 3fe1d6bbcd16f384d2c7dab2caf8e4b2df9ea7e6.

It turns out the current API is not that compatible with
some Microsoft mice, so better start again from scratch.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-logitech-hidpp.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 5f0c080059c6..fd6a8c325fa0 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3314,11 +3314,13 @@ static void hidpp_remove(struct hid_device *hdev)
 
 static const struct hid_device_id hidpp_devices[] = {
 	{ /* wireless touchpad */
-	  LDJ_DEVICE(0x4011),
+	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
+		USB_VENDOR_ID_LOGITECH, 0x4011),
 	  .driver_data = HIDPP_QUIRK_CLASS_WTP | HIDPP_QUIRK_DELAYED_INIT |
 			 HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS },
 	{ /* wireless touchpad T650 */
-	  LDJ_DEVICE(0x4101),
+	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
+		USB_VENDOR_ID_LOGITECH, 0x4101),
 	  .driver_data = HIDPP_QUIRK_CLASS_WTP | HIDPP_QUIRK_DELAYED_INIT },
 	{ /* wireless touchpad T651 */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
@@ -3358,13 +3360,16 @@ static const struct hid_device_id hidpp_devices[] = {
 	{ /* Mouse Logitech Performance MX */
 	  LDJ_DEVICE(0x101a), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_1P0 },
 	{ /* Keyboard logitech K400 */
-	  LDJ_DEVICE(0x4024),
+	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
+		USB_VENDOR_ID_LOGITECH, 0x4024),
 	  .driver_data = HIDPP_QUIRK_CLASS_K400 },
 	{ /* Solar Keyboard Logitech K750 */
-	  LDJ_DEVICE(0x4002),
+	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
+		USB_VENDOR_ID_LOGITECH, 0x4002),
 	  .driver_data = HIDPP_QUIRK_CLASS_K750 },
 
-	{ LDJ_DEVICE(HID_ANY_ID) },
+	{ HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
+		USB_VENDOR_ID_LOGITECH, HID_ANY_ID)},
 
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL),
 		.driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
-- 
2.19.1
