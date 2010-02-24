From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
Subject: [PATCH 3/3] hid-picolcd: make use of new suspend/resume hooks
Date: Wed, 24 Feb 2010 17:01:25 +0100
Message-ID: <20100224170125.65f8bdfc@neptune.home>
References: <20100221002001.0a7e05a7@neptune.home>
 <20100224163101.3622d69f@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100224163101.3622d69f-hY15tx4IgV39zxVx7UNMDg@public.gmane.org>
References: <20100224170049.0d04af3c-hY15tx4IgV39zxVx7UNMDg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rick L. Vinyard Jr." <rvinyard-qcTL/1vZYtiVc3sceRu5cw@public.gmane.org>, Nicu Pavel <npavel-VxACSXvuqMTQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Make use of new suspend/resume hooks to disable backlight on suspend
and restore backlight on simple resume or backlight, contrast and
framebuffer content on reset-resume.

Signed-off-by: Bruno Pr=C3=A9mont <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
Cc: Nicu Pavel <npavel-VxACSXvuqMTQT0dZR+AlfA@public.gmane.org>
---
 drivers/hid/hid-picolcd.c           |   45 +++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-picolcd.c b/drivers/hid/hid-picolcd.c
index e69de29..90f6be5 100644
--- a/drivers/hid/hid-picolcd.c
+++ b/drivers/hid/hid-picolcd.c
@@ -833,6 +833,46 @@
 };
=20
=20
+#ifdef CONFIG_PM
+static int picolcd_suspend(struct hid_device *hdev)
+{
+	struct picolcd_data *data =3D hid_get_drvdata(hdev);
+	int bl_power =3D data->lcd_power;
+
+	data->backlight->props.power =3D FB_BLANK_POWERDOWN;
+	picolcd_set_brightness(data->backlight);
+	data->lcd_power =3D data->backlight->props.power =3D bl_power;
+	dbg_hid(PICOLCD_NAME " device ready for suspend, lcd_power=3D%d\n", b=
l_power);
+	return 0;
+}
+
+static int picolcd_resume(struct hid_device *hdev)
+{
+	struct picolcd_data *data =3D hid_get_drvdata(hdev);
+	int ret;
+	ret =3D picolcd_set_brightness(data->backlight);
+	if (ret)
+		dbg_hid(PICOLCD_NAME " restoring brightness failed: %d\n", ret);
+	ret =3D picolcd_set_contrast(data->lcd, data->lcd_contrast);
+	if (ret)
+		dbg_hid(PICOLCD_NAME " restoring contrast failed: %d\n", ret);
+	return 0;
+}
+
+static int picolcd_reset_resume(struct hid_device *hdev)
+{
+	int ret;
+	ret =3D picolcd_reset(hdev);
+	if (ret)
+		dbg_hid(PICOLCD_NAME " resetting our device failed: %d\n", ret);
+	ret =3D picolcd_fb_reset(hdev, 0);
+	if (ret)
+		dbg_hid(PICOLCD_NAME " restoring framebuffer content failed: %d\n", =
ret);
+	return 0;
+}
+#endif
+
+
 static int picolcd_probe(struct hid_device *hdev,
 		     const struct hid_device_id *id)
 {
@@ -1057,6 +1097,11 @@
 	.probe =3D         picolcd_probe,
 	.remove =3D        picolcd_remove,
 	.raw_event =3D     picolcd_raw_event,
+#ifdef CONFIG_PM
+	.suspend =3D       picolcd_suspend,
+	.resume =3D        picolcd_resume,
+	.reset_resume =3D  picolcd_reset_resume,
+#endif
 };
=20
 static int __init picolcd_init(void)
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
