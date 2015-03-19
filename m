From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2] input: keypad: tc3589x: localize platform data
Date: Thu, 19 Mar 2015 15:52:44 +0100
Message-ID: <1426776765-18812-2-git-send-email-linus.walleij@linaro.org>
References: <1426776765-18812-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426776765-18812-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-input@vger.kernel.org

This driver can only get its platform data from the device tree,
and all platforms using it does that. Localize the platform data
for the keypad. A later patch will enforce the device tree / OF
dependence.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Dmitry it would be great if you could ACK this patch so Lee can
take it with the other patch through MFD.
---
 drivers/input/keyboard/tc3589x-keypad.c | 49 ++++++++++++++++++++++-----------
 include/linux/mfd/tc3589x.h             | 23 ----------------
 2 files changed, 33 insertions(+), 39 deletions(-)

diff --git a/drivers/input/keyboard/tc3589x-keypad.c b/drivers/input/keyboard/tc3589x-keypad.c
index 563932500ff1..0ccc7de9b59d 100644
--- a/drivers/input/keyboard/tc3589x-keypad.c
+++ b/drivers/input/keyboard/tc3589x-keypad.c
@@ -70,6 +70,28 @@
 #define TC3589x_KBD_INT_CLR	0x1
 
 /**
+ * struct tc35893_keypad_platform_data - platform specific keypad data
+ * @keymap_data:        matrix scan code table for keycodes
+ * @krow:               mask for available rows, value is 0xFF
+ * @kcol:               mask for available columns, value is 0xFF
+ * @debounce_period:    platform specific debounce time
+ * @settle_time:        platform specific settle down time
+ * @irqtype:            type of interrupt, falling or rising edge
+ * @enable_wakeup:      specifies if keypad event can wake up system from sleep
+ * @no_autorepeat:      flag for auto repetition
+ */
+struct tc3589x_keypad_platform_data {
+	const struct matrix_keymap_data *keymap_data;
+	u8                      krow;
+	u8                      kcol;
+	u8                      debounce_period;
+	u8                      settle_time;
+	unsigned long           irqtype;
+	bool                    enable_wakeup;
+	bool                    no_autorepeat;
+};
+
+/**
  * struct tc_keypad - data structure used by keypad driver
  * @tc3589x:    pointer to tc35893
  * @input:      pointer to input device object
@@ -360,23 +382,19 @@ static int tc3589x_keypad_probe(struct platform_device *pdev)
 	struct tc3589x *tc3589x = dev_get_drvdata(pdev->dev.parent);
 	struct tc_keypad *keypad;
 	struct input_dev *input;
-	const struct tc3589x_keypad_platform_data *plat;
 	int error, irq;
 
-	plat = tc3589x->pdata->keypad;
-	if (!plat) {
-		plat = tc3589x_keypad_of_probe(&pdev->dev);
-		if (IS_ERR(plat)) {
-			dev_err(&pdev->dev, "invalid keypad platform data\n");
-			return PTR_ERR(plat);
-		}
-	}
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
 
 	keypad = kzalloc(sizeof(struct tc_keypad), GFP_KERNEL);
+	keypad->board = tc3589x_keypad_of_probe(&pdev->dev);
+	if (IS_ERR(keypad->board)) {
+		dev_err(&pdev->dev, "invalid keypad platform data\n");
+		return PTR_ERR(keypad->board);
+	}
+
 	input = input_allocate_device();
 	if (!keypad || !input) {
 		dev_err(&pdev->dev, "failed to allocate keypad memory\n");
@@ -384,7 +402,6 @@ static int tc3589x_keypad_probe(struct platform_device *pdev)
 		goto err_free_mem;
 	}
 
-	keypad->board = plat;
 	keypad->input = input;
 	keypad->tc3589x = tc3589x;
 
@@ -395,7 +412,7 @@ static int tc3589x_keypad_probe(struct platform_device *pdev)
 	input->open = tc3589x_keypad_open;
 	input->close = tc3589x_keypad_close;
 
-	error = matrix_keypad_build_keymap(plat->keymap_data, NULL,
+	error = matrix_keypad_build_keymap(keypad->board->keymap_data, NULL,
 					   TC3589x_MAX_KPROW, TC3589x_MAX_KPCOL,
 					   NULL, input);
 	if (error) {
@@ -406,13 +423,13 @@ static int tc3589x_keypad_probe(struct platform_device *pdev)
 	keypad->keymap = input->keycode;
 
 	input_set_capability(input, EV_MSC, MSC_SCAN);
-	if (!plat->no_autorepeat)
+	if (!keypad->board->no_autorepeat)
 		__set_bit(EV_REP, input->evbit);
 
 	input_set_drvdata(input, keypad);
 
 	error = request_threaded_irq(irq, NULL, tc3589x_keypad_irq,
-				     plat->irqtype | IRQF_ONESHOT,
+				     keypad->board->irqtype | IRQF_ONESHOT,
 				     "tc3589x-keypad", keypad);
 	if (error < 0) {
 		dev_err(&pdev->dev,
@@ -428,8 +445,8 @@ static int tc3589x_keypad_probe(struct platform_device *pdev)
 	}
 
 	/* let platform decide if keypad is a wakeup source or not */
-	device_init_wakeup(&pdev->dev, plat->enable_wakeup);
-	device_set_wakeup_capable(&pdev->dev, plat->enable_wakeup);
+	device_init_wakeup(&pdev->dev, keypad->board->enable_wakeup);
+	device_set_wakeup_capable(&pdev->dev, keypad->board->enable_wakeup);
 
 	platform_set_drvdata(pdev, keypad);
 
diff --git a/include/linux/mfd/tc3589x.h b/include/linux/mfd/tc3589x.h
index c203c9c56776..468c31a27fcf 100644
--- a/include/linux/mfd/tc3589x.h
+++ b/include/linux/mfd/tc3589x.h
@@ -140,36 +140,13 @@ extern int tc3589x_set_bits(struct tc3589x *tc3589x, u8 reg, u8 mask, u8 val);
 #define TC_KPD_DEBOUNCE_PERIOD  0xA3
 #define TC_KPD_SETTLE_TIME      0xA3
 
-/**
- * struct tc35893_platform_data - data structure for platform specific data
- * @keymap_data:        matrix scan code table for keycodes
- * @krow:               mask for available rows, value is 0xFF
- * @kcol:               mask for available columns, value is 0xFF
- * @debounce_period:    platform specific debounce time
- * @settle_time:        platform specific settle down time
- * @irqtype:            type of interrupt, falling or rising edge
- * @enable_wakeup:      specifies if keypad event can wake up system from sleep
- * @no_autorepeat:      flag for auto repetition
- */
-struct tc3589x_keypad_platform_data {
-	const struct matrix_keymap_data *keymap_data;
-	u8                      krow;
-	u8                      kcol;
-	u8                      debounce_period;
-	u8                      settle_time;
-	unsigned long           irqtype;
-	bool                    enable_wakeup;
-	bool                    no_autorepeat;
-};
 
 /**
  * struct tc3589x_platform_data - TC3589x platform data
  * @block: bitmask of blocks to enable (use TC3589x_BLOCK_*)
- * @keypad: keypad-specific platform data
  */
 struct tc3589x_platform_data {
 	unsigned int block;
-	const struct tc3589x_keypad_platform_data *keypad;
 };
 
 #endif
-- 
1.9.3
