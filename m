From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing runtime suspend
Date: Mon,  7 Sep 2015 23:42:41 +0300
Message-ID: <1441658561-26190-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Octavian Purdila <octavian.purdila@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Irina Tirdea <irina.tirdea@intel.com>
List-Id: linux-input@vger.kernel.org

Add new option to sysfs control interface, allowing the user to force
suspend the device. This is useful for devices that need to be
suspended when closing the lid of a laptop or the screen of a mobile
device, while userspace still holds open handles to it and the
system does not enter system suspend.

Add the "off" option to the sysfs control power interface, along with
the already present "on" and "auto". When this attribute is set to
"off", the device will be force suspended by calling its runtime
suspend callback and disabling runtime power management so that
further acceses to the device will not change the actual state.
The device can be resumed by setting the attribute to "on" or "auto".
The behaviour of the interface when switching only between "on"
and "auto" states remains unchanged.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---

Hi,

This is a proposal for suspending devices when the closing the lid of
a laptop or the screen of a mobile device.

I am testing this with a Goodix touchscreen [1] for an Android mobile
device. Android has an userspace layer (power HAL) that would normally
close the touchscreen when the screen is closed. Android touchscreen
drivers usually provide a custom sysfs interface to allow this.
This would be better implemented in a common place, to avoid code
duplication and to simplify the driver code (as previosly discussed
in [1]).

I know there are more ways to implement this, so I would appreciate
your feedback.

Thank you,
Irina

[1] https://lkml.org/lkml/2015/9/7/329
[2] https://lkml.org/lkml/2014/7/15/928

 drivers/base/power/main.c    |   8 +++
 drivers/base/power/runtime.c | 141 ++++++++++++++++++++++++++++++++++++-------
 drivers/base/power/sysfs.c   |  22 ++++---
 drivers/usb/core/sysfs.c     |   3 +-
 include/linux/pm.h           |   8 ++-
 include/linux/pm_runtime.h   |  18 +++++-
 include/trace/events/rpm.h   |   6 +-
 7 files changed, 169 insertions(+), 37 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 9717d5f..e497c38 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -927,6 +927,9 @@ static void device_complete(struct device *dev, pm_message_t state)
 
 	device_unlock(dev);
 
+	if (dev->power.runtime_mode == RPM_MODE_OFF)
+		pm_runtime_force_suspend(dev);
+
 	pm_runtime_put(dev);
 }
 
@@ -1596,6 +1599,11 @@ static int device_prepare(struct device *dev, pm_message_t state)
 	spin_lock_irq(&dev->power.lock);
 	dev->power.direct_complete = ret > 0 && state.event == PM_EVENT_SUSPEND;
 	spin_unlock_irq(&dev->power.lock);
+
+	if (!dev->power.direct_complete &&
+	    dev->power.runtime_mode == RPM_MODE_OFF)
+		pm_runtime_enable(dev);
+
 	return 0;
 }
 
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 5070c4f..0d94b8c 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1189,49 +1189,144 @@ void pm_runtime_enable(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(pm_runtime_enable);
 
+static int dev_pm_mode_on(struct device *dev, void *data)
+{
+	return dev->power.runtime_mode != RPM_MODE_OFF;
+}
+
 /**
- * pm_runtime_forbid - Block runtime PM of a device.
+ * pm_runtime_force_off - Block runtime PM of a device and keep it suspended.
  * @dev: Device to handle.
  *
- * Increase the device's usage count and clear its power.runtime_auto flag,
- * so that it cannot be suspended at run time until pm_runtime_allow() is called
- * for it.
+ * Change the device's power.runtime_mode field to RPM_MODE_OFF and
+ * force runtime suspend (by running the device's runtime suspend
+ * and disabling runtime power management), so that it cannot be
+ * resumed at run time until pm_runtime_force_on() or
+ * pm_runtime_force_auto() is called for it.
  */
-void pm_runtime_forbid(struct device *dev)
+int pm_runtime_force_off(struct device *dev)
 {
+	int mode, ret;
+
 	spin_lock_irq(&dev->power.lock);
-	if (!dev->power.runtime_auto)
-		goto out;
+	mode = dev->power.runtime_mode;
+	if (mode == RPM_MODE_OFF) {
+		spin_unlock_irq(&dev->power.lock);
+		return 0;
+	}
 
-	dev->power.runtime_auto = false;
-	atomic_inc(&dev->power.usage_count);
-	rpm_resume(dev, 0);
+	/* Cannot force suspend if runtime pm is disabled */
+	if (!pm_runtime_enabled(dev)) {
+		spin_unlock_irq(&dev->power.lock);
+		return -EACCES;
+	}
 
- out:
+	/*
+	 * Cannot force suspend if children are on/auto and
+	 * device ignore_children flag is not set.
+	 */
+	if (!dev->power.ignore_children &&
+	    device_for_each_child(dev, NULL, dev_pm_mode_on)) {
+		spin_unlock_irq(&dev->power.lock);
+		return -EBUSY;
+	}
+
+	dev->power.runtime_mode = RPM_MODE_OFF;
+	if (mode == RPM_MODE_ON)
+		atomic_dec(&dev->power.usage_count);
 	spin_unlock_irq(&dev->power.lock);
+
+	ret = pm_runtime_force_suspend(dev);
+	if (ret) {
+		spin_lock_irq(&dev->power.lock);
+		dev->power.runtime_mode = mode;
+		if (mode == RPM_MODE_ON)
+			atomic_inc(&dev->power.usage_count);
+		spin_unlock_irq(&dev->power.lock);
+		return ret;
+	}
+
+	return 0;
 }
-EXPORT_SYMBOL_GPL(pm_runtime_forbid);
+EXPORT_SYMBOL_GPL(pm_runtime_force_off);
 
 /**
- * pm_runtime_allow - Unblock runtime PM of a device.
+ * pm_runtime_force_on - Block runtime PM of a device and keep it resumed.
  * @dev: Device to handle.
  *
- * Decrease the device's usage count and set its power.runtime_auto flag.
+ * Increase the device's usage count and set its power.runtime_mode field,
+ * to RPM_MODE_ON, so that it cannot be suspended at run time until
+ * pm_runtime_force_auto() is called for it.
  */
-void pm_runtime_allow(struct device *dev)
+int pm_runtime_force_on(struct device *dev)
 {
+	int mode;
+
 	spin_lock_irq(&dev->power.lock);
-	if (dev->power.runtime_auto)
-		goto out;
+	mode = dev->power.runtime_mode;
+	if (mode == RPM_MODE_ON) {
+		spin_unlock_irq(&dev->power.lock);
+		return 0;
+	}
 
-	dev->power.runtime_auto = true;
-	if (atomic_dec_and_test(&dev->power.usage_count))
-		rpm_idle(dev, RPM_AUTO);
+	/* Cannot resume if parent is force suspended. */
+	if (dev->parent && dev->parent->power.runtime_mode == RPM_MODE_OFF) {
+		spin_unlock_irq(&dev->power.lock);
+		return -EBUSY;
+	}
 
- out:
+	dev->power.runtime_mode = RPM_MODE_ON;
+	spin_unlock_irq(&dev->power.lock);
+
+	if (mode == RPM_MODE_OFF)
+		pm_runtime_enable(dev);
+
+	__pm_runtime_resume(dev, RPM_GET_PUT);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pm_runtime_force_on);
+
+/**
+ * pm_runtime_force_auto - Unblock runtime PM of a device.
+ * @dev: Device to handle.
+ *
+ * Set the device's power.runtime_mode field to RPM_MODE_AUTO.
+ * If previous state was suspended, enable runtime power
+ * management and resume. If previous state was resumed,
+ * decrease the device's usage count.
+ */
+int pm_runtime_force_auto(struct device *dev)
+{
+	int mode, flags = 0;
+
+	spin_lock_irq(&dev->power.lock);
+	mode = dev->power.runtime_mode;
+	if (mode == RPM_MODE_AUTO) {
+		spin_unlock_irq(&dev->power.lock);
+		return 0;
+	}
+
+	/* Cannot resume if both device and its parent are force suspended */
+	if (mode == RPM_MODE_OFF && dev->parent &&
+	    dev->parent->power.runtime_mode == RPM_MODE_OFF) {
+		spin_unlock_irq(&dev->power.lock);
+		return -EBUSY;
+	}
+
+	dev->power.runtime_mode = RPM_MODE_AUTO;
 	spin_unlock_irq(&dev->power.lock);
+
+	if (mode == RPM_MODE_OFF) {
+		pm_runtime_enable(dev);
+		__pm_runtime_resume(dev, 0);
+	} else if (mode == RPM_MODE_ON) {
+		flags = RPM_GET_PUT;
+	}
+
+	__pm_runtime_idle(dev, RPM_AUTO | flags);
+	return 0;
 }
-EXPORT_SYMBOL_GPL(pm_runtime_allow);
+EXPORT_SYMBOL_GPL(pm_runtime_force_auto);
 
 /**
  * pm_runtime_no_callbacks - Ignore runtime PM callbacks for a device.
@@ -1368,7 +1463,7 @@ void pm_runtime_init(struct device *dev)
 
 	atomic_set(&dev->power.child_count, 0);
 	pm_suspend_ignore_children(dev, false);
-	dev->power.runtime_auto = true;
+	dev->power.runtime_mode = RPM_MODE_AUTO;
 
 	dev->power.request_pending = false;
 	dev->power.request = RPM_REQ_NONE;
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index d2be3f9..db0630a 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -97,31 +97,38 @@ EXPORT_SYMBOL_GPL(power_group_name);
 
 static const char ctrl_auto[] = "auto";
 static const char ctrl_on[] = "on";
+static const char ctrl_off[] = "off";
 
 static ssize_t control_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
 	return sprintf(buf, "%s\n",
-				dev->power.runtime_auto ? ctrl_auto : ctrl_on);
+		       dev->power.runtime_mode == RPM_MODE_AUTO ? ctrl_auto :
+		       dev->power.runtime_mode == RPM_MODE_ON ? ctrl_on :
+		       ctrl_off);
 }
 
 static ssize_t control_store(struct device * dev, struct device_attribute *attr,
 			     const char * buf, size_t n)
 {
 	char *cp;
-	int len = n;
+	int len = n, ret = 0;
 
 	cp = memchr(buf, '\n', n);
 	if (cp)
 		len = cp - buf;
 	device_lock(dev);
 	if (len == sizeof ctrl_auto - 1 && strncmp(buf, ctrl_auto, len) == 0)
-		pm_runtime_allow(dev);
+		ret = pm_runtime_force_auto(dev);
 	else if (len == sizeof ctrl_on - 1 && strncmp(buf, ctrl_on, len) == 0)
-		pm_runtime_forbid(dev);
+		ret = pm_runtime_force_on(dev);
+	else if (len == sizeof ctrl_off - 1 && strncmp(buf, ctrl_off, len) == 0)
+		ret = pm_runtime_force_off(dev);
 	else
-		n = -EINVAL;
+		ret = -EINVAL;
 	device_unlock(dev);
+	if (ret)
+		return ret;
 	return n;
 }
 
@@ -545,11 +552,12 @@ static ssize_t rtpm_children_show(struct device *dev,
 static ssize_t rtpm_enabled_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
-	if ((dev->power.disable_depth) && (dev->power.runtime_auto == false))
+	if ((dev->power.disable_depth) &&
+	    (dev->power.runtime_mode != RPM_MODE_AUTO))
 		return sprintf(buf, "disabled & forbidden\n");
 	else if (dev->power.disable_depth)
 		return sprintf(buf, "disabled\n");
-	else if (dev->power.runtime_auto == false)
+	else if (dev->power.runtime_mode != RPM_MODE_AUTO)
 		return sprintf(buf, "forbidden\n");
 	return sprintf(buf, "enabled\n");
 }
diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index d269738..8165102 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -408,7 +408,8 @@ static ssize_t level_show(struct device *dev, struct device_attribute *attr,
 	const char *p = auto_string;
 
 	warn_level();
-	if (udev->state != USB_STATE_SUSPENDED && !udev->dev.power.runtime_auto)
+	if (udev->state != USB_STATE_SUSPENDED &&
+	    udev->dev.power.runtime_mode != RPM_MODE_AUTO)
 		p = on_string;
 	return sprintf(buf, "%s\n", p);
 }
diff --git a/include/linux/pm.h b/include/linux/pm.h
index e2f1be6..69273d4 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -542,6 +542,12 @@ struct pm_subsys_data {
 #endif
 };
 
+enum rpm_mode {
+	RPM_MODE_AUTO = 0,
+	RPM_MODE_ON,
+	RPM_MODE_OFF,
+};
+
 struct dev_pm_info {
 	pm_message_t		power_state;
 	unsigned int		can_wakeup:1;
@@ -575,12 +581,12 @@ struct dev_pm_info {
 	unsigned int		request_pending:1;
 	unsigned int		deferred_resume:1;
 	unsigned int		run_wake:1;
-	unsigned int		runtime_auto:1;
 	unsigned int		no_callbacks:1;
 	unsigned int		irq_safe:1;
 	unsigned int		use_autosuspend:1;
 	unsigned int		timer_autosuspends:1;
 	unsigned int		memalloc_noio:1;
+	enum rpm_mode		runtime_mode;
 	enum rpm_request	request;
 	enum rpm_status		runtime_status;
 	int			runtime_error;
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 30e84d4..186e9f0 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -44,8 +44,9 @@ extern int __pm_runtime_set_status(struct device *dev, unsigned int status);
 extern int pm_runtime_barrier(struct device *dev);
 extern void pm_runtime_enable(struct device *dev);
 extern void __pm_runtime_disable(struct device *dev, bool check_resume);
-extern void pm_runtime_allow(struct device *dev);
-extern void pm_runtime_forbid(struct device *dev);
+extern int pm_runtime_force_off(struct device *dev);
+extern int pm_runtime_force_on(struct device *dev);
+extern int pm_runtime_force_auto(struct device *dev);
 extern void pm_runtime_no_callbacks(struct device *dev);
 extern void pm_runtime_irq_safe(struct device *dev);
 extern void __pm_runtime_use_autosuspend(struct device *dev, bool use);
@@ -55,6 +56,16 @@ extern void pm_runtime_update_max_time_suspended(struct device *dev,
 						 s64 delta_ns);
 extern void pm_runtime_set_memalloc_noio(struct device *dev, bool enable);
 
+static inline void pm_runtime_allow(struct device *dev)
+{
+	pm_runtime_force_auto(dev);
+}
+
+static inline void pm_runtime_forbid(struct device *dev)
+{
+	pm_runtime_force_on(dev);
+}
+
 static inline bool pm_children_suspended(struct device *dev)
 {
 	return dev->power.ignore_children
@@ -155,6 +166,9 @@ static inline void pm_runtime_enable(struct device *dev) {}
 static inline void __pm_runtime_disable(struct device *dev, bool c) {}
 static inline void pm_runtime_allow(struct device *dev) {}
 static inline void pm_runtime_forbid(struct device *dev) {}
+static inline int pm_runtime_force_off(struct device *dev) { return 0; }
+static inline int pm_runtime_force_on(struct device *dev) { return 0; }
+static inline int pm_runtime_force_auto(struct device *dev) { return 0; }
 
 static inline bool pm_children_suspended(struct device *dev) { return false; }
 static inline void pm_runtime_get_noresume(struct device *dev) {}
diff --git a/include/trace/events/rpm.h b/include/trace/events/rpm.h
index 33f85b6..ab9cc18 100644
--- a/include/trace/events/rpm.h
+++ b/include/trace/events/rpm.h
@@ -25,7 +25,7 @@ DECLARE_EVENT_CLASS(rpm_internal,
 		__field(        int,            flags           )
 		__field(        int ,   	usage_count	)
 		__field(        int ,   	disable_depth   )
-		__field(        int ,   	runtime_auto	)
+		__field(        int ,   	runtime_mode	)
 		__field(        int ,   	request_pending	)
 		__field(        int ,   	irq_safe	)
 		__field(        int ,   	child_count 	)
@@ -37,7 +37,7 @@ DECLARE_EVENT_CLASS(rpm_internal,
 		__entry->usage_count = atomic_read(
 			&dev->power.usage_count);
 		__entry->disable_depth = dev->power.disable_depth;
-		__entry->runtime_auto = dev->power.runtime_auto;
+		__entry->runtime_mode = dev->power.runtime_mode;
 		__entry->request_pending = dev->power.request_pending;
 		__entry->irq_safe = dev->power.irq_safe;
 		__entry->child_count = atomic_read(
@@ -49,7 +49,7 @@ DECLARE_EVENT_CLASS(rpm_internal,
 			__get_str(name), __entry->flags,
 			__entry->usage_count,
 			__entry->disable_depth,
-			__entry->runtime_auto,
+			__entry->runtime_mode,
 			__entry->request_pending,
 			__entry->irq_safe,
 			__entry->child_count
-- 
1.9.1

