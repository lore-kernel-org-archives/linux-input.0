From: Gerhard Sittig <gsi@denx.de>
Subject: [PATCH v1 04/12] input: matrix-keypad: push/pull, separate polarity
Date: Fri, 21 Jun 2013 20:09:50 +0200
Message-ID: <1371838198-7327-5-git-send-email-gsi@denx.de>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:59961 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423562Ab3FUSKU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Jun 2013 14:10:20 -0400
In-Reply-To: <1371838198-7327-1-git-send-email-gsi@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Chao Xie <xiechao.mail@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>, Marek Vasut <marek.vasut@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Anatolij Gustschin <agust@denx.de>, Detlev Zundel <dzu@denx.de>, Gerhard Sittig <gsi@denx.de>

extend the device tree adjustable hardware configuration:
- allow for differing polarity of the row and column GPIO pins
- optionally fully drive column output pins instead of the former
  unconditional open collector emulation approach

this change introduces individual polarity settings for the row
pins as well as the column pins, to achieve this separate members
in the platform data bundle get introduced, and all places which
fill in the platform data receive an update -- the result is
complete backwards compatibility with existing matrix drivers and
an improvement for newly written code which needs the individual
polarity settings

this change allows optional support to fully drive the column
selection pins, but by default sticks with the former behaviour
of driving the active level and being passive for the inactive
level, so
- unadjusted configurations keep operating the hardware in an
  identical manner
- adjusted or newly configured hardware will be operated
  according to the configuration, which now allows for either
  setups with pull resistors or mere connections between logic

so this change doesn't break existing behaviour, is neutral for
unadjusted code or configurations, and is an improvement in those
areas where the former implementations was restricted

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 .../bindings/input/gpio-matrix-keypad.txt          |   18 +++++++++
 arch/arm/mach-davinci/board-tnetv107x-evm.c        |    3 +-
 arch/arm/mach-omap2/board-h4.c                     |    3 +-
 arch/arm/mach-pxa/palmtc.c                         |    3 +-
 arch/mips/jz4740/board-qi_lb60.c                   |    3 +-
 drivers/input/keyboard/matrix_keypad.c             |   39 +++++++++++++++++---
 include/linux/input/matrix_keypad.h                |    9 ++++-
 7 files changed, 66 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
index 11d030e..e6a01eb 100644
--- a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
+++ b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
@@ -27,6 +27,14 @@ More involved matrix layouts may include externally connected line
 drivers and might influence signal polarity.  The driver supports low
 active signals, while high active line levels are assumed by default.
 
+Since output drivers and input drivers may exist independently from each
+other and may or may not invert signals, polarity for row pins and for
+column pins is adjustable individually.  The initial implementation of
+the driver used to emulate some kind of an open collector behaviour in
+software, which makes signals float in the absence of pull up resistors.
+To fully drive output signals in either direction, enable push/pull mode
+for column pins.  This option is off by default for compatibility.
+
 Required Properties:
 - compatible:		Should be "gpio-matrix-keypad"
 - row-gpios:		List of gpios used as row lines. The gpio specifier
@@ -52,7 +60,17 @@ Optional Properties:
 			such that pin levels can settle after
 			propagating through the matrix and its
 			associated hardware components
+- row-gpios-activelow:	row GPIO pins are active low
+- col-gpios-activelow:	column GPIO pins are active low
 - gpio-activelow:	row pins as well as column pins are active low
+			(provided for backward compatibility, and useful
+			for matrix layouts of identical polarity for
+			rows and columns)
+- col-gpios-pushpull:	fully drive the column selection pins in either
+			direction (high and low signals), the default
+			behaviour is to actively drive low signals and
+			be passive otherwise (emulates an open collector
+			output driver)
 
 Example:
 	matrix-keypad {
diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
index ba79837..d41bd8a 100644
--- a/arch/arm/mach-davinci/board-tnetv107x-evm.c
+++ b/arch/arm/mach-davinci/board-tnetv107x-evm.c
@@ -199,7 +199,8 @@ static struct matrix_keypad_platform_data keypad_config = {
 	.num_row_gpios	= 6,
 	.num_col_gpios	= 5,
 	.debounce_ms	= 0, /* minimum */
-	.active_low	= 0, /* pull up realization */
+	.col_gpios_active_low	= 0, /* pull up realization */
+	.row_gpios_active_low	= 0, /* pull up realization */
 	.no_autorepeat	= 0,
 };
 
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 69c0acf..78c91cd 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -97,7 +97,8 @@ static struct matrix_keypad_platform_data board_keypad_platform_data = {
 	.num_row_gpios	= ARRAY_SIZE(board_keypad_row_gpios),
 	.col_gpios	= board_keypad_col_gpios,
 	.num_col_gpios	= ARRAY_SIZE(board_keypad_col_gpios),
-	.active_low	= 1,
+	.col_gpios_active_low	= 1,
+	.row_gpios_active_low	= 1,
 
 	.debounce_ms		= 20,
 	.col_scan_delay_us	= 5,
diff --git a/arch/arm/mach-pxa/palmtc.c b/arch/arm/mach-pxa/palmtc.c
index 100b176f..4767563 100644
--- a/arch/arm/mach-pxa/palmtc.c
+++ b/arch/arm/mach-pxa/palmtc.c
@@ -314,7 +314,8 @@ static struct matrix_keypad_platform_data palmtc_keypad_platform_data = {
 	.num_row_gpios	= ARRAY_SIZE(palmtc_keypad_row_gpios),
 	.col_gpios	= palmtc_keypad_col_gpios,
 	.num_col_gpios	= ARRAY_SIZE(palmtc_keypad_col_gpios),
-	.active_low	= 1,
+	.col_gpios_active_low	= 1,
+	.row_gpios_active_low	= 1,
 
 	.debounce_ms		= 20,
 	.col_scan_delay_us	= 5,
diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index be2b3de..4235ca2 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -250,7 +250,8 @@ static struct matrix_keypad_platform_data qi_lb60_pdata = {
 	.col_scan_delay_us	= 10,
 	.debounce_ms		= 10,
 	.wakeup			= 1,
-	.active_low		= 1,
+	.col_gpios_active_low	= 1,
+	.row_gpios_active_low	= 1,
 };
 
 static struct platform_device qi_lb60_keypad = {
diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 5b5f86d..4f22149 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -43,20 +43,37 @@ struct matrix_keypad {
 };
 
 /*
+ * former comment before introduction of optional push/pull behaviour:
+ * <cite>
  * NOTE: normally the GPIO has to be put into HiZ when de-activated to cause
  * minmal side effect when scanning other columns, here it is configured to
  * be input, and it should work on most platforms.
+ * </cite>
+ *
+ * the above sounds a lot like emulating open collector (open drain)
+ * behaviour in software, which should only be required if the GPIO pin
+ * lacks such a mode, which should be rare and could be hidden by
+ * transparent support in the GPIO chip driver, or could be handled by
+ * attaching an external transistor to the pin, which is cheap and in
+ * addition avoids damage in the hardware caused by running the wrong
+ * software configuration
+ *
+ * applying the "turn to input" logic unconditionally breaks hardware
+ * setups which have no pull resistors (i.e. where outputs are directly
+ * connected to the matrix or to external matrix line drivers), and
+ * could make input signals float and become unreliable
  */
 static void __activate_col_pin(const struct matrix_keypad_platform_data *pdata,
 			       int col, bool on)
 {
-	bool level_on = !pdata->active_low;
+	bool level_on = !pdata->col_gpios_active_low;
 
 	if (on) {
 		gpio_direction_output(pdata->col_gpios[col], level_on);
 	} else {
 		gpio_set_value_cansleep(pdata->col_gpios[col], !level_on);
-		gpio_direction_input(pdata->col_gpios[col]);
+		if (!pdata->col_gpios_push_pull)
+			gpio_direction_input(pdata->col_gpios[col]);
 	}
 }
 
@@ -82,7 +99,8 @@ static bool row_asserted(const struct matrix_keypad_platform_data *pdata,
 			 int row)
 {
 	return gpio_get_value_cansleep(pdata->row_gpios[row]) ?
-			!pdata->active_low : pdata->active_low;
+			!pdata->row_gpios_active_low :
+			pdata->row_gpios_active_low;
 }
 
 static void enable_row_irqs(struct matrix_keypad *keypad)
@@ -317,7 +335,8 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 			goto err_free_cols;
 		}
 
-		gpio_direction_output(pdata->col_gpios[i], !pdata->active_low);
+		gpio_direction_output(pdata->col_gpios[i],
+				      !pdata->col_gpios_active_low);
 	}
 
 	for (i = 0; i < pdata->num_row_gpios; i++) {
@@ -427,8 +446,16 @@ matrix_keypad_parse_dt(struct device *dev)
 		pdata->no_autorepeat = true;
 	if (of_get_property(np, "linux,wakeup", NULL))
 		pdata->wakeup = true;
-	if (of_get_property(np, "gpio-activelow", NULL))
-		pdata->active_low = true;
+	if (of_get_property(np, "col-gpios-activelow", NULL))
+		pdata->col_gpios_active_low = true;
+	if (of_get_property(np, "row-gpios-activelow", NULL))
+		pdata->row_gpios_active_low = true;
+	if (of_get_property(np, "gpio-activelow", NULL)) {
+		pdata->row_gpios_active_low = true;
+		pdata->col_gpios_active_low = true;
+	}
+	if (of_get_property(np, "col-gpios-pushpull", NULL))
+		pdata->col_gpios_push_pull = true;
 
 	of_property_read_u32(np, "debounce-delay-ms", &pdata->debounce_ms);
 	of_property_read_u32(np, "col-scan-delay-us",
diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
index 27e06ac..5496a00 100644
--- a/include/linux/input/matrix_keypad.h
+++ b/include/linux/input/matrix_keypad.h
@@ -45,7 +45,10 @@ struct matrix_keymap_data {
  * @clustered_irq: may be specified if interrupts of all row/column GPIOs
  *	are bundled to one single irq
  * @clustered_irq_flags: flags that are needed for the clustered irq
- * @active_low: gpio polarity
+ * @row_gpios_active_low: polarity of row gpio pins
+ * @col_gpios_active_low: polarity of column gpio pins
+ * @col_gpios_push_pull: whether column gpio pins emulate open drain
+ *	behaviour or fully drive pin levels to either direction
  * @wakeup: controls whether the device should be set up as wakeup
  *	source
  * @no_autorepeat: disable key autorepeat
@@ -70,7 +73,9 @@ struct matrix_keypad_platform_data {
 	unsigned int	clustered_irq;
 	unsigned int	clustered_irq_flags;
 
-	bool		active_low;
+	bool		row_gpios_active_low;
+	bool		col_gpios_active_low;
+	bool		col_gpios_push_pull;
 	bool		wakeup;
 	bool		no_autorepeat;
 };
-- 
1.7.10.4

