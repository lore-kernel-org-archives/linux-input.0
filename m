From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] keyboard: imx_keypad: Fix clock handling
Date: Fri, 6 Jul 2012 12:40:28 -0300
Message-ID: <1341589228-26057-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]:58836
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755767Ab2GFPzi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 6 Jul 2012 11:55:38 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: kernel@pengutronix.de, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Adapt clock handling to the new i.mx clock framework and fix the following warning:

input: imx-keypad as /devices/platform/imx-keypad/input/input0                  
------------[ cut here ]------------                                            
WARNING: at drivers/clk/clk.c:511 __clk_enable+0x98/0xa8()                      
Modules linked in:                                                              
[<c001a680>] (unwind_backtrace+0x0/0xf4) from [<c002452c>] (warn_slowpath_commo)
[<c002452c>] (warn_slowpath_common+0x48/0x60) from [<c0024560>] (warn_slowpath_)
[<c0024560>] (warn_slowpath_null+0x1c/0x24) from [<c02c4ec4>] (__clk_enable+0x9)
[<c02c4ec4>] (__clk_enable+0x98/0xa8) from [<c02c4ef8>] (clk_enable+0x24/0x5c)  
[<c02c4ef8>] (clk_enable+0x24/0x5c) from [<c027ac6c>] (imx_keypad_open+0x28/0xc)
[<c027ac6c>] (imx_keypad_open+0x28/0xc8) from [<c0274b14>] (input_open_device+0)
[<c0274b14>] (input_open_device+0x78/0xa8) from [<c01ec884>] (kbd_connect+0x60/)
[<c01ec884>] (kbd_connect+0x60/0x80) from [<c0273b94>] (input_attach_handler+0x)
[<c0273b94>] (input_attach_handler+0x220/0x258) from [<c02755d4>] (input_regist)
[<c02755d4>] (input_register_device+0x31c/0x390) from [<c038da1c>] (imx_keypad_)
[<c038da1c>] (imx_keypad_probe+0x2e4/0x3b8) from [<c020326c>] (platform_drv_pro)
[<c020326c>] (platform_drv_probe+0x18/0x1c) from [<c0201f64>] (driver_probe_dev)
[<c0201f64>] (driver_probe_device+0x84/0x210) from [<c020217c>] (__driver_attac)
[<c020217c>] (__driver_attach+0x8c/0x90) from [<c02008f8>] (bus_for_each_dev+0x)
[<c02008f8>] (bus_for_each_dev+0x68/0x90) from [<c0201064>] (bus_add_driver+0xa)
[<c0201064>] (bus_add_driver+0xa4/0x23c) from [<c020275c>] (driver_register+0x7)
[<c020275c>] (driver_register+0x78/0x12c) from [<c00087c0>] (do_one_initcall+0x)
[<c00087c0>] (do_one_initcall+0x34/0x188) from [<c04b9310>] (kernel_init+0xe4/0)
[<c04b9310>] (kernel_init+0xe4/0x1a8) from [<c0015bd8>] (kernel_thread_exit+0x0)
---[ end trace 1d550e891d03d7ce ]--- 

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/input/keyboard/imx_keypad.c |   18 ++++++++----------
 1 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index 6ee7421..87540a4 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -378,7 +378,7 @@ static void imx_keypad_close(struct input_dev *dev)
 	imx_keypad_inhibit(keypad);
 
 	/* Disable clock unit */
-	clk_disable(keypad->clk);
+	clk_disable_unprepare(keypad->clk);
 }
 
 static int imx_keypad_open(struct input_dev *dev)
@@ -391,7 +391,7 @@ static int imx_keypad_open(struct input_dev *dev)
 	keypad->enabled = true;
 
 	/* Enable the kpp clock */
-	clk_enable(keypad->clk);
+	clk_prepare_enable(keypad->clk);
 	imx_keypad_config(keypad);
 
 	/* Sanity control, not all the rows must be actived now. */
@@ -467,7 +467,7 @@ static int __devinit imx_keypad_probe(struct platform_device *pdev)
 		goto failed_free_priv;
 	}
 
-	keypad->clk = clk_get(&pdev->dev, "kpp");
+	keypad->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(keypad->clk)) {
 		dev_err(&pdev->dev, "failed to get keypad clock\n");
 		error = PTR_ERR(keypad->clk);
@@ -485,7 +485,7 @@ static int __devinit imx_keypad_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"invalid key data (too many rows or colums)\n");
 		error = -EINVAL;
-		goto failed_clock_put;
+		goto failed_unmap;
 	}
 	dev_dbg(&pdev->dev, "enabled rows mask: %x\n", keypad->rows_en_mask);
 	dev_dbg(&pdev->dev, "enabled cols mask: %x\n", keypad->cols_en_mask);
@@ -503,7 +503,7 @@ static int __devinit imx_keypad_probe(struct platform_device *pdev)
 					   keypad->keycodes, input_dev);
 	if (error) {
 		dev_err(&pdev->dev, "failed to build keymap\n");
-		goto failed_clock_put;
+		goto failed_unmap;
 	}
 
 	__set_bit(EV_REP, input_dev->evbit);
@@ -517,7 +517,7 @@ static int __devinit imx_keypad_probe(struct platform_device *pdev)
 			    pdev->name, keypad);
 	if (error) {
 		dev_err(&pdev->dev, "failed to request IRQ\n");
-		goto failed_clock_put;
+		goto failed_unmap;
 	}
 
 	/* Register the input device */
@@ -534,8 +534,6 @@ static int __devinit imx_keypad_probe(struct platform_device *pdev)
 
 failed_free_irq:
 	free_irq(irq, pdev);
-failed_clock_put:
-	clk_put(keypad->clk);
 failed_unmap:
 	iounmap(keypad->mmio_base);
 failed_free_priv:
@@ -581,7 +579,7 @@ static int imx_kbd_suspend(struct device *dev)
 	mutex_lock(&input_dev->mutex);
 
 	if (input_dev->users)
-		clk_disable(kbd->clk);
+		clk_disable_unprepare(kbd->clk);
 
 	mutex_unlock(&input_dev->mutex);
 
@@ -603,7 +601,7 @@ static int imx_kbd_resume(struct device *dev)
 	mutex_lock(&input_dev->mutex);
 
 	if (input_dev->users)
-		clk_enable(kbd->clk);
+		clk_prepare_enable(kbd->clk);
 
 	mutex_unlock(&input_dev->mutex);
 
-- 
1.7.1


