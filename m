From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: omap-keypad - remove set_col_gpio_val() and
 get_row_gpio_val()
Date: Thu, 7 Jan 2016 22:42:27 -0800
Message-ID: <20160108064227.GA30991@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35363 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbcAHGm3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jan 2016 01:42:29 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, Tony Lindgren <tony@atomide.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, linux-kernel@vger.kernel.org

Commit f799a3d8fe170159257b75c1baf48a7c1f625d1d ("Input: omap-keypad:
Remove dependencies to mach includes") removed users of the above
functions, but left them in the code.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/omap-keypad.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index 8dc34ee..146b26f 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -64,31 +64,6 @@ static DECLARE_TASKLET_DISABLED(kp_tasklet, omap_kp_tasklet, 0);
 static unsigned int *row_gpios;
 static unsigned int *col_gpios;
 
-#ifdef CONFIG_ARCH_OMAP2
-static void set_col_gpio_val(struct omap_kp *omap_kp, u8 value)
-{
-	int col;
-
-	for (col = 0; col < omap_kp->cols; col++)
-		gpio_set_value(col_gpios[col], value & (1 << col));
-}
-
-static u8 get_row_gpio_val(struct omap_kp *omap_kp)
-{
-	int row;
-	u8 value = 0;
-
-	for (row = 0; row < omap_kp->rows; row++) {
-		if (gpio_get_value(row_gpios[row]))
-			value |= (1 << row);
-	}
-	return value;
-}
-#else
-#define		set_col_gpio_val(x, y)	do {} while (0)
-#define		get_row_gpio_val(x)	0
-#endif
-
 static irqreturn_t omap_kp_interrupt(int irq, void *dev_id)
 {
 	/* disable keyboard interrupt and schedule for handling */
-- 
2.6.0.rc2.230.g3dd15c0


-- 
Dmitry
