From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH v2 1/2] Input: jornada720_kbd - switch to devm_* APIs
Date: Fri, 19 Aug 2016 17:30:59 +0100
Message-ID: <E1bamh9-0004Vi-0I@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:34980 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753665AbcHSQbC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 Aug 2016 12:31:02 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Switch the jornada720_kbd driver to use the devm_* APIs.  This is in
preparation to removing the mach/irqs.h include from this driver.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/input/keyboard/jornada720_kbd.c | 38 ++++++++-------------------------
 1 file changed, 9 insertions(+), 29 deletions(-)

diff --git a/drivers/input/keyboard/jornada720_kbd.c b/drivers/input/keyboard/jornada720_kbd.c
index 421d9c55b0e8..4b2e9ff18ba1 100644
--- a/drivers/input/keyboard/jornada720_kbd.c
+++ b/drivers/input/keyboard/jornada720_kbd.c
@@ -53,6 +53,7 @@ static unsigned short jornada_std_keymap[128] = {					/* ROW */
 struct jornadakbd {
 	unsigned short keymap[ARRAY_SIZE(jornada_std_keymap)];
 	struct input_dev *input;
+	int irq;
 };
 
 static irqreturn_t jornada720_kbd_interrupt(int irq, void *dev_id)
@@ -99,12 +100,10 @@ static int jornada720_kbd_probe(struct platform_device *pdev)
 	struct input_dev *input_dev;
 	int i, err;
 
-	jornadakbd = kzalloc(sizeof(struct jornadakbd), GFP_KERNEL);
-	input_dev = input_allocate_device();
-	if (!jornadakbd || !input_dev) {
-		err = -ENOMEM;
-		goto fail1;
-	}
+	jornadakbd = devm_kzalloc(&pdev->dev, sizeof(*jornadakbd), GFP_KERNEL);
+	input_dev = devm_input_allocate_device(&pdev->dev);
+	if (!jornadakbd || !input_dev)
+		return -ENOMEM;
 
 	platform_set_drvdata(pdev, jornadakbd);
 
@@ -127,37 +126,18 @@ static int jornada720_kbd_probe(struct platform_device *pdev)
 
 	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
 
-	err = request_irq(IRQ_GPIO0,
-			  jornada720_kbd_interrupt,
-			  IRQF_TRIGGER_FALLING,
-			  "jornadakbd", pdev);
+	err = devm_request_irq(&pdev->dev, IRQ_GPIO0, jornada720_kbd_interrupt,
+			       IRQF_TRIGGER_FALLING, "jornadakbd", pdev);
 	if (err) {
 		printk(KERN_INFO "jornadakbd720_kbd: Unable to grab IRQ\n");
-		goto fail1;
+		return err;
 	}
 
-	err = input_register_device(jornadakbd->input);
-	if (err)
-		goto fail2;
-
-	return 0;
-
- fail2:	/* IRQ, DEVICE, MEMORY */
-	free_irq(IRQ_GPIO0, pdev);
- fail1:	/* DEVICE, MEMORY */
-	input_free_device(input_dev);
-	kfree(jornadakbd);
-	return err;
+	return input_register_device(jornadakbd->input);
 };
 
 static int jornada720_kbd_remove(struct platform_device *pdev)
 {
-	struct jornadakbd *jornadakbd = platform_get_drvdata(pdev);
-
-	free_irq(IRQ_GPIO0, pdev);
-	input_unregister_device(jornadakbd->input);
-	kfree(jornadakbd);
-
 	return 0;
 }
 
-- 
2.1.0

