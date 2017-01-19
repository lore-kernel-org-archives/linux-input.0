From: Dennis Chen <barracks510@gmail.com>
Subject: [PATCH] HID: multitouch: enable Surface 3 Type Cover Pro to report
 multitouch data
Date: Thu, 19 Jan 2017 04:55:53 -0500
Message-ID: <1484819753.20429.4.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,

This should be the last related patch for the Surface Pro
Type Covers.

Sincerely,
Dennis Chen

>8------------------------------------------------------8<

Nearly identical to the previous set of patches related to Microsoft
Surface Keyboards.

Removes Surface Pro 3 generation TypeCover support from hid-microsoft
so proper multitouch data can be reported from the touchpad.

Signed-off-by: Dennis Chen <barracks510@gmail.com>
---
 drivers/hid/hid-core.c          | 10 ++--------
 drivers/hid/hid-ids.h           |  3 ---
 drivers/hid/hid-microsoft.c     |  6 ------
 drivers/hid/usbhid/hid-quirks.c |  7 ++-----
 4 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index d173e7f..52863e7 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -724,10 +724,7 @@ static void hid_scan_collection(struct hid_parser *parser, unsigned type)
 		hid->group = HID_GROUP_SENSOR_HUB;
 
 	if (hid->vendor == USB_VENDOR_ID_MICROSOFT &&
-	    (hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_3 ||
-	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2 ||
-	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP ||
-	     hid->product == USB_DEVICE_ID_MS_POWER_COVER) &&
+	    hid->product == USB_DEVICE_ID_MS_POWER_COVER &&
 	    hid->group == HID_GROUP_MULTITOUCH)
 		hid->group = HID_GROUP_GENERIC;
 
@@ -1982,9 +1979,6 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_3K) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_WIRELESS_OPTICAL_DESKTOP_3_0) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_OFFICE_KB) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_7K) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_600) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_3KV1) },
@@ -2308,7 +2302,7 @@ __ATTRIBUTE_GROUPS(hid_dev);
 
 static int hid_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
-	struct hid_device *hdev = to_hid_device(dev);	
+	struct hid_device *hdev = to_hid_device(dev);
 
 	if (add_uevent_var(env, "HID_ID=%04X:%08X:%08X",
 			hdev->bus, hdev->vendor, hdev->product))
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 87486ae..12f00a6 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -722,9 +722,6 @@
 #define USB_DEVICE_ID_MS_SURFACE_PRO_2   0x0799
 #define USB_DEVICE_ID_MS_TOUCH_COVER_2   0x07a7
 #define USB_DEVICE_ID_MS_TYPE_COVER_2    0x07a9
-#define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3    0x07dc
-#define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2  0x07e2
-#define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP 0x07dd
 #define USB_DEVICE_ID_MS_POWER_COVER     0x07da
 
 #define USB_VENDOR_ID_MOJO		0x8282
diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index d856726..96e7d32 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -274,12 +274,6 @@ static const struct hid_device_id ms_devices[] = {
 		.driver_data = MS_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_COMFORT_MOUSE_4500),
 		.driver_data = MS_DUPLICATE_USAGES },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3),
-		.driver_data = MS_HIDINPUT },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2),
-		.driver_data = MS_HIDINPUT },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP),
-		.driver_data = MS_HIDINPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER),
 		.driver_data = MS_HIDINPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_COMFORT_KEYBOARD),
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index f6432c5..80df173 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -102,9 +102,6 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_SURFACE_PRO_2, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_2, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TOUCH_COVER_2, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_NEXIO, USB_DEVICE_ID_NEXIO_MULTITOUCH_PTI0750, HID_QUIRK_NO_INIT_REPORTS },
@@ -293,7 +290,7 @@ static void usbhid_remove_all_dquirks(void)
 
 }
 
-/** 
+/**
  * usbhid_quirks_init: apply USB HID quirks specified at module load time
  */
 int usbhid_quirks_init(char **quirks_param)
@@ -357,7 +354,7 @@ static const struct hid_blacklist *usbhid_exists_squirk(const u16 idVendor,
 
 	if (bl_entry != NULL)
 		dbg_hid("Found squirk 0x%x for USB HID vendor 0x%hx prod 0x%hx\n",
-				bl_entry->quirks, bl_entry->idVendor, 
+				bl_entry->quirks, bl_entry->idVendor,
 				bl_entry->idProduct);
 	return bl_entry;
 }
-- 
2.7.4
