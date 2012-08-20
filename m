From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: [PATCH] Input: imx_keypad - reset the hardware before enabling
Date: Mon, 20 Aug 2012 23:34:21 +0200
Message-ID: <1345498461-18197-1-git-send-email-m.grzeschik@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42579 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686Ab2HTVe0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Aug 2012 17:34:26 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

assert the hardware is correctly initialized before requesting the
interrupt. Otherwise if a key was already touched since power-on the
kernel enters an interrupt loop. To fix this issue we clear pending
interrupt sources. We have to ensure to enable clks while changing the
keypad registers.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/input/keyboard/imx_keypad.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index ff4c0a8..ce68e36 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -358,6 +358,7 @@ static void imx_keypad_inhibit(struct imx_keypad *keypad)
 	/* Inhibit KDI and KRI interrupts. */
 	reg_val = readw(keypad->mmio_base + KPSR);
 	reg_val &= ~(KBD_STAT_KRIE | KBD_STAT_KDIE);
+	reg_val |= KBD_STAT_KPKR | KBD_STAT_KPKD;
 	writew(reg_val, keypad->mmio_base + KPSR);
 
 	/* Colums as open drain and disable all rows */
@@ -515,7 +516,9 @@ static int __devinit imx_keypad_probe(struct platform_device *pdev)
 	input_set_drvdata(input_dev, keypad);
 
 	/* Ensure that the keypad will stay dormant until opened */
+	clk_enable(keypad->clk);
 	imx_keypad_inhibit(keypad);
+	clk_disable(keypad->clk);
 
 	error = request_irq(irq, imx_keypad_irq_handler, 0,
 			    pdev->name, keypad);
-- 
1.7.10.4

