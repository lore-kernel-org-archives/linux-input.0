From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 3/4] input: wacom - add LED support for Cintiq 21ux2
Date: Mon,  3 Oct 2011 17:03:25 -0700
Message-ID: <1317686605-29648-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:33713 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733Ab1JDABi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Oct 2011 20:01:38 -0400
Received: by pzk1 with SMTP id 1so13187259pzk.1
        for <linux-input@vger.kernel.org>; Mon, 03 Oct 2011 17:01:37 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

Cintiq 21ux2 has two sets of four LEDs on right and left side of
the tablet, respectively.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 Documentation/ABI/testing/sysfs-driver-wacom |   23 ++++--
 drivers/input/tablet/wacom.h                 |   10 ++--
 drivers/input/tablet/wacom_sys.c             |   98 +++++++++++++++++++-------
 3 files changed, 94 insertions(+), 37 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-wacom b/Documentation/ABI/testing/sysfs-driver-wacom
index b560185..82d4df1 100644
--- a/Documentation/ABI/testing/sysfs-driver-wacom
+++ b/Documentation/ABI/testing/sysfs-driver-wacom
@@ -13,11 +13,11 @@ What:		/sys/bus/usb/devices/<busnum>-<devnum>:<cfg>.<intf>/wacom_led/led
 Date:		August 2011
 Contact:	linux-input@vger.kernel.org
 Description:
-		Attribute group for control of the status LEDs and the OLED
-		displays found on the Wacom Intuos 4 M, L, and XL tablets. This
-		attribute group is not available for other Wacom tablets.
+		Attribute group for control of the status LEDs and the OLEDs.
+		This attribute group is only available for Intuos 4 M, L,
+		and XL (with LEDs and OLEDs) and Cintiq 21UX2 (LEDs only).
 		Therefore its presence implicitly signifies the presence of
-		said LEDs and OLED displays on the tablet device.
+		said LEDs and OLEDs on the tablet device.
 
 What:		/sys/bus/usb/devices/<busnum>-<devnum>:<cfg>.<intf>/wacom_led/status0_luminance
 Date:		August 2011
@@ -36,12 +36,21 @@ Description:
 		when the stylus touches the tablet surface, or any button is
 		pressed on the stylus.
 
-What:		/sys/bus/usb/devices/<busnum>-<devnum>:<cfg>.<intf>/wacom_led/status_led_select
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<cfg>.<intf>/wacom_led/status_led0_select
 Date:		August 2011
 Contact:	linux-input@vger.kernel.org
 Description:
-		Writing to this file sets which one of the four status LEDs is
-		active (0..3). The other three LEDs are always inactive.
+		Writing to this file sets which one of the four (for Intuos 4)
+		or of the right four (for Cintiq 21UX2) status LEDs is active (0..3).
+		The other three LEDs on the same side are always inactive.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<cfg>.<intf>/wacom_led/status_led1_select
+Date:		September 2011
+Contact:	linux-input@vger.kernel.org
+Description:
+		Writing to this file sets which one of the left four (for Cintiq 21UX2)
+		status LEDs is active (0..3). The other three LEDs on the left are always
+		inactive.
 
 What:		/sys/bus/usb/devices/<busnum>-<devnum>:<cfg>.<intf>/wacom_led/buttons_luminance
 Date:		August 2011
diff --git a/drivers/input/tablet/wacom.h b/drivers/input/tablet/wacom.h
index 561f107..0783864 100644
--- a/drivers/input/tablet/wacom.h
+++ b/drivers/input/tablet/wacom.h
@@ -11,7 +11,7 @@
  *  Copyright (c) 2000 Daniel Egger		<egger@suse.de>
  *  Copyright (c) 2001 Frederic Lepied		<flepied@mandrakesoft.com>
  *  Copyright (c) 2004 Panagiotis Issaris	<panagiotis.issaris@mech.kuleuven.ac.be>
- *  Copyright (c) 2002-2009 Ping Cheng		<pingc@wacom.com>
+ *  Copyright (c) 2002-2011 Ping Cheng		<pingc@wacom.com>
  *
  *  ChangeLog:
  *      v0.1 (vp)  - Initial release
@@ -93,7 +93,7 @@
 /*
  * Version Information
  */
-#define DRIVER_VERSION "v1.52"
+#define DRIVER_VERSION "v1.53"
 #define DRIVER_AUTHOR "Vojtech Pavlik <vojtech@ucw.cz>"
 #define DRIVER_DESC "USB Wacom tablet driver"
 #define DRIVER_LICENSE "GPL"
@@ -115,9 +115,9 @@ struct wacom {
 	bool open;
 	char phys[32];
 	struct wacom_led {
-		u8 select; /* status led selector (0..3) */
-		u8 llv;    /* status led brightness no button (1..127) */
-		u8 hlv;    /* status led brightness button pressed (1..127) */
+		u8 select[2]; /* status led selector (0..3) */
+		u8 llv;       /* status led brightness no button (1..127) */
+		u8 hlv;       /* status led brightness button pressed (1..127) */
 		u8 img_lum;   /* OLED matrix display brightness */
 	} led;
 };
diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 7facacc..6a61c8b 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -493,14 +493,19 @@ static void wacom_remove_shared_data(struct wacom_wac *wacom)
 static int wacom_led_control(struct wacom *wacom)
 {
 	unsigned char *buf;
-	int retval;
+	int retval, led = 0;
 
 	buf = kzalloc(9, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
+	if (wacom->wacom_wac.features.type == WACOM_21UX2)
+		led = (wacom->led.select[1] << 4) | 0x40;
+
+	led |=  wacom->led.select[0] | 0x4;
+
 	buf[0] = WAC_CMD_LED_CONTROL;
-	buf[1] = wacom->led.select >= 0 ? wacom->led.select | 4 : 0;
+	buf[1] = led;
 	buf[2] = wacom->led.llv;
 	buf[3] = wacom->led.hlv;
 	buf[4] = wacom->led.img_lum;
@@ -552,8 +557,7 @@ out:
 	return retval;
 }
 
-static ssize_t wacom_led_select_store(struct device *dev,
-				      struct device_attribute *attr,
+static ssize_t wacom_led_select_store(struct device *dev, int set_id,
 				      const char *buf, size_t count)
 {
 	struct wacom *wacom = dev_get_drvdata(dev);
@@ -566,7 +570,7 @@ static ssize_t wacom_led_select_store(struct device *dev,
 
 	mutex_lock(&wacom->lock);
 
-	wacom->led.select = id;
+	wacom->led.select[set_id] = id & 0x3;
 	err = wacom_led_control(wacom);
 
 	mutex_unlock(&wacom->lock);
@@ -574,7 +578,17 @@ static ssize_t wacom_led_select_store(struct device *dev,
 	return err < 0 ? err : count;
 }
 
-static DEVICE_ATTR(status_led_select, S_IWUSR, NULL, wacom_led_select_store);
+#define DEVICE_LED_SELECT_ATTR(SET_ID)					\
+static ssize_t wacom_led##SET_ID##_select_store(struct device *dev,	\
+	struct device_attribute *attr, const char *buf, size_t count)	\
+{									\
+	return wacom_led_select_store(dev, SET_ID, buf, count);		\
+}									\
+static DEVICE_ATTR(status_led##SET_ID##_select, S_IWUSR, NULL,		\
+		    wacom_led##SET_ID##_select_store)
+
+DEVICE_LED_SELECT_ATTR(0);
+DEVICE_LED_SELECT_ATTR(1);
 
 static ssize_t wacom_luminance_store(struct wacom *wacom, u8 *dest,
 				     const char *buf, size_t count)
@@ -648,10 +662,21 @@ DEVICE_BTNIMG_ATTR(5);
 DEVICE_BTNIMG_ATTR(6);
 DEVICE_BTNIMG_ATTR(7);
 
-static struct attribute *wacom_led_attrs[] = {
+static struct attribute *cintiq_led_attrs[] = {
+	&dev_attr_status_led0_select.attr,
+	&dev_attr_status_led1_select.attr,
+	NULL
+};
+
+static struct attribute_group cintiq_led_attr_group = {
+	.name = "wacom_led",
+	.attrs = cintiq_led_attrs,
+};
+
+static struct attribute *intuos4_led_attrs[] = {
 	&dev_attr_status0_luminance.attr,
 	&dev_attr_status1_luminance.attr,
-	&dev_attr_status_led_select.attr,
+	&dev_attr_status_led0_select.attr,
 	&dev_attr_buttons_luminance.attr,
 	&dev_attr_button0_rawimg.attr,
 	&dev_attr_button1_rawimg.attr,
@@ -664,43 +689,66 @@ static struct attribute *wacom_led_attrs[] = {
 	NULL
 };
 
-static struct attribute_group wacom_led_attr_group = {
+static struct attribute_group intuos4_led_attr_group = {
 	.name = "wacom_led",
-	.attrs = wacom_led_attrs,
+	.attrs = intuos4_led_attrs,
 };
 
 static int wacom_initialize_leds(struct wacom *wacom)
 {
 	int error;
 
-	if (wacom->wacom_wac.features.type >= INTUOS4 &&
-	    wacom->wacom_wac.features.type <= INTUOS4L) {
-
-		/* Initialize default values */
-		wacom->led.select = 0;
+	/* Initialize default values */
+	switch (wacom->wacom_wac.features.type) {
+	case INTUOS4:
+	case INTUOS4L:
+		wacom->led.select[0] = 0;
+		wacom->led.select[1] = 0;
 		wacom->led.llv = 10;
 		wacom->led.hlv = 20;
 		wacom->led.img_lum = 10;
-		wacom_led_control(wacom);
+		error = sysfs_create_group(&wacom->intf->dev.kobj,
+					   &intuos4_led_attr_group);
+		break;
+
+	case WACOM_21UX2:
+		wacom->led.select[0] = 0;
+		wacom->led.select[1] = 0;
+		wacom->led.llv = 0;
+		wacom->led.hlv = 0;
+		wacom->led.img_lum = 0;
 
 		error = sysfs_create_group(&wacom->intf->dev.kobj,
-					   &wacom_led_attr_group);
-		if (error) {
-			dev_err(&wacom->intf->dev,
-				"cannot create sysfs group err: %d\n", error);
-			return error;
-		}
+					   &cintiq_led_attr_group);
+		break;
+
+	default:
+		return 0;
+	}
+
+	if (error) {
+		dev_err(&wacom->intf->dev,
+			"cannot create sysfs group err: %d\n", error);
+		return error;
 	}
+	wacom_led_control(wacom);
 
 	return 0;
 }
 
 static void wacom_destroy_leds(struct wacom *wacom)
 {
-	if (wacom->wacom_wac.features.type >= INTUOS4 &&
-	    wacom->wacom_wac.features.type <= INTUOS4L) {
+	switch (wacom->wacom_wac.features.type) {
+	case INTUOS4:
+	case INTUOS4L:
 		sysfs_remove_group(&wacom->intf->dev.kobj,
-				   &wacom_led_attr_group);
+				   &intuos4_led_attr_group);
+		break;
+
+	case WACOM_21UX2:
+		sysfs_remove_group(&wacom->intf->dev.kobj,
+				   &cintiq_led_attr_group);
+		break;
 	}
 }
 
-- 
1.7.6

