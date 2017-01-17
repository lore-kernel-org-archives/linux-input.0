From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH RESEND v2] input: tca8418: Use the interrupt trigger from the device tree
Date: Tue, 17 Jan 2017 22:08:37 +0100
Message-ID: <20170117210837.20555-1-maxime.ripard@free-electrons.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:36887 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbdAQVSh (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 17 Jan 2017 16:18:37 -0500
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
interrupt type" that was sent initially on 14/11, and didn't get any
answer.

Changes from v1:
  - Rely on the trigger type provided by the DT

 drivers/input/keyboard/tca8418_keypad.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
index 3048ef3e3e16..11d5c76d9fb4 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -277,6 +277,7 @@ static int tca8418_keypad_probe(struct i2c_client *client,
 	bool irq_is_gpio = false;
 	int irq;
 	int error, row_shift, max_keys;
+	unsigned long trigger = 0;
 
 	/* Copy the platform data */
 	if (pdata) {
@@ -289,6 +290,7 @@ static int tca8418_keypad_probe(struct i2c_client *client,
 		cols = pdata->cols;
 		rep  = pdata->rep;
 		irq_is_gpio = pdata->irq_is_gpio;
+		trigger = IRQF_TRIGGER_FALLING;
 	} else {
 		struct device_node *np = dev->of_node;
 		int err;
@@ -363,9 +365,7 @@ static int tca8418_keypad_probe(struct i2c_client *client,
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
2.11.0

