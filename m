From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 3/7] input/nomadik-ske: get rid of multiple interrupts
Date: Sun, 13 May 2012 14:43:54 +0200
Message-ID: <1336913034-10082-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:52217 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752342Ab2EMMoA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 May 2012 08:44:00 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

From: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>

The keypad could cause multiple interrupts to be fired in succession
since we weren't waiting for the IRQs to clear properly in the
interrupt handler. We ait for a number of bus iterations (the
readl():s from the peripheral bus will stall, so these are quite
long) before giving up on getting keys ready to read, then we
sleep until the IRQ is deasserted (this is OK since the interrupt
is threaded). Also use the debounce platform data for another
hardcoded wait loop.

Signed-off-by: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
Reviewed-by: Rikard Olsson <rikard.p.olsson@stericsson.com>
Reviewed-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/input/keyboard/nomadik-ske-keypad.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/nomadik-ske-keypad.c b/drivers/input/keyboard/nomadik-ske-keypad.c
index 0df47e5..83b0424 100644
--- a/drivers/input/keyboard/nomadik-ske-keypad.c
+++ b/drivers/input/keyboard/nomadik-ske-keypad.c
@@ -48,6 +48,7 @@
 #define SKE_ASR3	0x2C
 
 #define SKE_NUM_ASRX_REGISTERS	(4)
+#define	KEY_PRESSED_DELAY	10
 
 /**
  * struct ske_keypad  - data structure used by keypad driver
@@ -91,7 +92,7 @@ static void ske_keypad_set_bits(struct ske_keypad *keypad, u16 addr,
 static int __init ske_keypad_chip_init(struct ske_keypad *keypad)
 {
 	u32 value;
-	int timeout = 50;
+	int timeout = keypad->board->debounce_ms;
 
 	/* check SKE_RIS to be 0 */
 	while ((readl(keypad->reg_base + SKE_RIS) != 0x00000000) && timeout--)
@@ -195,18 +196,22 @@ static void ske_keypad_read_data(struct ske_keypad *keypad)
 static irqreturn_t ske_keypad_irq(int irq, void *dev_id)
 {
 	struct ske_keypad *keypad = dev_id;
-	int retries = 20;
+	int timeout = keypad->board->debounce_ms;
 
 	/* disable auto scan interrupt; mask the interrupt generated */
 	ske_keypad_set_bits(keypad, SKE_IMSC, ~SKE_KPIMA, 0x0);
 	ske_keypad_set_bits(keypad, SKE_ICR, 0x0, SKE_KPICA);
 
-	while ((readl(keypad->reg_base + SKE_CR) & SKE_KPASON) && --retries)
+	while ((readl(keypad->reg_base + SKE_CR) & SKE_KPASON) && --timeout)
 		cpu_relax();
 
 	/* SKEx registers are stable and can be read */
 	ske_keypad_read_data(keypad);
 
+	/* wait until raw interrupt is clear */
+	while ((readl(keypad->reg_base + SKE_RIS)) && --timeout)
+		msleep(KEY_PRESSED_DELAY);
+
 	/* enable auto scan interrupts */
 	ske_keypad_set_bits(keypad, SKE_IMSC, 0x0, SKE_KPIMA);
 
-- 
1.7.9.2

