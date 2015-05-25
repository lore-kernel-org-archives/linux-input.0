From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH v4 05/18] input: make LoCoMo keyboard driver support both poodle and collie
Date: Mon, 25 May 2015 14:41:40 +0300
Message-ID: <1432554113-26280-6-git-send-email-dbaryshkov@gmail.com>
References: <1432554113-26280-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1432554113-26280-1-git-send-email-dbaryshkov@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Andrea Adami <andrea.adami@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-spi@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-input@vger.kernel.org

Keyboards on collie and poodle differ only in wiring of 'Home' key.
Instead of complicating the driver with platform data, just check for
the machine for the time being. This will be converted to DTS property
sometime in the future.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/locomokbd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/locomokbd.c b/drivers/input/keyboard/locomokbd.c
index 7645053..73d6e58 100644
--- a/drivers/input/keyboard/locomokbd.c
+++ b/drivers/input/keyboard/locomokbd.c
@@ -33,6 +33,9 @@
 #include <linux/slab.h>
 #include <linux/mfd/locomo.h>
 
+/* There is one minor difference between mappings on poodle and collie */
+#include <asm/mach-types.h>
+
 #define KEY_ACTIVITY		KEY_F16
 #define KEY_CONTACT		KEY_F18
 #define KEY_CENTER		KEY_F15
@@ -45,7 +48,7 @@
 static const unsigned char
 locomokbd_keycode[LOCOMOKBD_NUMKEYS] = {
 	0, KEY_ESC, KEY_ACTIVITY, 0, 0, 0, 0, 0, 0, 0,				/* 0 - 9 */
-	0, 0, 0, 0, 0, 0, 0, KEY_MENU, KEY_HOME, KEY_CONTACT,			/* 10 - 19 */
+	0, 0, 0, 0, 0, 0, 0, KEY_MENU, 0, KEY_CONTACT,				/* 10 - 19 */
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0,						/* 20 - 29 */
 	0, 0, 0, KEY_CENTER, 0, KEY_MAIL, 0, 0, 0, 0,				/* 30 - 39 */
 	0, 0, 0, 0, 0, 0, 0, 0, 0, KEY_RIGHT,					/* 40 - 49 */
@@ -278,6 +281,11 @@ static int locomokbd_probe(struct platform_device *dev)
 			locomokbd_keycode,
 			sizeof(locomokbd->keycode));
 
+	if (machine_is_collie())
+		locomokbd->keycode[18] = KEY_HOME;
+	else
+		locomokbd->keycode[3] = KEY_HOME;
+
 	for (i = 0; i < LOCOMOKBD_NUMKEYS; i++)
 		input_set_capability(input_dev, EV_KEY, locomokbd->keycode[i]);
 	input_set_capability(input_dev, EV_PWR, KEY_SUSPEND);
-- 
2.1.4

