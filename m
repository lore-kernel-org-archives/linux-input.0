From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH 09/15] ARM: sa1100: don't preallocate IRQ space for locomo
Date: Tue, 28 Oct 2014 03:02:02 +0300
Message-ID: <1414454528-24240-10-git-send-email-dbaryshkov@gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Andrea Adami <andrea.adami@gmail.com>, Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: linux-input@vger.kernel.org

As new locomo driver properly supports SPARSE_IRQ, stop playing with
NR_IRQS on sa1100 (locomo was the last chip requiring NR_IRQ tricks).

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/include/mach/irqs.h | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-sa1100/include/mach/irqs.h b/arch/arm/mach-sa1100/include/mach/irqs.h
index 3790298..99e7202 100644
--- a/arch/arm/mach-sa1100/include/mach/irqs.h
+++ b/arch/arm/mach-sa1100/include/mach/irqs.h
@@ -68,22 +68,7 @@
 #define IRQ_BOARD_START		49
 #define IRQ_BOARD_END		65
 
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
2.1.1

