From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH v2] Input: enable i8042-level wakeup control
Date: Sat,  9 Jul 2011 22:13:21 +0100 (BST)
Message-ID: <20110709211321.5FE139D401C@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru
Cc: linux-pm@lists.linux-foundation.org, dilinger@queued.net, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The OLPC XO laptop is able to use the PS/2 controller as a wakeup source.
When used as a wakeup source, the key press/mouse motion must not be lost.

Add infrastructure to allow controllers to be marked as wakeup-capable,
and avoid doing power control/reset on the i8042/serio/input devices when
running in this mode. Default behaviour is unchanged - hardware platforms
must explicitly enable this functionality if they can support it.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/input/input.c                 |   18 +++++++++++
 drivers/input/serio/i8042-io.h        |    4 ++
 drivers/input/serio/i8042-ip22io.h    |    4 ++
 drivers/input/serio/i8042-jazzio.h    |    4 ++
 drivers/input/serio/i8042-ppcio.h     |    4 ++
 drivers/input/serio/i8042-snirm.h     |    4 ++
 drivers/input/serio/i8042-sparcio.h   |    4 ++
 drivers/input/serio/i8042-x86ia64io.h |    4 ++
 drivers/input/serio/i8042.c           |   54 ++++++++++++++++++++++++++++++--
 drivers/input/serio/serio.c           |   28 ++++++++++++++--
 10 files changed, 120 insertions(+), 8 deletions(-)

A followup patch will come soon, hooking this into OLPC's embedded controller:
http://dev.laptop.org/~dsd/20110114/0015-i8042-Enable-OLPC-s-EC-based-i8042-wakeup-control.patch
The underlying infrastructure for this work has now been merged in linux-next.

On last submission, Dmitry was worried about this functionality not working
at all on other platforms. I agree, it will only work where the hardware
has been specifically designed with this consideration. v2 of the patch
therefore removes the module param option, meaning that it will only be
activated on platforms that explicitly enable it at the code level.

v2 also performs a more extensive job. We avoid resetting the device
at the input_device level during suspend/resume - but this is ugly. Rafael,
is there a better way? Please see the input.c hunks. We also disable
i8042 interrupts when going into suspend, to avoid races handling interrupts
in the wrong order during resume.

diff --git a/drivers/input/input.c b/drivers/input/input.c
index da38d97..81a87bc 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1588,6 +1588,15 @@ static int input_dev_suspend(struct device *dev)
 {
 	struct input_dev *input_dev = to_input_dev(dev);
 
+	/*
+	 * If this device is a child of serio, which is a child of i8042, and
+	 * i8042 wakeup is enabled (i.e. this input device is not being
+	 * suspended), do nothing.
+	 */
+	if (dev->parent && dev->parent->parent
+			&& device_may_wakeup(dev->parent->parent))
+		return 0;
+
 	mutex_lock(&input_dev->mutex);
 
 	if (input_dev->users)
@@ -1602,6 +1611,15 @@ static int input_dev_resume(struct device *dev)
 {
 	struct input_dev *input_dev = to_input_dev(dev);
 
+	/*
+	 * If this device is a child of serio, which is a child of i8042, and
+	 * i8042 wakeup is enabled (i.e. this input device was not suspended),
+	 * do nothing.
+	 */
+	if (dev->parent && dev->parent->parent
+			&& device_may_wakeup(dev->parent->parent))
+		return 0;
+
 	input_reset_device(input_dev);
 
 	return 0;
diff --git a/drivers/input/serio/i8042-io.h b/drivers/input/serio/i8042-io.h
index 5d48bb6..296633c 100644
--- a/drivers/input/serio/i8042-io.h
+++ b/drivers/input/serio/i8042-io.h
@@ -92,4 +92,8 @@ static inline void i8042_platform_exit(void)
 #endif
 }
 
+static inline void i8042_platform_suspend(struct device *dev, bool may_wakeup)
+{
+}
+
 #endif /* _I8042_IO_H */
diff --git a/drivers/input/serio/i8042-ip22io.h b/drivers/input/serio/i8042-ip22io.h
index ee1ad27..c5b76a4 100644
--- a/drivers/input/serio/i8042-ip22io.h
+++ b/drivers/input/serio/i8042-ip22io.h
@@ -73,4 +73,8 @@ static inline void i8042_platform_exit(void)
 #endif
 }
 
+static inline void i8042_platform_suspend(struct device *dev, bool may_wakeup)
+{
+}
+
 #endif /* _I8042_IP22_H */
diff --git a/drivers/input/serio/i8042-jazzio.h b/drivers/input/serio/i8042-jazzio.h
index 13fd710..a11913a 100644
--- a/drivers/input/serio/i8042-jazzio.h
+++ b/drivers/input/serio/i8042-jazzio.h
@@ -66,4 +66,8 @@ static inline void i8042_platform_exit(void)
 #endif
 }
 
+static inline void i8042_platform_suspend(struct device *dev, bool may_wakeup)
+{
+}
+
 #endif /* _I8042_JAZZ_H */
diff --git a/drivers/input/serio/i8042-ppcio.h b/drivers/input/serio/i8042-ppcio.h
index f708c75..c9f4292 100644
--- a/drivers/input/serio/i8042-ppcio.h
+++ b/drivers/input/serio/i8042-ppcio.h
@@ -52,6 +52,10 @@ static inline void i8042_platform_exit(void)
 {
 }
 
+static inline void i8042_platform_suspend(struct device *dev, bool may_wakeup)
+{
+}
+
 #else
 
 #include "i8042-io.h"
diff --git a/drivers/input/serio/i8042-snirm.h b/drivers/input/serio/i8042-snirm.h
index 409a934..96d034f 100644
--- a/drivers/input/serio/i8042-snirm.h
+++ b/drivers/input/serio/i8042-snirm.h
@@ -72,4 +72,8 @@ static inline void i8042_platform_exit(void)
 
 }
 
+static inline void i8042_platform_suspend(struct device *dev, bool may_wakeup)
+{
+}
+
 #endif /* _I8042_SNIRM_H */
diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
index 395a9af..e5381d3 100644
--- a/drivers/input/serio/i8042-sparcio.h
+++ b/drivers/input/serio/i8042-sparcio.h
@@ -154,4 +154,8 @@ static inline void i8042_platform_exit(void)
 }
 #endif /* !CONFIG_PCI */
 
+static inline void i8042_platform_suspend(struct device *dev, bool may_wakeup)
+{
+}
+
 #endif /* _I8042_SPARCIO_H */
diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index bb9f5d3..76b2e58 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -875,6 +875,10 @@ static inline int i8042_pnp_init(void) { return 0; }
 static inline void i8042_pnp_exit(void) { }
 #endif
 
+static inline void i8042_platform_suspend(struct device *dev, bool may_wakeup)
+{
+}
+
 static int __init i8042_platform_init(void)
 {
 	int retval;
diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index d37a48e..e944667 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -87,6 +87,7 @@ MODULE_PARM_DESC(debug, "Turn i8042 debugging mode on and off");
 #endif
 
 static bool i8042_bypass_aux_irq_test;
+static bool i8042_enable_wakeup;
 
 #include "i8042.h"
 
@@ -1082,10 +1083,17 @@ static void i8042_dritek_enable(void)
  * before suspending.
  */
 
-static int i8042_controller_resume(bool force_reset)
+static int i8042_controller_resume(bool force_reset, bool soft_resume)
 {
 	int error;
 
+	/*
+	 * If device is selected as a wakeup source, it was not powered down
+	 * or reset during suspend, so we have very little to do.
+	 */
+	if (soft_resume)
+		goto soft;
+
 	error = i8042_controller_check();
 	if (error)
 		return error;
@@ -1129,6 +1137,7 @@ static int i8042_controller_resume(bool force_reset)
 	if (i8042_ports[I8042_KBD_PORT_NO].serio)
 		i8042_enable_kbd_port();
 
+soft:
 	i8042_interrupt(0, NULL);
 
 	return 0;
@@ -1146,14 +1155,48 @@ static int i8042_pm_reset(struct device *dev)
 	return 0;
 }
 
+static int i8042_pm_suspend(struct device *dev)
+{
+	i8042_platform_suspend(dev, device_may_wakeup(dev));
+
+	/*
+	 * If device is selected as a wakeup source, don't powerdown or reset
+	 * during suspend. Just disable IRQs to ensure race-free resume.
+	 */
+	if (device_may_wakeup(dev)) {
+		if (i8042_kbd_irq_registered)
+			disable_irq(I8042_KBD_IRQ);
+		if (i8042_aux_irq_registered)
+			disable_irq(I8042_AUX_IRQ);
+		return 0;
+	}
+
+	return i8042_pm_reset(dev);
+}
+
 static int i8042_pm_resume(struct device *dev)
 {
 	/*
 	 * On resume from S2R we always try to reset the controller
 	 * to bring it in a sane state. (In case of S2D we expect
 	 * BIOS to reset the controller for us.)
+	 * This function call will also handle any pending keypress event
+	 * (perhaps the system wakeup reason)
+	 */
+	int r = i8042_controller_resume(true, device_may_wakeup(dev));
+
+	/* If the device was left running during suspend, enable IRQs again
+	 * now. Must be done last to avoid races with interrupt processing
+	 * inside i8042_controller_resume.
 	 */
-	return i8042_controller_resume(true);
+	if (device_may_wakeup(dev)) {
+		if (i8042_kbd_irq_registered)
+			enable_irq(I8042_KBD_IRQ);
+		if (i8042_aux_irq_registered)
+			enable_irq(I8042_AUX_IRQ);
+	}
+
+	return r;
 }
 
 static int i8042_pm_thaw(struct device *dev)
@@ -1165,11 +1208,11 @@ static int i8042_pm_thaw(struct device *dev)
 
 static int i8042_pm_restore(struct device *dev)
 {
-	return i8042_controller_resume(false);
+	return i8042_controller_resume(false, false);
 }
 
 static const struct dev_pm_ops i8042_pm_ops = {
-	.suspend	= i8042_pm_reset,
+	.suspend	= i8042_pm_suspend,
 	.resume		= i8042_pm_resume,
 	.thaw		= i8042_pm_thaw,
 	.poweroff	= i8042_pm_reset,
@@ -1403,6 +1446,9 @@ static int __init i8042_probe(struct platform_device *dev)
 		i8042_dritek_enable();
 #endif
 
+	if (i8042_enable_wakeup)
+		device_set_wakeup_capable(&dev->dev, true);
+
 	if (!i8042_noaux) {
 		error = i8042_setup_aux();
 		if (error && error != -ENODEV && error != -EBUSY)
diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index ba70058..3d5793a 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -931,7 +931,7 @@ static int serio_uevent(struct device *dev, struct kobj_uevent_env *env)
 #endif /* CONFIG_HOTPLUG */
 
 #ifdef CONFIG_PM
-static int serio_suspend(struct device *dev)
+static int serio_poweroff(struct device *dev)
 {
 	struct serio *serio = to_serio_port(dev);
 
@@ -940,7 +940,17 @@ static int serio_suspend(struct device *dev)
 	return 0;
 }
 
-static int serio_resume(struct device *dev)
+static int serio_suspend(struct device *dev)
+{
+	/* If parent controller is configured as a wakeup source, don't
+	 * power off. */
+	if (device_may_wakeup(dev->parent))
+		return 0;
+
+	return serio_poweroff(dev);
+}
+
+static int serio_restore(struct device *dev)
 {
 	struct serio *serio = to_serio_port(dev);
 
@@ -953,11 +963,21 @@ static int serio_resume(struct device *dev)
 	return 0;
 }
 
+static int serio_resume(struct device *dev)
+{
+	/* If parent controller is configured as a wakeup source, we didn't
+	 * power off during suspend, and hence have nothing to do. */
+	if (device_may_wakeup(dev->parent))
+		return 0;
+
+	return serio_restore(dev);
+}
+
 static const struct dev_pm_ops serio_pm_ops = {
 	.suspend	= serio_suspend,
 	.resume		= serio_resume,
-	.poweroff	= serio_suspend,
-	.restore	= serio_resume,
+	.poweroff	= serio_poweroff,
+	.restore	= serio_restore,
 };
 #endif /* CONFIG_PM */
 
-- 
1.7.5.4
