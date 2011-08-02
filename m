From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH v4 1/2] Input: enable i8042-level wakeup control
Date: Tue,  2 Aug 2011 16:49:15 +0100 (BST)
Message-ID: <20110802154916.624619D401C__29255.1778642975$1312303672$gmane$org@zog.reactivated.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from queueout02-winn.ispmail.ntl.com ([81.103.221.56]:64591 "EHLO
	queueout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754670Ab1HBQrk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Aug 2011 12:47:40 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-pm@lists.linux-foundation.org, rjw@sisk.pl, dilinger@queued.net

The OLPC XO laptop is able to use the PS/2 controller as a wakeup source.
When used as a wakeup source, the key press/mouse motion must not be lost.

Add infrastructure to allow controllers to be marked as wakeup-capable,
and avoid doing power control/reset on the i8042/serio/input devices when
running in this mode. For systems where this functionality is available,
you are expected to enable wakeups on the i8042 device, the serio
devices, and the relevant input devices, to ensure that the hardware is
left powered and untouched throughout the suspend/resume.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/input/input.c                 |    6 +++-
 drivers/input/keyboard/atkbd.c        |    4 ++-
 drivers/input/mouse/hgpk.c            |    2 +
 drivers/input/mouse/psmouse-base.c    |    4 ++-
 drivers/input/serio/i8042-io.h        |    4 ++
 drivers/input/serio/i8042-ip22io.h    |    4 ++
 drivers/input/serio/i8042-jazzio.h    |    4 ++
 drivers/input/serio/i8042-ppcio.h     |    4 ++
 drivers/input/serio/i8042-snirm.h     |    4 ++
 drivers/input/serio/i8042-sparcio.h   |    4 ++
 drivers/input/serio/i8042-x86ia64io.h |    4 ++
 drivers/input/serio/i8042.c           |   62 +++++++++++++++++++++++++++++---
 drivers/input/serio/serio.c           |   29 +++++++++++++--
 13 files changed, 122 insertions(+), 13 deletions(-)

On original submission, Dmitry was worried about this functionality not
working at all on other platforms. I agree, it will only work where the
hardware has been specifically designed with this consideration. v2 of
the patch therefore removes the module param option, meaning that it
will only be activated on platforms that explicitly enable it at the
code level.

v2 also performs a more extensive job. We avoid resetting the device
at the input_device level during suspend/resume. We also disable i8042
interrupts when going into suspend, to avoid races handling interrupts
in the wrong order during resume.

v3 includes a cleanup suggested by Rafael, and explains the corner case
that we have to handle in the input layer.

v4 changes direction a little: each layer now just looks at the wakeup
capability of its own device, avoiding some of the earlier tree
traversal. Userspace must now enable wakeups on 5 devices:
	i8042
	i8042/serio0
	i8042/serio0/input*
	i8042/serio1
	i8042/serio1/input*
This matches the behaviour of USB devices, where both the device and the
parent controller must have wakeups enabled for wakeup functionality
to work. Suggested by Rafael J. Wysocki.

diff --git a/drivers/input/input.c b/drivers/input/input.c
index da38d97..639aba7 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1588,6 +1588,9 @@ static int input_dev_suspend(struct device *dev)
 {
 	struct input_dev *input_dev = to_input_dev(dev);
 
+	if (device_may_wakeup(dev))
+		return 0;
+
 	mutex_lock(&input_dev->mutex);
 
 	if (input_dev->users)
@@ -1602,7 +1605,8 @@ static int input_dev_resume(struct device *dev)
 {
 	struct input_dev *input_dev = to_input_dev(dev);
 
-	input_reset_device(input_dev);
+	if (!device_may_wakeup(dev))
+		input_reset_device(input_dev);
 
 	return 0;
 }
diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 19cfc0c..4bb81c2 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1027,6 +1027,7 @@ static void atkbd_set_keycode_table(struct atkbd *atkbd)
 static void atkbd_set_device_attrs(struct atkbd *atkbd)
 {
 	struct input_dev *input_dev = atkbd->dev;
+	struct device *parent = &atkbd->ps2dev.serio->dev;
 	int i;
 
 	if (atkbd->extra)
@@ -1047,7 +1048,8 @@ static void atkbd_set_device_attrs(struct atkbd *atkbd)
 	input_dev->id.product = atkbd->translated ? 1 : atkbd->set;
 	input_dev->id.version = atkbd->id;
 	input_dev->event = atkbd_event;
-	input_dev->dev.parent = &atkbd->ps2dev.serio->dev;
+	input_dev->dev.parent = parent;
+	device_set_wakeup_capable(&input_dev->dev, device_can_wakeup(parent));
 
 	input_set_drvdata(input_dev, atkbd);
 
diff --git a/drivers/input/mouse/hgpk.c b/drivers/input/mouse/hgpk.c
index 95577c1..d5dd990 100644
--- a/drivers/input/mouse/hgpk.c
+++ b/drivers/input/mouse/hgpk.c
@@ -548,6 +548,8 @@ static void hgpk_setup_input_device(struct input_dev *input,
 		input->phys = old_input->phys;
 		input->id = old_input->id;
 		input->dev.parent = old_input->dev.parent;
+		device_set_wakeup_capable(&input->dev,
+			device_can_wakeup(&old_input->dev));
 	}
 
 	memset(input->evbit, 0, sizeof(input->evbit));
diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 3f74bae..de8ecd5 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -1232,8 +1232,10 @@ static int psmouse_switch_protocol(struct psmouse *psmouse,
 {
 	const struct psmouse_protocol *selected_proto;
 	struct input_dev *input_dev = psmouse->dev;
+	struct device *parent = &psmouse->ps2dev.serio->dev;
 
-	input_dev->dev.parent = &psmouse->ps2dev.serio->dev;
+	input_dev->dev.parent = parent;
+	device_set_wakeup_capable(&input_dev->dev, device_can_wakeup(parent));
 
 	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REL);
 	input_dev->keybit[BIT_WORD(BTN_MOUSE)] =
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
index d37a48e..d275130 100644
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
@@ -1192,6 +1235,7 @@ static int __init i8042_create_kbd_port(void)
 {
 	struct serio *serio;
 	struct i8042_port *port = &i8042_ports[I8042_KBD_PORT_NO];
+	struct device *parent = &i8042_platform_device->dev;
 
 	serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
 	if (!serio)
@@ -1203,7 +1247,8 @@ static int __init i8042_create_kbd_port(void)
 	serio->stop		= i8042_stop;
 	serio->close		= i8042_port_close;
 	serio->port_data	= port;
-	serio->dev.parent	= &i8042_platform_device->dev;
+	serio->dev.parent	= parent;
+	device_set_wakeup_capable(&serio->dev, device_can_wakeup(parent));
 	strlcpy(serio->name, "i8042 KBD port", sizeof(serio->name));
 	strlcpy(serio->phys, I8042_KBD_PHYS_DESC, sizeof(serio->phys));
 
@@ -1218,6 +1263,7 @@ static int __init i8042_create_aux_port(int idx)
 	struct serio *serio;
 	int port_no = idx < 0 ? I8042_AUX_PORT_NO : I8042_MUX_PORT_NO + idx;
 	struct i8042_port *port = &i8042_ports[port_no];
+	struct device *parent = &i8042_platform_device->dev;
 
 	serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
 	if (!serio)
@@ -1228,7 +1274,8 @@ static int __init i8042_create_aux_port(int idx)
 	serio->start		= i8042_start;
 	serio->stop		= i8042_stop;
 	serio->port_data	= port;
-	serio->dev.parent	= &i8042_platform_device->dev;
+	serio->dev.parent	= parent;
+	device_set_wakeup_capable(&serio->dev, device_can_wakeup(parent));
 	if (idx < 0) {
 		strlcpy(serio->name, "i8042 AUX port", sizeof(serio->name));
 		strlcpy(serio->phys, I8042_AUX_PHYS_DESC, sizeof(serio->phys));
@@ -1403,6 +1450,9 @@ static int __init i8042_probe(struct platform_device *dev)
 		i8042_dritek_enable();
 #endif
 
+	if (i8042_enable_wakeup)
+		device_set_wakeup_capable(&dev->dev, true);
+
 	if (!i8042_noaux) {
 		error = i8042_setup_aux();
 		if (error && error != -ENODEV && error != -EBUSY)
diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index ba70058..9e2fdb4 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -931,7 +931,7 @@ static int serio_uevent(struct device *dev, struct kobj_uevent_env *env)
 #endif /* CONFIG_HOTPLUG */
 
 #ifdef CONFIG_PM
-static int serio_suspend(struct device *dev)
+static int serio_poweroff(struct device *dev)
 {
 	struct serio *serio = to_serio_port(dev);
 
@@ -940,7 +940,16 @@ static int serio_suspend(struct device *dev)
 	return 0;
 }
 
-static int serio_resume(struct device *dev)
+static int serio_suspend(struct device *dev)
+{
+	/* If configured as a wakeup source, don't power off. */
+	if (device_may_wakeup(dev))
+		return 0;
+
+	return serio_poweroff(dev);
+}
+
+static int serio_restore(struct device *dev)
 {
 	struct serio *serio = to_serio_port(dev);
 
@@ -953,11 +962,23 @@ static int serio_resume(struct device *dev)
 	return 0;
 }
 
+static int serio_resume(struct device *dev)
+{
+	/*
+	 * If configured as a wakeup source, we didn't power off during
+	 * suspend, and hence have nothing to do.
+	 */
+	if (device_may_wakeup(dev))
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
1.7.6

