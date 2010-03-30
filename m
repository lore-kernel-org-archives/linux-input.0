From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
Subject: [PATCH v6 3/8] hid: add backlight support to PicoLCD device
Date: Tue, 30 Mar 2010 22:35:27 +0200
Message-ID: <20100330223527.48315e0e@neptune.home>
References: <20100324233707.7243b04d@neptune.home>
	<20100324234022.0361bd80@neptune.home>
	<20100326065656.GC26602@core.coreip.homeip.net>
	<20100326102951.3b9ecda1@neptune.home>
	<alpine.LNX.2.00.1003262156280.24576@pobox.suse.cz>
	<20100327012245.0ace6a09@neptune.home>
	<alpine.LNX.2.00.1003291144350.24576@pobox.suse.cz>
	<20100329121611.0c22dcaf@pluto.restena.lu>
	<alpine.LNX.2.00.1003301010410.24576@pobox.suse.cz>
	<20100330223224.18fe4f3e@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100330223224.18fe4f3e-hY15tx4IgV39zxVx7UNMDg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rick L. Vinyard Jr." <rvinyard-qcTL/1vZYtiVc3sceRu5cw@public.gmane.org>, Nicu Pavel <npavel-VxACSXvuqMTQT0dZR+AlfA@public.gmane.org>, Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, Jaya Kumar <jayakumar.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Add backlight support to PicoLCD device.

Backlight support depends on backlight class and is only being
compiled if backlight class has been selected.

Changes since v3:
 - Moved PM support to separate patch
Changes since v2:
 - Drop inline keyword on non-stub functions

Signed-off-by: Bruno Pr=C3=A9mont <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
---
 drivers/hid/Kconfig       |    2 +-
 drivers/hid/hid-picolcd.c |  128 +++++++++++++++++++++++++++++++++++++=
+++++++-
 2 files changed, 128 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index a813ea9..588b9ac 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -278,8 +278,8 @@ config HID_PICOLCD
 	  - Keypad
 	  - Switching between Firmware and Flash mode
 	  - Framebuffer for monochrome 256x64 display
+	  - Backlight control    (needs CONFIG_BACKLIGHT_CLASS_DEVICE)
 	  Features that are not (yet) supported:
-	  - Backlight control
 	  - Contrast control
 	  - IR
 	  - General purpose outputs
diff --git a/drivers/hid/hid-picolcd.c b/drivers/hid/hid-picolcd.c
index 0fa3ca3..4d5fc2d 100644
--- a/drivers/hid/hid-picolcd.c
+++ b/drivers/hid/hid-picolcd.c
@@ -26,6 +26,7 @@
=20
 #include <linux/fb.h>
 #include <linux/vmalloc.h>
+#include <linux/backlight.h>
=20
 #include <linux/seq_file.h>
 #include <linux/debugfs.h>
@@ -183,6 +184,11 @@ struct picolcd_data {
 	struct fb_info *fb_info;
 	struct fb_deferred_io fb_defio;
 #endif /* CONFIG_FB */
+#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT=
_CLASS_DEVICE_MODULE)
+	struct backlight_device *backlight;
+	u8 lcd_brightness;
+	u8 lcd_power;
+#endif /* CONFIG_BACKLIGHT_CLASS_DEVICE */
=20
 	/* Housekeeping stuff */
 	spinlock_t lock;
@@ -729,7 +735,7 @@ static void picolcd_exit_framebuffer(struct picolcd=
_data *data)
 	kfree(fb_vbitmap);
 }
=20
-
+#define picolcd_fbinfo(d) ((d)->fb_info)
 #else
 static inline int picolcd_fb_reset(struct picolcd_data *data, int clea=
r)
 {
@@ -742,8 +748,120 @@ static inline int picolcd_init_framebuffer(struct=
 picolcd_data *data)
 static void picolcd_exit_framebuffer(struct picolcd_data *data)
 {
 }
+#define picolcd_fbinfo(d) NULL
 #endif /* CONFIG_FB */
=20
+#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT=
_CLASS_DEVICE_MODULE)
+/*
+ * backlight class device
+ */
+static int picolcd_get_brightness(struct backlight_device *bdev)
+{
+	struct picolcd_data *data =3D bl_get_data(bdev);
+	return data->lcd_brightness;
+}
+
+static int picolcd_set_brightness(struct backlight_device *bdev)
+{
+	struct picolcd_data *data =3D bl_get_data(bdev);
+	struct hid_report *report =3D picolcd_out_report(REPORT_BRIGHTNESS, d=
ata->hdev);
+	unsigned long flags;
+
+	if (!report || report->maxfield !=3D 1 || report->field[0]->report_co=
unt !=3D 1)
+		return -ENODEV;
+
+	data->lcd_brightness =3D bdev->props.brightness & 0x0ff;
+	data->lcd_power      =3D bdev->props.power;
+	spin_lock_irqsave(&data->lock, flags);
+	hid_set_field(report->field[0], 0, data->lcd_power =3D=3D FB_BLANK_UN=
BLANK ? data->lcd_brightness : 0);
+	usbhid_submit_report(data->hdev, report, USB_DIR_OUT);
+	spin_unlock_irqrestore(&data->lock, flags);
+	return 0;
+}
+
+static int picolcd_check_bl_fb(struct backlight_device *bdev, struct f=
b_info *fb)
+{
+	return fb && fb =3D=3D picolcd_fbinfo((struct picolcd_data *)bl_get_d=
ata(bdev));
+}
+
+static const struct backlight_ops picolcd_blops =3D {
+	.update_status  =3D picolcd_set_brightness,
+	.get_brightness =3D picolcd_get_brightness,
+	.check_fb       =3D picolcd_check_bl_fb,
+};
+
+static int picolcd_init_backlight(struct picolcd_data *data, struct hi=
d_report *report)
+{
+	struct device *dev =3D &data->hdev->dev;
+	struct backlight_device *bdev;
+	struct backlight_properties props;
+	if (!report)
+		return -ENODEV;
+	if (report->maxfield !=3D 1 || report->field[0]->report_count !=3D 1 =
||
+			report->field[0]->report_size !=3D 8) {
+		dev_err(dev, "unsupported BRIGHTNESS report");
+		return -EINVAL;
+	}
+
+	memset(&props, 0, sizeof(props));
+	props.max_brightness =3D 0xff;
+	bdev =3D backlight_device_register(dev_name(dev), dev, data,
+			&picolcd_blops, &props);
+	if (IS_ERR(bdev)) {
+		dev_err(dev, "failed to register backlight\n");
+		return PTR_ERR(bdev);
+	}
+	bdev->props.brightness     =3D 0xff;
+	data->lcd_brightness       =3D 0xff;
+	data->backlight            =3D bdev;
+	picolcd_set_brightness(bdev);
+	return 0;
+}
+
+static void picolcd_exit_backlight(struct picolcd_data *data)
+{
+	struct backlight_device *bdev =3D data->backlight;
+
+	data->backlight =3D NULL;
+	if (bdev)
+		backlight_device_unregister(bdev);
+}
+
+static inline int picolcd_resume_backlight(struct picolcd_data *data)
+{
+	if (!data->backlight)
+		return 0;
+	return picolcd_set_brightness(data->backlight);
+}
+
+static void picolcd_suspend_backlight(struct picolcd_data *data)
+{
+	int bl_power =3D data->lcd_power;
+	if (!data->backlight)
+		return;
+
+	data->backlight->props.power =3D FB_BLANK_POWERDOWN;
+	picolcd_set_brightness(data->backlight);
+	data->lcd_power =3D data->backlight->props.power =3D bl_power;
+}
+#else
+static inline int picolcd_init_backlight(struct picolcd_data *data,
+		struct hid_report *report)
+{
+	return 0;
+}
+static inline void picolcd_exit_backlight(struct picolcd_data *data)
+{
+}
+static inline int picolcd_resume_backlight(struct picolcd_data *data)
+{
+	return 0;
+}
+static void picolcd_suspend_backlight(struct picolcd_data *data)
+{
+}
+#endif /* CONFIG_BACKLIGHT_CLASS_DEVICE */
+
 /*
  * input class device
  */
@@ -879,6 +997,7 @@ static int picolcd_reset(struct hid_device *hdev)
 	if (error)
 		return error;
=20
+	picolcd_resume_backlight(data);
 #if defined(CONFIG_FB) || defined(CONFIG_FB_MODULE)
 	if (data->fb_info)
 		schedule_delayed_work(&data->fb_info->deferred_work, 0);
@@ -1567,6 +1686,11 @@ static int picolcd_probe_lcd(struct hid_device *=
hdev, struct picolcd_data *data)
 	if (error)
 		goto err;
=20
+	/* Setup backlight class device */
+	error =3D picolcd_init_backlight(data, picolcd_out_report(REPORT_BRIG=
HTNESS, hdev));
+	if (error)
+		goto err;
+
 #ifdef CONFIG_DEBUG_FS
 	report =3D picolcd_out_report(REPORT_READ_MEMORY, hdev);
 	if (report && report->maxfield =3D=3D 1 && report->field[0]->report_s=
ize =3D=3D 8)
@@ -1576,6 +1700,7 @@ static int picolcd_probe_lcd(struct hid_device *h=
dev, struct picolcd_data *data)
 #endif
 	return 0;
 err:
+	picolcd_exit_backlight(data);
 	picolcd_exit_framebuffer(data);
 	picolcd_exit_cir(data);
 	picolcd_exit_keys(data);
@@ -1707,6 +1832,7 @@ static void picolcd_remove(struct hid_device *hde=
v)
 	spin_unlock_irqrestore(&data->lock, flags);
=20
 	/* Clean up the framebuffer */
+	picolcd_exit_backlight(data);
 	picolcd_exit_framebuffer(data);
 	/* Cleanup input */
 	picolcd_exit_cir(data);
--=20
1.6.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
