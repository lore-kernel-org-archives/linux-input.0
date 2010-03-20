From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: [PATCH v2 4/6] hid: add lcd support to PicoLCD device
Date: Sat, 20 Mar 2010 17:08:10 +0100
Message-ID: <20100320170810.60539df3@neptune.home>
References: <20100320170014.440959a8@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100320170014.440959a8@neptune.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Oliver Neukum <oliver@neukum.org>, Jaya Kumar <jayakumar.lkml@gmail.com>
List-Id: linux-input@vger.kernel.org

Add lcd support to PicoLCD device.

LCD support depends on lcd class and is only being
compiled if lcd class has been selected.

Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
---
 drivers/hid/Kconfig       |    2 +-
 drivers/hid/hid-picolcd.c |  108 +++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 109 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 5ec3cb7..b01de6d 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -244,8 +244,8 @@ config HID_PICOLCD
 	  - Switching between Firmware and Flash mode
 	  - Framebuffer for monochrome 256x64 display
 	  - Backlight control    (needs CONFIG_BACKLIGHT_CLASS_DEVICE)
+	  - Contrast control     (needs CONFIG_LCD_CLASS_DEVICE)
 	  Features that are not (yet) supported:
-	  - Contrast control
 	  - IR
 	  - General purpose outputs
 	  - EEProm / Flash access
diff --git a/drivers/hid/hid-picolcd.c b/drivers/hid/hid-picolcd.c
index 06cf099..88284ca 100644
--- a/drivers/hid/hid-picolcd.c
+++ b/drivers/hid/hid-picolcd.c
@@ -27,6 +27,7 @@
 #include <linux/fb.h>
 #include <linux/vmalloc.h>
 #include <linux/backlight.h>
+#include <linux/lcd.h>
=20
 #include <linux/seq_file.h>
 #include <linux/debugfs.h>
@@ -183,6 +184,10 @@ struct picolcd_data {
 	struct fb_info *fb_info;
 	struct fb_deferred_io fb_defio;
 #endif /* CONFIG_FB */
+#if defined(CONFIG_LCD_CLASS_DEVICE) || defined(CONFIG_LCD_CLASS_DEVIC=
E_MODULE)
+	struct lcd_device *lcd;
+	u8 lcd_contrast;
+#endif
 #if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT=
_CLASS_DEVICE_MODULE)
 	struct backlight_device *backlight;
 	u8 lcd_brightness;
@@ -772,6 +777,98 @@ static void picolcd_suspend_backlight(struct picol=
cd_data *data)
 }
 #endif /* CONFIG_BACKLIGHT_CLASS_DEVICE */
=20
+#if defined(CONFIG_LCD_CLASS_DEVICE) || defined(CONFIG_LCD_CLASS_DEVIC=
E_MODULE)
+/*
+ * lcd class device
+ */
+static int picolcd_get_contrast(struct lcd_device *ldev)
+{
+	struct picolcd_data *data =3D lcd_get_data(ldev);
+	return data->lcd_contrast;
+}
+
+static int picolcd_set_contrast(struct lcd_device *ldev, int contrast)
+{
+	struct picolcd_data *data =3D lcd_get_data(ldev);
+	struct hid_report *report =3D picolcd_out_report(REPORT_CONTRAST, dat=
a->hdev);
+	unsigned long flags;
+
+	if (!report || report->maxfield !=3D 1 || report->field[0]->report_co=
unt !=3D 1)
+		return -ENODEV;
+
+	data->lcd_contrast =3D contrast & 0x0ff;
+	spin_lock_irqsave(&data->lock, flags);
+	hid_set_field(report->field[0], 0, data->lcd_contrast);
+	usbhid_submit_report(data->hdev, report, USB_DIR_OUT);
+	spin_unlock_irqrestore(&data->lock, flags);
+	return 0;
+}
+
+static int picolcd_check_lcd_fb(struct lcd_device *ldev, struct fb_inf=
o *fb)
+{
+	return fb && fb =3D=3D picolcd_fbinfo((struct picolcd_data *)lcd_get_=
data(ldev));
+}
+
+static struct lcd_ops picolcd_lcdops =3D {
+	.get_contrast   =3D picolcd_get_contrast,
+	.set_contrast   =3D picolcd_set_contrast,
+	.check_fb       =3D picolcd_check_lcd_fb,
+};
+
+static inline int picolcd_init_lcd(struct picolcd_data *data, struct h=
id_report *report)
+{
+	struct device *dev =3D &data->hdev->dev;
+	struct lcd_device *ldev;
+
+	if (!report)
+		return -ENODEV;
+	if (report->maxfield !=3D 1 || report->field[0]->report_count !=3D 1 =
||
+			report->field[0]->report_size !=3D 8) {
+		dev_err(dev, "unsupported CONTRAST report");
+		return -EINVAL;
+	}
+
+	ldev =3D lcd_device_register(dev_name(dev), dev, data, &picolcd_lcdop=
s);
+	if (IS_ERR(ldev)) {
+		dev_err(dev, "failed to register LCD\n");
+		return PTR_ERR(ldev);
+	}
+	ldev->props.max_contrast =3D 0x0ff;
+	data->lcd_contrast =3D 0xe5;
+	data->lcd =3D ldev;
+	picolcd_set_contrast(ldev, 0xe5);
+	return 0;
+}
+
+static void picolcd_exit_lcd(struct picolcd_data *data)
+{
+	struct lcd_device *ldev =3D data->lcd;
+
+	data->lcd =3D NULL;
+	if (ldev)
+		lcd_device_unregister(ldev);
+}
+
+static inline int picolcd_resume_lcd(struct picolcd_data *data)
+{
+	if (!data->lcd)
+		return 0;
+	return picolcd_set_contrast(data->lcd, data->lcd_contrast);
+}
+#else
+static inline int picolcd_init_lcd(struct picolcd_data *data, struct h=
id_report *report)
+{
+	return 0;
+}
+static inline void picolcd_exit_lcd(struct picolcd_data *data)
+{
+}
+static inline int picolcd_resume_lcd(struct picolcd_data *data)
+{
+	return 0;
+}
+#endif /* CONFIG_LCD_CLASS_DEVICE */
+
 /*
  * input class device
  */
@@ -891,6 +988,7 @@ static int picolcd_reset(struct hid_device *hdev)
 		return -EBUSY;
 	}
=20
+	picolcd_resume_lcd(data);
 	picolcd_resume_backlight(data);
 #if defined(CONFIG_FB) || defined(CONFIG_FB_MODULE)
 	if (data->fb_info)
@@ -1505,6 +1603,9 @@ static int picolcd_reset_resume(struct hid_device=
 *hdev)
 	ret =3D picolcd_fb_reset(hid_get_drvdata(hdev), 0);
 	if (ret)
 		dbg_hid(PICOLCD_NAME " restoring framebuffer content failed: %d\n", =
ret);
+	ret =3D picolcd_resume_lcd(hid_get_drvdata(hdev));
+	if (ret)
+		dbg_hid(PICOLCD_NAME " restoring lcd failed: %d\n", ret);
 	ret =3D picolcd_resume_backlight(hid_get_drvdata(hdev));
 	if (ret)
 		dbg_hid(PICOLCD_NAME " restoring backlight failed: %d\n", ret);
@@ -1629,6 +1730,11 @@ static inline int picolcd_probe_lcd(struct hid_d=
evice *hdev, struct picolcd_data
 	if (error)
 		goto err;
=20
+	/* Setup lcd class device */
+	error =3D picolcd_init_lcd(data, picolcd_out_report(REPORT_CONTRAST, =
hdev));
+	if (error)
+		goto err;
+
 	/* Setup backlight class device */
 	error =3D picolcd_init_backlight(data, picolcd_out_report(REPORT_BRIG=
HTNESS, hdev));
 	if (error)
@@ -1644,6 +1750,7 @@ static inline int picolcd_probe_lcd(struct hid_de=
vice *hdev, struct picolcd_data
 	return 0;
 err:
 	picolcd_exit_backlight(data);
+	picolcd_exit_lcd(data);
 	picolcd_exit_framebuffer(data);
 	picolcd_exit_cir(data);
 	picolcd_exit_keys(data);
@@ -1785,6 +1892,7 @@ static void picolcd_remove(struct hid_device *hde=
v)
=20
 	/* Clean up the framebuffer */
 	picolcd_exit_backlight(data);
+	picolcd_exit_lcd(data);
 	picolcd_exit_framebuffer(data);
 	/* Cleanup input */
 	picolcd_exit_cir(data);
--=20
1.6.4.4
