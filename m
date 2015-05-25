From: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 04/18] input: locomokbd: differentiate between two Enter keys
Date: Mon, 25 May 2015 14:41:39 +0300
Message-ID: <1432554113-26280-5-git-send-email-dbaryshkov@gmail.com>
References: <1432554113-26280-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432554113-26280-1-git-send-email-dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrea Adami <andrea.adami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: linux-input@vger.kernel.org

There are two Enter keys on collie/poodle keyboards. Make one of them to
generate KEY_KPENTER rather than just KEY_ENTER.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/input/keyboard/locomokbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/locomokbd.c b/drivers/input/keyboard/locomokbd.c
index 9742c79..7645053 100644
--- a/drivers/input/keyboard/locomokbd.c
+++ b/drivers/input/keyboard/locomokbd.c
@@ -50,7 +50,7 @@ locomokbd_keycode[LOCOMOKBD_NUMKEYS] = {
 	0, 0, 0, KEY_CENTER, 0, KEY_MAIL, 0, 0, 0, 0,				/* 30 - 39 */
 	0, 0, 0, 0, 0, 0, 0, 0, 0, KEY_RIGHT,					/* 40 - 49 */
 	KEY_UP, KEY_LEFT, 0, 0, KEY_P, 0, KEY_O, KEY_I, KEY_Y, KEY_T,		/* 50 - 59 */
-	KEY_E, KEY_W, 0, 0, 0, 0, KEY_DOWN, KEY_ENTER, 0, 0,			/* 60 - 69 */
+	KEY_E, KEY_W, 0, 0, 0, 0, KEY_DOWN, KEY_KPENTER, 0, 0,			/* 60 - 69 */
 	KEY_BACKSPACE, 0, KEY_L, KEY_U, KEY_H, KEY_R, KEY_D, KEY_Q, 0, 0,	/* 70 - 79 */
 	0, 0, 0, 0, 0, 0, KEY_ENTER, KEY_RIGHTSHIFT, KEY_K, KEY_J,		/* 80 - 89 */
 	KEY_G, KEY_F, KEY_X, KEY_S, 0, 0, 0, 0, 0, 0,				/* 90 - 99 */
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
