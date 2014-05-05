From: "Peter F. Patel-Schneider" <pfpschneider@gmail.com>
Subject: [PATCH] iio:hid-sensor-hub: Add in quirk for sensor hub in Lenovo
 Ideapad Yogas
Date: Mon, 05 May 2014 15:55:32 -0700
Message-ID: <536816E4.2040109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:39356 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756752AbaEEWzi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 May 2014 18:55:38 -0400
Received: by mail-qa0-f52.google.com with SMTP id cm18so6905163qab.11
        for <linux-input@vger.kernel.org>; Mon, 05 May 2014 15:55:37 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, jkosina@suse.cz
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

The sensor hub in Lenovo Yogas needs the enumeration quirk.  I've been running 
the patch for over a month with no problems, whereas the unpatched drivers 
reliably mis-initialized the sensors. (This is a resending of a previous patch 
that had formatting issues.)

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
  #define USB_DEVICE_ID_SYNAPTICS_HD	0x0ac3
  #define USB_DEVICE_ID_SYNAPTICS_QUAD_HD	0x1ac3

+#define USB_VENDOR_ID_TEXAS_INSTRUMENTS	0x2047
+#define USB_DEVICE_ID_TEXAS_INSTRUMENTS_LENOVO_YOGA	0x0855
+
  #define USB_VENDOR_ID_THINGM		0x27b8
  #define USB_DEVICE_ID_BLINK1		0x01ed

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 46f4480..597732b 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -665,6 +665,9 @@ static const struct hid_device_id sensor_hub_devices[] = {
  	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_INTEL_1,
  			USB_DEVICE_ID_INTEL_HID_SENSOR),
  			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
+	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_TEXAS_INSTRUMENTS,
+		     USB_DEVICE_ID_TEXAS_INSTRUMENTS_LENOVO_YOGA),
+		     .driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
  	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, HID_ANY_ID,
  		     HID_ANY_ID) },
  	{ }

