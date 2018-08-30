From: Harry Cutts <hcutts@chromium.org>
Subject: [PATCH v2 5/5] Use LDJ_DEVICE macro for existing Logitech mice
Date: Thu, 30 Aug 2018 14:56:22 -0700
Message-ID: <20180830215622.47550-6-hcutts@chromium.org>
References: <20180830215622.47550-1-hcutts@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830215622.47550-1-hcutts@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Jiri Kosina <jiri.kosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Harry Cutts <hcutts@chromium.org>, Jiri Kosina <jikos@kernel.org>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Harry Cutts <hcutts@chromium.org>
---

Changes in v2:
* Changed the REL_WHEEL_HI_RES code to use micrometres (a.k.a. microns)
  as its units, instead of 256ths of a millimetre.
* Removed support for mice connecting over Bluetooth, due to a bug where
  the mouse's high-res mode and the driver's settings get out of sync
  when the mouse is power cycled.
* Moved the creation of the HID++ 1.0 function and the refactor to use
  the LDJ_DEVICE macro into separate patches.
* Added a couple of explanatory comments to the Logitech driver.

 drivers/hid/hid-logitech-hidpp.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index fd6a8c325fa0..5f0c080059c6 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3314,13 +3314,11 @@ static void hidpp_remove(struct hid_device *hdev)
 
 static const struct hid_device_id hidpp_devices[] = {
 	{ /* wireless touchpad */
-	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
-		USB_VENDOR_ID_LOGITECH, 0x4011),
+	  LDJ_DEVICE(0x4011),
 	  .driver_data = HIDPP_QUIRK_CLASS_WTP | HIDPP_QUIRK_DELAYED_INIT |
 			 HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS },
 	{ /* wireless touchpad T650 */
-	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
-		USB_VENDOR_ID_LOGITECH, 0x4101),
+	  LDJ_DEVICE(0x4101),
 	  .driver_data = HIDPP_QUIRK_CLASS_WTP | HIDPP_QUIRK_DELAYED_INIT },
 	{ /* wireless touchpad T651 */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
@@ -3360,16 +3358,13 @@ static const struct hid_device_id hidpp_devices[] = {
 	{ /* Mouse Logitech Performance MX */
 	  LDJ_DEVICE(0x101a), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_1P0 },
 	{ /* Keyboard logitech K400 */
-	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
-		USB_VENDOR_ID_LOGITECH, 0x4024),
+	  LDJ_DEVICE(0x4024),
 	  .driver_data = HIDPP_QUIRK_CLASS_K400 },
 	{ /* Solar Keyboard Logitech K750 */
-	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
-		USB_VENDOR_ID_LOGITECH, 0x4002),
+	  LDJ_DEVICE(0x4002),
 	  .driver_data = HIDPP_QUIRK_CLASS_K750 },
 
-	{ HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
-		USB_VENDOR_ID_LOGITECH, HID_ANY_ID)},
+	{ LDJ_DEVICE(HID_ANY_ID) },
 
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL),
 		.driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog
