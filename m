From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: [PATCH v2 5/6] hid: add GPO (leds) support to PicoLCD device
Date: Sat, 20 Mar 2010 17:10:23 +0100
Message-ID: <20100320171023.45d6e6e0@neptune.home>
References: <20100320170014.440959a8@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from legolas.restena.lu ([158.64.1.34]:47239 "EHLO
	legolas.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003Ab0CTQPL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Mar 2010 12:15:11 -0400
In-Reply-To: <20100320170014.440959a8@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Oliver Neukum <oliver@neukum.org>, Jaya Kumar <jayakumar.lkml@gmail.com>, Richard Purdie <rpurdie@rpsys.net>

Add leds support to PicoLCD device to drive the GPO pins.

GPO support depends on leds class and is only being
compiled if leds class has been selected.

Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
---
 drivers/hid/Kconfig       |    6 +-
 drivers/hid/hid-picolcd.c |  163 +++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 166 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index b01de6d..90caaf3 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -243,11 +243,11 @@ config HID_PICOLCD
 	  - Keypad
 	  - Switching between Firmware and Flash mode
 	  - Framebuffer for monochrome 256x64 display
-	  - Backlight control    (needs CONFIG_BACKLIGHT_CLASS_DEVICE)
-	  - Contrast control     (needs CONFIG_LCD_CLASS_DEVICE)
+	  - Backlight control         (needs CONFIG_BACKLIGHT_CLASS_DEVICE)
+	  - Contrast control          (needs CONFIG_LCD_CLASS_DEVICE)
+	  - General purpose outputs   (needs CONFIG_LEDS_CLASS)
 	  Features that are not (yet) supported:
 	  - IR
-	  - General purpose outputs
 	  - EEProm / Flash access
=20
 config HID_SAMSUNG
diff --git a/drivers/hid/hid-picolcd.c b/drivers/hid/hid-picolcd.c
index 88284ca..f3d057c 100644
--- a/drivers/hid/hid-picolcd.c
+++ b/drivers/hid/hid-picolcd.c
@@ -29,6 +29,8 @@
 #include <linux/backlight.h>
 #include <linux/lcd.h>
=20
+#include <linux/leds.h>
+
 #include <linux/seq_file.h>
 #include <linux/debugfs.h>
=20
@@ -193,6 +195,11 @@ struct picolcd_data {
 	u8 lcd_brightness;
 	u8 lcd_power;
 #endif /* CONFIG_BACKLIGHT_CLASS_DEVICE */
+#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
+	/* LED stuff */
+	u8 led_state;
+	struct led_classdev *led[8];
+#endif /* CONFIG_LEDS_CLASS */
=20
 	/* Housekeeping stuff */
 	spinlock_t lock;
@@ -869,6 +876,152 @@ static inline int picolcd_resume_lcd(struct picol=
cd_data *data)
 }
 #endif /* CONFIG_LCD_CLASS_DEVICE */
=20
+#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
+/**
+ * LED class device
+ */
+static void picolcd_leds_set(struct picolcd_data *data)
+{
+	struct hid_report *report;
+	unsigned long flags;
+
+	if (!data->led[0])
+		return;
+	report =3D picolcd_out_report(REPORT_LED_STATE, data->hdev);
+	if (!report || report->maxfield !=3D 1 || report->field[0]->report_co=
unt !=3D 1)
+		return;
+
+	spin_lock_irqsave(&data->lock, flags);
+	hid_set_field(report->field[0], 0, data->led_state);
+	usbhid_submit_report(data->hdev, report, USB_DIR_OUT);
+	spin_unlock_irqrestore(&data->lock, flags);
+}
+
+static void picolcd_led_set_brightness(struct led_classdev *led_cdev,
+			enum led_brightness value)
+{
+	struct device *dev;
+	struct hid_device *hdev;
+	struct picolcd_data *data;
+	int i, state =3D 0;
+
+	dev  =3D led_cdev->dev->parent;
+	hdev =3D container_of(dev, struct hid_device, dev);
+	data =3D hid_get_drvdata(hdev);
+	for (i =3D 0; i < 8; i++) {
+		if (led_cdev !=3D data->led[i])
+			continue;
+		state =3D (data->led_state >> i) & 1;
+		if (value =3D=3D LED_OFF && state) {
+			data->led_state &=3D ~(1 << i);
+			picolcd_leds_set(data);
+		} else if (value !=3D LED_OFF && !state) {
+			data->led_state |=3D 1 << i;
+			picolcd_leds_set(data);
+		}
+		break;
+	}
+}
+
+static enum led_brightness picolcd_led_get_brightness(struct led_class=
dev *led_cdev)
+{
+	struct device *dev;
+	struct hid_device *hdev;
+	struct picolcd_data *data;
+	int i, value =3D 0;
+
+	dev  =3D led_cdev->dev->parent;
+	hdev =3D container_of(dev, struct hid_device, dev);
+	data =3D hid_get_drvdata(hdev);
+	for (i =3D 0; i < 8; i++)
+		if (led_cdev =3D=3D data->led[i]) {
+			value =3D (data->led_state >> i) & 1;
+			break;
+		}
+	return value ? LED_FULL : LED_OFF;
+}
+
+static inline int picolcd_init_leds(struct picolcd_data *data, struct =
hid_report *report)
+{
+	struct device *dev =3D &data->hdev->dev;
+	struct led_classdev *led;
+	size_t name_sz =3D strlen(dev_name(dev)) + 8;
+	char *name;
+	int i, ret =3D 0;
+
+	if (!report)
+		return -ENODEV;
+	if (report->maxfield !=3D 1 || report->field[0]->report_count !=3D 1 =
||
+			report->field[0]->report_size !=3D 8) {
+		dev_err(dev, "unsupported LED_STATE report");
+		return -EINVAL;
+	}
+
+	for (i =3D 0; i < 8; i++) {
+		led =3D kzalloc(sizeof(struct led_classdev)+name_sz, GFP_KERNEL);
+		if (!led) {
+			dev_err(dev, "can't allocate memory for LED %d\n", i);
+			ret =3D -ENOMEM;
+			goto err;
+		}
+		name =3D (void *)(&led[1]);
+		snprintf(name, name_sz, "%s::GPO%d", dev_name(dev), i);
+		led->name =3D name;
+		led->brightness =3D 0;
+		led->max_brightness =3D 1;
+		led->brightness_get =3D picolcd_led_get_brightness;
+		led->brightness_set =3D picolcd_led_set_brightness;
+
+		data->led[i] =3D led;
+		ret =3D led_classdev_register(dev, data->led[i]);
+		if (ret) {
+			data->led[i] =3D NULL;
+			kfree(led);
+			dev_err(dev, "can't register LED %d\n", i);
+			goto err;
+		}
+	}
+	return 0;
+err:
+	for (i =3D 0; i < 8; i++)
+		if (data->led[i]) {
+			led =3D data->led[i];
+			data->led[i] =3D NULL;
+			led_classdev_unregister(led);
+			kfree(led);
+		}
+	return ret;
+}
+
+static void picolcd_exit_leds(struct picolcd_data *data)
+{
+	struct led_classdev *led;
+	int i;
+
+	for (i =3D 0; i < 8; i++) {
+		led =3D data->led[i];
+		data->led[i] =3D NULL;
+		if (!led)
+			continue;
+		led_classdev_unregister(led);
+		kfree(led);
+	}
+}
+
+#else
+static inline int picolcd_init_leds(struct picolcd_data *data, struct =
hid_report *report)
+{
+	return 0;
+}
+static void picolcd_exit_leds(struct picolcd_data *data)
+{
+}
+static inline int picolcd_leds_set(struct picolcd_data *data)
+{
+	return 0;
+}
+#endif /* CONFIG_LEDS_CLASS */
+
 /*
  * input class device
  */
@@ -995,6 +1148,7 @@ static int picolcd_reset(struct hid_device *hdev)
 		schedule_delayed_work(&data->fb_info->deferred_work, 0);
 #endif /* CONFIG_FB */
=20
+	picolcd_leds_set(data);
 	return 0;
 }
=20
@@ -1609,6 +1763,7 @@ static int picolcd_reset_resume(struct hid_device=
 *hdev)
 	ret =3D picolcd_resume_backlight(hid_get_drvdata(hdev));
 	if (ret)
 		dbg_hid(PICOLCD_NAME " restoring backlight failed: %d\n", ret);
+	picolcd_leds_set(hid_get_drvdata(hdev));
 	return 0;
 }
 #endif
@@ -1740,6 +1895,11 @@ static inline int picolcd_probe_lcd(struct hid_d=
evice *hdev, struct picolcd_data
 	if (error)
 		goto err;
=20
+	/* Setup the LED class devices */
+	error =3D picolcd_init_leds(data, picolcd_out_report(REPORT_LED_STATE=
, hdev));
+	if (error)
+		goto err;
+
 #ifdef CONFIG_DEBUG_FS
 	report =3D picolcd_out_report(REPORT_READ_MEMORY, hdev);
 	if (report && report->maxfield =3D=3D 1 && report->field[0]->report_s=
ize =3D=3D 8)
@@ -1749,6 +1909,7 @@ static inline int picolcd_probe_lcd(struct hid_de=
vice *hdev, struct picolcd_data
 #endif
 	return 0;
 err:
+	picolcd_exit_leds(data);
 	picolcd_exit_backlight(data);
 	picolcd_exit_lcd(data);
 	picolcd_exit_framebuffer(data);
@@ -1890,6 +2051,8 @@ static void picolcd_remove(struct hid_device *hde=
v)
 	hdev->ll_driver->close(hdev);
 	hid_hw_stop(hdev);
=20
+	/* Cleanup LED */
+	picolcd_exit_leds(data);
 	/* Clean up the framebuffer */
 	picolcd_exit_backlight(data);
 	picolcd_exit_lcd(data);
--=20
1.6.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
