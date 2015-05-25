From: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 13/18] ARM: sa1100: don't preallocate IRQ space for locomo
Date: Mon, 25 May 2015 14:41:48 +0300
Message-ID: <1432554113-26280-14-git-send-email-dbaryshkov@gmail.com>
References: <1432554113-26280-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432554113-26280-1-git-send-email-dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrea Adami <andrea.adami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: linux-input@vger.kernel.org

As new locomo driver properly supports SPARSE_IRQ, stop playing with
NR_IRQS on sa1100 (locomo was the last chip requiring NR_IRQ tricks).

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/mach-sa1100/include/mach/irqs.h | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-sa1100/include/mach/irqs.h b/arch/arm/mach-sa1100/include/mach/irqs.h
index 734e30e..b4b9608 100644
--- a/arch/arm/mach-sa1100/include/mach/irqs.h
+++ b/arch/arm/mach-sa1100/include/mach/irqs.h
@@ -79,22 +79,7 @@
 #define IRQ_BOARD_START		61
 #define IRQ_BOARD_END		77
 
-/*
- * Figure out the MAX IRQ number.
- *
- * Neponset, SA1111 and UCB1x00 are sparse IRQ aware, so can dynamically
- * allocate their IRQs above NR_IRQS.
- *
- * LoCoMo has 4 additional IRQs, but is not sparse IRQ aware, and so has
- * to be included in the NR_IRQS calculation.
- */
-#ifdef CONFIG_SHARP_LOCOMO
-#define NR_IRQS_LOCOMO		4
-#else
-#define NR_IRQS_LOCOMO		0
-#endif
-
 #ifndef NR_IRQS
-#define NR_IRQS (IRQ_BOARD_START + NR_IRQS_LOCOMO)
+#define NR_IRQS IRQ_BOARD_START
 #endif
-#define SA1100_NR_IRQS (IRQ_BOARD_START + NR_IRQS_LOCOMO)
+#define SA1100_NR_IRQS IRQ_BOARD_START
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
