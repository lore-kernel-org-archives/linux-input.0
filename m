From: Alban Bedel <alban.bedel@avionic-design.de>
Subject: [PATCH] Input: tca8418 - Add support for shared interrupt
Date: Mon,  5 Nov 2012 17:14:12 +0100
Message-ID: <1352132052-19771-1-git-send-email-alban.bedel@avionic-design.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:55340 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752592Ab2KEQOO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Nov 2012 11:14:14 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Alban Bedel <alban.bedel@avionic-design.de>

Signed-off-by: Alban Bedel <alban.bedel@avionic-design.de>
---
 drivers/input/keyboard/tca8418_keypad.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
index fc9cc94..5adc655 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -225,16 +225,18 @@ static irqreturn_t tca8418_irq_handler(int irq, void *dev_id)
 	if (error) {
 		dev_err(&keypad_data->client->dev,
 			"unable to read REG_INT_STAT\n");
-		goto exit;
+		return IRQ_NONE;
 	}
 
+	if (!reg)
+		return IRQ_NONE;
+
 	if (reg & INT_STAT_OVR_FLOW_INT)
 		dev_warn(&keypad_data->client->dev, "overflow occurred\n");
 
 	if (reg & INT_STAT_K_INT)
 		tca8418_read_keypad(keypad_data);
 
-exit:
 	/* Clear all interrupts, even IRQs we didn't check (GPI, CAD, LCK) */
 	reg = 0xff;
 	error = tca8418_write_byte(keypad_data, REG_INT_STAT, reg);
@@ -377,7 +379,9 @@ static int __devinit tca8418_keypad_probe(struct i2c_client *client,
 		client->irq = gpio_to_irq(client->irq);
 
 	error = request_threaded_irq(client->irq, NULL, tca8418_irq_handler,
-				     IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+				     IRQF_TRIGGER_FALLING |
+				     IRQF_SHARED |
+				     IRQF_ONESHOT,
 				     client->name, keypad_data);
 	if (error) {
 		dev_dbg(&client->dev,
-- 
1.7.0.4

