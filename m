From: Joseph Lo <josephl@nvidia.com>
Subject: [PATCH] Input: gpio_keys - handle the missing key press event in resume phase
Date: Fri, 11 Sep 2015 10:24:22 +0800
Message-ID: <1441938262-20672-1-git-send-email-josephl@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18794 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743AbbIKCYi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Sep 2015 22:24:38 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Joseph Lo <josephl@nvidia.com>

The GPIO key press event might be missed in the resume phase, if the key
had been released before the system had been resumed to the stage that it
could capture the press event. So we simulate the wakeup key press event
in case the key had been released by the time we got interrupt handler
to run.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 drivers/input/keyboard/gpio_keys.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 9d517ca7eb5a..5ea6dc3c6ca2 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -46,6 +46,7 @@ struct gpio_button_data {
 	spinlock_t lock;
 	bool disabled;
 	bool key_pressed;
+	bool suspended;
 };
 
 struct gpio_keys_drvdata {
@@ -369,8 +370,19 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
 
 	BUG_ON(irq != bdata->irq);
 
-	if (bdata->button->wakeup)
+	if (bdata->button->wakeup) {
+		const struct gpio_keys_button *button = bdata->button;
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
@@ -801,6 +813,7 @@ static int gpio_keys_suspend(struct device *dev)
 			struct gpio_button_data *bdata = &ddata->data[i];
 			if (bdata->button->wakeup)
 				enable_irq_wake(bdata->irq);
+			bdata->suspended = true;
 		}
 	} else {
 		mutex_lock(&input->mutex);
@@ -824,6 +837,7 @@ static int gpio_keys_resume(struct device *dev)
 			struct gpio_button_data *bdata = &ddata->data[i];
 			if (bdata->button->wakeup)
 				disable_irq_wake(bdata->irq);
+			bdata->suspended = false;
 		}
 	} else {
 		mutex_lock(&input->mutex);
-- 
2.5.2

