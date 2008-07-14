From: "Liang, Dan" <Dan.Liang@atmel.com>
Subject: [PATCH 2/2] Add board specific code for atmel's touchscreen driver
Date: Mon, 14 Jul 2008 04:04:11 +0200
Message-ID: <0F5F73E36031FD46AD3F2E6948F0C0A020866C@frimb01.corp.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-class: urn:content-classes:message
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

This patch adds touchscreen info into specific cpu and board.

Signed-off-by: Justin Waters <justin.waters@timesys.com>
Signed-off-by: Dan Liang <dan.liang@atmel.com>
---
 arch/arm/mach-at91/at91sam9rl_devices.c  |   45 +++++
 arch/arm/mach-at91/board-sam9rlek.c      |    2 +
 include/asm-arm/arch-at91/board.h        |    3 +
 3 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c
b/arch/arm/mach-at91/at91sam9rl_devices.c
index 450db30..b2b1253 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -432,6 +432,51 @@ static void __init at91_add_device_tc(void) { }
 
 
 /* --------------------------------------------------------------------
+ *  Touchscreen
+ * --------------------------------------------------------------------
*/
+
+#if defined(CONFIG_TOUCHSCREEN_ATMEL_TSADCC) ||
defined(CONFIG_TOUCHSCREEN_ATMEL_TSADCC_MODULE)
+static u64 tsadcc_dmamask = DMA_BIT_MASK(32);
+
+static struct resource tsadcc_resources[] = {
+	[0] = {
+		.start	= AT91SAM9RL_BASE_TSC,
+		.end	= AT91SAM9RL_BASE_TSC + SZ_16K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AT91SAM9RL_ID_TSC,
+		.end	= AT91SAM9RL_ID_TSC,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device at91_tsadcc_device = {
+	.name		= "atmel_tsadcc",
+	.id		= -1,
+	.dev		= {
+				.dma_mask		=
&tsadcc_dmamask,
+				.coherent_dma_mask	=
DMA_BIT_MASK(32),
+	},
+	.resource	= tsadcc_resources,
+	.num_resources	= ARRAY_SIZE(tsadcc_resources),
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
+void __init at91_add_device_tsadcc(void) {}
+#endif
+
+
+/* --------------------------------------------------------------------
  *  RTC
  * --------------------------------------------------------------------
*/
 
diff --git a/arch/arm/mach-at91/board-sam9rlek.c
b/arch/arm/mach-at91/board-sam9rlek.c
index ffc0597..57da753 100644
--- a/arch/arm/mach-at91/board-sam9rlek.c
+++ b/arch/arm/mach-at91/board-sam9rlek.c
@@ -185,6 +185,8 @@ static void __init ek_board_init(void)
 	at91_add_device_mmc(0, &ek_mmc_data);
 	/* LCD Controller */
 	at91_add_device_lcdc(&ek_lcdc_data);
+	/* Touch Screen Controller */
+	at91_add_device_tsadcc();
 }
 
 MACHINE_START(AT91SAM9RLEK, "Atmel AT91SAM9RL-EK")
diff --git a/include/asm-arm/arch-at91/board.h
b/include/asm-arm/arch-at91/board.h
index dc189f0..e59e088 100644
--- a/include/asm-arm/arch-at91/board.h
+++ b/include/asm-arm/arch-at91/board.h
@@ -158,6 +158,9 @@ extern void __init at91_add_device_ac97(struct
atmel_ac97_data *data);
  /* ISI */
 extern void __init at91_add_device_isi(void);
 
+ /* Touchscreen Controller */
+extern void __init at91_add_device_tsadcc(void);
+
  /* LEDs */
 extern void __init at91_init_leds(u8 cpu_led, u8 timer_led);
 extern void __init at91_gpio_leds(struct gpio_led *leds, int nr);
--
1.5.0.6

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
