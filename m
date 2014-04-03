From: Stephen Chandler Paul <thatslyude@gmail.com>
Subject: [PATCH] Add sensor hub quirk for ThinkPad Helix
Date: Thu,  3 Apr 2014 16:27:55 -0400
Message-ID: <1396556875-31108-1-git-send-email-thatslyude@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:54890 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753612AbaDCU06 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Apr 2014 16:26:58 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Srinivas Pandruvada <srinivas.pandruvada@intel.com>, Adam Williamson <awilliam@redhat.com>

Just like some of the other laptops/tablets on the market with ultrabook
sensors, the ThinkPad Helix's sensor hub requires a special quirk in
order for it to power on properly. Without it the sensors are detected
by the kernel and set up as usual, but they won't output any data. This
will also fix the sensors on any other laptops with the same model of
sensor hub.

Signed-off-by: Stephen Chandler Paul <thatslyude@gmail.com>
---
 drivers/hid/hid-ids.h        | 3 ++-
 drivers/hid/hid-sensor-hub.c | 7 +++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index bd22126..3312f1b5 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -455,7 +455,8 @@
 
 #define USB_VENDOR_ID_INTEL_0		0x8086
 #define USB_VENDOR_ID_INTEL_1		0x8087
-#define USB_DEVICE_ID_INTEL_HID_SENSOR	0x09fa
+#define USB_DEVICE_ID_INTEL_HID_SENSOR_0	0x09fa
+#define USB_DEVICE_ID_INTEL_HID_SENSOR_1	0x0a04
 
 #define USB_VENDOR_ID_STM_0             0x0483
 #define USB_DEVICE_ID_STM_HID_SENSOR    0x91d1
diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 5182031..af8244b 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -697,10 +697,13 @@ static void sensor_hub_remove(struct hid_device *hdev)
 
 static const struct hid_device_id sensor_hub_devices[] = {
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_INTEL_0,
-			USB_DEVICE_ID_INTEL_HID_SENSOR),
+			USB_DEVICE_ID_INTEL_HID_SENSOR_0),
 			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_INTEL_1,
-			USB_DEVICE_ID_INTEL_HID_SENSOR),
+			USB_DEVICE_ID_INTEL_HID_SENSOR_0),
+			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
+	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_INTEL_1,
+			USB_DEVICE_ID_INTEL_HID_SENSOR_1),
 			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_STM_0,
 			USB_DEVICE_ID_STM_HID_SENSOR),
-- 
1.8.3.2

