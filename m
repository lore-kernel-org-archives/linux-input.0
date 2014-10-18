From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] input: stmpe: fix valid key line bitmask
Date: Sat, 18 Oct 2014 14:52:09 +0200
Message-ID: <1413636729-2985-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:55174 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbaJRMwm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Oct 2014 08:52:42 -0400
Received: by mail-lb0-f182.google.com with SMTP id z11so1919828lbi.13
        for <linux-input@vger.kernel.org>; Sat, 18 Oct 2014 05:52:40 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>

The bitmask comment says it will enable GPIO 8-14 and 16-20
for keypad use, but it actually enables GPIO 8-11 and 13-20
due to a bit error.

Instead of masking of the "hole" at GPIO 12 (which is used
for keypad output 4) mask of the proper "hole" at GPIO 15.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi Dmitry, this is for fixes I think.
---
 drivers/input/keyboard/stmpe-keypad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/stmpe-keypad.c b/drivers/input/keyboard/stmpe-keypad.c
index c6727dda68f2..ef5e67fb567e 100644
--- a/drivers/input/keyboard/stmpe-keypad.c
+++ b/drivers/input/keyboard/stmpe-keypad.c
@@ -86,7 +86,7 @@ static const struct stmpe_keypad_variant stmpe_keypad_variants[] = {
 		.max_cols		= 8,
 		.max_rows		= 12,
 		.col_gpios		= 0x0000ff,	/* GPIO 0 - 7*/
-		.row_gpios		= 0x1fef00,	/* GPIO 8-14, 16-20 */
+		.row_gpios		= 0x1f7f00,	/* GPIO 8-14, 16-20 */
 	},
 	[STMPE2403] = {
 		.auto_increment		= true,
-- 
1.9.3

