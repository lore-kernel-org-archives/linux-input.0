From: Eduard Hasenleithner <eduard@hasenleithner.at>
Subject: [PATCH] Wacom Intuos4 LED and OLED control
Date: Sat,  9 Apr 2011 00:54:14 +0200
Message-ID: <1302303254-3062-1-git-send-email-eduard@hasenleithner.at>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [93.83.152.182] ([93.83.152.182]:49451 "EHLO
	phenom.hasenleithner.at" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752564Ab1DHWyR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 8 Apr 2011 18:54:17 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

This commit enables control of the LEDs and OLED displays found
on the Wacom Intuos4 M, L, and XL. For this purpose, a new "led"
attribute group is added to the sysfs entry of the input device.

This "led" group only shows up when the correct device (M, L,
or XL) is detected. Four write-only attributes are created:
* "luminance":
	array of three integers specfying
	* status led brightness when no button is pressed (0..127)
	* status led brightness when a button is pressed (0..127)
	* brightness of the OLED display (0..15)
* "status_select":
	specifies the id (0..3) of the status led, -1 = none
* "button_select":
	specifies the button id (0..7) of the image
* "button_rawimg":
	sets the raw image data of the button (binary, 1024 octets)

Signed-off-by: Eduard Hasenleithner <eduard@hasenleithner.at>
---
 drivers/input/tablet/wacom.h     |    9 +++
 drivers/input/tablet/wacom_sys.c |  105 ++++++++++++++++++++++++++++++++++++++
 drivers/input/tablet/wacom_wac.c |   67 ++++++++++++++++++++++++
 3 files changed, 181 insertions(+), 0 deletions(-)

diff --git a/drivers/input/tablet/wacom.h b/drivers/input/tablet/wacom.h
index 23317bd..580acba 100644
--- a/drivers/input/tablet/wacom.h
+++ b/drivers/input/tablet/wacom.h
@@ -114,10 +114,19 @@ struct wacom {
 	struct mutex lock;
 	bool open;
 	char phys[32];
+	struct wacom_led {
+		char select; /* status led selector (0..3, -1=none) */
+		char llv;    /* status led brightness no button */
+		char hlv;    /* status led brightness button pressed */
+		char img_lum;   /* OLED matrix display brightness */
+		char button_id; /* button_id for next wacom_led_putimage */
+	} led;
 };
 
 extern const struct usb_device_id wacom_ids[];
 
+int wacom_led_control(struct wacom *wacom);
+int wacom_led_putimage(struct wacom *wacom, const void *img);
 void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len);
 void wacom_setup_device_quirks(struct wacom_features *features);
 void wacom_setup_input_capabilities(struct input_dev *input_dev,
diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 449c0a4..c573eef 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -465,6 +465,94 @@ static void wacom_remove_shared_data(struct wacom_wac *wacom)
 	}
 }
 
+static ssize_t led_select_store(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	long id;
+	int r = strict_strtol(buf, 10, &id);
+	if (r >= 0) {
+		struct wacom *wacom = dev_get_drvdata(dev);
+		wacom->led.select = id;
+		r = wacom_led_control(wacom);
+		if (r >= 0)
+			return count;
+		else
+			return r;
+	} else {
+		return r;
+	}
+}
+static DEVICE_ATTR(status_select, S_IWUSR, NULL, led_select_store);
+
+static ssize_t led_luminance_store(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	unsigned char llv, hlv, img_lum;
+	int r = sscanf(buf, "%hhu %hhu %hhu", &llv, &hlv, &img_lum);
+	if (r == 3) {
+		struct wacom *wacom = dev_get_drvdata(dev);
+		wacom->led.llv = llv & 0x7f;
+		wacom->led.hlv = hlv & 0x7f;
+		wacom->led.img_lum = img_lum & 0x7f;
+		r = wacom_led_control(wacom);
+		if (r >= 0)
+			return count;
+		else
+			return r;
+	} else {
+		return -EINVAL;
+	}
+}
+static DEVICE_ATTR(luminance, S_IWUSR, NULL, led_luminance_store);
+
+static ssize_t led_button_select(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	long id;
+	int r = strict_strtoul(buf, 10, &id);
+	if (r >= 0) {
+		struct wacom *wacom = dev_get_drvdata(dev);
+		wacom->led.button_id = id;
+		r = wacom_led_control(wacom);
+		if (r >= 0)
+			return count;
+		else
+			return r;
+	} else {
+		return r;
+	}
+}
+static DEVICE_ATTR(button_select, S_IWUSR, NULL, led_button_select);
+
+static ssize_t led_button_store(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	if (count == 1024) {
+		struct wacom *wacom = dev_get_drvdata(dev);
+		int r = wacom_led_putimage(wacom, buf);
+		if (r >= 0)
+			return count;
+		else
+			return r;
+	} else {
+		return -EINVAL;
+	}
+}
+static DEVICE_ATTR(button_rawimg, S_IWUSR, NULL, led_button_store);
+
+static struct attribute *wacom_led_attrs[] = {
+	&dev_attr_status_select.attr,
+	&dev_attr_luminance.attr,
+	&dev_attr_button_select.attr,
+	&dev_attr_button_rawimg.attr,
+	NULL
+};
+
+static struct attribute_group wacom_led_attr_group = {
+	.name = "led",
+	.attrs = wacom_led_attrs,
+};
+
 static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct usb_device *dev = interface_to_usbdev(intf);
@@ -557,6 +645,23 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 	if (error)
 		goto fail4;
 
+	if (
+		wacom->wacom_wac.features.type >= INTUOS4 &&
+		wacom->wacom_wac.features.type <= INTUOS4L
+	) {
+		error = sysfs_create_group(&input_dev->dev.kobj,
+			&wacom_led_attr_group);
+		if (error)
+			dev_warn(&input_dev->dev,
+				"cannot create sysfs group err: %d\n", error);
+		/* init default values */
+		wacom->led.select = 0;
+		wacom->led.llv = 30;
+		wacom->led.hlv = 20;
+		wacom->led.img_lum = 10;
+		wacom_led_control(wacom);
+	}
+
 	/* Note that if query fails it is not a hard failure */
 	wacom_query_tablet_data(intf, features);
 
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 08ba5ad..1b58101 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1570,3 +1570,70 @@ const struct usb_device_id wacom_ids[] = {
 	{ }
 };
 MODULE_DEVICE_TABLE(usb, wacom_ids);
+
+#define WAC_CMD_RETRIES 10
+
+#define WAC_CMD_LED_CTRL 0x20
+#define WAC_CMD_ICON_START 0x21
+#define WAC_CMD_ICON_XFER 0x23
+
+static int wacom_command_xfer(struct usb_interface *intf,
+	unsigned char id, void *buf, int size)
+{
+	int rval, retries = WAC_CMD_RETRIES;
+	do rval = usb_control_msg(interface_to_usbdev(intf),
+		usb_sndctrlpipe(interface_to_usbdev(intf), 0),
+		0x09, USB_TYPE_CLASS | USB_RECIP_INTERFACE,
+		0x300 | id, intf->altsetting[0].desc.bInterfaceNumber,
+		buf, size, 1000);
+	while ((rval == -ETIMEDOUT || rval == -EPIPE) && --retries > 0);
+
+	return rval;
+}
+
+int wacom_led_control(struct wacom *wacom)
+{
+	char buf[9] = {
+		WAC_CMD_LED_CTRL,
+		wacom->led.select >= 0 ? wacom->led.select|4 : 0,
+		wacom->led.llv,
+		wacom->led.hlv,
+		wacom->led.img_lum,
+		0, 0, 0, 0
+	};
+
+	return wacom_command_xfer(wacom->intf,
+		WAC_CMD_LED_CTRL, buf, sizeof buf);
+}
+
+static int wacom_icon_start(struct usb_interface *intf, int start)
+{
+	char buf[2] = { WAC_CMD_ICON_START, start };
+	return wacom_command_xfer(intf, WAC_CMD_ICON_START, buf, sizeof buf);
+}
+
+int wacom_led_putimage(struct wacom *wacom, const void *img)
+{
+	unsigned char *buf;
+	int i, rval;
+
+	buf = kzalloc(259, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	rval = wacom_icon_start(wacom->intf, 1);
+	if (rval >= 0) {
+		buf[0] = WAC_CMD_ICON_XFER;
+		buf[1] = wacom->led.button_id & 0x07;
+		for (i = 0; i < 4; i++) {
+			buf[2] = i;
+			memcpy(buf+3, img + i*256, 256);
+			rval = wacom_command_xfer(wacom->intf,
+				WAC_CMD_ICON_XFER, buf, 259);
+			if (rval < 0)
+				break;
+		}
+	}
+	kfree(buf);
+	wacom_icon_start(wacom->intf, 0);
+	return rval;
+}
-- 
1.7.0.4

