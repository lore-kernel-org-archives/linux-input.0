From: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 04/17] input: locomokbd: provide an Alt-SysRQ combination
Date: Tue, 28 Apr 2015 02:55:41 +0300
Message-ID: <1430178954-11138-5-git-send-email-dbaryshkov@gmail.com>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430178954-11138-1-git-send-email-dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrea Adami <andrea.adami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: linux-input@vger.kernel.org

It is usefull sometimes to have an Alt-SysRQ combo on the keyboard to be
able to trigger sysrq functions directly. Add an option providing sysrq
mapping for Contact-Home keys.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/input/keyboard/Kconfig     |  7 +++++++
 drivers/input/keyboard/locomokbd.c | 14 +++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 0a3d875..eb8b11b 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -343,6 +343,13 @@ config KEYBOARD_LOCOMO
 	  To compile this driver as a module, choose M here: the
 	  module will be called locomokbd.
 
+config KEYBOARD_LOCOMO_SYSRQ
+	bool "Provide SysRQ key on LoCoMo keyboard"
+	depends on KEYBOARD_LOCOMO
+	help
+	  Say Y here to be able to use Contact-Home as Alt-Sysrq combo.
+	  Say N if you want to use them as usual keys.
+
 config KEYBOARD_LPC32XX
 	tristate "LPC32XX matrix key scanner support"
 	depends on ARCH_LPC32XX && OF
diff --git a/drivers/input/keyboard/locomokbd.c b/drivers/input/keyboard/locomokbd.c
index eed0a94..eb8dbe2 100644
--- a/drivers/input/keyboard/locomokbd.c
+++ b/drivers/input/keyboard/locomokbd.c
@@ -40,6 +40,14 @@
 #define KEY_CONTACT		KEY_F18
 #define KEY_CENTER		KEY_F15
 
+#ifdef CONFIG_KEYBOARD_LOCOMOKBD_SYSRQ
+#define LOCOMO_KEY_CONTACT	KEY_LEFTALT
+#define LOCOMO_KEY_HOME		KEY_SYSRQ
+#else
+#define LOCOMO_KEY_CONTACT	KEY_CONTACT
+#define LOCOMO_KEY_HOME		KEY_HOME
+#endif
+
 #define KB_ROWS			16
 #define KB_COLS			8
 #define LOCOMOKBD_NUMKEYS	(KB_ROWS * KB_COLS)
@@ -48,7 +56,7 @@
 static const unsigned char
 locomokbd_keycode[LOCOMOKBD_NUMKEYS] = {
 	0, KEY_ESC, KEY_ACTIVITY, 0, 0, 0, 0, 0, 0, 0,				/* 0 - 9 */
-	0, 0, 0, 0, 0, 0, 0, KEY_MENU, 0, KEY_CONTACT,				/* 10 - 19 */
+	0, 0, 0, 0, 0, 0, 0, KEY_MENU, 0, LOCOMO_KEY_CONTACT,			/* 10 - 19 */
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0,						/* 20 - 29 */
 	0, 0, 0, KEY_CENTER, 0, KEY_MAIL, 0, 0, 0, 0,				/* 30 - 39 */
 	0, 0, 0, 0, 0, 0, 0, 0, 0, KEY_RIGHT,					/* 40 - 49 */
@@ -280,9 +288,9 @@ static int locomokbd_probe(struct platform_device *dev)
 			sizeof(locomokbd->keycode));
 
 	if (machine_is_collie())
-		locomokbd->keycode[18] = KEY_HOME;
+		locomokbd->keycode[18] = LOCOMO_KEY_HOME;
 	else
-		locomokbd->keycode[3] = KEY_HOME;
+		locomokbd->keycode[3] = LOCOMO_KEY_HOME;
 
 	for (i = 0; i < LOCOMOKBD_NUMKEYS; i++)
 		input_set_capability(input_dev, EV_KEY, locomokbd->keycode[i]);
-- 
2.1.4
