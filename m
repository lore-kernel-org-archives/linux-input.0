From: Justin Waters <justin.waters@timesys.com>
Subject: [PATCH 2/2] atmel_tsadcc: Add board specific information for
	touchscreen driver
Date: Fri, 25 Apr 2008 14:56:38 -0400
Message-ID: <1209149798-20418-3-git-send-email-justin.waters@timesys.com>
References: <> <1209149798-20418-1-git-send-email-justin.waters@timesys.com>
	<1209149798-20418-2-git-send-email-justin.waters@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <1209149798-20418-2-git-send-email-justin.waters@timesys.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-input@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
Cc: dmitry.torokhov@gmail.com, linux@maxim.org.za
List-Id: linux-input@vger.kernel.org

This patch adds board and cpu integration for the atmel_tsadcc driver on the
at91sam9rl-ek board.

Signed-off-by: Justin Waters <justin.waters@timesys.com>
---
 arch/arm/configs/at91sam9rlek_defconfig |    1 +
 arch/arm/mach-at91/at91sam9rl_devices.c |   56 +++++++++++++++++++++++++++++++
 arch/arm/mach-at91/board-sam9rlek.c     |    2 +
 include/asm-arm/arch-at91/board.h       |    3 ++
 4 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/at91sam9rlek_defconfig b/arch/arm/configs/at91sam9rlek_defconfig
index fbe8b30..fb273ad 100644
--- a/arch/arm/configs/at91sam9rlek_defconfig
+++ b/arch/arm/configs/at91sam9rlek_defconfig
@@ -520,6 +520,7 @@ CONFIG_INPUT_TOUCHSCREEN=y
 # CONFIG_TOUCHSCREEN_PENMOUNT is not set
 # CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
 # CONFIG_TOUCHSCREEN_TOUCHWIN is not set
+CONFIG_TOUCHSCREEN_ATMEL_TSADCC=y
 # CONFIG_TOUCHSCREEN_UCB1400 is not set
 # CONFIG_INPUT_MISC is not set
 
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index f43b5c3..780ea48 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -15,6 +15,7 @@
 
 #include <linux/fb.h>
 #include <video/atmel_lcdc.h>
+#include <linux/atmel_tsadcc.h>
 
 #include <asm/arch/board.h>
 #include <asm/arch/gpio.h>
@@ -579,6 +580,61 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
 
 
 /* --------------------------------------------------------------------
+ *  *  Touchscreen (ATMEL_TSADCC)
+ *   * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_TOUCHSCREEN_ATMEL_TSADCC) || defined(CONFIG_TOUCHSCREEN_ATMEL_TSADCC_MODULE)
+static u64 atmel_tsadcc_dmamask = 0xffffffffUL;
+
+static struct atmel_tsadcc_platform_data tsadcc_data = {
+	/* These values work with a 100 MHz Master Clock for the ADC */
+	.prescaler	= 0xC, /* 3.846 MHz Clock */
+	.debounce	= 0xE, /* 4.2 ms debounce */
+	.tsshtim	= 0x3, /* 1.04 us Sample Hold time */
+	.startup	= 0x13, /* 41 us Startup Time */
+};
+
+static struct resource atmel_tsadcc_resources[] = {
+	[0] = {
+		.start	= AT91SAM9RL_BASE_TSC,
+		.end	= AT91SAM9RL_BASE_TSC + SZ_16K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AT91SAM9RL_ID_TSC,
+		.end	= AT91SAM9RL_ID_TSC,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device at91_tsadcc_device = {
+	.name		= "atmel_tsadcc",
+	.id		= 0,
+	.dev		= {
+				.dma_mask		= &atmel_tsadcc_dmamask,
+				.coherent_dma_mask	= 0xffffffff,
+				.platform_data		= &tsadcc_data,
+	},
+	.resource	= atmel_tsadcc_resources,
+	.num_resources	= ARRAY_SIZE(atmel_tsadcc_resources),
+};
+
+void __init at91_add_device_tsadcc(void)
+{
+	at91_set_A_periph(AT91_PIN_PA17, 0);	/* AD0_XR */
+	at91_set_A_periph(AT91_PIN_PA18, 0);	/* AD1_XL */
+	at91_set_A_periph(AT91_PIN_PA19, 0);	/* AD2_YT */
+	at91_set_A_periph(AT91_PIN_PA20, 0);	/* AD3_TB */
+
+	platform_device_register(&at91_tsadcc_device);
+}
+#else
+void __init at91_add_device_tsadcc(void) {
+}
+#endif
+
+
+/* --------------------------------------------------------------------
  *  UART
  * -------------------------------------------------------------------- */
 
diff --git a/arch/arm/mach-at91/board-sam9rlek.c b/arch/arm/mach-at91/board-sam9rlek.c
index bc0546d..1c92793 100644
--- a/arch/arm/mach-at91/board-sam9rlek.c
+++ b/arch/arm/mach-at91/board-sam9rlek.c
@@ -190,6 +190,8 @@ static void __init ek_board_init(void)
 	at91_add_device_mmc(0, &ek_mmc_data);
 	/* LCD Controller */
 	at91_add_device_lcdc(&ek_lcdc_data);
+	/* TSADCC */
+	at91_add_device_tsadcc();
 }
 
 MACHINE_START(AT91SAM9RLEK, "Atmel AT91SAM9RL-EK")
diff --git a/include/asm-arm/arch-at91/board.h b/include/asm-arm/arch-at91/board.h
index dc189f0..e59e088 100644
--- a/include/asm-arm/arch-at91/board.h
+++ b/include/asm-arm/arch-at91/board.h
@@ -158,6 +158,9 @@ extern void __init at91_add_device_ac97(struct atmel_ac97_data *data);
  /* ISI */
 extern void __init at91_add_device_isi(void);
 
+ /* Touchscreen Controller */
+extern void __init at91_add_device_tsadcc(void);
+
  /* LEDs */
 extern void __init at91_init_leds(u8 cpu_led, u8 timer_led);
 extern void __init at91_gpio_leds(struct gpio_led *leds, int nr);
-- 
1.5.4.3


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
