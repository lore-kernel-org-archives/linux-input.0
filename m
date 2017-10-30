From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 2/4] Input: gpio_keys - Use a single suspended flag per device
Date: Mon, 30 Oct 2017 18:40:48 +0100
Message-ID: <20171030174050.30375-2-hdegoede@redhat.com>
References: <20171030174050.30375-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932673AbdJ3Rk4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 30 Oct 2017 13:40:56 -0400
In-Reply-To: <20171030174050.30375-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

There is no need to have a suspended flag per button, this also
allows gpio_keys_resume to set suspended to false after calling
gpio_keys_report_state, which will allow testing the suspended flag
in gpio_keys_report_state in a follow-up patch.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
-This is a new patch in v3 of this patch-set
---
 drivers/input/keyboard/gpio_keys.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 36ab7daba957..9b51aa56cc83 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -50,7 +50,6 @@ struct gpio_button_data {
 	spinlock_t lock;
 	bool disabled;
 	bool key_pressed;
-	bool suspended;
 };
 
 struct gpio_keys_drvdata {
@@ -58,6 +57,7 @@ struct gpio_keys_drvdata {
 	struct input_dev *input;
 	struct mutex disable_lock;
 	unsigned short *keymap;
+	bool suspended;
 	struct gpio_button_data data[0];
 };
 
@@ -404,7 +404,7 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
 		const struct gpio_keys_button *button = bdata->button;
 
 		pm_stay_awake(input->dev.parent);
-		if (bdata->suspended  &&
+		if (bdata->ddata->suspended  &&
 		    (button->type == 0 || button->type == EV_KEY)) {
 			/*
 			 * Simulate wakeup key press in case the key has
@@ -859,7 +859,6 @@ static int __maybe_unused gpio_keys_suspend(struct device *dev)
 			struct gpio_button_data *bdata = &ddata->data[i];
 			if (bdata->button->wakeup)
 				enable_irq_wake(bdata->irq);
-			bdata->suspended = true;
 		}
 	} else {
 		mutex_lock(&input->mutex);
@@ -868,6 +867,7 @@ static int __maybe_unused gpio_keys_suspend(struct device *dev)
 		mutex_unlock(&input->mutex);
 	}
 
+	ddata->suspended = true;
 	return 0;
 }
 
@@ -883,7 +883,6 @@ static int __maybe_unused gpio_keys_resume(struct device *dev)
 			struct gpio_button_data *bdata = &ddata->data[i];
 			if (bdata->button->wakeup)
 				disable_irq_wake(bdata->irq);
-			bdata->suspended = false;
 		}
 	} else {
 		mutex_lock(&input->mutex);
@@ -896,6 +895,7 @@ static int __maybe_unused gpio_keys_resume(struct device *dev)
 		return error;
 
 	gpio_keys_report_state(ddata);
+	ddata->suspended = false;
 	return 0;
 }
 
-- 
2.14.2

