From: Ciprian Ciubotariu <cheepeero@gmx.net>
Subject: [PATCH] Add drivers for Logitech G110, G13, G15v2 and G19
Date: Sat, 21 Feb 2015 17:50:03 +0200
Message-ID: <1424533803-17017-1-git-send-email-cheepeero@gmx.net>
References: <2205053.ll7fhHWnZQ@pink>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2205053.ll7fhHWnZQ@pink>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>, Ciprian Ciubotariu <cheepeero@gmx.net>
List-Id: linux-input@vger.kernel.org

New modules:
  - hid-gcore - common functions
  - hid-gfb   - framebuffer implementation
  - hid-g110  - G110 driver
  - hid-g13   - G13 driver
  - hid-g15v2 - G15 v2 driver
  - hid-g19   - G19 driver

Add Kconfig options for each driver, and a main menu option which is
responsible for hid-gcore. hid-gfb is only selected when individual
drivers need it.

Add product IDs to hid-ids.h, and blacklist them for hid-generic.
---
 drivers/hid/Kconfig     |  81 +++++
 drivers/hid/Makefile    |   8 +
 drivers/hid/hid-core.c  |   4 +
 drivers/hid/hid-g110.c  | 789 +++++++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-g13.c   | 783 ++++++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-g15v2.c | 721 +++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-g19.c   | 882 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-gcore.c | 398 ++++++++++++++++++++++
 drivers/hid/hid-gcore.h |  74 ++++
 drivers/hid/hid-gfb.c   | 751 +++++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-gfb.h   |  54 +++
 drivers/hid/hid-ids.h   |   7 +
 12 files changed, 4552 insertions(+)
 create mode 100644 drivers/hid/hid-g110.c
 create mode 100644 drivers/hid/hid-g13.c
 create mode 100644 drivers/hid/hid-g15v2.c
 create mode 100644 drivers/hid/hid-g19.c
 create mode 100644 drivers/hid/hid-gcore.c
 create mode 100644 drivers/hid/hid-gcore.h
 create mode 100644 drivers/hid/hid-gfb.c
 create mode 100644 drivers/hid/hid-gfb.h

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 152b006..5f28272 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -451,6 +451,87 @@ config LOGIWHEELS_FF
 	  - Logitech MOMO/MOMO 2
 	  - Logitech Formula Force EX
 
+config HID_LOGITECH_GSERIES
+	tristate "Logitech G-Series devices"
+	depends on HID
+	depends on USB
+	select NEW_LEDS
+	select LEDS_CLASS
+	help
+	Support for Logitech G-Series devices.
+
+	This option allows you to choose from a list of Logitech G-series devices.
+	If your keyboard has an LCD display, you will have to enable framebuffer
+	support (CONFIG_FB) to see it here.
+
+	If unsure, say N.
+
+	To compile this driver as a module, choose M here: the
+	module will be called hid-gcore.
+
+config LOGITECH_GFB
+	tristate
+	depends on HID_LOGITECH_GSERIES
+	depends on FB
+	select FB_DEFERRED_IO
+	select FB_SYS_FILLRECT
+	select FB_SYS_COPYAREA
+	select FB_SYS_IMAGEBLIT
+	select FB_SYS_FOPS
+	# select LCD_CLASS_DEVICE
+	# select BACKLIGHT_CLASS_DEVICE
+	# select BACKLIGHT_LCD_SUPPORT
+
+config LOGITECH_G110
+	tristate "Logitech G110 keyboard"
+	depends on HID_LOGITECH_GSERIES
+	help
+	  Say Y here if you have a Logitech G110 keyboard.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called hid-g110.
+
+config LOGITECH_G13
+	tristate "Logitech G13 keyboard"
+	depends on HID_LOGITECH_GSERIES
+	depends on FB
+	select LOGITECH_GFB
+	help
+	  Say Y here if you have a Logitech G13 keyboard.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called hid-g13.
+
+config LOGITECH_G15V2
+	tristate "Logitech G15 Version 2 keyboard"
+	depends on HID_LOGITECH_GSERIES
+	depends on FB
+	select LOGITECH_GFB
+	help
+	  Say Y here if you have a Logitech G15 Version 2 keyboard.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called hid-g15v2.
+
+config LOGITECH_G19
+	tristate "Logitech G19 keyboard"
+	depends on HID_LOGITECH_GSERIES
+	depends on FB
+	select LOGITECH_GFB
+	help
+	  Say Y here if you have a Logitech G19 keyboard.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called hid-g19.
+
 config HID_MAGICMOUSE
 	tristate "Apple Magic Mouse/Trackpad multi-touch support"
 	depends on HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 6f19958..a2b2cfa 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -107,3 +107,11 @@ obj-$(CONFIG_USB_MOUSE)		+= usbhid/
 obj-$(CONFIG_USB_KBD)		+= usbhid/
 
 obj-$(CONFIG_I2C_HID)		+= i2c-hid/
+
+
+obj-$(CONFIG_HID_LOGITECH_GSERIES)	+= hid-gcore.o
+obj-$(CONFIG_LOGITECH_GFB)	+= hid-gfb.o
+obj-$(CONFIG_LOGITECH_G110)	+= hid-g110.o
+obj-$(CONFIG_LOGITECH_G13)	+= hid-g13.o
+obj-$(CONFIG_LOGITECH_G15V2)	+= hid-g15v2.o
+obj-$(CONFIG_LOGITECH_G19)	+= hid-g19.o
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index db4fb6e..58a078b 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1856,6 +1856,10 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_VIBRATION_WHEEL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_DFP_WHEEL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_DFGT_WHEEL) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G110) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G13) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G15V2_LCD) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G19_LCD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G25_WHEEL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G27_WHEEL) },
 #if IS_ENABLED(CONFIG_HID_LOGITECH_DJ)
diff --git a/drivers/hid/hid-g110.c b/drivers/hid/hid-g110.c
new file mode 100644
index 0000000..87c5380
--- /dev/null
+++ b/drivers/hid/hid-g110.c
@@ -0,0 +1,789 @@
+/***************************************************************************
+ *   Copyright (C) 2010 by Alistair Buxton				   *
+ *   a.j.buxton@gmail.com						   *
+ *   based on hid-g13.c							   *
+ *									   *
+ *   This program is free software: you can redistribute it and/or modify  *
+ *   it under the terms of the GNU General Public License as published by  *
+ *   the Free Software Foundation, either version 2 of the License, or	   *
+ *   (at your option) any later version.				   *
+ *									   *
+ *   This driver is distributed in the hope that it will be useful, but	   *
+ *   WITHOUT ANY WARRANTY; without even the implied warranty of		   *
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU	   *
+ *   General Public License for more details.				   *
+ *									   *
+ *   You should have received a copy of the GNU General Public License	   *
+ *   along with this software. If not see <http://www.gnu.org/licenses/>.  *
+ ***************************************************************************/
+#include <linux/hid.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/sysfs.h>
+#include <linux/uaccess.h>
+#include <linux/usb.h>
+#include <linux/vmalloc.h>
+#include <linux/leds.h>
+#include <linux/completion.h>
+#include <linux/version.h>
+
+#include "hid-ids.h"
+#include "hid-gcore.h"
+
+#define G110_NAME "Logitech G110"
+
+/* Key defines */
+#define G110_KEYS 17
+
+/* Backlight defaults */
+#define G110_DEFAULT_RED (0)
+#define G110_DEFAULT_BLUE (255)
+
+/* LED array indices */
+#define G110_LED_M1 0
+#define G110_LED_M2 1
+#define G110_LED_M3 2
+#define G110_LED_MR 3
+#define G110_LED_BL_R 4
+#define G110_LED_BL_B 5
+
+#define G110_REPORT_4_INIT	0x00
+#define G110_REPORT_4_FINALIZE	0x01
+
+#define G110_READY_SUBSTAGE_1 0x01
+#define G110_READY_SUBSTAGE_2 0x02
+#define G110_READY_SUBSTAGE_3 0x04
+#define G110_READY_STAGE_1    0x07
+#define G110_READY_SUBSTAGE_4 0x08
+#define G110_READY_SUBSTAGE_5 0x10
+#define G110_READY_STAGE_2    0x1F
+#define G110_READY_SUBSTAGE_6 0x20
+#define G110_READY_SUBSTAGE_7 0x40
+#define G110_READY_STAGE_3    0x7F
+
+#define G110_RESET_POST 0x01
+#define G110_RESET_MESSAGE_1 0x02
+#define G110_RESET_READY 0x03
+
+/* G110-specific device data structure */
+struct g110_data {
+	/* HID reports */
+	struct hid_report *backlight_report;
+	struct hid_report *start_input_report;
+	struct hid_report *feature_report_4;
+	struct hid_report *led_report;
+	struct hid_report *output_report_3;
+
+	/* led state */
+	u8 backlight_rb[2];	/* keyboard illumination */
+	u8 led_mbtns;		/* m1, m2, m3 and mr */
+
+	/* non-standard buttons */
+	u8 ep1keys[2];
+	struct urb *ep1_urb;
+	spinlock_t ep1_urb_lock;
+
+	/* initialization stages */
+	struct completion ready;
+	int ready_stages;
+};
+
+/* Convenience macros */
+#define hid_get_g110data(hdev) \
+	((struct g110_data *)(hid_get_gdata(hdev)->data))
+#define dev_get_g110data(dev) \
+	((struct g110_data *)(dev_get_gdata(dev)->data))
+
+/*
+ * Keymap array indices (used as scancodes)
+ *
+ * Key	      Index
+ * ---------  ------
+ * G1-G12     0-11
+ * M1	      12
+ * M2	      13
+ * M3	      14
+ * MR	      15
+ * LIGHT      16
+ */
+static const unsigned int g110_default_keymap[G110_KEYS] = {
+	KEY_F1, KEY_F2, KEY_F3, KEY_F4,
+	KEY_F5, KEY_F6, KEY_F7, KEY_F8,
+	KEY_F9, KEY_F10, KEY_F11, KEY_F12,
+	/* M1, M2, M3, MR */
+	KEY_PROG1, KEY_PROG2, KEY_PROG3, KEY_RECORD,
+	KEY_KBDILLUMTOGGLE
+};
+
+static void g110_led_mbtns_send(struct hid_device *hdev)
+{
+	struct g110_data *g110data = hid_get_g110data(hdev);
+
+	g110data->led_report->field[0]->value[0] = g110data->led_mbtns & 0xFF;
+
+	hid_hw_request(hdev, g110data->led_report, HID_REQ_SET_REPORT);
+}
+
+static void g110_led_mbtns_brightness_set(struct led_classdev *led_cdev,
+					  enum led_brightness value)
+{
+	struct hid_device *hdev = gcore_led_classdev_to_hdev(led_cdev);
+	struct gcore_data *gdata = hid_get_gdata(hdev);
+	struct g110_data *g110data = gdata->data;
+	u8 mask = 0;
+
+	if (led_cdev == gdata->led_cdev[G110_LED_M1])
+		mask = 0x80;
+	else if (led_cdev == gdata->led_cdev[G110_LED_M2])
+		mask = 0x40;
+	else if (led_cdev == gdata->led_cdev[G110_LED_M3])
+		mask = 0x20;
+	else if (led_cdev == gdata->led_cdev[G110_LED_MR])
+		mask = 0x10;
+
+	if (mask && value)
+		g110data->led_mbtns |= mask;
+	else
+		g110data->led_mbtns &= ~mask;
+
+	g110_led_mbtns_send(hdev);
+}
+
+static enum led_brightness
+g110_led_mbtns_brightness_get(struct led_classdev *led_cdev)
+{
+	struct hid_device *hdev = gcore_led_classdev_to_hdev(led_cdev);
+	struct gcore_data *gdata = hid_get_gdata(hdev);
+	struct g110_data *g110data = gdata->data;
+	int value = 0;
+
+	if (led_cdev == gdata->led_cdev[G110_LED_M1])
+		value = g110data->led_mbtns & 0x80;
+	else if (led_cdev == gdata->led_cdev[G110_LED_M2])
+		value = g110data->led_mbtns & 0x40;
+	else if (led_cdev == gdata->led_cdev[G110_LED_M3])
+		value = g110data->led_mbtns & 0x20;
+	else if (led_cdev == gdata->led_cdev[G110_LED_MR])
+		value = g110data->led_mbtns & 0x10;
+	else
+		dev_err(&hdev->dev,
+			G110_NAME " error retrieving LED brightness\n");
+
+	if (value)
+		return LED_FULL;
+	return LED_OFF;
+}
+
+static void g110_led_bl_send(struct hid_device *hdev)
+{
+	struct g110_data *g110data = hid_get_g110data(hdev);
+
+	struct hid_field *field0 = g110data->backlight_report->field[0];
+	struct hid_field *field1 = g110data->backlight_report->field[1];
+
+	/*
+	 * Unlike the other keyboards, the G110 only has 2 LED backlights (red
+	 * and blue). Rather than just setting intensity on each, the keyboard
+	 * instead has a single intensity value, and a second value to specify
+	 * how red/blue the backlight should be. This weird logic converts the
+	 * two intensity values from the user into an intensity/colour value
+	 * suitable for the keyboard.
+	 *
+	 * Additionally, the intensity is only valid from 0x00 - 0x0f (rather
+	 * than 0x00 - 0xff). I decided to keep accepting 0x00 - 0xff as input,
+	 * and I just >>4 to make it fit.
+	 */
+
+	/* These are just always zero from what I can tell */
+	field0->value[1] = 0x00;
+	field0->value[2] = 0x00;
+
+	/* If the intensities are the same, "colour" is 0x80 */
+	if (g110data->backlight_rb[0] == g110data->backlight_rb[1]) {
+		field0->value[0] = 0x80;
+		field1->value[0] = g110data->backlight_rb[0]>>4;
+	}
+	/* If the blue value is higher */
+	else if (g110data->backlight_rb[1] > g110data->backlight_rb[0]) {
+		field0->value[0] = 0xff - (0x80 * g110data->backlight_rb[0]) /
+			g110data->backlight_rb[1];
+		field1->value[0] = g110data->backlight_rb[1]>>4;
+	}
+	/* If the red value is higher */
+	else {
+		field0->value[0] = (0x80 * g110data->backlight_rb[1]) /
+			g110data->backlight_rb[0];
+		field1->value[0] = g110data->backlight_rb[0]>>4;
+	}
+
+	hid_hw_request(hdev, g110data->backlight_report, HID_REQ_SET_REPORT);
+}
+
+static void g110_led_bl_brightness_set(struct led_classdev *led_cdev,
+				       enum led_brightness value)
+{
+	struct hid_device *hdev = gcore_led_classdev_to_hdev(led_cdev);
+	struct gcore_data *gdata = hid_get_gdata(hdev);
+	struct g110_data *g110data = gdata->data;
+
+	if (led_cdev == gdata->led_cdev[G110_LED_BL_R])
+		g110data->backlight_rb[0] = value;
+	else if (led_cdev == gdata->led_cdev[G110_LED_BL_B])
+		g110data->backlight_rb[1] = value;
+
+	g110_led_bl_send(hdev);
+}
+
+static enum led_brightness
+g110_led_bl_brightness_get(struct led_classdev *led_cdev)
+{
+	struct hid_device *hdev = gcore_led_classdev_to_hdev(led_cdev);
+	struct gcore_data *gdata = hid_get_gdata(hdev);
+	struct g110_data *g110data = gdata->data;
+	int value = 0;
+
+	if (led_cdev == gdata->led_cdev[G110_LED_BL_R])
+		value = g110data->backlight_rb[0];
+	else if (led_cdev == gdata->led_cdev[G110_LED_BL_B])
+		value = g110data->backlight_rb[1];
+	else
+		dev_err(&hdev->dev, G110_NAME " error retrieving LED brightness\n");
+
+	if (value)
+		return LED_FULL;
+	return LED_OFF;
+}
+
+
+static const struct led_classdev g110_led_cdevs[] = {
+	{
+		.name			= "g110_%d:orange:m1",
+		.brightness_set		= g110_led_mbtns_brightness_set,
+		.brightness_get		= g110_led_mbtns_brightness_get,
+	},
+	{
+		.name			= "g110_%d:orange:m2",
+		.brightness_set		= g110_led_mbtns_brightness_set,
+		.brightness_get		= g110_led_mbtns_brightness_get,
+	},
+	{
+		.name			= "g110_%d:orange:m3",
+		.brightness_set		= g110_led_mbtns_brightness_set,
+		.brightness_get		= g110_led_mbtns_brightness_get,
+	},
+	{
+		.name			= "g110_%d:red:mr",
+		.brightness_set		= g110_led_mbtns_brightness_set,
+		.brightness_get		= g110_led_mbtns_brightness_get,
+	},
+	{
+		.name			= "g110_%d:red:bl",
+		.brightness_set		= g110_led_bl_brightness_set,
+		.brightness_get		= g110_led_bl_brightness_get,
+	},
+	{
+		.name			= "g110_%d:blue:bl",
+		.brightness_set		= g110_led_bl_brightness_set,
+		.brightness_get		= g110_led_bl_brightness_get,
+	},
+};
+
+static DEVICE_ATTR(name, 0664, gcore_name_show, gcore_name_store);
+static DEVICE_ATTR(minor, 0444, gcore_minor_show, NULL);
+
+static struct attribute *g110_attrs[] = {
+	&dev_attr_name.attr,
+	&dev_attr_minor.attr,
+	NULL,	 /* need to NULL terminate the list of attributes */
+};
+
+static struct attribute_group g110_attr_group = {
+	.attrs = g110_attrs,
+};
+
+
+static void g110_raw_event_process_input(struct hid_device *hdev,
+					 struct gcore_data *gdata,
+					 u8 *raw_data)
+{
+	struct input_dev *idev = gdata->input_dev;
+	int scancode;
+	int value;
+	int i;
+	int mask;
+
+	raw_data[3] &= 0xBF; /* bit 6 is always on */
+
+	for (i = 0, mask = 0x01; i < 8; i++, mask <<= 1) {
+		/* Keys G1 through G8 */
+		scancode = i;
+		value = raw_data[1] & mask;
+		gcore_input_report_key(gdata, scancode, value);
+
+		/* Keys G9 through MR */
+		scancode = i + 8;
+		value = raw_data[2] & mask;
+		gcore_input_report_key(gdata, scancode, value);
+
+		/* Key Light Only */
+		if (i == 0) {
+			scancode = i + 16;
+			value = raw_data[3] & mask;
+			gcore_input_report_key(gdata, scancode, value);
+		}
+
+	}
+
+	input_sync(idev);
+}
+
+static int g110_raw_event(struct hid_device *hdev,
+			  struct hid_report *report,
+			  u8 *raw_data, int size)
+{
+	struct gcore_data *gdata = dev_get_gdata(&hdev->dev);
+	struct g110_data *g110data = gdata->data;
+	unsigned long irq_flags;
+
+	/*
+	* On initialization receive a 258 byte message with
+	* data = 6 0 255 255 255 255 255 255 255 255 ...
+	*/
+
+	spin_lock_irqsave(&gdata->lock, irq_flags);
+
+	if (unlikely(g110data->ready_stages != G110_READY_STAGE_3)) {
+		switch (report->id) {
+		case 6:
+			if (!(g110data->ready_stages & G110_READY_SUBSTAGE_1))
+				g110data->ready_stages |= G110_READY_SUBSTAGE_1;
+			else if (g110data->ready_stages & G110_READY_SUBSTAGE_4 &&
+				 !(g110data->ready_stages & G110_READY_SUBSTAGE_5))
+				g110data->ready_stages |= G110_READY_SUBSTAGE_5;
+			else if (g110data->ready_stages & G110_READY_SUBSTAGE_6 &&
+				 raw_data[1] >= 0x80)
+				g110data->ready_stages |= G110_READY_SUBSTAGE_7;
+			break;
+		case 1:
+			if (!(g110data->ready_stages & G110_READY_SUBSTAGE_2))
+				g110data->ready_stages |= G110_READY_SUBSTAGE_2;
+			else
+				g110data->ready_stages |= G110_READY_SUBSTAGE_3;
+			break;
+		}
+
+		if (g110data->ready_stages == G110_READY_STAGE_1 ||
+		    g110data->ready_stages == G110_READY_STAGE_2 ||
+		    g110data->ready_stages == G110_READY_STAGE_3)
+			complete_all(&g110data->ready);
+
+		spin_unlock_irqrestore(&gdata->lock, irq_flags);
+		return 1;
+	}
+
+	spin_unlock_irqrestore(&gdata->lock, irq_flags);
+
+	if (likely(report->id == 2)) {
+		g110_raw_event_process_input(hdev, gdata, raw_data);
+		return 1;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+
+static int g110_resume(struct hid_device *hdev)
+{
+	unsigned long irq_flags;
+	struct gcore_data *gdata = hid_get_gdata(hdev);
+
+	spin_lock_irqsave(&gdata->lock, irq_flags);
+	g110_led_bl_send(hdev);
+	g110_led_mbtns_send(hdev);
+	spin_unlock_irqrestore(&gdata->lock, irq_flags);
+
+	return 0;
+}
+
+static int g110_reset_resume(struct hid_device *hdev)
+{
+	return g110_resume(hdev);
+}
+
+#endif /* CONFIG_PM */
+
+/***** probe-related functions *****/
+
+static void g110_feature_report_4_send(struct hid_device *hdev, int which)
+{
+	struct g110_data *g110data = hid_get_g110data(hdev);
+
+	if (which == G110_REPORT_4_INIT) {
+		g110data->feature_report_4->field[0]->value[0] = 0x02;
+		g110data->feature_report_4->field[0]->value[1] = 0x00;
+		g110data->feature_report_4->field[0]->value[2] = 0x00;
+		g110data->feature_report_4->field[0]->value[3] = 0x00;
+	} else if (which == G110_REPORT_4_FINALIZE) {
+		g110data->feature_report_4->field[0]->value[0] = 0x02;
+		g110data->feature_report_4->field[0]->value[1] = 0x80;
+		g110data->feature_report_4->field[0]->value[2] = 0x00;
+		g110data->feature_report_4->field[0]->value[3] = 0xFF;
+	} else {
+		return;
+	}
+
+	hid_hw_request(hdev, g110data->feature_report_4, HID_REQ_SET_REPORT);
+}
+
+
+/* Unlock the urb so we can reuse it */
+static void g110_ep1_urb_completion(struct urb *urb)
+{
+	struct hid_device *hdev = urb->context;
+	struct gcore_data *gdata = hid_get_gdata(hdev);
+	struct g110_data *g110data = gdata->data;
+	struct input_dev *idev = gdata->input_dev;
+	int i;
+
+	for (i = 0; i < 8; i++)
+		gcore_input_report_key(gdata, 24+i,
+				       g110data->ep1keys[0]&(1<<i));
+
+	input_sync(idev);
+
+	usb_submit_urb(urb, GFP_ATOMIC);
+}
+
+static int g110_ep1_read(struct hid_device *hdev)
+{
+	struct usb_interface *intf;
+	struct usb_device *usb_dev;
+	struct g110_data *g110data = hid_get_g110data(hdev);
+
+	struct usb_host_endpoint *ep;
+	unsigned int pipe;
+	int retval = 0;
+
+	/* Get the usb device to send the image on */
+	intf = to_usb_interface(hdev->dev.parent);
+	usb_dev = interface_to_usbdev(intf);
+
+	pipe = usb_rcvintpipe(usb_dev, 0x01);
+	ep = (usb_pipein(pipe) ?
+	      usb_dev->ep_in : usb_dev->ep_out)[usb_pipeendpoint(pipe)];
+
+	if (unlikely(!ep))
+		return -EINVAL;
+
+	usb_fill_int_urb(g110data->ep1_urb, usb_dev, pipe, g110data->ep1keys, 2,
+			 g110_ep1_urb_completion, NULL, 10);
+	g110data->ep1_urb->context = hdev;
+	g110data->ep1_urb->actual_length = 0;
+
+	retval = usb_submit_urb(g110data->ep1_urb, GFP_KERNEL);
+
+	return retval;
+}
+
+static int read_feature_reports(struct gcore_data *gdata)
+{
+	struct hid_device *hdev = gdata->hdev;
+	struct g110_data *g110data = gdata->data;
+
+	struct list_head *feature_report_list =
+			    &hdev->report_enum[HID_FEATURE_REPORT].report_list;
+	struct hid_report *report;
+
+	if (list_empty(feature_report_list)) {
+		dev_err(&hdev->dev,
+			"%s no feature report found\n",
+			gdata->name);
+		return -ENODEV;
+	}
+	dbg_hid("%s feature report found\n", gdata->name);
+
+	list_for_each_entry(report, feature_report_list, list) {
+		switch (report->id) {
+		case 0x03:
+			g110data->feature_report_4 = report;
+			g110data->start_input_report = report;
+			g110data->led_report = report;
+			break;
+		case 0x07:
+			g110data->backlight_report = report;
+			break;
+		default:
+			break;
+		}
+		dbg_hid("%s Feature report: id=%u type=%u size=%u maxfield=%u report_count=%u\n",
+			gdata->name,
+			report->id, report->type, report->size,
+			report->maxfield, report->field[0]->report_count);
+	}
+
+	dbg_hid("%s found all reports\n", gdata->name);
+
+	return 0;
+}
+
+static void wait_ready(struct gcore_data *gdata)
+{
+	struct g110_data *g110data = gdata->data;
+	struct hid_device *hdev = gdata->hdev;
+	unsigned long irq_flags;
+
+	dbg_hid("Waiting for G110 to activate\n");
+
+	/*
+	 * Wait here for stage 1 (substages 1-3) to complete
+	 */
+	wait_for_completion_timeout(&g110data->ready, HZ);
+
+	/* Protect data->ready_stages */
+	spin_lock_irqsave(&gdata->lock, irq_flags);
+	if (g110data->ready_stages != G110_READY_STAGE_1) {
+		dev_warn(&hdev->dev,
+			 "%s hasn't completed stage 1 yet, forging ahead with initialization\n",
+			 gdata->name);
+		/* Force the stage */
+		g110data->ready_stages = G110_READY_STAGE_1;
+	}
+	init_completion(&g110data->ready);
+	g110data->ready_stages |= G110_READY_SUBSTAGE_4;
+	spin_unlock_irqrestore(&gdata->lock, irq_flags);
+
+	/*
+	 * Send the init report, then follow with the input report to trigger
+	 * report 6 and wait for us to get a response.
+	 */
+	g110_feature_report_4_send(hdev, G110_REPORT_4_INIT);
+	hid_hw_request(hdev, g110data->start_input_report, HID_REQ_GET_REPORT);
+	wait_for_completion_timeout(&g110data->ready, HZ);
+
+	/* Protect data->ready_stages */
+	spin_lock_irqsave(&gdata->lock, irq_flags);
+	if (g110data->ready_stages != G110_READY_STAGE_2) {
+		dev_warn(&hdev->dev,
+			 "%s hasn't completed stage 2 yet, forging ahead with initialization\n",
+			 gdata->name);
+		/* Force the stage */
+		g110data->ready_stages = G110_READY_STAGE_2;
+	}
+	init_completion(&g110data->ready);
+	g110data->ready_stages |= G110_READY_SUBSTAGE_6;
+	spin_unlock_irqrestore(&gdata->lock, irq_flags);
+}
+
+static void send_finalize_report(struct gcore_data *gdata)
+{
+	struct g110_data *g110data = gdata->data;
+	struct hid_device *hdev = gdata->hdev;
+	unsigned long irq_flags;
+
+	/*
+	 * Send the finalize report, then follow with the input report to
+	 * trigger report 6 and wait for us to get a response.
+	 */
+	g110_feature_report_4_send(hdev, G110_REPORT_4_FINALIZE);
+	hid_hw_request(hdev, g110data->start_input_report, HID_REQ_GET_REPORT);
+	hid_hw_request(hdev, g110data->start_input_report, HID_REQ_GET_REPORT);
+	wait_for_completion_timeout(&g110data->ready, HZ);
+
+	/* Protect data->ready_stages */
+	spin_lock_irqsave(&gdata->lock, irq_flags);
+
+	if (g110data->ready_stages != G110_READY_STAGE_3) {
+		dev_warn(&hdev->dev,
+			 "%s hasn't completed stage 3 yet, forging ahead with initialization\n",
+			 gdata->name);
+		/* Force the stage */
+		g110data->ready_stages = G110_READY_STAGE_3;
+	} else {
+		dbg_hid("%s stage 3 complete\n", gdata->name);
+	}
+
+	spin_unlock_irqrestore(&gdata->lock, irq_flags);
+}
+
+static int g110_probe(struct hid_device *hdev,
+		      const struct hid_device_id *id)
+{
+	int error;
+	struct gcore_data *gdata;
+	struct g110_data *g110data;
+
+	dev_dbg(&hdev->dev, "Logitech G110 HID hardware probe...");
+
+	gdata = gcore_alloc_data(G110_NAME, hdev);
+	if (gdata == NULL) {
+		dev_err(&hdev->dev,
+			G110_NAME
+			" can't allocate space for device attributes\n");
+		error = -ENOMEM;
+		goto err_no_cleanup;
+	}
+
+	g110data = kzalloc(sizeof(struct g110_data), GFP_KERNEL);
+	if (g110data == NULL) {
+		error = -ENOMEM;
+		goto err_cleanup_gdata;
+	}
+	gdata->data = g110data;
+	init_completion(&g110data->ready);
+
+	g110data->ep1_urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (g110data->ep1_urb == NULL) {
+		dev_err(&hdev->dev,
+			"%s: ERROR: can't alloc ep1 urb stuff\n",
+			gdata->name);
+		error = -ENOMEM;
+		goto err_cleanup_g110data;
+	}
+
+	error = gcore_hid_open(gdata);
+	if (error) {
+		dev_err(&hdev->dev,
+			"%s error opening hid device\n",
+			gdata->name);
+		goto err_cleanup_ep1_urb;
+	}
+
+	error = gcore_input_probe(gdata, g110_default_keymap,
+				  ARRAY_SIZE(g110_default_keymap));
+	if (error) {
+		dev_err(&hdev->dev,
+			"%s error registering input device\n",
+			gdata->name);
+		goto err_cleanup_hid;
+	}
+
+	error = read_feature_reports(gdata);
+	if (error) {
+		dev_err(&hdev->dev,
+			"%s error reading feature reports\n",
+			gdata->name);
+		goto err_cleanup_input;
+	}
+
+	error = gcore_leds_probe(gdata, g110_led_cdevs,
+				 ARRAY_SIZE(g110_led_cdevs));
+	if (error) {
+		dev_err(&hdev->dev, "%s error registering leds\n", gdata->name);
+		goto err_cleanup_input;
+	}
+
+	error = sysfs_create_group(&(hdev->dev.kobj), &g110_attr_group);
+	if (error) {
+		dev_err(&hdev->dev,
+			"%s failed to create sysfs group attributes\n",
+			gdata->name);
+		goto err_cleanup_leds;
+	}
+
+	wait_ready(gdata);
+
+	/*
+	 * Clear the LEDs
+	 */
+	g110data->backlight_rb[0] = G110_DEFAULT_RED;
+	g110data->backlight_rb[1] = G110_DEFAULT_BLUE;
+
+	g110_led_mbtns_send(hdev);
+	g110_led_bl_send(hdev);
+
+	send_finalize_report(gdata);
+
+	error = g110_ep1_read(hdev);
+	if (error) {
+		dev_err(&hdev->dev, "%s failed to read ep1\n", gdata->name);
+		goto err_cleanup_sysfs;
+	}
+
+	dbg_hid("G110 activated and initialized\n");
+
+	/* Everything went well */
+	return 0;
+
+err_cleanup_sysfs:
+	sysfs_remove_group(&(hdev->dev.kobj), &g110_attr_group);
+
+err_cleanup_leds:
+	gcore_leds_remove(gdata);
+
+err_cleanup_input:
+	gcore_input_remove(gdata);
+
+err_cleanup_hid:
+	gcore_hid_close(gdata);
+
+err_cleanup_ep1_urb:
+	usb_free_urb(g110data->ep1_urb);
+
+err_cleanup_g110data:
+	kfree(g110data);
+
+err_cleanup_gdata:
+	gcore_free_data(gdata);
+
+err_no_cleanup:
+	hid_set_drvdata(hdev, NULL);
+	return error;
+}
+
+static void g110_remove(struct hid_device *hdev)
+{
+	struct gcore_data *gdata = hid_get_drvdata(hdev);
+	struct g110_data *g110data = gdata->data;
+
+	usb_poison_urb(g110data->ep1_urb);
+
+	sysfs_remove_group(&(hdev->dev.kobj), &g110_attr_group);
+
+	gcore_leds_remove(gdata);
+	gcore_input_remove(gdata);
+	gcore_hid_close(gdata);
+
+	usb_free_urb(g110data->ep1_urb);
+
+	kfree(g110data);
+	gcore_free_data(gdata);
+}
+
+static const struct hid_device_id g110_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G110) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, g110_devices);
+
+static struct hid_driver g110_driver = {
+	.name			= "hid-g110",
+	.id_table		= g110_devices,
+	.probe			= g110_probe,
+	.remove			= g110_remove,
+	.raw_event		= g110_raw_event,
+
+#ifdef CONFIG_PM
+	.resume			= g110_resume,
+	.reset_resume		= g110_reset_resume,
+#endif
+};
+
+static int __init g110_init(void)
+{
+	return hid_register_driver(&g110_driver);
+}
+
+static void __exit g110_exit(void)
+{
+	hid_unregister_driver(&g110_driver);
+}
+
+module_init(g110_init);
+module_exit(g110_exit);
+MODULE_DESCRIPTION("Logitech G110 HID Driver");
+MODULE_AUTHOR("Alistair Buxton (a.j.buxton@gmail.com)");
+MODULE_AUTHOR("Ciubotariu Ciprian (cheepeero@gmx.net)");
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-g13.c b/drivers/hid/hid-g13.c
new file mode 100644
index 0000000..6bcc4f9
--- /dev/null
+++ b/drivers/hid/hid-g13.c
@@ -0,0 +1,783 @@
+/***************************************************************************
+ *   Copyright (C) 2009 by Rick L. Vinyard, Jr.				   *
+ *   rvinyard@cs.nmsu.edu						   *
+ *									   *
+ *   This program is free software: you can redistribute it and/or modify  *
+ *   it under the terms of the GNU General Public License as published by  *
+ *   the Free Software Foundation, either version 2 of the License, or	   *
+ *   (at your option) any later version.				   *
+ *									   *
+ *   This driver is distributed in the hope that it will be useful, but	   *
+ *   WITHOUT ANY WARRANTY; without even the implied warranty of		   *
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU	   *
+ *   General Public License for more details.				   *
+ *									   *
+ *   You should have received a copy of the GNU General Public License	   *
+ *   along with this software. If not see <http://www.gnu.org/licenses/>.  *
+ ***************************************************************************/
+#include <linux/fb.h>
+#include <linux/hid.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/sysfs.h>
+#include <linux/uaccess.h>
+#include <linux/usb.h>
+#include <linux/vmalloc.h>
+#include <linux/leds.h>
+#include <linux/completion.h>
+#include <linux/version.h>
+
+#include "hid-ids.h"
+#include "hid-gcore.h"
+#include "hid-gfb.h"
+
+#define G13_NAME "Logitech G13"
+
+/* Key defines */
+#define G13_KEYS 35
+#define G13_KEYMAP_SIZE (G13_KEYS*3)
+
+/* Framebuffer defines */
+#define G13FB_NAME "g13fb"
+#define G13FB_WIDTH (160)
+#define G13FB_LINE_LENGTH (160/8)
+#define G13FB_HEIGHT (43)
+#define G13FB_SIZE (G13FB_LINE_LENGTH*G13FB_HEIGHT)
+
+#define G13FB_UPDATE_RATE_LIMIT (20)
+#define G13FB_UPDATE_RATE_DEFAULT (10)
+
+/* Backlight defaults */
+#define G13_DEFAULT_RED (0)
+#define G13_DEFAULT_GREEN (255)
+#define G13_DEFAULT_BLUE (0)
+
+#define LED_COUNT 7
+
+/* LED array indices */
+#define G13_LED_M1 0
+#define G13_LED_M2 1
+#define G13_LED_M3 2
+#define G13_LED_MR 3
+#define G13_LED_BL_R 4
+#define G13_LED_BL_G 5
+#define G13_LED_BL_B 6
+
+#define G13_REPORT_4_INIT	0x00
+#define G13_REPORT_4_FINALIZE	0x01
+
+#define G13_READY_SUBSTAGE_1 0x01
+#define G13_READY_SUBSTAGE_2 0x02
+#define G13_READY_SUBSTAGE_3 0x04
+#define G13_READY_STAGE_1    0x07
+#define G13_READY_SUBSTAGE_4 0x08
+#define G13_READY_SUBSTAGE_5 0x10
+#define G13_READY_STAGE_2    0x1F
+#define G13_READY_SUBSTAGE_6 0x20
+#define G13_READY_SUBSTAGE_7 0x40
+#define G13_READY_STAGE_3    0x7F
+
+#define G13_RESET_POST 0x01
+#define G13_RESET_MESSAGE_1 0x02
+#define G13_RESET_READY 0x03
+
+/* G13-specific device data structure */
+struct g13_data {
+	/* HID reports */
+	struct hid_report *backlight_report;
+	struct hid_report *start_input_report;
+	struct hid_report *feature_report_4;
+	struct hid_report *led_report;
+	struct hid_report *output_report_3;
+
+	/* led state */
+	u8 backlight_rgb[3];	/* keyboard illumination */
+	u8 led_mbtns;		/* m1, m2, m3 and mr */
+
+	/* initialization stages */
+	struct completion ready;
+	int ready_stages;
+};
+
+/* Convenience macros */
+#define hid_get_g13data(hdev) \
+	((struct g13_data *)(hid_get_gdata(hdev)->data))
+#define dev_get_g19data(dev) \
+	((struct g13_data *)(dev_get_gdata(dev)->data))
+
+/*
+ * Keymap array indices
+ *
+ * Key	      Index
+ * ---------  ------
+ * G1-G22     0-21
+ * FUNC	      22
+ * LCD1	      23
+ * LCD2	      24
+ * LCD3	      25
+ * LCD4	      26
+ * M1	      27
+ * M2	      28
+ * M3	      29
+ * MR	      30
+ * BTN_LEFT   31
+ * BTN_DOWN   32
+ * BTN_STICK  33
+ * LIGHT      34
+ */
+static const unsigned int g13_default_keymap[G13_KEYS] = {
+	/* first row g1 - g7 */
+	KEY_F1, KEY_F2, KEY_F3, KEY_F4, KEY_F5, KEY_F6, KEY_F7,
+	/* second row g8 - g11 */
+	KEY_F8, KEY_F9, KEY_F10, KEY_F11,
+	/* second row g12 - g14 */
+	KEY_F12, KEY_F13, KEY_F14,
+	/* third row g15 - g19 */
+	KEY_F15, KEY_F16, KEY_F17, KEY_F18, KEY_F19,
+	/* fourth row g20 - g22 */
+	KEY_F20, KEY_F21, KEY_F22,
+	/* next, lightLeft, lightCenterLeft, lightCenterRight, lightRight */
+	/* BTN_0, BTN_1, BTN_2, BTN_3, BTN_4, */
+	KEY_OK, KEY_LEFT, KEY_UP, KEY_DOWN, KEY_RIGHT,
+	/* M1, M2, M3, MR */
+	KEY_PROG1, KEY_PROG2, KEY_PROG3, KEY_RECORD,
+	/* button left, button down, button stick, light */
+	BTN_LEFT, BTN_RIGHT, BTN_MIDDLE, KEY_KBDILLUMTOGGLE
+};
+
+static void g13_led_mbtns_send(struct hid_device *hdev)
+{
+	struct g13_data *g13data = hid_get_g13data(hdev);
+
+	g13data->led_report->field[0]->value[0] = g13data->led_mbtns&0x0F;
+	g13data->led_report->field[0]->value[1] = 0x00;
+	g13data->led_report->field[0]->value[2] = 0x00;
+	g13data->led_report->field[0]->value[3] = 0x00;
+
+	hid_hw_request(hdev, g13data->led_report, HID_REQ_SET_REPORT);
+}
+
+static void g13_led_mbtns_brightness_set(struct led_classdev *led_cdev,
+					 enum led_brightness value)
+{
+	struct hid_device *hdev = gcore_led_classdev_to_hdev(led_cdev);
+	struct gcore_data *gdata = hid_get_gdata(hdev);
+	struct g13_data *g13data = gdata->data;
+	u8 mask = 0;
+
+	if (led_cdev == gdata->led_cdev[G13_LED_M1])
+		mask = 0x01;
+	else if (led_cdev == gdata->led_cdev[G13_LED_M2])
+		mask = 0x02;
+	else if (led_cdev == gdata->led_cdev[G13_LED_M3])
+		mask = 0x04;
+	else if (led_cdev == gdata->led_cdev[G13_LED_MR])
+		mask = 0x08;
+
+	if (mask && value)
+		g13data->led_mbtns |= mask;
+	else
+		g13data->led_mbtns &= ~mask;
+
+	g13_led_mbtns_send(hdev);
+}
+
+static enum led_brightness
+g13_led_mbtns_brightness_get(struct led_classdev *led_cdev)
+{
+	struct hid_device *hdev = gcore_led_classdev_to_hdev(led_cdev);
+	struct gcore_data *gdata = hid_get_gdata(hdev);
+	struct g13_data *g13data = gdata->data;
+	int value = 0;
+
+	if (led_cdev == gdata->led_cdev[G13_LED_M1])
+		value = g13data->led_mbtns & 0x01;
+	else if (led_cdev == gdata->led_cdev[G13_LED_M2])
+		value = g13data->led_mbtns & 0x02;
+	else if (led_cdev == gdata->led_cdev[G13_LED_M3])
+		value = g13data->led_mbtns & 0x04;
+	else if (led_cdev == gdata->led_cdev[G13_LED_MR])
+		value = g13data->led_mbtns & 0x08;
+	else
+		dev_err(&hdev->dev,
+			G13_NAME " error retrieving LED brightness\n");
+
+	if (value)
+		return LED_FULL;
+	return LED_OFF;
+}
+
+static void g13_led_bl_send(struct hid_device *hdev)
+{
+	struct g13_data *g13data = hid_get_g13data(hdev);
+
+	struct hid_field *field0 = g13data->backlight_report->field[0];
+
+	field0->value[0] = g13data->backlight_rgb[0];
+	field0->value[1] = g13data->backlight_rgb[1];
+	field0->value[2] = g13data->backlight_rgb[2];
+	field0->value[3] = 0x00;
+
+	hid_hw_request(hdev, g13data->backlight_report, HID_REQ_SET_REPORT);
+}
+
+static void g13_led_bl_brightness_set(struct led_classdev *led_cdev,
+				      enum led_brightness value)
+{
+	struct hid_device *hdev = gcore_led_classdev_to_hdev(led_cdev);
+	struct gcore_data *gdata = hid_get_gdata(hdev);
+	struct g13_data *g13data = gdata->data;
+
+	if (led_cdev == gdata->led_cdev[G13_LED_BL_R])
+		g13data->backlight_rgb[0] = value;
+	else if (led_cdev == gdata->led_cdev[G13_LED_BL_G])
+		g13data->backlight_rgb[1] = value;
+	else if (led_cdev == gdata->led_cdev[G13_LED_BL_B])
+		g13data->backlight_rgb[2] = value;
+
+	g13_led_bl_send(hdev);
+}
+
+static enum led_brightness
+g13_led_bl_brightness_get(struct led_classdev *led_cdev)
+{
+	struct hid_device *hdev = gcore_led_classdev_to_hdev(led_cdev);
+	struct gcore_data *gdata = hid_get_gdata(hdev);
+	struct g13_data *g13data = gdata->data;
+
+	if (led_cdev == gdata->led_cdev[G13_LED_BL_R])
+		return g13data->backlight_rgb[0];
+	else if (led_cdev == gdata->led_cdev[G13_LED_BL_G])
+		return g13data->backlight_rgb[1];
+	else if (led_cdev == gdata->led_cdev[G13_LED_BL_B])
+		return g13data->backlight_rgb[2];
+
+	dev_err(&hdev->dev, G13_NAME " error retrieving LED brightness\n");
+	return LED_OFF;
+}
+
+static const struct led_classdev g13_led_cdevs[LED_COUNT] = {
+	{
+		.name			= "g13_%d:red:m1",
+		.brightness_set		= g13_led_mbtns_brightness_set,
+		.brightness_get		= g13_led_mbtns_brightness_get,
+	},
+	{
+		.name			= "g13_%d:red:m2",
+		.brightness_set		= g13_led_mbtns_brightness_set,
+		.brightness_get		= g13_led_mbtns_brightness_get,
+	},
+	{
+		.name			= "g13_%d:red:m3",
+		.brightness_set		= g13_led_mbtns_brightness_set,
+		.brightness_get		= g13_led_mbtns_brightness_get,
+	},
+	{
+		.name			= "g13_%d:red:mr",
+		.brightness_set		= g13_led_mbtns_brightness_set,
+		.brightness_get		= g13_led_mbtns_brightness_get,
+	},
+	{
+		.name			= "g13_%d:red:bl",
+		.brightness_set		= g13_led_bl_brightness_set,
+		.brightness_get		= g13_led_bl_brightness_get,
+	},
+	{
+		.name			= "g13_%d:green:bl",
+		.brightness_set		= g13_led_bl_brightness_set,
+		.brightness_get		= g13_led_bl_brightness_get,
+	},
+	{
+		.name			= "g13_%d:blue:bl",
+		.brightness_set		= g13_led_bl_brightness_set,
+		.brightness_get		= g13_led_bl_brightness_get,
+	},
+};
+
+static DEVICE_ATTR(fb_node, 0444, gfb_fb_node_show, NULL);
+static DEVICE_ATTR(fb_update_rate, 0664,
+		   gfb_fb_update_rate_show, gfb_fb_update_rate_store);
+static DEVICE_ATTR(name, 0664, gcore_name_show, gcore_name_store);
+static DEVICE_ATTR(minor, 0444, gcore_minor_show, NULL);
+
+static struct attribute *g13_attrs[] = {
+	&dev_attr_name.attr,
+	&dev_attr_minor.attr,
+	&dev_attr_fb_update_rate.attr,
+	&dev_attr_fb_node.attr,
+	NULL,	/* need to NULL terminate the list of attributes */
+};
+
+static struct attribute_group g13_attr_group = {
+	.attrs = g13_attrs,
+};
+
+
+static void g13_raw_event_process_input(struct hid_device *hdev,
+					struct gcore_data *gdata,
+					u8 *raw_data)
+{
+	struct input_dev *idev = gdata->input_dev;
+	int scancode;
+	int value;
+	int i;
+	int mask;
+
+	for (i = 0, mask = 0x01; i < 8; i++, mask <<= 1) {
+		/* Keys G1 through G8 */
+		scancode = i;
+		value = raw_data[3] & mask;
+		gcore_input_report_key(gdata, scancode, value);
+
+		/* Keys G9 through G16 */
+		scancode = i + 8;
+		value = raw_data[4] & mask;
+		gcore_input_report_key(gdata, scancode, value);
+
+		/* Keys G17 through G22 */
+		scancode = i + 16;
+		value = raw_data[5] & mask;
+		if (i <= 5)
+			gcore_input_report_key(gdata, scancode, value);
+
+		/* Keys FUNC through M3 */
+		scancode = i + 22;
+		value = raw_data[6] & mask;
+		gcore_input_report_key(gdata, scancode, value);
+
+		/* Keys MR through LIGHT */
+		scancode = i + 30;
+		value = raw_data[7] & mask;
+		if (i <= 4)
+			gcore_input_report_key(gdata, scancode, value);
+	}
+
+	input_report_abs(idev, ABS_X, raw_data[1]);
+	input_report_abs(idev, ABS_Y, raw_data[2]);
+	input_sync(idev);
+}
+
+static int g13_raw_event(struct hid_device *hdev,
+			 struct hid_report *report,
+			 u8 *raw_data, int size)
+{
+	unsigned long irq_flags;
+
+	/*
+	 * On initialization receive a 258 byte message with
+	 * data = 6 0 255 255 255 255 255 255 255 255 ...
+	 */
+	struct gcore_data *gdata = dev_get_gdata(&hdev->dev);
+	struct g13_data *g13data = gdata->data;
+
+	spin_lock_irqsave(&gdata->lock, irq_flags);
+
+	if (unlikely(g13data->ready_stages != G13_READY_STAGE_3)) {
+		switch (report->id) {
+		case 6:
+			if (!(g13data->ready_stages & G13_READY_SUBSTAGE_1))
+				g13data->ready_stages |= G13_READY_SUBSTAGE_1;
+			else if (g13data->ready_stages & G13_READY_SUBSTAGE_4 &&
+				 !(g13data->ready_stages & G13_READY_SUBSTAGE_5)
+				)
+				g13data->ready_stages |= G13_READY_SUBSTAGE_5;
+			else if (g13data->ready_stages & G13_READY_SUBSTAGE_6 &&
+				 raw_data[1] >= 0x80)
+				g13data->ready_stages |= G13_READY_SUBSTAGE_7;
+			break;
+		case 1:
+			if (!(g13data->ready_stages & G13_READY_SUBSTAGE_2))
+				g13data->ready_stages |= G13_READY_SUBSTAGE_2;
+			else
+				g13data->ready_stages |= G13_READY_SUBSTAGE_3;
+			break;
+		}
+
+		if (g13data->ready_stages == G13_READY_STAGE_1 ||
+		    g13data->ready_stages == G13_READY_STAGE_2 ||
+		    g13data->ready_stages == G13_READY_STAGE_3)
+			complete_all(&g13data->ready);
+
+		spin_unlock_irqrestore(&gdata->lock, irq_flags);
+		return 1;
+	}
+
+	spin_unlock_irqrestore(&gdata->lock, irq_flags);
+
+	if (likely(report->id == 1)) {
+		g13_raw_event_process_input(hdev, gdata, raw_data);
+		return 1;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+
+static int g13_resume(struct hid_device *hdev)
+{
+	unsigned long irq_flags;
+	struct gcore_data *gdata = hid_get_gdata(hdev);
+
+	spin_lock_irqsave(&gdata->lock, irq_flags);
+	g13_led_bl_send(hdev);
+	g13_led_mbtns_send(hdev);
+	spin_unlock_irqrestore(&gdata->lock, irq_flags);
+
+	return 0;
+}
+
+static int g13_reset_resume(struct hid_device *hdev)
+{
+	return g13_resume(hdev);
+}
+
+#endif /* CONFIG_PM */
+
+
+/***** probe-related functions *****/
+
+
+static void g13_feature_report_4_send(struct hid_device *hdev, int which)
+{
+	struct g13_data *g13data = hid_get_g13data(hdev);
+
+	if (which == G13_REPORT_4_INIT) {
+		g13data->feature_report_4->field[0]->value[0] = 0x02;
+		g13data->feature_report_4->field[0]->value[1] = 0x00;
+		g13data->feature_report_4->field[0]->value[2] = 0x00;
+		g13data->feature_report_4->field[0]->value[3] = 0x00;
+	} else if (which == G13_REPORT_4_FINALIZE) {
+		g13data->feature_report_4->field[0]->value[0] = 0x02;
+		g13data->feature_report_4->field[0]->value[1] = 0x80;
+		g13data->feature_report_4->field[0]->value[2] = 0x00;
+		g13data->feature_report_4->field[0]->value[3] = 0xFF;
+	} else {
+		return;
+	}
+
+	hid_hw_request(hdev, g13data->feature_report_4, HID_REQ_SET_REPORT);
+}
+
+static int read_feature_reports(struct gcore_data *gdata)
+{
+	struct hid_device *hdev = gdata->hdev;
+	struct g13_data *g13data = gdata->data;
+
+	struct list_head *feature_report_list =
+			    &hdev->report_enum[HID_FEATURE_REPORT].report_list;
+	struct list_head *output_report_list =
+			    &hdev->report_enum[HID_OUTPUT_REPORT].report_list;
+	struct hid_report *report;
+
+	if (list_empty(feature_report_list)) {
+		dev_err(&hdev->dev, "no feature report found\n");
+		return -ENODEV;
+	}
+	dbg_hid(G13_NAME " feature report found\n");
+
+	list_for_each_entry(report, feature_report_list, list) {
+		switch (report->id) {
+		case 0x04:
+			g13data->feature_report_4 = report;
+			break;
+		case 0x05:
+			g13data->led_report = report;
+			break;
+		case 0x06:
+			g13data->start_input_report = report;
+			break;
+		case 0x07:
+			g13data->backlight_report = report;
+			break;
+		default:
+			break;
+		}
+		dbg_hid("%s Feature report: id=%u type=%u size=%u maxfield=%u report_count=%u\n",
+			gdata->name,
+			report->id, report->type, report->size,
+			report->maxfield, report->field[0]->report_count);
+	}
+
+	if (list_empty(output_report_list)) {
+		dev_err(&hdev->dev, "no output report found\n");
+		return -ENODEV;
+	}
+	dbg_hid(G13_NAME " output report found\n");
+
+	list_for_each_entry(report, output_report_list, list) {
+		dbg_hid("%s output report %d found size=%u maxfield=%u\n",
+			gdata->name,
+			report->id, report->size, report->maxfield);
+		if (report->maxfield > 0) {
+			dbg_hid("%s offset=%u size=%u count=%u type=%u\n",
+				gdata->name,
+				report->field[0]->report_offset,
+				report->field[0]->report_size,
+				report->field[0]->report_count,
+				report->field[0]->report_type);
+		}
+		switch (report->id) {
+		case 0x03:
+			g13data->output_report_3 = report;
+			break;
+		}
+	}
+
+	dbg_hid("%s found all reports\n", gdata->name);
+
+	return 0;
+}
+
+static void wait_ready(struct gcore_data *gdata)
+{
+	struct g13_data *g13data = gdata->data;
+	struct hid_device *hdev = gdata->hdev;
+	unsigned long irq_flags;
+
+	dbg_hid("Waiting for G13 to activate\n");
+
+	/*
+	 * Wait here for stage 1 (substages 1-3) to complete
+	 */
+	wait_for_completion_timeout(&g13data->ready, HZ);
+
+	/* Protect data->ready_stages */
+	spin_lock_irqsave(&gdata->lock, irq_flags);
+	if (g13data->ready_stages != G13_READY_STAGE_1) {
+		dev_warn(&hdev->dev,
+			 "%s hasn't completed stage 1 yet, forging ahead with initialization\n",
+			 gdata->name);
+		/* Force the stage */
+		g13data->ready_stages = G13_READY_STAGE_1;
+	}
+	init_completion(&g13data->ready);
+	g13data->ready_stages |= G13_READY_SUBSTAGE_4;
+	spin_unlock_irqrestore(&gdata->lock, irq_flags);
+
+	/*
+	 * Send the init report, then follow with the input report to trigger
+	 * report 6 and wait for us to get a response.
+	 */
+	g13_feature_report_4_send(hdev, G13_REPORT_4_INIT);
+	hid_hw_request(hdev, g13data->start_input_report, HID_REQ_GET_REPORT);
+	wait_for_completion_timeout(&g13data->ready, HZ);
+
+	/* Protect data->ready_stages */
+	spin_lock_irqsave(&gdata->lock, irq_flags);
+	if (g13data->ready_stages != G13_READY_STAGE_2) {
+		dev_warn(&hdev->dev,
+			 "%s hasn't completed stage 2 yet, forging ahead with initialization\n",
+			 gdata->name);
+		/* Force the stage */
+		g13data->ready_stages = G13_READY_STAGE_2;
+	}
+	init_completion(&g13data->ready);
+	g13data->ready_stages |= G13_READY_SUBSTAGE_6;
+	spin_unlock_irqrestore(&gdata->lock, irq_flags);
+}
+
+static void send_finalize_report(struct gcore_data *gdata)
+{
+	struct g13_data *g13data = gdata->data;
+	struct hid_device *hdev = gdata->hdev;
+	unsigned long irq_flags;
+
+	/*
+	 * Send the finalize report, then follow with the input report to
+	 * trigger report 6 and wait for us to get a response.
+	 */
+	g13_feature_report_4_send(hdev, G13_REPORT_4_FINALIZE);
+	hid_hw_request(hdev, g13data->start_input_report, HID_REQ_GET_REPORT);
+	hid_hw_request(hdev, g13data->start_input_report, HID_REQ_GET_REPORT);
+	wait_for_completion_timeout(&g13data->ready, HZ);
+
+	/* Protect data->ready_stages */
+	spin_lock_irqsave(&gdata->lock, irq_flags);
+
+	if (g13data->ready_stages != G13_READY_STAGE_3) {
+		dev_warn(&hdev->dev, G13_NAME " hasn't completed stage 3 yet, forging ahead with initialization\n");
+		/* Force the stage */
+		g13data->ready_stages = G13_READY_STAGE_3;
+	} else {
+		dbg_hid(G13_NAME " stage 3 complete\n");
+	}
+
+	spin_unlock_irqrestore(&gdata->lock, irq_flags);
+}
+
+static int g13_probe(struct hid_device *hdev,
+		     const struct hid_device_id *id)
+{
+	int error;
+	struct gcore_data *gdata;
+	struct g13_data *g13data;
+
+	dev_dbg(&hdev->dev, "Logitech G13 HID hardware probe...");
+
+	gdata = gcore_alloc_data(G13_NAME, hdev);
+	if (gdata == NULL) {
+		dev_err(&hdev->dev,
+			G13_NAME
+			" can't allocate space for device attributes\n");
+		error = -ENOMEM;
+		goto err_no_cleanup;
+	}
+
+	g13data = kzalloc(sizeof(struct g13_data), GFP_KERNEL);
+	if (g13data == NULL) {
+		error = -ENOMEM;
+		goto err_cleanup_gdata;
+	}
+	gdata->data = g13data;
+	init_completion(&g13data->ready);
+
+	error = gcore_hid_open(gdata);
+	if (error) {
+		dev_err(&hdev->dev,
+			"%s error opening hid device\n",
+			gdata->name);
+		goto err_cleanup_g13data;
+	}
+
+	error = gcore_input_probe(gdata, g13_default_keymap,
+				  ARRAY_SIZE(g13_default_keymap));
+	if (error) {
+		dev_err(&hdev->dev,
+			"%s error registering input device\n",
+			gdata->name);
+		goto err_cleanup_hid;
+	}
+
+	/* initialize the joystick on the G13 */
+	input_set_capability(gdata->input_dev, EV_ABS, ABS_X);
+	input_set_capability(gdata->input_dev, EV_ABS, ABS_Y);
+	input_set_capability(gdata->input_dev, EV_MSC, MSC_SCAN);
+
+	/* 4 center values */
+	input_set_abs_params(gdata->input_dev, ABS_X, 0, 0xff, 0, 4);
+	input_set_abs_params(gdata->input_dev, ABS_Y, 0, 0xff, 0, 4);
+
+	error = read_feature_reports(gdata);
+	if (error) {
+		dev_err(&hdev->dev,
+			"%s error reading feature reports\n",
+			gdata->name);
+		goto err_cleanup_input;
+	}
+
+	error = gcore_leds_probe(gdata, g13_led_cdevs,
+				 ARRAY_SIZE(g13_led_cdevs));
+	if (error) {
+		dev_err(&hdev->dev, "%s error registering leds\n", gdata->name);
+		goto err_cleanup_input;
+	}
+
+	gdata->gfb_data = gfb_probe(hdev, GFB_PANEL_TYPE_160_43_1);
+	if (gdata->gfb_data == NULL) {
+		dev_err(&hdev->dev, G13_NAME " error registering framebuffer\n");
+		goto err_cleanup_leds;
+	}
+
+	error = sysfs_create_group(&(hdev->dev.kobj), &g13_attr_group);
+	if (error) {
+		dev_err(&hdev->dev, G13_NAME " failed to create sysfs group attributes\n");
+		goto err_cleanup_gfb;
+	}
+
+	wait_ready(gdata);
+
+	/*
+	 * Clear the LEDs
+	 */
+	g13data->backlight_rgb[0] = G13_DEFAULT_RED;
+	g13data->backlight_rgb[1] = G13_DEFAULT_GREEN;
+	g13data->backlight_rgb[2] = G13_DEFAULT_BLUE;
+
+	g13_led_mbtns_send(hdev);
+	g13_led_bl_send(hdev);
+
+	send_finalize_report(gdata);
+
+	dbg_hid("G13 activated and initialized\n");
+
+	/* Everything went well */
+	return 0;
+
+err_cleanup_gfb:
+	gfb_remove(gdata->gfb_data);
+
+err_cleanup_leds:
+	gcore_leds_remove(gdata);
+
+err_cleanup_input:
+	gcore_input_remove(gdata);
+
+err_cleanup_hid:
+	gcore_hid_close(gdata);
+
+err_cleanup_g13data:
+	kfree(g13data);
+
+err_cleanup_gdata:
+	gcore_free_data(gdata);
+
+err_no_cleanup:
+	hid_set_drvdata(hdev, NULL);
+	return error;
+}
+
+static void g13_remove(struct hid_device *hdev)
+{
+	struct gcore_data *gdata = hid_get_drvdata(hdev);
+	struct g13_data *g13data = gdata->data;
+
+	sysfs_remove_group(&(hdev->dev.kobj), &g13_attr_group);
+
+	gfb_remove(gdata->gfb_data);
+
+	gcore_leds_remove(gdata);
+	gcore_input_remove(gdata);
+	gcore_hid_close(gdata);
+
+	kfree(g13data);
+	gcore_free_data(gdata);
+}
+
+static const struct hid_device_id g13_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G13) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, g13_devices);
+
+static struct hid_driver g13_driver = {
+	.name			= "hid-g13",
+	.id_table		= g13_devices,
+	.probe			= g13_probe,
+	.remove			= g13_remove,
+	.raw_event		= g13_raw_event,
+
+#ifdef CONFIG_PM
+	.resume			= g13_resume,
+	.reset_resume		= g13_reset_resume,
+#endif
+};
+
+static int __init g13_init(void)
+{
+	return hid_register_driver(&g13_driver);
+}
+
+static void __exit g13_exit(void)
+{
+	hid_unregister_driver(&g13_driver);
+}
+
+module_init(g13_init);
+module_exit(g13_exit);
+MODULE_DESCRIPTION("Logitech G13 HID Driver");
+MODULE_AUTHOR("Rick L Vinyard Jr (rvinyard@cs.nmsu.edu)");
+MODULE_AUTHOR("Ciubotariu Ciprian (cheepeero@gmx.net)");
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-g15v2.c b/drivers/hid/hid-g15v2.c
new file mode 100644
index 0000000..fd557a8
--- /dev/null
+++ b/drivers/hid/hid-g15v2.c
@@ -0,0 +1,721 @@
+/***************************************************************************
+ *   Copyright (C) 2010 by Alistair Buxton				   *
+ *   a.j.buxton@gmail.com						   *
+ *   based on hid-g13.c							   *
+ *									   *
+ *   This program is free software: you can redistribute it and/or modify  *
+ *   it under the terms of the GNU General Public License as published by  *
+ *   the Free Software Foundation, either version 2 of the License, or	   *
+ *   (at your option) any later version.				   *
+ *									   *
+ *   This driver is distributed in the hope that it will be useful, but	   *
+ *   WITHOUT ANY WARRANTY; without even the implied warranty of		   *
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU	   *
+ *   General Public License for more details.				   *
+ *									   *
+ *   You should have received a copy of the GNU General Public License	   *
+ *   along with this software. If not see <http://www.gnu.org/licenses/>.  *
+ ***************************************************************************/
+#include <linux/fb.h>
+#include <linux/hid.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/sysfs.h>
+#include <linux/uaccess.h>
+#include <linux/usb.h>
+#include <linux/vmalloc.h>
+#include <linux/leds.h>
+#include <linux/completion.h>
+#include <linux/version.h>
+
+#include "hid-ids.h"
+#include "hid-gcore.h"
+#include "hid-gfb.h"
+
+#define G15V2_NAME "Logitech G15v2"
+
+/* Key defines */
+#define G15V2_KEYS 16
+
+/* Backlight defaults */
+#define G15V2_DEFAULT_RED (0)
+#define G15V2_DEFAULT_GREEN (255)
+#define G15V2_DEFAULT_BLUE (0)
+
+/* LED array indices */
+#define G15V2_LED_M1 0
+#define G15V2_LED_M2 1
+#define G15V2_LED_M3 2
+#define G15V2_LED_MR 3
+#define G15V2_LED_BL_KEYS 4
+#define G15V2_LED_BL_SCREEN 5
+#define G15V2_LED_BL_CONTRAST 6 /* HACK ALERT contrast is nothing like a LED */
+
+#define G15V2_REPORT_4_INIT	0x00
+#define G15V2_REPORT_4_FINALIZE	0x01
+
+#define G15V2_READY_SUBSTAGE_1 0x01
+#define G15V2_READY_SUBSTAGE_2 0x02
+#define G15V2_READY_SUBSTAGE_3 0x04
+#define G15V2_READY_STAGE_1    0x07
+#define G15V2_READY_SUBSTAGE_4 0x08
+#define G15V2_READY_SUBSTAGE_5 0x10
+#define G15V2_READY_STAGE_2    0x1F
+#define G15V2_READY_SUBSTAGE_6 0x20
+#define G15V2_READY_SUBSTAGE_7 0x40
+#define G15V2_READY_STAGE_3    0x7F
+
+#define G15V2_RESET_POST 0x01
+#define G15V2_RESET_MESSAGE_1 0x02
+#define G15V2_RESET_READY 0x03
+
+/* Per device data structure */
+struct g15v2_data {
+	/* HID reports */
+	struct hid_report *backlight_report;
+	struct hid_report *start_input_report;
+	struct hid_report *feature_report_4;
+	struct hid_report *led_report;
+	struct hid_report *output_report_3;
+
+	/* led state */
+	u8 backlight;		/* keyboard illumination */
+	u8 screen_bl;		/* screen backlight */
+	u8 screen_contrast;	/* screen contrast */
+	u8 led_mbtns;		/* m1, m2, m3 and mr */
+
+	/* initialization stages */
+	struct completion ready;
+	int ready_stages;
+};
+
+/* Convenience macros */
+#define hid_get_g15data(hdev) \
+	((struct g15v2_data *)(hid_get_gdata(hdev)->data))
+#define dev_get_g15data(dev) \
+	((struct g15v2_data *)(dev_get_gdata(dev)->data))
+
+/*
+ * Keymap array indices
+ */
+static const unsigned int g15v2_default_keymap[G15V2_KEYS] = {
+	KEY_F1,
+	KEY_F2,
+	KEY_F3,
+	KEY_F4,
+	KEY_F5,
+	KEY_F6,
+	KEY_PROG1,
+	KEY_PROG2,
+	KEY_KBDILLUMTOGGLE, /* Light */
+	KEY_LEFT, /* L2 */
+	KEY_UP, /* L3 */
+	KEY_DOWN, /* L4 */
+	KEY_RIGHT, /* L5 */
+	KEY_PROG3, /* M3 */
+	KEY_RECORD, /* MR */
+	KEY_OK /* L1 */
+};
+
+static void
+g15v2_led_send(struct hid_device *hdev, u8 msg, u8 value1, u8 value2)
+{
+	struct g15v2_data *g15data = hid_get_g15data(hdev);
+
+	g15data->led_report->field[0]->value[0] = msg;
+	g15data->led_report->field[0]->value[1] = value1;
+	g15data->led_report->field[0]->value[2] = value2;
+
+	hid_hw_request(hdev, g15data->led_report, HID_REQ_SET_REPORT);
+}
+
+static void g15v2_led_mbtns_send(struct hid_device *hdev)
+{
+	struct g15v2_data *g15data = hid_get_g15data(hdev);
+
+	g15v2_led_send(hdev, 0x04, ~(g15data->led_mbtns), 0);
+}
+
+static void g15v2_led_mbtns_brightness_set(struct led_classdev *led_cdev,
+					   enum led_brightness value)
+{
+	struct hid_device *hdev = gcore_led_classdev_to_hdev(led_cdev);
+	struct gcore_data *gdata = hid_get_gdata(hdev);
+	struct g15v2_data *g15data = gdata->data;
+	u8 mask = 0;
+
+	if (led_cdev == gdata->led_cdev[G15V2_LED_M1])
+		mask = 0x01;
+	else if (led_cdev == gdata->led_cdev[G15V2_LED_M2])
+		mask = 0x02;
+	else if (led_cdev == gdata->led_cdev[G15V2_LED_M3])
+		mask = 0x04;
+	else if (led_cdev == gdata->led_cdev[G15V2_LED_MR])
+		mask = 0x08;
+
+	if (mask && value)
+		g15data->led_mbtns |= mask;
+	else
+		g15data->led_mbtns &= ~mask;
+
+	g15v2_led_mbtns_send(hdev);
+}
+
+static enum led_brightness
+g15v2_led_mbtns_brightness_get(struct led_classdev *led_cdev)
+{
+	struct hid_device *hdev = gcore_led_classdev_to_hdev(led_cdev);
+	struct gcore_data *gdata = hid_get_gdata(hdev);
+	struct g15v2_data *g15data = gdata->data;
+	int value = 0;
+
+	if (led_cdev == gdata->led_cdev[G15V2_LED_M1])
+		value = g15data->led_mbtns & 0x01;
+	else if (led_cdev == gdata->led_cdev[G15V2_LED_M2])
+		value = g15data->led_mbtns & 0x02;
+	else if (led_cdev == gdata->led_cdev[G15V2_LED_M3])
+		value = g15data->led_mbtns & 0x04;
+	else if (led_cdev == gdata->led_cdev[G15V2_LED_MR])
+		value = g15data->led_mbtns & 0x08;
+	else
+		dev_err(&hdev->dev, G15V2_NAME " error retrieving LED brightness\n");
+
+	if (value)
+		return LED_FULL;
+	return LED_OFF;
+}
+
+static void g15v2_led_bl_send(struct hid_device *hdev)
+{
+	struct g15v2_data *g15data = hid_get_g15data(hdev);
+
+	g15v2_led_send(hdev, 0x01, g15data->backlight, 0);
+	g15v2_led_send(hdev, 0x02, g15data->screen_bl, 0);
+	g15v2_led_send(hdev, 0x20, 0x81, g15data->screen_contrast);
+}
+
+static void g15v2_led_bl_set(struct led_classdev *led_cdev,
+			     enum led_brightness value)
+{
+	struct hid_device *hdev = gcore_led_classdev_to_hdev(led_cdev);
+	struct gcore_data *gdata = hid_get_gdata(hdev);
+	struct g15v2_data *g15data = gdata->data;
+
+	if (led_cdev == gdata->led_cdev[G15V2_LED_BL_KEYS]) {
+		if (value > 2)
+			value = 2;
+		g15data->backlight = value;
+		g15v2_led_send(hdev, 0x01, g15data->backlight, 0);
+	} else if (led_cdev == gdata->led_cdev[G15V2_LED_BL_SCREEN]) {
+		if (value > 2)
+			value = 2;
+		g15data->screen_bl = value<<4;
+		g15v2_led_send(hdev, 0x02, g15data->screen_bl, 0);
+	} else if (led_cdev == gdata->led_cdev[G15V2_LED_BL_CONTRAST]) {
+		if (value > 63)
+			value = 63;
+		g15data->screen_contrast = value;
+		g15v2_led_send(hdev, 0x20, 0x81, g15data->screen_contrast);
+	}
+}
+
+static enum led_brightness g15v2_led_bl_get(struct led_classdev *led_cdev)
+{
+	struct hid_device *hdev = gcore_led_classdev_to_hdev(led_cdev);
+	struct gcore_data *gdata = hid_get_gdata(hdev);
+	struct g15v2_data *g15data = gdata->data;
+
+	if (led_cdev == gdata->led_cdev[G15V2_LED_BL_KEYS])
+		return g15data->backlight;
+	else if (led_cdev == gdata->led_cdev[G15V2_LED_BL_SCREEN])
+		return g15data->screen_bl;
+	else if (led_cdev == gdata->led_cdev[G15V2_LED_BL_CONTRAST])
+		return g15data->screen_contrast;
+
+	dev_err(&hdev->dev, G15V2_NAME " error retrieving LED brightness\n");
+	return LED_OFF;
+}
+
+static const struct led_classdev g15v2_led_cdevs[7] = {
+	{
+		.name			= "g15_%d:red:m1",
+		.brightness_set		= g15v2_led_mbtns_brightness_set,
+		.brightness_get		= g15v2_led_mbtns_brightness_get,
+	},
+	{
+		.name			= "g15_%d:red:m2",
+		.brightness_set		= g15v2_led_mbtns_brightness_set,
+		.brightness_get		= g15v2_led_mbtns_brightness_get,
+	},
+	{
+		.name			= "g15v2_%d:red:m3",
+		.brightness_set		= g15v2_led_mbtns_brightness_set,
+		.brightness_get		= g15v2_led_mbtns_brightness_get,
+	},
+	{
+		.name			= "g15v2_%d:blue:mr",
+		.brightness_set		= g15v2_led_mbtns_brightness_set,
+		.brightness_get		= g15v2_led_mbtns_brightness_get,
+	},
+	{
+		.name			= "g15v2_%d:orange:keys",
+		.brightness_set		= g15v2_led_bl_set,
+		.brightness_get		= g15v2_led_bl_get,
+	},
+	{
+		.name			= "g15v2_%d:white:screen",
+		.brightness_set		= g15v2_led_bl_set,
+		.brightness_get		= g15v2_led_bl_get,
+	},
+	{
+		.name			= "g15v2_%d:contrast:screen",
+		.brightness_set		= g15v2_led_bl_set,
+		.brightness_get		= g15v2_led_bl_get,
+	},
+};
+
+
+static DEVICE_ATTR(fb_node, 0444, gfb_fb_node_show, NULL);
+static DEVICE_ATTR(fb_update_rate, 0664,
+		   gfb_fb_update_rate_show, gfb_fb_update_rate_store);
+static DEVICE_ATTR(name, 0664, gcore_name_show, gcore_name_store);
+static DEVICE_ATTR(minor, 0444, gcore_minor_show, NULL);
+
+static struct attribute *g15v2_attrs[] = {
+	&dev_attr_name.attr,
+	&dev_attr_minor.attr,
+	&dev_attr_fb_update_rate.attr,
+	&dev_attr_fb_node.attr,
+	NULL,	/* need to NULL terminate the list of attributes */
+};
+
+static struct attribute_group g15v2_attr_group = {
+	.attrs = g15v2_attrs,
+};
+
+static void g15v2_raw_event_process_input(struct hid_device *hdev,
+					struct gcore_data *gdata,
+					u8 *raw_data)
+{
+	struct input_dev *idev = gdata->input_dev;
+	int scancode;
+	int value;
+	int i;
+	int mask;
+
+	for (i = 0, mask = 0x01; i < 8; i++, mask <<= 1) {
+		scancode = i;
+		value = raw_data[1] & mask;
+		gcore_input_report_key(gdata, scancode, value);
+
+		scancode = i + 8;
+		value = raw_data[2] & mask;
+		gcore_input_report_key(gdata, scancode, value);
+	}
+
+	input_sync(idev);
+}
+
+static int g15v2_raw_event(struct hid_device *hdev,
+			 struct hid_report *report,
+			 u8 *raw_data, int size)
+{
+	/*
+	* On initialization receive a 258 byte message with
+	* data = 6 0 255 255 255 255 255 255 255 255 ...
+	*/
+	unsigned long irq_flags;
+	struct gcore_data *gdata = dev_get_gdata(&hdev->dev);
+	struct g15v2_data *g15data = gdata->data;
+
+	spin_lock_irqsave(&gdata->lock, irq_flags);
+
+	if (unlikely(g15data->ready_stages != G15V2_READY_STAGE_3)) {
+		switch (report->id) {
+		case 6:
+			if (!(g15data->ready_stages & G15V2_READY_SUBSTAGE_1))
+				g15data->ready_stages |= G15V2_READY_SUBSTAGE_1;
+			else if (g15data->ready_stages & G15V2_READY_SUBSTAGE_4 &&
+				 !(g15data->ready_stages & G15V2_READY_SUBSTAGE_5)
+				)
+				g15data->ready_stages |= G15V2_READY_SUBSTAGE_5;
+			else if (g15data->ready_stages & G15V2_READY_SUBSTAGE_6 &&
+				 raw_data[1] >= 0x80)
+				g15data->ready_stages |= G15V2_READY_SUBSTAGE_7;
+			break;
+		case 1:
+			if (!(g15data->ready_stages & G15V2_READY_SUBSTAGE_2))
+				g15data->ready_stages |= G15V2_READY_SUBSTAGE_2;
+			else
+				g15data->ready_stages |= G15V2_READY_SUBSTAGE_3;
+			break;
+		}
+
+		if (g15data->ready_stages == G15V2_READY_STAGE_1 ||
+		    g15data->ready_stages == G15V2_READY_STAGE_2 ||
+		    g15data->ready_stages == G15V2_READY_STAGE_3)
+			complete_all(&g15data->ready);
+
+		spin_unlock_irqrestore(&gdata->lock, irq_flags);
+		return 1;
+	}
+
+	spin_unlock_irqrestore(&gdata->lock, irq_flags);
+
+	if (likely(report->id == 2)) {
+		g15v2_raw_event_process_input(hdev, gdata, raw_data);
+		return 1;
+	}
+
+	return 0;
+}
+
+
+#ifdef CONFIG_PM
+
+static int g15v2_resume(struct hid_device *hdev)
+{
+	unsigned long irq_flags;
+	struct gcore_data *gdata = hid_get_gdata(hdev);
+
+	spin_lock_irqsave(&gdata->lock, irq_flags);
+	g15v2_led_mbtns_send(hdev);
+	g15v2_led_bl_send(hdev);
+	spin_unlock_irqrestore(&gdata->lock, irq_flags);
+
+	return 0;
+}
+
+static int g15v2_reset_resume(struct hid_device *hdev)
+{
+	return g15v2_resume(hdev);
+}
+
+#endif /* CONFIG_PM */
+
+/***** probe-related functions *****/
+
+static void g15v2_feature_report_4_send(struct hid_device *hdev, int which)
+{
+	struct g15v2_data *gdata = hid_get_g15data(hdev);
+
+	if (which == G15V2_REPORT_4_INIT) {
+		gdata->feature_report_4->field[0]->value[0] = 0x02;
+		gdata->feature_report_4->field[0]->value[1] = 0x00;
+		gdata->feature_report_4->field[0]->value[2] = 0x00;
+		gdata->feature_report_4->field[0]->value[3] = 0x00;
+	} else if (which == G15V2_REPORT_4_FINALIZE) {
+		gdata->feature_report_4->field[0]->value[0] = 0x02;
+		gdata->feature_report_4->field[0]->value[1] = 0x80;
+		gdata->feature_report_4->field[0]->value[2] = 0x00;
+		gdata->feature_report_4->field[0]->value[3] = 0xFF;
+	} else {
+		return;
+	}
+
+	hid_hw_request(hdev, gdata->feature_report_4, HID_REQ_SET_REPORT);
+}
+
+static int read_feature_reports(struct gcore_data *gdata)
+{
+	struct hid_device *hdev = gdata->hdev;
+	struct g15v2_data *g15data = gdata->data;
+
+	struct list_head *feature_report_list =
+			    &hdev->report_enum[HID_FEATURE_REPORT].report_list;
+	struct list_head *output_report_list =
+			    &hdev->report_enum[HID_OUTPUT_REPORT].report_list;
+	struct hid_report *report;
+
+	if (list_empty(feature_report_list)) {
+		dev_err(&hdev->dev, "no feature report found\n");
+		return -ENODEV;
+	}
+	dbg_hid(G15V2_NAME " feature report found\n");
+
+	list_for_each_entry(report, feature_report_list, list) {
+		switch (report->id) {
+		case 0x02: /* G15 has only one feature report 0x02 */
+			g15data->feature_report_4
+				= g15data->led_report
+				= g15data->start_input_report
+				= g15data->backlight_report
+				= report;
+			break;
+		default:
+			break;
+		}
+		dbg_hid("%s Feature report: id=%u type=%u size=%u maxfield=%u report_count=%u\n",
+			gdata->name,
+			report->id, report->type, report->size,
+			report->maxfield, report->field[0]->report_count);
+	}
+
+	if (list_empty(output_report_list)) {
+		dev_err(&hdev->dev, "no output report found\n");
+		return -ENODEV;
+	}
+	dbg_hid(G15V2_NAME " output report found\n");
+
+	list_for_each_entry(report, output_report_list, list) {
+		dbg_hid("%s output report %d found size=%u maxfield=%u\n",
+			gdata->name,
+			report->id, report->size, report->maxfield);
+		if (report->maxfield > 0) {
+			dbg_hid("%s offset=%u size=%u count=%u type=%u\n",
+				gdata->name,
+				report->field[0]->report_offset,
+				report->field[0]->report_size,
+				report->field[0]->report_count,
+				report->field[0]->report_type);
+		}
+		switch (report->id) {
+		case 0x03:
+			g15data->output_report_3 = report;
+			break;
+		}
+	}
+
+	dbg_hid("Found all reports\n");
+
+	return 0;
+}
+
+static void wait_ready(struct gcore_data *gdata)
+{
+	struct g15v2_data *g15data = gdata->data;
+	struct hid_device *hdev = gdata->hdev;
+	unsigned long irq_flags;
+
+	dbg_hid("Waiting for G15v2 to activate\n");
+
+	/*
+	 * Wait here for stage 1 (substages 1-3) to complete
+	 */
+	wait_for_completion_timeout(&g15data->ready, HZ);
+
+	/* Protect data->ready_stages */
+	spin_lock_irqsave(&gdata->lock, irq_flags);
+	if (g15data->ready_stages != G15V2_READY_STAGE_1) {
+		dev_warn(&hdev->dev,
+			 "%s hasn't completed stage 1 yet, forging ahead with initialization\n",
+			 gdata->name);
+		/* Force the stage */
+		g15data->ready_stages = G15V2_READY_STAGE_1;
+	}
+	init_completion(&g15data->ready);
+	g15data->ready_stages |= G15V2_READY_SUBSTAGE_4;
+	spin_unlock_irqrestore(&gdata->lock, irq_flags);
+
+	/*
+	 * Send the init report, then follow with the input report to trigger
+	 * report 6 and wait for us to get a response.
+	 */
+	g15v2_feature_report_4_send(hdev, G15V2_REPORT_4_INIT);
+	hid_hw_request(hdev, g15data->start_input_report, HID_REQ_GET_REPORT);
+	wait_for_completion_timeout(&g15data->ready, HZ);
+
+	/* Protect data->ready_stages */
+	spin_lock_irqsave(&gdata->lock, irq_flags);
+	if (g15data->ready_stages != G15V2_READY_STAGE_2) {
+		dev_warn(&hdev->dev,
+			 "%s hasn't completed stage 2 yet, forging ahead with initialization\n",
+			gdata->name);
+		/* Force the stage */
+		g15data->ready_stages = G15V2_READY_STAGE_2;
+	}
+	init_completion(&g15data->ready);
+	g15data->ready_stages |= G15V2_READY_SUBSTAGE_6;
+	spin_unlock_irqrestore(&gdata->lock, irq_flags);
+}
+
+static void send_finalize_report(struct gcore_data *gdata)
+{
+	struct g15v2_data *g15data = gdata->data;
+	struct hid_device *hdev = gdata->hdev;
+	unsigned long irq_flags;
+
+	/*
+	 * Send the finalize report, then follow with the input report to
+	 * trigger report 6 and wait for us to get a response.
+	 */
+	g15v2_feature_report_4_send(hdev, G15V2_REPORT_4_FINALIZE);
+	hid_hw_request(hdev, g15data->start_input_report, HID_REQ_GET_REPORT);
+	hid_hw_request(hdev, g15data->start_input_report, HID_REQ_GET_REPORT);
+	wait_for_completion_timeout(&g15data->ready, HZ);
+
+	/* Protect data->ready_stages */
+	spin_lock_irqsave(&gdata->lock, irq_flags);
+
+	if (g15data->ready_stages != G15V2_READY_STAGE_3) {
+		dev_warn(&hdev->dev, G15V2_NAME " hasn't completed stage 3 yet, forging ahead with initialization\n");
+		/* Force the stage */
+		g15data->ready_stages = G15V2_READY_STAGE_3;
+	} else {
+		dbg_hid(G15V2_NAME " stage 3 complete\n");
+	}
+
+	spin_unlock_irqrestore(&gdata->lock, irq_flags);
+}
+
+static int g15v2_probe(struct hid_device *hdev,
+		     const struct hid_device_id *id)
+{
+	int error;
+	struct gcore_data *gdata;
+	struct g15v2_data *g15data;
+
+	dev_dbg(&hdev->dev, "Logitech G15v2 HID hardware probe...");
+
+	gdata = gcore_alloc_data(G15V2_NAME, hdev);
+	if (gdata == NULL) {
+		dev_err(&hdev->dev, G15V2_NAME " can't allocate space for device attributes\n");
+		error = -ENOMEM;
+		goto err_no_cleanup;
+	}
+
+	g15data = kzalloc(sizeof(struct g15v2_data), GFP_KERNEL);
+	if (g15data == NULL) {
+		error = -ENOMEM;
+		goto err_cleanup_gdata;
+	}
+	gdata->data = g15data;
+	init_completion(&g15data->ready);
+
+	error = gcore_hid_open(gdata);
+	if (error) {
+		dev_err(&hdev->dev,
+			"%s error opening hid device\n",
+			gdata->name);
+		goto err_cleanup_g15data;
+	}
+
+	error = gcore_input_probe(gdata, g15v2_default_keymap,
+				  ARRAY_SIZE(g15v2_default_keymap));
+	if (error) {
+		dev_err(&hdev->dev,
+			"%s error registering input device\n",
+			gdata->name);
+		goto err_cleanup_hid;
+	}
+
+	error = read_feature_reports(gdata);
+	if (error) {
+		dev_err(&hdev->dev,
+			"%s error reading feature reports\n",
+			gdata->name);
+		goto err_cleanup_input;
+	}
+
+	error = gcore_leds_probe(gdata, g15v2_led_cdevs,
+				 ARRAY_SIZE(g15v2_led_cdevs));
+	if (error) {
+		dev_err(&hdev->dev, "%s error registering leds\n", gdata->name);
+		goto err_cleanup_input;
+	}
+
+	gdata->gfb_data = gfb_probe(hdev, GFB_PANEL_TYPE_160_43_1);
+	if (gdata->gfb_data == NULL) {
+		dev_err(&hdev->dev, G15V2_NAME " error registering framebuffer\n");
+		goto err_cleanup_leds;
+	}
+
+	error = sysfs_create_group(&(hdev->dev.kobj), &g15v2_attr_group);
+	if (error) {
+		dev_err(&hdev->dev, G15V2_NAME " failed to create sysfs group attributes\n");
+		goto err_cleanup_gfb;
+	}
+
+	wait_ready(gdata);
+
+	/*
+	 * Clear the LEDs
+	 */
+	g15v2_led_mbtns_send(hdev);
+	g15v2_led_bl_send(hdev);
+
+	send_finalize_report(gdata);
+
+	dbg_hid("G15v2 activated and initialized\n");
+
+	/* Everything went well */
+	return 0;
+
+err_cleanup_gfb:
+	gfb_remove(gdata->gfb_data);
+
+err_cleanup_leds:
+	gcore_leds_remove(gdata);
+
+err_cleanup_input:
+	gcore_input_remove(gdata);
+
+err_cleanup_hid:
+	gcore_hid_close(gdata);
+
+err_cleanup_g15data:
+	kfree(g15data);
+
+err_cleanup_gdata:
+	gcore_free_data(gdata);
+
+err_no_cleanup:
+	hid_set_drvdata(hdev, NULL);
+	return error;
+}
+
+static void g15v2_remove(struct hid_device *hdev)
+{
+	struct gcore_data *gdata = hid_get_drvdata(hdev);
+	struct g15v2_data *g15data = gdata->data;
+
+	sysfs_remove_group(&(hdev->dev.kobj), &g15v2_attr_group);
+
+	gfb_remove(gdata->gfb_data);
+
+	gcore_leds_remove(gdata);
+	gcore_input_remove(gdata);
+	gcore_hid_close(gdata);
+
+	kfree(g15data);
+	gcore_free_data(gdata);
+}
+
+static const struct hid_device_id g15v2_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G15V2_LCD) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, g15v2_devices);
+
+static struct hid_driver g15v2_driver = {
+	.name			= "hid-g15v2",
+	.id_table		= g15v2_devices,
+	.probe			= g15v2_probe,
+	.remove			= g15v2_remove,
+	.raw_event		= g15v2_raw_event,
+
+#ifdef CONFIG_PM
+	.resume			= g15v2_resume,
+	.reset_resume		= g15v2_reset_resume,
+#endif
+
+};
+
+static int __init g15v2_init(void)
+{
+	return hid_register_driver(&g15v2_driver);
+}
+
+static void __exit g15v2_exit(void)
+{
+	hid_unregister_driver(&g15v2_driver);
+}
+
+module_init(g15v2_init);
+module_exit(g15v2_exit);
+MODULE_DESCRIPTION("Logitech G15v2 HID Driver");
+MODULE_AUTHOR("Alistair Buxton (a.j.buxton@gmail.com)");
+MODULE_AUTHOR("Ciubotariu Ciprian (cheepeero@gmx.net)");
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-g19.c b/drivers/hid/hid-g19.c
new file mode 100644
index 0000000..366d2d5
--- /dev/null
+++ b/drivers/hid/hid-g19.c
@@ -0,0 +1,882 @@
+/***************************************************************************
+ *   Copyright (C) 2010 by Alistair Buxton				   *
+ *   a.j.buxton@gmail.com						   *
+ *   based on hid-g13.c							   *
+ *									   *
+ *   This program is free software: you can redistribute it and/or modify  *
+ *   it under the terms of the GNU General Public License as published by  *
+ *   the Free Software Foundation, either version 2 of the License, or	   *
+ *   (at your option) any later version.				   *
+ *									   *
+ *   This driver is distributed in the hope that it will be useful, but	   *
+ *   WITHOUT ANY WARRANTY; without even the implied warranty of		   *
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU	   *
+ *   General Public License for more details.				   *
+ *									   *
+ *   You should have received a copy of the GNU General Public License	   *
+ *   along with this software. If not see <http://www.gnu.org/licenses/>.  *
+ ***************************************************************************/
+#include <linux/fb.h>
+#include <linux/hid.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/sysfs.h>
+#include <linux/uaccess.h>
+#include <linux/usb.h>
+#include <linux/vmalloc.h>
+#include <linux/leds.h>
+#include <linux/completion.h>
+#include <linux/version.h>
+
+#include "hid-ids.h"
+#include "hid-gcore.h"
+#include "hid-gfb.h"
+
+#define G19_NAME "Logitech G19"
+
+/* Key defines */
+#define G19_KEYS 32
+
+/* Backlight defaults */
+#define G19_DEFAULT_RED (0)
+#define G19_DEFAULT_GREEN (255)
+#define G19_DEFAULT_BLUE (0)
+#define G19_DEFAULT_BRIGHTNESS (80)
+
+/* LED array indices */
+#define G19_LED_M1 0
+#define G19_LED_M2 1
+#define G19_LED_M3 2
+#define G19_LED_MR 3
+#define G19_LED_BL_R 4
+#define G19_LED_BL_G 5
+#define G19_LED_BL_B 6
+#define G19_LED_BL_SCREEN 7
+
+/* Housekeeping stuff */
+#define G19_REPORT_4_INIT	0x00
+#define G19_REPORT_4_FINALIZE	0x01
+
+#define G19_READY_SUBSTAGE_1 0x01
+#define G19_READY_SUBSTAGE_2 0x02
+#define G19_READY_SUBSTAGE_3 0x04
+#define G19_READY_STAGE_1    0x07
+#define G19_READY_SUBSTAGE_4 0x08
+#define G19_READY_SUBSTAGE_5 0x10
+#define G19_READY_STAGE_2    0x1F
+#define G19_READY_SUBSTAGE_6 0x20
+#define G19_READY_SUBSTAGE_7 0x40
+#define G19_READY_STAGE_3    0x7F
+
+#define G19_RESET_POST 0x01
+#define G19_RESET_MESSAGE_1 0x02
+#define G19_RESET_READY 0x03
+
+
+/* G19-specific device data structure */
+struct g19_data {
+	/* HID reports */
+	struct hid_report *backlight_report;
+	struct hid_report *start_input_report;
+	struct hid_report *feature_report_4;
+	struct hid_report *led_report;
+	struct hid_report *output_report_3;
+
+	/* led state */
+	u8 backlight_rgb[3];	/* keyboard illumination */
+	u8 led_mbtns;		/* m1, m2, m3 and mr */
+	u8 screen_bl;		/* lcd backlight */
+
+	/* non-standard buttons */
+	u8 ep1keys[2];
+	struct urb *ep1_urb;
+	spinlock_t ep1_urb_lock;
+
+	/* initialization stages */
+	struct completion ready;
+	int ready_stages;
+};
+
+/* Convenience macros */
+#define hid_get_g19data(hdev) \
+	((struct g19_data *)(hid_get_gdata(hdev)->data))
+#define dev_get_g19data(dev) \
+	((struct g19_data *)(dev_get_gdata(dev)->data))
+
+
+/*
+ * Keymap array indices (used as scancodes)
+ *
+ * Key	      Index
+ * ---------  ------
+ * G1-G12     0-11
+ * M1	      12
+ * M2	      13
+ * M3	      14
+ * MR	      15
+ * LIGHT      19
+ * GEAR	      24
+ * BACK	      25
+ * MENU	      26
+ * OK	      27
+ * RIGHT      28
+ * LEFT	      29
+ * DOWN	      30
+ * UP	      31
+ */
+static const unsigned int g19_default_keymap[G19_KEYS] = {
+	/* G1 - G12 */
+	KEY_F1, KEY_F2, KEY_F3, KEY_F4,
+	KEY_F5, KEY_F6, KEY_F7, KEY_F8,
+	KEY_F9, KEY_F10, KEY_F11, KEY_F12,
+
+	/* M1, M2, M3, MR */
+	KEY_PROG1, KEY_PROG2, KEY_PROG3, KEY_RECORD,
+
+	/* backlight toggle */
+	KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_KBDILLUMTOGGLE,
+	KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
+
+	/* menu keys */
+	KEY_FORWARD, KEY_BACK, KEY_MENU, KEY_OK,
+	KEY_RIGHT, KEY_LEFT, KEY_DOWN, KEY_UP,
+};
+
+static void g19_led_mbtns_send(struct hid_device *hdev)
+{
+	struct g19_data *g19data = hid_get_g19data(hdev);
+
+	g19data->led_report->field[0]->value[0] = g19data->led_mbtns & 0xFF;
+
+	hid_hw_request(hdev, g19data->led_report, HID_REQ_SET_REPORT);
+}
+
+static void g19_led_mbtns_brightness_set(struct led_classdev *led_cdev,
+					 enum led_brightness value)
+{
+	struct hid_device *hdev = gcore_led_classdev_to_hdev(led_cdev);
+	struct gcore_data *gdata = hid_get_gdata(hdev);
+	struct g19_data *g19data = gdata->data;
+	u8 mask = 0;
+
+	if (led_cdev == gdata->led_cdev[G19_LED_M1])
+		mask = 0x80;
+	else if (led_cdev == gdata->led_cdev[G19_LED_M2])
+		mask = 0x40;
+	else if (led_cdev == gdata->led_cdev[G19_LED_M3])
+		mask = 0x20;
+	else if (led_cdev == gdata->led_cdev[G19_LED_MR])
+		mask = 0x10;
+
+	if (mask && value)
+		g19data->led_mbtns |= mask;
+	else
+		g19data->led_mbtns &= ~mask;
+
+	g19_led_mbtns_send(hdev);
+}
+
+static enum led_brightness
+g19_led_mbtns_brightness_get(struct led_classdev *led_cdev)
+{
+	struct hid_device *hdev = gcore_led_classdev_to_hdev(led_cdev);
+	struct gcore_data *gdata = hid_get_gdata(hdev);
+	struct g19_data *g19data = gdata->data;
+	int value = 0;
+
+	if (led_cdev == gdata->led_cdev[G19_LED_M1])
+		value = g19data->led_mbtns & 0x80;
+	else if (led_cdev == gdata->led_cdev[G19_LED_M2])
+		value = g19data->led_mbtns & 0x40;
+	else if (led_cdev == gdata->led_cdev[G19_LED_M3])
+		value = g19data->led_mbtns & 0x20;
+	else if (led_cdev == gdata->led_cdev[G19_LED_MR])
+		value = g19data->led_mbtns & 0x10;
+	else
+		dev_err(&hdev->dev,
+			G19_NAME " error retrieving LED brightness\n");
+
+	if (value)
+		return LED_FULL;
+	return LED_OFF;
+}
+
+static void g19_led_bl_send(struct hid_device *hdev)
+{
+	struct g19_data *g19data = hid_get_g19data(hdev);
+
+	struct hid_field *field0 = g19data->backlight_report->field[0];
+
+	field0->value[0] = g19data->backlight_rgb[0];
+	field0->value[1] = g19data->backlight_rgb[1];
+	field0->value[2] = g19data->backlight_rgb[2];
+
+	hid_hw_request(hdev, g19data->backlight_report, HID_REQ_SET_REPORT);
+}
+
+static void g19_led_bl_brightness_set(struct led_classdev *led_cdev,
+				      enum led_brightness value)
+{
+	struct hid_device *hdev = gcore_led_classdev_to_hdev(led_cdev);
+	struct gcore_data *gdata = hid_get_gdata(hdev);
+	struct g19_data *g19data = gdata->data;
+
+	if (led_cdev == gdata->led_cdev[G19_LED_BL_R])
+		g19data->backlight_rgb[0] = value;
+	else if (led_cdev == gdata->led_cdev[G19_LED_BL_G])
+		g19data->backlight_rgb[1] = value;
+	else if (led_cdev == gdata->led_cdev[G19_LED_BL_B])
+		g19data->backlight_rgb[2] = value;
+
+	g19_led_bl_send(hdev);
+}
+
+static enum led_brightness
+g19_led_bl_brightness_get(struct led_classdev *led_cdev)
+{
+	struct hid_device *hdev = gcore_led_classdev_to_hdev(led_cdev);
+	struct gcore_data *gdata = hid_get_gdata(hdev);
+	struct g19_data *g19data = gdata->data;
+
+	if (led_cdev == gdata->led_cdev[G19_LED_BL_R])
+		return g19data->backlight_rgb[0];
+	else if (led_cdev == gdata->led_cdev[G19_LED_BL_G])
+		return g19data->backlight_rgb[1];
+	else if (led_cdev == gdata->led_cdev[G19_LED_BL_B])
+		return g19data->backlight_rgb[2];
+
+	dev_err(&hdev->dev, G19_NAME " error retrieving LED brightness\n");
+	return LED_OFF;
+}
+
+static void g19_led_screen_bl_send(struct hid_device *hdev)
+{
+	struct usb_interface *intf;
+	struct usb_device *usb_dev;
+	struct g19_data *g19data = hid_get_g19data(hdev);
+	unsigned int pipe;
+	int i = 0;
+
+	unsigned char cp[9];
+
+	cp[0] = g19data->screen_bl;
+	cp[1] = 0xe2;
+	cp[2] = 0x12;
+	cp[3] = 0x00;
+	cp[4] = 0x8c;
+	cp[5] = 0x11;
+	cp[6] = 0x00;
+	cp[7] = 0x10;
+	cp[8] = 0x00;
+
+	intf = to_usb_interface(hdev->dev.parent);
+	usb_dev = interface_to_usbdev(intf);
+	pipe = usb_sndctrlpipe(usb_dev, 0x00);
+	i = usb_control_msg(usb_dev, pipe, 0x0a,
+			    USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
+			    0, 0, cp, sizeof(cp),
+			    1 * HZ);
+	if (i < 0) {
+		dev_warn(&hdev->dev,
+			 G19_NAME " error setting LCD backlight level %d\n",
+			 i);
+	}
+}
+
+static void g19_led_screen_bl_set(struct led_classdev *led_cdev,
+				  enum led_brightness value)
+{
+	struct hid_device *hdev = gcore_led_classdev_to_hdev(led_cdev);
+	struct gcore_data *gdata = hid_get_gdata(hdev);
+	struct g19_data *g19data = gdata->data;
+
+	if (led_cdev == gdata->led_cdev[G19_LED_BL_SCREEN]) {
+		if (value > 100)
+			value = 100;
+		g19data->screen_bl = value;
+		g19_led_screen_bl_send(hdev);
+	}
+}
+
+static enum led_brightness g19_led_screen_bl_get(struct led_classdev *led_cdev)
+{
+	struct hid_device *hdev = gcore_led_classdev_to_hdev(led_cdev);
+	struct gcore_data *gdata = hid_get_gdata(hdev);
+	struct g19_data *g19data = gdata->data;
+
+	if (led_cdev == gdata->led_cdev[G19_LED_BL_SCREEN])
+		return g19data->screen_bl;
+
+	dev_err(&hdev->dev, G19_NAME " error retrieving LED brightness\n");
+	return LED_OFF;
+}
+
+
+/* use the name field to convery a format string, */
+/* that will be used by gcore_leds_probe */
+static const struct led_classdev g19_led_cdevs[] = {
+	{
+		.name			= "g19_%d:orange:m1",
+		.brightness_set		= g19_led_mbtns_brightness_set,
+		.brightness_get		= g19_led_mbtns_brightness_get,
+	},
+	{
+		.name			= "g19_%d:orange:m2",
+		.brightness_set		= g19_led_mbtns_brightness_set,
+		.brightness_get		= g19_led_mbtns_brightness_get,
+	},
+	{
+		.name			= "g19_%d:orange:m3",
+		.brightness_set		= g19_led_mbtns_brightness_set,
+		.brightness_get		= g19_led_mbtns_brightness_get,
+	},
+	{
+		.name			= "g19_%d:red:mr",
+		.brightness_set		= g19_led_mbtns_brightness_set,
+		.brightness_get		= g19_led_mbtns_brightness_get,
+	},
+	{
+		.name			= "g19_%d:red:bl",
+		.brightness_set		= g19_led_bl_brightness_set,
+		.brightness_get		= g19_led_bl_brightness_get,
+	},
+	{
+		.name			= "g19_%d:green:bl",
+		.brightness_set		= g19_led_bl_brightness_set,
+		.brightness_get		= g19_led_bl_brightness_get,
+	},
+	{
+		.name			= "g19_%d:blue:bl",
+		.brightness_set		= g19_led_bl_brightness_set,
+		.brightness_get		= g19_led_bl_brightness_get,
+	},
+	{
+		.name			= "g19_%d:white:screen",
+		.brightness_set		= g19_led_screen_bl_set,
+		.brightness_get		= g19_led_screen_bl_get,
+	},
+};
+
+static DEVICE_ATTR(fb_node, 0444, gfb_fb_node_show, NULL);
+static DEVICE_ATTR(fb_update_rate, 0664,
+		   gfb_fb_update_rate_show, gfb_fb_update_rate_store);
+static DEVICE_ATTR(name, 0664, gcore_name_show, gcore_name_store);
+static DEVICE_ATTR(minor, 0444, gcore_minor_show, NULL);
+
+static struct attribute *g19_attrs[] = {
+	&dev_attr_name.attr,
+	&dev_attr_minor.attr,
+	&dev_attr_fb_update_rate.attr,
+	&dev_attr_fb_node.attr,
+	NULL,	 /* need to NULL terminate the list of attributes */
+};
+
+static struct attribute_group g19_attr_group = {
+	.attrs = g19_attrs,
+};
+
+
+static void g19_raw_event_process_input(struct hid_device *hdev,
+					struct gcore_data *gdata,
+					u8 *raw_data)
+{
+	int scancode, value;
+	int i, mask;
+
+	raw_data[3] &= 0xBF; /* bit 6 is always on */
+
+	for (i = 0, mask = 0x01; i < 8; i++, mask <<= 1) {
+		/* Keys G1 through G8 */
+		scancode = i;
+		value = raw_data[1] & mask;
+		gcore_input_report_key(gdata, scancode, value);
+
+		/* Keys G9 through G12, M1 through MR */
+		scancode = i + 8;
+		value = raw_data[2] & mask;
+		gcore_input_report_key(gdata, scancode, value);
+
+		/* Keys G17 through G22 */
+		scancode = i + 16;
+		value = raw_data[3] & mask;
+		gcore_input_report_key(gdata, scancode, value);
+	}
+
+	input_sync(gdata->input_dev);
+}
+
+static int g19_raw_event(struct hid_device *hdev,
+			 struct hid_report *report,
+			 u8 *raw_data, int size)
+{
+	struct gcore_data *gdata = dev_get_gdata(&hdev->dev);
+	struct g19_data *g19data = gdata->data;
+	unsigned long irq_flags;
+
+	/*
+	* On initialization receive a 258 byte message with
+	* data = 6 0 255 255 255 255 255 255 255 255 ...
+	*/
+
+
+	spin_lock_irqsave(&gdata->lock, irq_flags);
+
+	if (unlikely(g19data->ready_stages != G19_READY_STAGE_3)) {
+		switch (report->id) {
+		case 6:
+			if (!(g19data->ready_stages & G19_READY_SUBSTAGE_1))
+				g19data->ready_stages |= G19_READY_SUBSTAGE_1;
+			else if (g19data->ready_stages & G19_READY_SUBSTAGE_4 &&
+				 !(g19data->ready_stages & G19_READY_SUBSTAGE_5)
+				)
+				g19data->ready_stages |= G19_READY_SUBSTAGE_5;
+			else if (g19data->ready_stages & G19_READY_SUBSTAGE_6 &&
+				 raw_data[1] >= 0x80)
+				g19data->ready_stages |= G19_READY_SUBSTAGE_7;
+			break;
+		case 1:
+			if (!(g19data->ready_stages & G19_READY_SUBSTAGE_2))
+				g19data->ready_stages |= G19_READY_SUBSTAGE_2;
+			else
+				g19data->ready_stages |= G19_READY_SUBSTAGE_3;
+			break;
+		}
+
+		if (g19data->ready_stages == G19_READY_STAGE_1 ||
+		    g19data->ready_stages == G19_READY_STAGE_2 ||
+		    g19data->ready_stages == G19_READY_STAGE_3)
+			complete_all(&g19data->ready);
+
+		spin_unlock_irqrestore(&gdata->lock, irq_flags);
+		return 1;
+	}
+
+	spin_unlock_irqrestore(&gdata->lock, irq_flags);
+
+	if (likely(report->id == 2)) {
+		g19_raw_event_process_input(hdev, gdata, raw_data);
+		return 1;
+	}
+
+	return 0;
+}
+
+
+#ifdef CONFIG_PM
+
+static int g19_resume(struct hid_device *hdev)
+{
+	unsigned long irq_flags;
+	struct gcore_data *gdata = hid_get_gdata(hdev);
+
+	spin_lock_irqsave(&gdata->lock, irq_flags);
+	g19_led_bl_send(hdev);
+	g19_led_mbtns_send(hdev);
+	g19_led_screen_bl_send(hdev);
+	spin_unlock_irqrestore(&gdata->lock, irq_flags);
+
+	return 0;
+}
+
+static int g19_reset_resume(struct hid_device *hdev)
+{
+	return g19_resume(hdev);
+}
+
+#endif /* CONFIG_PM */
+
+/***** probe-related functions *****/
+
+static void g19_ep1_urb_completion(struct urb *urb)
+{
+	/* don't process unlinked or failed urbs */
+	if (likely(urb->status == 0)) {
+		struct hid_device *hdev = urb->context;
+		struct gcore_data *gdata = hid_get_gdata(hdev);
+		struct g19_data *g19data = gdata->data;
+		int i;
+
+		for (i = 0; i < 8; i++)
+			gcore_input_report_key(gdata, 24+i,
+					       g19data->ep1keys[0]&(1<<i));
+
+		input_sync(gdata->input_dev);
+
+		usb_submit_urb(urb, GFP_ATOMIC);
+	}
+}
+
+static void g19_feature_report_4_send(struct hid_device *hdev, int which)
+{
+	struct g19_data *g19data = hid_get_g19data(hdev);
+
+	if (which == G19_REPORT_4_INIT) {
+		g19data->feature_report_4->field[0]->value[0] = 0x02;
+		g19data->feature_report_4->field[0]->value[1] = 0x00;
+		g19data->feature_report_4->field[0]->value[2] = 0x00;
+		g19data->feature_report_4->field[0]->value[3] = 0x00;
+	} else if (which == G19_REPORT_4_FINALIZE) {
+		g19data->feature_report_4->field[0]->value[0] = 0x02;
+		g19data->feature_report_4->field[0]->value[1] = 0x80;
+		g19data->feature_report_4->field[0]->value[2] = 0x00;
+		g19data->feature_report_4->field[0]->value[3] = 0xFF;
+	} else {
+		return;
+	}
+
+	hid_hw_request(hdev, g19data->feature_report_4, HID_REQ_SET_REPORT);
+}
+
+static int read_feature_reports(struct gcore_data *gdata)
+{
+	struct hid_device *hdev = gdata->hdev;
+	struct g19_data *g19data = gdata->data;
+
+	struct list_head *feature_report_list =
+			    &hdev->report_enum[HID_FEATURE_REPORT].report_list;
+	struct hid_report *report;
+
+	if (list_empty(feature_report_list)) {
+		dev_err(&hdev->dev,
+			"%s no feature report found\n",
+			gdata->name);
+		return -ENODEV;
+	}
+	dbg_hid("%s feature report found\n", gdata->name);
+
+	list_for_each_entry(report, feature_report_list, list) {
+		switch (report->id) {
+		case 0x04:
+			g19data->feature_report_4 = report;
+			break;
+		case 0x05:
+			g19data->led_report = report;
+			break;
+		case 0x06:
+			g19data->start_input_report = report;
+			break;
+		case 0x07:
+			g19data->backlight_report = report;
+			break;
+		default:
+			break;
+		}
+		dbg_hid("%s Feature report: id=%u type=%u size=%u maxfield=%u report_count=%u\n",
+			gdata->name,
+			report->id, report->type, report->size,
+			report->maxfield, report->field[0]->report_count);
+	}
+
+	dbg_hid("%s found all reports\n", gdata->name);
+
+	return 0;
+}
+
+static void wait_ready(struct gcore_data *gdata)
+{
+	struct g19_data *g19data = gdata->data;
+	struct hid_device *hdev = gdata->hdev;
+	unsigned long irq_flags;
+
+	dbg_hid("Waiting for G19 to activate\n");
+
+	/* Wait here for stage 1 (substages 1-3) to complete */
+	wait_for_completion_timeout(&g19data->ready, HZ);
+
+	/* Protect data->ready_stages */
+	spin_lock_irqsave(&gdata->lock, irq_flags);
+	if (g19data->ready_stages != G19_READY_STAGE_1) {
+		dev_warn(&hdev->dev,
+			 "%s hasn't completed stage 1 yet, forging ahead with initialization\n",
+			 gdata->name);
+		/* Force the stage */
+		g19data->ready_stages = G19_READY_STAGE_1;
+	}
+	init_completion(&g19data->ready);
+	g19data->ready_stages |= G19_READY_SUBSTAGE_4;
+	spin_unlock_irqrestore(&gdata->lock, irq_flags);
+
+	/*
+	 * Send the init report, then follow with the input report to trigger
+	 * report 6 and wait for us to get a response.
+	 */
+	g19_feature_report_4_send(hdev, G19_REPORT_4_INIT);
+	hid_hw_request(hdev, g19data->start_input_report, HID_REQ_GET_REPORT);
+	wait_for_completion_timeout(&g19data->ready, HZ);
+
+	/* Protect g19data->ready_stages */
+	spin_lock_irqsave(&gdata->lock, irq_flags);
+	if (g19data->ready_stages != G19_READY_STAGE_2) {
+		dev_warn(&hdev->dev,
+			 "%s hasn't completed stage 2 yet, forging ahead with initialization\n",
+			 gdata->name);
+		/* Force the stage */
+		g19data->ready_stages = G19_READY_STAGE_2;
+	}
+	init_completion(&g19data->ready);
+	g19data->ready_stages |= G19_READY_SUBSTAGE_6;
+	spin_unlock_irqrestore(&gdata->lock, irq_flags);
+}
+
+static void send_finalize_report(struct gcore_data *gdata)
+{
+	struct g19_data *g19data = gdata->data;
+	struct hid_device *hdev = gdata->hdev;
+	unsigned long irq_flags;
+
+	/*
+	 * Send the finalize report, then follow with the input report to
+	 * trigger report 6 and wait for us to get a response.
+	 */
+	g19_feature_report_4_send(hdev, G19_REPORT_4_FINALIZE);
+	hid_hw_request(hdev, g19data->start_input_report, HID_REQ_GET_REPORT);
+	hid_hw_request(hdev, g19data->start_input_report, HID_REQ_GET_REPORT);
+	wait_for_completion_timeout(&g19data->ready, HZ);
+
+	/* Protect data->ready_stages */
+	spin_lock_irqsave(&gdata->lock, irq_flags);
+
+	if (g19data->ready_stages != G19_READY_STAGE_3) {
+		dev_warn(&hdev->dev,
+			 "%s hasn't completed stage 3 yet, forging ahead with initialization\n",
+			 gdata->name);
+		/* Force the stage */
+		g19data->ready_stages = G19_READY_STAGE_3;
+	} else {
+		dbg_hid("%s stage 3 complete\n", gdata->name);
+	}
+
+	spin_unlock_irqrestore(&gdata->lock, irq_flags);
+}
+
+static int g19_ep1_read(struct hid_device *hdev)
+{
+	struct usb_interface *intf;
+	struct usb_device *usb_dev;
+	struct g19_data *g19data = hid_get_g19data(hdev);
+
+	struct usb_host_endpoint *ep;
+	unsigned int pipe;
+	int retval = 0;
+
+	/* Get the usb device to send the image on */
+	intf = to_usb_interface(hdev->dev.parent);
+	usb_dev = interface_to_usbdev(intf);
+
+	pipe = usb_rcvintpipe(usb_dev, 0x01);
+	ep = (usb_pipein(pipe) ?
+	      usb_dev->ep_in : usb_dev->ep_out)[usb_pipeendpoint(pipe)];
+
+	if (unlikely(!ep))
+		return -EINVAL;
+
+	usb_fill_int_urb(g19data->ep1_urb, usb_dev, pipe, g19data->ep1keys, 2,
+			 g19_ep1_urb_completion, NULL, 10);
+	g19data->ep1_urb->context = hdev;
+	g19data->ep1_urb->actual_length = 0;
+
+	retval = usb_submit_urb(g19data->ep1_urb, GFP_KERNEL);
+
+	return retval;
+}
+
+
+static int g19_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	int error;
+	struct gcore_data *gdata;
+	struct g19_data *g19data;
+
+	dev_dbg(&hdev->dev, "Logitech G19 HID hardware probe...");
+
+	gdata = gcore_alloc_data(G19_NAME, hdev);
+	if (gdata == NULL) {
+		dev_err(&hdev->dev,
+			G19_NAME
+			" can't allocate space for device attributes\n");
+		error = -ENOMEM;
+		goto err_no_cleanup;
+	}
+
+	g19data = kzalloc(sizeof(struct g19_data), GFP_KERNEL);
+	if (g19data == NULL) {
+		error = -ENOMEM;
+		goto err_cleanup_gdata;
+	}
+	gdata->data = g19data;
+	init_completion(&g19data->ready);
+
+	g19data->ep1_urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (g19data->ep1_urb == NULL) {
+		dev_err(&hdev->dev,
+			"%s: ERROR: can't alloc ep1 urb stuff\n",
+			gdata->name);
+		error = -ENOMEM;
+		goto err_cleanup_g19data;
+	}
+
+	error = gcore_hid_open(gdata);
+	if (error) {
+		dev_err(&hdev->dev,
+			"%s error opening hid device\n",
+			gdata->name);
+		goto err_cleanup_ep1_urb;
+	}
+
+	error = gcore_input_probe(gdata, g19_default_keymap,
+				  ARRAY_SIZE(g19_default_keymap));
+	if (error) {
+		dev_err(&hdev->dev,
+			"%s error registering input device\n",
+			gdata->name);
+		goto err_cleanup_hid;
+	}
+
+	error = read_feature_reports(gdata);
+	if (error) {
+		dev_err(&hdev->dev,
+			"%s error reading feature reports\n",
+			gdata->name);
+		goto err_cleanup_input;
+	}
+
+	error = gcore_leds_probe(gdata, g19_led_cdevs,
+				 ARRAY_SIZE(g19_led_cdevs));
+	if (error) {
+		dev_err(&hdev->dev, "%s error registering leds\n", gdata->name);
+		goto err_cleanup_input;
+	}
+
+	gdata->gfb_data = gfb_probe(hdev, GFB_PANEL_TYPE_320_240_16);
+	if (gdata->gfb_data == NULL) {
+		dev_err(&hdev->dev,
+			"%s error registering framebuffer\n",
+			gdata->name);
+		goto err_cleanup_leds;
+	}
+
+	error = sysfs_create_group(&(hdev->dev.kobj), &g19_attr_group);
+	if (error) {
+		dev_err(&hdev->dev,
+			"%s failed to create sysfs group attributes\n",
+			gdata->name);
+		goto err_cleanup_gfb;
+	}
+
+	wait_ready(gdata);
+
+	/*
+	 * Clear the LEDs
+	 */
+	g19data->backlight_rgb[0] = G19_DEFAULT_RED;
+	g19data->backlight_rgb[1] = G19_DEFAULT_GREEN;
+	g19data->backlight_rgb[2] = G19_DEFAULT_BLUE;
+	g19data->screen_bl = G19_DEFAULT_BRIGHTNESS;
+
+	g19_led_bl_send(hdev);
+	g19_led_mbtns_send(hdev);
+	g19_led_screen_bl_send(hdev);
+
+	send_finalize_report(gdata);
+
+	error = g19_ep1_read(hdev);
+	if (error) {
+		dev_err(&hdev->dev, "%s failed to read ep1\n", gdata->name);
+		goto err_cleanup_sysfs;
+	}
+
+	dbg_hid("G19 activated and initialized\n");
+
+	/* Everything went well */
+	return 0;
+
+err_cleanup_sysfs:
+	sysfs_remove_group(&(hdev->dev.kobj), &g19_attr_group);
+
+err_cleanup_gfb:
+	gfb_remove(gdata->gfb_data);
+
+err_cleanup_leds:
+	gcore_leds_remove(gdata);
+
+err_cleanup_input:
+	gcore_input_remove(gdata);
+
+err_cleanup_hid:
+	gcore_hid_close(gdata);
+
+err_cleanup_ep1_urb:
+	usb_free_urb(g19data->ep1_urb);
+
+err_cleanup_g19data:
+	kfree(g19data);
+
+err_cleanup_gdata:
+	gcore_free_data(gdata);
+
+err_no_cleanup:
+	hid_set_drvdata(hdev, NULL);
+	return error;
+}
+
+static void g19_remove(struct hid_device *hdev)
+{
+	struct gcore_data *gdata = hid_get_drvdata(hdev);
+	struct g19_data *g19data = gdata->data;
+
+	usb_poison_urb(g19data->ep1_urb);
+
+	sysfs_remove_group(&(hdev->dev.kobj), &g19_attr_group);
+
+	gfb_remove(gdata->gfb_data);
+
+	gcore_leds_remove(gdata);
+	gcore_input_remove(gdata);
+	gcore_hid_close(gdata);
+
+	usb_free_urb(g19data->ep1_urb);
+
+	kfree(g19data);
+	gcore_free_data(gdata);
+}
+
+
+static const struct hid_device_id g19_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G19_LCD) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, g19_devices);
+
+static struct hid_driver g19_driver = {
+	.name			= "hid-g19",
+	.id_table		= g19_devices,
+	.probe			= g19_probe,
+	.remove			= g19_remove,
+	.raw_event		= g19_raw_event,
+
+#ifdef CONFIG_PM
+	.resume			= g19_resume,
+	.reset_resume		= g19_reset_resume,
+#endif
+
+};
+
+static int __init g19_init(void)
+{
+	return hid_register_driver(&g19_driver);
+}
+
+static void __exit g19_exit(void)
+{
+	hid_unregister_driver(&g19_driver);
+}
+
+module_init(g19_init);
+module_exit(g19_exit);
+MODULE_DESCRIPTION("Logitech G19 HID Driver");
+MODULE_AUTHOR("Alistair Buxton (a.j.buxton@gmail.com)");
+MODULE_AUTHOR("Thomas Berger (tbe@boreus.de)");
+MODULE_AUTHOR("Ciubotariu Ciprian (cheepeero@gmx.net)");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hid/hid-gcore.c b/drivers/hid/hid-gcore.c
new file mode 100644
index 0000000..ee18fc3
--- /dev/null
+++ b/drivers/hid/hid-gcore.c
@@ -0,0 +1,398 @@
+/***************************************************************************
+ *   Copyright (C) 2014 by Ciprian Ciubotariu <cheepeero@gmx.net>	   *
+ *									   *
+ *   This program is free software: you can redistribute it and/or modify  *
+ *   it under the terms of the GNU General Public License as published by  *
+ *   the Free Software Foundation, either version 2 of the License, or	   *
+ *   (at your option) any later version.				   *
+ *									   *
+ *   This driver is distributed in the hope that it will be useful, but	   *
+ *   WITHOUT ANY WARRANTY; without even the implied warranty of		   *
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU	   *
+ *   General Public License for more details.				   *
+ *									   *
+ *   You should have received a copy of the GNU General Public License	   *
+ *   along with this software. If not see <http://www.gnu.org/licenses/>.  *
+ ***************************************************************************/
+#include <linux/hid.h>
+#include <linux/input.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+
+#include "hid-gcore.h"
+
+struct gcore_data *gcore_alloc_data(const char *name, struct hid_device *hdev)
+{
+	struct gcore_data *gdata = kzalloc(sizeof(struct gcore_data),
+					   GFP_KERNEL);
+
+	if (gdata == NULL) {
+		dev_err(&hdev->dev,
+			"%s error allocating memory for device attributes\n",
+			name);
+		return NULL;
+	}
+
+	gdata->name = kzalloc((strlen(name) + 1) * sizeof(char), GFP_KERNEL);
+	if (gdata->name == NULL) {
+		kfree(gdata);
+		return NULL;
+	}
+	strcpy(gdata->name, name);
+
+	spin_lock_init(&gdata->lock);
+
+	gdata->hdev = hdev;
+	hid_set_drvdata(hdev, gdata);
+
+	return gdata;
+}
+EXPORT_SYMBOL_GPL(gcore_alloc_data);
+
+
+void gcore_free_data(struct gcore_data *gdata)
+{
+	kfree(gdata->name);
+	kfree(gdata);
+}
+EXPORT_SYMBOL_GPL(gcore_free_data);
+
+
+int gcore_hid_open(struct gcore_data *gdata)
+{
+	struct hid_device *hdev = gdata->hdev;
+	int error;
+
+	dbg_hid("Preparing to parse %s hid reports\n", gdata->name);
+
+	/* Parse the device reports and start it up */
+	error = hid_parse(hdev);
+	if (error) {
+		dev_err(&hdev->dev, "%s device report parse failed\n",
+			gdata->name);
+		error = -EINVAL;
+		goto err_no_cleanup;
+	}
+
+	error = hid_hw_start(hdev,
+			     HID_CONNECT_DEFAULT | HID_CONNECT_HIDINPUT_FORCE);
+	if (error) {
+		dev_err(&hdev->dev, "%s hardware start failed\n", gdata->name);
+		error = -EINVAL;
+		goto err_cleanup_hid;
+	}
+
+	dbg_hid("%s claimed: %d\n", gdata->name, hdev->claimed);
+
+	error = hdev->ll_driver->open(hdev);
+	if (error) {
+		dev_err(&hdev->dev,
+			"%s failed to open input interrupt pipe for key and joystick events\n",
+			gdata->name);
+		error = -EINVAL;
+		goto err_cleanup_hid;
+	}
+
+	return 0;
+
+err_cleanup_hid:
+	hid_hw_stop(hdev);
+
+err_no_cleanup:
+	return error;
+}
+EXPORT_SYMBOL_GPL(gcore_hid_open);
+
+
+void gcore_hid_close(struct gcore_data *gdata)
+{
+	struct hid_device *hdev = gdata->hdev;
+
+	hdev->ll_driver->close(hdev);
+	hid_hw_stop(hdev);
+}
+EXPORT_SYMBOL_GPL(gcore_hid_close);
+
+
+
+int gcore_input_probe(struct gcore_data *gdata,
+		      const unsigned int default_keymap[],
+		      int keymap_size)
+{
+	struct hid_device *hdev = gdata->hdev;
+	int i, error;
+	unsigned int *keycode;
+
+	/* Set up the input device for the key I/O */
+	gdata->input_dev = input_allocate_device();
+	if (gdata->input_dev == NULL) {
+		dev_err(&hdev->dev,
+			"%s error initializing the input device",
+			gdata->name);
+		error = -ENOMEM;
+		goto err_no_cleanup;
+	}
+
+	input_set_drvdata(gdata->input_dev, gdata);
+
+	gdata->input_dev->name = gdata->name;
+	gdata->input_dev->phys = hdev->phys;
+	gdata->input_dev->uniq = hdev->uniq;
+	gdata->input_dev->id.bustype = hdev->bus;
+	gdata->input_dev->id.vendor = hdev->vendor;
+	gdata->input_dev->id.product = hdev->product;
+	gdata->input_dev->id.version = hdev->version;
+	gdata->input_dev->dev.parent = hdev->dev.parent;
+
+	input_set_capability(gdata->input_dev, EV_KEY, KEY_UNKNOWN);
+	gdata->input_dev->evbit[0] |= BIT_MASK(EV_REP);
+
+	/* Initialize keymap */
+	gdata->input_dev->keycode = kcalloc(keymap_size, sizeof(unsigned int),
+					    GFP_KERNEL);
+	if (gdata->input_dev->keycode == NULL) {
+		error = -ENOMEM;
+		goto err_cleanup_input_dev;
+	}
+
+	keycode = gdata->input_dev->keycode;
+	gdata->input_dev->keycodemax = keymap_size;
+	gdata->input_dev->keycodesize = sizeof(unsigned int);
+	for (i = 0; i < keymap_size; i++) {
+		keycode[i] = default_keymap[i];
+		__set_bit(keycode[i], gdata->input_dev->keybit);
+	}
+
+	__clear_bit(KEY_RESERVED, gdata->input_dev->keybit);
+
+	/* Register input device */
+	error = input_register_device(gdata->input_dev);
+	if (error) {
+		dev_err(&hdev->dev,
+			"%s error registering the input device",
+			gdata->name);
+		error = -EINVAL;
+		goto err_cleanup_input_dev_keycode;
+	}
+
+	return 0;
+
+err_cleanup_input_dev_keycode:
+	kfree(gdata->input_dev->keycode);
+
+err_cleanup_input_dev:
+	input_free_device(gdata->input_dev);
+
+err_no_cleanup:
+	return error;
+}
+EXPORT_SYMBOL_GPL(gcore_input_probe);
+
+
+void gcore_input_report_key(struct gcore_data *gdata, int scancode, int value)
+{
+	struct input_dev *idev = gdata->input_dev;
+	int error;
+
+	struct input_keymap_entry ke = {
+		.flags	  = 0,
+		.len	  = sizeof(scancode),
+	};
+	*((int *) ke.scancode) = scancode;
+
+	error = input_get_keycode(idev, &ke);
+	if (!error && ke.keycode != KEY_UNKNOWN && ke.keycode != KEY_RESERVED) {
+		/* Only report mapped keys */
+		input_report_key(idev, ke.keycode, value);
+	} else if (!!value) {
+		/* Or report MSC_SCAN on keypress of an unmapped key */
+		input_event(idev, EV_MSC, MSC_SCAN, scancode);
+	}
+}
+EXPORT_SYMBOL_GPL(gcore_input_report_key);
+
+
+void gcore_input_remove(struct gcore_data *gdata)
+{
+	input_unregister_device(gdata->input_dev);
+	kfree(gdata->input_dev->keycode);
+}
+EXPORT_SYMBOL_GPL(gcore_input_remove);
+
+
+int gcore_leds_probe(struct gcore_data *gdata,
+		     const struct led_classdev led_templates[],
+		     int led_count)
+{
+	struct hid_device *hdev = gdata->hdev;
+	int error, i, registered_leds;
+	char *led_name;
+
+	gdata->led_count = led_count;
+
+	gdata->led_cdev = kcalloc(led_count,
+				  sizeof(struct led_classdev *),
+				  GFP_KERNEL);
+	if (gdata->led_cdev == NULL) {
+		error = -ENOMEM;
+		goto err_no_cleanup;
+	}
+
+	for (i = 0; i < led_count; i++) {
+		gdata->led_cdev[i] = kzalloc(sizeof(struct led_classdev),
+					     GFP_KERNEL);
+		if (gdata->led_cdev[i] == NULL) {
+			error = -ENOMEM;
+			goto err_cleanup_led_structs;
+		}
+
+		/* Set the accessor functions by copying from template*/
+		*(gdata->led_cdev[i]) = led_templates[i];
+
+		/*
+		 * Allocate memory for the LED name
+		 *
+		 * Since led_classdev->name is a const char* we'll use an
+		 * intermediate until the name is formatted with sprintf().
+		 */
+		led_name = kzalloc(sizeof(char)*20, GFP_KERNEL);
+		if (led_name == NULL) {
+			error = -ENOMEM;
+			goto err_cleanup_led_structs;
+		}
+		sprintf(led_name, led_templates[i].name, hdev->minor);
+		gdata->led_cdev[i]->name = led_name;
+	}
+
+	for (i = 0; i < led_count; i++) {
+		registered_leds = i;
+		error = led_classdev_register(&hdev->dev, gdata->led_cdev[i]);
+		if (error < 0) {
+			dev_err(&hdev->dev,
+				"%s error registering led %d",
+				gdata->name, i);
+			error = -EINVAL;
+			goto err_cleanup_registered_leds;
+		}
+	}
+
+	return 0;
+
+err_cleanup_registered_leds:
+	for (i = 0; i < registered_leds; i++)
+		led_classdev_unregister(gdata->led_cdev[i]);
+
+err_cleanup_led_structs:
+	for (i = 0; i < led_count; i++) {
+		if (gdata->led_cdev[i] != NULL) {
+			if (gdata->led_cdev[i]->name != NULL)
+				kfree(gdata->led_cdev[i]->name);
+			kfree(gdata->led_cdev[i]);
+		}
+	}
+
+/* err_cleanup_led_array: */
+	kfree(gdata->led_cdev);
+
+err_no_cleanup:
+
+	return error;
+}
+EXPORT_SYMBOL_GPL(gcore_leds_probe);
+
+
+void gcore_leds_remove(struct gcore_data *gdata)
+{
+	int i;
+
+	for (i = 0; i < gdata->led_count; i++) {
+		led_classdev_unregister(gdata->led_cdev[i]);
+		kfree(gdata->led_cdev[i]->name);
+		kfree(gdata->led_cdev[i]);
+	}
+	kfree(gdata->led_cdev);
+}
+EXPORT_SYMBOL_GPL(gcore_leds_remove);
+
+
+struct hid_device *gcore_led_classdev_to_hdev(struct led_classdev *led_cdev)
+{
+	struct device *dev;
+
+	/* Get the device associated with the led */
+	dev = led_cdev->dev->parent;
+
+	/* Get the hid associated with the device */
+	return container_of(dev, struct hid_device, dev);
+}
+EXPORT_SYMBOL_GPL(gcore_led_classdev_to_hdev);
+
+
+ssize_t gcore_name_show(struct device *dev,
+			struct device_attribute *attr,
+			char *buf)
+{
+	unsigned long irq_flags;
+	struct gcore_data *gdata = dev_get_gdata(dev);
+	int result;
+
+	spin_lock_irqsave(&gdata->lock, irq_flags);
+	result = sprintf(buf, "%s", gdata->name);
+	spin_unlock_irqrestore(&gdata->lock, irq_flags);
+
+	return result;
+}
+EXPORT_SYMBOL_GPL(gcore_name_show);
+
+
+ssize_t gcore_name_store(struct device *dev,
+			 struct device_attribute *attr,
+			 const char *buf, size_t count)
+{
+	unsigned long irq_flags;
+	struct gcore_data *gdata = dev_get_gdata(dev);
+	size_t limit = count;
+	char *end;
+
+	end = strpbrk(buf, "\n\r");
+	if (end != NULL)
+		limit = end - buf;
+
+	if (end != buf) {
+		if (limit > 100)
+			limit = 100;
+
+		spin_lock_irqsave(&gdata->lock, irq_flags);
+
+		kfree(gdata->name);
+		gdata->name = kzalloc(limit+1, GFP_ATOMIC);
+
+		strncpy(gdata->name, buf, limit);
+
+		spin_unlock_irqrestore(&gdata->lock, irq_flags);
+	}
+
+	return count;
+}
+EXPORT_SYMBOL_GPL(gcore_name_store);
+
+
+ssize_t gcore_minor_show(struct device *dev,
+			 struct device_attribute *attr,
+			 char *buf)
+{
+	struct gcore_data *gdata = dev_get_gdata(dev);
+
+	return sprintf(buf, "%d\n", gdata->hdev->minor);
+}
+EXPORT_SYMBOL_GPL(gcore_minor_show);
+
+
+
+MODULE_DESCRIPTION("Logitech HID core functions");
+MODULE_AUTHOR("Rick L Vinyard Jr (rvinyard@cs.nmsu.edu)");
+MODULE_AUTHOR("Alistair Buxton (a.j.buxton@gmail.com)");
+MODULE_AUTHOR("Thomas Berger (tbe@boreus.de)");
+MODULE_AUTHOR("Ciubotariu Ciprian (cheepeero@gmx.net)");
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-gcore.h b/drivers/hid/hid-gcore.h
new file mode 100644
index 0000000..c22d70d
--- /dev/null
+++ b/drivers/hid/hid-gcore.h
@@ -0,0 +1,74 @@
+#ifndef HID_GCORE_H_INCLUDED
+#define HID_GCORE_H_INCLUDED		1
+
+/* See hid-gfb.h */
+struct gfb_data;
+
+/* Private driver data that is common for G-series drivers
+ *
+ * The model of the hid-gXX driver is an unique driver for all
+ * devices contained within the specific keyboard (framebuffer, extra keys
+ * and leds). Factoring common functionalities between drivers lead to
+ * separate modules needing access to common shared data.
+ *
+ * All functions along different modules should be able to access their
+ * specific data structures starting from this structure, attached to
+ * the root hid device, by downcasting the data field to the appropriate
+ * gXX_data structure.
+ */
+struct gcore_data {
+	char *name;		       /* name of the device */
+
+	struct hid_device *hdev;       /* hid device */
+	struct input_dev *input_dev;   /* input device */
+	struct gfb_data *gfb_data;     /* framebuffer (may be NULL) */
+	int led_count;		       /* number of leds */
+	struct led_classdev **led_cdev; /* led devices */
+
+	spinlock_t lock;	       /* global device lock */
+
+	void *data;		       /* specific driver data */
+};
+
+
+/* get the common private driver data from a hid_device */
+#define hid_get_gdata(hdev) \
+	((struct gcore_data *)(hid_get_drvdata(hdev)))
+
+/* get the common private driver data from a generic device */
+#define dev_get_gdata(dev) \
+	((struct gcore_data *)(dev_get_drvdata(dev)))
+
+
+/** Exported functions. */
+
+
+/** Initialization helpers. */
+struct gcore_data *gcore_alloc_data(const char *name, struct hid_device *hdev);
+void gcore_free_data(struct gcore_data *gdata);
+
+int gcore_hid_open(struct gcore_data *gdata);
+void gcore_hid_close(struct gcore_data *gdata);
+
+int gcore_input_probe(struct gcore_data *gdata,
+		      const unsigned int default_keymap[], int keymap_size);
+void gcore_input_remove(struct gcore_data *gdata);
+
+int gcore_leds_probe(struct gcore_data *gdata,
+		     const struct led_classdev led_templates[], int led_count);
+void gcore_leds_remove(struct gcore_data *gdata);
+
+struct hid_device *gcore_led_classdev_to_hdev(struct led_classdev *led_cdev);
+
+/** Input helpers. */
+void gcore_input_report_key(struct gcore_data *gdata, int scancode, int value);
+
+/** Common sysfs attributes. */
+ssize_t gcore_name_show(struct device *dev, struct device_attribute *attr,
+			char *buf);
+ssize_t gcore_name_store(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count);
+ssize_t gcore_minor_show(struct device *dev, struct device_attribute *attr,
+			 char *buf);
+
+#endif
diff --git a/drivers/hid/hid-gfb.c b/drivers/hid/hid-gfb.c
new file mode 100644
index 0000000..d371475
--- /dev/null
+++ b/drivers/hid/hid-gfb.c
@@ -0,0 +1,751 @@
+/***************************************************************************
+ *   Copyright (C) 2010 by Alistair Buxton				   *
+ *   a.j.buxton@gmail.com						   *
+ *   based on hid-g13.c							   *
+ *									   *
+ *   This program is free software: you can redistribute it and/or modify  *
+ *   it under the terms of the GNU General Public License as published by  *
+ *   the Free Software Foundation, either version 2 of the License, or	   *
+ *   (at your option) any later version.				   *
+ *									   *
+ *   This driver is distributed in the hope that it will be useful, but	   *
+ *   WITHOUT ANY WARRANTY; without even the implied warranty of		   *
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU	   *
+ *   General Public License for more details.				   *
+ *									   *
+ *   You should have received a copy of the GNU General Public License	   *
+ *   along with this software. If not see <http://www.gnu.org/licenses/>.  *
+ ***************************************************************************/
+#include <linux/fb.h>
+#include <linux/hid.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/sysfs.h>
+#include <linux/uaccess.h>
+#include <linux/usb.h>
+#include <linux/vmalloc.h>
+#include <linux/leds.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+
+#include "hid-ids.h"
+#include "hid-gcore.h"
+#include "hid-gfb.h"
+
+#define GFB_NAME "Logitech GamePanel Framebuffer"
+
+/* Framebuffer defines */
+#define GFB_UPDATE_RATE_LIMIT (30)
+#define GFB_UPDATE_RATE_DEFAULT (30)
+
+/* Convenience macros */
+#define dev_get_gfbdata(dev)					\
+	((struct gfb_data *)(dev_get_gdata(dev)->gfb_data))
+
+static uint32_t pseudo_palette[16];
+
+/* Forward decl. */
+static void gfb_free_data(struct kref *kref);
+
+/* Unlock the urb so we can reuse it */
+static void gfb_fb_urb_completion(struct urb *urb)
+{
+	/* we need to unlock fb_vbitmap regardless of urb success status */
+	unsigned long irq_flags;
+	struct gfb_data *data = urb->context;
+
+	spin_lock_irqsave(&data->fb_urb_lock, irq_flags);
+	data->fb_vbitmap_busy = false;
+	spin_unlock_irqrestore(&data->fb_urb_lock, irq_flags);
+}
+
+/* Send the current framebuffer vbitmap as an interrupt message */
+static int gfb_fb_send(struct gfb_data *data)
+{
+	struct usb_interface *intf;
+	struct usb_device *usb_dev;
+	struct hid_device *hdev = data->hdev;
+
+	struct usb_host_endpoint *ep;
+	unsigned int pipe;
+	int retval = 0;
+	unsigned long irq_flags;
+
+	/* This would fail down below if the device was removed. */
+	if (data->virtualized)
+		return -ENODEV;
+
+	/*
+	 * Try and lock the framebuffer urb to prevent access if we have
+	 * submitted it. If we can't lock it we'll have to delay this update
+	 * until the next framebuffer interval.
+	 *
+	 * Fortunately, we already have the infrastructure in place with the
+	 * framebuffer deferred I/O driver to schedule the delayed update.
+	 */
+
+	spin_lock_irqsave(&data->fb_urb_lock, irq_flags);
+	if (likely(!data->fb_vbitmap_busy)) {
+		/* Get the usb device to send the image on */
+		intf = to_usb_interface(hdev->dev.parent);
+		usb_dev = interface_to_usbdev(intf);
+
+		switch (data->panel_type) {
+		case GFB_PANEL_TYPE_160_43_1:
+			pipe = usb_sndintpipe(usb_dev, 0x02);
+			break;
+		case GFB_PANEL_TYPE_320_240_16:
+			pipe = usb_sndbulkpipe(usb_dev, 0x02);
+			break;
+		default:
+			spin_unlock_irqrestore(&data->fb_urb_lock, irq_flags);
+			return -EINVAL;
+		}
+
+		ep = (usb_pipein(pipe) ?
+		      usb_dev->ep_in : usb_dev->ep_out)[usb_pipeendpoint(pipe)];
+
+		if (unlikely(!ep)) {
+			spin_unlock_irqrestore(&data->fb_urb_lock, irq_flags);
+			return -ENODEV;
+		}
+
+		switch (data->panel_type) {
+		case GFB_PANEL_TYPE_160_43_1:
+			usb_fill_int_urb(data->fb_urb, usb_dev, pipe,
+					 data->fb_vbitmap,
+					 data->fb_vbitmap_size,
+					 gfb_fb_urb_completion, data,
+					 ep->desc.bInterval);
+			break;
+		case GFB_PANEL_TYPE_320_240_16:
+			usb_fill_bulk_urb(data->fb_urb, usb_dev, pipe,
+					  data->fb_vbitmap,
+					  data->fb_vbitmap_size,
+					  gfb_fb_urb_completion, data);
+			break;
+		default:
+			spin_unlock_irqrestore(&data->fb_urb_lock, irq_flags);
+			return -EINVAL;
+		}
+
+		data->fb_urb->actual_length = 0;
+
+		/* atomic since we're holding a spinlock */
+		retval = usb_submit_urb(data->fb_urb, GFP_ATOMIC);
+		if (unlikely(retval < 0)) {
+			/*
+			 * We need to unlock the framebuffer urb lock since
+			 * the urb submission failed and therefore
+			 * g19_fb_urb_completion() won't be called.
+			 */
+			spin_unlock_irqrestore(&data->fb_urb_lock, irq_flags);
+			return retval;
+		}
+
+		/* All succeeded - mark the softlock and unlock the spinlock */
+		data->fb_vbitmap_busy = true;
+		spin_unlock_irqrestore(&data->fb_urb_lock, irq_flags);
+	} else {
+		spin_unlock_irqrestore(&data->fb_urb_lock, irq_flags);
+		schedule_delayed_work(&data->fb_info->deferred_work,
+				      data->fb_defio.delay);
+	}
+
+	return retval;
+}
+
+
+static char hdata[512] = {
+	0x10, 0x0f, 0x00, 0x58, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3f,
+	0x01, 0xef, 0x00, 0x0f, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
+	0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f, 0x20, 0x21, 0x22, 0x23,
+	0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f,
+	0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3a, 0x3b,
+	0x3c, 0x3d, 0x3e, 0x3f, 0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47,
+	0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f, 0x50, 0x51, 0x52, 0x53,
+	0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f,
+	0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6a, 0x6b,
+	0x6c, 0x6d, 0x6e, 0x6f, 0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77,
+	0x78, 0x79, 0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x7f, 0x80, 0x81, 0x82, 0x83,
+	0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f,
+	0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98, 0x99, 0x9a, 0x9b,
+	0x9c, 0x9d, 0x9e, 0x9f, 0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7,
+	0xa8, 0xa9, 0xaa, 0xab, 0xac, 0xad, 0xae, 0xaf, 0xb0, 0xb1, 0xb2, 0xb3,
+	0xb4, 0xb5, 0xb6, 0xb7, 0xb8, 0xb9, 0xba, 0xbb, 0xbc, 0xbd, 0xbe, 0xbf,
+	0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7, 0xc8, 0xc9, 0xca, 0xcb,
+	0xcc, 0xcd, 0xce, 0xcf, 0xd0, 0xd1, 0xd2, 0xd3, 0xd4, 0xd5, 0xd6, 0xd7,
+	0xd8, 0xd9, 0xda, 0xdb, 0xdc, 0xdd, 0xde, 0xdf, 0xe0, 0xe1, 0xe2, 0xe3,
+	0xe4, 0xe5, 0xe6, 0xe7, 0xe8, 0xe9, 0xea, 0xeb, 0xec, 0xed, 0xee, 0xef,
+	0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7, 0xf8, 0xf9, 0xfa, 0xfb,
+	0xfc, 0xfd, 0xfe, 0xff, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10, 0x11, 0x12, 0x13,
+	0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f,
+	0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2a, 0x2b,
+	0x2c, 0x2d, 0x2e, 0x2f, 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,
+	0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f, 0x40, 0x41, 0x42, 0x43,
+	0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f,
+	0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5a, 0x5b,
+	0x5c, 0x5d, 0x5e, 0x5f, 0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67,
+	0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f, 0x70, 0x71, 0x72, 0x73,
+	0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x7f,
+	0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x8a, 0x8b,
+	0x8c, 0x8d, 0x8e, 0x8f, 0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97,
+	0x98, 0x99, 0x9a, 0x9b, 0x9c, 0x9d, 0x9e, 0x9f, 0xa0, 0xa1, 0xa2, 0xa3,
+	0xa4, 0xa5, 0xa6, 0xa7, 0xa8, 0xa9, 0xaa, 0xab, 0xac, 0xad, 0xae, 0xaf,
+	0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7, 0xb8, 0xb9, 0xba, 0xbb,
+	0xbc, 0xbd, 0xbe, 0xbf, 0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7,
+	0xc8, 0xc9, 0xca, 0xcb, 0xcc, 0xcd, 0xce, 0xcf, 0xd0, 0xd1, 0xd2, 0xd3,
+	0xd4, 0xd5, 0xd6, 0xd7, 0xd8, 0xd9, 0xda, 0xdb, 0xdc, 0xdd, 0xde, 0xdf,
+	0xe0, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7, 0xe8, 0xe9, 0xea, 0xeb,
+	0xec, 0xed, 0xee, 0xef, 0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
+	0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff
+};
+
+/* Update fb_vbitmap from the screen_base and send to the device */
+static void gfb_fb_qvga_update(struct gfb_data *data)
+{
+	int xres, yres;
+	int col, row;
+	u16 *src, *dst;
+
+	/* Set the image message header */
+	memcpy(data->fb_vbitmap, &hdata, sizeof(hdata));
+
+	/* LCD is a portrait mode one so we have to rotate the framebuffer */
+
+	src = (u16 *)data->fb_bitmap;
+	dst = (u16 *)(data->fb_vbitmap + sizeof(hdata));
+
+	xres = data->fb_info->var.xres;
+	yres = data->fb_info->var.yres;
+	for (col = 0; col < xres; ++col)
+		for (row = 0; row < yres; ++row)
+			*dst++ = src[row * xres + col];
+}
+
+static void gfb_fb_mono_update(struct gfb_data *data)
+{
+	int xres, yres, ll;
+	int band, bands, col, bit;
+	u8 *dst, *src, *row_start;
+	u8 mask;
+
+	/* Clear the vbitmap (we only flip bits to 1 later on) */
+	memset(data->fb_vbitmap, 0x00, data->fb_vbitmap_size);
+
+	/* Set the magic number */
+	data->fb_vbitmap[0] = 0x03;
+
+	/*
+	 * Translate the XBM format screen_base into the format needed by the
+	 * G15. This format places the pixels in a vertical rather than
+	 * horizontal format. Assuming a grid with 0,0 in the upper left corner
+	 * and 159,42 in the lower right corner, the first byte contains the
+	 * pixels 0,0 through 0,7 and the second byte contains the pixels 1,0
+	 * through 1,7. Within the byte, bit 0 represents 0,0; bit 1 0,1; etc.
+	 *
+	 * The offset is adjusted by 32 within the image message.
+	 */
+
+	xres = data->fb_info->var.xres;
+	yres = data->fb_info->var.yres;
+	ll = data->fb_info->fix.line_length;
+
+	dst = data->fb_vbitmap + 32;
+
+	bands = (yres + 7) / 8; /* poor man's ceil(yres/8) */
+	for (band = 0; band < bands ; ++band) {
+		/* each band is 8 pixels vertically */
+		row_start = data->fb_bitmap + band * 8 * ll;
+		for (col = 0; col < xres; ++col) {
+			src = row_start + col / 8;
+			mask = 0x01 << (col % 8);
+			for (bit = 0 ; bit < 8 ; ++bit) {
+				if (*src & mask)
+					*dst |= (0x01 << bit);
+				src += ll;
+			}
+			++dst;
+		}
+	}
+}
+
+static int gfb_fb_update(struct gfb_data *data)
+{
+	int result = 0;
+
+	switch (data->panel_type) {
+	case GFB_PANEL_TYPE_160_43_1:
+		gfb_fb_mono_update(data);
+		result = gfb_fb_send(data);
+		break;
+	case GFB_PANEL_TYPE_320_240_16:
+		gfb_fb_qvga_update(data);
+		result = gfb_fb_send(data);
+		break;
+	default:
+		break;
+	}
+	return result;
+}
+
+/* Callback from deferred IO workqueue */
+static void gfb_fb_deferred_io(struct fb_info *info, struct list_head *pagelist)
+{
+	gfb_fb_update(info->par);
+}
+
+
+/* Blame vfb.c if things go wrong in gfb_fb_setcolreg */
+
+static int gfb_fb_setcolreg(unsigned regno, unsigned red, unsigned green,
+			    unsigned blue, unsigned transp,
+			    struct fb_info *info)
+{
+	if (regno >= 16)
+		return 1;
+
+	/* grayscale works only partially under directcolor */
+	if (info->var.grayscale) {
+		/* grayscale = 0.30*R + 0.59*G + 0.11*B */
+		red = green = blue =
+				  (red * 77 + green * 151 + blue * 28) >> 8;
+	}
+
+	/* Truecolor has hardware independent palette */
+	if (info->fix.visual == FB_VISUAL_TRUECOLOR) {
+		u32 v;
+
+#define CNVT_TOHW(val, width) ((((val)<<(width))+0x7FFF-(val))>>16)
+
+		red = CNVT_TOHW(red, info->var.red.length);
+		green = CNVT_TOHW(green, info->var.green.length);
+		blue = CNVT_TOHW(blue, info->var.blue.length);
+		transp = CNVT_TOHW(transp, info->var.transp.length);
+
+#undef CNVT_TOHW
+
+		v = (red << info->var.red.offset) |
+		    (green << info->var.green.offset) |
+		    (blue << info->var.blue.offset) |
+		    (transp << info->var.transp.offset);
+
+		switch (info->var.bits_per_pixel) {
+		case 8:
+			break;
+		case 16:
+			((u32 *) (info->pseudo_palette))[regno] = v;
+			break;
+		case 24:
+		case 32:
+			((u32 *) (info->pseudo_palette))[regno] = v;
+			break;
+		}
+	}
+
+	return 0;
+}
+
+/* Stub to call the system default and update the image on the gfb */
+static void gfb_fb_fillrect(struct fb_info *info,
+			    const struct fb_fillrect *rect)
+{
+	struct gfb_data *par = info->par;
+
+	sys_fillrect(info, rect);
+	gfb_fb_update(par);
+}
+
+/* Stub to call the system default and update the image on the gfb */
+static void gfb_fb_copyarea(struct fb_info *info,
+			    const struct fb_copyarea *area)
+{
+	struct gfb_data *par = info->par;
+
+	sys_copyarea(info, area);
+	gfb_fb_update(par);
+}
+
+/* Stub to call the system default and update the image on the gfb */
+static void gfb_fb_imageblit(struct fb_info *info, const struct fb_image *image)
+{
+	struct gfb_data *par = info->par;
+
+	sys_imageblit(info, image);
+	gfb_fb_update(par);
+}
+
+
+static int gfb_fb_open(struct fb_info *info, int user)
+{
+	struct gfb_data *dev = info->par;
+
+	/* If the USB device is gone, we don't accept new opens */
+	if (dev->virtualized)
+		return -ENODEV;
+
+	dev->fb_count++;
+
+	/* match kref_put in gfb_fb_release */
+	kref_get(&dev->kref);
+
+	return 0;
+}
+
+
+static int gfb_fb_release(struct fb_info *info, int user)
+{
+	struct gfb_data *dev = info->par;
+
+	dev->fb_count--;
+
+	if (dev->virtualized && dev->fb_count == 0)
+		schedule_delayed_work(&dev->free_framebuffer_work, HZ);
+
+	/* match kref_get in gfb_fb_open */
+	kref_put(&dev->kref, gfb_free_data);
+
+	return 0;
+}
+
+/*
+ * this is the slow path from userspace. they can seek and write to
+ * the fb. it's inefficient to do anything less than a full screen draw
+ */
+static ssize_t gfb_fb_write(struct fb_info *info, const char __user *buf,
+			    size_t count, loff_t *ppos)
+{
+	struct gfb_data *par = info->par;
+	ssize_t result;
+
+	result = fb_sys_write(info, buf, count, ppos);
+	if (result != -EFAULT && result != -EPERM)
+		result = gfb_fb_update(par);
+	return result;
+}
+
+static struct fb_ops gfb_ops = {
+	.owner = THIS_MODULE,
+	.fb_read      = fb_sys_read,
+	.fb_open      = gfb_fb_open,
+	.fb_release   = gfb_fb_release,
+	.fb_write     = gfb_fb_write,
+	.fb_setcolreg = gfb_fb_setcolreg,
+	.fb_fillrect  = gfb_fb_fillrect,
+	.fb_copyarea  = gfb_fb_copyarea,
+	.fb_imageblit = gfb_fb_imageblit,
+};
+
+/*
+ * The "fb_node" attribute
+ */
+ssize_t gfb_fb_node_show(struct device *dev,
+			 struct device_attribute *attr,
+			 char *buf)
+{
+	unsigned fb_node;
+	struct gfb_data *data = dev_get_gfbdata(dev);
+
+	if (!data)
+		return -ENODATA;
+
+	fb_node = data->fb_info->node;
+
+	return sprintf(buf, "%u\n", fb_node);
+}
+EXPORT_SYMBOL_GPL(gfb_fb_node_show);
+
+/*
+ * The "fb_update_rate" attribute
+ */
+ssize_t gfb_fb_update_rate_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	unsigned fb_update_rate;
+	struct gfb_data *data = dev_get_gfbdata(dev);
+
+	if (!data)
+		return -ENODATA;
+
+	fb_update_rate = data->fb_update_rate;
+
+	return sprintf(buf, "%u\n", fb_update_rate);
+}
+EXPORT_SYMBOL_GPL(gfb_fb_update_rate_show);
+
+static ssize_t gfb_set_fb_update_rate(struct gfb_data *data,
+				      unsigned fb_update_rate)
+{
+	if (fb_update_rate > GFB_UPDATE_RATE_LIMIT)
+		data->fb_update_rate = GFB_UPDATE_RATE_LIMIT;
+	else if (fb_update_rate == 0)
+		data->fb_update_rate = 1;
+	else
+		data->fb_update_rate = fb_update_rate;
+
+	data->fb_defio.delay = HZ / data->fb_update_rate;
+
+	return 0;
+}
+
+ssize_t gfb_fb_update_rate_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	int i;
+	unsigned u;
+	ssize_t set_result;
+
+	struct gfb_data *data = dev_get_gfbdata(dev);
+
+	if (!data)
+		return -ENODATA;
+
+	i = kstrtouint(buf, 0, &u);
+	if (i != 0) {
+		dev_warn(dev, GFB_NAME " unrecognized input: %s", buf);
+		return -EINVAL;
+	}
+
+	set_result = gfb_set_fb_update_rate(data, u);
+
+	if (set_result < 0)
+		return set_result;
+
+	return count;
+}
+EXPORT_SYMBOL_GPL(gfb_fb_update_rate_store);
+
+static struct fb_deferred_io gfb_fb_defio = {
+	.delay = HZ / GFB_UPDATE_RATE_DEFAULT,
+	.deferred_io = gfb_fb_deferred_io,
+};
+
+
+/* Free the gfb_data structure and the bitmaps. */
+static void gfb_free_data(struct kref *kref)
+{
+	struct gfb_data *data = container_of(kref, struct gfb_data, kref);
+
+	vfree(data->fb_bitmap);
+	kfree(data->fb_vbitmap);
+
+	kfree(data);
+}
+
+
+/* Free framebuffer structures after all file handles are released. */
+static void gfb_free_framebuffer_work(struct work_struct *work)
+{
+	struct gfb_data *data = container_of(work, struct gfb_data,
+					     free_framebuffer_work.work);
+	struct fb_info *info = data->fb_info;
+
+	if (info) {
+		fb_deferred_io_cleanup(info);
+		usb_free_urb(data->fb_urb);
+
+		unregister_framebuffer(info);
+		framebuffer_release(info);
+
+		data->fb_info = NULL;
+	}
+
+	/* release reference taken by kref_put in gfb_probe() */
+	kref_put(&data->kref, gfb_free_data);
+}
+
+
+
+struct gfb_data *gfb_probe(struct hid_device *hdev,
+			   const int panel_type) {
+	int error;
+	struct gfb_data *data;
+
+	dev_dbg(&hdev->dev, "Logitech GamePanel framebuffer probe...");
+
+	/*
+	 * Let's allocate the gfb data structure, set some reasonable
+	 * defaults, and associate it with the device
+	 */
+	data = kzalloc(sizeof(struct gfb_data), GFP_KERNEL);
+	if (data == NULL) {
+		error = -ENOMEM;
+		goto err_no_cleanup;
+	}
+
+	data->fb_bitmap = NULL;
+	data->fb_vbitmap = NULL;
+
+	kref_init(&data->kref); /* matching kref_put in gfb_remove */
+
+	data->fb_info = framebuffer_alloc(0, &hdev->dev);
+	if (data->fb_info == NULL) {
+		dev_err(&hdev->dev, GFB_NAME " failed to allocate fb\n");
+		goto err_cleanup_data;
+	}
+
+	/* init Framebuffer visual structures */
+
+	data->panel_type = panel_type;
+
+	switch (panel_type) {
+	case GFB_PANEL_TYPE_160_43_1:
+		data->fb_info->fix = (struct fb_fix_screeninfo) {
+			.id = "GFB_MONO",
+			.type = FB_TYPE_PACKED_PIXELS,
+			.visual = FB_VISUAL_MONO01,
+			.xpanstep = 0,
+			.ypanstep = 0,
+			.ywrapstep = 0,
+			.line_length = 32, /* = xres*bpp/8 + 12 bytes padding */
+			.accel = FB_ACCEL_NONE,
+		};
+		data->fb_info->var = (struct fb_var_screeninfo) {
+			.xres = 160,
+			.yres = 43,
+			.xres_virtual = 160,
+			.yres_virtual = 43,
+			.bits_per_pixel = 1,
+		};
+
+		/*
+		 * The native monochrome format uses vertical bits. Therefore
+		 * the number of bytes needed to represent the first column is
+		 * 43/8 (rows/bits) rounded up.
+		 * Additionally, the format requires a padding of 32 bits in
+		 * front of theimage data.
+		 *
+		 * Therefore the vbitmap size must be:
+		 *   160 * ceil(43/8) + 32 = 160 * 6 + 32 = 992
+		 */
+		data->fb_vbitmap_size = 992; /* = 32 + ceil(yres/8) * xres */
+		break;
+	case GFB_PANEL_TYPE_320_240_16:
+		data->fb_info->fix = (struct fb_fix_screeninfo) {
+			.id = "GFB_QVGA",
+			.type = FB_TYPE_PACKED_PIXELS,
+			.visual = FB_VISUAL_TRUECOLOR,
+			.xpanstep = 0,
+			.ypanstep = 0,
+			.ywrapstep = 0,
+			.line_length = 640, /*	 = xres * bpp/8 */
+			.accel = FB_ACCEL_NONE,
+		};
+		data->fb_info->var = (struct fb_var_screeninfo) {
+			.xres = 320,
+			.yres = 240,
+			.xres_virtual = 320,
+			.yres_virtual = 240,
+			.bits_per_pixel = 16,
+			.red	    = {11, 5, 0}, /* RGB565 */
+			.green	    = { 5, 6, 0},
+			.blue	    = { 0, 5, 0},
+			.transp	    = { 0, 0, 0},
+		};
+		data->fb_vbitmap_size = 154112; /* = yres * line_length +
+						 *   sizeof(hdata) */
+		break;
+	default:
+		dev_err(&hdev->dev, GFB_NAME ": ERROR: unknown panel type\n");
+		goto err_cleanup_fb;
+	}
+	data->fb_info->pseudo_palette = &pseudo_palette;
+	data->fb_info->fbops = &gfb_ops;
+	data->fb_info->par = data;
+	data->fb_info->flags = FBINFO_FLAG_DEFAULT;
+	data->fb_info->fix.smem_len =
+		data->fb_info->fix.line_length * data->fb_info->var.yres;
+
+	data->hdev = hdev;
+
+	data->fb_bitmap = vmalloc(data->fb_info->fix.smem_len);
+	if (data->fb_bitmap == NULL) {
+		error = -ENOMEM;
+		goto err_cleanup_data;
+	}
+
+	data->fb_vbitmap = kmalloc_array(data->fb_vbitmap_size, sizeof(u8),
+					 GFP_KERNEL);
+	if (data->fb_vbitmap == NULL) {
+		error = -ENOMEM;
+		goto err_cleanup_fb_bitmap;
+	}
+	data->fb_vbitmap_busy = false;
+
+	spin_lock_init(&data->fb_urb_lock);
+
+	data->fb_urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (data->fb_urb == NULL) {
+		dev_err(&hdev->dev, GFB_NAME ": ERROR: can't alloc usb urb\n");
+		error = -ENOMEM;
+		goto err_cleanup_fb_vbitmap;
+	}
+
+	data->fb_info->screen_base = (char __force __iomem *) data->fb_bitmap;
+
+	data->fb_update_rate = GFB_UPDATE_RATE_DEFAULT;
+
+	dbg_hid(KERN_INFO GFB_NAME " allocated framebuffer\n");
+
+	data->fb_defio = gfb_fb_defio;
+	data->fb_info->fbdefio = &data->fb_defio;
+
+	dbg_hid(KERN_INFO GFB_NAME " allocated deferred IO structure\n");
+
+	fb_deferred_io_init(data->fb_info);
+
+	INIT_DELAYED_WORK(&data->free_framebuffer_work,
+			  gfb_free_framebuffer_work);
+
+	if (register_framebuffer(data->fb_info) < 0)
+		goto err_cleanup_fb_deferred;
+
+	data->fb_count = 0;
+	data->virtualized = false;
+
+	kref_get(&data->kref); /* matching kref_put in free_framebuffer_work */
+
+	return data;
+
+
+err_cleanup_fb_deferred:
+	fb_deferred_io_cleanup(data->fb_info);
+	usb_free_urb(data->fb_urb);
+
+err_cleanup_fb_vbitmap:
+err_cleanup_fb_bitmap:
+err_cleanup_fb:
+	framebuffer_release(data->fb_info);
+
+err_cleanup_data:
+	kref_put(&data->kref, gfb_free_data);
+
+err_no_cleanup:
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(gfb_probe);
+
+
+void gfb_remove(struct gfb_data *data)
+{
+	data->virtualized = true;
+	if (data->fb_count == 0)
+		schedule_delayed_work(&data->free_framebuffer_work, 0);
+
+	/* release reference taken by kref_init in gfb_probe() */
+	kref_put(&data->kref, gfb_free_data);
+}
+EXPORT_SYMBOL_GPL(gfb_remove);
+
+
+MODULE_DESCRIPTION("Logitech GFB HID Driver");
+MODULE_AUTHOR("Rick L Vinyard Jr (rvinyard@cs.nmsu.edu)");
+MODULE_AUTHOR("Alistair Buxton (a.j.buxton@gmail.com)");
+MODULE_AUTHOR("Thomas Berger (tbe@boreus.de)");
+MODULE_AUTHOR("Ciubotariu Ciprian (cheepeero@gmx.net)");
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-gfb.h b/drivers/hid/hid-gfb.h
new file mode 100644
index 0000000..27f81b1
--- /dev/null
+++ b/drivers/hid/hid-gfb.h
@@ -0,0 +1,54 @@
+#ifndef GFB_PANEL_H_INCLUDED
+#define GFB_PANEL_H_INCLUDED		1
+
+#define GFB_PANEL_TYPE_160_43_1		0
+#define GFB_PANEL_TYPE_320_240_16	1
+
+#include <linux/fb.h>
+
+/* Per device data structure */
+struct gfb_data {
+	struct hid_device *hdev;
+	struct kref kref;
+
+	/* Framebuffer stuff */
+	int panel_type; /* enumeration of GFB_PANEL_TYPE_ values */
+
+	struct fb_info *fb_info;
+
+	struct fb_deferred_io fb_defio;
+	u8 fb_update_rate;
+
+	u8 *fb_bitmap;		/* device-dependent bitmap */
+	u8 *fb_vbitmap;		/* userspace bitmap */
+	int fb_vbitmap_busy;	/* soft-lock for vbitmap; uses fb_urb_lock */
+	size_t fb_vbitmap_size; /* size of vbitmap */
+
+	struct delayed_work free_framebuffer_work;
+
+	/* USB stuff */
+	struct urb *fb_urb;
+	spinlock_t fb_urb_lock;
+
+	/* Userspace stuff */
+	int fb_count;	   /* open file handle counter */
+	bool virtualized;  /* true when physical device not present */
+};
+
+ssize_t gfb_fb_node_show(struct device *dev,
+			 struct device_attribute *attr,
+			 char *buf);
+
+ssize_t gfb_fb_update_rate_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf);
+
+ssize_t gfb_fb_update_rate_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count);
+
+struct gfb_data *gfb_probe(struct hid_device *hdev, const int panel_type);
+
+void gfb_remove(struct gfb_data *data);
+
+#endif
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 46edb4d..63127e1 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -596,6 +596,13 @@
 #define USB_DEVICE_ID_LOGITECH_DUAL_ACTION	0xc216
 #define USB_DEVICE_ID_LOGITECH_RUMBLEPAD2	0xc218
 #define USB_DEVICE_ID_LOGITECH_RUMBLEPAD2_2	0xc219
+#define USB_DEVICE_ID_LOGITECH_G13		0xc21c
+#define USB_DEVICE_ID_LOGITECH_G15_LCD		0xc222
+#define USB_DEVICE_ID_LOGITECH_G15V2		0xc226
+#define USB_DEVICE_ID_LOGITECH_G15V2_LCD	0xc227
+#define USB_DEVICE_ID_LOGITECH_G19		0xc228
+#define USB_DEVICE_ID_LOGITECH_G19_LCD		0xc229
+#define USB_DEVICE_ID_LOGITECH_G110		0xc22b
 #define USB_DEVICE_ID_LOGITECH_WINGMAN_F3D	0xc283
 #define USB_DEVICE_ID_LOGITECH_FORCE3D_PRO	0xc286
 #define USB_DEVICE_ID_LOGITECH_FLIGHT_SYSTEM_G940	0xc287
-- 
2.0.5
