From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: RE: [PATCH] ep93xx_keypad: remove macros and update clkdev support
Date: Tue, 30 Jun 2009 14:31:46 -0400
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901A13523@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE1909019683A6@mi8nycmail19.Mi8.com> <BD79186B4FD85F4B8E60E381CAEE1909019BDB3A@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6ob113.obsmtp.com ([64.18.1.30]:33317 "HELO psmtp.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752019AbZF3Sbq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Jun 2009 14:31:46 -0400
Content-class: urn:content-classes:message
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE1909019BDB3A@mi8nycmail19.Mi8.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Ping...

Any comments?

Regards,
Hartley

-----Original Message-----
From: linux-input-owner@vger.kernel.org [mailto:linux-input-owner@vger.kernel.org] On Behalf Of H Hartley Sweeten
Sent: Monday, June 22, 2009 4:35 PM
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov
Subject: RE: [PATCH] ep93xx_keypad: remove macros and update clkdev support

Update the ep93xx_keypad driver.

Most of these changes are to put this driver inline with my
local version of the source.

1) Add generic macros for matrix keypads (ep93xx_keypad.h).
2) Add missing include.
3) Cleanup and rename the register defines to avoid namespace
   problems.
4) The keypad_{readl|writel} macros are both only used once.
   Remove them and just open code the __raw_{readl|writel}.
5) Reorganize the private ep93xx_keypad data.
6) Update ep93xx_keypad_build_keycode() to use the generic
   matrix keypad macros.
7) Split ep93xx_keypad_irq_handler() into more logical pieces.
8) Update ep93xx_keypad_config() to correctly use the clkdev API.
9) The ep93xx_keypad clock is matched based on the device ID.
   Change the clk_get() call to reflect this.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

---

Patch is attached in case of word wrap problems.

If we can get a consensus on the generic macros for matrix keypads I
will create a patch to move this to linux/input.h and update all the
in tree users.

Note: a patch to add the necessary ep93xx clkdev support was recently
submitted to linux-arm-kernel.  If anyone needs this patch right now
please let me know.


diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx_keypad.h b/arch/arm/mach-ep93xx/include/mach/ep93xx_keypad.h
index 83f31cd..dc1f4f5 100644
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
@@ -36,7 +33,22 @@ struct ep93xx_keypad_platform_data {
 	unsigned int	flags;
 };
 
-/* macro for creating the matrix_key_map table */
-#define KEY(row, col, val)	(((row) << 28) | ((col) << 24) | (val))
+#define MAX_MATRIX_KEY_ROWS	(8)
+#define MAX_MATRIX_KEY_COLS	(8)
+
+/*
+ * Macro to pack the row/col of a key on a matrix keypad and it's associated
+ * KEY_* code into into an array.  4 bits are used for both the row and column
+ * allowing for up to a 16x16 keypad.  The row (_r) and column (_c) are
+ * interchangable depending on a keypad drivers usage.
+ */
+#define MATRIX_KEY(_r, _c, _v)	(((_r) << 28) | ((_c) << 24) | (_v))
+
+#define MATRIX_ROWCOL_MASK	MATRIX_KEY(0x0f, 0x0f, 0)
+#define MATRIX_KEYCODE_MASK	(~MATRIX_ROWCOL_MASK)
+
+#define MATRIX_ROW(_k)		(((_k) >> 28) & 0x0f)
+#define MATRIX_COL(_k)		(((_k) >> 24) & 0x0f)
+#define MATRIX_KEYCODE(_k)	((_k) & MATRIX_KEYCODE_MASK)
 
 #endif	/* __ASM_ARCH_EP93XX_KEYPAD_H */
diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
index 181d30e..acb79d5 100644
--- a/drivers/input/keyboard/ep93xx_keypad.c
+++ b/drivers/input/keyboard/ep93xx_keypad.c
@@ -24,125 +24,144 @@
 #include <linux/interrupt.h>
 #include <linux/input.h>
 #include <linux/clk.h>
+#include <linux/io.h>
 
 #include <mach/hardware.h>
 #include <mach/gpio.h>
 #include <mach/ep93xx_keypad.h>
 
 /*
- * Keypad Interface Register offsets
+ * Keypad Interface register offsets and bit defines
  */
-#define KEY_INIT		0x00	/* Key Scan Initialization register */
-#define KEY_DIAG		0x04	/* Key Scan Diagnostic register */
-#define KEY_REG			0x08	/* Key Value Capture register */
-
-/* Key Scan Initialization Register bit defines */
-#define KEY_INIT_DBNC_MASK	(0x00ff0000)
-#define KEY_INIT_DBNC_SHIFT	(16)
-#define KEY_INIT_DIS3KY		(1<<15)
-#define KEY_INIT_DIAG		(1<<14)
-#define KEY_INIT_BACK		(1<<13)
-#define KEY_INIT_T2		(1<<12)
-#define KEY_INIT_PRSCL_MASK	(0x000003ff)
-#define KEY_INIT_PRSCL_SHIFT	(0)
-
-/* Key Scan Diagnostic Register bit defines */
-#define KEY_DIAG_MASK		(0x0000003f)
-#define KEY_DIAG_SHIFT		(0)
-
-/* Key Value Capture Register bit defines */
-#define KEY_REG_K		(1<<15)
-#define KEY_REG_INT		(1<<14)
-#define KEY_REG_2KEYS		(1<<13)
-#define KEY_REG_1KEY		(1<<12)
-#define KEY_REG_KEY2_MASK	(0x00000fc0)
-#define KEY_REG_KEY2_SHIFT	(6)
-#define KEY_REG_KEY1_MASK	(0x0000003f)
-#define KEY_REG_KEY1_SHIFT	(0)
-
-#define keypad_readl(off)	__raw_readl(keypad->mmio_base + (off))
-#define keypad_writel(v, off)	__raw_writel((v), keypad->mmio_base + (off))
-
-#define MAX_MATRIX_KEY_NUM	(MAX_MATRIX_KEY_ROWS * MAX_MATRIX_KEY_COLS)
+#define EP93XX_KEY_INIT			0x00
+#define   EP93XX_KEY_INIT_DBNC_MASK	  0x00ff0000
+#define   EP93XX_KEY_INIT_DBNC_SHIFT	  16
+#define   EP93XX_KEY_INIT_DIS3KY	  (1<<15)
+#define   EP93XX_KEY_INIT_DIAG		  (1<<14)
+#define   EP93XX_KEY_INIT_BACK		  (1<<13)
+#define   EP93XX_KEY_INIT_T2		  (1<<12)
+#define   EP93XX_KEY_INIT_PRSCL_MASK	  0x000003ff
+#define   EP93XX_KEY_INIT_PRSCL_SHIFT	  0
+#define EP93XX_KEY_DIAG			0x04
+#define   EP93XX_KEY_DIAG_MASK		  0x0000003f
+#define   EP93XX_KEY_DIAG_SHIFT		  0
+#define EP93XX_KEY_REG			0x08
+#define   EP93XX_KEY_REG_K		  (1<<15)
+#define   EP93XX_KEY_REG_INT		  (1<<14)
+#define   EP93XX_KEY_REG_2KEYS		  (1<<13)
+#define   EP93XX_KEY_REG_1KEY		  (1<<12)
+#define   EP93XX_KEY_REG_KEY2_MASK	  0x00000fc0
+#define   EP93XX_KEY_REG_KEY2_SHIFT	  6
+#define   EP93XX_KEY_REG_KEY1_MASK	  0x0000003f
+#define   EP93XX_KEY_REG_KEY1_SHIFT	  0
+
+#define EP93XX_KEYTCHCLKDIV_4		(EP93XX_EXT_CLK_RATE / 4)
+#define EP93XX_KEYTCHCLKDIV_16		(EP93XX_EXT_CLK_RATE / 16)
+
+#define MAX_MATRIX_KEY_NUM		(MAX_MATRIX_KEY_ROWS * MAX_MATRIX_KEY_COLS)
 
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
+	unsigned int matrix_keycodes[MAX_MATRIX_KEY_NUM];
 
 	int key1;
 	int key2;
 
-	unsigned int matrix_keycodes[MAX_MATRIX_KEY_NUM];
+	int irq;
+	int enabled;
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
+		int row = MATRIX_ROW(*key);
+		int col = MATRIX_COL(*key);
+		int code = MATRIX_KEYCODE(*key);
 
 		keypad->matrix_keycodes[(row << 3) + col] = code;
 		__set_bit(code, input_dev->keybit);
 	}
 }
 
-static irqreturn_t ep93xx_keypad_irq_handler(int irq, void *dev_id)
+static void ep93xx_keypad_report(struct ep93xx_keypad *keypad, int key, int press)
 {
-	struct ep93xx_keypad *keypad = dev_id;
 	struct input_dev *input_dev = keypad->input_dev;
-	unsigned int status = keypad_readl(KEY_REG);
-	int keycode, key1, key2;
 
-	keycode = (status & KEY_REG_KEY1_MASK) >> KEY_REG_KEY1_SHIFT;
-	key1 = keypad->matrix_keycodes[keycode];
+	if (key) {
+		input_report_key(input_dev, key, press);
+		input_sync(input_dev);
+	}
+}
 
-	keycode = (status & KEY_REG_KEY2_MASK) >> KEY_REG_KEY2_SHIFT;
-	key2 = keypad->matrix_keycodes[keycode];
+static void ep93xx_keypad_release(struct ep93xx_keypad *keypad, int *key)
+{
+	ep93xx_keypad_report(keypad, *key, 0);
+	*key = 0;
+}
+
+static void ep93xx_keypad_press(struct ep93xx_keypad *keypad, int *key, int code)
+{
+	*key = code;
+	ep93xx_keypad_report(keypad, *key, 1);
+}
 
-	if (status & KEY_REG_2KEYS) {
-		if (keypad->key1 && key1 != keypad->key1 && key2 != keypad->key1)
-			input_report_key(input_dev, keypad->key1, 0);
+static void ep93xx_keypad_process(struct ep93xx_keypad *keypad,
+				int key1, int key2)
+{
+	int old_key1 = keypad->key1;
+	int old_key2 = keypad->key2;
 
-		if (keypad->key2 && key1 != keypad->key2 && key2 != keypad->key2)
-			input_report_key(input_dev, keypad->key2, 0);
+	if (old_key1 != key1 && old_key1 != key2)
+		ep93xx_keypad_release(keypad, &keypad->key1);
 
-		input_report_key(input_dev, key1, 1);
-		input_report_key(input_dev, key2, 1);
+	if (old_key2 != key1 && old_key2 != key2)
+		ep93xx_keypad_release(keypad, &keypad->key2);
 
+	if (old_key1 != key1 && old_key2 != key1)
+		ep93xx_keypad_press(keypad, &keypad->key1, key1);
+	else
 		keypad->key1 = key1;
+
+	if (old_key1 != key2 && old_key2 != key2)
+		ep93xx_keypad_press(keypad, &keypad->key2, key2);
+	else
 		keypad->key2 = key2;
+}
 
-	} else if (status & KEY_REG_1KEY) {
-		if (keypad->key1 && key1 != keypad->key1)
-			input_report_key(input_dev, keypad->key1, 0);
+static irqreturn_t ep93xx_keypad_irq_handler(int irq, void *dev_id)
+{
+	struct ep93xx_keypad *keypad = dev_id;
+	unsigned int status;
+	int keycode, key1, key2;
 
-		if (keypad->key2 && key1 != keypad->key2)
-			input_report_key(input_dev, keypad->key2, 0);
+	status = __raw_readl(keypad->mmio_base + EP93XX_KEY_REG);
 
-		input_report_key(input_dev, key1, 1);
+	keycode = (status & EP93XX_KEY_REG_KEY1_MASK) >>
+				EP93XX_KEY_REG_KEY1_SHIFT;
+	key1 = keypad->matrix_keycodes[keycode];
 
-		keypad->key1 = key1;
-		keypad->key2 = 0;
+	keycode = (status & EP93XX_KEY_REG_KEY2_MASK) >>
+				EP93XX_KEY_REG_KEY2_SHIFT;
+	key2 = keypad->matrix_keycodes[keycode];
 
+	if (status & EP93XX_KEY_REG_2KEYS) {
+		ep93xx_keypad_process(keypad, key1, key2);
+	} else if (status & EP93XX_KEY_REG_1KEY) {
+		ep93xx_keypad_process(keypad, key1, 0);
 	} else {
-		input_report_key(input_dev, keypad->key1, 0);
-		input_report_key(input_dev, keypad->key2, 0);
-
-		keypad->key1 = keypad->key2 = 0;
+		ep93xx_keypad_process(keypad, 0, 0);
 	}
-	input_sync(input_dev);
 
 	return IRQ_HANDLED;
 }
@@ -152,22 +171,27 @@ static void ep93xx_keypad_config(struct ep93xx_keypad *keypad)
 	struct ep93xx_keypad_platform_data *pdata = keypad->pdata;
 	unsigned int val = 0;
 
-	clk_set_rate(keypad->clk, pdata->flags & EP93XX_KEYPAD_KDIV);
+	if (pdata->flags & EP93XX_KEYPAD_KDIV)
+		clk_set_rate(keypad->clk, EP93XX_KEYTCHCLKDIV_4);
+	else
+		clk_set_rate(keypad->clk, EP93XX_KEYTCHCLKDIV_16);
 
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
+		EP93XX_KEY_INIT_DBNC_MASK);
 
-	val |= ((pdata->prescale << KEY_INIT_PRSCL_SHIFT) & KEY_INIT_PRSCL_MASK);
+	val |= ((pdata->prescale << EP93XX_KEY_INIT_PRSCL_SHIFT) &
+		EP93XX_KEY_INIT_PRSCL_MASK);
 
-	keypad_writel(val, KEY_INIT);
+	__raw_writel(val, keypad->mmio_base + EP93XX_KEY_INIT);
 }
 
 static int ep93xx_keypad_open(struct input_dev *pdev)
@@ -323,7 +347,7 @@ static int __devinit ep93xx_keypad_probe(struct platform_device *pdev)
 		}
 	}
 
-	keypad->clk = clk_get(&pdev->dev, "key_clk");
+	keypad->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(keypad->clk)) {
 		dev_err(&pdev->dev, "failed to get keypad clock\n");
 		err = PTR_ERR(keypad->clk); 
