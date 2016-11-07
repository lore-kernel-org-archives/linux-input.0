From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH] drivers: tca8418: Change the interrupt type
Date: Mon,  7 Nov 2016 15:40:24 +0100
Message-ID: <20161107144024.15291-1-maxime.ripard@free-electrons.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from up.free-electrons.com ([163.172.77.33]:49176 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751297AbcKGOkh (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 7 Nov 2016 09:40:37 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>

The TCA8418 interrupt has a level trigger, not a edge one.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/input/keyboard/tca8418_keypad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
index 9002298698fc..b88b3696a2e1 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -360,7 +360,7 @@ static int tca8418_keypad_probe(struct i2c_client *client,
 		irq = gpio_to_irq(irq);
 
 	error = devm_request_threaded_irq(dev, irq, NULL, tca8418_irq_handler,
-					  IRQF_TRIGGER_FALLING |
+					  IRQF_TRIGGER_LOW |
 						IRQF_SHARED |
 						IRQF_ONESHOT,
 					  client->name, keypad_data);
-- 
2.10.1

