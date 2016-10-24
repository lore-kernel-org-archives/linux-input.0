From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] Input: tca8418_keypad: hide gcc-4.9 -Wmaybe-uninitialized warning
Date: Mon, 24 Oct 2016 17:32:08 +0200
Message-ID: <20161024153222.2738294-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:49876 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935768AbcJXPc1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 24 Oct 2016 11:32:27 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Older versions of gcc warn about the tca8418_irq_handler function
as they can't keep track of the variable assignment inside of the
loop when using the -Wmaybe-unintialized flag:

drivers/input/keyboard/tca8418_keypad.c: In function ‘tca8418_irq_handler’:
drivers/input/keyboard/tca8418_keypad.c:172:9: error: ‘reg’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
drivers/input/keyboard/tca8418_keypad.c:165:5: note: ‘reg’ was declared here

This is fixed in gcc-6, but it's possible to rearrange the code
in a way that avoids the warning on older compilers as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/keyboard/tca8418_keypad.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
index 9002298698fc..3048ef3e3e16 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -164,11 +164,18 @@ static void tca8418_read_keypad(struct tca8418_keypad *keypad_data)
 	int error, col, row;
 	u8 reg, state, code;
 
-	/* Initial read of the key event FIFO */
-	error = tca8418_read_byte(keypad_data, REG_KEY_EVENT_A, &reg);
+	do {
+		error = tca8418_read_byte(keypad_data, REG_KEY_EVENT_A, &reg);
+		if (error < 0) {
+			dev_err(&keypad_data->client->dev,
+				"unable to read REG_KEY_EVENT_A\n");
+			break;
+		}
+
+		/* Assume that key code 0 signifies empty FIFO */
+		if (reg <= 0)
+			break;
 
-	/* Assume that key code 0 signifies empty FIFO */
-	while (error >= 0 && reg > 0) {
 		state = reg & KEY_EVENT_VALUE;
 		code  = reg & KEY_EVENT_CODE;
 
@@ -184,11 +191,7 @@ static void tca8418_read_keypad(struct tca8418_keypad *keypad_data)
 
 		/* Read for next loop */
 		error = tca8418_read_byte(keypad_data, REG_KEY_EVENT_A, &reg);
-	}
-
-	if (error < 0)
-		dev_err(&keypad_data->client->dev,
-			"unable to read REG_KEY_EVENT_A\n");
+	} while (1);
 
 	input_sync(input);
 }
-- 
2.9.0

