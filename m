From: Evgeniy Dushistov <dushistov@mail.ru>
Subject: [PATCH 1/3] max7359_keypad: Do not set MAX7359_CFG_INTERRUPT flag
Date: Thu, 14 May 2015 05:34:50 +0300
Message-ID: <20150514023450.GA28560@fifteen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fallback7.mail.ru ([94.100.181.128]:55331 "EHLO
	fallback7.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933139AbbENCgF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 May 2015 22:36:05 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

max7359_keypad: Do not set MAX7359_CFG_INTERRUPT flag. 
In datasheet of max7359, there is description of this flag:
0 - INT cleared when FIFO empty,
1 - INT cleared after host read. In this mode, I2C should read
 FIFO until interrupt condition removed, or further INT may be lost.

So, if we set this flag, we have to read FIFO until it become
empty. But in interrupt we read FIFO just once.
This lead to "keyboard" hang until reboot, if we press
several keys, because of interrupt handler read just one
"press" from FIFO and clear interrupt.

Signed-off-by: Evgeniy A. Dushistov <dushistov@mail.ru>
---
 drivers/input/keyboard/max7359_keypad.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/keyboard/max7359_keypad.c b/drivers/input/keyboard/max7359_keypad.c
index faa6da5..4e35904 100644
--- a/drivers/input/keyboard/max7359_keypad.c
+++ b/drivers/input/keyboard/max7359_keypad.c
@@ -166,7 +166,6 @@ static void max7359_close(struct input_dev *dev)
 static void max7359_initialize(struct i2c_client *client)
 {
 	max7359_write_reg(client, MAX7359_REG_CONFIG,
-		MAX7359_CFG_INTERRUPT | /* Irq clears after host read */
 		MAX7359_CFG_KEY_RELEASE | /* Key release enable */
 		MAX7359_CFG_WAKEUP); /* Key press wakeup enable */
 
-- 
2.3.6

-- 
/Evgeniy
