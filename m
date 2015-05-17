From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH v3 12/17] ARM: sa1100: don't preallocate IRQ space for locomo
Date: Sun, 17 May 2015 19:27:52 +0300
Message-ID: <1431880077-26321-13-git-send-email-dbaryshkov@gmail.com>
References: <1431880077-26321-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1431880077-26321-1-git-send-email-dbaryshkov@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Andrea Adami <andrea.adami@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-input@vger.kernel.org

As new locomo driver properly supports SPARSE_IRQ, stop playing with
NR_IRQS on sa1100 (locomo was the last chip requiring NR_IRQ tricks).

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
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

