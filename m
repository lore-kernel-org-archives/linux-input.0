From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Patch v7 1/2] input: add support for Nomadik SKE keypad
 controller
Date: Wed, 29 Sep 2010 19:40:45 -0700
Message-ID: <20100930024045.GD5260@core.coreip.homeip.net>
References: <1285666324-14578-1-git-send-email-sundar.iyer@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58461 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452Ab0I3Cky (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Sep 2010 22:40:54 -0400
Received: by ywh1 with SMTP id 1so474653ywh.19
        for <linux-input@vger.kernel.org>; Wed, 29 Sep 2010 19:40:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1285666324-14578-1-git-send-email-sundar.iyer@stericsson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sundar Iyer <sundar.iyer@stericsson.com>
Cc: linux-input@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>

On Tue, Sep 28, 2010 at 03:02:04PM +0530, Sundar Iyer wrote:
> Add support for the keypad controller in the Scroll Key Encoder (SKE)
> module on the Nomadik family and the DB8500 SoC.
> 
> Acked-by: Linus Walleij <linus.walleij@stericsson.com>
> Signed-off-by: Sundar Iyer <sundar.iyer@stericsson.com>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

Applied with the following small changes:

 arch/arm/mach-ux500/board-mop500.c          |    2 +-
 arch/arm/plat-nomadik/include/plat/ske.h    |    2 +-
 drivers/input/keyboard/nomadik-ske-keypad.c |   12 ++++++------
 3 files changed, 8 insertions(+), 8 deletions(-)


diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 3450b74..5265fb9 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -177,7 +177,7 @@ static const unsigned int ux500_keymap[] = {
 	KEY(3, 2, KEY_7),
 };
 
-static struct matrix_keymap_data ux500_keymap_data = {
+static const struct matrix_keymap_data ux500_keymap_data = {
 	.keymap         = ux500_keymap,
 	.keymap_size    = ARRAY_SIZE(ux500_keymap),
 };
diff --git a/arch/arm/plat-nomadik/include/plat/ske.h b/arch/arm/plat-nomadik/include/plat/ske.h
index 148b2bc..31382fb 100644
--- a/arch/arm/plat-nomadik/include/plat/ske.h
+++ b/arch/arm/plat-nomadik/include/plat/ske.h
@@ -40,7 +40,7 @@
 struct ske_keypad_platform_data {
 	int (*init)(void);
 	int (*exit)(void);
-	struct matrix_keymap_data *keymap_data;
+	const struct matrix_keymap_data *keymap_data;
 	u8 krow;
 	u8 kcol;
 	u8 debounce_ms;
diff --git a/drivers/input/keyboard/nomadik-ske-keypad.c b/drivers/input/keyboard/nomadik-ske-keypad.c
index 8c6ce8a..6e0f230 100644
--- a/drivers/input/keyboard/nomadik-ske-keypad.c
+++ b/drivers/input/keyboard/nomadik-ske-keypad.c
@@ -83,7 +83,7 @@ static void ske_keypad_set_bits(struct ske_keypad *keypad, u16 addr,
 }
 
 /*
- * ske_keypad_chip_init : init keypad controller configuration
+ * ske_keypad_chip_init: init keypad controller configuration
  *
  * Enable Multi key press detection, auto scan mode
  */
@@ -144,7 +144,7 @@ static void ske_keypad_read_data(struct ske_keypad *keypad)
 	 * Read the auto scan registers
 	 *
 	 * Each SKE_ASRx (x=0 to x=3) contains two row values.
-	 * lower byte contains row value for coloumn 2*x,
+	 * lower byte contains row value for column 2*x,
 	 * upper byte contains row value for column 2*x + 1
 	 */
 	for (i = 0; i < SKE_NUM_ASRX_REGISTERS; i++) {
@@ -152,7 +152,7 @@ static void ske_keypad_read_data(struct ske_keypad *keypad)
 		if (!ske_asr)
 			continue;
 
-		/* now that ASRx is zero, find out the coloumn x and row y*/
+		/* now that ASRx is zero, find out the column x and row y*/
 		if (ske_asr & 0xff) {
 			col = i * 2;
 			status = ske_asr & 0xff;
@@ -251,7 +251,7 @@ static int __devinit ske_keypad_probe(struct platform_device *pdev)
 
 	keypad->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(keypad->clk)) {
-		dev_err(&pdev->dev, "failed to clk_get\n");
+		dev_err(&pdev->dev, "failed to get clk\n");
 		error = PTR_ERR(keypad->clk);
 		goto err_iounmap;
 	}
@@ -285,8 +285,8 @@ static int __devinit ske_keypad_probe(struct platform_device *pdev)
 		goto err_clk_disable;
 	}
 
-	error = request_irq(keypad->irq, ske_keypad_irq, 0,
-			"ske-keypad", keypad);
+	error = request_threaded_irq(keypad->irq, NULL, ske_keypad_irq,
+				     IRQF_ONESHOT, "ske-keypad", keypad);
 	if (error) {
 		dev_err(&pdev->dev, "allocate irq %d failed\n", keypad->irq);
 		goto err_clk_disable;

The main change is use of request_threaded_irq() - we do need it as you
msleep() in the handler.

Thanks.

-- 
Dmitry
