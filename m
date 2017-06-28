From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH RESEND] input: gpio_keys: handle the missing key press event in resume phase
Date: Wed, 28 Jun 2017 12:29:40 +0200
Message-ID: <20170628102940.15670-1-enric.balletbo@collabora.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58833 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751522AbdF1K3v (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 28 Jun 2017 06:29:51 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Phil Blundell <pb@handhelds.org>
Cc: groeck@chromium.org, Joseph Lo <josephl@nvidia.com>

From: Joseph Lo <josephl@nvidia.com>

The GPIO key press event might be missed in the resume phase, if the key
had been released before the system had been resumed to the stage that it
could capture the press event. So we simulate the wakeup key press event
in case the key had been released by the time we got interrupt handler
to run.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
This patch was sent long time ago [1] but apparently did not receive feedback
and seems that nobody take care of it. I think might be interesting have this
upstream so I resend this version just rebased on top of mainline and tested
on a veyron device.

[1] https://patchwork.kernel.org/patch/7157201/

 drivers/input/keyboard/gpio_keys.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index da3d362..a047b9a 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -48,6 +48,7 @@ struct gpio_button_data {
 	spinlock_t lock;
 	bool disabled;
 	bool key_pressed;
+	bool suspended;
 };
 
 struct gpio_keys_drvdata {
@@ -396,8 +397,20 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
 
 	BUG_ON(irq != bdata->irq);
 
-	if (bdata->button->wakeup)
+	if (bdata->button->wakeup) {
+		const struct gpio_keys_button *button = bdata->button;
+
 		pm_stay_awake(bdata->input->dev.parent);
+		if (bdata->suspended  &&
+		    (button->type == 0 || button->type == EV_KEY)) {
+			/*
+			 * Simulate wakeup key press in case the key has
+			 * already released by the time we got interrupt
+			 * handler to run.
+			 */
+			input_report_key(bdata->input, button->code, 1);
+		}
+	}
 
 	mod_delayed_work(system_wq,
 			 &bdata->work,
@@ -855,6 +868,7 @@ static int __maybe_unused gpio_keys_suspend(struct device *dev)
 			struct gpio_button_data *bdata = &ddata->data[i];
 			if (bdata->button->wakeup)
 				enable_irq_wake(bdata->irq);
+			bdata->suspended = true;
 		}
 	} else {
 		mutex_lock(&input->mutex);
@@ -878,6 +892,7 @@ static int __maybe_unused gpio_keys_resume(struct device *dev)
 			struct gpio_button_data *bdata = &ddata->data[i];
 			if (bdata->button->wakeup)
 				disable_irq_wake(bdata->irq);
+			bdata->suspended = false;
 		}
 	} else {
 		mutex_lock(&input->mutex);
-- 
2.9.3

