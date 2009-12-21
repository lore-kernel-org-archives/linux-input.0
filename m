From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: [PATCH] ep93xx_keypad.c: cleanup and use matrix_keypad helpers
Date: Mon, 21 Dec 2009 13:01:01 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE19090200F166@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6og116.obsmtp.com ([64.18.1.37]:44074 "HELO
	exprod6og116.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751123AbZLUSBF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Dec 2009 13:01:05 -0500
Content-class: urn:content-classes:message
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

ep93xx_keypad.c: cleanup and use matrix_keypad helpers

1) use struct matrix_keymap_data to supply the keymap from the platform code
   and use matrix_keypad_build_keymap() to initialize the keymap
2) namespace sanitize the local defines
3) cleanup the interrupt handler to make it more understandable
4) allocate the keycode matrix at run time

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

---

diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx_keypad.h b/arch/arm/mach-ep93xx/include/mach/ep93xx_keypad.h
index 62d1742..1e2f4e9 100644
--- a/arch/arm/mach-ep93xx/include/mach/ep93xx_keypad.h
+++ b/arch/arm/mach-ep93xx/include/mach/ep93xx_keypad.h
@@ -5,6 +5,8 @@
 #ifndef __ASM_ARCH_EP93XX_KEYPAD_H
 #define __ASM_ARCH_EP93XX_KEYPAD_H
 
+struct matrix_keymap_data;
+
 /* flags for the ep93xx_keypad driver */
 #define EP93XX_KEYPAD_DISABLE_3_KEY	(1<<0)	/* disable 3-key reset */
 #define EP93XX_KEYPAD_DIAG_MODE		(1<<1)	/* diagnostic mode */
@@ -15,15 +17,13 @@
 
 /**
  * struct ep93xx_keypad_platform_data - platform specific device structure
- * @matrix_key_map:		array of keycodes defining the keypad matrix
- * @matrix_key_map_size:	ARRAY_SIZE(matrix_key_map)
- * @debounce:			debounce start count; terminal count is 0xff
- * @prescale:			row/column counter pre-scaler load value
- * @flags:			see above
+ * @keymap_data:	pointer to &matrix_keymap_data
+ * @debounce:		debounce start count; terminal count is 0xff
+ * @prescale:		row/column counter pre-scaler load value
+ * @flags:		see above
  */
 struct ep93xx_keypad_platform_data {
-	unsigned int	*matrix_key_map;
-	int		matrix_key_map_size;
+	struct matrix_keymap_data *keymap_data;
 	unsigned int	debounce;
 	unsigned int	prescale;
 	unsigned int	flags;
diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
index e457404..aed201b 100644
--- a/drivers/input/keyboard/ep93xx_keypad.c
+++ b/drivers/input/keyboard/ep93xx_keypad.c
@@ -32,35 +32,35 @@
 /*
  * Keypad Interface Register offsets
  */
-#define KEY_INIT		0x00	/* Key Scan Initialization register */
-#define KEY_DIAG		0x04	/* Key Scan Diagnostic register */
-#define KEY_REG			0x08	/* Key Value Capture register */
+#define EP93XX_KEY_INIT			0x00	/* Key Scan Initialization register */
+#define EP93XX_KEY_DIAG			0x04	/* Key Scan Diagnostic register */
+#define EP93XX_KEY_REG			0x08	/* Key Value Capture register */
 
 /* Key Scan Initialization Register bit defines */
-#define KEY_INIT_DBNC_MASK	(0x00ff0000)
-#define KEY_INIT_DBNC_SHIFT	(16)
-#define KEY_INIT_DIS3KY		(1<<15)
-#define KEY_INIT_DIAG		(1<<14)
-#define KEY_INIT_BACK		(1<<13)
-#define KEY_INIT_T2		(1<<12)
-#define KEY_INIT_PRSCL_MASK	(0x000003ff)
-#define KEY_INIT_PRSCL_SHIFT	(0)
+#define EP93XX_KEY_INIT_DBNC_MASK	(0x00ff0000)
+#define EP93XX_KEY_INIT_DBNC_SHIFT	(16)
+#define EP93XX_KEY_INIT_DIS3KY		(1 << 15)
+#define EP93XX_KEY_INIT_DIAG		(1 << 14)
+#define EP93XX_KEY_INIT_BACK		(1 << 13)
+#define EP93XX_KEY_INIT_T2		(1 << 12)
+#define EP93XX_KEY_INIT_PRSCL_MASK	(0x000003ff)
+#define EP93XX_KEY_INIT_PRSCL_SHIFT	(0)
 
 /* Key Scan Diagnostic Register bit defines */
-#define KEY_DIAG_MASK		(0x0000003f)
-#define KEY_DIAG_SHIFT		(0)
+#define EP93XX_KEY_DIAG_MASK		(0x0000003f)
+#define EP93XX_KEY_DIAG_SHIFT		(0)
 
 /* Key Value Capture Register bit defines */
-#define KEY_REG_K		(1<<15)
-#define KEY_REG_INT		(1<<14)
-#define KEY_REG_2KEYS		(1<<13)
-#define KEY_REG_1KEY		(1<<12)
-#define KEY_REG_KEY2_MASK	(0x00000fc0)
-#define KEY_REG_KEY2_SHIFT	(6)
-#define KEY_REG_KEY1_MASK	(0x0000003f)
-#define KEY_REG_KEY1_SHIFT	(0)
+#define EP93XX_KEY_REG_K		(1 << 15)
+#define EP93XX_KEY_REG_INT		(1 << 14)
+#define EP93XX_KEY_REG_2KEYS		(1 << 13)
+#define EP93XX_KEY_REG_1KEY		(1 << 12)
+#define EP93XX_KEY_REG_KEY2_MASK	(0x00000fc0)
+#define EP93XX_KEY_REG_KEY2_SHIFT	(6)
+#define EP93XX_KEY_REG_KEY1_MASK	(0x0000003f)
+#define EP93XX_KEY_REG_KEY1_SHIFT	(0)
 
-#define EP93XX_MATRIX_SIZE	(EP93XX_MATRIX_ROWS * EP93XX_MATRIX_COLS)
+#define EP93XX_MATRIX_SIZE		(EP93XX_MATRIX_ROWS * EP93XX_MATRIX_COLS)
 
 struct ep93xx_keypad {
 	struct ep93xx_keypad_platform_data *pdata;
@@ -69,7 +69,7 @@ struct ep93xx_keypad {
 
 	void __iomem *mmio_base;
 
-	unsigned int matrix_keycodes[EP93XX_MATRIX_SIZE];
+	unsigned short *keycodes;
 
 	int key1;
 	int key2;
@@ -79,71 +79,74 @@ struct ep93xx_keypad {
 	bool enabled;
 };
 
-static void ep93xx_keypad_build_keycode(struct ep93xx_keypad *keypad)
+static void ep93xx_keypad_report(struct ep93xx_keypad *keypad, int key, int press)
 {
-	struct ep93xx_keypad_platform_data *pdata = keypad->pdata;
 	struct input_dev *input_dev = keypad->input_dev;
-	unsigned int *key;
-	int i;
-
-	key = &pdata->matrix_key_map[0];
-	for (i = 0; i < pdata->matrix_key_map_size; i++, key++) {
-		int row = KEY_ROW(*key);
-		int col = KEY_COL(*key);
-		int code = KEY_VAL(*key);
 
-		keypad->matrix_keycodes[(row << 3) + col] = code;
-		__set_bit(code, input_dev->keybit);
+	if (key) {
+		input_report_key(input_dev, key, press);
+		input_sync(input_dev);
 	}
 }
 
-static irqreturn_t ep93xx_keypad_irq_handler(int irq, void *dev_id)
+static void ep93xx_keypad_release(struct ep93xx_keypad *keypad, int *key)
 {
-	struct ep93xx_keypad *keypad = dev_id;
-	struct input_dev *input_dev = keypad->input_dev;
-	unsigned int status;
-	int keycode, key1, key2;
-
-	status = __raw_readl(keypad->mmio_base + KEY_REG);
-
-	keycode = (status & KEY_REG_KEY1_MASK) >> KEY_REG_KEY1_SHIFT;
-	key1 = keypad->matrix_keycodes[keycode];
+	ep93xx_keypad_report(keypad, *key, 0);
+	*key = 0;
+}
 
-	keycode = (status & KEY_REG_KEY2_MASK) >> KEY_REG_KEY2_SHIFT;
-	key2 = keypad->matrix_keycodes[keycode];
+static void ep93xx_keypad_press(struct ep93xx_keypad *keypad, int *key, int code)
+{
+	*key = code;
+	ep93xx_keypad_report(keypad, *key, 1);
+}
 
-	if (status & KEY_REG_2KEYS) {
-		if (keypad->key1 && key1 != keypad->key1 && key2 != keypad->key1)
-			input_report_key(input_dev, keypad->key1, 0);
+static void ep93xx_keypad_process(struct ep93xx_keypad *keypad,
+				int keycode1, int keycode2)
+{
+	int old_key1 = keypad->key1;
+	int old_key2 = keypad->key2;
 
-		if (keypad->key2 && key1 != keypad->key2 && key2 != keypad->key2)
-			input_report_key(input_dev, keypad->key2, 0);
+	if (old_key1 != keycode1 && old_key1 != keycode2)
+		ep93xx_keypad_release(keypad, &keypad->key1);
 
-		input_report_key(input_dev, key1, 1);
-		input_report_key(input_dev, key2, 1);
+	if (old_key2 != keycode1 && old_key2 != keycode2)
+		ep93xx_keypad_release(keypad, &keypad->key2);
 
-		keypad->key1 = key1;
-		keypad->key2 = key2;
+	if (old_key1 != keycode1 && old_key2 != keycode1)
+		ep93xx_keypad_press(keypad, &keypad->key1, keycode1);
+	else
+		keypad->key1 = keycode1;
 
-	} else if (status & KEY_REG_1KEY) {
-		if (keypad->key1 && key1 != keypad->key1)
-			input_report_key(input_dev, keypad->key1, 0);
+	if (old_key1 != keycode2 && old_key2 != keycode2)
+		ep93xx_keypad_press(keypad, &keypad->key2, keycode2);
+	else
+		keypad->key2 = keycode2;
+}
 
-		if (keypad->key2 && key1 != keypad->key2)
-			input_report_key(input_dev, keypad->key2, 0);
+static irqreturn_t ep93xx_keypad_irq_handler(int irq, void *dev_id)
+{
+	struct ep93xx_keypad *keypad = dev_id;
+	unsigned int status;
+	int key1, key2, keycode1, keycode2;
 
-		input_report_key(input_dev, key1, 1);
+	status = __raw_readl(keypad->mmio_base + EP93XX_KEY_REG);
 
-		keypad->key1 = key1;
-		keypad->key2 = 0;
+	key1 = (status & EP93XX_KEY_REG_KEY1_MASK) >> EP93XX_KEY_REG_KEY1_SHIFT;
+	key2 = (status & EP93XX_KEY_REG_KEY2_MASK) >> EP93XX_KEY_REG_KEY2_SHIFT;
 
+	if (status & EP93XX_KEY_REG_2KEYS) {
+		keycode1 = keypad->keycodes[key1];
+		keycode2 = keypad->keycodes[key2];
+	} else if (status & EP93XX_KEY_REG_1KEY) {
+		keycode1 = keypad->keycodes[key1];
+		keycode2 = 0;
 	} else {
-		input_report_key(input_dev, keypad->key1, 0);
-		input_report_key(input_dev, keypad->key2, 0);
-
-		keypad->key1 = keypad->key2 = 0;
+		keycode1 = 0;
+		keycode2 = 0;
 	}
-	input_sync(input_dev);
+
+	ep93xx_keypad_process(keypad, keycode1, keycode2);
 
 	return IRQ_HANDLED;
 }
@@ -159,19 +162,21 @@ static void ep93xx_keypad_config(struct ep93xx_keypad *keypad)
 		clk_set_rate(keypad->clk, EP93XX_KEYTCHCLK_DIV16);
 
 	if (pdata->flags & EP93XX_KEYPAD_DISABLE_3_KEY)
-		val |= KEY_INIT_DIS3KY;
+		val |= EP93XX_KEY_INIT_DIS3KY;
 	if (pdata->flags & EP93XX_KEYPAD_DIAG_MODE)
-		val |= KEY_INIT_DIAG;
+		val |= EP93XX_KEY_INIT_DIAG;
 	if (pdata->flags & EP93XX_KEYPAD_BACK_DRIVE)
-		val |= KEY_INIT_BACK;
+		val |= EP93XX_KEY_INIT_BACK;
 	if (pdata->flags & EP93XX_KEYPAD_TEST_MODE)
-		val |= KEY_INIT_T2;
+		val |= EP93XX_KEY_INIT_T2;
 
-	val |= ((pdata->debounce << KEY_INIT_DBNC_SHIFT) & KEY_INIT_DBNC_MASK);
+	val |= ((pdata->debounce << EP93XX_KEY_INIT_DBNC_SHIFT) &
+					EP93XX_KEY_INIT_DBNC_MASK);
 
-	val |= ((pdata->prescale << KEY_INIT_PRSCL_SHIFT) & KEY_INIT_PRSCL_MASK);
+	val |= ((pdata->prescale << EP93XX_KEY_INIT_PRSCL_SHIFT) &
+					EP93XX_KEY_INIT_PRSCL_MASK);
 
-	__raw_writel(val, keypad->mmio_base + KEY_INIT);
+	__raw_writel(val, keypad->mmio_base + EP93XX_KEY_INIT);
 }
 
 static int ep93xx_keypad_open(struct input_dev *pdev)
@@ -256,13 +261,18 @@ static int ep93xx_keypad_resume(struct platform_device *pdev)
 static int __devinit ep93xx_keypad_probe(struct platform_device *pdev)
 {
 	struct ep93xx_keypad *keypad;
+	const struct matrix_keymap_data *keymap_data;
 	struct input_dev *input_dev;
 	struct resource *res;
+	unsigned short *keycodes;
 	int err;
 
 	keypad = kzalloc(sizeof(struct ep93xx_keypad), GFP_KERNEL);
-	if (!keypad)
-		return -ENOMEM;
+	keycodes = kzalloc(EP93XX_MATRIX_SIZE * sizeof(*keycodes), GFP_KERNEL);
+	if (!keypad || !keycodes) {
+		err = -ENOMEM;
+		goto failed_free;
+	}
 
 	keypad->pdata = pdev->dev.platform_data;
 	if (!keypad->pdata) {
@@ -270,6 +280,12 @@ static int __devinit ep93xx_keypad_probe(struct platform_device *pdev)
 		goto failed_free;
 	}
 
+	keymap_data = keypad->pdata->keymap_data;
+	if (!keymap_data) {
+		err = -EINVAL;
+		goto failed_free;
+	}
+
 	keypad->irq = platform_get_irq(pdev, 0);
 	if (!keypad->irq) {
 		err = -ENXIO;
@@ -311,15 +327,16 @@ static int __devinit ep93xx_keypad_probe(struct platform_device *pdev)
 	}
 
 	keypad->input_dev = input_dev;
+	keypad->keycodes = keycodes;
 
 	input_dev->name = pdev->name;
 	input_dev->id.bustype = BUS_HOST;
 	input_dev->open = ep93xx_keypad_open;
 	input_dev->close = ep93xx_keypad_close;
 	input_dev->dev.parent = &pdev->dev;
-	input_dev->keycode = keypad->matrix_keycodes;
-	input_dev->keycodesize = sizeof(keypad->matrix_keycodes[0]);
-	input_dev->keycodemax = ARRAY_SIZE(keypad->matrix_keycodes);
+	input_dev->keycode = keycodes;
+	input_dev->keycodesize = sizeof(*keycodes);
+	input_dev->keycodemax = EP93XX_MATRIX_SIZE;
 
 	input_set_drvdata(input_dev, keypad);
 
@@ -327,7 +344,8 @@ static int __devinit ep93xx_keypad_probe(struct platform_device *pdev)
 	if (keypad->pdata->flags & EP93XX_KEYPAD_AUTOREPEAT)
 		input_dev->evbit[0] |= BIT_MASK(EV_REP);
 
-	ep93xx_keypad_build_keycode(keypad);
+	matrix_keypad_build_keymap(keymap_data, 3,
+				   input_dev->keycode, input_dev->keybit);
 	platform_set_drvdata(pdev, keypad);
 
 	err = request_irq(keypad->irq, ep93xx_keypad_irq_handler,
@@ -357,6 +375,7 @@ failed_free_io:
 failed_free_mem:
 	release_mem_region(res->start, resource_size(res));
 failed_free:
+	kfree(keycodes);
 	kfree(keypad);
 	return err;
 }
@@ -383,6 +402,7 @@ static int __devexit ep93xx_keypad_remove(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(res->start, resource_size(res));
 
+	kfree(keypad->keycodes);
 	kfree(keypad);
 
 	return 0; 
