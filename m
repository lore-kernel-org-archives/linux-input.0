From: "Peter F. Patel-Schneider" <pfpschneider@gmail.com>
Subject: [PATCH] iio:hid-sensor-hub: Add in quirk for sensor hub in Lenovo
 Ideapad Yogas
Date: Thu, 06 Mar 2014 12:57:53 -0800
Message-ID: <5318E151.9040702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:64444 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbaCFU56 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Mar 2014 15:57:58 -0500
Received: by mail-qa0-f54.google.com with SMTP id w8so3168297qac.27
        for <linux-input@vger.kernel.org>; Thu, 06 Mar 2014 12:57:57 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com

The sensor hub in Lenovo Yogas needs the enumeration quirk.  I've been running 
the patch for about a week with no problems, whereas the unpatched drivers 
reliably mis-initialized the sensors.

Signed-off-by: Peter F. Patel-Schneider <pfpschneider@gmail.com>
---
  drivers/hid/hid-ids.h        | 3 +++
  drivers/hid/hid-sensor-hub.c | 3 +++
  2 files changed, 6 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 5a5248f..f944e37 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -823,6 +823,9 @@
  #define USB_DEVICE_ID_SYNAPTICS_HD    0x0ac3
  #define USB_DEVICE_ID_SYNAPTICS_QUAD_HD    0x1ac3

+#define USB_VENDOR_ID_TEXAS_INSTRUMENTS    0x2047
+#define USB_DEVICE_ID_TEXAS_INSTRUMENTS_LENOVO_YOGA    0x0855
+
  #define USB_VENDOR_ID_THINGM        0x27b8
  #define USB_DEVICE_ID_BLINK1        0x01ed

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 46f4480..597732b 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -665,6 +665,9 @@ static const struct hid_device_id sensor_hub_devices[] = {
      { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_INTEL_1,
              USB_DEVICE_ID_INTEL_HID_SENSOR),
              .driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
+    { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, 
USB_VENDOR_ID_TEXAS_INSTRUMENTS,
+             USB_DEVICE_ID_TEXAS_INSTRUMENTS_LENOVO_YOGA),
+             .driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
      { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, HID_ANY_ID,
               HID_ANY_ID) },
      { }
