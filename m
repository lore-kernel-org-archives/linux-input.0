From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/3] input: stmpe: bias keypad columns properly
Date: Sat, 18 Oct 2014 14:56:39 +0200
Message-ID: <1413636999-3326-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:51201 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbaJRM4q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Oct 2014 08:56:46 -0400
Received: by mail-lb0-f181.google.com with SMTP id l4so1863258lbv.40
        for <linux-input@vger.kernel.org>; Sat, 18 Oct 2014 05:56:44 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>

All keypad column pins used as inputs should be pulled up
on the STMPE24xx, but this is not done by the current driver.
Add some logic that will do this properly. The STMPE1601 also
has a keypad controller, but explicitly does *NOT* require
you to set up any pull-ups.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/input/keyboard/stmpe-keypad.c | 37 +++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/stmpe-keypad.c b/drivers/input/keyboard/stmpe-keypad.c
index d46391f48310..fe6e3f22eed7 100644
--- a/drivers/input/keyboard/stmpe-keypad.c
+++ b/drivers/input/keyboard/stmpe-keypad.c
@@ -52,6 +52,7 @@
  * struct stmpe_keypad_variant - model-specific attributes
  * @auto_increment: whether the KPC_DATA_BYTE register address
  *		    auto-increments on multiple read
+ * @set_pullup: whether the pins need to have their pull-ups set
  * @num_data: number of data bytes
  * @num_normal_data: number of normal keys' data bytes
  * @max_cols: maximum number of columns supported
@@ -61,6 +62,7 @@
  */
 struct stmpe_keypad_variant {
 	bool		auto_increment;
+	bool		set_pullup;
 	int		num_data;
 	int		num_normal_data;
 	int		max_cols;
@@ -81,6 +83,7 @@ static const struct stmpe_keypad_variant stmpe_keypad_variants[] = {
 	},
 	[STMPE2401] = {
 		.auto_increment		= false,
+		.set_pullup		= true,
 		.num_data		= 3,
 		.num_normal_data	= 2,
 		.max_cols		= 8,
@@ -90,6 +93,7 @@ static const struct stmpe_keypad_variant stmpe_keypad_variants[] = {
 	},
 	[STMPE2403] = {
 		.auto_increment		= true,
+		.set_pullup		= true,
 		.num_data		= 5,
 		.num_normal_data	= 3,
 		.max_cols		= 8,
@@ -185,7 +189,10 @@ static int stmpe_keypad_altfunc_init(struct stmpe_keypad *keypad)
 	unsigned int col_gpios = variant->col_gpios;
 	unsigned int row_gpios = variant->row_gpios;
 	struct stmpe *stmpe = keypad->stmpe;
+	u8 pureg = stmpe->regs[STMPE_IDX_GPPUR_LSB];
 	unsigned int pins = 0;
+	unsigned int pu_pins = 0;
+	int ret;
 	int i;
 
 	/*
@@ -202,8 +209,10 @@ static int stmpe_keypad_altfunc_init(struct stmpe_keypad *keypad)
 	for (i = 0; i < variant->max_cols; i++) {
 		int num = __ffs(col_gpios);
 
-		if (keypad->cols & (1 << i))
+		if (keypad->cols & (1 << i)) {
 			pins |= 1 << num;
+			pu_pins |= 1 << num;
+		}
 
 		col_gpios &= ~(1 << num);
 	}
@@ -217,7 +226,31 @@ static int stmpe_keypad_altfunc_init(struct stmpe_keypad *keypad)
 		row_gpios &= ~(1 << num);
 	}
 
-	return stmpe_set_altfunc(stmpe, pins, STMPE_BLOCK_KEYPAD);
+	ret = stmpe_set_altfunc(stmpe, pins, STMPE_BLOCK_KEYPAD);
+	if (ret)
+		return ret;
+
+	/*
+	 * On STMPE24xx, set pin bias to pull-up on all keypad input
+	 * pins (columns), this incidentally happen to be maximum 8 pins
+	 * and placed at GPIO0-7 so only the LSB of the pull up register
+	 * ever needs to be written.
+	 */
+	if (variant->set_pullup) {
+		u8 val;
+
+		ret = stmpe_reg_read(stmpe, pureg);
+		if (ret)
+			return ret;
+
+		/* Do not touch unused pins, may be used for GPIO */
+		val = ret & ~pu_pins;
+		val |= pu_pins;
+
+		ret = stmpe_reg_write(stmpe, pureg, val);
+	}
+
+	return 0;
 }
 
 static int stmpe_keypad_chip_init(struct stmpe_keypad *keypad)
-- 
1.9.3

