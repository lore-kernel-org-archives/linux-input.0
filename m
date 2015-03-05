From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 1/2] HID: HID Sensor: Custom and Generic sensor support
Date: Thu,  5 Mar 2015 08:05:43 -0800
Message-ID: <1425571544-21324-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1425571544-21324-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:17350 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932902AbbCEQHN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 5 Mar 2015 11:07:13 -0500
In-Reply-To: <1425571544-21324-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, jic23@kernel.org
Cc: linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

HID Sensor Spec defines two usage ids for custom sensors
HID_USAGE_SENSOR_TYPE_OTHER_CUSTOM (0x09, 0xE1)
HID_USAGE_SENSOR_TYPE_OTHER_GENERIC(0x09, 0xE2)
The purpose of these sensors is to extend the functionality or provide a
way to obfuscate the data being communicated by a sensor. Without knowing the
mapping between the data and its encapsulated form, it is difficult for
an application/driver to determine what data is being communicated by the sensor.
This allows some differentiating use cases, where vendor can provide applications.
Some common use cases are debug other sensors or to provide some events like
keyboard attached/detached or lid open/close.
Since these can't be represented by standard sensor interfaces like IIO,
we present these as fields with
- type (input/output)
- units
- min/max
- get/set value
In addition an dev interface to transfer report events. Details about this
interface is described in /Documentation/hid/hid-sensor.txt.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/Kconfig             |  12 +
 drivers/hid/Makefile            |   1 +
 drivers/hid/hid-sensor-custom.c | 551 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 564 insertions(+)
 create mode 100644 drivers/hid/hid-sensor-custom.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 152b006..d1daab5 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -885,6 +885,18 @@ config HID_SENSOR_HUB
 	  for events and handle data streams. Each sensor driver can format
 	  data and present to user mode using input or IIO interface.
 
+config HID_SENSOR_CUSTOM_SENSOR
+	tristate "HID Sensors hub custom sensor support"
+	depends on HID_SENSOR_HUB
+	default n
+	---help---
+	  HID Sensor hub specification allows definition of some custom and
+	  generic sensors. Unlike other HID sensors, they can't be exported
+	  via Linux IIO. For example, these sensors define like opening of
+	  lid or keyboard attached. This is upto the manufacturer to decide
+	  how to interpret these special sensor ids and process in user space.
+	  Select this config option for custom/generic sensor support.
+
 endmenu
 
 endif # HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 6f19958..c90ce7b 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -101,6 +101,7 @@ obj-$(CONFIG_HID_WACOM)		+= wacom.o
 obj-$(CONFIG_HID_WALTOP)	+= hid-waltop.o
 obj-$(CONFIG_HID_WIIMOTE)	+= hid-wiimote.o
 obj-$(CONFIG_HID_SENSOR_HUB)	+= hid-sensor-hub.o
+obj-$(CONFIG_HID_SENSOR_CUSTOM_SENSOR)	+= hid-sensor-custom.o
 
 obj-$(CONFIG_USB_HID)		+= usbhid/
 obj-$(CONFIG_USB_MOUSE)		+= usbhid/
diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
new file mode 100644
index 0000000..283194a
--- /dev/null
+++ b/drivers/hid/hid-sensor-custom.c
@@ -0,0 +1,551 @@
+/*
+ * hid-sensor-custom.c
+ * Copyright (c) 2015, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/miscdevice.h>
+#include <linux/kfifo.h>
+#include <linux/sched.h>
+#include <linux/wait.h>
+#include <linux/platform_device.h>
+#include <linux/hid-sensor-hub.h>
+
+#define HID_CUSTOM_NAME_LENGTH		40
+#define HID_CUSTOM_MAX_CORE_ATTRS	10
+#define HID_CUSTOM_TOTAL_ATTRS		(HID_CUSTOM_MAX_CORE_ATTRS + 1)
+#define HID_CUSTOM_FIFO_SIZE		256
+#define HID_CUSTOM_MAX_FEATURE_BYTES	64
+
+struct hid_sensor_custom_field {
+	int report_id;
+	char group_name[HID_CUSTOM_NAME_LENGTH];
+	struct hid_sensor_hub_attribute_info attribute;
+	struct device_attribute sd_attrs[HID_CUSTOM_MAX_CORE_ATTRS];
+	char attr_name[HID_CUSTOM_TOTAL_ATTRS][HID_CUSTOM_NAME_LENGTH];
+	struct attribute *attrs[HID_CUSTOM_TOTAL_ATTRS];
+	struct attribute_group hid_custom_attribute_group;
+};
+
+struct hid_sensor_custom {
+	struct mutex mutex;
+	struct hid_sensor_hub_device *hsdev;
+	struct platform_device *pdev;
+	struct hid_sensor_hub_callbacks callbacks;
+	struct hid_sensor_custom_field *fields;
+	struct miscdevice custom_dev;
+	struct kfifo data_fifo;
+	unsigned long misc_opened;
+	wait_queue_head_t wait;
+	int sensor_field_count;
+	bool enable;
+};
+
+/* Header for each sample to user space via dev interface */
+struct hid_sensor_sample {
+	u32 usage_id;
+	u32 raw_len;
+};
+
+static struct attribute hid_custom_attrs[] = {
+	{.name = "units", .mode = S_IRUGO},
+	{.name = "unit-expo", .mode = S_IRUGO},
+	{.name = "minimum", .mode = S_IRUGO},
+	{.name = "maximum", .mode = S_IRUGO},
+	{.name = "size", .mode = S_IRUGO},
+	{.name = "value", .mode = S_IWUSR | S_IRUGO},
+	{.name = NULL}
+};
+
+static ssize_t enable_sensor_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct hid_sensor_custom *sensor_inst = platform_get_drvdata(pdev);
+
+	return sprintf(buf, "%d\n", sensor_inst->enable);
+}
+
+static ssize_t enable_sensor_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct hid_sensor_custom *sensor_inst = platform_get_drvdata(pdev);
+	int value;
+	int ret = -EINVAL;
+
+	if (kstrtoint(buf, 0, &value) != 0)
+		return -EINVAL;
+
+	mutex_lock(&sensor_inst->mutex);
+	if (value && !sensor_inst->enable) {
+		ret = sensor_hub_device_open(sensor_inst->hsdev);
+		if (!ret)
+			sensor_inst->enable = true;
+	} else if (!value && sensor_inst->enable) {
+		sensor_hub_device_close(sensor_inst->hsdev);
+		sensor_inst->enable = false;
+	}
+	mutex_unlock(&sensor_inst->mutex);
+
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+static DEVICE_ATTR_RW(enable_sensor);
+
+static struct attribute *enable_sensor_attrs[] = {
+	&dev_attr_enable_sensor.attr,
+	NULL,
+};
+
+static struct attribute_group enable_sensor_attr_group = {
+	.attrs = enable_sensor_attrs,
+};
+
+static ssize_t show_value(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct hid_sensor_custom *sensor_inst = platform_get_drvdata(pdev);
+	int index, usage;
+	char name[HID_CUSTOM_NAME_LENGTH];
+	bool feature = false;
+	bool input = false;
+	int value = 0;
+
+	if (sscanf(attr->attr.name, "feature-%d-%x-%s", &index, &usage,
+		   name) == 3)
+		feature = true;
+	else if (sscanf(attr->attr.name, "input-%d-%x-%s", &index, &usage,
+		   name) == 3)
+		input = true;
+	else
+		return -EINVAL;
+
+	if (!strncmp(name, "value", strlen("value"))) {
+		u32 report_id;
+		int ret;
+
+		report_id = sensor_inst->fields[index].attribute.report_id;
+		if (feature) {
+			u8 values[HID_CUSTOM_MAX_FEATURE_BYTES];
+			int len = 0;
+			int i;
+
+			ret = sensor_hub_get_feature(sensor_inst->hsdev,
+						     report_id, index,
+						     sizeof(values), values);
+			if (ret < 0)
+				return ret;
+
+			for (i = 0; i < ret; ++i)
+				len += snprintf(&buf[len], PAGE_SIZE - len,
+						"%d ", values[i]);
+			len += snprintf(&buf[len], PAGE_SIZE - len, "\n");
+
+			return len;
+		} else if (input)
+			value = sensor_hub_input_attr_get_raw_value(
+						sensor_inst->hsdev,
+						sensor_inst->hsdev->usage,
+						usage, report_id,
+						SENSOR_HUB_SYNC);
+	} else if (!strncmp(name, "units", strlen("units")))
+		value = sensor_inst->fields[index].attribute.units;
+	else if (!strncmp(name, "unit-expo", strlen("unit-expo")))
+		value = sensor_inst->fields[index].attribute.unit_expo;
+	else if (!strncmp(name, "size", strlen("size")))
+		value = sensor_inst->fields[index].attribute.size;
+	else if (!strncmp(name, "minimum", strlen("minimum")))
+		value = sensor_inst->fields[index].attribute.logical_minimum;
+	else if (!strncmp(name, "maximum", strlen("maximum")))
+		value = sensor_inst->fields[index].attribute.logical_maximum;
+	else
+		return -EINVAL;
+
+	return sprintf(buf, "%d\n", value);
+}
+
+static ssize_t store_value(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct hid_sensor_custom *sensor_inst = platform_get_drvdata(pdev);
+	int index, usage;
+	char name[HID_CUSTOM_NAME_LENGTH];
+	bool feature = false;
+	int value;
+
+	if (sscanf(attr->attr.name, "feature-%d-%x-%s", &index, &usage,
+		   name) == 3)
+		feature = true;
+	else
+		return -EINVAL;
+
+	if (!strncmp(name, "value", strlen("value"))) {
+		u32 report_id;
+		int ret;
+
+		if (kstrtoint(buf, 0, &value) != 0)
+			return -EINVAL;
+
+		report_id = sensor_inst->fields[index].attribute.report_id;
+		if (feature)
+			ret = sensor_hub_set_feature(sensor_inst->hsdev,
+						     report_id, index,
+						     sizeof(value), &value);
+	} else
+		return -EINVAL;
+
+	return count;
+}
+
+static int hid_sensor_push_sample(struct hid_sensor_hub_device *hsdev,
+				  unsigned usage_id, size_t raw_len,
+				  char *raw_data, void *priv)
+{
+	struct hid_sensor_custom *sensor_inst = platform_get_drvdata(priv);
+	int required_size = sizeof(struct hid_sensor_sample) + raw_len;
+	struct hid_sensor_sample header;
+
+	header.usage_id = usage_id;
+	header.raw_len = raw_len;
+	if (kfifo_avail(&sensor_inst->data_fifo) >= required_size) {
+		kfifo_in(&sensor_inst->data_fifo, (unsigned char *)&header,
+			 sizeof(header));
+		kfifo_in(&sensor_inst->data_fifo, (unsigned char *)raw_data,
+			 raw_len);
+		wake_up(&sensor_inst->wait);
+	}
+
+	return 0;
+}
+
+static int hid_sensor_custom_add_field(struct hid_sensor_custom *sensor_inst,
+				       int index, int report_type,
+				       struct hid_report *report,
+				       struct hid_field *field)
+{
+	struct hid_sensor_custom_field *sensor_field;
+	void *fields;
+
+	fields = krealloc(sensor_inst->fields,
+			  (sensor_inst->sensor_field_count + 1) *
+			   sizeof(struct hid_sensor_custom_field), GFP_KERNEL);
+	if (!fields) {
+		kfree(sensor_inst->fields);
+		return -ENOMEM;
+	}
+	sensor_inst->fields = fields;
+	sensor_field = &sensor_inst->fields[sensor_inst->sensor_field_count];
+	sensor_field->attribute.usage_id = sensor_inst->hsdev->usage;
+	if (field->logical)
+		sensor_field->attribute.attrib_id = field->logical;
+	else
+		sensor_field->attribute.attrib_id = field->usage[0].hid;
+
+	sensor_field->attribute.index = index;
+	sensor_field->attribute.report_id = report->id;
+	sensor_field->attribute.units = field->unit;
+	sensor_field->attribute.unit_expo = field->unit_exponent;
+	sensor_field->attribute.size = (field->report_size *
+						field->report_count)/8;
+	sensor_field->attribute.logical_minimum = field->logical_minimum;
+	sensor_field->attribute.logical_maximum = field->logical_maximum;
+
+	if (report_type == HID_FEATURE_REPORT)
+		snprintf(sensor_field->group_name,
+			 sizeof(sensor_field->group_name), "feature-%x-%x",
+			 sensor_field->attribute.index,
+			 sensor_field->attribute.attrib_id);
+	else if (report_type == HID_INPUT_REPORT)
+		snprintf(sensor_field->group_name,
+			 sizeof(sensor_field->group_name),
+			 "input-%x-%x", sensor_field->attribute.index,
+			 sensor_field->attribute.attrib_id);
+
+	memset(&sensor_field->hid_custom_attribute_group, 0,
+	       sizeof(struct attribute_group));
+	sensor_inst->sensor_field_count++;
+
+	return 0;
+}
+
+static int hid_sensor_custom_add_attributes(
+					struct hid_sensor_custom *sensor_inst)
+{
+	struct hid_sensor_hub_device *hsdev = sensor_inst->hsdev;
+	struct hid_report *report;
+	struct hid_field *field;
+	struct hid_report_enum *report_enum;
+	struct hid_device *hdev = hsdev->hdev;
+	int ret = -1;
+	int i, j;
+
+	for (j = 0; j < HID_REPORT_TYPES; ++j) {
+		if (j == HID_OUTPUT_REPORT)
+			continue;
+
+		report_enum = &hdev->report_enum[j];
+		list_for_each_entry(report, &report_enum->report_list, list) {
+			for (i = 0; i < report->maxfield; ++i) {
+				field = report->field[i];
+				if (field->maxusage &&
+				    ((field->usage[0].collection_index >=
+				      hsdev->start_collection_index) &&
+				      (field->usage[0].collection_index <
+				       hsdev->end_collection_index))) {
+
+					ret = hid_sensor_custom_add_field(
+								sensor_inst,
+								i, j, report,
+								field);
+					if (ret)
+						return ret;
+
+				}
+			}
+		}
+	}
+
+	/* Create sysfs attributes */
+	for (i = 0; i < sensor_inst->sensor_field_count; ++i) {
+		j = 0;
+		while (j < HID_CUSTOM_TOTAL_ATTRS && hid_custom_attrs[j].name) {
+			snprintf((char *)&sensor_inst->fields[i].attr_name[j],
+				 HID_CUSTOM_NAME_LENGTH, "%s-%s",
+				 sensor_inst->fields[i].group_name,
+				 hid_custom_attrs[j].name);
+			sysfs_attr_init(&sensor_inst->fields[i].sd_attrs[j].
+					dev_attr.attr);
+			sensor_inst->fields[i].sd_attrs[j].attr.name =
+				(char *)&sensor_inst->fields[i].attr_name[j];
+			sensor_inst->fields[i].sd_attrs[j].attr.mode =
+				hid_custom_attrs[j].mode;
+			sensor_inst->fields[i].sd_attrs[j].show = show_value;
+			if (hid_custom_attrs[j].mode & S_IWUSR)
+				sensor_inst->fields[i].sd_attrs[j].store =
+								store_value;
+			sensor_inst->fields[i].attrs[j] =
+				&sensor_inst->fields[i].sd_attrs[j].attr;
+			++j;
+		}
+		sensor_inst->fields[i].attrs[j] = NULL;
+		sensor_inst->fields[i].hid_custom_attribute_group.attrs =
+						sensor_inst->fields[i].attrs;
+		sensor_inst->fields[i].hid_custom_attribute_group.name =
+					sensor_inst->fields[i].group_name;
+		ret = sysfs_create_group(&sensor_inst->pdev->dev.kobj,
+					 &sensor_inst->fields[i].
+						hid_custom_attribute_group);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static ssize_t hid_sensor_custom_read(struct file *file, char __user *buf,
+				      size_t count, loff_t *f_ps)
+{
+	struct hid_sensor_custom *sensor_inst;
+	unsigned int copied;
+	int ret;
+
+	sensor_inst = container_of(file->private_data,
+				   struct hid_sensor_custom, custom_dev);
+
+	if (count < sizeof(struct hid_sensor_sample))
+		return -EINVAL;
+	do {
+		if (kfifo_is_empty(&sensor_inst->data_fifo)) {
+			if (file->f_flags & O_NONBLOCK)
+				return -EAGAIN;
+
+			ret = wait_event_interruptible(sensor_inst->wait,
+				!kfifo_is_empty(&sensor_inst->data_fifo));
+			if (ret)
+				return ret;
+		}
+		ret = kfifo_to_user(&sensor_inst->data_fifo, buf, count,
+				    &copied);
+		if (ret)
+			return ret;
+	} while (copied == 0);
+
+	return copied;
+}
+
+static int hid_sensor_custom_release(struct inode *inode, struct file *file)
+{
+	struct hid_sensor_custom *sensor_inst;
+
+	sensor_inst = container_of(file->private_data,
+				   struct hid_sensor_custom, custom_dev);
+
+	clear_bit(0, &sensor_inst->misc_opened);
+
+	return 0;
+}
+
+static int hid_sensor_custom_open(struct inode *inode, struct file *file)
+{
+	struct hid_sensor_custom *sensor_inst;
+
+	sensor_inst = container_of(file->private_data,
+				   struct hid_sensor_custom, custom_dev);
+	/* We essentially have single reader and writer */
+	if (test_and_set_bit(0, &sensor_inst->misc_opened))
+		return -EBUSY;
+
+	return nonseekable_open(inode, file);
+}
+
+static const struct file_operations hid_sensor_custom_fops = {
+	.open =  hid_sensor_custom_open,
+	.read =  hid_sensor_custom_read,
+	.release = hid_sensor_custom_release,
+	.llseek = noop_llseek,
+};
+
+static int hid_sensor_custom_dev_if(struct hid_sensor_custom *sensor_inst)
+{
+	int ret;
+
+	ret = kfifo_alloc(&sensor_inst->data_fifo, HID_CUSTOM_FIFO_SIZE,
+			  GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	init_waitqueue_head(&sensor_inst->wait);
+
+	sensor_inst->custom_dev.minor = MISC_DYNAMIC_MINOR;
+	sensor_inst->custom_dev.name = dev_name(&sensor_inst->pdev->dev);
+	sensor_inst->custom_dev.fops = &hid_sensor_custom_fops,
+	ret = misc_register(&sensor_inst->custom_dev);
+	if (ret) {
+		kfifo_free(&sensor_inst->data_fifo);
+		return ret;
+	}
+	return 0;
+}
+
+static int hid_sensor_custom_probe(struct platform_device *pdev)
+{
+	struct hid_sensor_custom *sensor_inst;
+	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
+	int ret;
+	int i;
+
+	sensor_inst = kzalloc(sizeof(*sensor_inst), GFP_KERNEL);
+	if (!sensor_inst)
+		return -ENOMEM;
+
+	sensor_inst->callbacks.capture_sample = hid_sensor_push_sample;
+	sensor_inst->callbacks.pdev = pdev;
+	sensor_inst->hsdev = hsdev;
+	sensor_inst->pdev = pdev;
+	mutex_init(&sensor_inst->mutex);
+	platform_set_drvdata(pdev, sensor_inst);
+	ret = sensor_hub_register_callback(hsdev, hsdev->usage,
+					   &sensor_inst->callbacks);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "callback reg failed\n");
+		goto err_free_inst;
+	}
+
+	ret = sysfs_create_group(&sensor_inst->pdev->dev.kobj,
+				 &enable_sensor_attr_group);
+	if (ret)
+		goto err_remove_callback;
+
+	ret = hid_sensor_custom_add_attributes(sensor_inst);
+	if (ret)
+		goto err_remove_group;
+
+	ret = hid_sensor_custom_dev_if(sensor_inst);
+	if (ret)
+		goto err_remove_attributes;
+
+	return 0;
+
+err_remove_attributes:
+	for (i = 0; i < sensor_inst->sensor_field_count; ++i)
+		sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
+				   &sensor_inst->fields[i].
+				   hid_custom_attribute_group);
+	kfree(sensor_inst->fields);
+
+err_remove_group:
+	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
+			   &enable_sensor_attr_group);
+err_remove_callback:
+	sensor_hub_remove_callback(hsdev, hsdev->usage);
+err_free_inst:
+	kfree(sensor_inst);
+
+	return ret;
+}
+
+static int hid_sensor_custom_remove(struct platform_device *pdev)
+{
+	int i;
+	struct hid_sensor_custom *sensor_inst = platform_get_drvdata(pdev);
+	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
+
+	wake_up(&sensor_inst->wait);
+	misc_deregister(&sensor_inst->custom_dev);
+	kfifo_free(&sensor_inst->data_fifo);
+
+	for (i = 0; i < sensor_inst->sensor_field_count; ++i)
+		sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
+				   &sensor_inst->fields[i].
+				   hid_custom_attribute_group);
+	kfree(sensor_inst->fields);
+	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
+			   &enable_sensor_attr_group);
+	sensor_hub_remove_callback(hsdev, hsdev->usage);
+	kfree(sensor_inst);
+
+	return 0;
+}
+
+static struct platform_device_id hid_sensor_custom_ids[] = {
+	{
+		.name = "HID-SENSOR-2000e1",
+	},
+	{
+		.name = "HID-SENSOR-2000e2",
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, hid_sensor_custom_ids);
+
+static struct platform_driver hid_sensor_custom_platform_driver = {
+	.id_table = hid_sensor_custom_ids,
+	.driver = {
+		.name	= KBUILD_MODNAME,
+	},
+	.probe		= hid_sensor_custom_probe,
+	.remove		= hid_sensor_custom_remove,
+};
+module_platform_driver(hid_sensor_custom_platform_driver);
+
+MODULE_DESCRIPTION("HID Sensor Custom and Generic sensor Driver");
+MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
+MODULE_LICENSE("GPL");
-- 
1.9.1

