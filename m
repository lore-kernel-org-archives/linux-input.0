From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: A few changes to pxa27x_keypad
Date: Thu, 23 Jul 2009 00:36:25 -0700
Message-ID: <20090723073625.GC3997@dtor-d630.eng.vmware.com>
References: <20090721080845.GD10168@dtor-d630.eng.vmware.com> <4A659C28.3040305@compulab.co.il> <20090723063044.GD2782@dtor-d630.eng.vmware.com> <20090723072802.GB3997@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:44818 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbZGWHg3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jul 2009 03:36:29 -0400
Received: by rv-out-0506.google.com with SMTP id f6so215720rvb.1
        for <linux-input@vger.kernel.org>; Thu, 23 Jul 2009 00:36:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090723072802.GB3997@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: Eric Miao <eric.y.miao@gmail.com>, linux-input@vger.kernel.org

On Thu, Jul 23, 2009 at 12:28:02AM -0700, Dmitry Torokhov wrote:
> On Wed, Jul 22, 2009 at 11:30:44PM -0700, Dmitry Torokhov wrote:
> > On Tue, Jul 21, 2009 at 01:44:56PM +0300, Mike Rapoport wrote:
> > > Hi Dmitry,
> > > 
> > > Dmitry Torokhov wrote:
> > > > Hi Eric,
> > > > 
> > > > I made a few adjustments to the pxa27x_keypad driver and was wondering
> > > > if you would be able to give it a sping and check if I broke it or not.
> > > 
> > > Apparently not :)
> > > Tested-by: Mike Rapoport <mike@compulab.co.il>
> > > 
> > 
> > Cool, thanks for testing. I have another one for you then ;)
> > 
> > TIA!
> > 
> 
> Umm.. this one is hopefully better...
> 

And another one implementing keymap manipulation.

-- 
Dmitry


Input: pxa27x_keypad - allow modifying keymap from userspace

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 arch/arm/mach-pxa/include/mach/pxa27x_keypad.h |    3 
 drivers/input/keyboard/pxa27x_keypad.c         |  168 +++++++++++++-----------
 2 files changed, 90 insertions(+), 81 deletions(-)


diff --git a/arch/arm/mach-pxa/include/mach/pxa27x_keypad.h b/arch/arm/mach-pxa/include/mach/pxa27x_keypad.h
index 63e8965..a0e5561 100644
--- a/arch/arm/mach-pxa/include/mach/pxa27x_keypad.h
+++ b/arch/arm/mach-pxa/include/mach/pxa27x_keypad.h
@@ -6,6 +6,7 @@
 
 #define MAX_MATRIX_KEY_ROWS	(8)
 #define MAX_MATRIX_KEY_COLS	(8)
+#define MAX_DIRECT_KEY_NUM	(8)
 
 /* pxa3xx keypad platform specific parameters
  *
@@ -34,7 +35,7 @@ struct pxa27x_keypad_platform_data {
 
 	/* direct keys */
 	int		direct_key_num;
-	unsigned int	direct_key_map[8];
+	unsigned int	direct_key_map[MAX_DIRECT_KEY_NUM];
 
 	/* rotary encoders 0 */
 	int		enable_rotary0;
diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index c987cc7..68f5b10 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -96,7 +96,8 @@
 #define keypad_readl(off)	__raw_readl(keypad->mmio_base + (off))
 #define keypad_writel(off, v)	__raw_writel((v), keypad->mmio_base + (off))
 
-#define MAX_MATRIX_KEY_NUM	(8 * 8)
+#define MAX_MATRIX_KEY_NUM	(MAX_MATRIX_KEY_ROWS * MAX_MATRIX_KEY_COLS)
+#define MAX_KEYPAD_KEYS		(MAX_MATRIX_KEY_NUM + MAX_DIRECT_KEY_NUM)
 
 struct pxa27x_keypad {
 	struct pxa27x_keypad_platform_data *pdata;
@@ -107,73 +108,80 @@ struct pxa27x_keypad {
 
 	int irq;
 
-	/* matrix key code map */
-	unsigned short matrix_keycodes[MAX_MATRIX_KEY_NUM];
+	unsigned short keycodes[MAX_KEYPAD_KEYS];
+	int rotary_rel_code[2];
 
 	/* state row bits of each column scan */
 	uint32_t matrix_key_state[MAX_MATRIX_KEY_COLS];
 	uint32_t direct_key_state;
 
 	unsigned int direct_key_mask;
-
-	int rotary_rel_code[2];
-	int rotary_up_key[2];
-	int rotary_down_key[2];
 };
 
 static void pxa27x_keypad_build_keycode(struct pxa27x_keypad *keypad)
 {
 	struct pxa27x_keypad_platform_data *pdata = keypad->pdata;
 	struct input_dev *input_dev = keypad->input_dev;
+	unsigned short code;
 	int i;
 
 	for (i = 0; i < pdata->matrix_key_map_size; i++) {
 		unsigned int key = pdata->matrix_key_map[i];
 		unsigned int row = KEY_ROW(key);
 		unsigned int col = KEY_COL(key);
-		unsigned short code = KEY_VAL(key);
 
-		keypad->matrix_keycodes[(row << 3) + col] = code;
+		code = KEY_VAL(key);
+		keypad->keycodes[(row << 3) + col] = code;
 		__set_bit(code, input_dev->keybit);
 	}
-	__clear_bit(KEY_RESERVED, input_dev->keybit);
 
-	for (i = 0; i < pdata->direct_key_num; i++)
-		__set_bit(pdata->direct_key_map[i], input_dev->keybit);
-
-	keypad->rotary_up_key[0] = pdata->rotary0_up_key;
-	keypad->rotary_up_key[1] = pdata->rotary1_up_key;
-	keypad->rotary_down_key[0] = pdata->rotary0_down_key;
-	keypad->rotary_down_key[1] = pdata->rotary1_down_key;
-	keypad->rotary_rel_code[0] = pdata->rotary0_rel_code;
-	keypad->rotary_rel_code[1] = pdata->rotary1_rel_code;
+	for (i = 0; i < pdata->direct_key_num; i++) {
+		code = pdata->direct_key_map[i];
+		keypad->keycodes[MAX_MATRIX_KEY_NUM + i] = code;
+		__set_bit(code, input_dev->keybit);
+	}
 
 	if (pdata->enable_rotary0) {
 		if (pdata->rotary0_up_key && pdata->rotary0_down_key) {
-			__set_bit(pdata->rotary0_up_key, input_dev->keybit);
-			__set_bit(pdata->rotary0_down_key, input_dev->keybit);
-		} else
+			code = pdata->rotary0_up_key;
+			keypad->keycodes[MAX_MATRIX_KEY_NUM + 0] = code;
+			__set_bit(code, input_dev->keybit);
+
+			code = pdata->rotary0_down_key;
+			keypad->keycodes[MAX_MATRIX_KEY_NUM + 1] = code;
+			__set_bit(code, input_dev->keybit);
+
+			keypad->rotary_rel_code[0] = -1;
+		} else {
+			keypad->rotary_rel_code[0] = pdata->rotary0_rel_code;
 			__set_bit(pdata->rotary0_rel_code, input_dev->relbit);
+		}
 	}
 
 	if (pdata->enable_rotary1) {
 		if (pdata->rotary1_up_key && pdata->rotary1_down_key) {
-			__set_bit(pdata->rotary1_up_key, input_dev->keybit);
-			__set_bit(pdata->rotary1_down_key, input_dev->keybit);
-		} else
+			code = pdata->rotary1_up_key;
+			keypad->keycodes[MAX_MATRIX_KEY_NUM + 2] = code;
+			__set_bit(code, input_dev->keybit);
+
+			code = pdata->rotary1_down_key;
+			keypad->keycodes[MAX_MATRIX_KEY_NUM + 3] = code;
+			__set_bit(code, input_dev->keybit);
+
+			keypad->rotary_rel_code[1] = -1;
+		} else {
+			keypad->rotary_rel_code[1] = pdata->rotary1_rel_code;
 			__set_bit(pdata->rotary1_rel_code, input_dev->relbit);
+		}
 	}
-}
 
-static inline unsigned int lookup_matrix_keycode(
-		struct pxa27x_keypad *keypad, int row, int col)
-{
-	return keypad->matrix_keycodes[(row << 3) + col];
+	__clear_bit(KEY_RESERVED, input_dev->keybit);
 }
 
 static void pxa27x_keypad_scan_matrix(struct pxa27x_keypad *keypad)
 {
 	struct pxa27x_keypad_platform_data *pdata = keypad->pdata;
+	struct input_dev *input_dev = keypad->input_dev;
 	int row, col, num_keys_pressed = 0;
 	uint32_t new_state[MAX_MATRIX_KEY_COLS];
 	uint32_t kpas = keypad_readl(KPAS);
@@ -216,6 +224,7 @@ static void pxa27x_keypad_scan_matrix(struct pxa27x_keypad *keypad)
 scan:
 	for (col = 0; col < pdata->matrix_key_cols; col++) {
 		uint32_t bits_changed;
+		int code;
 
 		bits_changed = keypad->matrix_key_state[col] ^ new_state[col];
 		if (bits_changed == 0)
@@ -225,12 +234,13 @@ scan:
 			if ((bits_changed & (1 << row)) == 0)
 				continue;
 
-			input_report_key(keypad->input_dev,
-				lookup_matrix_keycode(keypad, row, col),
-				new_state[col] & (1 << row));
+			code = (row << 3) + col;
+			input_event(input_dev, EV_MSC, MSC_SCAN, code);
+			input_report_key(input_dev, keypad->keycodes[code],
+					 new_state[col] & (1 << row));
 		}
 	}
-	input_sync(keypad->input_dev);
+	input_sync(input_dev);
 	memcpy(keypad->matrix_key_state, new_state, sizeof(new_state));
 }
 
@@ -253,13 +263,15 @@ static void report_rotary_event(struct pxa27x_keypad *keypad, int r, int delta)
 	if (delta == 0)
 		return;
 
-	if (keypad->rotary_up_key[r] && keypad->rotary_down_key[r]) {
-		int keycode = (delta > 0) ? keypad->rotary_up_key[r] :
-					    keypad->rotary_down_key[r];
+	if (keypad->rotary_rel_code[r] == -1) {
+		int code = MAX_MATRIX_KEY_NUM + 2 * r + (delta > 0 ? 0 : 1);
+		unsigned char keycode = keypad->keycodes[code];
 
 		/* simulate a press-n-release */
+		input_event(dev, EV_MSC, MSC_SCAN, code);
 		input_report_key(dev, keycode, 1);
 		input_sync(dev);
+		input_event(dev, EV_MSC, MSC_SCAN, code);
 		input_report_key(dev, keycode, 0);
 		input_sync(dev);
 	} else {
@@ -287,6 +299,7 @@ static void pxa27x_keypad_scan_rotary(struct pxa27x_keypad *keypad)
 static void pxa27x_keypad_scan_direct(struct pxa27x_keypad *keypad)
 {
 	struct pxa27x_keypad_platform_data *pdata = keypad->pdata;
+	struct input_dev *input_dev = keypad->input_dev;
 	unsigned int new_state;
 	uint32_t kpdk, bits_changed;
 	int i;
@@ -296,9 +309,6 @@ static void pxa27x_keypad_scan_direct(struct pxa27x_keypad *keypad)
 	if (pdata->enable_rotary0 || pdata->enable_rotary1)
 		pxa27x_keypad_scan_rotary(keypad);
 
-	if (pdata->direct_key_map == NULL)
-		return;
-
 	new_state = KPDK_DK(kpdk) & keypad->direct_key_mask;
 	bits_changed = keypad->direct_key_state ^ new_state;
 
@@ -306,12 +316,15 @@ static void pxa27x_keypad_scan_direct(struct pxa27x_keypad *keypad)
 		return;
 
 	for (i = 0; i < pdata->direct_key_num; i++) {
-		if (bits_changed & (1 << i))
-			input_report_key(keypad->input_dev,
-					pdata->direct_key_map[i],
-					(new_state & (1 << i)));
+		if (bits_changed & (1 << i)) {
+			int code = MAX_MATRIX_KEY_NUM + i;
+
+			input_event(input_dev, EV_MSC, MSC_SCAN, code);
+			input_report_key(input_dev, keypad->keycodes[code],
+					 new_state & (1 << i));
+		}
 	}
-	input_sync(keypad->input_dev);
+	input_sync(input_dev);
 	keypad->direct_key_state = new_state;
 }
 
@@ -432,38 +445,41 @@ static const struct dev_pm_ops pxa27x_keypad_pm_ops = {
 
 static int __devinit pxa27x_keypad_probe(struct platform_device *pdev)
 {
+	struct pxa27x_keypad_platform_data *pdata = pdev->dev.platform_data;
 	struct pxa27x_keypad *keypad;
 	struct input_dev *input_dev;
 	struct resource *res;
 	int irq, error;
 
-	keypad = kzalloc(sizeof(struct pxa27x_keypad), GFP_KERNEL);
-	if (keypad == NULL) {
-		dev_err(&pdev->dev, "failed to allocate driver data\n");
-		return -ENOMEM;
-	}
-
-	keypad->pdata = pdev->dev.platform_data;
-	if (keypad->pdata == NULL) {
+	if (pdata == NULL) {
 		dev_err(&pdev->dev, "no platform data defined\n");
-		error = -EINVAL;
-		goto failed_free;
+		return -EINVAL;
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "failed to get keypad irq\n");
-		error = -ENXIO;
-		goto failed_free;
+		return -ENXIO;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res == NULL) {
 		dev_err(&pdev->dev, "failed to get I/O memory\n");
-		error = -ENXIO;
+		return -ENXIO;
+	}
+
+	keypad = kzalloc(sizeof(struct pxa27x_keypad), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!keypad || !input_dev) {
+		dev_err(&pdev->dev, "failed to allocate memory\n");
+		error = -ENOMEM;
 		goto failed_free;
 	}
 
+	keypad->pdata = pdata;
+	keypad->input_dev = input_dev;
+	keypad->irq = irq;
+
 	res = request_mem_region(res->start, resource_size(res), pdev->name);
 	if (res == NULL) {
 		dev_err(&pdev->dev, "failed to request I/O memory\n");
@@ -485,43 +501,35 @@ static int __devinit pxa27x_keypad_probe(struct platform_device *pdev)
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
 	input_dev->name = pdev->name;
 	input_dev->id.bustype = BUS_HOST;
 	input_dev->open = pxa27x_keypad_open;
 	input_dev->close = pxa27x_keypad_close;
 	input_dev->dev.parent = &pdev->dev;
 
-	keypad->input_dev = input_dev;
+	input_dev->keycode = keypad->keycodes;
+	input_dev->keycodesize = sizeof(keypad->keycodes[0]);
+	input_dev->keycodemax = ARRAY_SIZE(keypad->keycodes);
+
 	input_set_drvdata(input_dev, keypad);
 
 	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
-	if ((keypad->pdata->enable_rotary0 &&
-			keypad->pdata->rotary0_rel_code) ||
-	    (keypad->pdata->enable_rotary1 &&
-			keypad->pdata->rotary1_rel_code)) {
-		input_dev->evbit[0] |= BIT_MASK(EV_REL);
-	}
+	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
 
 	pxa27x_keypad_build_keycode(keypad);
-	platform_set_drvdata(pdev, keypad);
+
+	if ((pdata->enable_rotary0 && keypad->rotary_rel_code[0] != -1) ||
+	    (pdata->enable_rotary1 && keypad->rotary_rel_code[1] != -1)) {
+		input_dev->evbit[0] |= BIT_MASK(EV_REL);
+	}
 
 	error = request_irq(irq, pxa27x_keypad_irq_handler, IRQF_DISABLED,
 			    pdev->name, keypad);
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
@@ -529,15 +537,13 @@ static int __devinit pxa27x_keypad_probe(struct platform_device *pdev)
 		goto failed_free_irq;
 	}
 
+	platform_set_drvdata(pdev, keypad);
 	device_init_wakeup(&pdev->dev, 1);
 
 	return 0;
 
 failed_free_irq:
 	free_irq(irq, pdev);
-	platform_set_drvdata(pdev, NULL);
-failed_free_dev:
-	input_free_device(input_dev);
 failed_put_clk:
 	clk_put(keypad->clk);
 failed_free_io:
@@ -545,6 +551,7 @@ failed_free_io:
 failed_free_mem:
 	release_mem_region(res->start, resource_size(res));
 failed_free:
+	input_free_device(input_dev);
 	kfree(keypad);
 	return error;
 }
@@ -567,6 +574,7 @@ static int __devexit pxa27x_keypad_remove(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, NULL);
 	kfree(keypad);
+
 	return 0;
 }
 
