From: Archana Patni <archana.patni@linux.intel.com>
Subject: [PATCH] HID: hid-sensor-hub: quirk for STM Sensor hub
Date: Mon,  3 Feb 2014 12:44:16 +0530
Message-ID: <1391411656-32684-1-git-send-email-archana.patni@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:17740 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751298AbaBCHOj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 3 Feb 2014 02:14:39 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: jic23@kernel.org, linux-input@vger.kernel.org, srinivas.pandruvada@linux.intel.com, Archana Patni <archana.patni@linux.intel.com>

Added STM sensor hub vendor id in HID_SENSOR_HUB_ENUM_QUIRK to
fix report descriptors. These devices uses old FW which uses
logical 0 as minimum. In these, HID reports are not using proper
collection classes. So we need to fix report descriptors,for
such devices. This will not have any impact, if the FW uses
logical 1 as minimum.

We look for usage id for "power and report state", and modify
logical minimum value to 1.

This is a follow-up patch to commit id 875e36f8.

Signed-off-by: Archana Patni <archana.patni@linux.intel.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-ids.h        |    3 +++
 drivers/hid/hid-sensor-hub.c |    3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 5a5248f..1fc5bee 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -451,6 +451,9 @@
 #define USB_VENDOR_ID_INTEL_1		0x8087
 #define USB_DEVICE_ID_INTEL_HID_SENSOR	0x09fa
 
+#define USB_VENDOR_ID_STM_0             0x0483
+#define USB_DEVICE_ID_STM_HID_SENSOR    0x91d1
+
 #define USB_VENDOR_ID_ION		0x15e4
 #define USB_DEVICE_ID_ICADE		0x0132
 
diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 46f4480..9c22e14 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -665,6 +665,9 @@ static const struct hid_device_id sensor_hub_devices[] = {
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_INTEL_1,
 			USB_DEVICE_ID_INTEL_HID_SENSOR),
 			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
+	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_STM_0,
+			USB_DEVICE_ID_STM_HID_SENSOR),
+			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, HID_ANY_ID,
 		     HID_ANY_ID) },
 	{ }
-- 
1.7.9.5

