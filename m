From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: RE: [PATCH] ep93xx_keypad.c: cleanup and use matrix_keypad helpers
Date: Mon, 11 Jan 2010 15:48:48 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190902089963@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE19090200F166@mi8nycmail19.Mi8.com> <20091221181959.GA6696@core.coreip.homeip.net> <BD79186B4FD85F4B8E60E381CAEE19090200F172@mi8nycmail19.Mi8.com> <BD79186B4FD85F4B8E60E381CAEE19090200F17C@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6og103.obsmtp.com ([64.18.1.185]:58681 "HELO
	exprod6og103.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753960Ab0AKUst convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jan 2010 15:48:49 -0500
Content-class: urn:content-classes:message
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE19090200F17C@mi8nycmail19.Mi8.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Ping... Any comments on this Dmitry?

Regards,
Hartley 

-----Original Message-----
From: linux-input-owner@vger.kernel.org [mailto:linux-input-owner@vger.kernel.org] On Behalf Of H Hartley Sweeten
Sent: Monday, December 21, 2009 11:40 AM
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov
Subject: RE: [PATCH] ep93xx_keypad.c: cleanup and use matrix_keypad helpers

ep93xx_keypad.c: cleanup and use matrix_keypad helpers

Use struct matrix_keymap_data to supply the keymap from the platform code
and matrix_keypad_build_keymap() to initialize the keymap.

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
index e457404..bd25a3a 100644
--- a/drivers/input/keyboard/ep93xx_keypad.c
+++ b/drivers/input/keyboard/ep93xx_keypad.c
@@ -69,7 +69,7 @@ struct ep93xx_keypad {
 
 	void __iomem *mmio_base;
 
-	unsigned int matrix_keycodes[EP93XX_MATRIX_SIZE];
+	unsigned short keycodes[EP93XX_MATRIX_SIZE];
 
 	int key1;
 	int key2;
@@ -79,24 +79,6 @@ struct ep93xx_keypad {
 	bool enabled;
 };
 
-static void ep93xx_keypad_build_keycode(struct ep93xx_keypad *keypad)
-{
-	struct ep93xx_keypad_platform_data *pdata = keypad->pdata;
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
 static irqreturn_t ep93xx_keypad_irq_handler(int irq, void *dev_id)
 {
 	struct ep93xx_keypad *keypad = dev_id;
@@ -107,10 +89,10 @@ static irqreturn_t ep93xx_keypad_irq_handler(int irq, void *dev_id)
 	status = __raw_readl(keypad->mmio_base + KEY_REG);
 
 	keycode = (status & KEY_REG_KEY1_MASK) >> KEY_REG_KEY1_SHIFT;
-	key1 = keypad->matrix_keycodes[keycode];
+	key1 = keypad->keycodes[keycode];
 
 	keycode = (status & KEY_REG_KEY2_MASK) >> KEY_REG_KEY2_SHIFT;
-	key2 = keypad->matrix_keycodes[keycode];
+	key2 = keypad->keycodes[keycode];
 
 	if (status & KEY_REG_2KEYS) {
 		if (keypad->key1 && key1 != keypad->key1 && key2 != keypad->key1)
@@ -256,6 +238,7 @@ static int ep93xx_keypad_resume(struct platform_device *pdev)
 static int __devinit ep93xx_keypad_probe(struct platform_device *pdev)
 {
 	struct ep93xx_keypad *keypad;
+	const struct matrix_keymap_data *keymap_data;
 	struct input_dev *input_dev;
 	struct resource *res;
 	int err;
@@ -270,6 +253,12 @@ static int __devinit ep93xx_keypad_probe(struct platform_device *pdev)
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
@@ -317,9 +306,9 @@ static int __devinit ep93xx_keypad_probe(struct platform_device *pdev)
 	input_dev->open = ep93xx_keypad_open;
 	input_dev->close = ep93xx_keypad_close;
 	input_dev->dev.parent = &pdev->dev;
-	input_dev->keycode = keypad->matrix_keycodes;
-	input_dev->keycodesize = sizeof(keypad->matrix_keycodes[0]);
-	input_dev->keycodemax = ARRAY_SIZE(keypad->matrix_keycodes);
+	input_dev->keycode = keypad->keycodes;
+	input_dev->keycodesize = sizeof(keypad->keycodes[0]);
+	input_dev->keycodemax = ARRAY_SIZE(keypad->keycodes);
 
 	input_set_drvdata(input_dev, keypad);
 
@@ -327,7 +316,8 @@ static int __devinit ep93xx_keypad_probe(struct platform_device *pdev)
 	if (keypad->pdata->flags & EP93XX_KEYPAD_AUTOREPEAT)
 		input_dev->evbit[0] |= BIT_MASK(EV_REP);
 
-	ep93xx_keypad_build_keycode(keypad);
+	matrix_keypad_build_keymap(keymap_data, 3,
+				   input_dev->keycode, input_dev->keybit);
 	platform_set_drvdata(pdev, keypad);
 
 	err = request_irq(keypad->irq, ep93xx_keypad_irq_handler, 
--
To unsubscribe from this list: send the line "unsubscribe linux-input" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
