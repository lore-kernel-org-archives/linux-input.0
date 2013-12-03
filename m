From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH] input synaptics-rmi4: Remove sysfs & debugfs stuff
Date: Mon, 2 Dec 2013 16:52:20 -0800
Message-ID: <1386031940-20829-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:22749 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957Ab3LCAwZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Dec 2013 19:52:25 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

This patch implements changes to the synaptics-rmi4 branch of
Dmitry's input tree.  The base for the patchset is Dmitry's commit
4a695a01fba9bf467b3b52e124ccee6cef73b323 from 2013-01-31.

Removed all of the sysfs and most of the debugfs support from the driver core
and function drivers.  The code is still horribly broken (as previously
advertised) but should now be easier to work with.  A few lines are reformatted
for line-length issues.

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Cc: Joerie de Gram <j.de.gram@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---
 drivers/input/rmi4/rmi_bus.h    |  11 -
 drivers/input/rmi4/rmi_driver.c | 175 +--------
 drivers/input/rmi4/rmi_f01.c    | 787 +---------------------------------------
 drivers/input/rmi4/rmi_f11.c    | 183 ----------
 drivers/input/rmi4/rmi_i2c.c    |   6 +-
 5 files changed, 9 insertions(+), 1153 deletions(-)

diff --git a/drivers/input/rmi4/rmi_bus.h b/drivers/input/rmi4/rmi_bus.h
index 33e8f1b..e2a3dc6 100644
--- a/drivers/input/rmi4/rmi_bus.h
+++ b/drivers/input/rmi4/rmi_bus.h
@@ -22,17 +22,6 @@
 #include <linux/debugfs.h>
 #include <linux/rmi.h>
 
-
-/* Permissions for sysfs attributes.  Since the permissions policy will change
- * on a global basis in the future, rather than edit all sysfs attrs everywhere
- * in the driver (and risk screwing that up in the process), we use this handy
- * set of #defines.  That way when we change the policy for sysfs permissions,
- * we only need to change them here.
- */
-#define RMI_RO_ATTR S_IRUGO
-#define RMI_RW_ATTR (S_IRUGO | S_IWUGO)
-#define RMI_WO_ATTR S_IWUGO
-
 struct rmi_device;
 
 /**
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 5cf7b33..132cd52 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -4,9 +4,10 @@
  *
  * This driver provides the core support for a single RMI4-based device.
  *
- * The RMI4 specification can be found here:
+ * The RMI4 specification can be found here (URL split for line length):
  *
- * http://www.synaptics.com/sites/default/files/511-000136-01-Rev-E-RMI4%20Intrfacing%20Guide.pdf
+ * http://www.synaptics.com/sites/default/files/
+ *      511-000136-01-Rev-E-RMI4%20Intrfacing%20Guide.pdf
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License version 2 as published by
@@ -42,48 +43,6 @@
 
 #define IRQ_DEBUG(data) (IS_ENABLED(CONFIG_RMI4_DEBUG) && data->irq_debug)
 
-#ifdef	CONFIG_RMI4_DEBUG
-static void rmi_driver_setup_debugfs(struct rmi_device *rmi_dev)
-{
-	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
-	struct rmi_phys_info *info = &rmi_dev->phys->info;
-
-	if (!rmi_dev->debugfs_root)
-		return;
-
-	if (!debugfs_create_u32_array("transport_stats", RMI_RO_ATTR,
-				      rmi_dev->debugfs_root,
-				      (u32 *)&info->tx_count, 6))
-		dev_warn(&rmi_dev->dev,
-			 "Failed to create debugfs transport_stats\n");
-
-	if (!debugfs_create_bool("irq_debug", RMI_RW_ATTR,
-				 rmi_dev->debugfs_root,
-				 &data->irq_debug))
-		dev_warn(&rmi_dev->dev, "Failed to create debugfs irq_debug\n");
-
-	if (!debugfs_create_u32("attn_count", RMI_RO_ATTR,
-				rmi_dev->debugfs_root,
-				&data->attn_count))
-		dev_warn(&rmi_dev->dev,
-			 "Failed to create debugfs attn_count\n");
-}
-
-static void rmi_driver_teardown_debugfs(struct rmi_device *rmi_dev)
-{
-	debugfs_remove_recursive(rmi_dev->debugfs_root);
-}
-
-#else
-static inline void rmi_driver_setup_debugfs(struct rmi_device *rmi_dev)
-{
-}
-
-static inline rmi_driver_teardown_debugfs(struct rmi_device *rmi_dev)
-{
-}
-#endif
-
 static irqreturn_t rmi_irq_thread(int irq, void *p)
 {
 	struct rmi_phys_device *phys = p;
@@ -217,122 +176,6 @@ static int enable_sensor(struct rmi_device *rmi_dev)
 	return retval;
 }
 
-/* sysfs show and store fns for driver attributes */
-
-static ssize_t rmi_driver_bsr_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	struct rmi_device *rmi_dev;
-	struct rmi_driver_data *data;
-	rmi_dev = to_rmi_device(dev);
-	data = dev_get_drvdata(&rmi_dev->dev);
-
-	return snprintf(buf, PAGE_SIZE, "%u\n", data->bsr);
-}
-
-static ssize_t rmi_driver_bsr_store(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t count)
-{
-	int retval;
-	unsigned long val;
-	struct rmi_device *rmi_dev;
-	struct rmi_driver_data *data;
-
-	rmi_dev = to_rmi_device(dev);
-	data = dev_get_drvdata(&rmi_dev->dev);
-
-	/* need to convert the string data to an actual value */
-	retval = strict_strtoul(buf, 10, &val);
-	if (retval < 0 || val > 255) {
-		dev_err(dev, "Invalid value '%s' written to BSR.\n", buf);
-		return -EINVAL;
-	}
-
-	retval = rmi_write(rmi_dev, BSR_LOCATION, (u8)val);
-	if (retval < 0) {
-		dev_err(dev, "%s : failed to write bsr %lu to %#06x\n",
-			__func__, val, BSR_LOCATION);
-		return retval;
-	}
-
-	data->bsr = val;
-
-	return count;
-}
-
-static DEVICE_ATTR(bsr, RMI_RW_ATTR, rmi_driver_bsr_show, rmi_driver_bsr_store);
-
-static ssize_t rmi_driver_enabled_show(struct device *dev,
-				       struct device_attribute *attr, char *buf)
-{
-	struct rmi_device *rmi_dev = to_rmi_device(dev);
-	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
-
-	return snprintf(buf, PAGE_SIZE, "%u\n", data->enabled);
-}
-
-static ssize_t rmi_driver_enabled_store(struct device *dev,
-					struct device_attribute *attr,
-					const char *buf, size_t count)
-{
-	struct rmi_device *rmi_dev = to_rmi_device(dev);
-	int retval;
-	int new_value;
-
-	if (sysfs_streq(buf, "0"))
-		new_value = false;
-	else if (sysfs_streq(buf, "1"))
-		new_value = true;
-	else
-		return -EINVAL;
-
-	if (new_value) {
-		retval = enable_sensor(rmi_dev);
-		if (retval) {
-			dev_err(dev, "Failed to enable sensor, code=%d.\n",
-				retval);
-			return -EIO;
-		}
-	} else {
-		disable_sensor(rmi_dev);
-	}
-
-	return count;
-}
-
-/** This sysfs attribute is deprecated, and will be removed in a future release.
- */
-static DEVICE_ATTR(enabled, RMI_RW_ATTR,
-		   rmi_driver_enabled_show, rmi_driver_enabled_store);
-
-static umode_t rmi_driver_attr_visible(struct kobject *kobj,
-				       struct attribute *attr, int n)
-{
-	struct device *dev = kobj_to_dev(kobj);
-	struct rmi_device *rmi_dev = to_rmi_device(dev);
-	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
-	umode_t mode = attr->mode;
-
-	if (attr == &dev_attr_bsr.attr) {
-		if (!data->pdt_props.has_bsr)
-			mode = 0;
-	}
-
-	return mode;
-}
-
-static struct attribute *rmi_driver_attrs[] = {
-	&dev_attr_bsr.attr,
-	&dev_attr_enabled.attr,
-	NULL
-};
-
-static struct attribute_group rmi_driver_attr_group = {
-	.is_visible	= rmi_driver_attr_visible,
-	.attrs		= rmi_driver_attrs,
-};
-
 static void rmi_free_function_list(struct rmi_device *rmi_dev)
 {
 	struct rmi_function *fn, *tmp;
@@ -718,7 +561,8 @@ static int reset_and_reflash(struct rmi_device *rmi_dev)
 	bool has_f01 = false;
 	int i;
 	int retval;
-	const struct rmi_device_platform_data *pdata = to_rmi_platform_data(rmi_dev);
+	const struct rmi_device_platform_data *pdata =
+			to_rmi_platform_data(rmi_dev);
 
 	dev_dbg(dev, "Initial reset.\n");
 
@@ -941,7 +785,6 @@ static int rmi_driver_remove(struct device *dev)
 	struct rmi_device *rmi_dev = to_rmi_device(dev);
 
 	rmi_driver_teardown_debugfs(rmi_dev);
-	sysfs_remove_group(&dev->kobj, &rmi_driver_attr_group);
 
 	disable_sensor(rmi_dev);
 	rmi_free_function_list(rmi_dev);
@@ -1079,14 +922,6 @@ static int rmi_driver_probe(struct device *dev)
 		mutex_init(&data->suspend_mutex);
 	}
 
-	retval = sysfs_create_group(&dev->kobj, &rmi_driver_attr_group);
-	if (retval < 0) {
-		dev_err(dev, "%s: Failed to create sysfs group\n", __func__);
-		goto err_free_data;
-	}
-
-	rmi_driver_setup_debugfs(rmi_dev);
-
 	if (pdata->attn_gpio) {
 		data->irq = gpio_to_irq(pdata->attn_gpio);
 		if (pdata->level_triggered) {
diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index fe26869..840a8d0 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -8,7 +8,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/debugfs.h>
 #include <linux/kconfig.h>
 #include <linux/rmi.h>
 #include <linux/slab.h>
@@ -143,780 +142,6 @@ struct f01_data {
 	bool suspended;
 	bool old_nosleep;
 #endif
-
-#ifdef CONFIG_RMI4_DEBUG
-	struct dentry *debugfs_interrupt_enable;
-#endif
-};
-
-#ifdef CONFIG_RMI4_DEBUG
-struct f01_debugfs_data {
-	bool done;
-	struct rmi_function *fn;
-};
-
-static int f01_debug_open(struct inode *inodep, struct file *filp)
-{
-	struct f01_debugfs_data *data;
-	struct rmi_function *fn = inodep->i_private;
-
-	data = kzalloc(sizeof(struct f01_debugfs_data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	data->fn = fn;
-	filp->private_data = data;
-	return 0;
-}
-
-static int f01_debug_release(struct inode *inodep, struct file *filp)
-{
-	kfree(filp->private_data);
-	return 0;
-}
-
-static ssize_t interrupt_enable_read(struct file *filp, char __user *buffer,
-				     size_t size, loff_t *offset) {
-	int i;
-	int len;
-	int total_len = 0;
-	char local_buf[size]; // FIXME!!!! XXX arbitrary size array on stack
-	char *current_buf = local_buf;
-	struct f01_debugfs_data *data = filp->private_data;
-	struct f01_data *f01 = data->fn->data;
-
-	if (data->done)
-		return 0;
-
-	data->done = 1;
-
-	/* loop through each irq value and copy its
-	 * string representation into buf */
-	for (i = 0; i < f01->irq_count; i++) {
-		int irq_reg;
-		int irq_shift;
-		int interrupt_enable;
-
-		irq_reg = i / 8;
-		irq_shift = i % 8;
-		interrupt_enable =
-		    ((f01->device_control.interrupt_enable[irq_reg]
-			>> irq_shift) & 0x01);
-
-		/* get next irq value and write it to buf */
-		len = snprintf(current_buf, size - total_len,
-			"%u ", interrupt_enable);
-		/* bump up ptr to next location in buf if the
-		 * snprintf was valid.  Otherwise issue an error
-		 * and return. */
-		if (len > 0) {
-			current_buf += len;
-			total_len += len;
-		} else {
-			dev_err(&data->fn->dev, "Failed to build interrupt_enable buffer, code = %d.\n",
-						len);
-			return snprintf(local_buf, size, "unknown\n");
-		}
-	}
-	len = snprintf(current_buf, size - total_len, "\n");
-	if (len > 0)
-		total_len += len;
-	else
-		dev_warn(&data->fn->dev, "%s: Failed to append carriage return.\n",
-			 __func__);
-
-	if (copy_to_user(buffer, local_buf, total_len))
-		return -EFAULT;
-
-	return total_len;
-}
-
-static ssize_t interrupt_enable_write(struct file *filp,
-		const char __user *buffer, size_t size, loff_t *offset) {
-	int retval;
-	char buf[size];
-	char *local_buf = buf;
-	int i;
-	int irq_count = 0;
-	int irq_reg = 0;
-	struct f01_debugfs_data *data = filp->private_data;
-	struct f01_data *f01 = data->fn->data;
-
-	retval = copy_from_user(buf, buffer, size);
-	if (retval)
-		return -EFAULT;
-
-	for (i = 0; i < f01->irq_count && *local_buf != 0;
-	     i++, local_buf += 2) {
-		int irq_shift;
-		int interrupt_enable;
-		int result;
-
-		irq_reg = i / 8;
-		irq_shift = i % 8;
-
-		/* get next interrupt mapping value and store and bump up to
-		 * point to next item in local_buf */
-		result = sscanf(local_buf, "%u", &interrupt_enable);
-		if ((result != 1) ||
-			(interrupt_enable != 0 && interrupt_enable != 1)) {
-			dev_err(&data->fn->dev, "Interrupt enable[%d] is not a valid value 0x%x.\n",
-				i, interrupt_enable);
-			return -EINVAL;
-		}
-		if (interrupt_enable == 0) {
-			f01->device_control.interrupt_enable[irq_reg] &=
-				(1 << irq_shift) ^ 0xFF;
-		} else
-			f01->device_control.interrupt_enable[irq_reg] |=
-				(1 << irq_shift);
-		irq_count++;
-	}
-
-	/* Make sure the irq count matches */
-	if (irq_count != f01->irq_count) {
-		dev_err(&data->fn->dev, "Interrupt enable count of %d doesn't match device count of %d.\n",
-			 irq_count, f01->irq_count);
-		return -EINVAL;
-	}
-
-	/* write back to the control register */
-	retval = rmi_write_block(data->fn->rmi_dev, f01->interrupt_enable_addr,
-			f01->device_control.interrupt_enable,
-			f01->num_of_irq_regs);
-	if (retval < 0) {
-		dev_err(&data->fn->dev, "Could not write interrupt_enable mask to %#06x\n",
-			f01->interrupt_enable_addr);
-		return retval;
-	}
-
-	return size;
-}
-
-static const struct file_operations interrupt_enable_fops = {
-	.owner = THIS_MODULE,
-	.open = f01_debug_open,
-	.release = f01_debug_release,
-	.read = interrupt_enable_read,
-	.write = interrupt_enable_write,
-};
-
-static int setup_debugfs(struct rmi_function *fn)
-{
-	struct f01_data *data = fn->data;
-
-	if (!fn->debugfs_root)
-		return -ENODEV;
-
-	data->debugfs_interrupt_enable = debugfs_create_file("interrupt_enable",
-		RMI_RW_ATTR, fn->debugfs_root, fn, &interrupt_enable_fops);
-	if (!data->debugfs_interrupt_enable)
-		dev_warn(&fn->dev,
-			 "Failed to create debugfs interrupt_enable.\n");
-
-	return 0;
-}
-
-static void teardown_debugfs(struct f01_data *f01)
-{
-	if (f01->debugfs_interrupt_enable)
-		debugfs_remove(f01->debugfs_interrupt_enable);
-}
-
-#else
-
-static inline int setup_debugfs(struct rmi_function *fn)
-{
-	return 0;
-}
-
-static inline void teardown_debugfs(struct f01_data *f01)
-{
-}
-
-#endif
-
-static ssize_t rmi_fn_01_productinfo_show(struct device *dev,
-					  struct device_attribute *attr,
-					  char *buf)
-{
-	struct rmi_function *fn = to_rmi_function(dev);
-	struct f01_data *data = fn->data;
-
-	return snprintf(buf, PAGE_SIZE, "0x%04x\n",
-			data->properties.productinfo);
-}
-
-static ssize_t rmi_fn_01_productid_show(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
-{
-	struct rmi_function *fn = to_rmi_function(dev);
-	struct f01_data *data = fn->data;
-
-	return snprintf(buf, PAGE_SIZE, "%s\n", data->properties.product_id);
-}
-
-static ssize_t rmi_fn_01_manufacturer_show(struct device *dev,
-					   struct device_attribute *attr,
-					   char *buf)
-{
-	struct rmi_function *fn = to_rmi_function(dev);
-	struct f01_data *data = fn->data;
-
-	return snprintf(buf, PAGE_SIZE, "0x%02x\n",
-			data->properties.manufacturer_id);
-}
-
-static ssize_t rmi_fn_01_datecode_show(struct device *dev,
-				       struct device_attribute *attr,
-				       char *buf)
-{
-	struct rmi_function *fn = to_rmi_function(dev);
-	struct f01_data *data = fn->data;
-
-	return snprintf(buf, PAGE_SIZE, "%s\n", data->properties.dom);
-}
-
-static ssize_t rmi_fn_01_reset_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t count)
-{
-	struct rmi_function *fn = to_rmi_function(dev);
-	unsigned int reset;
-	int error;
-
-	if (sscanf(buf, "%u", &reset) != 1)
-		return -EINVAL;
-	if (reset < 0 || reset > 1)
-		return -EINVAL;
-
-	/* Per spec, 0 has no effect, so we skip it entirely. */
-	if (reset) {
-		/* Command register always reads as 0, so just use a local. */
-		u8 command = RMI_F01_CMD_DEVICE_RESET;
-
-		error = rmi_write_block(fn->rmi_dev, fn->fd.command_base_addr,
-					 &command, sizeof(command));
-		if (error < 0) {
-			dev_err(dev, "Failed to issue reset command, code = %d.",
-				error);
-			return error;
-		}
-	}
-
-	return count;
-}
-
-static ssize_t rmi_fn_01_sleepmode_show(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
-{
-	struct rmi_function *fn = to_rmi_function(dev);
-	struct f01_data *data = fn->data;
-	unsigned int value = data->device_control.ctrl0 &
-					RMI_F01_CTRL0_SLEEP_MODE_MASK;
-
-	return snprintf(buf, PAGE_SIZE, "%d\n", value);
-}
-
-static ssize_t rmi_fn_01_sleepmode_store(struct device *dev,
-					 struct device_attribute *attr,
-					 const char *buf, size_t count)
-{
-	struct rmi_function *fn = to_rmi_function(dev);
-	struct f01_data *data = fn->data;
-	unsigned long new_value;
-	int retval;
-
-	retval = strict_strtoul(buf, 10, &new_value);
-	if (retval < 0 || !RMI_IS_VALID_SLEEPMODE(new_value)) {
-		dev_err(dev, "%s: Invalid sleep mode %s.", __func__, buf);
-		return -EINVAL;
-	}
-
-	retval = mutex_lock_interruptible(&data->control_mutex);
-	if (retval)
-		return retval;
-
-	dev_dbg(dev, "Setting sleep mode to %ld.", new_value);
-
-	data->device_control.ctrl0 &= ~RMI_F01_CTRL0_SLEEP_MODE_MASK;
-	data->device_control.ctrl0 |= new_value;
-
-	retval = rmi_write_block(fn->rmi_dev, fn->fd.control_base_addr,
-			&data->device_control.ctrl0,
-			sizeof(data->device_control.ctrl0));
-	if (retval >= 0)
-		retval = count;
-	else
-		dev_err(dev, "Failed to write sleep mode, code %d.\n", retval);
-
-	mutex_unlock(&data->control_mutex);
-	return retval;
-}
-
-static ssize_t rmi_fn_01_nosleep_show(struct device *dev,
-				      struct device_attribute *attr, char *buf)
-{
-	struct rmi_function *fn = to_rmi_function(dev);
-	struct f01_data *data = fn->data;
-	unsigned int value = !!(data->device_control.ctrl0 &
-					RMI_F01_CRTL0_NOSLEEP_BIT);
-
-	return snprintf(buf, PAGE_SIZE, "%d\n", value);
-}
-
-static ssize_t rmi_fn_01_nosleep_store(struct device *dev,
-				       struct device_attribute *attr,
-				       const char *buf, size_t count)
-{
-	struct rmi_function *fn = to_rmi_function(dev);
-	struct f01_data *data = fn->data;
-	unsigned long new_value;
-	int retval;
-
-	retval = strict_strtoul(buf, 10, &new_value);
-	if (retval < 0 || new_value > 1) {
-		dev_err(dev, "%s: Invalid nosleep bit %s.", __func__, buf);
-		return -EINVAL;
-	}
-
-	retval = mutex_lock_interruptible(&data->control_mutex);
-	if (retval)
-		return retval;
-
-	if (new_value)
-		data->device_control.ctrl0 |= RMI_F01_CRTL0_NOSLEEP_BIT;
-	else
-		data->device_control.ctrl0 &= ~RMI_F01_CRTL0_NOSLEEP_BIT;
-
-	retval = rmi_write_block(fn->rmi_dev, fn->fd.control_base_addr,
-				 &data->device_control.ctrl0,
-				 sizeof(data->device_control.ctrl0));
-	if (retval >= 0)
-		retval = count;
-	else
-		dev_err(dev, "Failed to write nosleep bit.\n");
-
-	mutex_unlock(&data->control_mutex);
-	return retval;
-}
-
-static ssize_t rmi_fn_01_chargerinput_show(struct device *dev,
-				      struct device_attribute *attr, char *buf)
-{
-	struct rmi_function *fn = to_rmi_function(dev);
-	struct f01_data *data = fn->data;
-	unsigned int value = !!(data->device_control.ctrl0 &
-					RMI_F01_CRTL0_CHARGER_BIT);
-
-	return snprintf(buf, PAGE_SIZE, "%d\n", value);
-}
-
-static ssize_t rmi_fn_01_chargerinput_store(struct device *dev,
-				       struct device_attribute *attr,
-				       const char *buf, size_t count)
-{
-	struct rmi_function *fn = to_rmi_function(dev);
-	struct f01_data *data = fn->data;
-	unsigned long new_value;
-	int retval;
-
-	retval = strict_strtoul(buf, 10, &new_value);
-	if (retval < 0 || new_value > 1) {
-		dev_err(dev, "%s: Invalid chargerinput bit %s.", __func__, buf);
-		return -EINVAL;
-	}
-
-	retval = mutex_lock_interruptible(&data->control_mutex);
-	if (retval)
-		return retval;
-
-	if (new_value)
-		data->device_control.ctrl0 |= RMI_F01_CRTL0_CHARGER_BIT;
-	else
-		data->device_control.ctrl0 &= ~RMI_F01_CRTL0_CHARGER_BIT;
-
-	retval = rmi_write_block(fn->rmi_dev, fn->fd.control_base_addr,
-				 &data->device_control.ctrl0,
-				 sizeof(data->device_control.ctrl0));
-	if (retval >= 0)
-		retval = count;
-	else
-		dev_err(dev, "Failed to write chargerinput bit.\n");
-
-	mutex_unlock(&data->control_mutex);
-	return retval;
-}
-
-static ssize_t rmi_fn_01_reportrate_show(struct device *dev,
-				      struct device_attribute *attr, char *buf)
-{
-	struct rmi_function *fn = to_rmi_function(dev);
-	struct f01_data *data = fn->data;
-	int value = !!(data->device_control.ctrl0 &
-				RMI_F01_CRTL0_REPORTRATE_BIT);
-
-	return snprintf(buf, PAGE_SIZE, "%d\n", value);
-}
-
-static ssize_t rmi_fn_01_reportrate_store(struct device *dev,
-				       struct device_attribute *attr,
-				       const char *buf, size_t count)
-{
-	struct rmi_function *fn = to_rmi_function(dev);
-	struct f01_data *data = fn->data;
-	unsigned long new_value;
-	int retval;
-
-	retval = strict_strtoul(buf, 10, &new_value);
-	if (retval < 0 || new_value > 1) {
-		dev_err(dev, "%s: Invalid reportrate bit %s.", __func__, buf);
-		return -EINVAL;
-	}
-
-	retval = mutex_lock_interruptible(&data->control_mutex);
-	if (retval)
-		return retval;
-
-	if (new_value)
-		data->device_control.ctrl0 |= RMI_F01_CRTL0_REPORTRATE_BIT;
-	else
-		data->device_control.ctrl0 &= ~RMI_F01_CRTL0_REPORTRATE_BIT;
-
-	retval = rmi_write_block(fn->rmi_dev, fn->fd.control_base_addr,
-				 &data->device_control.ctrl0,
-				 sizeof(data->device_control.ctrl0));
-	if (retval >= 0)
-		retval = count;
-	else
-		dev_err(dev, "Failed to write reportrate bit.\n");
-
-	mutex_unlock(&data->control_mutex);
-	return retval;
-}
-
-static ssize_t rmi_fn_01_interrupt_enable_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct rmi_function *fn = to_rmi_function(dev);
-	struct f01_data *data = fn->data;
-	int i, len, total_len = 0;
-	char *current_buf = buf;
-
-	/* loop through each irq value and copy its
-	 * string representation into buf */
-	for (i = 0; i < data->irq_count; i++) {
-		int irq_reg;
-		int irq_shift;
-		int interrupt_enable;
-
-		irq_reg = i / 8;
-		irq_shift = i % 8;
-		interrupt_enable =
-		    ((data->device_control.interrupt_enable[irq_reg]
-			>> irq_shift) & 0x01);
-
-		/* get next irq value and write it to buf */
-		len = snprintf(current_buf, PAGE_SIZE - total_len,
-			"%u ", interrupt_enable);
-		/* bump up ptr to next location in buf if the
-		 * snprintf was valid.  Otherwise issue an error
-		 * and return. */
-		if (len > 0) {
-			current_buf += len;
-			total_len += len;
-		} else {
-			dev_err(dev, "Failed to build interrupt_enable buffer, code = %d.\n",
-						len);
-			return snprintf(buf, PAGE_SIZE, "unknown\n");
-		}
-	}
-	len = snprintf(current_buf, PAGE_SIZE - total_len, "\n");
-	if (len > 0)
-		total_len += len;
-	else
-		dev_warn(dev, "%s: Failed to append carriage return.\n",
-			 __func__);
-	return total_len;
-
-}
-
-static ssize_t rmi_fn_01_doze_interval_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct rmi_function *fn = to_rmi_function(dev);
-	struct f01_data *data = fn->data;
-
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-			data->device_control.doze_interval);
-
-}
-
-static ssize_t rmi_fn_01_doze_interval_store(struct device *dev,
-					  struct device_attribute *attr,
-					  const char *buf, size_t count)
-{
-	struct rmi_function *fn = to_rmi_function(dev);
-	struct f01_data *data = fn->data;
-	unsigned long new_value;
-	int retval;
-	u16 ctrl_base_addr;
-
-	retval = strict_strtoul(buf, 10, &new_value);
-	if (retval < 0 || new_value > 255) {
-		dev_err(dev, "%s: Invalid doze interval %s.", __func__, buf);
-		return -EINVAL;
-	}
-
-	retval = mutex_lock_interruptible(&data->control_mutex);
-	if (retval)
-		return retval;
-
-	data->device_control.doze_interval = new_value;
-	ctrl_base_addr = fn->fd.control_base_addr + sizeof(u8) +
-			(sizeof(u8)*(data->num_of_irq_regs));
-	dev_dbg(dev, "doze_interval store address %x, value %d",
-		ctrl_base_addr, data->device_control.doze_interval);
-
-	retval = rmi_write_block(fn->rmi_dev, data->doze_interval_addr,
-			&data->device_control.doze_interval,
-			sizeof(u8));
-	if (retval >= 0)
-		retval = count;
-	else
-		dev_err(dev, "Failed to write doze interval.\n");
-
-	mutex_unlock(&data->control_mutex);
-	return retval;
-}
-
-static ssize_t rmi_fn_01_wakeup_threshold_show(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
-{
-	struct rmi_function *fn = to_rmi_function(dev);
-	struct f01_data *data = fn->data;
-
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-			data->device_control.wakeup_threshold);
-}
-
-static ssize_t rmi_fn_01_wakeup_threshold_store(struct device *dev,
-					  struct device_attribute *attr,
-					  const char *buf, size_t count)
-{
-	struct rmi_function *fn = to_rmi_function(dev);
-	struct f01_data *data = fn->data;
-	unsigned long new_value;
-	int retval;
-
-	retval = strict_strtoul(buf, 10, &new_value);
-	if (retval < 0 || new_value > 255) {
-		dev_err(dev, "%s: Invalid wakeup threshold %s.", __func__, buf);
-		return -EINVAL;
-	}
-
-	retval = mutex_lock_interruptible(&data->control_mutex);
-	if (retval)
-		return retval;
-
-	data->device_control.doze_interval = new_value;
-	retval = rmi_write_block(fn->rmi_dev, data->wakeup_threshold_addr,
-			&data->device_control.wakeup_threshold,
-			sizeof(u8));
-	if (retval >= 0)
-		retval = count;
-	else
-		dev_err(dev, "Failed to write wakeup threshold.\n");
-
-	mutex_unlock(&data->control_mutex);
-	return retval;
-}
-
-static ssize_t rmi_fn_01_doze_holdoff_show(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
-{
-	struct rmi_function *fn = to_rmi_function(dev);
-	struct f01_data *data = fn->data;
-
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-			data->device_control.doze_holdoff);
-
-}
-
-static ssize_t rmi_fn_01_doze_holdoff_store(struct device *dev,
-					  struct device_attribute *attr,
-					  const char *buf, size_t count)
-{
-	struct rmi_function *fn = to_rmi_function(dev);
-	struct f01_data *data = fn->data;
-	unsigned long new_value;
-	int retval;
-
-	retval = strict_strtoul(buf, 10, &new_value);
-	if (retval < 0 || new_value > 255) {
-		dev_err(dev, "%s: Invalid doze holdoff %s.", __func__, buf);
-		return -EINVAL;
-	}
-
-	retval = mutex_lock_interruptible(&data->control_mutex);
-	if (retval)
-		return retval;
-
-	data->device_control.doze_interval = new_value;
-	retval = rmi_write_block(fn->rmi_dev, data->doze_holdoff_addr,
-			&data->device_control.doze_holdoff,
-			sizeof(u8));
-	if (retval >= 0)
-		retval = count;
-	else
-		dev_err(dev, "Failed to write doze holdoff.\n");
-
-	mutex_unlock(&data->control_mutex);
-	return retval;
-}
-
-static ssize_t rmi_fn_01_configured_show(struct device *dev,
-				      struct device_attribute *attr, char *buf)
-{
-	struct rmi_function *fn = to_rmi_function(dev);
-	struct f01_data *data = fn->data;
-	unsigned int value = !!(data->device_control.ctrl0 &
-					RMI_F01_CRTL0_CONFIGURED_BIT);
-
-	return snprintf(buf, PAGE_SIZE, "%d\n", value);
-}
-
-static ssize_t rmi_fn_01_unconfigured_show(struct device *dev,
-				      struct device_attribute *attr, char *buf)
-{
-	struct rmi_function *fn = to_rmi_function(dev);
-	struct f01_data *data = fn->data;
-
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-			RMI_F01_STATUS_UNCONFIGURED(data->device_status));
-}
-
-static ssize_t rmi_fn_01_flashprog_show(struct device *dev,
-				      struct device_attribute *attr, char *buf)
-{
-	struct rmi_function *fn = to_rmi_function(dev);
-	struct f01_data *data = fn->data;
-
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-			RMI_F01_STATUS_BOOTLOADER(data->device_status));
-}
-
-static ssize_t rmi_fn_01_statuscode_show(struct device *dev,
-				      struct device_attribute *attr, char *buf)
-{
-	struct rmi_function *fn = to_rmi_function(dev);
-	struct f01_data *data = fn->data;
-
-	return snprintf(buf, PAGE_SIZE, "0x%02x\n",
-			RMI_F01_STATUS_CODE(data->device_status));
-}
-
-#define RMI_F01_ATTR(_name)			\
-	DEVICE_ATTR(_name, RMI_RW_ATTR,		\
-		    rmi_fn_01_##_name##_show,	\
-		    rmi_fn_01_##_name##_store)
-
-#define RMI_F01_RO_ATTR(_name)			\
-	DEVICE_ATTR(_name, RMI_RO_ATTR,		\
-		    rmi_fn_01_##_name##_show,	\
-		    NULL)
-
-#define RMI_F01_WO_ATTR(_name)			\
-	DEVICE_ATTR(_name, RMI_RO_ATTR,		\
-		    NULL,			\
-		    rmi_fn_01_##_name##_store)
-
-
-static RMI_F01_RO_ATTR(productinfo);
-static RMI_F01_RO_ATTR(productid);
-static RMI_F01_RO_ATTR(manufacturer);
-static RMI_F01_RO_ATTR(datecode);
-
-/* Control register access */
-static RMI_F01_ATTR(sleepmode);
-static RMI_F01_ATTR(nosleep);
-static RMI_F01_ATTR(chargerinput);
-static RMI_F01_ATTR(reportrate);
-
-/*
- * We don't want arbitrary callers changing the interrupt enable mask,
- * so it's read only.
- */
-static RMI_F01_RO_ATTR(interrupt_enable);
-static RMI_F01_ATTR(doze_interval);
-static RMI_F01_ATTR(wakeup_threshold);
-static RMI_F01_ATTR(doze_holdoff);
-
-/*
- * We make 'configured' RO, since the driver uses that to look for
- * resets.  We don't want someone faking us out by changing that
- * bit.
- */
-static RMI_F01_RO_ATTR(configured);
-
-/* Command register access. */
-static RMI_F01_WO_ATTR(reset);
-
-/* Status register access. */
-static RMI_F01_RO_ATTR(unconfigured);
-static RMI_F01_RO_ATTR(flashprog);
-static RMI_F01_RO_ATTR(statuscode);
-
-static struct attribute *rmi_fn_01_attrs[] = {
-	&dev_attr_productinfo.attr,
-	&dev_attr_productid.attr,
-	&dev_attr_manufacturer.attr,
-	&dev_attr_datecode.attr,
-	&dev_attr_sleepmode.attr,
-	&dev_attr_nosleep.attr,
-	&dev_attr_chargerinput.attr,
-	&dev_attr_reportrate.attr,
-	&dev_attr_interrupt_enable.attr,
-	&dev_attr_doze_interval.attr,
-	&dev_attr_wakeup_threshold.attr,
-	&dev_attr_doze_holdoff.attr,
-	&dev_attr_configured.attr,
-	&dev_attr_reset.attr,
-	&dev_attr_unconfigured.attr,
-	&dev_attr_flashprog.attr,
-	&dev_attr_statuscode.attr,
-	NULL
-};
-
-static umode_t rmi_fn_01_attr_visible(struct kobject *kobj,
-				      struct attribute *attr, int n)
-{
-	struct device *dev = kobj_to_dev(kobj);
-	struct rmi_function *fn = to_rmi_function(dev);
-	struct f01_data *data = fn->data;
-	umode_t mode = attr->mode;
-
-	if (attr == &dev_attr_doze_interval.attr) {
-		if (!data->properties.has_lts)
-			mode = 0;
-	} else if (attr == &dev_attr_wakeup_threshold.attr) {
-		if (!data->properties.has_adjustable_doze)
-			mode = 0;
-	} else if (attr == &dev_attr_doze_holdoff.attr) {
-		if (!data->properties.has_adjustable_doze_holdoff)
-			mode = 0;
-	}
-
-	return mode;
-}
-
-static struct attribute_group rmi_fn_01_attr_group = {
-	.is_visible	= rmi_fn_01_attr_visible,
-	.attrs		= rmi_fn_01_attrs,
 };
 
 static int rmi_f01_alloc_memory(struct rmi_function *fn,
@@ -1148,11 +373,6 @@ static int rmi_f01_initialize(struct rmi_function *fn)
 		goto error_exit;
 	}
 
-	error = setup_debugfs(fn);
-	if (error)
-		dev_warn(&fn->dev, "Failed to setup debugfs, error: %d.\n",
-			 error);
-
 	return 0;
 
  error_exit:
@@ -1228,17 +448,12 @@ static int rmi_f01_probe(struct rmi_function *fn)
 	if (error)
 		return error;
 
-	error = sysfs_create_group(&fn->dev.kobj, &rmi_fn_01_attr_group);
-	if (error)
-		return error;
-
 	return 0;
 }
 
 static void rmi_f01_remove(struct rmi_function *fn)
 {
-	teardown_debugfs(fn->data);
-	sysfs_remove_group(&fn->dev.kobj, &rmi_fn_01_attr_group);
+	/* Placeholder for now. */
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index 017c8ff..8984054 100644
--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -10,7 +10,6 @@
 #define FUNCTION_DATA f11_data
 
 #include <linux/kernel.h>
-#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/input.h>
@@ -822,177 +821,6 @@ enum finger_state_values {
 	F11_RESERVED	= 0x03
 };
 
-static ssize_t rmi_f11_rezero_store(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t count)
-{
-	struct rmi_function *fn = to_rmi_function(dev);
-	unsigned int rezero;
-	int error;
-
-	error = kstrtouint(buf, 0, &rezero);
-	if (error)
-		return error;
-
-	if (rezero > 1)
-		return -ERANGE;
-
-	/* Per spec, 0 has no effect, so we skip it entirely. */
-	if (rezero) {
-		/* Command register always reads as 0, so just use a local. */
-		struct f11_2d_commands commands = {
-			.rezero = true,
-		};
-
-		error = rmi_write_block(fn->rmi_dev, fn->fd.command_base_addr,
-					&commands, sizeof(commands));
-		if (error < 0) {
-			dev_err(dev,
-				"%s: failed to issue rezero command, error = %d.",
-				__func__, error);
-			return error;
-		}
-	}
-
-	return count;
-}
-
-static DEVICE_ATTR(rezero, RMI_WO_ATTR, NULL, rmi_f11_rezero_store);
-
-static struct attribute *rmi_f11_attrs[] = {
-	&dev_attr_rezero.attr,
-	NULL
-};
-
-static struct attribute_group rmi_f11_attr_group = {
-	.attrs = rmi_f11_attrs,
-};
-
-#ifdef CONFIG_RMI4_DEBUG
-static void rmi_f11_setup_sensor_debugfs(struct f11_2d_sensor *sensor)
-{
-	struct rmi_function *fn = sensor->fn;
-	struct dentry *sensor_root;
-	char dirname[sizeof("sensorNNN")];
-
-	if (!fn->debugfs_root)
-		return;
-
-	snprintf(dirname, sizeof(dirname), "input%3u", sensor->sensor_index);
-	sensor_root = debugfs_create_dir(dirname, fn->debugfs_root);
-	if (!sensor_root) {
-		dev_warn(&fn->dev,
-			 "Failed to create debugfs directory %s for sensor %d\n",
-			 dirname, sensor->sensor_index);
-		return;
-	}
-
-	if (!debugfs_create_bool("type_a", RMI_RW_ATTR, sensor_root,
-				 &sensor->type_a))
-		dev_warn(&fn->dev,
-			 "Failed to create debugfs type_a for sensor %d.\n",
-			 sensor->sensor_index);
-
-	if (!debugfs_create_u16("max_x", RMI_RW_ATTR, sensor_root,
-				&sensor->max_x))
-		dev_warn(&fn->dev,
-			 "Failed to create debugfs max_x for sensor %d.\n",
-			 sensor->sensor_index);
-
-	if (!debugfs_create_u16("max_xy", RMI_RW_ATTR, sensor_root,
-				&sensor->max_y))
-		dev_warn(&fn->dev,
-			 "Failed to create debugfs max_y for sensor %d.\n",
-			 sensor->sensor_index);
-
-	if (!debugfs_create_bool("flip_x", RMI_RW_ATTR, sensor_root,
-				 &sensor->axis_align.flip_x))
-		dev_warn(&fn->dev,
-			 "Failed to create debugfs flip_x for sensor %d.\n",
-			 sensor->sensor_index);
-
-	if (!debugfs_create_bool("flip_y", RMI_RW_ATTR, sensor_root,
-				 &sensor->axis_align.flip_y))
-		dev_warn(&fn->dev,
-			 "Failed to create debugfs flip_y for sensor %d.\n",
-			 sensor->sensor_index);
-
-	if (!debugfs_create_u16("clip_x_low", RMI_RW_ATTR, sensor_root,
-				&sensor->axis_align.clip_x_low))
-		dev_warn(&fn->dev,
-			 "Failed to create debugfs clip_x_low for sensor %d.\n",
-			 sensor->sensor_index);
-
-	if (!debugfs_create_u16("clip_x_high", RMI_RW_ATTR, sensor_root,
-				&sensor->axis_align.clip_x_high))
-		dev_warn(&fn->dev,
-			 "Failed to create debugfs clip_x_high for sensor %d.\n",
-			 sensor->sensor_index);
-
-	if (!debugfs_create_u16("clip_y_low", RMI_RW_ATTR, sensor_root,
-				 &sensor->axis_align.clip_y_low))
-		dev_warn(&fn->dev,
-			 "Failed to create debugfs clip_y_low for sensor %d.\n",
-			 sensor->sensor_index);
-
-	if (!debugfs_create_u16("clip_y_high", RMI_RW_ATTR, sensor_root,
-				 &sensor->axis_align.clip_y_high))
-		dev_warn(&fn->dev,
-			 "Failed to create debugfs clip_y_high for sensor %d.\n",
-			 sensor->sensor_index);
-
-	if (!debugfs_create_u8("delta_x_threshold", RMI_RW_ATTR, sensor_root,
-				&sensor->axis_align.delta_x_threshold))
-		dev_warn(&fn->dev,
-			 "Failed to create debugfs delta_x_threshold for sensor %d.\n",
-			 sensor->sensor_index);
-
-	if (!debugfs_create_u8("delta_y_threshold", RMI_RW_ATTR, sensor_root,
-				&sensor->axis_align.delta_y_threshold))
-		dev_warn(&fn->dev,
-			 "Failed to create debugfs delta_y_threshold for sensor %d.\n",
-			 sensor->sensor_index);
-
-	if (!debugfs_create_u16("offset_x", RMI_RW_ATTR, sensor_root,
-				 &sensor->axis_align.offset_x))
-		dev_warn(&fn->dev,
-			 "Failed to create debugfs offset_x for sensor %d.\n",
-			 sensor->sensor_index);
-
-	if (!debugfs_create_u16("offset_x", RMI_RW_ATTR, sensor_root,
-				 &sensor->axis_align.offset_x))
-		dev_warn(&fn->dev,
-			 "Failed to create debugfs offset_y for sensor %d.\n",
-			 sensor->sensor_index);
-
-	if (!debugfs_create_bool("swap", RMI_RW_ATTR, sensor_root,
-				 &sensor->axis_align.swap_axes))
-		dev_warn(&fn->dev,
-			 "Failed to create debugfs swap for sensor %d.\n",
-			 sensor->sensor_index);
-}
-
-static void rmi_f11_setup_debugfs(struct rmi_function *fn)
-{
-	struct f11_data *f11 = fn->data;
-
-	if (fn->debugfs_root)
-		if (!debugfs_create_u16("rezero_wait", RMI_RW_ATTR,
-					fn->debugfs_root,
-					&f11->rezero_wait_ms))
-			dev_warn(&fn->dev,
-				 "Failed to create debugfs rezero_wait.\n");
-}
-#else
-static inline void rmi_f11_setup_sensor_debugfs(struct f11_2d_sensor *sensor)
-{
-}
-static inline void rmi_f11_setup_debugfs(struct rmi_function *fn)
-{
-}
-#endif
-/* End adding debugfs */
-
 /** F11_INACCURATE state is overloaded to indicate pen present. */
 #define F11_PEN F11_INACCURATE
 
@@ -1886,12 +1714,8 @@ static int rmi_f11_initialize(struct rmi_function *fn)
 				dev_warn(&fn->dev, "Failed to write to delta_y_threshold %d. Code: %d.\n",
 					i, rc);
 		}
-
-		rmi_f11_setup_sensor_debugfs(sensor);
 	}
 
-	rmi_f11_setup_debugfs(fn);
-
 	mutex_init(&f11->dev_controls_mutex);
 	return 0;
 }
@@ -2112,18 +1936,11 @@ static int rmi_f11_probe(struct rmi_function *fn)
 	if (error)
 		return error;
 
-	error = sysfs_create_group(&fn->dev.kobj, &rmi_f11_attr_group);
-	if (error)
-		return error;
-
 	return 0;
 }
 
 static void rmi_f11_remove(struct rmi_function *fn)
 {
-	debugfs_remove_recursive(fn->debugfs_root);
-	sysfs_remove_group(&fn->dev.kobj, &rmi_f11_attr_group);
-
 	rmi_f11_free_devices(fn);
 }
 
diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
index f3bef04..62351c4 100644
--- a/drivers/input/rmi4/rmi_i2c.c
+++ b/drivers/input/rmi4/rmi_i2c.c
@@ -8,7 +8,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
@@ -61,8 +60,9 @@ static int setup_debugfs(struct rmi_device *rmi_dev, struct rmi_i2c_data *data)
 	if (!rmi_dev->debugfs_root)
 		return -ENODEV;
 
-	data->debugfs_comms = debugfs_create_bool("comms_debug", RMI_RW_ATTR,
-			rmi_dev->debugfs_root, &data->comms_debug);
+	data->debugfs_comms = debugfs_create_bool("comms_debug",
+			(S_IRUGO | S_IWUGO), rmi_dev->debugfs_root,
+			&data->comms_debug);
 	if (!data->debugfs_comms || IS_ERR(data->debugfs_comms)) {
 		dev_warn(&rmi_dev->dev,
 			 "Failed to create debugfs comms_debug.\n");
