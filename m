From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] i8042 / PM: Allow PC keyboard to wake up from suspend-to-idle
Date: Mon, 09 Mar 2015 16:19:50 +0100
Message-ID: <2197217.yzvHkR7SyK@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kristen Carlson Accardi <kristen@linux.intel.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If they keyboard interrupt is registered, mark the i8042 platform
device as wakeup-capable and check the user space wakeup setting in
i8042_pm_suspend() and i8042_pm_resume() to enable or disable,
respectively, the keyboard interrupt to wake up the system.

This makes it possible to use the PC keyboard to wake up the system
from suspend-to-idle after writing "enabled" to the i8042 device's
power/wakeup sysfs attribute.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/input/serio/i8042.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-pm/drivers/input/serio/i8042.c
===================================================================
--- linux-pm.orig/drivers/input/serio/i8042.c
+++ linux-pm/drivers/input/serio/i8042.c
@@ -1163,12 +1163,17 @@ static int i8042_controller_resume(bool
 static int i8042_pm_suspend(struct device *dev)
 {
 	i8042_controller_reset(true);
+	if (device_may_wakeup(&i8042_platform_device->dev))
+		enable_irq_wake(I8042_KBD_IRQ);
 
 	return 0;
 }
 
 static int i8042_pm_resume(struct device *dev)
 {
+	if (device_may_wakeup(&i8042_platform_device->dev))
+		disable_irq_wake(I8042_KBD_IRQ);
+
 	/*
 	 * On resume from S2R we always try to reset the controller
 	 * to bring it in a sane state. (In case of S2D we expect
@@ -1406,6 +1411,7 @@ static int __init i8042_setup_kbd(void)
 	if (error)
 		goto err_free_irq;
 
+	device_set_wakeup_capable(&i8042_platform_device->dev, true);
 	i8042_kbd_irq_registered = true;
 	return 0;
 

