From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2] hid: migrate Dream Cheeky LED driver from USB misc to HID
Date: Tue, 14 Jun 2016 23:05:15 +0200
Message-ID: <4d61b468-845d-7a7a-d18a-b68244270a75@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35977 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162AbcFNVFZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jun 2016 17:05:25 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org, Linux USB Mailing List <linux-usb@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>

The Dream Cheeky Webmail Notifier and Friends Alert are supported as part
of usb/misc/usbled driver currently. This patch migrates the driver for
these devices to the HID subsystem.

Benefits:
- Avoid using USB low-level calls and use the HID subsystem instead
  (as this device provides a USB HID interface)
- Use standard LED subsystem instead of proprietary sysfs entries,
  this allows e.g. to use the device with features like triggers

There might be users of the current driver, therefore so far allow
compilation of the new driver only if the old one is disabled.

Successfully tested with a Dream Cheeky Webmail Notifier.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- move hid_hw_start after dc_init_device to avoid a potential race
---
 drivers/hid/Kconfig            |   8 ++
 drivers/hid/Makefile           |   1 +
 drivers/hid/hid-core.c         |   6 +-
 drivers/hid/hid-dream-cheeky.c | 175 +++++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-ids.h          |   2 +
 5 files changed, 190 insertions(+), 2 deletions(-)
 create mode 100644 drivers/hid/hid-dream-cheeky.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 16fe27d..5618a61 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -247,6 +247,14 @@ config DRAGONRISE_FF
 	Say Y here if you want to enable force feedback support for DragonRise Inc.
 	game controllers.
 
+config HID_DREAM_CHEEKY
+	tristate "Dream Cheeky Webmail Notifier USB RGB LED"
+	depends on HID
+	depends on USB_LED = 'n'
+	---help---
+	Support for the Dream Cheeky Webmail Notifier. This driver registers
+	a LED class instance for red, green, and blue color component.
+
 config HID_EMS_FF
 	tristate "EMS Production Inc. force feedback support"
 	depends on HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 90300f3..2878739 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_HID_CORSAIR)	+= hid-corsair.o
 obj-$(CONFIG_HID_CP2112)	+= hid-cp2112.o
 obj-$(CONFIG_HID_CYPRESS)	+= hid-cypress.o
 obj-$(CONFIG_HID_DRAGONRISE)	+= hid-dr.o
+obj-$(CONFIG_HID_DREAM_CHEEKY)	+= hid-dream-cheeky.o
 obj-$(CONFIG_HID_EMS_FF)	+= hid-emsff.o
 obj-$(CONFIG_HID_ELECOM)	+= hid-elecom.o
 obj-$(CONFIG_HID_ELO)		+= hid-elo.o
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 730589a..c24f758 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1879,6 +1879,8 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_MOUSE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, 0x0006) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, 0x0011) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, USB_DEVICE_ID_DREAM_CHEEKY_WN) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, USB_DEVICE_ID_DREAM_CHEEKY_FA) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_BM084) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELO, 0x0009) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELO, 0x0030) },
@@ -2349,8 +2351,6 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DEALEXTREAME, USB_DEVICE_ID_DEALEXTREAME_RADIO_SI4701) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EARTHMATE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EM_LT20) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, 0x0004) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, 0x000a) },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, 0x0400) },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, 0x0401) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSENTIAL_REALITY_P5) },
@@ -2489,6 +2489,8 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_YEALINK, USB_DEVICE_ID_YEALINK_P1K_P4K_B2K) },
 #if IS_ENABLED(CONFIG_USB_LED)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_RISO_KAGAKU, USB_DEVICE_ID_RI_KA_WEBMAIL) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, USB_DEVICE_ID_DREAM_CHEEKY_WN) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, USB_DEVICE_ID_DREAM_CHEEKY_FA) },
 #endif
 	{ }
 };
diff --git a/drivers/hid/hid-dream-cheeky.c b/drivers/hid/hid-dream-cheeky.c
new file mode 100644
index 0000000..9806de4
--- /dev/null
+++ b/drivers/hid/hid-dream-cheeky.c
@@ -0,0 +1,175 @@
+/*
+ * Dream Cheeka Webmail Notifier USB RGB LED driver
+ *
+ * Copyright 2016 Heiner Kallweit <hkallweit1@gmail.com>
+ * Based on drivers/hid/hid-thingm.c and
+ * drivers/usb/misc/usbled.c
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2.
+ */
+
+#include <linux/hid.h>
+#include <linux/hidraw.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+
+#include "hid-ids.h"
+
+#define REPORT_SIZE	9
+#define REPORT_ID	0
+
+#define DC_MAX_BRIGHTNESS 0x1f
+
+struct dc_led {
+	struct led_classdev	cdev;
+	struct dc_device	*dcdev;
+	char			name[32];
+};
+
+struct dc_device {
+	struct dc_led		red;
+	struct dc_led		green;
+	struct dc_led		blue;
+	struct hid_device       *hdev;
+	struct mutex		lock;
+};
+
+#define to_dc_led(arg) container_of(arg, struct dc_led, cdev)
+
+static int dc_send(struct dc_device *dcdev, __u8 buf[REPORT_SIZE])
+{
+	int ret;
+
+	mutex_lock(&dcdev->lock);
+
+	ret = hid_hw_raw_request(dcdev->hdev, buf[0], buf, REPORT_SIZE,
+			HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+
+	mutex_unlock(&dcdev->lock);
+
+	if (ret < 0)
+		return ret;
+
+	return ret == REPORT_SIZE ? 0 : -EMSGSIZE;
+}
+
+static int dc_write_color(struct led_classdev *cdev, enum led_brightness br)
+{
+	struct dc_led *dcled = to_dc_led(cdev);
+	struct dc_device *dcdev = dcled->dcdev;
+	__u8 buf[REPORT_SIZE] = { REPORT_ID };
+
+	buf[1] = dcdev->red.cdev.brightness;
+	buf[2] = dcdev->green.cdev.brightness;
+	buf[3] = dcdev->blue.cdev.brightness;
+	buf[7] = 0x1a;
+	buf[8] = 0x05;
+
+	return dc_send(dcdev, buf);
+}
+
+static int dc_init_device(struct dc_device *dcdev)
+{
+	__u8 buf[REPORT_SIZE] = { REPORT_ID };
+
+	/* Dream Cheeky magic */
+	buf[1] = 0x1f;
+	buf[2] = 0x02;
+	buf[4] = 0x5f;
+	buf[7] = 0x1a;
+	buf[8] = 0x03;
+
+	return dc_send(dcdev, buf);
+}
+
+static int dc_init_led(struct dc_led *led, const char *color_name,
+		       struct dc_device *dcdev, int minor)
+{
+	snprintf(led->name, sizeof(led->name), "dream_cheeky%d:%s", minor, color_name);
+	led->cdev.name = led->name;
+	led->cdev.max_brightness = DC_MAX_BRIGHTNESS;
+	led->cdev.brightness_set_blocking = dc_write_color;
+	led->cdev.flags = LED_HW_PLUGGABLE;
+	led->dcdev = dcdev;
+
+	return devm_led_classdev_register(&dcdev->hdev->dev, &led->cdev);
+}
+
+static int dc_init_rgb(struct dc_device *dcdev, int minor)
+{
+	int ret;
+
+	/* Register the red diode */
+	ret = dc_init_led(&dcdev->red, "red", dcdev, minor);
+	if (ret)
+		return ret;
+
+	/* Register the green diode */
+	ret = dc_init_led(&dcdev->green, "green", dcdev, minor);
+	if (ret)
+		return ret;
+
+	/* Register the blue diode */
+	return dc_init_led(&dcdev->blue, "blue", dcdev, minor);
+}
+
+static int dc_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	struct dc_device *dcdev;
+	int ret, minor;
+
+	dcdev = devm_kzalloc(&hdev->dev, sizeof(*dcdev), GFP_KERNEL);
+	if (!dcdev)
+		return -ENOMEM;
+
+	ret = hid_parse(hdev);
+	if (ret)
+		return ret;
+
+	dcdev->hdev = hdev;
+	mutex_init(&dcdev->lock);
+
+	ret = dc_init_device(dcdev);
+	if (ret)
+		return ret;
+
+	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
+	if (ret)
+		return ret;
+
+	minor = ((struct hidraw *) hdev->hidraw)->minor;
+
+	ret = dc_init_rgb(dcdev, minor);
+	if (ret) {
+		hid_hw_stop(hdev);
+		return ret;
+	}
+
+	dev_info(&hdev->dev, "Dream Cheeky Webmail Notifier %d initialized\n", minor);
+
+	return 0;
+}
+
+static const struct hid_device_id dc_table[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY,
+	  USB_DEVICE_ID_DREAM_CHEEKY_WN) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY,
+	  USB_DEVICE_ID_DREAM_CHEEKY_FA) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, dc_table);
+
+static struct hid_driver dc_driver = {
+	.name = "dream-cheeky",
+	.probe = dc_probe,
+	.id_table = dc_table,
+};
+
+module_hid_driver(dc_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Heiner Kallweit <hkallweit1@gmail.com>");
+MODULE_DESCRIPTION("Dream Cheeky Webmail Notifier USB RGB LED driver");
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 3eec09a..e104aba 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -334,6 +334,8 @@
 #define USB_DEVICE_ID_ELECOM_BM084	0x0061
 
 #define USB_VENDOR_ID_DREAM_CHEEKY	0x1d34
+#define USB_DEVICE_ID_DREAM_CHEEKY_WN	0x0004
+#define USB_DEVICE_ID_DREAM_CHEEKY_FA	0x000a
 
 #define USB_VENDOR_ID_ELITEGROUP	0x03fc
 #define USB_DEVICE_ID_ELITEGROUP_05D8	0x05d8
-- 
2.8.3


