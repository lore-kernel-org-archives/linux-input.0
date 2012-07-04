From: srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH 2/8] HID Sensors: Add to special driver list
Date: Wed,  4 Jul 2012 12:52:06 -0700
Message-ID: <1341431532-15060-3-git-send-email-srinivas.pandruvada@intel.com>
References: <1341431532-15060-1-git-send-email-srinivas.pandruvada@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:29210 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755781Ab2GDUCq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Jul 2012 16:02:46 -0400
In-Reply-To: <1341431532-15060-1-git-send-email-srinivas.pandruvada@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-iio@vger.kernel.org
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, lars@metafoo.de, jic23@cam.ac.uk, srinivas pandruvada <srinivas.pandruvada@intel.com>

Adding Intel and STM sensor hub in the list of drivers with
specialized driver.

Signed-off-by: srinivas pandruvada <srinivas.pandruvada@intel.com>
---
 drivers/hid/hid-core.c |   10 ++++++++++
 drivers/hid/hid-ids.h  |    6 ++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 8e3a6b2..36c8007 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1536,6 +1536,14 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GYRATION, USB_DEVICE_ID_GYRATION_REMOTE_2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GYRATION, USB_DEVICE_ID_GYRATION_REMOTE_3) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK, USB_DEVICE_ID_HOLTEK_ON_LINE_GRIP) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_INTEL_8086,
+					USB_DEVICE_ID_SENSOR_HUB_1020) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_INTEL_8086,
+					USB_DEVICE_ID_SENSOR_HUB_09FA) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_INTEL_8087,
+					USB_DEVICE_ID_SENSOR_HUB_1020) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_INTEL_8087,
+					USB_DEVICE_ID_SENSOR_HUB_09FA) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KENSINGTON, USB_DEVICE_ID_KS_SLIMBLADE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KEYTOUCH, USB_DEVICE_ID_KEYTOUCH_IEC) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_ERGO_525V) },
@@ -1626,6 +1634,8 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SUNPLUS, USB_DEVICE_ID_SUNPLUS_WDESKTOP) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STANTUM_STM,
+			 USB_DEVICE_ID_SENSOR_HUB_7014) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb300) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb304) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb323) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 9373f53..2f1dc5b 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -407,6 +407,11 @@
 #define USB_VENDOR_ID_IMATION		0x0718
 #define USB_DEVICE_ID_DISC_STAKKA	0xd000
 
+#define USB_VENDOR_ID_INTEL_8086	0x8086
+#define USB_VENDOR_ID_INTEL_8087	0x8087
+#define USB_DEVICE_ID_SENSOR_HUB_1020	0x1020
+#define USB_DEVICE_ID_SENSOR_HUB_09FA	0x09FA
+
 #define USB_VENDOR_ID_IRTOUCHSYSTEMS	0x6615
 #define USB_DEVICE_ID_IRTOUCH_INFRARED_USB	0x0070
 
@@ -670,6 +675,7 @@
 
 #define USB_VENDOR_ID_STANTUM_STM		0x0483
 #define USB_DEVICE_ID_MTP_STM		0x3261
+#define USB_DEVICE_ID_SENSOR_HUB_7014	0x7014
 
 #define USB_VENDOR_ID_STANTUM_SITRONIX		0x1403
 #define USB_DEVICE_ID_MTP_SITRONIX		0x5001
-- 
1.7.7.6

