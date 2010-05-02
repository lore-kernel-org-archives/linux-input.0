From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH 2/2] hid: add PM support to PicoLCD device
Date: Sun, 2 May 2010 16:05:05 +0200
Message-ID: <20100502160505.4acc9f1c@neptune.home>
References: <20100425214003.7e87c6a3@neptune.home>
	<20100425214306.5d7be049@neptune.home>
	<alpine.LNX.2.00.1004271525330.9849@pobox.suse.cz>
	<20100427221648.39735c41@neptune.home>
	<alpine.LNX.2.00.1004272256160.9849@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from legolas.restena.lu ([158.64.1.34]:33199 "EHLO
	legolas.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756150Ab0EBOFT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 May 2010 10:05:19 -0400
In-Reply-To: <alpine.LNX.2.00.1004272256160.9849@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Oliver Neukum <oliver@neukum.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Nicu Pavel <npavel@ituner.com>, Jaya Kumar <jayakumar.lkml@gmail.com>, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>

On Tue, 27 April 2010 Jiri Kosina <jkosina@suse.cz> wrote:
> > Yeah, I could drop the #else branch (of #ifconfig CONFIG_PM).
>=20
> Yup, please do so.
>=20
> > Is gcc quiet about defined but unused static inline functions?
>=20
> Yup, -Wunused-function doesn't warn about unused static inline functi=
on.

Ok, below is an updated patch, which also adds missing 'inline' keyword
for a few stubs and replaces #define f(a,b) to nothing with equivalent
stubs.
Is it ok to have all of this in a single patch or is it better to split
it into two (one for PM and one for cleaning up)?

Thanks,
Bruno


---
Add PM support in order to turn off backlight on suspend, restore
it on resume and especially restore complete state on reset-resume.

v2:
  Don't define stub to nothing but use static inline stubs
  Don't define picolcd_suspend_backlight() at all in !CONFIG_PM case

Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
---
 drivers/hid/hid-picolcd.c |   79 +++++++++++++++++++++++++++++++++++++=
+++++---
 1 files changed, 74 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-picolcd.c b/drivers/hid/hid-picolcd.c
index aa6f2e1..95253b3 100644
--- a/drivers/hid/hid-picolcd.c
+++ b/drivers/hid/hid-picolcd.c
@@ -763,7 +763,7 @@ static inline int picolcd_init_framebuffer(struct p=
icolcd_data *data)
 {
 	return 0;
 }
-static void picolcd_exit_framebuffer(struct picolcd_data *data)
+static inline void picolcd_exit_framebuffer(struct picolcd_data *data)
 {
 }
 #define picolcd_fbinfo(d) NULL
@@ -852,6 +852,18 @@ static inline int picolcd_resume_backlight(struct =
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
+#endif /* CONFIG_PM */
 #else
 static inline int picolcd_init_backlight(struct picolcd_data *data,
 		struct hid_report *report)
@@ -865,6 +877,9 @@ static inline int picolcd_resume_backlight(struct p=
icolcd_data *data)
 {
 	return 0;
 }
+static inline void picolcd_suspend_backlight(struct picolcd_data *data=
)
+{
+}
 #endif /* CONFIG_HID_PICOLCD_BACKLIGHT */
=20
 #ifdef CONFIG_HID_PICOLCD_LCD
@@ -1098,7 +1113,7 @@ static inline int picolcd_init_leds(struct picolc=
d_data *data,
 {
 	return 0;
 }
-static void picolcd_exit_leds(struct picolcd_data *data)
+static inline void picolcd_exit_leds(struct picolcd_data *data)
 {
 }
 static inline int picolcd_leds_set(struct picolcd_data *data)
@@ -2214,9 +2229,18 @@ static void picolcd_exit_devfs(struct picolcd_da=
ta *data)
 	mutex_destroy(&data->mutex_flash);
 }
 #else
-#define picolcd_debug_raw_event(data, hdev, report, raw_data, size)
-#define picolcd_init_devfs(data, eeprom_r, eeprom_w, flash_r, flash_w,=
 reset)
-static void picolcd_exit_devfs(struct picolcd_data *data)
+static inline void picolcd_debug_raw_event(struct picolcd_data *data,
+		struct hid_device *hdev, struct hid_report *report,
+		u8 *raw_data, int size)
+{
+}
+static inline void picolcd_init_devfs(struct picolcd_data *data,
+		struct hid_report *eeprom_r, struct hid_report *eeprom_w,
+		struct hid_report *flash_r, struct hid_report *flash_w,
+		struct hid_report *reset)
+{
+}
+static inline void picolcd_exit_devfs(struct picolcd_data *data)
 {
 }
 #endif /* CONFIG_DEBUG_FS */
@@ -2259,6 +2283,46 @@ static int picolcd_raw_event(struct hid_device *=
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
@@ -2544,6 +2608,11 @@ static struct hid_driver picolcd_driver =3D {
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

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
