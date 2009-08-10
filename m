From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] input: Add keypad driver for w90p910
Date: Sun, 9 Aug 2009 18:36:15 -0700
Message-ID: <20090810020638.6B2EE526EC9@mailhub.coreip.homeip.net>
References: <4A5C6D2A.7040501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:54390 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545AbZHJBgW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 9 Aug 2009 21:36:22 -0400
Received: by rv-out-0506.google.com with SMTP id f6so858232rvb.1
        for <linux-input@vger.kernel.org>; Sun, 09 Aug 2009 18:36:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A5C6D2A.7040501@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, "Eric.miao" <eric.y.miao@gmail.com>, H Hartley Sweeten <hartleys@visionengravers.com>, Trilok Soni <soni.trilok@gmail.com>

Hi Wan,

On Tue, Jul 14, 2009 at 07:34:02PM +0800, Wan ZongShun wrote:
> Dear Dmitry,
> 
> This is a latest keypad driver, according to your and H Hartley's
> advice, I fixed up my keypad driver again and merge this header file
> patch to keypad driver patch.
>

I was waiting for the matrix_keypad code to settle before applying your
drive; now that it has settled I ajusted w90p910_keypad to use
definitions from include/linux/input/matrix_keypad.h and I am ready to
apply it to my tree.

Could you please try the patch below to verify that I did not break
anything (you'll have to pull the latest Linus tree to get the correct
bits of matrix_keypad)?

Thanks!

-- 
Dmitry

Input: w90p910_keypad - adjust to use definitions from matrix_keypad.h

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Also have the driver send MSC_SCAN events as most keyboards do to aid
in updating keymap from userspace.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 .../arm/mach-w90x900/include/mach/w90p910_keypad.h |    5 -
 drivers/input/keyboard/w90p910_keypad.c            |  144 +++++++++-----------
 2 files changed, 66 insertions(+), 83 deletions(-)


diff --git a/arch/arm/mach-w90x900/include/mach/w90p910_keypad.h b/arch/arm/mach-w90x900/include/mach/w90p910_keypad.h
index 79462fa..556778e 100644
--- a/arch/arm/mach-w90x900/include/mach/w90p910_keypad.h
+++ b/arch/arm/mach-w90x900/include/mach/w90p910_keypad.h
@@ -6,13 +6,10 @@
 extern void mfp_set_groupi(struct device *dev);
 
 struct w90p910_keypad_platform_data {
+	const struct matrix_keymap_data *keymap_data;
 
 	unsigned int	prescale;
 	unsigned int	debounce;
-	unsigned int	matrix_key_rows;
-	unsigned int	matrix_key_cols;
-	unsigned int	*matrix_key_map;
-	int		matrix_key_map_size;
 };
 
 #endif /* __ASM_ARCH_W90P910_KEYPAD_H */
diff --git a/drivers/input/keyboard/w90p910_keypad.c b/drivers/input/keyboard/w90p910_keypad.c
index 472c705..24096cd 100644
--- a/drivers/input/keyboard/w90p910_keypad.c
+++ b/drivers/input/keyboard/w90p910_keypad.c
@@ -41,58 +41,34 @@
 #define KGET_RAW(n)		(((n) & KEY0R) >> 3)
 #define KGET_COLUMN(n)		((n) & KEY0C)
 
-#define MAX_MATRIX_KEY_NUM	(8 * 8)
+#define W90P910_MAX_KEY_NUM	(8 * 8)
+#define W90P910_ROW_SHIFT	3
 
 struct w90p910_keypad {
-	struct w90p910_keypad_platform_data *pdata;
+	const struct w90p910_keypad_platform_data *pdata;
 	struct clk *clk;
 	struct input_dev *input_dev;
 	void __iomem *mmio_base;
 	int irq;
-	unsigned int matrix_keycodes[MAX_MATRIX_KEY_NUM];
+	unsigned short keymap[W90P910_MAX_KEY_NUM];
 };
 
-static void w90p910_keypad_build_keycode(struct w90p910_keypad *keypad)
-{
-	struct w90p910_keypad_platform_data *pdata = keypad->pdata;
-	struct input_dev *input_dev = keypad->input_dev;
-	unsigned int *key;
-	int i;
-
-	key = &pdata->matrix_key_map[0];
-	for (i = 0; i < pdata->matrix_key_map_size; i++, key++) {
-		int row = KEY_ROW(*key);
-		int col = KEY_COL(*key);
-		int code = KEY_VAL(*key);
-
-		keypad->matrix_keycodes[(row << 3) + col] = code;
-		__set_bit(code, input_dev->keybit);
-	}
-}
-
-static inline unsigned int lookup_matrix_keycode(
-		struct w90p910_keypad *keypad, int row, int col)
-{
-	return keypad->matrix_keycodes[(row << 3) + col];
-}
-
 static void w90p910_keypad_scan_matrix(struct w90p910_keypad *keypad,
 							unsigned int status)
 {
-	unsigned int row, col, val;
-
-	row = KGET_RAW(status);
-	col = KGET_COLUMN(status);
-
-	val = lookup_matrix_keycode(keypad, row, col);
-
-	input_report_key(keypad->input_dev, val, 1);
-
-	input_sync(keypad->input_dev);
-
-	input_report_key(keypad->input_dev, val, 0);
-
-	input_sync(keypad->input_dev);
+	struct input_dev *input_dev = keypad->input_dev;
+	unsigned int row = KGET_RAW(status);
+	unsigned int col = KGET_COLUMN(status);
+	unsigned int code = MATRIX_SCAN_CODE(row, col, W90P910_ROW_SHIFT);
+	unsigned int key = keypad->keymap[code];
+
+	input_event(input_dev, EV_MSC, MSC_SCAN, code);
+	input_report_key(input_dev, key, 1);
+	input_sync(input_dev);
+
+	input_event(input_dev, EV_MSC, MSC_SCAN, code);
+	input_report_key(input_dev, key, 0);
+	input_sync(input_dev);
 }
 
 static irqreturn_t w90p910_keypad_irq_handler(int irq, void *dev_id)
@@ -113,7 +89,7 @@ static irqreturn_t w90p910_keypad_irq_handler(int irq, void *dev_id)
 static int w90p910_keypad_open(struct input_dev *dev)
 {
 	struct w90p910_keypad *keypad = input_get_drvdata(dev);
-	struct w90p910_keypad_platform_data *pdata = keypad->pdata;
+	const struct w90p910_keypad_platform_data *pdata = keypad->pdata;
 	unsigned int val, config;
 
 	/* Enable unit clock */
@@ -142,31 +118,39 @@ static void w90p910_keypad_close(struct input_dev *dev)
 
 static int __devinit w90p910_keypad_probe(struct platform_device *pdev)
 {
+	const struct w90p910_keypad_platform_data *pdata =
+						pdev->dev.platform_data;
+	const struct matrix_keymap_data *keymap_data = pdata->keymap_data;
 	struct w90p910_keypad *keypad;
 	struct input_dev *input_dev;
 	struct resource *res;
-	int irq, error;
-
-	keypad = kzalloc(sizeof(struct w90p910_keypad), GFP_KERNEL);
-	if (keypad == NULL) {
-		dev_err(&pdev->dev, "failed to allocate driver data\n");
-		return -ENOMEM;
-	}
+	int irq;
+	int error;
+	int i;
 
-	keypad->pdata = pdev->dev.platform_data;
-	if (keypad->pdata == NULL) {
+	if (!pdata) {
 		dev_err(&pdev->dev, "no platform data defined\n");
-		error = -EINVAL;
-		goto failed_free;
+		return -EINVAL;
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "failed to get keypad irq\n");
-		error = -ENXIO;
+		return -ENXIO;
+	}
+
+	keypad = kzalloc(sizeof(struct w90p910_keypad), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!keypad || !input_dev) {
+		dev_err(&pdev->dev, "failed to allocate driver data\n");
+		error = -ENOMEM;
 		goto failed_free;
 	}
 
+	keypad->pdata = pdata;
+	keypad->input_dev = input_dev;
+	keypad->irq = irq;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res == NULL) {
 		dev_err(&pdev->dev, "failed to get I/O memory\n");
@@ -185,7 +169,7 @@ static int __devinit w90p910_keypad_probe(struct platform_device *pdev)
 	if (keypad->mmio_base == NULL) {
 		dev_err(&pdev->dev, "failed to remap I/O memory\n");
 		error = -ENXIO;
-		goto failed_free_mem;
+		goto failed_free_res;
 	}
 
 	keypad->clk = clk_get(&pdev->dev, NULL);
@@ -195,14 +179,6 @@ static int __devinit w90p910_keypad_probe(struct platform_device *pdev)
 		goto failed_free_io;
 	}
 
-	/* Create and register the input driver. */
-	input_dev = input_allocate_device();
-	if (!input_dev) {
-		dev_err(&pdev->dev, "failed to allocate input device\n");
-		error = -ENOMEM;
-		goto failed_put_clk;
-	}
-
 	/* set multi-function pin for w90p910 kpi. */
 	mfp_set_groupi(&pdev->dev);
 
@@ -211,26 +187,37 @@ static int __devinit w90p910_keypad_probe(struct platform_device *pdev)
 	input_dev->open = w90p910_keypad_open;
 	input_dev->close = w90p910_keypad_close;
 	input_dev->dev.parent = &pdev->dev;
-	input_dev->keycode = keypad->matrix_keycodes;
-	input_dev->keycodesize = sizeof(keypad->matrix_keycodes[0]);
-	input_dev->keycodemax = ARRAY_SIZE(keypad->matrix_keycodes);
 
-	keypad->input_dev = input_dev;
+	input_dev->keycode = keypad->keymap;
+	input_dev->keycodesize = sizeof(keypad->keymap[0]);
+	input_dev->keycodemax = ARRAY_SIZE(keypad->keymap);
+
 	input_set_drvdata(input_dev, keypad);
 
 	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
-	w90p910_keypad_build_keycode(keypad);
-	platform_set_drvdata(pdev, keypad);
+	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
+
+	for (i = 0; i < keymap_data->keymap_size; i++) {
+		unsigned int key = keymap_data->keymap[i];
+		unsigned int row = KEY_ROW(key);
+		unsigned int col = KEY_COL(key);
+		unsigned short keycode = KEY_VAL(key);
+		unsigned int scancode = MATRIX_SCAN_CODE(row, col,
+							 W90P910_ROW_SHIFT);
+
+		keypad->keymap[scancode] = keycode;
+		__set_bit(keycode, input_dev->keybit);
+	}
+	__clear_bit(KEY_RESERVED, input_dev->keybit);
+
 
-	error = request_irq(irq, w90p910_keypad_irq_handler, IRQF_DISABLED,
-			    pdev->name, keypad);
+	error = request_irq(keypad->irq, w90p910_keypad_irq_handler,
+			    IRQF_DISABLED, pdev->name, keypad);
 	if (error) {
 		dev_err(&pdev->dev, "failed to request IRQ\n");
-		goto failed_free_dev;
+		goto failed_put_clk;
 	}
 
-	keypad->irq = irq;
-
 	/* Register the input device */
 	error = input_register_device(input_dev);
 	if (error) {
@@ -238,20 +225,19 @@ static int __devinit w90p910_keypad_probe(struct platform_device *pdev)
 		goto failed_free_irq;
 	}
 
+	platform_set_drvdata(pdev, keypad);
 	return 0;
 
 failed_free_irq:
 	free_irq(irq, pdev);
-	platform_set_drvdata(pdev, NULL);
-failed_free_dev:
-	input_free_device(input_dev);
 failed_put_clk:
 	clk_put(keypad->clk);
 failed_free_io:
 	iounmap(keypad->mmio_base);
-failed_free_mem:
+failed_free_res:
 	release_mem_region(res->start, resource_size(res));
 failed_free:
+	input_free_device(input_dev);
 	kfree(keypad);
 	return error;
 }
@@ -268,12 +254,12 @@ static int __devexit w90p910_keypad_remove(struct platform_device *pdev)
 	input_unregister_device(keypad->input_dev);
 
 	iounmap(keypad->mmio_base);
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(res->start, resource_size(res));
 
 	platform_set_drvdata(pdev, NULL);
 	kfree(keypad);
+
 	return 0;
 }
 
