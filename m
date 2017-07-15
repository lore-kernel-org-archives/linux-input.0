From: Patrick Pedersen <ctx.xda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] HID: Add quirk for Lenovo Yoga 910 with ITE Chips
Date: Sat, 15 Jul 2017 14:27:21 +0200
Message-ID: <20170715122721.6908-1-ctx.xda@gmail.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

As with previous generations of this device (see https://patchwork.kernel.org/patch/7887361/), the ITE
HID Sensor Hub, responsible for the accelerometer and als sensor, requires a quirk entry.

Without the entry, the Sensor Hub can't be accessed and the kernel fails to report any movements. As a result
iio-sensor-proxy receives no new data.

It shall additionally be noted that the i2c-hid 'sleep' bug (present since kernel ver. 4.3)
still affects the driver. This means that the sensor hub will not report any movement, until
the device is suspended and resumed.

Signed-off-by: Patrick Pedersen <ctx.xda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/hid/hid-ids.h        | 1 +
 drivers/hid/hid-sensor-hub.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 4f9a3938189a..b427a0bcfbe8 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -565,6 +565,7 @@
 #define USB_DEVICE_ID_ITE_LENOVO_YOGA   0x8386
 #define USB_DEVICE_ID_ITE_LENOVO_YOGA2  0x8350
 #define USB_DEVICE_ID_ITE_LENOVO_YOGA900	0x8396
+#define USB_DEVICE_ID_ITE_LENOVO_YOGA910	0x8186
 
 #define USB_VENDOR_ID_JABRA		0x0b0e
 #define USB_DEVICE_ID_JABRA_SPEAK_410	0x0412
diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 4ef73374a8f9..85b8425483bd 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -820,6 +820,9 @@ static const struct hid_device_id sensor_hub_devices[] = {
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_ITE,
 			USB_DEVICE_ID_ITE_LENOVO_YOGA900),
 			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
+	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_ITE,
+			USB_DEVICE_ID_ITE_LENOVO_YOGA910),
+			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_INTEL_0,
 			0x22D8),
 			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
-- 
2.13.3
