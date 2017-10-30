From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 3/4] Input: gpio_keys - Allow suppression of input events for wakeup button presses
Date: Mon, 30 Oct 2017 18:40:49 +0100
Message-ID: <20171030174050.30375-3-hdegoede@redhat.com>
References: <20171030174050.30375-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932673AbdJ3Rk5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 30 Oct 2017 13:40:57 -0400
In-Reply-To: <20171030174050.30375-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

In some cases it is undesirable for a wakeup button to send input events
to userspace if pressed to wakeup the system (if pressed during suspend).

A typical example of this is the power-button on laptops / tablets,
sending a KEY_POWER event to userspace when woken up with the power-button
will cause userspace to immediately suspend the system again which is
undesirable.

For power-buttons attached to a PMIC, or handled by e.g. ACPI, not sending
an input event in this case is take care of by the PMIC / ACPI hardware /
code. But in the case of a GPIO button we need to explicitly suppress the
sending of the input event.

This commit supports this by adding a suppress_evdev_events_on_wakeup bool
to struct gpio_keys_button, which platform code can set to suppress the
input events for presses of wakeup keys during suspend.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-This is a rewrite if my "Input: gpio_keys - Do not report wake button
 presses as evdev events" patch.
-Instead of unconditionally ignoring presses of all wake-up buttons during
 suspend, this rewrite makes this configurable per button
-This version uses a timer to delay clearing the suspended flag for software
 debouncing, rather then jiffy compare magic

Changes in v3:
-Get rid of the need to have a timer all-together
-Rename the flag from no_wakeup_events to suppress_evdev_events_on_wakeup
---
 drivers/input/keyboard/gpio_keys.c | 13 +++++++++++++
 include/linux/gpio_keys.h          |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 9b51aa56cc83..3beff91f1a4c 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -373,6 +373,10 @@ static void gpio_keys_gpio_report_event(struct gpio_button_data *bdata)
 		return;
 	}
 
+	if (bdata->button->suppress_evdev_events_on_wakeup &&
+	    bdata->ddata->suspended && state)
+		return;
+
 	if (type == EV_ABS) {
 		if (state)
 			input_event(input, type, button->code, button->value);
@@ -400,6 +404,10 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
 
 	BUG_ON(irq != bdata->irq);
 
+	if (bdata->button->suppress_evdev_events_on_wakeup &&
+	    bdata->ddata->suspended)
+		return IRQ_HANDLED;
+
 	if (bdata->button->wakeup) {
 		const struct gpio_keys_button *button = bdata->button;
 
@@ -445,6 +453,10 @@ static irqreturn_t gpio_keys_irq_isr(int irq, void *dev_id)
 
 	BUG_ON(irq != bdata->irq);
 
+	if (bdata->button->suppress_evdev_events_on_wakeup &&
+	    bdata->ddata->suspended)
+		return IRQ_HANDLED;
+
 	spin_lock_irqsave(&bdata->lock, flags);
 
 	if (!bdata->key_pressed) {
@@ -894,6 +906,7 @@ static int __maybe_unused gpio_keys_resume(struct device *dev)
 	if (error)
 		return error;
 
+	/* Sync state before clearing suspended, so it knows this is a resume */
 	gpio_keys_report_state(ddata);
 	ddata->suspended = false;
 	return 0;
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index 0b71024c082c..e05fe0902358 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -15,6 +15,9 @@ struct device;
  * @debounce_interval:	debounce ticks interval in msecs
  * @can_disable:	%true indicates that userspace is allowed to
  *			disable button via sysfs
+ * @suppress_evdev_events_on_wakeup:  For wake-up source buttons only, if %true
+ *			then no evdev-events will be generated if pressed while
+ *			suspended
  * @value:		axis value for %EV_ABS
  * @irq:		Irq number in case of interrupt keys
  */
@@ -27,6 +30,7 @@ struct gpio_keys_button {
 	int wakeup;
 	int debounce_interval;
 	bool can_disable;
+	bool suppress_evdev_events_on_wakeup;
 	int value;
 	unsigned int irq;
 };
-- 
2.14.2

