From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH v3 15/17] ARM: pxa: poodle: don't preallocate IRQ space for locomo
Date: Sun, 17 May 2015 19:27:55 +0300
Message-ID: <1431880077-26321-16-git-send-email-dbaryshkov@gmail.com>
References: <1431880077-26321-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <1431880077-26321-1-git-send-email-dbaryshkov@gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Andrea Adami <andrea.adami@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-input@vger.kernel.org

As new locomo driver supports SPARSE_IRQ, don't preallocate NR_IRQS
space for it on poodle.

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
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
