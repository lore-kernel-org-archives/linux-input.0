From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH mmotm] hid-picolcd: depends on LCD_CLASS_DEVICE
Date: Sun, 11 Apr 2010 12:17:45 +0200
Message-ID: <20100411121745.6a500755@neptune.home>
References: <201004052336.o35NaeSE015814@imap1.linux-foundation.org>
	<20100405220414.9d90da83.randy.dunlap@oracle.com>
	<alpine.LNX.2.00.1004061038510.8345@pobox.suse.cz>
	<20100406105635.5384a087@pluto.restena.lu>
	<20100406082614.79aaf1c5.randy.dunlap@oracle.com>
	<20100406183535.7de3c628@neptune.home>
	<20100406095633.49ec957a.randy.dunlap@oracle.com>
	<20100406230434.1336c317@neptune.home>
	<20100407092010.4cd60ece.randy.dunlap@oracle.com>
	<20100407203132.7fe2d0f1@neptune.home>
	<alpine.LNX.2.00.1004081441460.8345@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from legolas.restena.lu ([158.64.1.34]:49468 "EHLO
	legolas.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770Ab0DKKR7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 11 Apr 2010 06:17:59 -0400
In-Reply-To: <alpine.LNX.2.00.1004081441460.8345@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, rvinyard@cs.nmsu.edu

HID_PICOLCD should depend on LCD_CLASS_DEVICE, otherwise the
build fails when HID_PICOLCD=3Dy and LCD_CLASS_DEVICE=3Dm:

hid-picolcd.c:(.text+0x84523f): undefined reference to `lcd_device_unre=
gister'
hid-picolcd.c:(.text+0x8478ab): undefined reference to `lcd_device_regi=
ster'
hid-picolcd.c:(.text+0x84c15f): undefined reference to `lcd_device_unre=
gister'

Same applies to FB, BACKLIGHT_CLASS_DEVICE and LEDS_CLASS.

Add suboptions for those features to handle the deps on kbuild side
and just check HID_PICOLCD_* in the code.

Reported-by: Randy Dunlap <randy.dunlap@oracle.com>
Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
---

On Thu, 08 April 2010 Jiri Kosina <jkosina@suse.cz> wrote:
> > +config HID_PICOLCD_FB
> > +	bool "Framebuffer support"
> > +	default !EMBEDDED
> > +	depends on HID_PICOLCD
> > +	depends on HID_PICOLCD=3DFB || FB=3Dy
> > +	select FB_DEFERRED_IO
> > +	select FB_SYS_FILLRECT
> > +	select FB_SYS_COPYAREA
> > +	select FB_SYS_IMAGEBLIT
> > +	select FB_SYS_FOPS
>=20
> Could we perhaps also make the sub-choices for individual features=20
> availabel only if !EMBEDDED as well?

Here is an updated patch to make the sub-choices visible only in
EMBEDDED case.

Thanks,
Bruno



 drivers/hid/Kconfig       |   53 +++++++++++++++++++++++++++++++++++++=
-------
 drivers/hid/hid-picolcd.c |   40 +++++++++++++++++-----------------
 2 files changed, 64 insertions(+), 29 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index a2ecd83..621c52c 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -265,11 +265,6 @@ config HID_PETALYNX
 config HID_PICOLCD
 	tristate "PicoLCD (graphic version)"
 	depends on USB_HID
-	select FB_DEFERRED_IO if FB
-	select FB_SYS_FILLRECT if FB
-	select FB_SYS_COPYAREA if FB
-	select FB_SYS_IMAGEBLIT if FB
-	select FB_SYS_FOPS if FB
 	---help---
 	  This provides support for Minibox PicoLCD devices, currently
 	  only the graphical ones are supported.
@@ -277,14 +272,54 @@ config HID_PICOLCD
 	  This includes support for the following device features:
 	  - Keypad
 	  - Switching between Firmware and Flash mode
-	  - Framebuffer for monochrome 256x64 display
-	  - Backlight control         (needs CONFIG_BACKLIGHT_CLASS_DEVICE)
-	  - Contrast control          (needs CONFIG_LCD_CLASS_DEVICE)
-	  - General purpose outputs   (needs CONFIG_LEDS_CLASS)
 	  - EEProm / Flash access     (via debugfs)
+	  Features selectively enabled:
+	  - Framebuffer for monochrome 256x64 display
+	  - Backlight control
+	  - Contrast control
+	  - General purpose outputs
 	  Features that are not (yet) supported:
 	  - IR
=20
+config HID_PICOLCD_FB
+	bool "Framebuffer support" if EMBEDDED
+	default !EMBEDDED
+	depends on HID_PICOLCD
+	depends on HID_PICOLCD=3DFB || FB=3Dy
+	select FB_DEFERRED_IO
+	select FB_SYS_FILLRECT
+	select FB_SYS_COPYAREA
+	select FB_SYS_IMAGEBLIT
+	select FB_SYS_FOPS
+	---help---
+	  Provide access to PicoLCD's 256x64 monochrome display via a
+	  frambuffer device.
+
+config HID_PICOLCD_BACKLIGHT
+	bool "Backlight control" if EMBEDDED
+	default !EMBEDDED
+	depends on HID_PICOLCD
+	depends on HID_PICOLCD=3DBACKLIGHT_CLASS_DEVICE || BACKLIGHT_CLASS_DE=
VICE=3Dy
+	---help---
+	  Provide access to PicoLCD's backlight control via backlight
+	  class.
+
+config HID_PICOLCD_LCD
+	bool "Contrast control" if EMBEDDED
+	default !EMBEDDED
+	depends on HID_PICOLCD
+	depends on HID_PICOLCD=3DLCD_CLASS_DEVICE || LCD_CLASS_DEVICE=3Dy
+	---help---
+	  Provide access to PicoLCD's LCD contrast via lcd class.
+
+config HID_PICOLCD_LEDS
+	bool "GPO via leds class" if EMBEDDED
+	default !EMBEDDED
+	depends on HID_PICOLCD
+	depends on HID_PICOLCD=3DLEDS_CLASS || LEDS_CLASS=3Dy
+	---help---
+	  Provide access to PicoLCD's GPO pins via leds class.
+
 config HID_QUANTA
 	tristate "Quanta Optical Touch"
 	depends on USB_HID
diff --git a/drivers/hid/hid-picolcd.c b/drivers/hid/hid-picolcd.c
index 0eacc6b..0fbc7d3 100644
--- a/drivers/hid/hid-picolcd.c
+++ b/drivers/hid/hid-picolcd.c
@@ -77,7 +77,7 @@
 #define REPORT_HOOK_VERSION    0xf7 /* LCD: IN[2], OUT[1]   */
 #define REPORT_EXIT_FLASHER    0xff /*                      Bootloader=
: OUT[2]         */
=20
-#if defined(CONFIG_FB) || defined(CONFIG_FB_MODULE)
+#ifdef CONFIG_HID_PICOLCD_FB
 /* Framebuffer
  *
  * The PicoLCD use a Topway LCD module of 256x64 pixel
@@ -128,7 +128,7 @@ static const struct fb_var_screeninfo picolcdfb_var=
 =3D {
 	.bits_per_pixel =3D 1,
 	.grayscale      =3D 1,
 };
-#endif /* CONFIG_FB */
+#endif /* CONFIG_HID_PICOLCD_FB */
=20
 /* Input device
  *
@@ -183,7 +183,7 @@ struct picolcd_data {
 	struct input_dev *input_cir;
 	unsigned short keycode[PICOLCD_KEYS];
=20
-#if defined(CONFIG_FB) || defined(CONFIG_FB_MODULE)
+#ifdef CONFIG_HID_PICOLCD_FB
 	/* Framebuffer stuff */
 	u8 fb_update_rate;
 	u8 fb_bpp;
@@ -191,21 +191,21 @@ struct picolcd_data {
 	u8 *fb_bitmap;		/* framebuffer */
 	struct fb_info *fb_info;
 	struct fb_deferred_io fb_defio;
-#endif /* CONFIG_FB */
-#if defined(CONFIG_LCD_CLASS_DEVICE) || defined(CONFIG_LCD_CLASS_DEVIC=
E_MODULE)
+#endif /* CONFIG_HID_PICOLCD_FB */
+#ifdef CONFIG_HID_PICOLCD_LCD
 	struct lcd_device *lcd;
 	u8 lcd_contrast;
-#endif
-#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT=
_CLASS_DEVICE_MODULE)
+#endif /* CONFIG_HID_PICOLCD_LCD */
+#ifdef CONFIG_HID_PICOLCD_BACKLIGHT
 	struct backlight_device *backlight;
 	u8 lcd_brightness;
 	u8 lcd_power;
-#endif /* CONFIG_BACKLIGHT_CLASS_DEVICE */
-#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
+#endif /* CONFIG_HID_PICOLCD_BACKLIGHT */
+#ifdef CONFIG_HID_PICOLCD_LEDS
 	/* LED stuff */
 	u8 led_state;
 	struct led_classdev *led[8];
-#endif /* CONFIG_LEDS_CLASS */
+#endif /* CONFIG_HID_PICOLCD_LEDS */
=20
 	/* Housekeeping stuff */
 	spinlock_t lock;
@@ -287,7 +287,7 @@ static struct picolcd_pending *picolcd_send_and_wai=
t(struct hid_device *hdev,
 	return work;
 }
=20
-#if defined(CONFIG_FB) || defined(CONFIG_FB_MODULE)
+#ifdef CONFIG_HID_PICOLCD_FB
 /* Send a given tile to PicoLCD */
 static int picolcd_fb_send_tile(struct hid_device *hdev, int chip, int=
 tile)
 {
@@ -766,9 +766,9 @@ static void picolcd_exit_framebuffer(struct picolcd=
_data *data)
 {
 }
 #define picolcd_fbinfo(d) NULL
-#endif /* CONFIG_FB */
+#endif /* CONFIG_HID_PICOLCD_FB */
=20
-#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT=
_CLASS_DEVICE_MODULE)
+#ifdef CONFIG_HID_PICOLCD_BACKLIGHT
 /*
  * backlight class device
  */
@@ -864,9 +864,9 @@ static inline int picolcd_resume_backlight(struct p=
icolcd_data *data)
 {
 	return 0;
 }
-#endif /* CONFIG_BACKLIGHT_CLASS_DEVICE */
+#endif /* CONFIG_HID_PICOLCD_BACKLIGHT */
=20
-#if defined(CONFIG_LCD_CLASS_DEVICE) || defined(CONFIG_LCD_CLASS_DEVIC=
E_MODULE)
+#ifdef CONFIG_HID_PICOLCD_LCD
 /*
  * lcd class device
  */
@@ -957,9 +957,9 @@ static inline int picolcd_resume_lcd(struct picolcd=
_data *data)
 {
 	return 0;
 }
-#endif /* CONFIG_LCD_CLASS_DEVICE */
+#endif /* CONFIG_HID_PICOLCD_LCD */
=20
-#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
+#ifdef CONFIG_HID_PICOLCD_LEDS
 /**
  * LED class device
  */
@@ -1104,7 +1104,7 @@ static inline int picolcd_leds_set(struct picolcd=
_data *data)
 {
 	return 0;
 }
-#endif /* CONFIG_LEDS_CLASS */
+#endif /* CONFIG_HID_PICOLCD_LEDS */
=20
 /*
  * input class device
@@ -1243,10 +1243,10 @@ static int picolcd_reset(struct hid_device *hde=
v)
=20
 	picolcd_resume_lcd(data);
 	picolcd_resume_backlight(data);
-#if defined(CONFIG_FB) || defined(CONFIG_FB_MODULE)
+#ifdef CONFIG_HID_PICOLCD_FB
 	if (data->fb_info)
 		schedule_delayed_work(&data->fb_info->deferred_work, 0);
-#endif /* CONFIG_FB */
+#endif /* CONFIG_HID_PICOLCD_FB */
=20
 	picolcd_leds_set(data);
 	return 0;
--=20
1.6.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
