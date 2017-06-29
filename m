From: Wang Yafei <wangyafei@goodix.com>
Subject: [PATCH v5 2/2]Input: Add driver for Goodix GTx5 series touchscreen
Date: Thu, 29 Jun 2017 09:57:26 +0800
Message-ID: <20170629015726.GA4253@andrew-dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from Mailgw01.goodix.com ([58.250.26.195]:2579 "EHLO
        barracuda.goodix.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751548AbdF2B5f (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 28 Jun 2017 21:57:35 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, andrew@goodix.com, mouse@goodix.com

This driver is for Goodix GTx5 series touchscreen controllers
such as GT8589, GT7589. This driver designed with hierarchical structure,
for that can be modified to support subsequent controllers easily.
Some zones of the touchscreen can be set to buttons(according to the
hardware). That is why it handles button and multitouch events.

A brief description of driver structure
- Core Layer: This layer responsible for basic input events report,
  GPIO pinctrl, Interrupt, Power resources manager and sub-modules manager.
- Hardware Layer: This layer responsible for controllers initialization,
  irq handle as well as bus read/write.
- External Module Layer: This layer used for support more features
  such as firmware update, debug tools and gesture wakeup.

Signed-off-by: Wang Yafei <wangyafei@goodix.com>
---
Changes in v2:
- replace touchscreen properties according to the description in
  Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
  - Droped all compat stuff for older kernels
  - Removed Android stuff (EARLY_SUSPEND, CONFIG_FB)
  - Use device_property_read_*  get device properties
  - Use get-unaligned_*() API
  - Use dev_err() dev_dbg() for logging
  - Remove pinctrl functions
  - Remove some unused functions

Changes in v3:
  - Modify Kconfig

Changes in v4:
  - Unify functions name and file name
  - Recheck code spell and style problems
  - Modify code comments
  - Remove firmware update and debug tool modules

Changes in v5:
  - Modify DT related functions
  - Remove irq-gpio
---
 drivers/input/touchscreen/Kconfig     |   12 +
 drivers/input/touchscreen/Makefile    |    1 +
 drivers/input/touchscreen/gtx5_core.c | 1259 +++++++++++++++++++++++++++++++++
 drivers/input/touchscreen/gtx5_core.h |  398 +++++++++++
 drivers/input/touchscreen/gtx5_i2c.c  |  802 +++++++++++++++++++++
 5 files changed, 2472 insertions(+)
 create mode 100644 drivers/input/touchscreen/gtx5_core.c
 create mode 100644 drivers/input/touchscreen/gtx5_core.h
 create mode 100644 drivers/input/touchscreen/gtx5_i2c.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index cf26ca4..e879af8 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -344,6 +344,18 @@ config TOUCHSCREEN_GOODIX
 	  To compile this driver as a module, choose M here: the
 	  module will be called goodix.
 
+config TOUCHSCREEN_GTX5
+	tristate "Goodix GTx5 touchscreen"
+	depends on I2C && OF
+	depends on GPIOLIB
+	help
+	  Say Y here if you have a touchscreen using Goodix GTx5 series
+	  controller.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here
+
 config TOUCHSCREEN_ILI210X
 	tristate "Ilitek ILI210X based touchscreen"
 	depends on I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 18e4769..00643d4 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_TOUCHSCREEN_EGALAX)	+= egalax_ts.o
 obj-$(CONFIG_TOUCHSCREEN_EGALAX_SERIAL)	+= egalax_ts_serial.o
 obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+= goodix.o
+obj-$(CONFIG_TOUCHSCREEN_GTX5)		+= gtx5_i2c.o gtx5_core.o
 obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+= ili210x.o
 obj-$(CONFIG_TOUCHSCREEN_IMX6UL_TSC)	+= imx6ul_tsc.o
 obj-$(CONFIG_TOUCHSCREEN_INEXIO)	+= inexio.o
diff --git a/drivers/input/touchscreen/gtx5_core.c b/drivers/input/touchscreen/gtx5_core.c
new file mode 100644
index 0000000..72a58ce
--- /dev/null
+++ b/drivers/input/touchscreen/gtx5_core.c
@@ -0,0 +1,1259 @@
+/*
+ * Goodix GTx5 Touchscreen Driver
+ * Core layer of gtx5 touchscreen driver.
+ *
+ * Copyright (C) 2015 - 2016 Goodix, Inc.
+ *
+ * Authors:  Wang Yafei <wangyafei@goodix.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; version 2 of the License.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/of_platform.h>
+#include <linux/completion.h>
+#include <linux/regulator/consumer.h>
+#include <linux/input/mt.h>
+#include "gtx5_core.h"
+
+#define INPUT_TYPE_B_PROTOCOL
+
+#define GOOIDX_INPUT_PHYS	"gtx5_ts/input0"
+#define PINCTRL_STATE_ACTIVE    "pmx_ts_active"
+#define PINCTRL_STATE_SUSPEND   "pmx_ts_suspend"
+
+/*
+ * struct gtx5_modules - external modules container
+ * @head: external modules list
+ * @initialized: whether this struct is initialized
+ * @mutex: module mutex lock
+ * @count: current number of registered external module
+ * @wq: workqueue for module register work
+ * @core_exit: if gtx5 touch core exit, then no
+ *   registration is allowed.
+ * @core_data: core_data pointer
+ */
+struct gtx5_modules {
+	struct list_head head;
+	bool initialized;
+	struct mutex mutex;
+	unsigned int count;
+	struct workqueue_struct *wq;
+	bool core_exit;
+	struct completion core_comp;
+	struct gtx5_ts_core *core_data;
+};
+
+static struct gtx5_modules gtx5_modules;
+
+static void  __do_register_ext_module(struct work_struct *work)
+{
+	struct gtx5_ext_module *module =
+			container_of(work, struct gtx5_ext_module, work);
+	struct gtx5_ext_module *ext_module;
+	struct list_head *insert_point = &gtx5_modules.head;
+
+	/* waiting for core layer */
+	if (!wait_for_completion_timeout(&gtx5_modules.core_comp, 5 * HZ))
+		return;
+
+	/* driver probe failed */
+	if (gtx5_modules.core_exit)
+		return;
+
+	/* priority level *must* be set */
+	if (module->priority == EXTMOD_PRIO_RESERVED)
+		return;
+
+	mutex_lock(&gtx5_modules.mutex);
+	if (!list_empty(&gtx5_modules.head)) {
+		list_for_each_entry(ext_module, &gtx5_modules.head, list) {
+			if (ext_module == module) {
+				mutex_unlock(&gtx5_modules.mutex);
+				return;
+			}
+		}
+
+		list_for_each_entry(ext_module, &gtx5_modules.head, list) {
+			/* small value of priority have higher priority level */
+			if (ext_module->priority >= module->priority) {
+				insert_point = &ext_module->list;
+				break;
+			}
+		}
+	}
+
+	if (module->funcs && module->funcs->init) {
+		if (module->funcs->init(gtx5_modules.core_data,
+					module) < 0) {
+			mutex_unlock(&gtx5_modules.mutex);
+			return;
+		}
+	}
+
+	list_add(&module->list, insert_point->prev);
+	gtx5_modules.count++;
+	mutex_unlock(&gtx5_modules.mutex);
+}
+
+/**
+ * gtx5_register_ext_module - interface for external module
+ * to register into touch core modules structure
+ */
+int gtx5_register_ext_module(struct gtx5_ext_module *module)
+{
+	if (!module)
+		return -EINVAL;
+
+	if (!gtx5_modules.initialized) {
+		gtx5_modules.initialized = true;
+		INIT_LIST_HEAD(&gtx5_modules.head);
+		mutex_init(&gtx5_modules.mutex);
+		init_completion(&gtx5_modules.core_comp);
+	}
+
+	if (gtx5_modules.core_exit)
+		return -EFAULT;
+
+	INIT_WORK(&module->work, __do_register_ext_module);
+	schedule_work(&module->work);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gtx5_register_ext_module);
+
+/**
+ * gtx5_unregister_ext_module - interface for external module
+ * to unregister external modules
+ */
+int gtx5_unregister_ext_module(struct gtx5_ext_module *module)
+{
+	struct gtx5_ext_module *ext_module;
+	bool found = false;
+
+	if (!module)
+		return -EINVAL;
+
+	if (!gtx5_modules.initialized)
+		return -EINVAL;
+
+	if (!gtx5_modules.core_data)
+		return -ENODEV;
+
+	mutex_lock(&gtx5_modules.mutex);
+	if (!list_empty(&gtx5_modules.head)) {
+		list_for_each_entry(ext_module, &gtx5_modules.head, list) {
+			if (ext_module == module) {
+				found = true;
+				break;
+			}
+		}
+	} else {
+		mutex_unlock(&gtx5_modules.mutex);
+		return -EFAULT;
+	}
+
+	if (!found) {
+		mutex_unlock(&gtx5_modules.mutex);
+		return -EFAULT;
+	}
+
+	list_del(&module->list);
+	mutex_unlock(&gtx5_modules.mutex);
+
+	if (module->funcs && module->funcs->exit)
+		module->funcs->exit(gtx5_modules.core_data, module);
+	gtx5_modules.count--;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gtx5_unregister_ext_module);
+
+static void gtx5_ext_sysfs_release(struct kobject *kobj)
+{
+	return;
+}
+
+#define to_ext_module(kobj) container_of(kobj,\
+				struct gtx5_ext_module, kobj)
+#define to_ext_attr(attr) container_of(attr,\
+				struct gtx5_ext_attribute, attr)
+
+static ssize_t gtx5_ext_sysfs_show(struct kobject *kobj,
+				   struct attribute *attr,
+				   char *buf)
+{
+	struct gtx5_ext_module *module = to_ext_module(kobj);
+	struct gtx5_ext_attribute *ext_attr = to_ext_attr(attr);
+
+	if (ext_attr->show)
+		return ext_attr->show(module, buf);
+
+	return -EIO;
+}
+
+static ssize_t gtx5_ext_sysfs_store(struct kobject *kobj,
+				    struct attribute *attr,
+				    const char *buf,
+				    size_t count)
+{
+	struct gtx5_ext_module *module = to_ext_module(kobj);
+	struct gtx5_ext_attribute *ext_attr = to_ext_attr(attr);
+
+	if (ext_attr->store)
+		return ext_attr->store(module, buf, count);
+
+	return -EIO;
+}
+
+static const struct sysfs_ops gtx5_ext_ops = {
+	.show = gtx5_ext_sysfs_show,
+	.store = gtx5_ext_sysfs_store
+};
+
+static struct kobj_type gtx5_ext_ktype = {
+	.release = gtx5_ext_sysfs_release,
+	.sysfs_ops = &gtx5_ext_ops,
+};
+
+struct kobj_type *gtx5_get_default_ktype(void)
+{
+	return &gtx5_ext_ktype;
+}
+EXPORT_SYMBOL_GPL(gtx5_get_default_ktype);
+
+struct kobject *gtx5_get_default_kobj(void)
+{
+	struct kobject *kobj = NULL;
+
+	if (gtx5_modules.core_data &&
+	    gtx5_modules.core_data->pdev)
+		kobj = &gtx5_modules.core_data->pdev->dev.kobj;
+	return kobj;
+}
+EXPORT_SYMBOL_GPL(gtx5_get_default_kobj);
+
+/* show external module information */
+static ssize_t gtx5_ts_extmod_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct gtx5_ext_module *module;
+	size_t offset = 0;
+	int r;
+
+	mutex_lock(&gtx5_modules.mutex);
+	if (!list_empty(&gtx5_modules.head)) {
+		list_for_each_entry(module, &gtx5_modules.head, list) {
+			r = snprintf(&buf[offset], PAGE_SIZE,
+				     "priority:%u module:%s\n",
+				     module->priority, module->name);
+			if (r < 0) {
+				mutex_unlock(&gtx5_modules.mutex);
+				return -EINVAL;
+			}
+			offset += r;
+		}
+	}
+
+	mutex_unlock(&gtx5_modules.mutex);
+	return offset;
+}
+
+/* show driver information */
+static ssize_t gtx5_ts_driver_info_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "DriverVersion:%s\n",
+			GTX5_DRIVER_VERSION);
+}
+
+/* show chip information */
+static ssize_t gtx5_ts_chip_info_show(struct device  *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct gtx5_ts_core *core_data = dev_get_drvdata(dev);
+	struct gtx5_ts_device *ts_dev = core_data->ts_dev;
+	struct gtx5_ts_version chip_ver;
+	int r, cnt = 0;
+
+	cnt += snprintf(buf, PAGE_SIZE,
+			"TouchDeviceName:%s\n", ts_dev->name);
+	if (ts_dev->hw_ops->read_version) {
+		r = ts_dev->hw_ops->read_version(ts_dev, &chip_ver);
+		if (!r && chip_ver.valid) {
+			cnt += snprintf(&buf[cnt], PAGE_SIZE,
+					"PID:%s\nVID:%04x\nPanelID:%02x\n",
+					chip_ver.pid, chip_ver.vid,
+					chip_ver.panel_id);
+		}
+	}
+
+	return cnt;
+}
+
+static ssize_t gtx5_ts_config_data_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct gtx5_ts_core *core_data = dev_get_drvdata(dev);
+	struct gtx5_ts_device *ts_dev = core_data->ts_dev;
+	struct gtx5_ts_config *ncfg = ts_dev->normal_cfg;
+	u8 *data;
+	int i, r, offset = 0;
+
+	if (ncfg && ncfg->initialized && ncfg->length < PAGE_SIZE) {
+		data = kmalloc(ncfg->length, GFP_KERNEL);
+		if (!data)
+			return -ENOMEM;
+
+		r = ts_dev->hw_ops->read(ts_dev, ncfg->reg_base,
+				&data[0], ncfg->length);
+		if (r < 0) {
+			kfree(data);
+			return -EINVAL;
+		}
+
+		for (i = 0; i < ncfg->length; i++) {
+			if (i != 0 && i % 20 == 0)
+				buf[offset++] = '\n';
+			offset += snprintf(&buf[offset], PAGE_SIZE - offset,
+					   "%02x ", data[i]);
+		}
+		buf[offset++] = '\n';
+		buf[offset++] = '\0';
+		kfree(data);
+		return offset;
+	}
+
+	return -EINVAL;
+}
+
+static ssize_t gtx5_ts_reset_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf,
+				   size_t count)
+{
+	struct gtx5_ts_core *core_data =
+		dev_get_drvdata(dev);
+	struct gtx5_ts_device *ts_dev = core_data->ts_dev;
+	int en;
+
+	if (kstrtoint(buf, 10, &en))
+		return -EINVAL;
+
+	if (en != 1)
+		return -EINVAL;
+
+	if (ts_dev->hw_ops->reset)
+		ts_dev->hw_ops->reset(ts_dev);
+
+	return count;
+}
+
+static ssize_t gtx5_ts_irq_info_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct gtx5_ts_core *core_data = dev_get_drvdata(dev);
+	struct irq_desc *desc;
+	size_t offset = 0;
+	int r;
+
+	r = snprintf(&buf[offset], PAGE_SIZE, "irq:%u\n",
+		     core_data->irq);
+	if (r < 0)
+		return -EINVAL;
+
+	offset += r;
+	r = snprintf(&buf[offset], PAGE_SIZE - offset, "state:%s\n",
+		     atomic_read(&core_data->irq_enabled) ?
+		     "enabled" : "disabled");
+	if (r < 0)
+		return -EINVAL;
+
+	desc = irq_to_desc(core_data->irq);
+	offset += r;
+	r = snprintf(&buf[offset], PAGE_SIZE - offset, "disable-depth:%d\n",
+		     desc->depth);
+	if (r < 0)
+		return -EINVAL;
+
+	offset += r;
+	r = snprintf(&buf[offset], PAGE_SIZE - offset, "trigger-count:%zu\n",
+		     core_data->irq_trig_cnt);
+	if (r < 0)
+		return -EINVAL;
+
+	offset += r;
+	r = snprintf(&buf[offset], PAGE_SIZE - offset,
+		     "echo 0/1 > irq_info to disable/enable irq");
+	if (r < 0)
+		return -EINVAL;
+
+	offset += r;
+	return offset;
+}
+
+/* enable/disable irq */
+static ssize_t gtx5_ts_irq_info_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf,
+				      size_t count)
+{
+	struct gtx5_ts_core *core_data =
+		dev_get_drvdata(dev);
+	int en;
+
+	if (kstrtoint(buf, 10, &en))
+		return -EINVAL;
+
+	gtx5_ts_irq_enable(core_data, en);
+	return count;
+}
+
+static DEVICE_ATTR(extmod_info, 0444, gtx5_ts_extmod_show, NULL);
+static DEVICE_ATTR(driver_info, 0444, gtx5_ts_driver_info_show, NULL);
+static DEVICE_ATTR(chip_info, 0444, gtx5_ts_chip_info_show, NULL);
+static DEVICE_ATTR(config_data, 0444, gtx5_ts_config_data_show, NULL);
+static DEVICE_ATTR(reset, 0200, NULL, gtx5_ts_reset_store);
+static DEVICE_ATTR(irq_info, 0644,
+		   gtx5_ts_irq_info_show, gtx5_ts_irq_info_store);
+
+static struct attribute *sysfs_attrs[] = {
+	&dev_attr_extmod_info.attr,
+	&dev_attr_driver_info.attr,
+	&dev_attr_chip_info.attr,
+	&dev_attr_config_data.attr,
+	&dev_attr_reset.attr,
+	&dev_attr_irq_info.attr,
+	NULL,
+};
+
+static const struct attribute_group sysfs_group = {
+	.attrs = sysfs_attrs,
+};
+
+static int gtx5_ts_sysfs_init(struct gtx5_ts_core *core_data)
+{
+	return sysfs_create_group(&core_data->pdev->dev.kobj, &sysfs_group);
+}
+
+static void gtx5_ts_sysfs_exit(struct gtx5_ts_core *core_data)
+{
+	sysfs_remove_group(&core_data->pdev->dev.kobj, &sysfs_group);
+}
+
+/* event notifier */
+static BLOCKING_NOTIFIER_HEAD(ts_notifier_list);
+/**
+ * gtx5_ts_register_client - register a client notifier
+ * @nb: notifier block to callback on events
+ *  see enum ts_notify_event in gtx5_ts_core.h
+ */
+int gtx5_ts_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&ts_notifier_list, nb);
+}
+EXPORT_SYMBOL(gtx5_ts_register_notifier);
+
+/**
+ * gtx5_ts_unregister_client - unregister a client notifier
+ * @nb: notifier block to callback on events
+ *	see enum ts_notify_event in gtx5_ts_core.h
+ */
+int gtx5_ts_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&ts_notifier_list, nb);
+}
+EXPORT_SYMBOL(gtx5_ts_unregister_notifier);
+
+/**
+ * gtx5_ts_blocking_notify - notify clients of certain events
+ *	see enum ts_notify_event in gtx5_ts_core.h
+ */
+int gtx5_ts_blocking_notify(enum ts_notify_event evt, void *v)
+{
+	return blocking_notifier_call_chain(&ts_notifier_list,
+			(unsigned long)evt, v);
+}
+EXPORT_SYMBOL_GPL(gtx5_ts_blocking_notify);
+
+/**
+ * gtx5_ts_input_report - report touch event to input subsystem
+ *
+ * @dev: input device pointer
+ * @touch_data: touch data pointer
+ * return: 0 ok, <0 failed
+ */
+static int gtx5_ts_input_report(struct input_dev *dev,
+				struct gtx5_touch_data *touch_data)
+{
+	struct gtx5_ts_coords *coords = &touch_data->coords[0];
+	struct gtx5_ts_core *core_data = input_get_drvdata(dev);
+	struct gtx5_ts_board_data *ts_bdata = board_data(core_data);
+	unsigned int touch_num = touch_data->touch_num, x, y;
+	static u16 pre_fin;
+	int i, id;
+
+	/* report touch-key */
+	if (unlikely(touch_data->key_value)) {
+		for (i = 0; i < ts_bdata->panel_max_key; i++) {
+			input_report_key(dev, ts_bdata->panel_key_map[i],
+					 touch_data->key_value & (1 << i));
+		}
+	}
+
+	/* first touch down and last touch up condition */
+	if (touch_num != 0 && pre_fin == 0x0000) {
+		/* first touch down event */
+		input_report_key(dev, BTN_TOUCH, 1);
+		input_report_key(dev, BTN_TOOL_FINGER, 1);
+	} else if (touch_num == 0 && pre_fin != 0x0000) {
+		/* no finger exist */
+		input_report_key(dev, BTN_TOUCH, 0);
+		input_report_key(dev, BTN_TOOL_FINGER, 0);
+	} else if (touch_num == 0 && pre_fin == 0x0000) {
+		return 0;
+	}
+
+	/* report abs */
+	id = coords->id;
+	for (i = 0; i < ts_bdata->panel_max_id; i++) {
+		if (touch_num && i == id) {
+			/* this is a valid touch down event */
+#ifdef INPUT_TYPE_B_PROTOCOL
+			input_mt_slot(dev, id);
+			input_mt_report_slot_state(dev, MT_TOOL_FINGER, true);
+#else
+			input_report_abs(dev, ABS_MT_TRACKING_ID, id);
+#endif
+			if (unlikely(ts_bdata->swap_axis)) {
+				x = coords->y;
+				y = coords->x;
+			} else {
+				x = coords->x;
+				y = coords->y;
+			}
+			input_report_abs(dev, ABS_MT_POSITION_X, x);
+			input_report_abs(dev, ABS_MT_POSITION_Y, y);
+			input_report_abs(dev, ABS_MT_TOUCH_MAJOR, coords->w);
+			pre_fin |= 1 << i;
+			id = (++coords)->id;
+#ifndef INPUT_TYPE_B_PROTOCOL
+			input_mt_sync(dev);
+#endif
+		} else {
+			if (pre_fin & (1 << i)) {/* release touch */
+#ifdef INPUT_TYPE_B_PROTOCOL
+				input_mt_slot(dev, i);
+				input_mt_report_slot_state(dev, MT_TOOL_FINGER,
+							   false);
+#endif
+				pre_fin &= ~(1 << i);
+			}
+		}
+	}
+
+#ifndef INPUT_TYPE_B_PROTOCOL
+	if (!pre_fin)
+		input_mt_sync(dev);
+#endif
+	input_sync(dev);
+	return 0;
+}
+
+static irqreturn_t gtx5_ts_threadirq_func(int irq, void *data)
+{
+	struct gtx5_ts_core *core_data = data;
+	struct gtx5_ts_device *ts_dev =  core_data->ts_dev;
+	struct gtx5_ext_module *ext_module;
+	struct gtx5_ts_event *ts_event = &core_data->ts_event;
+	int r;
+
+	core_data->irq_trig_cnt++;
+	/* inform external module */
+	list_for_each_entry(ext_module, &gtx5_modules.head, list) {
+		if (!ext_module->funcs->irq_event)
+			continue;
+		r = ext_module->funcs->irq_event(core_data, ext_module);
+		if (r == EVT_CANCEL_IRQEVT)
+			return IRQ_HANDLED;
+	}
+
+	/* read touch data from touch device */
+	r = ts_dev->hw_ops->event_handler(ts_dev, ts_event);
+	if (likely(r >= 0)) {
+		if (ts_event->event_type == EVENT_TOUCH) {
+			/* report touch event */
+			gtx5_ts_input_report(core_data->input_dev,
+					     &ts_event->event_data.touch_data);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * gtx5_ts_init_irq - Request interrupt line from system
+ * @core_data: pointer to touch core data
+ */
+static int gtx5_ts_irq_setup(struct gtx5_ts_core *core_data)
+{
+	const struct gtx5_ts_board_data *ts_bdata = board_data(core_data);
+	const struct device *dev = &core_data->pdev->dev;
+	int r;
+
+	core_data->irq = ts_bdata->irq;
+	dev_info(dev, "IRQ:%u,flags:%d\n",
+		 core_data->irq, (int)ts_bdata->irq_flags);
+	r = devm_request_threaded_irq(&core_data->pdev->dev,
+				      core_data->irq, NULL,
+				      gtx5_ts_threadirq_func,
+				      ts_bdata->irq_flags | IRQF_ONESHOT,
+				      GTX5_CORE_DRIVER_NAME,
+				      core_data);
+	if (r < 0)
+		dev_err(dev, "Failed to request threaded irq:%d\n", r);
+	else
+		atomic_set(&core_data->irq_enabled, 1);
+
+	return r;
+}
+
+void gtx5_ts_irq_enable(struct gtx5_ts_core *core_data, bool enable)
+{
+	const struct device *dev = &core_data->pdev->dev;
+
+	if (enable) {
+		if (!atomic_cmpxchg(&core_data->irq_enabled, 0, 1)) {
+			enable_irq(core_data->irq);
+			dev_dbg(dev, "Irq enabled\n");
+		}
+	} else {
+		if (atomic_cmpxchg(&core_data->irq_enabled, 1, 0)) {
+			disable_irq(core_data->irq);
+			dev_dbg(dev, "Irq disabled\n");
+		}
+	}
+}
+
+/**
+ * gtx5_ts_power_init - Try get regulator for touch device
+ */
+static int gtx5_ts_power_init(struct gtx5_ts_core *core_data)
+{
+	struct gtx5_ts_board_data *ts_bdata;
+	struct device *dev = NULL;
+
+	dev =  core_data->ts_dev->dev;
+	ts_bdata = board_data(core_data);
+
+	if (ts_bdata->avdd_name) {
+		core_data->avdd = devm_regulator_get(dev, ts_bdata->avdd_name);
+		if (IS_ERR_OR_NULL(core_data->avdd)) {
+			core_data->avdd = NULL;
+			return -ENOENT;
+		}
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * gtx5_ts_power_on - Turn the power on if we can control it
+ */
+static int gtx5_ts_power_on(struct gtx5_ts_core *core_data)
+{
+	const struct device *dev = &core_data->pdev->dev;
+	int r;
+
+	dev_info(dev, "Device power on\n");
+	if (core_data->power_on)
+		return 0;
+
+	if (core_data->avdd) {
+		r = regulator_enable(core_data->avdd);
+		if (!r) {
+			/* need delay 13ms after power on */
+			usleep_range(13000, 15000);
+		} else {
+			dev_err(dev, "Failed to enable analog power:%d\n", r);
+			core_data->power_on = 0;
+			return r;
+		}
+	}
+
+	core_data->power_on = 1;
+	return 0;
+}
+
+static int gtx5_ts_power_off(struct gtx5_ts_core *core_data)
+{
+	const struct device *dev = &core_data->pdev->dev;
+	int r;
+
+	dev_info(dev, "Device power off\n");
+	if (!core_data->power_on)
+		return 0;
+
+	if (core_data->avdd) {
+		r = regulator_disable(core_data->avdd);
+		if (r) {
+			dev_err(dev, "Failed to disable analog power:%d\n", r);
+			return r;
+		}
+	}
+
+	core_data->power_on = 0;
+	return 0;
+}
+
+static void gtx5_ts_gpio_setup(struct gtx5_ts_core *core_data)
+{
+	struct gtx5_ts_board_data *ts_bdata = board_data(core_data);
+	struct gtx5_ts_device *ts_dev = core_data->ts_dev;
+	const struct device *dev = &core_data->pdev->dev;
+
+	ts_bdata->reset_gpiod = devm_gpiod_get_optional(ts_dev->dev,
+							"reset",
+							GPIOD_OUT_LOW);
+	if (!ts_bdata->reset_gpiod)
+		dev_info(dev, "No reset gpio found\n");
+}
+
+static void gtx5_ts_set_input_params(struct input_dev *input_dev,
+				     struct gtx5_ts_board_data *ts_bdata)
+{
+	int i;
+
+	if (ts_bdata->swap_axis)
+		swap(ts_bdata->panel_max_x, ts_bdata->panel_max_y);
+
+	input_set_abs_params(input_dev, ABS_MT_TRACKING_ID,
+			     0, ts_bdata->panel_max_id, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
+			     0, ts_bdata->panel_max_x, 0, 0);
+
+	input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
+			     0, ts_bdata->panel_max_y, 0, 0);
+
+	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
+			     0, ts_bdata->panel_max_w, 0, 0);
+	if (ts_bdata->panel_max_key) {
+		for (i = 0; i < ts_bdata->panel_max_key; i++)
+			input_set_capability(input_dev, EV_KEY,
+					     ts_bdata->panel_key_map[i]);
+	}
+}
+
+static int gtx5_ts_input_dev_config(struct gtx5_ts_core *core_data)
+{
+	struct gtx5_ts_board_data *ts_bdata = board_data(core_data);
+	struct device *dev = &core_data->pdev->dev;
+	struct input_dev *input_dev = NULL;
+	int r;
+
+	input_dev = devm_input_allocate_device(dev);
+	if (!input_dev) {
+		dev_err(dev, "Failed to allocated input device\n");
+		return -ENOMEM;
+	}
+
+	core_data->input_dev = input_dev;
+	input_set_drvdata(input_dev, core_data);
+
+	input_dev->name = GTX5_CORE_DRIVER_NAME;
+	input_dev->phys = GOOIDX_INPUT_PHYS;
+	input_dev->id.product = 0xDEAD;
+	input_dev->id.vendor = 0xBEEF;
+	input_dev->id.version = 10427;
+
+	__set_bit(EV_SYN, input_dev->evbit);
+	__set_bit(EV_KEY, input_dev->evbit);
+	__set_bit(EV_ABS, input_dev->evbit);
+	__set_bit(BTN_TOUCH, input_dev->keybit);
+	__set_bit(BTN_TOOL_FINGER, input_dev->keybit);
+
+#ifdef INPUT_PROP_DIRECT
+	__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
+#endif
+
+	/* set input parameters */
+	gtx5_ts_set_input_params(input_dev, ts_bdata);
+
+#ifdef INPUT_TYPE_B_PROTOCOL
+	input_mt_init_slots(input_dev, ts_bdata->panel_max_id,
+			    INPUT_MT_DIRECT);
+#endif
+
+	input_set_capability(input_dev, EV_KEY, KEY_POWER);
+	r = input_register_device(input_dev);
+	if (r < 0) {
+		dev_err(dev, "Unable to register input device\n");
+		return r;
+	}
+
+	return 0;
+}
+
+static int gtx5_ts_hw_init(struct gtx5_ts_core *core_data)
+{
+	const struct gtx5_ts_hw_ops *hw_ops =
+		ts_hw_ops(core_data);
+	int r;
+
+	r = gtx5_ts_power_on(core_data);
+	if (r < 0)
+		goto exit;
+
+	if (hw_ops->init) {
+		r = hw_ops->init(core_data->ts_dev);
+		if (r < 0) {
+			core_data->hw_err = true;
+			goto exit;
+		}
+	}
+
+exit:
+	/* if bus communication error occurred then exit driver binding, other
+	 * errors will be ignored
+	 */
+	if (r != -EBUS)
+		r = 0;
+	return r;
+}
+
+/**
+ * gtx5_ts_esd_work - check hardware status and try recovery
+ *  the firmware work state if needed.
+ */
+static void gtx5_ts_esd_work(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct gtx5_ts_esd *ts_esd =
+			container_of(dwork, struct gtx5_ts_esd, esd_work);
+	struct gtx5_ts_core *core =
+			container_of(ts_esd, struct gtx5_ts_core, ts_esd);
+	const struct gtx5_ts_hw_ops *hw_ops = ts_hw_ops(core);
+	int r = 0;
+
+	if (ts_esd->esd_on == false)
+		return;
+
+	if (hw_ops->check_hw)
+		r = hw_ops->check_hw(core->ts_dev);
+	if (r < 0) {
+		gtx5_ts_power_off(core);
+		gtx5_ts_power_on(core);
+		if (hw_ops->reset)
+			hw_ops->reset(core->ts_dev);
+	}
+
+	mutex_lock(&ts_esd->esd_mutex);
+	if (ts_esd->esd_on)
+		schedule_delayed_work(&ts_esd->esd_work, 2 * HZ);
+	mutex_unlock(&ts_esd->esd_mutex);
+}
+
+/**
+ * gtx5_ts_esd_on - turn on esd protection
+ */
+static void gtx5_ts_esd_on(struct gtx5_ts_core *core_data)
+{
+	struct gtx5_ts_esd *ts_esd = &core_data->ts_esd;
+	const struct device *dev = &core_data->pdev->dev;
+
+	mutex_lock(&ts_esd->esd_mutex);
+	if (ts_esd->esd_on == false) {
+		ts_esd->esd_on = true;
+		schedule_delayed_work(&ts_esd->esd_work, 2 * HZ);
+		mutex_unlock(&ts_esd->esd_mutex);
+		dev_info(dev, "Esd on\n");
+		return;
+	}
+	mutex_unlock(&ts_esd->esd_mutex);
+}
+
+/**
+ * gtx5_ts_esd_off - turn off esd protection
+ */
+static void gtx5_ts_esd_off(struct gtx5_ts_core *core_data)
+{
+	struct gtx5_ts_esd *ts_esd = &core_data->ts_esd;
+	const struct device *dev = &core_data->pdev->dev;
+
+	mutex_lock(&ts_esd->esd_mutex);
+	if (ts_esd->esd_on == true) {
+		ts_esd->esd_on = false;
+		cancel_delayed_work(&ts_esd->esd_work);
+		mutex_unlock(&ts_esd->esd_mutex);
+		dev_info(dev, "Esd off\n");
+		return;
+	}
+	mutex_unlock(&ts_esd->esd_mutex);
+}
+
+/**
+ * gtx5_esd_notifier_callback - notification callback
+ *  under certain condition, we need to turn off/on the esd
+ *  protector, we use kernel notify call chain to achieve this.
+ *
+ *  for example: before firmware update we need to turn off the
+ *  esd protector and after firmware update finished, we should
+ *  turn on the esd protector.
+ */
+static int gtx5_esd_notifier_callback(struct notifier_block *nb,
+				      unsigned long action, void *data)
+{
+	struct gtx5_ts_esd *ts_esd =
+			container_of(nb, struct gtx5_ts_esd, esd_notifier);
+
+	switch (action) {
+	case NOTIFY_FWUPDATE_START:
+	case NOTIFY_SUSPEND:
+		gtx5_ts_esd_off(ts_esd->ts_core);
+		break;
+	case NOTIFY_FWUPDATE_END:
+	case NOTIFY_RESUME:
+		gtx5_ts_esd_on(ts_esd->ts_core);
+		break;
+	}
+
+	return 0;
+}
+
+/**
+ * gtx5_ts_esd_init - initialize esd protection
+ */
+static int gtx5_ts_esd_init(struct gtx5_ts_core *core)
+{
+	struct gtx5_ts_esd *ts_esd = &core->ts_esd;
+
+	INIT_DELAYED_WORK(&ts_esd->esd_work, gtx5_ts_esd_work);
+	mutex_init(&ts_esd->esd_mutex);
+	ts_esd->ts_core = core;
+	ts_esd->esd_on = false;
+	ts_esd->esd_notifier.notifier_call = gtx5_esd_notifier_callback;
+	gtx5_ts_register_notifier(&ts_esd->esd_notifier);
+
+	if (core->ts_dev->hw_ops->check_hw)
+		gtx5_ts_esd_on(core);
+	return 0;
+}
+
+/**
+ * gtx5_ts_suspend - Touchscreen suspend function
+ */
+static int gtx5_ts_suspend(struct gtx5_ts_core *core_data)
+{
+	struct gtx5_ext_module *ext_module;
+	struct gtx5_ts_device *ts_dev = core_data->ts_dev;
+	const struct device *dev = &core_data->pdev->dev;
+	int r;
+
+	dev_dbg(dev, "Suspend start\n");
+	/*
+	 * notify suspend event, inform the esd protector
+	 * and charger detector to turn off the work
+	 */
+	gtx5_ts_blocking_notify(NOTIFY_SUSPEND, NULL);
+
+	/* inform external module */
+	mutex_lock(&gtx5_modules.mutex);
+	if (!list_empty(&gtx5_modules.head)) {
+		list_for_each_entry(ext_module, &gtx5_modules.head, list) {
+			if (!ext_module->funcs->before_suspend)
+				continue;
+
+			r = ext_module->funcs->before_suspend(core_data, ext_module);
+			if (r == EVT_CANCEL_SUSPEND) {
+				mutex_unlock(&gtx5_modules.mutex);
+				dev_dbg(dev, "Canceled by module:%s\n",
+					ext_module->name);
+				goto out;
+			}
+		}
+	}
+	mutex_unlock(&gtx5_modules.mutex);
+
+	gtx5_ts_irq_enable(core_data, false);
+
+	/* let touch controller work in sleep mode */
+	if (ts_dev && ts_dev->hw_ops->suspend)
+		ts_dev->hw_ops->suspend(ts_dev);
+	atomic_set(&core_data->suspended, 1);
+
+	/* inform external modules */
+	mutex_lock(&gtx5_modules.mutex);
+	if (!list_empty(&gtx5_modules.head)) {
+		list_for_each_entry(ext_module, &gtx5_modules.head, list) {
+			if (!ext_module->funcs->after_suspend)
+				continue;
+
+			r = ext_module->funcs->after_suspend(core_data, ext_module);
+			if (r == EVT_CANCEL_SUSPEND) {
+				mutex_unlock(&gtx5_modules.mutex);
+				dev_dbg(dev, "Canceled by module:%s\n",
+					ext_module->name);
+				goto out;
+			}
+		}
+	}
+	mutex_unlock(&gtx5_modules.mutex);
+
+out:
+	/* release all the touch IDs */
+	core_data->ts_event.event_data.touch_data.touch_num = 0;
+	gtx5_ts_input_report(core_data->input_dev,
+			     &core_data->ts_event.event_data.touch_data);
+	dev_dbg(dev, "Suspend end\n");
+	return 0;
+}
+
+/**
+ * gtx5_ts_resume - Touchscreen resume function
+ * Called by PM/FB/EARLYSUSPEN module to wake up device
+ */
+static int gtx5_ts_resume(struct gtx5_ts_core *core_data)
+{
+	struct gtx5_ext_module *ext_module;
+	struct gtx5_ts_device *ts_dev = core_data->ts_dev;
+	const struct device *dev = &core_data->pdev->dev;
+	int r;
+
+	dev_dbg(dev, "Resume start\n");
+	mutex_lock(&gtx5_modules.mutex);
+	if (!list_empty(&gtx5_modules.head)) {
+		list_for_each_entry(ext_module, &gtx5_modules.head, list) {
+			if (!ext_module->funcs->before_resume)
+				continue;
+
+			r = ext_module->funcs->before_resume(core_data, ext_module);
+			if (r == EVT_CANCEL_RESUME) {
+				mutex_unlock(&gtx5_modules.mutex);
+				dev_dbg(dev, "Canceled by module:%s\n",
+					ext_module->name);
+				goto out;
+			}
+		}
+	}
+	mutex_unlock(&gtx5_modules.mutex);
+
+	atomic_set(&core_data->suspended, 0);
+	/* resume device */
+	if (ts_dev && ts_dev->hw_ops->resume)
+		ts_dev->hw_ops->resume(ts_dev);
+
+	gtx5_ts_irq_enable(core_data, true);
+
+	mutex_lock(&gtx5_modules.mutex);
+	if (!list_empty(&gtx5_modules.head)) {
+		list_for_each_entry(ext_module, &gtx5_modules.head, list) {
+			if (!ext_module->funcs->after_resume)
+				continue;
+
+			r = ext_module->funcs->after_resume(core_data,
+							    ext_module);
+			if (r == EVT_CANCEL_RESUME) {
+				mutex_unlock(&gtx5_modules.mutex);
+				dev_dbg(dev, "Canceled by module:%s\n",
+					ext_module->name);
+				goto out;
+			}
+		}
+	}
+	mutex_unlock(&gtx5_modules.mutex);
+
+out:
+	/*
+	 * notify resume event, inform the esd protector
+	 * and charger detector to turn on the work
+	 */
+	gtx5_ts_blocking_notify(NOTIFY_RESUME, NULL);
+	dev_dbg(dev, "Resume end\n");
+	return 0;
+}
+
+static int __maybe_unused gtx5_ts_pm_suspend(struct device *dev)
+{
+	struct gtx5_ts_core *core_data =
+		dev_get_drvdata(dev);
+
+	return gtx5_ts_suspend(core_data);
+}
+
+static int __maybe_unused gtx5_ts_pm_resume(struct device *dev)
+{
+	struct gtx5_ts_core *core_data =
+		dev_get_drvdata(dev);
+
+	return gtx5_ts_resume(core_data);
+}
+
+/**
+ * gtx5_generic_noti_callback - generic notifier callback
+ *  for gtx5 touch notification event.
+ */
+static int gtx5_generic_noti_callback(struct notifier_block *self,
+				      unsigned long action, void *data)
+{
+	struct gtx5_ts_core *ts_core = container_of(self,
+			struct gtx5_ts_core, ts_notifier);
+	const struct gtx5_ts_hw_ops *hw_ops = ts_hw_ops(ts_core);
+	int r;
+
+	switch (action) {
+	case NOTIFY_FWUPDATE_END:
+		if (ts_core->hw_err && hw_ops->init) {
+			/* Firmware has been updated, we need to reinit
+			 * the chip, read the sensor ID and send the
+			 * correct config data based on sensor ID.
+			 * The input parameters also needs to be updated.
+			 */
+			r = hw_ops->init(ts_core->ts_dev);
+			if (r < 0)
+				goto exit;
+
+			gtx5_ts_set_input_params(ts_core->input_dev,
+						 ts_core->ts_dev->board_data);
+			ts_core->hw_err = false;
+		}
+		break;
+	}
+
+exit:
+	return 0;
+}
+
+static int gtx5_ts_probe(struct platform_device *pdev)
+{
+	struct gtx5_ts_core *core_data = NULL;
+	struct gtx5_ts_device *ts_device;
+	int r;
+
+	ts_device = pdev->dev.platform_data;
+	if (!ts_device || !ts_device->hw_ops || !ts_device->board_data) {
+		dev_err(&pdev->dev, "Invalid touch device\n");
+		return -ENODEV;
+	}
+
+	core_data = devm_kzalloc(&pdev->dev, sizeof(struct gtx5_ts_core),
+				 GFP_KERNEL);
+	if (!core_data)
+		return -ENOMEM;
+
+	/* touch core layer is a platform driver */
+	core_data->pdev = pdev;
+	core_data->ts_dev = ts_device;
+	platform_set_drvdata(pdev, core_data);
+
+	r = gtx5_ts_power_init(core_data);
+	if (r < 0)
+		dev_err(&pdev->dev, "Failed power init\n");
+
+	/* get GPIO resource if have */
+	gtx5_ts_gpio_setup(core_data);
+
+	/* initialize firmware */
+	r = gtx5_ts_hw_init(core_data);
+	if (r < 0)
+		goto out;
+
+	/* alloc/config/register input device */
+	r = gtx5_ts_input_dev_config(core_data);
+	if (r < 0)
+		goto out;
+
+	/* request irq line */
+	r = gtx5_ts_irq_setup(core_data);
+	if (r < 0)
+		goto out;
+
+	/* inform the external module manager that
+	 * touch core layer is ready now
+	 */
+	gtx5_modules.core_data = core_data;
+	complete_all(&gtx5_modules.core_comp);
+
+	/* create sysfs files */
+	gtx5_ts_sysfs_init(core_data);
+
+	/* esd protector */
+	gtx5_ts_esd_init(core_data);
+
+	/* generic notifier callback */
+	core_data->ts_notifier.notifier_call = gtx5_generic_noti_callback;
+	gtx5_ts_register_notifier(&core_data->ts_notifier);
+
+	return 0;
+out:
+	gtx5_modules.core_exit = true;
+	complete_all(&gtx5_modules.core_comp);
+	dev_err(&pdev->dev, "Core layer probe failed");
+	return r;
+}
+
+static int gtx5_ts_remove(struct platform_device *pdev)
+{
+	struct gtx5_ts_core *core_data =
+		platform_get_drvdata(pdev);
+
+	gtx5_ts_power_off(core_data);
+	gtx5_ts_sysfs_exit(core_data);
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(dev_pm_ops, gtx5_ts_pm_suspend, gtx5_ts_pm_resume);
+
+static const struct platform_device_id ts_core_ids[] = {
+	{.name = GTX5_CORE_DRIVER_NAME},
+	{}
+};
+MODULE_DEVICE_TABLE(platform, ts_core_ids);
+
+static struct platform_driver gtx5_ts_driver = {
+	.driver = {
+		.name = GTX5_CORE_DRIVER_NAME,
+		.pm = &dev_pm_ops,
+	},
+	.probe = gtx5_ts_probe,
+	.remove = gtx5_ts_remove,
+	.id_table = ts_core_ids,
+};
+
+static int __init gtx5_ts_core_init(void)
+{
+	if (!gtx5_modules.initialized) {
+		gtx5_modules.initialized = true;
+		INIT_LIST_HEAD(&gtx5_modules.head);
+		mutex_init(&gtx5_modules.mutex);
+		init_completion(&gtx5_modules.core_comp);
+	}
+
+	return platform_driver_register(&gtx5_ts_driver);
+}
+
+static void __exit gtx5_ts_core_exit(void)
+{
+	platform_driver_unregister(&gtx5_ts_driver);
+}
+
+module_init(gtx5_ts_core_init);
+module_exit(gtx5_ts_core_exit);
+
+MODULE_DESCRIPTION("Goodix Touchscreen Core Module");
+MODULE_AUTHOR("Goodix, Inc.");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/input/touchscreen/gtx5_core.h b/drivers/input/touchscreen/gtx5_core.h
new file mode 100644
index 0000000..7f7f49a
--- /dev/null
+++ b/drivers/input/touchscreen/gtx5_core.h
@@ -0,0 +1,398 @@
+/*
+ * Goodix GTx5 Touchscreen Driver
+ *
+ * Copyright (C) 2015 - 2016 Goodix, Inc.
+ *
+ * Authors:  Wang Yafei <wangyafei@goodix.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; version 2 of the License.
+ */
+
+#ifndef _GTX5_CORE_H_
+#define _GTX5_CORE_H_
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/firmware.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/kthread.h>
+#include <linux/version.h>
+#include <linux/delay.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/input.h>
+#include <asm/unaligned.h>
+#ifdef CONFIG_OF
+#include <linux/of_gpio.h>
+#include <linux/regulator/consumer.h>
+#endif
+
+#include <linux/gpio/consumer.h>
+
+#define GTX5_CORE_DRIVER_NAME	"gtx5_ts"
+#define GTX5_DRIVER_VERSION	"v0.8"
+#define GTX5_BUS_RETRY_TIMES	3
+#define GTX5_MAX_TOUCH		10
+#define GTX5_MAX_KEY		5
+#define GTX5_CFG_MAX_SIZE	1024
+
+struct gtx5_ts_board_data {
+	const char *avdd_name;		/* name of analog regulator */
+	struct gpio_desc *reset_gpiod;
+	struct gpio_desc *irq_gpiod;
+	int irq;
+	unsigned int  irq_flags;
+
+	unsigned int swap_axis;
+	unsigned int panel_max_id;
+	unsigned int panel_max_x;
+	unsigned int panel_max_y;
+	unsigned int panel_max_w;	/* input major axis */
+	unsigned int panel_max_key;	/* max supported key number*/
+	unsigned int panel_key_map[GTX5_MAX_KEY]; /* touch key map*/
+	const char *fw_name;		/* name of firmware image */
+};
+
+struct gtx5_ts_config {
+	bool initialized;
+	char name[24];
+	struct mutex lock;
+	unsigned int reg_base;
+	unsigned int length;
+	unsigned int mdelay;	/* delay time after send config */
+	unsigned char data[GTX5_CFG_MAX_SIZE];
+};
+
+#pragma pack(4)
+struct gtx5_ts_cmd {
+	u32 initialized;
+	u32 cmd_reg;	/* command register */
+	u32 length;	/* command data length */
+	u8 cmds[3];	/* command data buffer */
+};
+
+#pragma pack()
+
+/* interrupt event type */
+enum ts_event_type {
+	EVENT_INVALID,
+	EVENT_TOUCH,
+	EVENT_REQUEST,
+};
+
+/* request event type */
+enum ts_request_type {
+	REQUEST_INVALID,
+	REQUEST_CONFIG,
+	REQUEST_BAKREF,
+	REQUEST_RESET,
+	REQUEST_MAINCLK,
+};
+
+/* notifier event */
+enum ts_notify_event {
+	NOTIFY_FWUPDATE_START,
+	NOTIFY_FWUPDATE_END,
+	NOTIFY_SUSPEND,
+	NOTIFY_RESUME,
+};
+
+/* coordinate package */
+struct gtx5_ts_coords {
+	int id;
+	unsigned int x, y, w, p;
+};
+
+/* touch event data */
+struct gtx5_touch_data {
+	int touch_num;
+	struct gtx5_ts_coords coords[GTX5_MAX_TOUCH];
+	u16 key_value;
+};
+
+/* request event data */
+struct gtx5_request_data {
+	enum ts_request_type request_type;
+};
+
+struct gtx5_ts_event {
+	enum ts_event_type event_type;
+	union {
+		struct gtx5_touch_data touch_data;
+		struct gtx5_request_data request_data;
+	} event_data;
+};
+
+struct gtx5_ts_version {
+	bool valid;	/* version information valid flag */
+	char pid[5];	/* production id */
+	u16 vid;	/* firmware version code */
+	u8 cid;		/* customer id */
+	u8 panel_id;
+};
+
+struct gtx5_ts_device {
+	char *name;
+
+	struct gtx5_ts_board_data *board_data;
+	struct gtx5_ts_config *normal_cfg;
+	struct gtx5_ts_config *highsense_cfg;
+	const struct gtx5_ts_hw_ops *hw_ops;
+
+	struct gtx5_ts_version chip_version;
+	struct gtx5_ts_cmd sleep_cmd;
+	struct gtx5_ts_cmd gesture_cmd;
+
+	struct device *dev;
+};
+
+struct gtx5_ts_hw_ops {
+	int (*init)(struct gtx5_ts_device *dev);
+	void (*reset)(struct gtx5_ts_device *dev);
+	int (*read)(struct gtx5_ts_device *dev, unsigned int addr,
+		    unsigned char *data, unsigned int len);
+	int (*write)(struct gtx5_ts_device *dev, unsigned int addr,
+		     unsigned char *data, unsigned int len);
+	int (*send_cmd)(struct gtx5_ts_device *dev,
+			struct gtx5_ts_cmd  *cmd);
+	int (*send_config)(struct gtx5_ts_device *dev,
+			   struct gtx5_ts_config *config);
+	int (*read_version)(struct gtx5_ts_device *dev,
+			    struct gtx5_ts_version *version);
+	int (*event_handler)(struct gtx5_ts_device *dev,
+			     struct gtx5_ts_event *ts_event);
+	int (*check_hw)(struct gtx5_ts_device *dev); /* for esd check */
+	int (*suspend)(struct gtx5_ts_device *dev);
+	int (*resume)(struct gtx5_ts_device *dev);
+};
+
+struct gtx5_ts_esd {
+	struct delayed_work esd_work;
+	struct mutex esd_mutex;
+	struct notifier_block esd_notifier;
+	struct gtx5_ts_core *ts_core;
+	bool esd_on;	/* esd enable flag */
+};
+
+struct gtx5_ts_core {
+	struct platform_device *pdev;
+	struct gtx5_ts_device *ts_dev;
+	struct input_dev *input_dev;
+
+	struct regulator *avdd;		/* analogy regulator */
+	struct gtx5_ts_event ts_event;	/* record ts_event information */
+	int power_on;
+	int irq;			/* irq num */
+	size_t irq_trig_cnt;		/* irq trig counter */
+
+	atomic_t irq_enabled;
+	atomic_t suspended;
+	bool hw_err;
+
+	struct notifier_block ts_notifier;
+	struct gtx5_ts_esd ts_esd;
+};
+
+/* external module structures */
+enum gtx5_ext_priority {
+	EXTMOD_PRIO_RESERVED = 0,
+	EXTMOD_PRIO_FWUPDATE,
+	EXTMOD_PRIO_GESTURE,
+	EXTMOD_PRIO_HOTKNOT,
+	EXTMOD_PRIO_DBGTOOL,
+	EXTMOD_PRIO_DEFAULT,
+};
+
+struct gtx5_ext_module;
+/* external module callback functions */
+struct gtx5_ext_module_funcs {
+	int (*init)(struct gtx5_ts_core *core_data,
+		    struct gtx5_ext_module *module);
+	int (*exit)(struct gtx5_ts_core *core_data,
+		    struct gtx5_ext_module *module);
+
+	int (*before_reset)(struct gtx5_ts_core *core_data,
+			    struct gtx5_ext_module *module);
+	int (*after_reset)(struct gtx5_ts_core *core_data,
+			   struct gtx5_ext_module *module);
+
+	int (*before_suspend)(struct gtx5_ts_core *core_data,
+			      struct gtx5_ext_module *module);
+	int (*after_suspend)(struct gtx5_ts_core *core_data,
+			     struct gtx5_ext_module *module);
+
+	int (*before_resume)(struct gtx5_ts_core *core_data,
+			     struct gtx5_ext_module *module);
+	int (*after_resume)(struct gtx5_ts_core *core_data,
+			    struct gtx5_ext_module *module);
+
+	int (*irq_event)(struct gtx5_ts_core *core_data,
+			 struct gtx5_ext_module *module);
+};
+
+struct gtx5_ext_module {
+	struct list_head list;
+	char *name;
+	enum gtx5_ext_priority priority;
+	const struct gtx5_ext_module_funcs *funcs;
+	void *priv_data;
+	struct kobject kobj;
+	struct work_struct work;	/* used in module registration */
+};
+
+/*
+ * struct gtx5_ext_attribute - external attribute struct
+ */
+struct gtx5_ext_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct gtx5_ext_module *, char *);
+	ssize_t (*store)(struct gtx5_ext_module *, const char *, size_t);
+};
+
+/* external attrs helper macro */
+#define __EXTMOD_ATTR(_name, _mode, _show, _store)	{	\
+	.attr = {.name = __stringify(_name), .mode = _mode },	\
+	.show   = _show,	\
+	.store  = _store,	\
+}
+
+/* external attrs helper macro, used to define external attrs */
+#define DEFINE_EXTMOD_ATTR(_name, _mode, _show, _store)	\
+static struct gtx5_ext_attribute ext_attr_##_name = \
+	__EXTMOD_ATTR(_name, _mode, _show, _store)
+
+/*
+ * get board data pointer
+ */
+static inline struct gtx5_ts_board_data *board_data(struct gtx5_ts_core *core)
+{
+	return core->ts_dev->board_data;
+}
+
+/*
+ * get touch hardware operations pointer
+ */
+static inline const struct gtx5_ts_hw_ops *ts_hw_ops(struct gtx5_ts_core *core)
+{
+	return core->ts_dev->hw_ops;
+}
+
+/*
+ * checksum helper functions
+ * checksum can be u8/le16/be16/le32/be32 format
+ * NOTE: the caller should be responsible for the
+ * legality of @data and @size parameters, so be
+ * careful when call these functions.
+ */
+static inline u8 checksum_u8(u8 *data, u32 size)
+{
+	u8 checksum = 0;
+	u32 i;
+
+	for (i = 0; i < size; i++)
+		checksum += data[i];
+	return checksum;
+}
+
+static inline u16 checksum_le16(u8 *data, u32 size)
+{
+	u16 checksum = 0;
+	u32 i;
+
+	for (i = 0; i < size; i += 2)
+		checksum += le16_to_cpup((__le16 *)(data + i));
+	return checksum;
+}
+
+static inline u16 checksum_be16(u8 *data, u32 size)
+{
+	u16 checksum = 0;
+	u32 i;
+
+	for (i = 0; i < size; i += 2)
+		checksum += be16_to_cpup((__be16 *)(data + i));
+	return checksum;
+}
+
+static inline u32 checksum_le32(u8 *data, u32 size)
+{
+	u32 checksum = 0;
+	u32 i;
+
+	for (i = 0; i < size; i += 4)
+		checksum += le32_to_cpup((__le32 *)(data + i));
+	return checksum;
+}
+
+static inline u32 checksum_be32(u8 *data, u32 size)
+{
+	u32 checksum = 0;
+	u32 i;
+
+	for (i = 0; i < size; i += 4)
+		checksum += be32_to_cpup((__be32 *)(data + i));
+	return checksum;
+}
+
+/*
+ * define event action
+ * EVT_xxx macros are used in operations callback
+ * defined in @gtx5_ext_module_funcs to control
+ * the behaviors of event such as suspend/resume/
+ * irq_event.
+ *
+ * generally there are two types of behaviors:
+ * - you want the flow of this event be canceled,
+ *   in this condition, you should return EVT_CANCEL_XXX
+ *   in the operations callback. e.g. the firmware update
+ *   module is updating the firmware, you want to cancel
+ *   suspend flow, so you need to return EVT_CANCEL_SUSPEND in
+ *   suspend callback function.
+ * - you want the flow of this event continue, in this condition,
+ *   you should return EVT_HANDLED in the callback function.
+ */
+#define EVT_HANDLED			0
+#define EVT_CANCEL_IRQEVT		1
+#define EVT_CANCEL_SUSPEND		1
+#define EVT_CANCEL_RESUME		1
+#define EVT_CANCEL_RESET		1
+
+/*
+ * errno define
+ * Note:
+ *	1. bus read/write functions defined in hardware
+ *	  layer code(e.g. gtx5_xxx_i2c.c) *must* return
+ *	  -EBUS if failed to transfer data on bus.
+ */
+#define EBUS					1000
+#define ETIMEOUT				1001
+#define ECHKSUM					1002
+#define EMEMCMP					1003
+
+/**
+ * gtx5_register_ext_module - interface for external module
+ * to register into touch core modules structure
+ */
+int gtx5_register_ext_module(struct gtx5_ext_module *module);
+
+/**
+ * gtx5_unregister_ext_module - interface for external module
+ * to unregister external
+ */
+int gtx5_unregister_ext_module(struct gtx5_ext_module *module);
+
+void gtx5_ts_irq_enable(struct gtx5_ts_core *core_data, bool enable);
+
+struct kobj_type *gtx5_get_default_ktype(void);
+
+/**
+ * gtx5_ts_blocking_notify - notify clients of certain events
+ *	see enum ts_notify_event in gtx5_ts_core.h
+ */
+int gtx5_ts_blocking_notify(enum ts_notify_event evt, void *v);
+
+#endif
diff --git a/drivers/input/touchscreen/gtx5_i2c.c b/drivers/input/touchscreen/gtx5_i2c.c
new file mode 100644
index 0000000..57b0815
--- /dev/null
+++ b/drivers/input/touchscreen/gtx5_i2c.c
@@ -0,0 +1,802 @@
+/*
+ * Goodix GTx5 Touchscreen Driver
+ * Hardware interface layer of gtx5 touchscreen driver.
+ *
+ * Copyright (C) 2015 - 2016 Goodix, Inc.
+ *
+ * Authors:  Wang Yafei <wangyafei@goodix.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; version 2 of the License.
+ */
+
+#include <linux/ctype.h>
+#include <linux/i2c.h>
+#include <linux/property.h>
+#include <linux/interrupt.h>
+#include "gtx5_core.h"
+
+#define TS_DRIVER_NAME		"gtx5_i2c"
+#define I2C_MAX_TRANSFER_SIZE	256
+#define TS_ADDR_LENGTH		2
+
+#define TS_REG_COORDS_BASE	0x824E
+#define TS_REG_CMD		0x8040
+#define TS_REG_REQUEST		0x8044
+#define TS_REG_VERSION		0x8240
+#define TS_REG_CFG_BASE		0x8050
+
+#define CFG_XMAX_OFFSET		(0x8052 - 0x8050)
+#define CFG_YMAX_OFFSET		(0x8054 - 0x8050)
+
+#define REQUEST_HANDLED		0x00
+#define REQUEST_CONFIG		0x01
+#define REQUEST_BAKREF		0x02
+#define REQUEST_RESET		0x03
+#define REQUEST_MAINCLK		0x04
+#define REQUEST_IDLE		0x05
+
+#define TS_MAX_PANELID		9
+#define TS_CFG_MAX_LEN		495
+
+#define DEFAULT_IRQ_FLAGS IRQF_TRIGGER_FALLING
+
+#ifdef CONFIG_OF
+/*
+ * gtx5_parse_dt_resolution - parse resolution from dt
+ * @dev: device
+ * @board_data: pointer to board data structure
+ * return: 0 - no error, <0 error
+ */
+static int gtx5_parse_dt_resolution(struct device *dev,
+				    struct gtx5_ts_board_data *board_data)
+{
+	int r, err = 0;
+
+	r = device_property_read_u32(dev, "touchscreen-max-id",
+				     &board_data->panel_max_id);
+	if (r || board_data->panel_max_id > GTX5_MAX_TOUCH)
+		board_data->panel_max_id = GTX5_MAX_TOUCH;
+
+	r = device_property_read_u32(dev, "touchscreen-size-x",
+				     &board_data->panel_max_x);
+	if (r)
+		err = -ENOENT;
+
+	r = device_property_read_u32(dev, "touchscreen-size-y",
+				     &board_data->panel_max_y);
+	if (r)
+		err = -ENOENT;
+
+	r = device_property_read_u32(dev, "touchscreen-max-w",
+				     &board_data->panel_max_w);
+	if (r)
+		err = -ENOENT;
+
+	board_data->swap_axis = device_property_read_bool(dev,
+					"touchscreen-swapped-x-y");
+
+	return err;
+}
+
+/**
+ * gtx5_parse_dt - parse board data from dt
+ */
+static int gtx5_parse_dt(struct device *dev,
+			 struct gtx5_ts_board_data *board_data)
+{
+	int r;
+
+	if (!board_data) {
+		dev_err(dev, "Invalid board data\n");
+		return -EINVAL;
+	}
+
+	board_data->avdd_name = "vtouch";
+
+	/* get resolutions information from dt */
+	r = gtx5_parse_dt_resolution(dev, board_data);
+	if (r < 0) {
+		dev_err(dev, "Failed to parse resolutions:%d\n", r);
+		return r;
+	}
+
+	/* parse key map */
+	r = device_property_read_u32_array(dev, "panel-key-map",
+					   NULL, GTX5_MAX_KEY);
+	if (r > 0 && r <= GTX5_MAX_KEY) {
+		board_data->panel_max_key = r;
+		r = device_property_read_u32_array(dev, "linux,keycodes",
+						   &board_data->panel_key_map[0],
+						   board_data->panel_max_key);
+		if (r)
+			dev_err(dev, "Failed get key code info\n");
+	} else {
+		dev_info(dev, "No Key codes info\n");
+	}
+
+	dev_dbg(dev, "[DT]id:%d, x:%d, y:%d, w:%d\n",
+		board_data->panel_max_id,
+		board_data->panel_max_x,
+		board_data->panel_max_y,
+		board_data->panel_max_w);
+	return 0;
+}
+
+/**
+ * gtx5_parse_dt_cfg - pares config data from devicetree dev
+ * @ts_dev: pointer to gtx5 device
+ * @cfg_type: config type such as normal_config, highsense_cfg ...
+ * @config: pointer to config data structure
+ * @panel_id: sensor id
+ */
+static int gtx5_parse_dt_cfg(struct gtx5_ts_device *ts_dev,
+			     char *cfg_type, struct gtx5_ts_config *config,
+			     unsigned int panel_id)
+{
+	int r, len;
+	u16 checksum;
+	char cfg_name[24] = {0};
+	struct device *dev = ts_dev->dev;
+	struct gtx5_ts_board_data *ts_bdata = ts_dev->board_data;
+
+	if (panel_id > TS_MAX_PANELID) {
+		dev_err(dev, "Invalid panel id\n");
+		return -EINVAL;
+	}
+
+	if (config->initialized) {
+		dev_dbg(dev, "Config already initialized\n");
+		return 0;
+	}
+
+	/*
+	 * config data are located in child node called
+	 * 'panelX', X is the panel ID got from touch
+	 * device.
+	 */
+	snprintf(cfg_name, sizeof(cfg_name),
+		 "goodix,%s-%u", cfg_type, panel_id);
+	len = device_property_read_u8_array(dev, cfg_name, NULL,
+					    TS_CFG_MAX_LEN);
+	if (len <= 0 || len % 2 != 1) {
+		dev_err(dev, "Invalid cfg type%s, size:%u\n", cfg_type, len);
+		return -EINVAL;
+	}
+
+	config->length = len;
+
+	mutex_init(&config->lock);
+	mutex_lock(&config->lock);
+
+	r = device_property_read_u8_array(dev, cfg_name, config->data,
+					  TS_CFG_MAX_LEN);
+	if (r) {
+		mutex_unlock(&config->lock);
+		return r;
+	}
+
+	/* modify max-x max-y resolution, little-endian */
+	config->data[CFG_XMAX_OFFSET] = (u8)ts_bdata->panel_max_x;
+	config->data[CFG_XMAX_OFFSET + 1] = (u8)(ts_bdata->panel_max_x >> 8);
+	config->data[CFG_YMAX_OFFSET] = (u8)ts_bdata->panel_max_y;
+	config->data[CFG_YMAX_OFFSET + 1] = (u8)(ts_bdata->panel_max_y >> 8);
+
+	/*
+	 * checksum: u16 little-endian format
+	 * the last byte of config is the config update flag
+	 */
+	checksum = checksum_le16(config->data, len - 3);
+	checksum = 0 - checksum;
+	config->data[len - 3] = (u8)checksum;
+	config->data[len - 2] = (u8)(checksum >> 8 & 0xff);
+	config->data[len - 1] = 0x01;
+
+	strlcpy(config->name, cfg_type, sizeof(config->name));
+	config->reg_base = TS_REG_CFG_BASE;
+	config->mdelay = 0;
+	config->initialized = true;
+	mutex_unlock(&config->lock);
+
+	dev_dbg(dev, "Config name:%s,ver:%02xh,size:%d,checksum:%04xh\n",
+		config->name, config->data[0],
+		config->length, checksum);
+	return 0;
+}
+#endif
+
+/**
+ * gtx5_i2c_read - read device register data
+ * @ts_dev: pointer to device data
+ * @addr: register address
+ * @data: read buffer
+ * @len: bytes to read
+ * return: 0 - read ok, < 0 - i2c transfer error
+ */
+static int gtx5_i2c_read(struct gtx5_ts_device *ts_dev, unsigned int reg,
+			 unsigned char *data, unsigned int len)
+{
+	struct i2c_client *client = to_i2c_client(ts_dev->dev);
+	unsigned int transfer_length = 0;
+	unsigned int pos = 0, address = reg;
+	unsigned char get_buf[64], addr_buf[2];
+	int retry, r = 0;
+	struct i2c_msg msgs[] = {
+		{
+			.addr = client->addr,
+			.flags = !I2C_M_RD,
+			.buf = &addr_buf[0],
+			.len = TS_ADDR_LENGTH,
+		}, {
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+		}
+	};
+
+	if (likely(len < sizeof(get_buf))) {
+		/* code optimize, use stack memory */
+		msgs[1].buf = &get_buf[0];
+	} else {
+		msgs[1].buf = kzalloc(len > I2C_MAX_TRANSFER_SIZE
+				? I2C_MAX_TRANSFER_SIZE : len, GFP_KERNEL);
+		if (!msgs[1].buf)
+			return -ENOMEM;
+	}
+
+	while (pos != len) {
+		if (unlikely(len - pos > I2C_MAX_TRANSFER_SIZE))
+			transfer_length = I2C_MAX_TRANSFER_SIZE;
+		else
+			transfer_length = len - pos;
+
+		msgs[0].buf[0] = (address >> 8) & 0xFF;
+		msgs[0].buf[1] = address & 0xFF;
+		msgs[1].len = transfer_length;
+
+		for (retry = 0; retry < GTX5_BUS_RETRY_TIMES; retry++) {
+			if (likely(i2c_transfer(client->adapter, msgs, 2) == 2)) {
+				memcpy(&data[pos], msgs[1].buf, transfer_length);
+				pos += transfer_length;
+				address += transfer_length;
+				break;
+			}
+			dev_info(&client->dev, "I2c read retry[%d]:0x%x\n",
+				 retry + 1, reg);
+			msleep(20);
+		}
+		if (unlikely(retry == GTX5_BUS_RETRY_TIMES)) {
+			dev_err(&client->dev,
+				"I2c read failed,dev:%02x,reg:%04x,size:%u\n",
+				client->addr, reg, len);
+			r = -EBUS;
+			goto read_exit;
+		}
+	}
+
+read_exit:
+	if (unlikely(len >= sizeof(get_buf)))
+		kfree(msgs[1].buf);
+	return r;
+}
+
+/**
+ * gtx5_i2c_write - write data to device register
+ * @ts_dev: pointer to gtx5 device data
+ * @addr: register address
+ * @data: write buffer
+ * @len: bytes to write
+ * return: 0 - write ok; < 0 - i2c transfer error.
+ */
+static int gtx5_i2c_write(struct gtx5_ts_device *ts_dev,
+			  unsigned int reg,
+			  unsigned char *data,
+			  unsigned int len)
+{
+	struct i2c_client *client = to_i2c_client(ts_dev->dev);
+	unsigned int pos = 0, transfer_length = 0;
+	unsigned int address = reg;
+	unsigned char put_buf[64];
+	int retry, r = 0;
+	struct i2c_msg msg = {
+			.addr = client->addr,
+			.flags = !I2C_M_RD,
+	};
+
+	if (likely(len + TS_ADDR_LENGTH < sizeof(put_buf))) {
+		/* code optimize,use stack memory*/
+		msg.buf = &put_buf[0];
+	} else {
+		msg.buf = kmalloc(len + TS_ADDR_LENGTH > I2C_MAX_TRANSFER_SIZE
+			? I2C_MAX_TRANSFER_SIZE : len + TS_ADDR_LENGTH, GFP_KERNEL);
+		if (!msg.buf)
+			return -ENOMEM;
+	}
+
+	while (pos != len) {
+		if (unlikely(len - pos > I2C_MAX_TRANSFER_SIZE - TS_ADDR_LENGTH))
+			transfer_length = I2C_MAX_TRANSFER_SIZE - TS_ADDR_LENGTH;
+		else
+			transfer_length = len - pos;
+
+		msg.buf[0] = (unsigned char)((address >> 8) & 0xFF);
+		msg.buf[1] = (unsigned char)(address & 0xFF);
+		msg.len = transfer_length + 2;
+		memcpy(&msg.buf[2], &data[pos], transfer_length);
+
+		for (retry = 0; retry < GTX5_BUS_RETRY_TIMES; retry++) {
+			if (likely(i2c_transfer(client->adapter, &msg, 1) == 1)) {
+				pos += transfer_length;
+				address += transfer_length;
+				break;
+			}
+			dev_info(&client->dev, "I2c write retry[%d]\n", retry + 1);
+			msleep(20);
+		}
+		if (unlikely(retry == GTX5_BUS_RETRY_TIMES)) {
+			dev_err(&client->dev,
+				"I2c write failed,dev:%02x,reg:%04x,size:%u",
+				client->addr, reg, len);
+			r = -EBUS;
+			goto write_exit;
+		}
+	}
+
+write_exit:
+	if (likely(len + TS_ADDR_LENGTH >= sizeof(put_buf)))
+		kfree(msg.buf);
+	return r;
+}
+
+static int gtx5_read_version(struct gtx5_ts_device *ts_dev,
+			     struct gtx5_ts_version *version)
+{
+	u8 buffer[12];
+	int r;
+
+	r = gtx5_i2c_read(ts_dev, TS_REG_VERSION,
+			  buffer, sizeof(buffer));
+	if (r < 0) {
+		dev_err(ts_dev->dev, "Read chip version failed\n");
+		if (version)
+			version->valid = false;
+		return r;
+	}
+
+	/* if checksum is right and first 4 bytes are not invalid value */
+	if (checksum_u8(buffer, sizeof(buffer)) == 0 &&
+	    isalnum(buffer[0]) && isalnum(buffer[1]) &&
+	    isalnum(buffer[2]) && isalnum(buffer[3])) {
+		if (version) {
+			memcpy(&version->pid[0], buffer, 4);
+			version->pid[4] = '\0';
+			version->cid = buffer[4];
+			/* vid = main version + minor version */
+			version->vid = get_unaligned_be16(&buffer[5]);
+			version->panel_id = buffer[10] & 0x0F;
+			version->valid = true;
+
+			if (version->cid)
+				dev_info(ts_dev->dev,
+					 "PID:%s,CID: %c,VID:%04x,PanelID:%u\n",
+					 version->pid, version->cid + 'A' - 1,
+					 version->vid, version->panel_id);
+			else
+				dev_info(ts_dev->dev,
+					 "PID:%s,VID:%04x,PanelID:%u\n",
+					 version->pid, version->vid,
+					 version->panel_id);
+		}
+	} else {
+		dev_warn(ts_dev->dev, "Checksum error:%*ph\n",
+			 (int)sizeof(buffer), buffer);
+		/* mark this version is invalid */
+		if (version)
+			version->valid = false;
+		r = -EINVAL;
+	}
+
+	return r;
+}
+
+static int gtx5_send_config(struct gtx5_ts_device *ts_dev,
+			    struct gtx5_ts_config *config)
+{
+	int r = 0;
+
+	if (!config || !config->data) {
+		dev_warn(ts_dev->dev, "Null config data\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(ts_dev->dev, "Send %s,ver:%02xh,size:%d\n",
+		config->name, config->data[0],
+		config->length);
+
+	mutex_lock(&config->lock);
+	r = gtx5_i2c_write(ts_dev, config->reg_base,
+			   config->data, config->length);
+	if (r)
+		goto exit;
+
+	/* make sure the firmware accept the config data*/
+	if (config->mdelay)
+		msleep(config->mdelay);
+exit:
+	mutex_unlock(&config->lock);
+	return r;
+}
+
+static inline int gtx5_cmds_init(struct gtx5_ts_device *ts_dev)
+{
+	/* low power mode command */
+	ts_dev->sleep_cmd.cmd_reg = TS_REG_CMD;
+	ts_dev->sleep_cmd.length = 3;
+	ts_dev->sleep_cmd.cmds[0] = 0x05;
+	ts_dev->sleep_cmd.cmds[1] = 0x0;
+	ts_dev->sleep_cmd.cmds[2] = 0 - 0x05;
+	ts_dev->sleep_cmd.initialized = true;
+
+	return 0;
+}
+
+/**
+ * gtx5_hw_init - hardware initialize
+ * Called by touch core layer when module install
+ * @ts_dev: pointer to touch device
+ * return: 0 - no error, <0 error
+ */
+static int gtx5_hw_init(struct gtx5_ts_device *ts_dev)
+{
+	int r;
+
+	gtx5_cmds_init(ts_dev);
+
+	if (!ts_dev->normal_cfg) {
+		ts_dev->normal_cfg = devm_kzalloc(ts_dev->dev,
+				sizeof(*ts_dev->normal_cfg), GFP_KERNEL);
+		if (!ts_dev->normal_cfg) {
+			dev_err(ts_dev->dev,
+				"Failed to alloc memory for normal config\n");
+			return -ENOMEM;
+		}
+	}
+
+	/* read chip version: PID/VID/sensor ID,etc.*/
+	r = gtx5_read_version(ts_dev, &ts_dev->chip_version);
+	if (r < 0)
+		return r;
+
+#ifdef CONFIG_OF
+	/* parse normal-cfg from devicetree node */
+	r = gtx5_parse_dt_cfg(ts_dev, "normal-cfg",
+			      ts_dev->normal_cfg,
+			      ts_dev->chip_version.panel_id);
+	if (r < 0) {
+		dev_warn(ts_dev->dev, "Failed to obtain normal-cfg\n");
+		return r;
+	}
+#endif
+
+	ts_dev->normal_cfg->mdelay = 120;
+	/* send normal-cfg to firmware */
+	r = gtx5_send_config(ts_dev, ts_dev->normal_cfg);
+
+	return r;
+}
+
+static void gtx5_hw_reset(struct gtx5_ts_device *dev)
+{
+	dev_dbg(dev->dev, "HW reset\n");
+
+	if (!dev->board_data->reset_gpiod) {
+		msleep(80);
+		return;
+	}
+	gpiod_direction_output(dev->board_data->reset_gpiod, 0);
+	usleep_range(200, 210);
+	gpiod_direction_output(dev->board_data->reset_gpiod, 1);
+	msleep(80);
+}
+
+/**
+ * gtx5_request_handler - handle firmware request
+ *
+ * @dev: pointer to touch device
+ * @request_data: request information
+ * Returns 0 - succeed,<0 - failed
+ */
+static int gtx5_request_handler(struct gtx5_ts_device *dev,
+		struct gtx5_request_data *request_data) {
+	unsigned char buffer[1];
+	int r;
+
+	r = gtx5_i2c_read(dev, TS_REG_REQUEST, buffer, 1);
+	if (r < 0)
+		return r;
+
+	switch (buffer[0]) {
+	case REQUEST_CONFIG:
+		dev_dbg(dev->dev, "HW request config\n");
+		gtx5_send_config(dev, dev->normal_cfg);
+		goto clear_requ;
+	case REQUEST_BAKREF:
+		dev_dbg(dev->dev, "HW request bake reference data\n");
+		goto clear_requ;
+	case REQUEST_RESET:
+		dev_dbg(dev->dev, "HW request reset\n");
+		goto clear_requ;
+	case REQUEST_MAINCLK:
+		dev_dbg(dev->dev, "HW request main clock\n");
+		goto clear_requ;
+	default:
+		dev_dbg(dev->dev, "Unknown hw request:%d\n", buffer[0]);
+		return 0;
+	}
+
+clear_requ:
+	buffer[0] = 0x00;
+	r = gtx5_i2c_write(dev, TS_REG_REQUEST, buffer, 1);
+	return r;
+}
+
+/**
+ * gtx5_event_handler - handle firmware event
+ *
+ * @dev: pointer to touch device
+ * @ts_event: pointer to touch event structure
+ * Returns 0 - succeed,<0 - failed
+ */
+static int gtx5_event_handler(struct gtx5_ts_device *dev,
+			      struct gtx5_ts_event *ts_event)
+{
+#define BYTES_PER_COORD 8
+	struct gtx5_touch_data *touch_data =
+			&ts_event->event_data.touch_data;
+	struct gtx5_ts_coords *coords = &touch_data->coords[0];
+	int max_touch_num = dev->board_data->panel_max_id;
+	unsigned char buffer[2 + BYTES_PER_COORD * max_touch_num];
+	unsigned char coord_sta;
+	int touch_num = 0, i, r;
+	unsigned char chksum = 0;
+
+	r = gtx5_i2c_read(dev, TS_REG_COORDS_BASE,
+			  buffer, 3 + BYTES_PER_COORD/* * 1*/);
+	if (unlikely(r < 0))
+		return r;
+
+	/* buffer[0]: event state */
+	coord_sta = buffer[0];
+	if (unlikely(coord_sta == 0x00)) {
+		/* handle request event */
+		ts_event->event_type = EVENT_REQUEST;
+		gtx5_request_handler(dev, &ts_event->event_data.request_data);
+		goto exit_clean_sta;
+	} else if (unlikely((coord_sta & 0x80) != 0x80)) {
+		r = -EINVAL;
+		return r;
+	}
+
+	/* bit7 of coord_sta is 1, touch data is ready */
+	/* handle touch event */
+	touch_data->key_value = (coord_sta >> 4) & 0x01;
+	touch_num = coord_sta & 0x0F;
+	if (unlikely(touch_num > max_touch_num)) {
+		touch_num = -EINVAL;
+		goto exit_clean_sta;
+	} else if (unlikely(touch_num > 1)) {
+		r = gtx5_i2c_read(dev,
+				  TS_REG_COORDS_BASE + 3 + BYTES_PER_COORD,
+				  &buffer[3 + BYTES_PER_COORD],
+				  (touch_num - 1) * BYTES_PER_COORD);
+		if (unlikely(r < 0))
+			goto exit_clean_sta;
+	}
+
+	/* touch_num * BYTES_PER_COORD + 1(touch event state) + 1(checksum)
+	 * + 1(key value)
+	 */
+	chksum = checksum_u8(&buffer[0], touch_num * BYTES_PER_COORD + 3);
+	if (unlikely(chksum != 0)) {
+		dev_warn(dev->dev, "Checksum error:%X\n", chksum);
+		r = -EINVAL;
+		goto exit_clean_sta;
+	}
+
+	memset(touch_data->coords, 0x00, sizeof(touch_data->coords));
+	for (i = 0; i < touch_num; i++) {
+		coords->id = buffer[i * BYTES_PER_COORD + 1] & 0x0f;
+		coords->x = get_unaligned_le16(&buffer[i * BYTES_PER_COORD + 2]);
+		coords->y = get_unaligned_le16(&buffer[i * BYTES_PER_COORD + 4]);
+		coords->w = get_unaligned_le16(&buffer[i * BYTES_PER_COORD + 6]);
+
+		dev_dbg(dev->dev, "D:[%d](%d, %d)[%d]\n",
+			coords->id, coords->x, coords->y, coords->w);
+		coords++;
+	}
+
+	touch_data->touch_num = touch_num;
+	/* mark this event as touch event */
+	ts_event->event_type = EVENT_TOUCH;
+	r = 0;
+
+exit_clean_sta:
+	/* handshake */
+	buffer[0] = 0x00;
+	gtx5_i2c_write(dev, TS_REG_COORDS_BASE, buffer, 1);
+	return r;
+}
+
+int gtx5_send_command(struct gtx5_ts_device *dev,
+		      struct gtx5_ts_cmd *cmd)
+{
+	int ret;
+
+	if (!cmd || !cmd->initialized)
+		return -EINVAL;
+	ret = gtx5_i2c_write(dev, cmd->cmd_reg, cmd->cmds,
+			     cmd->length);
+	return ret;
+}
+
+static int gtx5_hw_suspend(struct gtx5_ts_device *dev)
+{
+	struct gtx5_ts_cmd *sleep_cmd =	&dev->sleep_cmd;
+	int r = 0;
+
+	if (sleep_cmd->initialized) {
+		r = gtx5_send_command(dev, sleep_cmd);
+		if (!r)
+			dev_dbg(dev->dev, "Chip in sleep mode\n");
+	} else {
+		dev_dbg(dev->dev, "Uninitialized sleep command\n");
+	}
+
+	return r;
+}
+
+static int gtx5_hw_resume(struct gtx5_ts_device *dev)
+{
+	struct gtx5_ts_version ver;
+	int r, retry = GTX5_BUS_RETRY_TIMES;
+
+	for (; retry--;) {
+		gtx5_hw_reset(dev);
+		r = gtx5_read_version(dev, &ver);
+		if (!r)
+			break;
+	}
+
+	return r;
+}
+
+/* hardware operation functions */
+static const struct gtx5_ts_hw_ops hw_i2c_ops = {
+	.init = gtx5_hw_init,
+	.read = gtx5_i2c_read,
+	.write = gtx5_i2c_write,
+	.reset = gtx5_hw_reset,
+	.event_handler = gtx5_event_handler,
+	.send_config = gtx5_send_config,
+	.send_cmd = gtx5_send_command,
+	.read_version = gtx5_read_version,
+	.suspend = gtx5_hw_suspend,
+	.resume = gtx5_hw_resume,
+};
+
+static struct platform_device *gtx5_pdev;
+static void gtx5_pdev_release(struct device *dev)
+{
+	kfree(gtx5_pdev);
+}
+
+static int gtx5_i2c_probe(struct i2c_client *client,
+			  const struct i2c_device_id *dev_id)
+{
+	struct gtx5_ts_device *ts_device = NULL;
+	struct gtx5_ts_board_data *ts_bdata = NULL;
+	int r = 0;
+
+	r = i2c_check_functionality(client->adapter,
+				    I2C_FUNC_I2C);
+	if (!r)
+		return -EIO;
+
+	/* board data */
+	ts_bdata = devm_kzalloc(&client->dev,
+				sizeof(struct gtx5_ts_board_data), GFP_KERNEL);
+	if (!ts_bdata)
+		return -ENOMEM;
+
+#ifdef CONFIG_OF
+	if (IS_ENABLED(CONFIG_OF) && client->dev.of_node) {
+		/* parse devicetree property */
+		r = gtx5_parse_dt(&client->dev, ts_bdata);
+		if (r < 0)
+			return r;
+	} else
+#endif
+	{
+		/* use platform data */
+		dev_info(&client->dev, "use platform data\n");
+		devm_kfree(&client->dev, ts_bdata);
+		ts_bdata = client->dev.platform_data;
+	}
+
+	if (!ts_bdata)
+		return -ENODEV;
+
+	ts_device = devm_kzalloc(&client->dev,
+				 sizeof(struct gtx5_ts_device), GFP_KERNEL);
+	if (!ts_device)
+		return -ENOMEM;
+
+	ts_bdata->irq = client->irq;
+	/*
+	 * Systems using device tree should set up interrupt via DTS,
+	 * the rest will use the default interrupts flags.
+	 */
+	ts_bdata->irq_flags = client->dev.of_node ? 0 : DEFAULT_IRQ_FLAGS;
+	ts_device->name = "GTx5 TouchDevice";
+	ts_device->dev = &client->dev;
+	ts_device->board_data = ts_bdata;
+	ts_device->hw_ops = &hw_i2c_ops;
+
+	/* ts core device */
+	gtx5_pdev = kzalloc(sizeof(*gtx5_pdev), GFP_KERNEL);
+	if (!gtx5_pdev)
+		return -ENOMEM;
+
+	gtx5_pdev->name = GTX5_CORE_DRIVER_NAME;
+	gtx5_pdev->id = 0;
+	gtx5_pdev->num_resources = 0;
+	/* you could find this platform dev in
+	 * /sys/devices/platform/gtx5_ts.0
+	 * gtx5_pdev->dev.parent = &client->dev;
+	 */
+	gtx5_pdev->dev.platform_data = ts_device;
+	gtx5_pdev->dev.release = gtx5_pdev_release;
+
+	/* register platform device, then the gtx5_ts_core module will probe
+	 * the touch device.
+	 */
+	r = platform_device_register(gtx5_pdev);
+	return r;
+}
+
+static int gtx5_i2c_remove(struct i2c_client *client)
+{
+	platform_device_unregister(gtx5_pdev);
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id gtx5_of_match[] = {
+	{.compatible = "goodix,gt7589"},
+	{.compatible = "goodix,gt8589"},
+	{.compatible = "goodix,gt9589"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, gtx5_of_match);
+#endif
+
+static const struct i2c_device_id gtx5_id_table[] = {
+	{TS_DRIVER_NAME, 0},
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, gtx5_id_table);
+
+static struct i2c_driver gtx5_i2c_driver = {
+	.driver = {
+		.name = TS_DRIVER_NAME,
+		.of_match_table = of_match_ptr(gtx5_of_match),
+	},
+	.probe = gtx5_i2c_probe,
+	.remove = gtx5_i2c_remove,
+	.id_table = gtx5_id_table,
+};
+module_i2c_driver(gtx5_i2c_driver);
+
+MODULE_DESCRIPTION("Goodix GTx5 Touchscreen Hardware Module");
+MODULE_AUTHOR("Goodix, Inc.");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

