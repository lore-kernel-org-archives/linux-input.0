From: Sundar Iyer <sundar.iyer@stericsson.com>
Subject: [Patch v7 2/2] ux500: add platform data for Nomadik SKE keypad controller
Date: Tue, 28 Sep 2010 15:02:18 +0530
Message-ID: <1285666338-14620-1-git-send-email-sundar.iyer@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:57087 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753576Ab0I1Jcf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Sep 2010 05:32:35 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Sundar Iyer <sundar.iyer@stericsson.com>

Signed-off-by: Sundar Iyer <sundar.iyer@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500.c         |  129 ++++++++++++++++++++++++++++
 arch/arm/mach-ux500/clock.c                |    1 +
 arch/arm/mach-ux500/devices-db8500.c       |   21 +++++
 arch/arm/mach-ux500/include/mach/devices.h |    1 +
 arch/arm/mach-ux500/pins-db8500.h          |   32 ++++----
 5 files changed, 168 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 58610bb..5307996 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -18,12 +18,14 @@
 #include <linux/amba/pl022.h>
 #include <linux/spi/spi.h>
 #include <linux/mfd/ab8500.h>
+#include <linux/input/matrix_keypad.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
 #include <plat/pincfg.h>
 #include <plat/i2c.h>
+#include <plat/ske.h>
 
 #include <mach/hardware.h>
 #include <mach/setup.h>
@@ -49,6 +51,24 @@ static pin_cfg_t mop500_pins[] = {
 	GPIO11_I2C2_SCL,
 	GPIO229_I2C3_SDA,
 	GPIO230_I2C3_SCL,
+
+	/* SKE keypad */
+	GPIO153_KP_I7,
+	GPIO154_KP_I6,
+	GPIO155_KP_I5,
+	GPIO156_KP_I4,
+	GPIO157_KP_O7,
+	GPIO158_KP_O6,
+	GPIO159_KP_O5,
+	GPIO160_KP_O4,
+	GPIO161_KP_I3,
+	GPIO162_KP_I2,
+	GPIO163_KP_I1,
+	GPIO164_KP_I0,
+	GPIO165_KP_O3,
+	GPIO166_KP_O2,
+	GPIO167_KP_O1,
+	GPIO168_KP_O0,
 };
 
 static void ab4500_spi_cs_control(u32 command)
@@ -154,12 +174,120 @@ static struct amba_device *amba_devs[] __initdata = {
 	&u8500_ssp0_device,
 };
 
+static const unsigned int ux500_keymap[] = {
+	KEY(2, 5, KEY_END),
+	KEY(4, 1, KEY_POWER),
+	KEY(3, 5, KEY_VOLUMEDOWN),
+	KEY(1, 3, KEY_3),
+	KEY(5, 2, KEY_RIGHT),
+	KEY(5, 0, KEY_9),
+
+	KEY(0, 5, KEY_MENU),
+	KEY(7, 6, KEY_ENTER),
+	KEY(4, 5, KEY_0),
+	KEY(6, 7, KEY_2),
+	KEY(3, 4, KEY_UP),
+	KEY(3, 3, KEY_DOWN),
+
+	KEY(6, 4, KEY_SEND),
+	KEY(6, 2, KEY_BACK),
+	KEY(4, 2, KEY_VOLUMEUP),
+	KEY(5, 5, KEY_1),
+	KEY(4, 3, KEY_LEFT),
+	KEY(3, 2, KEY_7),
+};
+
+static struct matrix_keymap_data ux500_keymap_data = {
+	.keymap         = ux500_keymap,
+	.keymap_size    = ARRAY_SIZE(ux500_keymap),
+};
+
+/*
+ * Nomadik SKE keypad
+ */
+#define ROW_PIN_I0      164
+#define ROW_PIN_I1      163
+#define ROW_PIN_I2      162
+#define ROW_PIN_I3      161
+#define ROW_PIN_I4      156
+#define ROW_PIN_I5      155
+#define ROW_PIN_I6      154
+#define ROW_PIN_I7      153
+#define COL_PIN_O0      168
+#define COL_PIN_O1      167
+#define COL_PIN_O2      166
+#define COL_PIN_O3      165
+#define COL_PIN_O4      160
+#define COL_PIN_O5      159
+#define COL_PIN_O6      158
+#define COL_PIN_O7      157
+
+#define SKE_KPD_MAX_ROWS        8
+#define SKE_KPD_MAX_COLS        8
+
+static int ske_kp_rows[] = {
+	ROW_PIN_I0, ROW_PIN_I1, ROW_PIN_I2, ROW_PIN_I3,
+	ROW_PIN_I4, ROW_PIN_I5, ROW_PIN_I6, ROW_PIN_I7,
+};
+
+/*
+ * ske_set_gpio_row: request and set gpio rows
+ */
+static int ske_set_gpio_row(int gpio)
+{
+	int ret;
+
+	ret = gpio_request(gpio, "ske-kp");
+	if (ret < 0) {
+		pr_err("ske_set_gpio_row: gpio request failed\n");
+		return ret;
+	}
+
+	ret = gpio_direction_output(gpio, 1);
+	if (ret < 0) {
+		pr_err("ske_set_gpio_row: gpio direction failed\n");
+		gpio_free(gpio);
+	}
+
+	return ret;
+}
+
+/*
+ * ske_kp_init - enable the gpio configuration
+ */
+static int ske_kp_init(void)
+{
+	int ret, i;
+
+	for (i = 0; i < SKE_KPD_MAX_ROWS; i++) {
+		ret = ske_set_gpio_row(ske_kp_rows[i]);
+		if (ret < 0) {
+			pr_err("ske_kp_init: failed init\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static struct ske_keypad_platform_data ske_keypad_board = {
+	.init           = ske_kp_init,
+	.keymap_data    = &ux500_keymap_data,
+	.no_autorepeat  = true,
+	.krow           = SKE_KPD_MAX_ROWS,     /* 8x8 matrix */
+	.kcol           = SKE_KPD_MAX_COLS,
+	.debounce_ms    = 40,                   /* in millsecs */
+};
+
+
+
 /* add any platform devices here - TODO */
 static struct platform_device *platform_devs[] __initdata = {
 	&u8500_i2c0_device,
 	&ux500_i2c1_device,
 	&ux500_i2c2_device,
 	&ux500_i2c3_device,
+	&ux500_ske_keypad_device,
 };
 
 static void __init u8500_init_machine(void)
@@ -174,6 +302,7 @@ static void __init u8500_init_machine(void)
 	ux500_i2c1_device.dev.platform_data = &u8500_i2c1_data;
 	ux500_i2c2_device.dev.platform_data = &u8500_i2c2_data;
 	ux500_i2c3_device.dev.platform_data = &u8500_i2c3_data;
+	ux500_ske_keypad_device.dev.platform_data = &ske_keypad_board;
 
 	u8500_ssp0_device.dev.platform_data = &ssp0_platform_data;
 
diff --git a/arch/arm/mach-ux500/clock.c b/arch/arm/mach-ux500/clock.c
index d8ab7f1..1675047 100644
--- a/arch/arm/mach-ux500/clock.c
+++ b/arch/arm/mach-ux500/clock.c
@@ -477,6 +477,7 @@ static struct clk_lookup u8500_common_clks[] = {
 	CLK(sdi5,	"sdi5",		NULL),
 	CLK(uart2,	"uart2",	NULL),
 	CLK(ske,	"ske",		NULL),
+	CLK(ske,	"nmk-ske-keypad",	NULL),
 	CLK(sdi2,	"sdi2",		NULL),
 	CLK(i2c0,	"nmk-i2c.0",	NULL),
 	CLK(fsmc,	"fsmc",		NULL),
diff --git a/arch/arm/mach-ux500/devices-db8500.c b/arch/arm/mach-ux500/devices-db8500.c
index 28866b4..d0c5e1e 100644
--- a/arch/arm/mach-ux500/devices-db8500.c
+++ b/arch/arm/mach-ux500/devices-db8500.c
@@ -291,3 +291,24 @@ void dma40_u8500ed_fixup(void)
 	dma40_resources[1].start = U8500_DMA_LCPA_BASE_ED;
 	dma40_resources[1].end = U8500_DMA_LCPA_BASE_ED + 2 * SZ_1K - 1;
 }
+
+struct resource keypad_resources[] = {
+	[0] = {
+		.start = U8500_SKE_BASE,
+		.end = U8500_SKE_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_DB8500_KB,
+		.end = IRQ_DB8500_KB,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device ux500_ske_keypad_device = {
+	.name = "nmk-ske-keypad",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(keypad_resources),
+	.resource = keypad_resources,
+};
+
diff --git a/arch/arm/mach-ux500/include/mach/devices.h b/arch/arm/mach-ux500/include/mach/devices.h
index 33a120c..b91a4d1 100644
--- a/arch/arm/mach-ux500/include/mach/devices.h
+++ b/arch/arm/mach-ux500/include/mach/devices.h
@@ -26,6 +26,7 @@ extern struct platform_device ux500_i2c3_device;
 extern struct platform_device u8500_i2c0_device;
 extern struct platform_device u8500_i2c4_device;
 extern struct platform_device u8500_dma40_device;
+extern struct platform_device ux500_ske_keypad_device;
 
 extern struct amba_device u8500_sdi0_device;
 extern struct amba_device u8500_sdi1_device;
diff --git a/arch/arm/mach-ux500/pins-db8500.h b/arch/arm/mach-ux500/pins-db8500.h
index 66f8761..f923764 100644
--- a/arch/arm/mach-ux500/pins-db8500.h
+++ b/arch/arm/mach-ux500/pins-db8500.h
@@ -459,82 +459,82 @@
 #define GPIO152_KP_O9		PIN_CFG(152, ALT_C)
 
 #define GPIO153_GPIO		PIN_CFG(153, GPIO)
-#define GPIO153_KP_I7		PIN_CFG(153, ALT_A)
+#define GPIO153_KP_I7		PIN_CFG_PULL(153, ALT_A, DOWN)
 #define GPIO153_LCD_D24		PIN_CFG(153, ALT_B)
 #define GPIO153_U2_RXD		PIN_CFG(153, ALT_C)
 
 #define GPIO154_GPIO		PIN_CFG(154, GPIO)
-#define GPIO154_KP_I6		PIN_CFG(154, ALT_A)
+#define GPIO154_KP_I6		PIN_CFG_PULL(154, ALT_A, DOWN)
 #define GPIO154_LCD_D25		PIN_CFG(154, ALT_B)
 #define GPIO154_U2_TXD		PIN_CFG(154, ALT_C)
 
 #define GPIO155_GPIO		PIN_CFG(155, GPIO)
-#define GPIO155_KP_I5		PIN_CFG(155, ALT_A)
+#define GPIO155_KP_I5		PIN_CFG_PULL(155, ALT_A, DOWN)
 #define GPIO155_LCD_D26		PIN_CFG(155, ALT_B)
 #define GPIO155_STMAPE_CLK	PIN_CFG(155, ALT_C)
 
 #define GPIO156_GPIO		PIN_CFG(156, GPIO)
-#define GPIO156_KP_I4		PIN_CFG(156, ALT_A)
+#define GPIO156_KP_I4		PIN_CFG_PULL(156, ALT_A, DOWN)
 #define GPIO156_LCD_D27		PIN_CFG(156, ALT_B)
 #define GPIO156_STMAPE_DAT3	PIN_CFG(156, ALT_C)
 
 #define GPIO157_GPIO		PIN_CFG(157, GPIO)
-#define GPIO157_KP_O7		PIN_CFG(157, ALT_A)
+#define GPIO157_KP_O7		PIN_CFG_PULL(157, ALT_A, UP)
 #define GPIO157_LCD_D28		PIN_CFG(157, ALT_B)
 #define GPIO157_STMAPE_DAT2	PIN_CFG(157, ALT_C)
 
 #define GPIO158_GPIO		PIN_CFG(158, GPIO)
-#define GPIO158_KP_O6		PIN_CFG(158, ALT_A)
+#define GPIO158_KP_O6		PIN_CFG_PULL(158, ALT_A, UP)
 #define GPIO158_LCD_D29		PIN_CFG(158, ALT_B)
 #define GPIO158_STMAPE_DAT1	PIN_CFG(158, ALT_C)
 
 #define GPIO159_GPIO		PIN_CFG(159, GPIO)
-#define GPIO159_KP_O5		PIN_CFG(159, ALT_A)
+#define GPIO159_KP_O5		PIN_CFG_PULL(159, ALT_A, UP)
 #define GPIO159_LCD_D30		PIN_CFG(159, ALT_B)
 #define GPIO159_STMAPE_DAT0	PIN_CFG(159, ALT_C)
 
 #define GPIO160_GPIO		PIN_CFG(160, GPIO)
-#define GPIO160_KP_O4		PIN_CFG(160, ALT_A)
+#define GPIO160_KP_O4		PIN_CFG_PULL(160, ALT_A, UP)
 #define GPIO160_LCD_D31		PIN_CFG(160, ALT_B)
 #define GPIO160_NONE		PIN_CFG(160, ALT_C)
 
 #define GPIO161_GPIO		PIN_CFG(161, GPIO)
-#define GPIO161_KP_I3		PIN_CFG(161, ALT_A)
+#define GPIO161_KP_I3		PIN_CFG_PULL(161, ALT_A, DOWN)
 #define GPIO161_LCD_D32		PIN_CFG(161, ALT_B)
 #define GPIO161_UARTMOD_RXD	PIN_CFG(161, ALT_C)
 
 #define GPIO162_GPIO		PIN_CFG(162, GPIO)
-#define GPIO162_KP_I2		PIN_CFG(162, ALT_A)
+#define GPIO162_KP_I2		PIN_CFG_PULL(162, ALT_A, DOWN)
 #define GPIO162_LCD_D33		PIN_CFG(162, ALT_B)
 #define GPIO162_UARTMOD_TXD	PIN_CFG(162, ALT_C)
 
 #define GPIO163_GPIO		PIN_CFG(163, GPIO)
-#define GPIO163_KP_I1		PIN_CFG(163, ALT_A)
+#define GPIO163_KP_I1		PIN_CFG_PULL(163, ALT_A, DOWN)
 #define GPIO163_LCD_D34		PIN_CFG(163, ALT_B)
 #define GPIO163_STMMOD_CLK	PIN_CFG(163, ALT_C)
 
 #define GPIO164_GPIO		PIN_CFG(164, GPIO)
-#define GPIO164_KP_I0		PIN_CFG(164, ALT_A)
+#define GPIO164_KP_I0		PIN_CFG_PULL(164, ALT_A, UP)
 #define GPIO164_LCD_D35		PIN_CFG(164, ALT_B)
 #define GPIO164_STMMOD_DAT3	PIN_CFG(164, ALT_C)
 
 #define GPIO165_GPIO		PIN_CFG(165, GPIO)
-#define GPIO165_KP_O3		PIN_CFG(165, ALT_A)
+#define GPIO165_KP_O3		PIN_CFG_PULL(165, ALT_A, UP)
 #define GPIO165_LCD_D36		PIN_CFG(165, ALT_B)
 #define GPIO165_STMMOD_DAT2	PIN_CFG(165, ALT_C)
 
 #define GPIO166_GPIO		PIN_CFG(166, GPIO)
-#define GPIO166_KP_O2		PIN_CFG(166, ALT_A)
+#define GPIO166_KP_O2		PIN_CFG_PULL(166, ALT_A, UP)
 #define GPIO166_LCD_D37		PIN_CFG(166, ALT_B)
 #define GPIO166_STMMOD_DAT1	PIN_CFG(166, ALT_C)
 
 #define GPIO167_GPIO		PIN_CFG(167, GPIO)
-#define GPIO167_KP_O1		PIN_CFG(167, ALT_A)
+#define GPIO167_KP_O1		PIN_CFG_PULL(167, ALT_A, UP)
 #define GPIO167_LCD_D38		PIN_CFG(167, ALT_B)
 #define GPIO167_STMMOD_DAT0	PIN_CFG(167, ALT_C)
 
 #define GPIO168_GPIO		PIN_CFG(168, GPIO)
-#define GPIO168_KP_O0		PIN_CFG(168, ALT_A)
+#define GPIO168_KP_O0		PIN_CFG_PULL(168, ALT_A, UP)
 #define GPIO168_LCD_D39		PIN_CFG(168, ALT_B)
 #define GPIO168_NONE		PIN_CFG(168, ALT_C)
 
-- 
1.7.2.dirty

