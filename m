From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] input: sh_keysc: Switch to threaded IRQ handler
Date: Thu, 21 Apr 2011 22:38:24 +0900
Message-ID: <20110421133824.8698.22092.sendpatchset@t400s>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, dmitry.torokhov@gmail.com, simon@horms.net, linux-sh@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the KEYSC driver to make use of threaded IRQs
with IRQF_ONESHOT.

Also pass dev_name() as string for /proc/interrupts.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/input/keyboard/sh_keysc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- 0011/drivers/input/keyboard/sh_keysc.c
+++ work/drivers/input/keyboard/sh_keysc.c	2011-04-21 19:42:33.000000000 +0900
@@ -231,7 +231,8 @@ static int __devinit sh_keysc_probe(stru
 	input->keycodesize = sizeof(pdata->keycodes[0]);
 	input->keycodemax = ARRAY_SIZE(pdata->keycodes);
 
-	error = request_irq(irq, sh_keysc_isr, 0, pdev->name, pdev);
+	error = request_threaded_irq(irq, NULL, sh_keysc_isr, IRQF_ONESHOT,
+				     dev_name(&pdev->dev), pdev);
 	if (error) {
 		dev_err(&pdev->dev, "failed to request IRQ\n");
 		goto err3;
