From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.52-rc9] input: fix platform driver hotplug/coldplug
Date: Sun, 13 Apr 2008 16:31:48 -0700
Message-ID: <200804131631.48742.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:41217 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752964AbYDMXbv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Apr 2008 19:31:51 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, kay.sievers@vrfy.org

=46rom: Kay Sievers <kay.sievers@vrfy.org>
Subject: add MODULE_ALIAS() to hotpluggable platform modules

Since 43cc71eed1250755986da4c0f9898f9a635cb3bf, the platform modalias
is prefixed with "platform:". Add MODULE_ALIAS() to the hotpluggable
"input" platform drivers, to re-enable auto loading.

[ dbrownell@users.sourceforge.net: more drivers, registration fixes ]
Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
By the way, where is linux-input@vger archived?  The mail-archive.com
stuff ends in February ... may I suggest marc.info?  When I post to
linux-input, it feels awfully much like a black hole.  Despite what
I've been told, the old list (@atrey not @vger) seems to be the only
one that's active, if one goes by archives...

 drivers/input/keyboard/aaed2000_kbd.c     |    4 ++++
 drivers/input/keyboard/bf54x-keys.c       |    2 ++
 drivers/input/keyboard/corgikbd.c         |    2 ++
 drivers/input/keyboard/gpio_keys.c        |    2 ++
 drivers/input/keyboard/jornada680_kbd.c   |    2 ++
 drivers/input/keyboard/jornada720_kbd.c   |    4 ++++
 drivers/input/keyboard/omap-keypad.c      |    2 ++
 drivers/input/keyboard/pxa27x_keypad.c    |    4 ++++
 drivers/input/keyboard/spitzkbd.c         |    1 +
 drivers/input/keyboard/tosakbd.c          |    2 ++
 drivers/input/misc/cobalt_btns.c          |    3 +++
 drivers/input/mouse/gpio_mouse.c          |    4 ++++
 drivers/input/serio/rpckbd.c              |    2 ++
 drivers/input/touchscreen/corgi_ts.c      |    2 ++
 drivers/input/touchscreen/jornada720_ts.c |    4 ++++
 15 files changed, 40 insertions(+)

--- g26.orig/drivers/input/keyboard/aaed2000_kbd.c	2008-04-13 16:12:01.=
000000000 -0700
+++ g26/drivers/input/keyboard/aaed2000_kbd.c	2008-04-13 16:15:05.00000=
0000 -0700
@@ -156,11 +156,15 @@ static int __devexit aaedkbd_remove(stru
 	return 0;
 }
=20
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:aaed2000-keyboard");
+
 static struct platform_driver aaedkbd_driver =3D {
 	.probe		=3D aaedkbd_probe,
 	.remove		=3D __devexit_p(aaedkbd_remove),
 	.driver		=3D {
 		.name	=3D "aaed2000-keyboard",
+		.owner	=3D THIS_MODULE,
 	},
 };
=20
--- g26.orig/drivers/input/keyboard/bf54x-keys.c	2008-04-13 16:11:53.00=
0000000 -0700
+++ g26/drivers/input/keyboard/bf54x-keys.c	2008-04-13 16:15:10.0000000=
00 -0700
@@ -359,6 +359,7 @@ struct platform_driver bfin_kpad_device_
 	.remove		=3D __devexit_p(bfin_kpad_remove),
 	.driver		=3D {
 		.name	=3D DRV_NAME,
+		.owner	=3D THIS_MODULE,
 	}
 };
=20
@@ -378,3 +379,4 @@ module_exit(bfin_kpad_exit);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
 MODULE_DESCRIPTION("Keypad driver for BF54x Processors");
+MODULE_ALIAS("platform:bf54x-keys");
--- g26.orig/drivers/input/keyboard/corgikbd.c	2008-04-13 16:11:52.0000=
00000 -0700
+++ g26/drivers/input/keyboard/corgikbd.c	2008-04-13 16:12:32.000000000=
 -0700
@@ -392,6 +392,7 @@ static struct platform_driver corgikbd_d
 	.resume		=3D corgikbd_resume,
 	.driver		=3D {
 		.name	=3D "corgi-keyboard",
+		.owner	=3D THIS_MODULE,
 	},
 };
=20
@@ -411,3 +412,4 @@ module_exit(corgikbd_exit);
 MODULE_AUTHOR("Richard Purdie <rpurdie@rpsys.net>");
 MODULE_DESCRIPTION("Corgi Keyboard Driver");
 MODULE_LICENSE("GPLv2");
+MODULE_ALIAS("platform:corgi-keyboard");
--- g26.orig/drivers/input/keyboard/gpio_keys.c	2008-04-13 16:11:52.000=
000000 -0700
+++ g26/drivers/input/keyboard/gpio_keys.c	2008-04-13 16:12:27.00000000=
0 -0700
@@ -214,6 +214,7 @@ struct platform_driver gpio_keys_device_
 	.resume		=3D gpio_keys_resume,
 	.driver		=3D {
 		.name	=3D "gpio-keys",
+		.owner	=3D THIS_MODULE,
 	}
 };
=20
@@ -233,3 +234,4 @@ module_exit(gpio_keys_exit);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Phil Blundell <pb@handhelds.org>");
 MODULE_DESCRIPTION("Keyboard driver for CPU GPIOs");
+MODULE_ALIAS("platform:gpio-keys");
--- g26.orig/drivers/input/keyboard/jornada680_kbd.c	2008-04-13 16:11:5=
3.000000000 -0700
+++ g26/drivers/input/keyboard/jornada680_kbd.c	2008-04-13 16:14:28.000=
000000 -0700
@@ -254,6 +254,7 @@ static int __devexit jornada680kbd_remov
 static struct platform_driver jornada680kbd_driver =3D {
 	.driver	=3D {
 		.name	=3D "jornada680_kbd",
+		.owner	=3D THIS_MODULE,
 	},
 	.probe	=3D jornada680kbd_probe,
 	.remove	=3D __devexit_p(jornada680kbd_remove),
@@ -275,3 +276,4 @@ module_exit(jornada680kbd_exit);
 MODULE_AUTHOR("Kristoffer Ericson <kristoffer.ericson@gmail.com>");
 MODULE_DESCRIPTION("HP Jornada 620/660/680/690 Keyboard Driver");
 MODULE_LICENSE("GPLv2");
+MODULE_ALIAS("platform:jornada680_kbd");
--- g26.orig/drivers/input/keyboard/jornada720_kbd.c	2008-04-13 16:12:0=
1.000000000 -0700
+++ g26/drivers/input/keyboard/jornada720_kbd.c	2008-04-13 16:14:22.000=
000000 -0700
@@ -162,9 +162,13 @@ static int __devexit jornada720_kbd_remo
 	return 0;
 }
=20
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:jornada720_kbd");
+
 static struct platform_driver jornada720_kbd_driver =3D {
 	.driver  =3D {
 		.name    =3D "jornada720_kbd",
+		.owner	=3D THIS_MODULE,
 	 },
 	.probe   =3D jornada720_kbd_probe,
 	.remove  =3D __devexit_p(jornada720_kbd_remove),
--- g26.orig/drivers/input/keyboard/omap-keypad.c	2008-04-13 16:11:53.0=
00000000 -0700
+++ g26/drivers/input/keyboard/omap-keypad.c	2008-04-13 16:14:34.000000=
000 -0700
@@ -464,6 +464,7 @@ static struct platform_driver omap_kp_dr
 	.resume		=3D omap_kp_resume,
 	.driver		=3D {
 		.name	=3D "omap-keypad",
+		.owner	=3D THIS_MODULE,
 	},
 };
=20
@@ -484,3 +485,4 @@ module_exit(omap_kp_exit);
 MODULE_AUTHOR("Timo Ter=E4s");
 MODULE_DESCRIPTION("OMAP Keypad Driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:omap-keypad");
--- g26.orig/drivers/input/keyboard/pxa27x_keypad.c	2008-04-13 16:12:01=
=2E000000000 -0700
+++ g26/drivers/input/keyboard/pxa27x_keypad.c	2008-04-13 16:13:37.0000=
00000 -0700
@@ -545,6 +545,9 @@ static int __devexit pxa27x_keypad_remov
 	return 0;
 }
=20
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:pxa27x-keypad");
+
 static struct platform_driver pxa27x_keypad_driver =3D {
 	.probe		=3D pxa27x_keypad_probe,
 	.remove		=3D __devexit_p(pxa27x_keypad_remove),
@@ -552,6 +555,7 @@ static struct platform_driver pxa27x_key
 	.resume		=3D pxa27x_keypad_resume,
 	.driver		=3D {
 		.name	=3D "pxa27x-keypad",
+		.owner	=3D THIS_MODULE,
 	},
 };
=20
--- g26.orig/drivers/input/keyboard/spitzkbd.c	2008-04-13 16:11:52.0000=
00000 -0700
+++ g26/drivers/input/keyboard/spitzkbd.c	2008-04-13 16:11:55.000000000=
 -0700
@@ -494,3 +494,4 @@ module_exit(spitzkbd_exit);
 MODULE_AUTHOR("Richard Purdie <rpurdie@rpsys.net>");
 MODULE_DESCRIPTION("Spitz Keyboard Driver");
 MODULE_LICENSE("GPLv2");
+MODULE_ALIAS("platform:spitz-keyboard");
--- g26.orig/drivers/input/keyboard/tosakbd.c	2008-04-13 16:11:52.00000=
0000 -0700
+++ g26/drivers/input/keyboard/tosakbd.c	2008-04-13 16:13:53.000000000 =
-0700
@@ -394,6 +394,7 @@ static struct platform_driver tosakbd_dr
 	.resume		=3D tosakbd_resume,
 	.driver		=3D {
 		.name	=3D "tosa-keyboard",
+		.owner	=3D THIS_MODULE,
 	},
 };
=20
@@ -413,3 +414,4 @@ module_exit(tosakbd_exit);
 MODULE_AUTHOR("Dirk Opfer <Dirk@Opfer-Online.de>");
 MODULE_DESCRIPTION("Tosa Keyboard Driver");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:tosa-keyboard");
--- g26.orig/drivers/input/misc/cobalt_btns.c	2008-04-13 16:12:01.00000=
0000 -0700
+++ g26/drivers/input/misc/cobalt_btns.c	2008-04-13 16:15:42.000000000 =
-0700
@@ -148,6 +148,9 @@ static int __devexit cobalt_buttons_remo
 	return 0;
 }
=20
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:Cobalt buttons");
+
 static struct platform_driver cobalt_buttons_driver =3D {
 	.probe	=3D cobalt_buttons_probe,
 	.remove	=3D __devexit_p(cobalt_buttons_remove),
--- g26.orig/drivers/input/mouse/gpio_mouse.c	2008-04-13 16:12:02.00000=
0000 -0700
+++ g26/drivers/input/mouse/gpio_mouse.c	2008-04-13 16:16:20.000000000 =
-0700
@@ -171,10 +171,14 @@ static int __devexit gpio_mouse_remove(s
 	return 0;
 }
=20
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:gpio_mouse");
+
 struct platform_driver gpio_mouse_device_driver =3D {
 	.remove		=3D __devexit_p(gpio_mouse_remove),
 	.driver		=3D {
 		.name	=3D "gpio_mouse",
+		.owner	=3D THIS_MODULE,
 	}
 };
=20
--- g26.orig/drivers/input/serio/rpckbd.c	2008-04-13 16:11:52.000000000=
 -0700
+++ g26/drivers/input/serio/rpckbd.c	2008-04-13 16:16:43.000000000 -070=
0
@@ -45,6 +45,7 @@
 MODULE_AUTHOR("Vojtech Pavlik, Russell King");
 MODULE_DESCRIPTION("Acorn RiscPC PS/2 keyboard controller driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:kart");
=20
 static int rpckbd_write(struct serio *port, unsigned char val)
 {
@@ -140,6 +141,7 @@ static struct platform_driver rpckbd_dri
 	.remove		=3D __devexit_p(rpckbd_remove),
 	.driver		=3D {
 		.name	=3D "kart",
+		.owner	=3D THIS_MODULE,
 	},
 };
=20
--- g26.orig/drivers/input/touchscreen/corgi_ts.c	2008-04-13 16:11:52.0=
00000000 -0700
+++ g26/drivers/input/touchscreen/corgi_ts.c	2008-04-13 16:16:59.000000=
000 -0700
@@ -361,6 +361,7 @@ static struct platform_driver corgits_dr
 	.resume		=3D corgits_resume,
 	.driver		=3D {
 		.name	=3D "corgi-ts",
+		.owner	=3D THIS_MODULE,
 	},
 };
=20
@@ -380,3 +381,4 @@ module_exit(corgits_exit);
 MODULE_AUTHOR("Richard Purdie <rpurdie@rpsys.net>");
 MODULE_DESCRIPTION("Corgi TouchScreen Driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:corgi-ts");
--- g26.orig/drivers/input/touchscreen/jornada720_ts.c	2008-04-13 16:12=
:02.000000000 -0700
+++ g26/drivers/input/touchscreen/jornada720_ts.c	2008-04-13 16:17:32.0=
00000000 -0700
@@ -160,11 +160,15 @@ static int __devexit jornada720_ts_remov
 	return 0;
 }
=20
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:jornada_ts");
+
 static struct platform_driver jornada720_ts_driver =3D {
 	.probe		=3D jornada720_ts_probe,
 	.remove		=3D __devexit_p(jornada720_ts_remove),
 	.driver		=3D {
 		.name	=3D "jornada_ts",
+		.owner	=3D THIS_MODULE,
 	},
 };
=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
