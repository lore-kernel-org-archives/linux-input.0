From: Eduard Hasenleithner <eduard@hasenleithner.at>
Subject: [PATCHv2] Wacom Intuos4 LED and OLED control
Date: Sun,  8 May 2011 15:24:02 +0200
Message-ID: <1304861042-9987-1-git-send-email-eduard@hasenleithner.at>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [93.83.152.182] ([93.83.152.182]:46167 "EHLO
	phenom.hasenleithner.at" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750850Ab1EHNYN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 8 May 2011 09:24:13 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

This commit enables control of the LEDs and OLED displays found
on the Wacom Intuos4 M, L, and XL. For this purpose, a new "led"
attribute group is added to the sysfs entry of the input device.

This "led" group only shows up when the correct device (M, L,
or XL) is detected. The attributes are described in
Documentation/ABI/testing/sysfs-wacom

Signed-off-by: Eduard Hasenleithner <eduard@hasenleithner.at>
---
 Documentation/ABI/testing/sysfs-wacom |   54 ++++++++++++
 drivers/input/tablet/wacom.h          |    8 ++
 drivers/input/tablet/wacom_sys.c      |  145 +++++++++++++++++++++++++++++++++
 drivers/input/tablet/wacom_wac.c      |   67 +++++++++++++++
 4 files changed, 274 insertions(+), 0 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-wacom b/Documentation/ABI/testing/sysfs-wacom
index 1517976..ca60e89 100644
--- a/Documentation/ABI/testing/sysfs-wacom
+++ b/Documentation/ABI/testing/sysfs-wacom
@@ -8,3 +8,57 @@ Description:
 		this file returns 1 if tablet reports in high speed mode
 		or 0 otherwise. Writing to this file one of these values
 		switches reporting speed.
+
+What:		/sys/class/input/input*/led
+Date:		Mai 2011
+Contact:	linux-input@vger.kernel.org
+Description:
+		Attribute group for control of the status LEDs and the OLED
+		displays found on the Wacom Intuos4 M, L, and XL tablets. This
+		attribute group is not available for other Wacom tablets.
+		Therefore its presence implicitly signifies the presence of
+		said LEDs and OLED displays on the tablet device.
+
+What:		/sys/class/input/input*/led/status0_luminance
+Date:		Mai 2011
+Contact:	linux-input@vger.kernel.org
+Description:
+		Writing to this file sets the status LED luminance (0..127)
+		when the stylus does not touch the tablet surface, and no
+		button is pressed on the stylus.
+
+What:		/sys/class/input/input*/led/status1_luminance
+Date:		Mai 2011
+Contact:	linux-input@vger.kernel.org
+Description:
+		Writing to this file sets the status LED luminance (0..127)
+		when the stylus touches the tablet surface, or any button is
+		pressed on the stylus.
+
+What:		/sys/class/input/input*/led/status_led_select
+Date:		Mai 2011
+Contact:	linux-input@vger.kernel.org
+Description:
+		Writing to this file sets which one of the four status LEDs is
+		active (0..3). The other three LEDs are always inactive.  By
+		means of specifying "-1" it is possible to set all status LEDs
+		to inactive.
+
+What:		/sys/class/input/input*/led/buttons_luminance
+Date:		Mai 2011
+Contact:	linux-input@vger.kernel.org
+Description:
+		Writing to this file sets the overall luminance level (0..15)
+		of all eight button OLED displays.
+
+What:		/sys/class/input/input*/led/buttonN_rawimg
+Date:		Mai 2011
+Contact:	linux-input@vger.kernel.org
+Description:
+		When writing a 1024 byte raw image in wacom Intuos4
+		interleaving format to the file, the image shows up on Button N
+		of the device. The image is a 64x32 pixel 4-bit gray image. The
+		1024 byte binary is split up into 16x 64 byte chunks. Each 64
+		byte chunk encodes the image data for two consecutive lines on
+		the display. The low nibble of each byte contains the first
+		line, and the high nibble contains the second line.
diff --git a/drivers/input/tablet/wacom.h b/drivers/input/tablet/wacom.h
index 23317bd..5ded77c 100644
--- a/drivers/input/tablet/wacom.h
+++ b/drivers/input/tablet/wacom.h
@@ -114,10 +114,18 @@ struct wacom {
 	struct mutex lock;
 	bool open;
 	char phys[32];
+	struct wacom_led {
+		char select; /* status led selector (0..3, -1=none) */
+		char llv;    /* status led brightness no button */
+		char hlv;    /* status led brightness button pressed */
+		char img_lum;   /* OLED matrix display brightness */
+	} led;
 };
 
 extern const struct usb_device_id wacom_ids[];
 
+int wacom_led_control(struct wacom *wacom);
+int wacom_led_putimage(struct wacom *wacom, int button_id, const void *img);
 void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len);
 void wacom_setup_device_quirks(struct wacom_features *features);
 void wacom_setup_input_capabilities(struct input_dev *input_dev,
diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 449c0a4..9c40cf8 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -465,6 +465,134 @@ static void wacom_remove_shared_data(struct wacom_wac *wacom)
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
+static DEVICE_ATTR(status_led_select, S_IWUSR, NULL, led_select_store);
+
+static ssize_t status_luminance0_store(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	long value;
+	int r = strict_strtol(buf, 10, &value);
+	if (r >= 0) {
+		struct wacom *wacom = dev_get_drvdata(dev);
+		wacom->led.llv = value & 0x7f;
+		r = wacom_led_control(wacom);
+		if (r >= 0)
+			return count;
+		else
+			return r;
+	} else {
+		return -EINVAL;
+	}
+}
+static DEVICE_ATTR(status0_luminance, S_IWUSR, NULL, status_luminance0_store);
+
+static ssize_t status_luminance1_store(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	long value;
+	int r = strict_strtol(buf, 10, &value);
+	if (r >= 0) {
+		struct wacom *wacom = dev_get_drvdata(dev);
+		wacom->led.hlv = value & 0x7f;
+		r = wacom_led_control(wacom);
+		if (r >= 0)
+			return count;
+		else
+			return r;
+	} else {
+		return -EINVAL;
+	}
+}
+static DEVICE_ATTR(status1_luminance, S_IWUSR, NULL, status_luminance1_store);
+
+static ssize_t buttons_luminance_store(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	long value;
+	int r = strict_strtol(buf, 10, &value);
+	if (r >= 0) {
+		struct wacom *wacom = dev_get_drvdata(dev);
+		wacom->led.img_lum = value & 0x7f;
+		r = wacom_led_control(wacom);
+		if (r >= 0)
+			return count;
+		else
+			return r;
+	} else {
+		return -EINVAL;
+	}
+}
+static DEVICE_ATTR(buttons_luminance, S_IWUSR, NULL, buttons_luminance_store);
+
+static ssize_t button_image_store(struct device *dev, int button_id,
+	const char *buf, size_t count)
+{
+	if (count == 1024) {
+		struct wacom *wacom = dev_get_drvdata(dev);
+		int r = wacom_led_putimage(wacom, button_id, buf);
+		if (r >= 0)
+			return count;
+		else
+			return r;
+	} else {
+		return -EINVAL;
+	}
+}
+
+#define DEVICE_BTNIMG_ATTR(BUTTON_ID) \
+static ssize_t btnimg##BUTTON_ID##_store(struct device *dev, \
+	struct device_attribute *attr, const char *buf, size_t count) \
+{ return button_image_store(dev, BUTTON_ID, buf, count); } \
+static DEVICE_ATTR(button##BUTTON_ID##_rawimg, S_IWUSR, \
+	NULL, btnimg##BUTTON_ID##_store);
+
+DEVICE_BTNIMG_ATTR(0)
+DEVICE_BTNIMG_ATTR(1)
+DEVICE_BTNIMG_ATTR(2)
+DEVICE_BTNIMG_ATTR(3)
+DEVICE_BTNIMG_ATTR(4)
+DEVICE_BTNIMG_ATTR(5)
+DEVICE_BTNIMG_ATTR(6)
+DEVICE_BTNIMG_ATTR(7)
+
+static struct attribute *wacom_led_attrs[] = {
+	&dev_attr_status0_luminance.attr,
+	&dev_attr_status1_luminance.attr,
+	&dev_attr_status_led_select.attr,
+	&dev_attr_buttons_luminance.attr,
+	&dev_attr_button0_rawimg.attr,
+	&dev_attr_button1_rawimg.attr,
+	&dev_attr_button2_rawimg.attr,
+	&dev_attr_button3_rawimg.attr,
+	&dev_attr_button4_rawimg.attr,
+	&dev_attr_button5_rawimg.attr,
+	&dev_attr_button6_rawimg.attr,
+	&dev_attr_button7_rawimg.attr,
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
@@ -557,6 +685,23 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
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
index 08ba5ad..6b6ef13 100644
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
+int wacom_led_putimage(struct wacom *wacom, int button_id, const void *img)
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
+		buf[1] = button_id & 0x07;
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

