From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: [PATCH 2/2] hid: add PM support to PicoLCD device
Date: Sun, 25 Apr 2010 21:43:06 +0200
Message-ID: <20100425214306.5d7be049@neptune.home>
References: <20100425214003.7e87c6a3@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100425214003.7e87c6a3@neptune.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>, Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Nicu Pavel <npavel@ituner.com>, Jaya Kumar <jayakumar.lkml@gmail.com>, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>
List-Id: linux-input@vger.kernel.org

Add PM support in order to turn off backlight on suspend, restore
it on resume and especially restore complete state on reset-resume.

Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
---
 drivers/hid/hid-picolcd.c |   61 +++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-picolcd.c b/drivers/hid/hid-picolcd.c
index aa6f2e1..c652390 100644
--- a/drivers/hid/hid-picolcd.c
+++ b/drivers/hid/hid-picolcd.c
@@ -852,6 +852,20 @@ static inline int picolcd_resume_backlight(struct =
picolcd_data *data)
 	return picolcd_set_brightness(data->backlight);
 }
=20
+#ifdef CONFIG_PM
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
+#define picolcd_suspend_backlight(a)
+#endif /* CONFIG_PM */
 #else
 static inline int picolcd_init_backlight(struct picolcd_data *data,
 		struct hid_report *report)
@@ -865,6 +879,7 @@ static inline int picolcd_resume_backlight(struct p=
icolcd_data *data)
 {
 	return 0;
 }
+#define picolcd_suspend_backlight(a)
 #endif /* CONFIG_HID_PICOLCD_BACKLIGHT */
=20
 #ifdef CONFIG_HID_PICOLCD_LCD
@@ -2259,6 +2274,46 @@ static int picolcd_raw_event(struct hid_device *=
hdev,
 	return 1;
 }
=20
+#ifdef CONFIG_PM
+static int picolcd_suspend(struct hid_device *hdev, pm_message_t messa=
ge)
+{
+	if (message.event & PM_EVENT_AUTO)
+		return 0;
+
+	picolcd_suspend_backlight(hid_get_drvdata(hdev));
+	dbg_hid(PICOLCD_NAME " device ready for suspend\n");
+	return 0;
+}
+
+static int picolcd_resume(struct hid_device *hdev)
+{
+	int ret;
+	ret =3D picolcd_resume_backlight(hid_get_drvdata(hdev));
+	if (ret)
+		dbg_hid(PICOLCD_NAME " restoring backlight failed: %d\n", ret);
+	return 0;
+}
+
+static int picolcd_reset_resume(struct hid_device *hdev)
+{
+	int ret;
+	ret =3D picolcd_reset(hdev);
+	if (ret)
+		dbg_hid(PICOLCD_NAME " resetting our device failed: %d\n", ret);
+	ret =3D picolcd_fb_reset(hid_get_drvdata(hdev), 0);
+	if (ret)
+		dbg_hid(PICOLCD_NAME " restoring framebuffer content failed: %d\n", =
ret);
+	ret =3D picolcd_resume_lcd(hid_get_drvdata(hdev));
+	if (ret)
+		dbg_hid(PICOLCD_NAME " restoring lcd failed: %d\n", ret);
+	ret =3D picolcd_resume_backlight(hid_get_drvdata(hdev));
+	if (ret)
+		dbg_hid(PICOLCD_NAME " restoring backlight failed: %d\n", ret);
+	picolcd_leds_set(hid_get_drvdata(hdev));
+	return 0;
+}
+#endif
+
 /* initialize keypad input device */
 static int picolcd_init_keys(struct picolcd_data *data,
 		struct hid_report *report)
@@ -2544,6 +2599,11 @@ static struct hid_driver picolcd_driver =3D {
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
--=20
1.6.4.4
