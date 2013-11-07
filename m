From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] Input: tnetv107x-keypad - make irqs signed for error handling
Date: Thu, 7 Nov 2013 10:52:40 +0300
Message-ID: <20131107075240.GK21844@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:39264 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753634Ab3KGHxE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Nov 2013 02:53:04 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bill Pemberton <wfp5p@virginia.edu>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Javier Martinez Canillas <javier@dowhile0.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Sachin Kamat <sachin.kamat@linaro.org>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

There is a bug in keypad_probe() where we do:

	kp->irq_press   = platform_get_irq_byname(pdev, "press");
	kp->irq_release = platform_get_irq_byname(pdev, "release");
	if (kp->irq_press < 0 || kp->irq_release < 0) {

The problem is that these irq variables are unsigned so the error
handling doesn't work.  I've changed them to signed values.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/input/keyboard/tnetv107x-keypad.c b/drivers/input/keyboard/tnetv107x-keypad.c
index 5f7b427..8bd24d5 100644
--- a/drivers/input/keyboard/tnetv107x-keypad.c
+++ b/drivers/input/keyboard/tnetv107x-keypad.c
@@ -60,8 +60,8 @@ struct keypad_data {
 	struct clk			*clk;
 	struct device			*dev;
 	spinlock_t			lock;
-	u32				irq_press;
-	u32				irq_release;
+	int				irq_press;
+	int				irq_release;
 	int				rows, cols, row_shift;
 	int				debounce_ms, active_low;
 	u32				prev_keys[3];
