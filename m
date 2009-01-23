From: "hartleys" <hartleys@visionengravers.com>
Subject: [RFC] Matrix keypad driver for Cirrus EP93xx
Date: Fri, 23 Jan 2009 17:31:10 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909010C9A32@mi8nycmail19.Mi8.com>
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
List-Id: linux-input@vger.kernel.org

New input/keyboard driver for the Cirrus Logic EP93xx keypad matrix
peripheral.

This driver is based on the pxa27x_keypad driver and provides support
for the 8x8 matrix keypad peripheral in the EP93xx ARM SOC.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index 9604928..b2f604e 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -24,10 +24,15 @@
 struct clk {
 	unsigned long	rate;
 	int		users;
+	int		sw_locked;
 	u32		enable_reg;
 	u32		enable_mask;
+
+	int		(*set_rate)(struct clk *clk, unsigned long
rate);
 };
 
+static int set_keyclk(struct clk *clk, unsigned long rate);
+
 static struct clk clk_uart = {
 	.rate		= 14745600,
 };
@@ -40,6 +45,12 @@ static struct clk clk_usb_host = {
 	.enable_reg	= EP93XX_SYSCON_CLOCK_CONTROL,
 	.enable_mask	= EP93XX_SYSCON_CLOCK_USH_EN,
 };
+static struct clk clk_keypad = {
+	.sw_locked	= 1,
+	.enable_reg	= EP93XX_SYSCON_KEY_TCH_CLOCK_DIV,
+	.enable_mask	= EP93XX_SYSCON_KEY_TCH_CLOCK_DIV_KEN,
+	.set_rate	= set_keyclk,
+};
 
 #define INIT_CK(dev,con,ck)					\
 	{ .dev_id = dev, .con_id = con, .clk = ck }
@@ -54,6 +65,7 @@ static struct clk_lookup clocks[] = {
 	INIT_CK(NULL, "pclk", &clk_p),
 	INIT_CK(NULL, "pll2", &clk_pll2),
 	INIT_CK(NULL, "usb_host", &clk_usb_host),
+	INIT_CK("ep93xx-keypad", NULL, &clk_keypad),
 };
 
 
@@ -63,6 +75,8 @@ int clk_enable(struct clk *clk)
 		u32 value;
 
 		value = __raw_readl(clk->enable_reg);
+		if (clk->sw_locked)
+			__raw_writel(0xaa, EP93XX_SYSCON_SWLOCK);
 		__raw_writel(value | clk->enable_mask, clk->enable_reg);
 	}
 
@@ -76,6 +90,8 @@ void clk_disable(struct clk *clk)
 		u32 value;
 
 		value = __raw_readl(clk->enable_reg);
+		if (clk->sw_locked)
+			__raw_writel(0xaa, EP93XX_SYSCON_SWLOCK);
 		__raw_writel(value & ~clk->enable_mask,
clk->enable_reg);
 	}
 }
@@ -87,6 +103,37 @@ unsigned long clk_get_rate(struct clk *clk)
 }
 EXPORT_SYMBOL(clk_get_rate);
 
+static int set_keyclk(struct clk *clk, unsigned long rate)
+{
+	u32 value;
+
+	value = __raw_readl(EP93XX_SYSCON_KEY_TCH_CLOCK_DIV);
+
+	if (rate) {
+		/* Any rate > 0 will result in a 1/4 external clock rate
*/
+		value |= EP93XX_SYSCON_KEY_TCH_CLOCK_DIV_KDIV;
+		rate = EP93XX_EXT_CLK_RATE / 4;
+	} else {
+		/* A rate of 0 will result in a 1/16 external clock rate
*/
+		value &= ~EP93XX_SYSCON_KEY_TCH_CLOCK_DIV_KDIV;
+		rate = EP93XX_EXT_CLK_RATE / 16;
+	}
+
+	__raw_writel(0xaa, EP93XX_SYSCON_SWLOCK);
+	__raw_writel(value, EP93XX_SYSCON_KEY_TCH_CLOCK_DIV);
+
+	clk->rate = rate;
+
+	return 0;
+}
+int clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	if (clk->set_rate)
+		return clk->set_rate(clk, rate);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(clk_set_rate);
 
 static char fclk_divisors[] = { 1, 2, 4, 8, 16, 1, 1, 1 };
 static char hclk_divisors[] = { 1, 2, 4, 5, 6, 8, 16, 32 };
diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
index 22d6c9a..5664ec7 100644
--- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
+++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
@@ -139,6 +139,7 @@
 #define EP93XX_UART3_PHYS_BASE		(EP93XX_APB_PHYS_BASE +
0x000e0000)
 
 #define EP93XX_KEY_MATRIX_BASE		(EP93XX_APB_VIRT_BASE +
0x000f0000)
+#define EP93XX_KEY_MATRIX_PHYS_BASE	(EP93XX_APB_PHYS_BASE +
0x000f0000)
 
 #define EP93XX_ADC_BASE			(EP93XX_APB_VIRT_BASE +
0x00100000)
 #define EP93XX_TOUCHSCREEN_BASE		(EP93XX_APB_VIRT_BASE +
0x00100000)
@@ -159,6 +160,11 @@
 #define EP93XX_SYSCON_CLOCK_SET2	EP93XX_SYSCON_REG(0x24)
 #define EP93XX_SYSCON_DEVICE_CONFIG	EP93XX_SYSCON_REG(0x80)
 #define EP93XX_SYSCON_DEVICE_CONFIG_CRUNCH_ENABLE	0x00800000
+#define EP93XX_SYSCON_KEY_TCH_CLOCK_DIV	EP93XX_SYSCON_REG(0x90)
+#define EP93XX_SYSCON_KEY_TCH_CLOCK_DIV_TSEN	(1<<31)
+#define EP93XX_SYSCON_KEY_TCH_CLOCK_DIV_ADIV	(1<<16)
+#define EP93XX_SYSCON_KEY_TCH_CLOCK_DIV_KEN	(1<<15)
+#define EP93XX_SYSCON_KEY_TCH_CLOCK_DIV_KDIV	(1<<0)
 #define EP93XX_SYSCON_SWLOCK		EP93XX_SYSCON_REG(0xc0)
 
 #define EP93XX_WATCHDOG_BASE		(EP93XX_APB_VIRT_BASE +
0x00140000)
diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx_keypad.h
b/arch/arm/mach-ep93xx/include/mach/ep93xx_keypad.h
new file mode 100644
index 0000000..3dd15d5
--- /dev/null
+++ b/arch/arm/mach-ep93xx/include/mach/ep93xx_keypad.h
@@ -0,0 +1,35 @@
+/*
+ * arch/arm/mach-ep93xx/include/mach/ep93xx_keypad.h
+ */
+
+#ifndef __ASM_ARCH_EP93XX_KEYPAD_H
+#define __ASM_ARCH_EP93XX_KEYPAD_H
+
+/* flags for the ep93xx_keypad driver */
+#define EP93XX_KEYPAD_DISABLE_3_KEY	(1<<0)	/* disable 3-key reset
*/
+#define EP93XX_KEYPAD_DIAG_MODE		(1<<1)	/* diagnostic
mode */
+#define EP93XX_KEYPAD_BACK_DRIVE	(1<<2)	/* back driving mode */
+#define EP93XX_KEYPAD_TEST_MODE		(1<<3)	/* scan only
column 0 */
+#define EP93XX_KEYPAD_KDIV		(1<<4)	/* 1/4 clock or 1/16
clock */
+#define EP93XX_KEYPAD_AUTOREPEAT	(1<<5)	/* enable key autorepeat
*/
+
+/**
+ * struct ep93xx_keypad_platform_data - platform specific device
structure
+ * @matrix_key_map:		array of keycodes defining the keypad
matrix
+ * @matrix_key_map_size:	ARRAY_SIZE(matrix_key_map)
+ * @debounce:			debounce start count; terminal count is
0xff
+ * @prescale:			row/column counter pre-scaler load value
+ * @flags:			see above
+ */
+struct ep93xx_keypad_platform_data {
+	unsigned int	*matrix_key_map;
+	int		matrix_key_map_size;
+	unsigned int	debounce;
+	unsigned int	prescale;
+	unsigned int	flags;
+};
+
+/* macro for creating the matrix_key_map table */
+#define KEY(row, col, val)	(((row) << 28) | ((col) << 24) | (val))
+
+#endif	/* __ASM_ARCH_EP93XX_KEYPAD_H */
diff --git a/drivers/input/keyboard/Kconfig
b/drivers/input/keyboard/Kconfig
index 3556168..6153a4f 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -332,4 +332,14 @@ config KEYBOARD_SH_KEYSC
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called sh_keysc.
+
+config KEYBOARD_EP93XX
+	tristate "EP93xx Matrix Keypad support"
+	depends on ARCH_EP93XX
+	help
+	  Say Y here to enable the matrix keypad on the Cirrus EP93XX.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ep93xx_keypad.
+
 endif
diff --git a/drivers/input/keyboard/Makefile
b/drivers/input/keyboard/Makefile
index 36351e1..13ba9c9 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -28,3 +28,4 @@ obj-$(CONFIG_KEYBOARD_HP7XX)		+=
jornada720_kbd.o
 obj-$(CONFIG_KEYBOARD_MAPLE)		+= maple_keyb.o
 obj-$(CONFIG_KEYBOARD_BFIN)		+= bf54x-keys.o
 obj-$(CONFIG_KEYBOARD_SH_KEYSC)		+= sh_keysc.o
+obj-$(CONFIG_KEYBOARD_EP93XX)		+= ep93xx_keypad.o
diff --git a/drivers/input/keyboard/ep93xx_keypad.c
b/drivers/input/keyboard/ep93xx_keypad.c
new file mode 100644
index 0000000..6e82049
--- /dev/null
+++ b/drivers/input/keyboard/ep93xx_keypad.c
@@ -0,0 +1,455 @@
+/*
+ * Driver for the Cirrus EP93xx matrix keypad controller.
+ *
+ * Copyright (c) 2008 H Hartley Sweeten <hsweeten@visionengravers.com>
+ *
+ * Based on the pxa27x matrix keypad controller by Rodolfo Giometti.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * NOTE:
+ *
+ * The 3-key reset is triggered by pressing the 3 keys in
+ * Row 0, Columns 2, 4, and 7 at the same time.  This action can
+ * be disabled by setting the EP93XX_KEYPAD_DISABLE_3_KEY flag.
+ *
+ * Normal operation for the matrix does not autorepeat the key press.
+ * This action can be enabled by setting the EP93XX_KEYPAD_AUTOREPEAT
+ * flag.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+#include <linux/clk.h>
+
+#include <mach/hardware.h>
+#include <mach/gpio.h>
+#include <mach/ep93xx_keypad.h>
+
+/*
+ * Keypad Interface Register offsets
+ */
+#define KEY_INIT		0x00	/* Key Scan Initialization
register */
+#define KEY_DIAG		0x04	/* Key Scan Diagnostic register
*/
+#define KEY_REG			0x08	/* Key Value Capture
register */
+
+struct ep93xx_keypad {
+	struct ep93xx_keypad_platform_data *pdata;
+
+	struct clk *clk;
+	struct input_dev *input_dev;
+	void __iomem *mmio_base;
+
+	int irq;
+	int enabled;
+
+	int key1;
+	int key2;
+
+	unsigned int matrix_keycodes[8*8];
+};
+
+static void ep93xx_keypad_build_keycode(struct ep93xx_keypad *keypad)
+{
+	struct ep93xx_keypad_platform_data *pdata = keypad->pdata;
+	struct input_dev *input_dev = keypad->input_dev;
+	unsigned int *key;
+	int i;
+
+	key = &pdata->matrix_key_map[0];
+	for (i = 0; i < pdata->matrix_key_map_size; i++, key++) {
+		int row = ((*key) >> 28) & 0xf;
+		int col = ((*key) >> 24) & 0xf;
+		int code = (*key) & 0xffffff;
+
+		keypad->matrix_keycodes[(row << 3) + col] = code;
+		set_bit(code, input_dev->keybit);
+	}
+}
+
+static void ep93xx_keypad_handle_key(struct ep93xx_keypad *keypad,
+				int key, int press)
+{
+	struct input_dev *input_dev = keypad->input_dev;
+
+	if (key) {
+		input_report_key(input_dev, key, press);
+		input_sync(input_dev);
+	}
+}
+
+static void ep93xx_keypad_key1_release(struct ep93xx_keypad *keypad)
+{
+	ep93xx_keypad_handle_key(keypad, keypad->key1, 0);
+	keypad->key1 = 0;
+}
+
+static void ep93xx_keypad_key2_release(struct ep93xx_keypad *keypad)
+{
+	ep93xx_keypad_handle_key(keypad, keypad->key2, 0);
+	keypad->key2 = 0;
+}
+
+static void ep93xx_keypad_key1_press(struct ep93xx_keypad *keypad, int
key)
+{
+	ep93xx_keypad_handle_key(keypad, key, 1);
+	keypad->key1 = key;
+}
+
+static void ep93xx_keypad_key2_press(struct ep93xx_keypad *keypad, int
key)
+{
+	ep93xx_keypad_handle_key(keypad, key, 1);
+	keypad->key2 = key;
+}
+
+static void ep93xx_keypad_scan_1key(struct ep93xx_keypad *keypad, int
key)
+{
+	if (keypad->key1 && key != keypad->key1)
+		ep93xx_keypad_key1_release(keypad);
+
+	if (keypad->key2 && key != keypad->key2)
+		ep93xx_keypad_key2_release(keypad);
+
+	ep93xx_keypad_key1_press(keypad, key);
+}
+
+static void ep93xx_keypad_scan_2keys(struct ep93xx_keypad *keypad,
+				int key1, int key2)
+{
+	if (keypad->key1 && key1 != keypad->key1 && key2 !=
keypad->key1)
+		ep93xx_keypad_key1_release(keypad);
+
+	if (keypad->key2 && key1 != keypad->key2 && key2 !=
keypad->key2)
+		ep93xx_keypad_key2_release(keypad);
+
+	if (key1 != keypad->key1 && key1 != keypad->key2)
+		ep93xx_keypad_key1_press(keypad, key1);
+
+	if (key2 != keypad->key2 && key2 != keypad->key2)
+		ep93xx_keypad_key2_press(keypad, key2);
+}
+
+static irqreturn_t ep93xx_keypad_irq_handler(int irq, void *dev_id)
+{
+	struct ep93xx_keypad *keypad = dev_id;
+	unsigned int status;
+	int keycode, key1, key2;
+
+	status = __raw_readl(keypad->mmio_base + KEY_REG);
+
+	keycode = (status & 0x0000003f) >> 0;
+	key1 = keypad->matrix_keycodes[keycode];
+
+	keycode = (status & 0x00000fc0) >> 6;
+	key2 = keypad->matrix_keycodes[keycode];
+
+	if (status & (1<<13)) {
+		ep93xx_keypad_scan_2keys(keypad, key1, key2);
+	} else if (status & (1<<12)) {
+		ep93xx_keypad_scan_1key(keypad, key1);
+	} else {
+		if (keypad->key1)
+			ep93xx_keypad_key1_release(keypad);
+		if (keypad->key2)
+			ep93xx_keypad_key2_release(keypad);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void ep93xx_keypad_config(struct ep93xx_keypad *keypad)
+{
+	struct ep93xx_keypad_platform_data *pdata = keypad->pdata;
+	unsigned int val = 0;
+
+	/*
+	 * Set the peripheral clock rate based on the passed platform
data.
+	 * EP93XX_KEYPAD_KDIV == 0 -> clock = 1/16 external clock rate
+	 * EP93XX_KEYPAD_KDIV == 1 -> clock = 1/4 external clock rate
+	 */
+	clk_set_rate(keypad->clk, pdata->flags & EP93XX_KEYPAD_KDIV);
+
+	/*
+	 * Set the Key Scan Initialization Register
+	 * based on the the passed platform data.
+	 */
+	if (pdata->flags & EP93XX_KEYPAD_DISABLE_3_KEY)
+		val |= (1<<15);
+	if (pdata->flags & EP93XX_KEYPAD_DIAG_MODE)
+		val |= (1<<14);
+	if (pdata->flags & EP93XX_KEYPAD_BACK_DRIVE)
+		val |= (1<<13);
+	if (pdata->flags & EP93XX_KEYPAD_TEST_MODE)
+		val |= (1<<12);
+	val |= ((pdata->debounce << 16) & 0x00ff0000);
+	val |= ((pdata->prescale << 0) & 0x000003ff);
+
+	__raw_writel(val, keypad->mmio_base + KEY_INIT);
+}
+
+static int ep93xx_keypad_open(struct input_dev *pdev)
+{
+	struct ep93xx_keypad *keypad = input_get_drvdata(pdev);
+
+	if (!keypad->enabled) {
+		ep93xx_keypad_config(keypad);
+		clk_enable(keypad->clk);
+		keypad->enabled = 1;
+	}
+
+	return 0;
+}
+
+static void ep93xx_keypad_close(struct input_dev *pdev)
+{
+	struct ep93xx_keypad *keypad = input_get_drvdata(pdev);
+
+	if (keypad->enabled) {
+		clk_disable(keypad->clk);
+		keypad->enabled = 0;
+	}
+}
+
+
+#ifdef CONFIG_PM
+/*
+ * NOTE: I don't know if this is correct, or will work on the ep93xx.
+ *
+ * None of the existing ep93xx drivers have power management support.
+ * But, this is basically what the pxa27x_keypad driver does.
+ */
+static int ep93xx_keypad_suspend(struct platform_device *pdev,
+				pm_message_t state)
+{
+	struct ep93xx_keypad *keypad = platform_get_drvdata(pdev);
+
+	if (keypad->enabled) {
+		clk_disable(keypad->clk);
+		keypad->enabled = 0;
+	}
+
+	if (device_may_wakeup(&pdev->dev))
+		enable_irq_wake(keypad->irq);
+
+	return 0;
+}
+
+static int ep93xx_keypad_resume(struct platform_device *pdev)
+{
+	struct ep93xx_keypad *keypad = platform_get_drvdata(pdev);
+	struct input_dev *input_dev = keypad->input_dev;
+
+	if (device_may_wakeup(&pdev->dev))
+		disable_irq_wake(keypad->irq);
+
+	mutex_lock(&input_dev->mutex);
+
+	if (input_dev->users) {
+		if (!keypad->enabled) {
+			ep93xx_keypad_config(keypad);
+			clk_enable(keypad->clk);
+			keypad->enabled = 1;
+		}
+	}
+
+	mutex_unlock(&input_dev->mutex);
+
+	return 0;
+}
+#else	/* !CONFIG_PM */
+#define ep93xx_keypad_suspend	NULL
+#define ep93xx_keypad_resume	NULL
+#endif	/* !CONFIG_PM */
+
+static int __devinit ep93xx_keypad_probe(struct platform_device *pdev)
+{
+	struct ep93xx_keypad *keypad;
+	struct input_dev *input_dev;
+	struct resource *res;
+	int irq, err, i, gpio;
+
+	keypad = kzalloc(sizeof(struct ep93xx_keypad), GFP_KERNEL);
+	if (keypad == NULL)
+		return -ENOMEM;
+
+	keypad->pdata = pdev->dev.platform_data;
+	if (keypad->pdata == NULL) {
+		err = -EINVAL;
+		goto failed_free;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		err = -ENXIO;
+		goto failed_free;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		err = -ENXIO;
+		goto failed_free;
+	}
+
+	res = request_mem_region(res->start, resource_size(res),
pdev->name);
+	if (res == NULL) {
+		err = -EBUSY;
+		goto failed_free;
+	}
+
+	keypad->mmio_base = ioremap(res->start, resource_size(res));
+	if (keypad->mmio_base == NULL) {
+		err = -ENXIO;
+		goto failed_free_mem;
+	}
+
+	/* Request the needed GPIO's */
+	gpio = EP93XX_GPIO_LINE_ROW0;
+	for (i = 0; i < 8; i++, gpio++) {
+		err = gpio_request(gpio, pdev->name);
+		if (err)
+			goto failed_free_rows;
+	}
+	gpio = EP93XX_GPIO_LINE_COL0;
+	for (i = 0; i < 8; i++, gpio++) {
+		err = gpio_request(gpio, pdev->name);
+		if (err)
+			goto failed_free_cols;
+	}
+
+	keypad->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(keypad->clk)) {
+		err = PTR_ERR(keypad->clk);
+		goto failed_free_io;
+	}
+
+	input_dev = input_allocate_device();
+	if (!input_dev) {
+		err = -ENOMEM;
+		goto failed_put_clk;
+	}
+
+	input_dev->name = pdev->name;
+	input_dev->id.bustype = BUS_HOST;
+	input_dev->open = ep93xx_keypad_open;
+	input_dev->close = ep93xx_keypad_close;
+	input_dev->dev.parent = &pdev->dev;
+
+	keypad->input_dev = input_dev;
+	input_set_drvdata(input_dev, keypad);
+
+	input_dev->evbit[0] = BIT_MASK(EV_KEY);
+	if (keypad->pdata->flags & EP93XX_KEYPAD_AUTOREPEAT)
+		input_dev->evbit[0] |= BIT_MASK(EV_REP);
+
+	ep93xx_keypad_build_keycode(keypad);
+	platform_set_drvdata(pdev, keypad);
+
+	err = request_irq(irq, ep93xx_keypad_irq_handler, IRQF_DISABLED,
+				pdev->name, keypad);
+	if (err)
+		goto failed_free_dev;
+
+	keypad->irq = irq;
+
+	err = input_register_device(input_dev);
+	if (err)
+		goto failed_free_irq;
+
+	device_init_wakeup(&pdev->dev, 1);
+
+	return 0;
+
+failed_free_irq:
+	free_irq(irq, pdev);
+	platform_set_drvdata(pdev, NULL);
+failed_free_dev:
+	input_free_device(input_dev);
+failed_put_clk:
+	clk_put(keypad->clk);
+failed_free_io:
+	i = 8 - 1;
+	gpio = EP93XX_GPIO_LINE_COL0 + i;
+failed_free_cols:
+	for ( ; i >= 0; i--, gpio--)
+		gpio_free(gpio);
+	i = 8 - 1;
+	gpio = EP93XX_GPIO_LINE_ROW0 + i;
+failed_free_rows:
+	for ( ; i >= 0; i--, gpio--)
+		gpio_free(gpio);
+	iounmap(keypad->mmio_base);
+failed_free_mem:
+	release_mem_region(res->start, resource_size(res));
+failed_free:
+	kfree(keypad);
+	return err;
+}
+
+static int __devexit ep93xx_keypad_remove(struct platform_device *pdev)
+{
+	struct ep93xx_keypad *keypad = platform_get_drvdata(pdev);
+	struct resource *res;
+	int i, gpio;
+
+	free_irq(keypad->irq, pdev);
+
+	platform_set_drvdata(pdev, NULL);
+
+	if (keypad->enabled)
+		clk_disable(keypad->clk);
+	clk_put(keypad->clk);
+
+	input_unregister_device(keypad->input_dev);
+	input_free_device(keypad->input_dev);
+
+	i = 8 - 1;
+	gpio = EP93XX_GPIO_LINE_COL0 + i;
+	for ( ; i >= 0; i--, gpio--)
+		gpio_free(gpio);
+
+	i = 8 - 1;
+	gpio = EP93XX_GPIO_LINE_ROW0 + i;
+	for ( ; i >= 0; i--, gpio--)
+		gpio_free(gpio);
+
+	iounmap(keypad->mmio_base);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(res->start, resource_size(res));
+
+	kfree(keypad);
+
+	return 0;
+}
+
+static struct platform_driver ep93xx_keypad_driver = {
+	.driver		= {
+		.name	= "ep93xx-keypad",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= ep93xx_keypad_probe,
+	.remove		= __devexit_p(ep93xx_keypad_remove),
+	.suspend	= ep93xx_keypad_suspend,
+	.resume		= ep93xx_keypad_resume,
+};
+
+static int __init ep93xx_keypad_init(void)
+{
+	return platform_driver_register(&ep93xx_keypad_driver);
+}
+
+static void __exit ep93xx_keypad_exit(void)
+{
+	platform_driver_unregister(&ep93xx_keypad_driver);
+}
+
+module_init(ep93xx_keypad_init);
+module_exit(ep93xx_keypad_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("H Hartley Sweeten <hsweeten@visionengravers.com>");
+MODULE_DESCRIPTION("EP93xx 8x8 Matrix Keypad Controller");
+MODULE_ALIAS("platform:ep93xx-keypad"); 

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
