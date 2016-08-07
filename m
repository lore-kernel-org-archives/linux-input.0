From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 6/7] hid: hid-sensor-hub: Add ISH quirk
Date: Sun,  7 Aug 2016 02:25:38 -0700
Message-ID: <1470561939-14278-7-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1470561939-14278-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:27394 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751664AbcHGJZw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 7 Aug 2016 05:25:52 -0400
In-Reply-To: <1470561939-14278-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org, jic23@kernel.org
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com

Need enum quirk to change the base of enums to 1 for
power and report descriptors.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-hub.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 3d5ba5b..658a607 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -16,6 +16,7 @@
  * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
  *
  */
+
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
@@ -798,6 +799,9 @@ static const struct hid_device_id sensor_hub_devices[] = {
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_ITE,
 			USB_DEVICE_ID_ITE_LENOVO_YOGA900),
 			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
+	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_INTEL_0,
+			0x22D8),
+			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, HID_ANY_ID,
 		     HID_ANY_ID) },
 	{ }
-- 
2.7.4

