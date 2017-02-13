From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: tca8418_keypad - remove double read of key event
 register
Date: Mon, 13 Feb 2017 15:50:38 -0800
Message-ID: <20170213235038.GA25758@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36691 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751250AbdBMXun (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 13 Feb 2017 18:50:43 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org

There is no need to tread the same register twice in a row.

Fixes: ea4348c8462a ("Input: tca8418_keypad - hide gcc-4.9 -Wmaybe-un ...")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/tca8418_keypad.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
index 44dd7689c571..e37e335e406f 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -188,8 +188,6 @@ static void tca8418_read_keypad(struct tca8418_keypad *keypad_data)
 		input_event(input, EV_MSC, MSC_SCAN, code);
 		input_report_key(input, keymap[code], state);
 
-		/* Read for next loop */
-		error = tca8418_read_byte(keypad_data, REG_KEY_EVENT_A, &reg);
 	} while (1);
 
 	input_sync(input);
-- 
2.11.0.483.g087da7b7c-goog

-- 
Dmitry
