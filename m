From: =?us-ascii?B?PT9VVEYtOD9xP0NsPUMzPUE5bWVudD0yMFZ1Y2hlbmVyPz0=?=
	<clement.vuchener@gmail.com>
Subject: [PATCH 1/2] HID: corsair: Remove all features using the USB protocol
Date: Wed, 23 Mar 2016 18:32:36 +0100
Message-ID: <6204914445b01d6379c3e3877014a7b11dc7c82b.1458744569.git.clement.vuchener@gmail.com>
References: <cover.1458744569.git.clement.vuchener@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35557 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386AbcCWRco (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Mar 2016 13:32:44 -0400
Content-Disposition: inline
In-Reply-To: <cover.1458744569.git.clement.vuchener@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Remove every use of USB control requests since it can be more easily do=
ne in user space. This removes the dependency on USB and LED subsystems=
=2E The simplyfied driver now only remaps Corsair usage codes.

Signed-off-by: Cl=E9ment Vuchener <clement.vuchener@gmail.com>
---
 Documentation/ABI/testing/sysfs-driver-hid-corsair |  15 -
 drivers/hid/Kconfig                                |   2 +-
 drivers/hid/hid-corsair.c                          | 497 +------------=
--------
 3 files changed, 2 insertions(+), 512 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-driver-hid-corsair

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-corsair b/Docum=
entation/ABI/testing/sysfs-driver-hid-corsair
deleted file mode 100644
index b8827f0..0000000
--- a/Documentation/ABI/testing/sysfs-driver-hid-corsair
+++ /dev/null
@@ -1,15 +0,0 @@
-What:		/sys/bus/drivers/corsair/<dev>/macro_mode
-Date:		August 2015
-KernelVersion:	4.2
-Contact:	Clement Vuchener <clement.vuchener@gmail.com>
-Description:	Get/set the current playback mode. "SW" for software mode
-		where G-keys triggers their regular key codes. "HW" for
-		hardware playback mode where the G-keys play their macro
-		from the on-board memory.
-
-
-What:		/sys/bus/drivers/corsair/<dev>/current_profile
-Date:		August 2015
-KernelVersion:	4.2
-Contact:	Clement Vuchener <clement.vuchener@gmail.com>
-Description:	Get/set the current selected profile. Values are from 1 t=
o 3.
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 4117225..43b018f 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -173,7 +173,7 @@ config HID_CHICONY
=20
 config HID_CORSAIR
 	tristate "Corsair devices"
-	depends on HID && USB && LEDS_CLASS
+	depends on HID
 	---help---
 	Support for Corsair devices that are not fully compliant with the
 	HID standard.
diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
index 717704e..98f40aa 100644
--- a/drivers/hid/hid-corsair.c
+++ b/drivers/hid/hid-corsair.c
@@ -16,31 +16,9 @@
=20
 #include <linux/hid.h>
 #include <linux/module.h>
-#include <linux/usb.h>
-#include <linux/leds.h>
=20
 #include "hid-ids.h"
=20
-#define CORSAIR_USE_K90_MACRO	(1<<0)
-#define CORSAIR_USE_K90_BACKLIGHT	(1<<1)
-
-struct k90_led {
-	struct led_classdev cdev;
-	int brightness;
-	struct work_struct work;
-	bool removed;
-};
-
-struct k90_drvdata {
-	struct k90_led record_led;
-};
-
-struct corsair_drvdata {
-	unsigned long quirks;
-	struct k90_drvdata *k90;
-	struct k90_led *backlight;
-};
-
 #define K90_GKEY_COUNT	18
=20
 static int corsair_usage_to_gkey(unsigned int usage)
@@ -119,474 +97,6 @@ MODULE_PARM_DESC(profilekey_codes, "Key codes for =
the profile buttons");
 #define CORSAIR_USAGE_LIGHT_BRIGHT 0xfd
 #define CORSAIR_USAGE_LIGHT_MAX 0xfd
=20
-/* USB control protocol */
-
-#define K90_REQUEST_BRIGHTNESS 49
-#define K90_REQUEST_MACRO_MODE 2
-#define K90_REQUEST_STATUS 4
-#define K90_REQUEST_GET_MODE 5
-#define K90_REQUEST_PROFILE 20
-
-#define K90_MACRO_MODE_SW 0x0030
-#define K90_MACRO_MODE_HW 0x0001
-
-#define K90_MACRO_LED_ON  0x0020
-#define K90_MACRO_LED_OFF 0x0040
-
-/*
- * LED class devices
- */
-
-#define K90_BACKLIGHT_LED_SUFFIX "::backlight"
-#define K90_RECORD_LED_SUFFIX "::record"
-
-static enum led_brightness k90_backlight_get(struct led_classdev *led_=
cdev)
-{
-	int ret;
-	struct k90_led *led =3D container_of(led_cdev, struct k90_led, cdev);
-	struct device *dev =3D led->cdev.dev->parent;
-	struct usb_interface *usbif =3D to_usb_interface(dev->parent);
-	struct usb_device *usbdev =3D interface_to_usbdev(usbif);
-	int brightness;
-	char data[8];
-
-	ret =3D usb_control_msg(usbdev, usb_rcvctrlpipe(usbdev, 0),
-			      K90_REQUEST_STATUS,
-			      USB_DIR_IN | USB_TYPE_VENDOR |
-			      USB_RECIP_DEVICE, 0, 0, data, 8,
-			      USB_CTRL_SET_TIMEOUT);
-	if (ret < 0) {
-		dev_warn(dev, "Failed to get K90 initial state (error %d).\n",
-			 ret);
-		return -EIO;
-	}
-	brightness =3D data[4];
-	if (brightness < 0 || brightness > 3) {
-		dev_warn(dev,
-			 "Read invalid backlight brightness: %02hhx.\n",
-			 data[4]);
-		return -EIO;
-	}
-	return brightness;
-}
-
-static enum led_brightness k90_record_led_get(struct led_classdev *led=
_cdev)
-{
-	struct k90_led *led =3D container_of(led_cdev, struct k90_led, cdev);
-
-	return led->brightness;
-}
-
-static void k90_brightness_set(struct led_classdev *led_cdev,
-			       enum led_brightness brightness)
-{
-	struct k90_led *led =3D container_of(led_cdev, struct k90_led, cdev);
-
-	led->brightness =3D brightness;
-	schedule_work(&led->work);
-}
-
-static void k90_backlight_work(struct work_struct *work)
-{
-	int ret;
-	struct k90_led *led =3D container_of(work, struct k90_led, work);
-	struct device *dev;
-	struct usb_interface *usbif;
-	struct usb_device *usbdev;
-
-	if (led->removed)
-		return;
-
-	dev =3D led->cdev.dev->parent;
-	usbif =3D to_usb_interface(dev->parent);
-	usbdev =3D interface_to_usbdev(usbif);
-
-	ret =3D usb_control_msg(usbdev, usb_sndctrlpipe(usbdev, 0),
-			      K90_REQUEST_BRIGHTNESS,
-			      USB_DIR_OUT | USB_TYPE_VENDOR |
-			      USB_RECIP_DEVICE, led->brightness, 0,
-			      NULL, 0, USB_CTRL_SET_TIMEOUT);
-	if (ret !=3D 0)
-		dev_warn(dev, "Failed to set backlight brightness (error: %d).\n",
-			 ret);
-}
-
-static void k90_record_led_work(struct work_struct *work)
-{
-	int ret;
-	struct k90_led *led =3D container_of(work, struct k90_led, work);
-	struct device *dev;
-	struct usb_interface *usbif;
-	struct usb_device *usbdev;
-	int value;
-
-	if (led->removed)
-		return;
-
-	dev =3D led->cdev.dev->parent;
-	usbif =3D to_usb_interface(dev->parent);
-	usbdev =3D interface_to_usbdev(usbif);
-
-	if (led->brightness > 0)
-		value =3D K90_MACRO_LED_ON;
-	else
-		value =3D K90_MACRO_LED_OFF;
-
-	ret =3D usb_control_msg(usbdev, usb_sndctrlpipe(usbdev, 0),
-			      K90_REQUEST_MACRO_MODE,
-			      USB_DIR_OUT | USB_TYPE_VENDOR |
-			      USB_RECIP_DEVICE, value, 0, NULL, 0,
-			      USB_CTRL_SET_TIMEOUT);
-	if (ret !=3D 0)
-		dev_warn(dev, "Failed to set record LED state (error: %d).\n",
-			 ret);
-}
-
-/*
- * Keyboard attributes
- */
-
-static ssize_t k90_show_macro_mode(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	int ret;
-	struct usb_interface *usbif =3D to_usb_interface(dev->parent);
-	struct usb_device *usbdev =3D interface_to_usbdev(usbif);
-	const char *macro_mode;
-	char data[8];
-
-	ret =3D usb_control_msg(usbdev, usb_rcvctrlpipe(usbdev, 0),
-			      K90_REQUEST_GET_MODE,
-			      USB_DIR_IN | USB_TYPE_VENDOR |
-			      USB_RECIP_DEVICE, 0, 0, data, 2,
-			      USB_CTRL_SET_TIMEOUT);
-	if (ret < 0) {
-		dev_warn(dev, "Failed to get K90 initial mode (error %d).\n",
-			 ret);
-		return -EIO;
-	}
-
-	switch (data[0]) {
-	case K90_MACRO_MODE_HW:
-		macro_mode =3D "HW";
-		break;
-
-	case K90_MACRO_MODE_SW:
-		macro_mode =3D "SW";
-		break;
-	default:
-		dev_warn(dev, "K90 in unknown mode: %02hhx.\n",
-			 data[0]);
-		return -EIO;
-	}
-
-	return snprintf(buf, PAGE_SIZE, "%s\n", macro_mode);
-}
-
-static ssize_t k90_store_macro_mode(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t count)
-{
-	int ret;
-	struct usb_interface *usbif =3D to_usb_interface(dev->parent);
-	struct usb_device *usbdev =3D interface_to_usbdev(usbif);
-	__u16 value;
-
-	if (strncmp(buf, "SW", 2) =3D=3D 0)
-		value =3D K90_MACRO_MODE_SW;
-	else if (strncmp(buf, "HW", 2) =3D=3D 0)
-		value =3D K90_MACRO_MODE_HW;
-	else
-		return -EINVAL;
-
-	ret =3D usb_control_msg(usbdev, usb_sndctrlpipe(usbdev, 0),
-			      K90_REQUEST_MACRO_MODE,
-			      USB_DIR_OUT | USB_TYPE_VENDOR |
-			      USB_RECIP_DEVICE, value, 0, NULL, 0,
-			      USB_CTRL_SET_TIMEOUT);
-	if (ret !=3D 0) {
-		dev_warn(dev, "Failed to set macro mode.\n");
-		return ret;
-	}
-
-	return count;
-}
-
-static ssize_t k90_show_current_profile(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
-{
-	int ret;
-	struct usb_interface *usbif =3D to_usb_interface(dev->parent);
-	struct usb_device *usbdev =3D interface_to_usbdev(usbif);
-	int current_profile;
-	char data[8];
-
-	ret =3D usb_control_msg(usbdev, usb_rcvctrlpipe(usbdev, 0),
-			      K90_REQUEST_STATUS,
-			      USB_DIR_IN | USB_TYPE_VENDOR |
-			      USB_RECIP_DEVICE, 0, 0, data, 8,
-			      USB_CTRL_SET_TIMEOUT);
-	if (ret < 0) {
-		dev_warn(dev, "Failed to get K90 initial state (error %d).\n",
-			 ret);
-		return -EIO;
-	}
-	current_profile =3D data[7];
-	if (current_profile < 1 || current_profile > 3) {
-		dev_warn(dev, "Read invalid current profile: %02hhx.\n",
-			 data[7]);
-		return -EIO;
-	}
-
-	return snprintf(buf, PAGE_SIZE, "%d\n", current_profile);
-}
-
-static ssize_t k90_store_current_profile(struct device *dev,
-					 struct device_attribute *attr,
-					 const char *buf, size_t count)
-{
-	int ret;
-	struct usb_interface *usbif =3D to_usb_interface(dev->parent);
-	struct usb_device *usbdev =3D interface_to_usbdev(usbif);
-	int profile;
-
-	if (kstrtoint(buf, 10, &profile))
-		return -EINVAL;
-	if (profile < 1 || profile > 3)
-		return -EINVAL;
-
-	ret =3D usb_control_msg(usbdev, usb_sndctrlpipe(usbdev, 0),
-			      K90_REQUEST_PROFILE,
-			      USB_DIR_OUT | USB_TYPE_VENDOR |
-			      USB_RECIP_DEVICE, profile, 0, NULL, 0,
-			      USB_CTRL_SET_TIMEOUT);
-	if (ret !=3D 0) {
-		dev_warn(dev, "Failed to change current profile (error %d).\n",
-			 ret);
-		return ret;
-	}
-
-	return count;
-}
-
-static DEVICE_ATTR(macro_mode, 0644, k90_show_macro_mode, k90_store_ma=
cro_mode);
-static DEVICE_ATTR(current_profile, 0644, k90_show_current_profile,
-		   k90_store_current_profile);
-
-static struct attribute *k90_attrs[] =3D {
-	&dev_attr_macro_mode.attr,
-	&dev_attr_current_profile.attr,
-	NULL
-};
-
-static const struct attribute_group k90_attr_group =3D {
-	.attrs =3D k90_attrs,
-};
-
-/*
- * Driver functions
- */
-
-static int k90_init_backlight(struct hid_device *dev)
-{
-	int ret;
-	struct corsair_drvdata *drvdata =3D hid_get_drvdata(dev);
-	size_t name_sz;
-	char *name;
-
-	drvdata->backlight =3D kzalloc(sizeof(struct k90_led), GFP_KERNEL);
-	if (!drvdata->backlight) {
-		ret =3D -ENOMEM;
-		goto fail_backlight_alloc;
-	}
-
-	name_sz =3D
-	    strlen(dev_name(&dev->dev)) + sizeof(K90_BACKLIGHT_LED_SUFFIX);
-	name =3D kzalloc(name_sz, GFP_KERNEL);
-	if (!name) {
-		ret =3D -ENOMEM;
-		goto fail_name_alloc;
-	}
-	snprintf(name, name_sz, "%s" K90_BACKLIGHT_LED_SUFFIX,
-		 dev_name(&dev->dev));
-	drvdata->backlight->removed =3D false;
-	drvdata->backlight->cdev.name =3D name;
-	drvdata->backlight->cdev.max_brightness =3D 3;
-	drvdata->backlight->cdev.brightness_set =3D k90_brightness_set;
-	drvdata->backlight->cdev.brightness_get =3D k90_backlight_get;
-	INIT_WORK(&drvdata->backlight->work, k90_backlight_work);
-	ret =3D led_classdev_register(&dev->dev, &drvdata->backlight->cdev);
-	if (ret !=3D 0)
-		goto fail_register_cdev;
-
-	return 0;
-
-fail_register_cdev:
-	kfree(drvdata->backlight->cdev.name);
-fail_name_alloc:
-	kfree(drvdata->backlight);
-	drvdata->backlight =3D NULL;
-fail_backlight_alloc:
-	return ret;
-}
-
-static int k90_init_macro_functions(struct hid_device *dev)
-{
-	int ret;
-	struct corsair_drvdata *drvdata =3D hid_get_drvdata(dev);
-	struct k90_drvdata *k90;
-	size_t name_sz;
-	char *name;
-
-	k90 =3D kzalloc(sizeof(struct k90_drvdata), GFP_KERNEL);
-	if (!k90) {
-		ret =3D -ENOMEM;
-		goto fail_drvdata;
-	}
-	drvdata->k90 =3D k90;
-
-	/* Init LED device for record LED */
-	name_sz =3D strlen(dev_name(&dev->dev)) + sizeof(K90_RECORD_LED_SUFFI=
X);
-	name =3D kzalloc(name_sz, GFP_KERNEL);
-	if (!name) {
-		ret =3D -ENOMEM;
-		goto fail_record_led_alloc;
-	}
-	snprintf(name, name_sz, "%s" K90_RECORD_LED_SUFFIX,
-		 dev_name(&dev->dev));
-	k90->record_led.removed =3D false;
-	k90->record_led.cdev.name =3D name;
-	k90->record_led.cdev.max_brightness =3D 1;
-	k90->record_led.cdev.brightness_set =3D k90_brightness_set;
-	k90->record_led.cdev.brightness_get =3D k90_record_led_get;
-	INIT_WORK(&k90->record_led.work, k90_record_led_work);
-	k90->record_led.brightness =3D 0;
-	ret =3D led_classdev_register(&dev->dev, &k90->record_led.cdev);
-	if (ret !=3D 0)
-		goto fail_record_led;
-
-	/* Init attributes */
-	ret =3D sysfs_create_group(&dev->dev.kobj, &k90_attr_group);
-	if (ret !=3D 0)
-		goto fail_sysfs;
-
-	return 0;
-
-fail_sysfs:
-	k90->record_led.removed =3D true;
-	led_classdev_unregister(&k90->record_led.cdev);
-	cancel_work_sync(&k90->record_led.work);
-fail_record_led:
-	kfree(k90->record_led.cdev.name);
-fail_record_led_alloc:
-	kfree(k90);
-fail_drvdata:
-	drvdata->k90 =3D NULL;
-	return ret;
-}
-
-static void k90_cleanup_backlight(struct hid_device *dev)
-{
-	struct corsair_drvdata *drvdata =3D hid_get_drvdata(dev);
-
-	if (drvdata->backlight) {
-		drvdata->backlight->removed =3D true;
-		led_classdev_unregister(&drvdata->backlight->cdev);
-		cancel_work_sync(&drvdata->backlight->work);
-		kfree(drvdata->backlight->cdev.name);
-		kfree(drvdata->backlight);
-	}
-}
-
-static void k90_cleanup_macro_functions(struct hid_device *dev)
-{
-	struct corsair_drvdata *drvdata =3D hid_get_drvdata(dev);
-	struct k90_drvdata *k90 =3D drvdata->k90;
-
-	if (k90) {
-		sysfs_remove_group(&dev->dev.kobj, &k90_attr_group);
-
-		k90->record_led.removed =3D true;
-		led_classdev_unregister(&k90->record_led.cdev);
-		cancel_work_sync(&k90->record_led.work);
-		kfree(k90->record_led.cdev.name);
-
-		kfree(k90);
-	}
-}
-
-static int corsair_probe(struct hid_device *dev, const struct hid_devi=
ce_id *id)
-{
-	int ret;
-	unsigned long quirks =3D id->driver_data;
-	struct corsair_drvdata *drvdata;
-	struct usb_interface *usbif =3D to_usb_interface(dev->dev.parent);
-
-	drvdata =3D devm_kzalloc(&dev->dev, sizeof(struct corsair_drvdata),
-			       GFP_KERNEL);
-	if (drvdata =3D=3D NULL)
-		return -ENOMEM;
-	drvdata->quirks =3D quirks;
-	hid_set_drvdata(dev, drvdata);
-
-	ret =3D hid_parse(dev);
-	if (ret !=3D 0) {
-		hid_err(dev, "parse failed\n");
-		return ret;
-	}
-	ret =3D hid_hw_start(dev, HID_CONNECT_DEFAULT);
-	if (ret !=3D 0) {
-		hid_err(dev, "hw start failed\n");
-		return ret;
-	}
-
-	if (usbif->cur_altsetting->desc.bInterfaceNumber =3D=3D 0) {
-		if (quirks & CORSAIR_USE_K90_MACRO) {
-			ret =3D k90_init_macro_functions(dev);
-			if (ret !=3D 0)
-				hid_warn(dev, "Failed to initialize K90 macro functions.\n");
-		}
-		if (quirks & CORSAIR_USE_K90_BACKLIGHT) {
-			ret =3D k90_init_backlight(dev);
-			if (ret !=3D 0)
-				hid_warn(dev, "Failed to initialize K90 backlight.\n");
-		}
-	}
-
-	return 0;
-}
-
-static void corsair_remove(struct hid_device *dev)
-{
-	k90_cleanup_macro_functions(dev);
-	k90_cleanup_backlight(dev);
-
-	hid_hw_stop(dev);
-}
-
-static int corsair_event(struct hid_device *dev, struct hid_field *fie=
ld,
-			 struct hid_usage *usage, __s32 value)
-{
-	struct corsair_drvdata *drvdata =3D hid_get_drvdata(dev);
-
-	if (!drvdata->k90)
-		return 0;
-
-	switch (usage->hid & HID_USAGE) {
-	case CORSAIR_USAGE_MACRO_RECORD_START:
-		drvdata->k90->record_led.brightness =3D 1;
-		break;
-	case CORSAIR_USAGE_MACRO_RECORD_STOP:
-		drvdata->k90->record_led.brightness =3D 0;
-		break;
-	default:
-		break;
-	}
-
-	return 0;
-}
-
 static int corsair_input_mapping(struct hid_device *dev,
 				 struct hid_input *input,
 				 struct hid_field *field,
@@ -641,9 +151,7 @@ static int corsair_input_mapping(struct hid_device =
*dev,
 }
=20
 static const struct hid_device_id corsair_devices[] =3D {
-	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_K90),
-		.driver_data =3D CORSAIR_USE_K90_MACRO |
-			       CORSAIR_USE_K90_BACKLIGHT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_K90) },
 	{}
 };
=20
@@ -652,9 +160,6 @@ MODULE_DEVICE_TABLE(hid, corsair_devices);
 static struct hid_driver corsair_driver =3D {
 	.name =3D "corsair",
 	.id_table =3D corsair_devices,
-	.probe =3D corsair_probe,
-	.event =3D corsair_event,
-	.remove =3D corsair_remove,
 	.input_mapping =3D corsair_input_mapping,
 };
=20
--=20
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
