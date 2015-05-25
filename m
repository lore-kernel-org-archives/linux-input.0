From: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 16/18] ARM: pxa: poodle: don't preallocate IRQ space for locomo
Date: Mon, 25 May 2015 14:41:51 +0300
Message-ID: <1432554113-26280-17-git-send-email-dbaryshkov@gmail.com>
References: <1432554113-26280-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432554113-26280-1-git-send-email-dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrea Adami <andrea.adami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: linux-input@vger.kernel.org

As new locomo driver supports SPARSE_IRQ, don't preallocate NR_IRQS
space for it on poodle.

Acked-by: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/mach-pxa/include/mach/poodle.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/include/mach/poodle.h b/arch/arm/mach-pxa/include/mach/poodle.h
index 5905cf1..71b6383 100644
--- a/arch/arm/mach-pxa/include/mach/poodle.h
+++ b/arch/arm/mach-pxa/include/mach/poodle.h
@@ -81,7 +81,7 @@
 #define POODLE_GPIO_L_LCLK	(POODLE_SCOOP_GPIO_BASE + 10)
 #define POODLE_GPIO_HS_OUT	(POODLE_SCOOP_GPIO_BASE + 11)
 
-#define POODLE_NR_IRQS		(IRQ_BOARD_START + 4)	/* 4 for LoCoMo */
+#define POODLE_NR_IRQS		IRQ_BOARD_START
 
 extern struct platform_device poodle_locomo_device;
 
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
