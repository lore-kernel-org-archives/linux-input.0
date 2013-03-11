From: Rabin Vincent <rabin.vincent@stericsson.com>
Subject: [PATCH] Input: tc3589x-keypad - fix row shift
Date: Mon, 11 Mar 2013 16:53:22 +0100
Message-ID: <1363017202-4556-1-git-send-email-rabin.vincent@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog110.obsmtp.com ([207.126.144.129]:46947 "EHLO
	eu1sys200aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751868Ab3CKPy1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Mar 2013 11:54:27 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, rabin@rab.in, Rabin Vincent <rabin.vincent@stericsson.com>

Since 1932811f426fee ("Input: matrix-keymap - uninline and prepare for
device tree support"), the row_shift used by the driver does not match
the one used by matrix_keypad_build_keymap(), leading to misdetection of
keys.  Fix it.

Cc: <stable@vger.kernel.org> # 3.8
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 drivers/input/keyboard/tc3589x-keypad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/tc3589x-keypad.c b/drivers/input/keyboard/tc3589x-keypad.c
index 208de7c..4ce924d 100644
--- a/drivers/input/keyboard/tc3589x-keypad.c
+++ b/drivers/input/keyboard/tc3589x-keypad.c
@@ -163,7 +163,7 @@ static int tc3589x_keypad_init_key_hardware(struct tc_keypad *keypad)
 #define TC35893_DATA_REGS		4
 #define TC35893_KEYCODE_FIFO_EMPTY	0x7f
 #define TC35893_KEYCODE_FIFO_CLEAR	0xff
-#define TC35893_KEYPAD_ROW_SHIFT	0x3
+#define TC35893_KEYPAD_ROW_SHIFT	0x4
 
 static irqreturn_t tc3589x_keypad_irq(int irq, void *dev)
 {
-- 
1.8.1.5

