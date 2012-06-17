From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 2/4] input/nomadik-ske: suspend and resume support
Date: Sun, 17 Jun 2012 16:17:51 +0200
Message-ID: <1339942671-20121-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:42621 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757385Ab2FQOSB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Jun 2012 10:18:01 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

From: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>

Suspend and resume support for ske keypad by using disable or
enable of keypad.

Signed-off-by: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
Reviewed-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/input/keyboard/nomadik-ske-keypad.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/nomadik-ske-keypad.c b/drivers/input/keyboard/nomadik-ske-keypad.c
index 6857454..68c36a7 100644
--- a/drivers/input/keyboard/nomadik-ske-keypad.c
+++ b/drivers/input/keyboard/nomadik-ske-keypad.c
@@ -368,8 +368,11 @@ static int ske_keypad_suspend(struct device *dev)
 
 	if (device_may_wakeup(dev))
 		enable_irq_wake(irq);
-	else
+	else {
+		disable_irq(keypad->irq);
 		ske_keypad_set_bits(keypad, SKE_IMSC, ~SKE_KPIMA, 0x0);
+		clk_disable(keypad->clk);
+	}
 
 	return 0;
 }
@@ -382,8 +385,11 @@ static int ske_keypad_resume(struct device *dev)
 
 	if (device_may_wakeup(dev))
 		disable_irq_wake(irq);
-	else
-		ske_keypad_set_bits(keypad, SKE_IMSC, 0x0, SKE_KPIMA);
+	else {
+		clk_enable(keypad->clk);
+		enable_irq(keypad->irq);
+		ske_keypad_chip_init(keypad);
+	}
 
 	return 0;
 }
-- 
1.7.9.2

