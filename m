From: "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: [PATCH] GPIO button wth wakeup attribute is supposed to wake the
 system up
Date: Thu, 19 Jun 2014 08:51:25 +0800
Message-ID: <53A2340D.9030503@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

When the wakeup attribute is set, the GPIO button is capable of
waking up the system from sleep states, including the "freeze"
sleep state.  For that to work, its driver needs to pass the
IRQF_NO_SUSPEND flag to devm_request_any_context_irq(), or the
interrupt will be disabled by suspend_device_irqs() and the
system won't be woken up by it from the "freeze" sleep state.

The suspend_device_irqs() routine is a workaround for drivers
that mishandle interrupts triggered when the devices handled
by them are suspended, so it is safe to use IRQF_NO_SUSPEND in
all drivers that don't have that problem.

The affected/tested machines include Dell Venue 11 Pro and Asus T100TA.

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/input/keyboard/gpio_keys.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 8c98e97..b046dc6 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -527,6 +527,14 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	if (!button->can_disable)
 		irqflags |= IRQF_SHARED;
 
+	/*
+	 * If platform has specified the wakeup attribute of the button,
+	 * we add IRQF_NO_SUSPEND to desc->action->flag. So the wake up
+	 * interrupt will not be disabled in suspend_device_irqs
+	 */
+	if (button->wakeup)
+		irqflags |= IRQF_NO_SUSPEND;
+
 	error = devm_request_any_context_irq(&pdev->dev, bdata->irq,
 					     isr, irqflags, desc, bdata);
 	if (error < 0) {
-- 
1.7.10.4
