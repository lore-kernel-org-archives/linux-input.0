From: srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH, 2/7] HID-Sensors: Sensor framework
Date: Wed,  6 Jun 2012 08:39:19 -0700
Message-ID: <1338997164-5077-3-git-send-email-srinivas.pandruvada@intel.com>
References: <1338997164-5077-1-git-send-email-srinivas.pandruvada@intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1338997164-5077-1-git-send-email-srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Adding processing for HID Sensor usage table as defined by
HID 1.12, Request #: HUTRR39, dated 05 May, 2011.
This driver uses HID driver framework to register, send and
receive events.
This delegated the actual usage id processing to different
modules, which are registered statically.

Signed-off-by: srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/staging/Kconfig                            |    2 +
 drivers/staging/Makefile                           |    1 +
 drivers/staging/hid-sensors/Kconfig                |   19 +
 drivers/staging/hid-sensors/Makefile               |    9 +
 drivers/staging/hid-sensors/hid-sensor-hub.c       |  705 ++++++++++++++++++++
 drivers/staging/hid-sensors/hid-sensor-ids.h       |  117 ++++
 drivers/staging/hid-sensors/hid-sensor-interface.h |   75 ++
 7 files changed, 928 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/hid-sensors/Kconfig
 create mode 100644 drivers/staging/hid-sensors/Makefile
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-hub.c
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-ids.h
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-interface.h

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 97d412d..562700a 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -80,6 +80,8 @@ source "drivers/staging/sep/Kconfig"
 
 source "drivers/staging/iio/Kconfig"
 
+source "drivers/staging/hid-sensors/Kconfig"
+
 source "drivers/staging/zram/Kconfig"
 
 source "drivers/staging/zcache/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index ffe7d44..f53f0d4 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_VT6656)		+= vt6656/
 obj-$(CONFIG_VME_BUS)		+= vme/
 obj-$(CONFIG_DX_SEP)            += sep/
 obj-$(CONFIG_IIO)		+= iio/
+obj-$(CONFIG_HID_SENSORS)	+= hid-sensors/
 obj-$(CONFIG_ZRAM)		+= zram/
 obj-$(CONFIG_ZCACHE)		+= zcache/
 obj-$(CONFIG_ZSMALLOC)		+= zsmalloc/
diff --git a/drivers/staging/hid-sensors/Kconfig b/drivers/staging/hid-sensors/Kconfig
new file mode 100644
index 0000000..be442f8
--- /dev/null
+++ b/drivers/staging/hid-sensors/Kconfig
@@ -0,0 +1,19 @@
+#
+# Sensor HUB subsytem configuration
+#
+
+menuconfig HID_SENSORS
+	tristate "HID Sensor Core"
+	select USB_HID
+	select IIO
+	select IIO_RING_BUFFER
+	select IIO_SW_RING
+	help
+	  Support for HID Sensor hub based on HID 1.12 sensor usage table
+
+menuconfig HID_SENSOR_DEBUG
+	tristate "HID Sensor debug support"
+	depends on HID_SENSORS
+	default n
+	help
+	  Debug support for Hid sensors
diff --git a/drivers/staging/hid-sensors/Makefile b/drivers/staging/hid-sensors/Makefile
new file mode 100644
index 0000000..13591b2
--- /dev/null
+++ b/drivers/staging/hid-sensors/Makefile
@@ -0,0 +1,9 @@
+#
+# Makefile for the HID Sensors.
+#
+ccflags-y += -Idrivers/hid
+ccflags-y += -Idrivers/staging
+ccflags-$(CONFIG_HID_SENSOR_DEBUG) += -DDEBUG
+
+hid-sensors-y := hid-sensor-hub.o
+obj-$(CONFIG_HID_SENSORS) += hid-sensors.o
diff --git a/drivers/staging/hid-sensors/hid-sensor-hub.c b/drivers/staging/hid-sensors/hid-sensor-hub.c
new file mode 100644
index 0000000..384e0d0
--- /dev/null
+++ b/drivers/staging/hid-sensors/hid-sensor-hub.c
@@ -0,0 +1,705 @@
+/*
+ * HID Sensors Driver
+ * Copyright (c) 2012, Intel Corporation.
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
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ */
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/usb.h>
+#include "usbhid/usbhid.h"
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#include "hid-ids.h"
+#include "hid-sensor-ids.h"
+#include "hid-sensor-interface.h"
+
+#define RAW_BUFFER_SIZE	128
+#define sensor_hub_in_report(id, dev) sensor_hub_report(id, dev,\
+							HID_INPUT_REPORT)
+#define sensor_hub_out_report(id, dev) sensor_hub_report(id, dev,\
+							HID_OUTPUT_REPORT)
+#define sensor_hub_feature_report(id, dev) sensor_hub_report(id, dev,\
+							HID_FEATURE_REPORT)
+
+/* Description of in-progress IO operation, used for operations
+ * that trigger response from device */
+struct sensor_hub_pending {
+	struct completion ready;
+	u32 usage_id;
+	u32 attr_usage_id;
+	int raw_size;
+	u8 raw_data[RAW_BUFFER_SIZE];
+};
+
+struct sensor_hub_data {
+	struct hid_device *hdev;
+	struct mutex mutex;
+	spinlock_t lock;
+	struct sensor_hub_pending *pending;
+};
+
+struct sensor_hub_callbacks_list {
+	u32 usage_id;
+	struct sensor_hub_callbacks* (*reg_callback)(void);
+	int initialized;
+	void *priv;
+};
+
+static struct sensor_hub_callbacks_list usage_callbacks[] = {
+	{0}
+};
+
+/* Utility functions */
+
+static int sensor_hub_check_for_sensor_page(struct hid_device *hdev)
+{
+	int i;
+	int ret = -1;
+
+	for (i = 0; i < hdev->maxcollection; i++) {
+		struct hid_collection *col = &hdev->collection[i];
+		if (col->type == HID_COLLECTION_PHYSICAL &&
+		   (col->usage & HID_USAGE_PAGE) == HID_UP_SENSOR) {
+			ret = 0;
+			break;
+		}
+	}
+	return ret;
+}
+
+static struct hid_report *sensor_hub_report(int id, struct hid_device *hdev,
+						int dir)
+{
+	struct list_head *feature_report_list =
+					&hdev->report_enum[dir].report_list;
+	struct hid_report *report = NULL;
+
+	list_for_each_entry(report, feature_report_list, list) {
+		if (report->id == id)
+			return report;
+	}
+	hid_warn(hdev, "No report with id 0x%x found\n", id);
+	return NULL;
+}
+
+static struct sensor_hub_callbacks *sensor_hub_get_callback(u32 usage_id,
+							void **priv)
+{
+	int j;
+	struct sensor_hub_callbacks *callback = NULL;
+
+	j = 0;
+	while (usage_callbacks[j].usage_id != 0) {
+		if (usage_callbacks[j].initialized &&
+			usage_callbacks[j].usage_id == usage_id) {
+			callback = usage_callbacks[j].reg_callback();
+			*priv = usage_callbacks[j].priv;
+			break;
+		}
+		++j;
+	}
+	return callback;
+}
+
+static int sensor_hub_init_callbacks(struct hid_device *hdev)
+{
+	int i, j;
+	int ret = 0;
+	struct sensor_hub_callbacks *callback;
+
+	for (i = 0; i < hdev->maxcollection; ++i) {
+		struct hid_collection *collection = &hdev->collection[i];
+		hid_dbg(hdev, "c:%d t:0x%x u:0x%x l:0x%x\n",
+				i, collection->type,
+				collection->usage, collection->level);
+		j = 0;
+		while (usage_callbacks[j].usage_id != 0) {
+			if (collection->usage == usage_callbacks[j].usage_id) {
+				callback = usage_callbacks[j].reg_callback();
+				ret = callback->enter(hdev, collection->usage,
+					&usage_callbacks[j].priv);
+				if (ret) {
+					hid_err(hdev, "Failed:usage id:0x%x\n",
+						collection->usage);
+					break;
+				}
+				usage_callbacks[j].initialized = 1;
+			}
+			++j;
+		}
+	}
+	return ret;
+}
+
+#if (defined CONFIG_HID_SENSOR_DEBUG) || \
+	(defined CONFIG_HID_SENSOR_DEBUG_MODULE)
+static void dump_report(struct hid_device *hdev)
+{
+	int i, j;
+	struct hid_report *report;
+	struct hid_field *field;
+	struct hid_report_enum *report_enum;
+
+	hid_dbg(hdev, "Bus:0x%x Vendor:0x%x Product:0x%x\n", hdev->bus,
+			hdev->vendor, hdev->product);
+	hid_dbg(hdev, "rsize=%d, max_collections:%d\n", hdev->rsize,
+			hdev->maxcollection);
+	for (i = 0; i < hdev->maxcollection; ++i) {
+		struct hid_collection *collection = &hdev->collection[i];
+		hid_dbg(hdev, "c:%d t:0x%x u:0x%x l:0x%x\n",
+				 i, collection->type, collection->usage,
+				collection->level);
+	}
+
+	hid_dbg(hdev, "report_enum[HID_INPUT_REPORT]\n");
+	report_enum = &hdev->report_enum[HID_INPUT_REPORT];
+	list_for_each_entry(report, &report_enum->report_list, list) {
+		hid_dbg(hdev, "Report id:%x\n", report->id);
+		for (i = 0; i < report->maxfield; ++i) {
+			field = report->field[i];
+			for (j = 0; j < field->maxusage; ++j) {
+				hid_dbg(hdev, "usage hid:%x c_index:%x\n",
+				field->usage[j].hid,
+				field->usage[j].collection_index);
+			}
+			hid_dbg(hdev, "units:%x expo:%x\n",
+				field->unit,
+				field->unit_exponent);
+		}
+	}
+
+	hid_dbg(hdev, "report_enum[HID_OUTPUT_REPORT]\n");
+	report_enum = &hdev->report_enum[HID_OUTPUT_REPORT];
+	list_for_each_entry(report, &report_enum->report_list, list) {
+		hid_dbg(hdev, "Report id:%x\n", report->id);
+		for (i = 0; i < report->maxfield; ++i) {
+			field = report->field[i];
+			for (j = 0; j < field->maxusage; ++j) {
+				hid_dbg(hdev, "usage hid:%x c_index:%x\n",
+				field->usage[j].hid,
+				field->usage[j].collection_index);
+			}
+			hid_dbg(hdev, "units:%x expo:%x\n",
+				field->unit,
+				field->unit_exponent);
+
+		}
+	}
+
+	hid_dbg(hdev, "report_enum[HID_FEATURE_REPORT]\n");
+	report_enum = &hdev->report_enum[HID_FEATURE_REPORT];
+	list_for_each_entry(report, &report_enum->report_list, list) {
+		hid_dbg(hdev, "Report id:%x\n", report->id);
+		for (i = 0; i < report->maxfield; ++i) {
+			field = report->field[i];
+			for (j = 0; j < field->maxusage; ++j) {
+				hid_dbg(hdev, "u hid:%x c_index:%x\n",
+				field->usage[j].hid,
+				field->usage[j].collection_index);
+			}
+			hid_dbg(hdev, "units:%x expo:%x\n",
+				field->unit,
+				field->unit_exponent);
+		}
+	}
+}
+
+static void dump_raw_data(struct hid_device *hdev, int size, u8 *pdata)
+{
+	int j = 0;
+
+	for (j = 0; j < size; ++j)
+		hid_dbg(hdev, "0x%x\n", *pdata++);
+}
+#endif
+
+int sensor_hub_set_feature(struct hid_device *hdev, u32 report_id,
+				u32 field_index, s32 value)
+{
+	struct hid_report *report;
+	struct sensor_hub_data *data =  hid_get_drvdata(hdev);
+	int ret = 0;
+
+	mutex_lock(&data->mutex);
+	report = sensor_hub_feature_report(report_id, hdev);
+	if (!report) {
+		ret = -EINVAL;
+		goto done_proc;
+	}
+	if (field_index >=  report->maxfield) {
+		ret = -EINVAL;
+		goto done_proc;
+	}
+	hid_set_field(report->field[field_index], 0, value);
+	usbhid_submit_report(hdev, report, USB_DIR_OUT);
+	usbhid_wait_io(hdev);
+done_proc:
+	mutex_unlock(&data->mutex);
+	return ret;
+}
+
+int sensor_hub_get_feature(struct hid_device *hdev, u32 report_id,
+				u32 field_index, s32 *value)
+{
+	struct hid_report *report;
+	struct sensor_hub_data *data =  hid_get_drvdata(hdev);
+	int ret = 0;
+
+	mutex_lock(&data->mutex);
+	report = sensor_hub_feature_report(report_id, hdev);
+	if (!report) {
+		ret = -EINVAL;
+		goto done_proc;
+	}
+	if (field_index >=  report->maxfield) {
+		ret = -EINVAL;
+		goto done_proc;
+	}
+	usbhid_submit_report(hdev, report, USB_DIR_IN);
+	usbhid_wait_io(hdev);
+	*value = report->field[field_index]->value[0];
+done_proc:
+	mutex_unlock(&data->mutex);
+	return ret;
+}
+
+static int sensor_hub_get_report_id(struct hid_device *hdev, u8 type,
+					u32 usage_id, u32 field_usage_id,
+					int *index)
+{
+	int ret = -1;
+	int i, j;
+	int collection_index = -1;
+	struct hid_report *report;
+	struct hid_field *field;
+	struct hid_report_enum *report_enum;
+
+	*index = 0;
+	for (i = 0; i < hdev->maxcollection; ++i) {
+		struct hid_collection *collection = &hdev->collection[i];
+		if (usage_id == collection->usage) {
+			collection_index = i;
+			break;
+		}
+	}
+	if (collection_index == -1)
+		goto err_ret;
+
+	report_enum = &hdev->report_enum[type];
+	list_for_each_entry(report, &report_enum->report_list, list) {
+		for (i = 0; i < report->maxfield; ++i) {
+			field = report->field[i];
+			for (j = 0; j < field->maxusage; ++j) {
+				if (field->usage[j].hid == field_usage_id &&
+					field->usage[j].collection_index ==
+							collection_index)  {
+					*index = i;
+					ret = report->id;
+					hid_dbg(hdev, "Found usage hid\n");
+					hid_dbg(hdev, "r:%x id:%x c:%x f:%x\n",
+					ret, field->usage[j].hid,
+					field->usage[j].collection_index,
+					*index);
+					break;
+				}
+			}
+		}
+	}
+
+err_ret:
+	return ret;
+}
+
+/* Interface functions for sensor usage id clients */
+int sensor_hub_get_field_usage_index(struct hid_device *hdev, u32 *report_id,
+					u32 usage_id, u32 field_usage_id)
+{
+	int id;
+	int index = -1;
+
+	id = sensor_hub_get_report_id(hdev, HID_INPUT_REPORT, usage_id,
+					field_usage_id, &index);
+	if (id >= 0) {
+		*report_id = id;
+		goto done_proc;
+	}
+
+	id = sensor_hub_get_report_id(hdev, HID_OUTPUT_REPORT, usage_id,
+					field_usage_id, &index);
+	if (id >= 0) {
+		*report_id = id;
+		goto done_proc;
+	}
+
+	id = sensor_hub_get_report_id(hdev, HID_FEATURE_REPORT, usage_id,
+					field_usage_id, &index);
+	if (id >= 0) {
+		*report_id = id;
+		goto done_proc;
+	}
+
+done_proc:
+	return index;
+}
+
+ssize_t sensor_hub_input_attr_get_value(struct hid_device *hdev, u32 usage_id,
+					u32 attr_usage_id, u32 report_id,
+					u32 buf_len, u8 *buf)
+{
+	int len = -1;
+	struct sensor_hub_data *data =  hid_get_drvdata(hdev);
+	struct sensor_hub_pending *work;
+	unsigned long flags;
+	struct hid_report *report;
+
+	work = kzalloc(sizeof(*work), GFP_KERNEL);
+	if (!work)
+		return len;
+
+	init_completion(&work->ready);
+	work->usage_id = usage_id;
+	work->attr_usage_id = attr_usage_id;
+	work->raw_size = 0;
+
+	mutex_lock(&data->mutex);
+	spin_lock_irqsave(&data->lock, flags);
+	data->pending = work;
+	report = sensor_hub_in_report(report_id, data->hdev);
+	if (!report)
+		goto err_free;
+	usbhid_submit_report(data->hdev, report, USB_DIR_IN);
+	spin_unlock_irqrestore(&data->lock, flags);
+	wait_for_completion_interruptible_timeout(&work->ready, HZ*5);
+	if (work->raw_size)
+		len = snprintf(buf, buf_len, "%x\n", *(u32 *)work->raw_data);
+
+err_free:
+	data->pending = NULL;
+	mutex_unlock(&data->mutex);
+
+	kfree(work);
+	return len;
+}
+
+
+int sensor_hub_input_get_attribute_info(struct hid_device *hdev , u8 type,
+					u32 usage_id,
+					u32 attr_usage_id,
+				struct hid_sensor_hub_attribute_info *info)
+{
+	int ret = -1;
+	int i, j;
+	int collection_index = -1;
+	struct hid_report *report;
+	struct hid_field *field;
+	struct hid_report_enum *report_enum;
+
+	/* Initialize with defaults */
+	info->usage_id = usage_id;
+	info->attrib_id =  attr_usage_id;
+	info->report_id = -1;
+	info->index = -1;
+	info->units = -1;
+	info->unit_expo = -1;
+
+	for (i = 0; i < hdev->maxcollection; ++i) {
+		struct hid_collection *collection = &hdev->collection[i];
+		if (usage_id == collection->usage) {
+			collection_index = i;
+			break;
+		}
+	}
+	if (collection_index == -1)
+		goto err_ret;
+
+	report_enum = &hdev->report_enum[type];
+	list_for_each_entry(report, &report_enum->report_list, list) {
+		for (i = 0; i < report->maxfield; ++i) {
+			field = report->field[i];
+			for (j = 0; j < field->maxusage; ++j) {
+				if (field->usage[j].hid == attr_usage_id &&
+					field->usage[j].collection_index ==
+					collection_index)  {
+					info->index = i;
+					info->report_id = report->id;
+					info->units = field->unit;
+					info->unit_expo = field->unit_exponent;
+					break;
+				}
+			}
+		}
+	}
+err_ret:
+	return ret;
+
+}
+
+#ifdef CONFIG_PM
+static int sensor_hub_suspend(struct hid_device *hdev, pm_message_t message)
+{
+	int j;
+	struct sensor_hub_callbacks *callback;
+
+	hid_dbg(hdev, " sensor_hub_suspend\n");
+	j = 0;
+	while (usage_callbacks[j].usage_id != 0) {
+		if (usage_callbacks[j].initialized) {
+			callback = usage_callbacks[j].reg_callback();
+			if (callback->suspend)
+				callback->suspend(hdev,
+						  usage_callbacks[j].priv);
+		}
+		++j;
+	}
+	return 0;
+}
+
+static int sensor_hub_resume(struct hid_device *hdev)
+{
+	int j;
+	struct sensor_hub_callbacks *callback;
+
+	hid_dbg(hdev, " sensor_hub_resume\n");
+	j = 0;
+	while (usage_callbacks[j].usage_id != 0) {
+		if (usage_callbacks[j].initialized) {
+			callback = usage_callbacks[j].reg_callback();
+			if (callback->resume)
+				callback->resume(hdev,
+					usage_callbacks[j].priv);
+		}
+		++j;
+	}
+	return 0;
+}
+
+static int sensor_hub_reset_resume(struct hid_device *hdev)
+{
+	return 0;
+}
+#endif
+
+/*
+ * Handle raw report as sent by device
+ */
+static int sensor_hub_raw_event(struct hid_device *hdev,
+		struct hid_report *report, u8 *raw_data, int size)
+{
+	int i;
+	u8 *ptr;
+	int sz;
+	struct sensor_hub_data *pdata = hid_get_drvdata(hdev);
+	unsigned long flags;
+	struct sensor_hub_callbacks *callback = NULL;
+	struct hid_collection *collection = NULL;
+	void *priv = NULL;
+
+	hid_dbg(hdev, "sensor_hub_raw_event report id:0x%x size:%d type:%d\n",
+			 report->id, size, report->type);
+	hid_dbg(hdev, "maxfield:%d\n", report->maxfield);
+#if (defined CONFIG_HID_SENSOR_DEBUG) || \
+	(defined CONFIG_HID_SENSOR_DEBUG_MODULE)
+	dump_raw_data(hdev, size, raw_data);
+#endif
+	if (report->type != HID_INPUT_REPORT)
+		return 1;
+
+	ptr = raw_data;
+	ptr++; /*Skip report id*/
+
+	if (!report)
+		goto err_report;
+
+	spin_lock_irqsave(&pdata->lock, flags);
+
+	for (i = 0; i < report->maxfield; ++i) {
+
+		hid_dbg(hdev, "%d collection_index:%x hid:%x sz:%x\n",
+				i, report->field[i]->usage->collection_index,
+				report->field[i]->usage->hid,
+				report->field[i]->report_size/8);
+
+		sz = report->field[i]->report_size/8;
+		if (pdata->pending && pdata->pending->attr_usage_id ==
+				report->field[i]->usage->hid) {
+			hid_dbg(hdev, "data was pending ...\n");
+			sz = (sz > RAW_BUFFER_SIZE) ? RAW_BUFFER_SIZE : sz;
+			memcpy(pdata->pending->raw_data, ptr, sz);
+			pdata->pending->raw_size  = sz;
+			complete(&pdata->pending->ready);
+		}
+		collection = &hdev->collection[
+				report->field[i]->usage->collection_index];
+		hid_dbg(hdev, "collection->usage %x\n",
+					collection->usage);
+		callback = sensor_hub_get_callback(collection->usage,
+							   &priv);
+		if (callback && callback->capture_sample) {
+			callback->capture_sample(hdev,
+			report->field[i]->usage->hid, sz, ptr, priv);
+		}
+		ptr += sz;
+	}
+	if (callback && collection && callback->send_event)
+		callback->send_event(hdev, collection->usage, priv);
+
+	spin_unlock_irqrestore(&pdata->lock, flags);
+
+err_report:
+	return 1;
+}
+
+static int sensor_hub_probe(struct hid_device *hdev,
+				const struct hid_device_id *id)
+{
+	int ret;
+	struct sensor_hub_data *sd;
+
+	sd = kzalloc(sizeof(struct sensor_hub_data), GFP_KERNEL);
+	if (!sd) {
+		hid_err(hdev, "cannot allocate Sensor data\n");
+		return -ENOMEM;
+	}
+	hid_set_drvdata(hdev, sd);
+	sd->hdev = hdev;
+	spin_lock_init(&sd->lock);
+	mutex_init(&sd->mutex);
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "parse failed\n");
+		goto err_free;
+	}
+#if (defined CONFIG_HID_SENSOR_DEBUG) || \
+	(defined CONFIG_HID_SENSOR_DEBUG_MODULE)
+	dump_report(hdev);
+#endif
+	if (sensor_hub_check_for_sensor_page(hdev) < 0) {
+		hid_err(hdev, "sensor page not found\n");
+		goto err_free;
+	}
+	INIT_LIST_HEAD(&hdev->inputs);
+
+	hdev->claimed = HID_CLAIMED_INPUT;
+	ret = hid_hw_start(hdev, 0);
+	if (ret) {
+		hid_err(hdev, "hw start failed\n");
+		goto err_free;
+	}
+	ret = hid_hw_open(hdev);
+	if (ret) {
+		hid_hw_stop(hdev);
+		hid_err(hdev, "failed to open input interrupt pipe\n");
+		goto err_close;
+	}
+
+	ret = sensor_hub_init_callbacks(hdev);
+	if (ret < 0)
+		goto err_stop_hw;
+	return ret;
+
+err_close:
+	hid_hw_stop(hdev);
+err_stop_hw:
+	hid_hw_close(hdev);
+err_free:
+	kfree(sd);
+
+	return ret;
+}
+
+static void sensor_hub_remove(struct hid_device *hdev)
+{
+	struct sensor_hub_data *data = hid_get_drvdata(hdev);
+	unsigned long flags;
+	int j, ret;
+	struct sensor_hub_callbacks *callback;
+
+	hid_dbg(hdev, " hardware removed\n");
+
+	hdev->claimed &= ~HID_CLAIMED_INPUT;
+
+	hid_hw_stop(hdev);
+	hid_hw_close(hdev);
+
+	j = 0;
+	while (usage_callbacks[j].usage_id != 0) {
+		if (usage_callbacks[j].initialized) {
+			callback = usage_callbacks[j].reg_callback();
+			ret = callback->exit(hdev, usage_callbacks[j].priv);
+			if (ret) {
+				hid_err(hdev, "callback exit failed\n");
+				break;
+			}
+		}
+			++j;
+	}
+
+	hid_set_drvdata(hdev, NULL);
+
+	spin_lock_irqsave(&data->lock, flags);
+	if (data->pending)
+		complete(&data->pending->ready);
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	mutex_destroy(&data->mutex);
+	kfree(data);
+}
+
+static const struct hid_device_id sensor_hub_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_INTEL_8086,
+			USB_DEVICE_ID_SENSOR_HUB_1020) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_INTEL_8087,
+			USB_DEVICE_ID_SENSOR_HUB_09FA) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_INTEL_8087,
+			USB_DEVICE_ID_SENSOR_HUB_09FA) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STANTUM_STM,
+			USB_DEVICE_ID_SENSOR_HUB_7014) },
+	{ }
+};
+
+static const struct hid_usage_id sensor_hub_grabbed_usages[] = {
+	{ HID_ANY_ID, HID_ANY_ID, HID_ANY_ID },
+	{ HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1 }
+};
+
+static struct hid_driver sensor_hub_driver = {
+	.name = "hid-sensor-hub",
+	.id_table = sensor_hub_devices,
+	.probe = sensor_hub_probe,
+	.remove = sensor_hub_remove,
+	.raw_event = sensor_hub_raw_event,
+#ifdef CONFIG_PM
+	.suspend = sensor_hub_suspend,
+	.resume =  sensor_hub_resume,
+	.reset_resume =  sensor_hub_reset_resume,
+#endif
+};
+
+static int __init sensor_hub_init(void)
+{
+	return hid_register_driver(&sensor_hub_driver);
+}
+
+static void __exit sensor_hub_exit(void)
+{
+	hid_unregister_driver(&sensor_hub_driver);
+}
+
+
+module_init(sensor_hub_init);
+module_exit(sensor_hub_exit);
+MODULE_LICENSE("GPL");
diff --git a/drivers/staging/hid-sensors/hid-sensor-ids.h b/drivers/staging/hid-sensors/hid-sensor-ids.h
new file mode 100644
index 0000000..553f366
--- /dev/null
+++ b/drivers/staging/hid-sensors/hid-sensor-ids.h
@@ -0,0 +1,117 @@
+/*
+ * HID Sensors Driver
+ * Copyright (c) 2012, Intel Corporation.
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
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ */
+#ifndef _HID_SENSORS_IDS_H
+#define _HID_SENSORS_IDS_H
+
+#include "hid-ids.h"
+
+#define HID_UP_SENSOR		0x00200000
+#define HID_SENSOR_POLLING      0x0020030E
+#define HID_SENSOR_REPORT_STATE 0x00200316
+
+
+/* Accel 3D (200073) */
+#define HID_USAGE_SENSOR_ACCEL_3D				0x200073
+#define HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_X_AXIS	0x200453
+#define HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_Y_AXIS	0x200454
+#define HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_Z_AXIS	0x200455
+
+/* ALS (200041) */
+#define HID_USAGE_SENSOR_ALS				        0x200041
+#define HID_USAGE_SENSOR_DATA_LIGHT_ILLUMINANCE			0x2004d1
+
+/* Compass 3D: (200083) */
+
+/* Gyro 3D: (200076) */
+#define HID_USAGE_SENSOR_GYRO_3D				0x200076
+#define HID_USAGE_SENSOR_DATA_MOTION_ANGULAR_VELOCITY_X_AXIS	0x200457
+#define HID_USAGE_SENSOR_DATA_MOTION_ANGULAR_VELOCITY_Y_AXIS	0x200458
+#define HID_USAGE_SENSOR_DATA_MOTION_ANGULAR_VELOCITY_Z_AXIS	0x200459
+
+/*ORIENTATION: Compass 3D: (200083) */
+#define HID_USAGE_SENSOR_COMPASS_3D				0x200083
+#define HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_HEADING	0x200471
+#define HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_HEADING_X	0x200472
+#define HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_HEADING_Y	0x200473
+#define HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_HEADING_Z	0x200474
+
+#define HID_USAGE_SENSOR_DATA_ORIENTATION_COMPENSATED_MAGNETIC_NORTH 0x200475
+#define HID_USAGE_SENSOR_DATA_ORIENTATION_COMPENSATED_TRUE_NORTH 0x200476
+#define HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_NORTH	0x200477
+#define HID_USAGE_SENSOR_DATA_ORIENTATION_TRUE_NORTH		0x200478
+
+#define HID_USAGE_SENSOR_DATA_ORIENTATION_DISTANCE		0x200479
+#define HID_USAGE_SENSOR_DATA_ORIENTATION_DISTANCE_X		0x20047A
+#define HID_USAGE_SENSOR_DATA_ORIENTATION_DISTANCE_Y		0x20047B
+#define HID_USAGE_SENSOR_DATA_ORIENTATION_DISTANCE_Z		0x20047C
+#define HID_USAGE_SENSOR_DATA_ORIENTATION_DISTANCE_OUT_OF_RANGE 0x20047D
+#define HID_USAGE_SENSOR_DATA_ORIENTATION_TILT			0x20047E
+#define HID_USAGE_SENSOR_DATA_ORIENTATION_TILT_X		0x20047F
+#define HID_USAGE_SENSOR_DATA_ORIENTATION_TILT_Y		0x200480
+#define HID_USAGE_SENSOR_DATA_ORIENTATION_TILT_Z		0x200481
+#define HID_USAGE_SENSOR_DATA_ORIENTATION_ROTATION_MATRIX	0x200482
+#define HID_USAGE_SENSOR_DATA_ORIENTATION_QUATERNION		0x200483
+#define HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX		0x200484
+
+#define HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_X_AXIS	0x200485
+#define HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_Y_AXIS	0x200486
+#define HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_Z_AXIS	0x200487
+
+/* Units */
+#define HID_USAGE_SENSOR_UNITS_NOT_SPECIFIED	0x00
+#define HID_USAGE_SENSOR_UNITS_LUX		0x01
+#define HID_USAGE_SENSOR_UNITS_KELVIN		(0x01, 0x00, 0x01, 0x00)
+#define HID_USAGE_SENSOR_UNITS_FAHRENHEIT	(0x03, 0x00, 0x01, 0x00)
+#define HID_USAGE_SENSOR_UNITS_PASCAL		(0xF1, 0xE1)
+#define HID_USAGE_SENSOR_UNITS_NEWTON		(0x11, 0xE1)
+#define HID_USAGE_SENSOR_UNITS_METERS_PER_SECOND (0x11, 0xF0)
+#define HID_USAGE_SENSOR_UNITS_METERS_PER_SEC_SQRD (0x11, 0xE0)
+#define HID_USAGE_SENSOR_UNITS_FARAD		(0xE1, 0x4F, 0x20, 0x00)
+#define HID_USAGE_SENSOR_UNITS_AMPERE		(0x01, 0x00, 0x10, 0x00)
+#define HID_USAGE_SENSOR_UNITS_WATT		(0x21, 0xd1)
+#define HID_USAGE_SENSOR_UNITS_HENRY		(0x21, 0xE1, 0xE0, 0x00)
+#define HID_USAGE_SENSOR_UNITS_OHM		(0x21, 0xD1, 0xE0, 0x00)
+#define HID_USAGE_SENSOR_UNITS_VOLT		(0x21, 0xD1, 0xF0, 0x00)
+#define HID_USAGE_SENSOR_UNITS_HERTZ		(0x01, 0xF0)
+#define HID_USAGE_SENSOR_UNITS_DEGREES_PER_SEC_SQRD (0x14, 0xE0)
+#define HID_USAGE_SENSOR_UNITS_RADIANS		0x12
+#define HID_USAGE_SENSOR_UNITS_RADIANS_PER_SECOND (0x12, 0xF0)
+#define HID_USAGE_SENSOR_UNITS_RADIANS_PER_SEC_SQRD (0x12, 0xE0)
+#define HID_USAGE_SENSOR_UNITS_SECOND		(0x01, 0x10)
+#define HID_USAGE_SENSOR_UNITS_GAUSS		(0x01, 0xE1, 0xF0, 0x00)
+#define HID_USAGE_SENSOR_UNITS_GRAM		(0x01, 0x01)
+#define HID_USAGE_SENSOR_UNITS_CENTIMETER	0x11
+#define HID_USAGE_SENSOR_UNITS_G		0x1A
+#define HID_USAGE_SENSOR_UNITS_MILLISECOND	0x19
+#define HID_USAGE_SENSOR_UNITS_PERCENT		0x17
+#define HID_USAGE_SENSOR_UNITS_DEGREES		0x14
+#define HID_USAGE_SENSOR_UNITS_DEGREES_PER_SECOND 0x15
+
+/* Common selectors */
+#define HID_USAGE_SENSOR_PROPERTY_REPORT_INTERVAL		0x20030E
+#define HID_USAGE_SENSOR_PROPERTY_CHANGE_SENSITIVITY_ABS	0x20030F
+#define HID_USAGE_SENSOR_PROPERTY_CHANGE_SENSITIVITY_RANGE_PCT	0x200310
+#define HID_USAGE_SENSOR_PROPERTY_CHANGE_SENSITIVITY_REL_PCT	0x200311
+#define HID_USAGE_SENSOR_PROPERTY_ACCURACY			0x200312
+#define HID_USAGE_SENSOR_PROPERTY_RESOLUTION			0x200313
+#define HID_USAGE_SENSOR_PROPERTY_RANGE_MAXIMUM			0x200314
+#define HID_USAGE_SENSOR_PROPERTY_RANGE_MINIMUM			0x200315
+#define HID_USAGE_SENSOR_PROPERTY_REPORTING_STATE		0x200316
+
+#endif
diff --git a/drivers/staging/hid-sensors/hid-sensor-interface.h b/drivers/staging/hid-sensors/hid-sensor-interface.h
new file mode 100644
index 0000000..18a2e09
--- /dev/null
+++ b/drivers/staging/hid-sensors/hid-sensor-interface.h
@@ -0,0 +1,75 @@
+/*
+ * HID Sensors Driver
+ * Copyright (c) 2012, Intel Corporation.
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
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ */
+#ifndef _HID_SENSORS_INTERFACE_H
+#define _HID_SENSORS_INTERFACE_H
+
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/usb.h>
+#include "usbhid/usbhid.h"
+#include <linux/module.h>
+#include <linux/slab.h>
+#include "iio/iio.h"
+#include "iio/sysfs.h"
+#include "iio/ring_sw.h"
+#include "iio/trigger.h"
+
+struct hid_sensor_hub_attribute_info {
+	u32 usage_id;
+	u32 attrib_id;
+	s32 report_id;
+	s32 index;
+	s32 units;
+	s32 unit_expo;
+};
+
+struct hid_sensor_attributes {
+	struct hid_device *hdev;
+	unsigned usage_id;
+	bool data_ready;
+	struct hid_sensor_hub_attribute_info poll;
+	struct hid_sensor_hub_attribute_info activate;
+	struct hid_sensor_hub_attribute_info sensitivity;
+	void *private;
+};
+
+struct sensor_hub_callbacks {
+	int (*enter)(struct hid_device *hdev, u32 usage_id, void **priv);
+	int (*exit)(struct hid_device *hdev, void *priv);
+	int (*suspend)(struct hid_device *hdev, void *priv);
+	int (*resume)(struct hid_device *hdev, void *priv);
+	int (*capture_sample)(struct hid_device *hdev, u32 usage_id,
+				size_t raw_len, char *raw_data, void *priv);
+	int (*send_event)(struct hid_device *hdev, u32 usage_id, void *priv);
+};
+
+/* Hid sensor hub core interfaces */
+int sensor_hub_input_get_attribute_info(struct hid_device *hdev, u8 type,
+				u32 usage_id, u32 attr_usage_id,
+				struct hid_sensor_hub_attribute_info *info);
+int sensor_hub_set_feature(struct hid_device *dev, u32 report_id,
+					u32 field_index, s32 value);
+int sensor_hub_get_feature(struct hid_device *hdev, u32 report_id,
+				u32 field_index, s32 *value);
+ssize_t sensor_hub_input_attr_get_value(struct hid_device *hdev, u32 usage_id,
+					u32 attr_usage_id, u32 report_id,
+					u32 buf_len, u8 *buf);
+int sensor_hub_input_get_unit_expo(struct hid_device *hdev, u32 field_usage_id,
+					s32 *unit, s32 *unit_expo);
+#endif
-- 
1.7.7.6
