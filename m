From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v2] input: tca8418: Use the interrupt trigger from the device tree
Date: Mon, 14 Nov 2016 09:39:11 +0100
Message-ID: <20161114083911.2423-1-maxime.ripard@free-electrons.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:34863 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752188AbcKNIjR (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 14 Nov 2016 03:39:17 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>

The TCA8418 might be used using different interrupt triggers on various
boards. This is not working so far because the current code forces a
falling edge trigger.

The device tree already provides a trigger type, so let's use whatever it
sets up, and since we can be loaded without DT, keep the old behaviour for
the non-DT case.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
Hi,

This is the second version of the patch "drivers: tca8418: Change the
interrupt type".

Changes from v1:
  - Rely on the trigger type provided by the DT

 drivers/input/keyboard/tca8418_keypad.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
index 9002298698fc..33e4950431c8 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -274,6 +274,7 @@ static int tca8418_keypad_probe(struct i2c_client *client,
 	bool irq_is_gpio = false;
 	int irq;
 	int error, row_shift, max_keys;
+	unsigned long trigger = 0;
 
 	/* Copy the platform data */
 	if (pdata) {
@@ -286,6 +287,7 @@ static int tca8418_keypad_probe(struct i2c_client *client,
 		cols = pdata->cols;
 		rep  = pdata->rep;
 		irq_is_gpio = pdata->irq_is_gpio;
+		trigger = IRQF_TRIGGER_FALLING;
 	} else {
 		struct device_node *np = dev->of_node;
 		int err;
@@ -360,9 +362,7 @@ static int tca8418_keypad_probe(struct i2c_client *client,
 		irq = gpio_to_irq(irq);
 
 	error = devm_request_threaded_irq(dev, irq, NULL, tca8418_irq_handler,
-					  IRQF_TRIGGER_FALLING |
-						IRQF_SHARED |
-						IRQF_ONESHOT,
+					  trigger | IRQF_SHARED | IRQF_ONESHOT,
 					  client->name, keypad_data);
 	if (error) {
 		dev_err(dev, "Unable to claim irq %d; error %d\n",
-- 
2.10.1

