From: Derya <derya.kiran@yahoo.de>
Subject: Re: [PATCH 2/2 ] Surface Pro 2 HID sensor, wacom, keyboard/multitouch
 composite device
Date: Fri, 07 Mar 2014 16:58:05 +0100
Message-ID: <5319EC8D.9070302@yahoo.de>
References: <5319EB7C.5070209@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nm22-vm2.bullet.mail.ir2.yahoo.com ([212.82.97.8]:30609 "EHLO
	nm22-vm2.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752503AbaCGQB0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 7 Mar 2014 11:01:26 -0500
In-Reply-To: <5319EB7C.5070209@yahoo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, jkosina@suse.cz

Enumeration quirks for Surface Pro 2 sensor-hub

Signed-off-by: Derya <derya.kiran@yahoo.de>
---
  drivers/hid/hid-sensor-hub.c | 9 +++++++++
  1 file changed, 9 insertions(+)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 9c22e14..16f4bb8 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -668,6 +668,15 @@ static const struct hid_device_id 
sensor_hub_devices[] = {
      { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_STM_0,
              USB_DEVICE_ID_STM_HID_SENSOR),
              .driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
+    { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, 
USB_VENDOR_ID_MICROSOFT,
+             USB_DEVICE_ID_MS_TOUCH_COVER_2),
+            .driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
+    { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, 
USB_VENDOR_ID_MICROSOFT,
+             USB_DEVICE_ID_MS_TYPE_COVER_2),
+            .driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
+    { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, 
USB_VENDOR_ID_MICROSOFT,
+             USB_DEVICE_ID_MS_SURFACE_PRO_2),
+            .driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
      { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, HID_ANY_ID,
               HID_ANY_ID) },
      { }
-- 
1.8.3.2
