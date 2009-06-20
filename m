From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: [PATCH] ep93xx_keypad: remove macros and update clkdev support
Date: Sat, 20 Jun 2009 18:36:12 -0400
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909019683A6@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6ob109.obsmtp.com ([64.18.1.22]:59766 "HELO psmtp.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751888AbZFTWgM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Jun 2009 18:36:12 -0400
Content-class: urn:content-classes:message
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

The keypad_{readl|writel} macros are both only used once.  Remove
them and just open code the __raw_{readl|writel}.

The ep93xx_keypad clock is matched based on the device ID.  Change
the clk_get() call to reflect this.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

Note: a patch to add the necessary ep93xx clkdev support was recently
submitted to linux-arm-kernel.  If anyone needs this patch right now
please let me know.


diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
index 181d30e..ebb0026 100644
--- a/drivers/input/keyboard/ep93xx_keypad.c
+++ b/drivers/input/keyboard/ep93xx_keypad.c
@@ -60,9 +60,6 @@
 #define KEY_REG_KEY1_MASK	(0x0000003f)
 #define KEY_REG_KEY1_SHIFT	(0)
 
-#define keypad_readl(off)	__raw_readl(keypad->mmio_base + (off))
-#define keypad_writel(v, off)	__raw_writel((v), keypad->mmio_base + (off))
-
 #define MAX_MATRIX_KEY_NUM	(MAX_MATRIX_KEY_ROWS * MAX_MATRIX_KEY_COLS)
 
 struct ep93xx_keypad {
@@ -102,9 +99,11 @@ static irqreturn_t ep93xx_keypad_irq_handler(int irq, void *dev_id)
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
 
@@ -167,7 +166,7 @@ static void ep93xx_keypad_config(struct ep93xx_keypad *keypad)
 
 	val |= ((pdata->prescale << KEY_INIT_PRSCL_SHIFT) & KEY_INIT_PRSCL_MASK);
 
-	keypad_writel(val, KEY_INIT);
+	__raw_writel(val, keypad->mmio_base + KEY_INIT);
 }
 
 static int ep93xx_keypad_open(struct input_dev *pdev)
@@ -323,7 +322,7 @@ static int __devinit ep93xx_keypad_probe(struct platform_device *pdev)
 		}
 	}
 
-	keypad->clk = clk_get(&pdev->dev, "key_clk");
+	keypad->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(keypad->clk)) {
 		dev_err(&pdev->dev, "failed to get keypad clock\n");
 		err = PTR_ERR(keypad->clk); 
