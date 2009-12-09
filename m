From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: [PATCH] ep93xx_keypad.c: update driver to new core support
Date: Wed, 9 Dec 2009 17:20:53 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901FB0DB6@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6og115.obsmtp.com ([64.18.1.35]:33202 "EHLO
	exprod6og115.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756054AbZLIW1v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Dec 2009 17:27:51 -0500
Content-class: urn:content-classes:message
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

ep93xx_keypad.c: update driver to new core support

This driver was merged before the ep93xx core support was added
for the keypad clock and acquiring/releasing the necessary gpio's.
Now that the proper support is in the ep93xx core this driver
needs to be updated to work correctly.

Summary of changes:
  1) Remove some unused members from the platform data.
  2) Remove the custom KEY macro and use the ones available in
     <linux/input/matrix_keypad.h>
  3) Remove the keypad_{readl/writel} macros and just use
     __raw_{readl/writel} directly.
  4) Update the clk_set_rate() call to work with the core support.
  5) Cleanup the probe routine and remove some unneeded messages.
  6) Use the ep93xx core functions to acquire and release the gpio's.
  7) Fix the clk_get() call to get the keypad clock.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

---

diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx_keypad.h b/arch/arm/mach-ep93xx/include/mach/ep93xx_keypad.h
index 83f31cd..62d1742 100644
--- a/arch/arm/mach-ep93xx/include/mach/ep93xx_keypad.h
+++ b/arch/arm/mach-ep93xx/include/mach/ep93xx_keypad.h
@@ -5,9 +5,6 @@
 #ifndef __ASM_ARCH_EP93XX_KEYPAD_H
 #define __ASM_ARCH_EP93XX_KEYPAD_H
 
-#define MAX_MATRIX_KEY_ROWS		(8)
-#define MAX_MATRIX_KEY_COLS		(8)
-
 /* flags for the ep93xx_keypad driver */
 #define EP93XX_KEYPAD_DISABLE_3_KEY	(1<<0)	/* disable 3-key reset */
 #define EP93XX_KEYPAD_DIAG_MODE		(1<<1)	/* diagnostic mode */
@@ -18,8 +15,6 @@
 
 /**
  * struct ep93xx_keypad_platform_data - platform specific device structure
- * @matrix_key_rows:		number of rows in the keypad matrix
- * @matrix_key_cols:		number of columns in the keypad matrix
  * @matrix_key_map:		array of keycodes defining the keypad matrix
  * @matrix_key_map_size:	ARRAY_SIZE(matrix_key_map)
  * @debounce:			debounce start count; terminal count is 0xff
@@ -27,8 +22,6 @@
  * @flags:			see above
  */
 struct ep93xx_keypad_platform_data {
-	unsigned int	matrix_key_rows;
-	unsigned int	matrix_key_cols;
 	unsigned int	*matrix_key_map;
 	int		matrix_key_map_size;
 	unsigned int	debounce;
@@ -36,7 +29,7 @@ struct ep93xx_keypad_platform_data {
 	unsigned int	flags;
 };
 
-/* macro for creating the matrix_key_map table */
-#define KEY(row, col, val)	(((row) << 28) | ((col) << 24) | (val))
+#define EP93XX_MATRIX_ROWS		(8)
+#define EP93XX_MATRIX_COLS		(8)
 
 #endif	/* __ASM_ARCH_EP93XX_KEYPAD_H */
diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
index 181d30e..a5d8508 100644
--- a/drivers/input/keyboard/ep93xx_keypad.c
+++ b/drivers/input/keyboard/ep93xx_keypad.c
@@ -22,11 +22,11 @@
 
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
-#include <linux/input.h>
 #include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/input/matrix_keypad.h>
 
 #include <mach/hardware.h>
-#include <mach/gpio.h>
 #include <mach/ep93xx_keypad.h>
 
 /*
@@ -60,38 +60,36 @@
 #define KEY_REG_KEY1_MASK	(0x0000003f)
 #define KEY_REG_KEY1_SHIFT	(0)
 
-#define keypad_readl(off)	__raw_readl(keypad->mmio_base + (off))
-#define keypad_writel(v, off)	__raw_writel((v), keypad->mmio_base + (off))
-
-#define MAX_MATRIX_KEY_NUM	(MAX_MATRIX_KEY_ROWS * MAX_MATRIX_KEY_COLS)
+#define EP93XX_MATRIX_SIZE	(EP93XX_MATRIX_ROWS * EP93XX_MATRIX_COLS)
 
 struct ep93xx_keypad {
 	struct ep93xx_keypad_platform_data *pdata;
-
-	struct clk *clk;
 	struct input_dev *input_dev;
+	struct clk *clk;
+
 	void __iomem *mmio_base;
 
-	int irq;
-	int enabled;
+	unsigned int matrix_keycodes[EP93XX_MATRIX_SIZE];
 
 	int key1;
 	int key2;
 
-	unsigned int matrix_keycodes[MAX_MATRIX_KEY_NUM];
+	int enabled;
+	int irq;
 };
 
 static void ep93xx_keypad_build_keycode(struct ep93xx_keypad *keypad)
 {
 	struct ep93xx_keypad_platform_data *pdata = keypad->pdata;
 	struct input_dev *input_dev = keypad->input_dev;
+	unsigned int *key;
 	int i;
 
-	for (i = 0; i < pdata->matrix_key_map_size; i++) {
-		unsigned int key = pdata->matrix_key_map[i];
-		int row = (key >> 28) & 0xf;
-		int col = (key >> 24) & 0xf;
-		int code = key & 0xffffff;
+	key = &pdata->matrix_key_map[0];
+	for (i = 0; i < pdata->matrix_key_map_size; i++, key++) {
+		int row = KEY_ROW(*key);
+		int col = KEY_COL(*key);
+		int code = KEY_VAL(*key);
 
 		keypad->matrix_keycodes[(row << 3) + col] = code;
 		__set_bit(code, input_dev->keybit);
@@ -102,9 +100,11 @@ static irqreturn_t ep93xx_keypad_irq_handler(int irq, void *dev_id)
 {
 	struct ep93xx_keypad *keypad = dev_id;
 	struct input_dev *input_dev = keypad->input_dev;
-	unsigned int status = keypad_readl(KEY_REG);
+	unsigned int status;
 	int keycode, key1, key2;
 
+	status = __raw_readl(keypad->mmio_base + KEY_REG);
+
 	keycode = (status & KEY_REG_KEY1_MASK) >> KEY_REG_KEY1_SHIFT;
 	key1 = keypad->matrix_keycodes[keycode];
 
@@ -152,7 +152,10 @@ static void ep93xx_keypad_config(struct ep93xx_keypad *keypad)
 	struct ep93xx_keypad_platform_data *pdata = keypad->pdata;
 	unsigned int val = 0;
 
-	clk_set_rate(keypad->clk, pdata->flags & EP93XX_KEYPAD_KDIV);
+	if (pdata->flags & EP93XX_KEYPAD_KDIV)
+		clk_set_rate(keypad->clk, EP93XX_KEYTCHCLK_DIV4);
+	else
+		clk_set_rate(keypad->clk, EP93XX_KEYTCHCLK_DIV16);
 
 	if (pdata->flags & EP93XX_KEYPAD_DISABLE_3_KEY)
 		val |= KEY_INIT_DIS3KY;
@@ -167,7 +170,7 @@ static void ep93xx_keypad_config(struct ep93xx_keypad *keypad)
 
 	val |= ((pdata->prescale << KEY_INIT_PRSCL_SHIFT) & KEY_INIT_PRSCL_MASK);
 
-	keypad_writel(val, KEY_INIT);
+	__raw_writel(val, keypad->mmio_base + KEY_INIT);
 }
 
 static int ep93xx_keypad_open(struct input_dev *pdev)
@@ -252,88 +255,56 @@ static int ep93xx_keypad_resume(struct platform_device *pdev)
 static int __devinit ep93xx_keypad_probe(struct platform_device *pdev)
 {
 	struct ep93xx_keypad *keypad;
-	struct ep93xx_keypad_platform_data *pdata = pdev->dev.platform_data;
 	struct input_dev *input_dev;
 	struct resource *res;
-	int irq, err, i, gpio;
-
-	if (!pdata ||
-	    !pdata->matrix_key_rows ||
-	    pdata->matrix_key_rows > MAX_MATRIX_KEY_ROWS ||
-	    !pdata->matrix_key_cols ||
-	    pdata->matrix_key_cols > MAX_MATRIX_KEY_COLS) {
-		dev_err(&pdev->dev, "invalid or missing platform data\n");
-		return -EINVAL;
-	}
+	int err;
 
 	keypad = kzalloc(sizeof(struct ep93xx_keypad), GFP_KERNEL);
-	if (!keypad) {
-		dev_err(&pdev->dev, "failed to allocate driver data\n");
+	if (!keypad)
 		return -ENOMEM;
-	}
 
-	keypad->pdata = pdata;
+	keypad->pdata = pdev->dev.platform_data;
+	if (!keypad->pdata) {
+		err = -EINVAL;
+		goto failed_free;
+	}
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get keypad irq\n");
+	keypad->irq = platform_get_irq(pdev, 0);
+	if (!keypad->irq) {
 		err = -ENXIO;
 		goto failed_free;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
-		dev_err(&pdev->dev, "failed to get I/O memory\n");
 		err = -ENXIO;
 		goto failed_free;
 	}
 
 	res = request_mem_region(res->start, resource_size(res), pdev->name);
 	if (!res) {
-		dev_err(&pdev->dev, "failed to request I/O memory\n");
 		err = -EBUSY;
 		goto failed_free;
 	}
 
 	keypad->mmio_base = ioremap(res->start, resource_size(res));
 	if (keypad->mmio_base == NULL) {
-		dev_err(&pdev->dev, "failed to remap I/O memory\n");
 		err = -ENXIO;
 		goto failed_free_mem;
 	}
 
-	/* Request the needed GPIO's */
-	gpio = EP93XX_GPIO_LINE_ROW0;
-	for (i = 0; i < keypad->pdata->matrix_key_rows; i++, gpio++) {
-		err = gpio_request(gpio, pdev->name);
-		if (err) {
-			dev_err(&pdev->dev, "failed to request gpio-%d\n",
-				gpio);
-			goto failed_free_rows;
-		}
-	}
-
-	gpio = EP93XX_GPIO_LINE_COL0;
-	for (i = 0; i < keypad->pdata->matrix_key_cols; i++, gpio++) {
-		err = gpio_request(gpio, pdev->name);
-		if (err) {
-			dev_err(&pdev->dev, "failed to request gpio-%d\n",
-				gpio);
-			goto failed_free_cols;
-		}
-	}
+	err = ep93xx_keypad_acquire_gpio(pdev);
+	if (err)
+		goto failed_free_io;
 
-	keypad->clk = clk_get(&pdev->dev, "key_clk");
+	keypad->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(keypad->clk)) {
-		dev_err(&pdev->dev, "failed to get keypad clock\n");
 		err = PTR_ERR(keypad->clk);
-		goto failed_free_io;
+		goto failed_free_gpio;
 	}
 
-	/* Create and register the input driver */
 	input_dev = input_allocate_device();
 	if (!input_dev) {
-		dev_err(&pdev->dev, "failed to allocate input device\n");
 		err = -ENOMEM;
 		goto failed_put_clk;
 	}
@@ -358,44 +329,29 @@ static int __devinit ep93xx_keypad_probe(struct platform_device *pdev)
 	ep93xx_keypad_build_keycode(keypad);
 	platform_set_drvdata(pdev, keypad);
 
-	err = request_irq(irq, ep93xx_keypad_irq_handler, IRQF_DISABLED,
-				pdev->name, keypad);
-	if (err) {
-		dev_err(&pdev->dev, "failed to request IRQ\n");
+	err = request_irq(keypad->irq, ep93xx_keypad_irq_handler,
+			  IRQF_DISABLED, pdev->name, keypad);
+	if (err)
 		goto failed_free_dev;
-	}
-
-	keypad->irq = irq;
 
-	/* Register the input device */
 	err = input_register_device(input_dev);
-	if (err) {
-		dev_err(&pdev->dev, "failed to register input device\n");
+	if (err)
 		goto failed_free_irq;
-	}
 
 	device_init_wakeup(&pdev->dev, 1);
 
 	return 0;
 
 failed_free_irq:
-	free_irq(irq, pdev);
+	free_irq(keypad->irq, pdev);
 	platform_set_drvdata(pdev, NULL);
 failed_free_dev:
 	input_free_device(input_dev);
 failed_put_clk:
 	clk_put(keypad->clk);
+failed_free_gpio:
+	ep93xx_keypad_release_gpio(pdev);
 failed_free_io:
-	i = keypad->pdata->matrix_key_cols - 1;
-	gpio = EP93XX_GPIO_LINE_COL0 + i;
-failed_free_cols:
-	for ( ; i >= 0; i--, gpio--)
-		gpio_free(gpio);
-	i = keypad->pdata->matrix_key_rows - 1;
-	gpio = EP93XX_GPIO_LINE_ROW0 + i;
-failed_free_rows:
-	for ( ; i >= 0; i--, gpio--)
-		gpio_free(gpio);
 	iounmap(keypad->mmio_base);
 failed_free_mem:
 	release_mem_region(res->start, resource_size(res));
@@ -408,7 +364,6 @@ static int __devexit ep93xx_keypad_remove(struct platform_device *pdev)
 {
 	struct ep93xx_keypad *keypad = platform_get_drvdata(pdev);
 	struct resource *res;
-	int i, gpio;
 
 	free_irq(keypad->irq, pdev);
 
@@ -420,15 +375,7 @@ static int __devexit ep93xx_keypad_remove(struct platform_device *pdev)
 
 	input_unregister_device(keypad->input_dev);
 
-	i = keypad->pdata->matrix_key_cols - 1;
-	gpio = EP93XX_GPIO_LINE_COL0 + i;
-	for ( ; i >= 0; i--, gpio--)
-		gpio_free(gpio);
-
-	i = keypad->pdata->matrix_key_rows - 1;
-	gpio = EP93XX_GPIO_LINE_ROW0 + i;
-	for ( ; i >= 0; i--, gpio--)
-		gpio_free(gpio);
+	ep93xx_keypad_release_gpio(pdev);
 
 	iounmap(keypad->mmio_base);
  
