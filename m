From: Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH] Input - i8042: Enable wakeup on a stable struct device
Date: Tue, 27 Aug 2019 14:34:31 -0700
Message-ID: <20190827213431.35882-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-input@vger.kernel.org

We don't know when the device will be added with device_add() in
serio_add_port() because serio_add_port() is called from a workqueue
that this driver schedules by calling serio_register_port(). The best we
can know is that the device will definitely not have been added yet when
the start callback is called on the serio device.

While it hasn't been shown to be a problem, proactively move the wakeup
enabling calls to the start hook so that we don't race with the
workqueue calling device_add(). This will avoid racy situations where
code tries to add wakeup sysfs attributes for this device from
dpm_sysfs_add() but the path in device_set_wakeup_capable() has already
done so.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/input/serio/i8042.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index e4352741c467..f32780ce22cc 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -432,6 +432,19 @@ static int i8042_start(struct serio *serio)
 {
 	struct i8042_port *port = serio->port_data;
 
+	device_set_wakeup_capable(&serio->dev, true);
+
+	/*
+	 * On platforms using suspend-to-idle, allow the keyboard to
+	 * wake up the system from sleep by enabling keyboard wakeups
+	 * by default.  This is consistent with keyboard wakeup
+	 * behavior on many platforms using suspend-to-RAM (ACPI S3)
+	 * by default.
+	 */
+	if (pm_suspend_via_s2idle() &&
+	    serio == i8042_ports[I8042_KBD_PORT_NO].serio)
+		device_set_wakeup_enable(&serio->dev, true);
+
 	spin_lock_irq(&i8042_lock);
 	port->exists = true;
 	spin_unlock_irq(&i8042_lock);
@@ -1397,17 +1410,6 @@ static void __init i8042_register_ports(void)
 			(unsigned long) I8042_COMMAND_REG,
 			i8042_ports[i].irq);
 		serio_register_port(serio);
-		device_set_wakeup_capable(&serio->dev, true);
-
-		/*
-		 * On platforms using suspend-to-idle, allow the keyboard to
-		 * wake up the system from sleep by enabling keyboard wakeups
-		 * by default.  This is consistent with keyboard wakeup
-		 * behavior on many platforms using suspend-to-RAM (ACPI S3)
-		 * by default.
-		 */
-		if (pm_suspend_via_s2idle() && i == I8042_KBD_PORT_NO)
-			device_set_wakeup_enable(&serio->dev, true);
 	}
 }
 
-- 
Sent by a computer through tubes
