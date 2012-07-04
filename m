From: srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/8] HID-Sensors: Common attribute and trigger
Date: Wed,  4 Jul 2012 12:52:08 -0700
Message-ID: <1341431532-15060-5-git-send-email-srinivas.pandruvada@intel.com>
References: <1341431532-15060-1-git-send-email-srinivas.pandruvada@intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1341431532-15060-1-git-send-email-srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This patch contains the common code, which is used by all HID sensors.
There are some common set of attributes, which every hid sensor
needs it. This patch contains all such attributes processing.
Also the trigger interface is common among all HID sensors. This
patch contains common trigger functions utilized by all HID sensors.

Signed-off-by: srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/staging/iio/Kconfig                        |    1 +
 drivers/staging/iio/Makefile                       |    1 +
 drivers/staging/iio/common/Kconfig                 |    6 +
 drivers/staging/iio/common/Makefile                |    5 +
 drivers/staging/iio/common/hid-sensors/Kconfig     |   21 +++
 drivers/staging/iio/common/hid-sensors/Makefile    |    6 +
 .../iio/common/hid-sensors/hid-sensor-attributes.c |  182 ++++++++++++++++++++
 .../iio/common/hid-sensors/hid-sensor-attributes.h |   60 +++++++
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |  104 +++++++++++
 .../iio/common/hid-sensors/hid-sensor-trigger.h    |   27 +++
 10 files changed, 413 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/common/Kconfig
 create mode 100644 drivers/staging/iio/common/Makefile
 create mode 100644 drivers/staging/iio/common/hid-sensors/Kconfig
 create mode 100644 drivers/staging/iio/common/hid-sensors/Makefile
 create mode 100644 drivers/staging/iio/common/hid-sensors/hid-sensor-attributes.c
 create mode 100644 drivers/staging/iio/common/hid-sensors/hid-sensor-attributes.h
 create mode 100644 drivers/staging/iio/common/hid-sensors/hid-sensor-trigger.c
 create mode 100644 drivers/staging/iio/common/hid-sensors/hid-sensor-trigger.h

diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index 04cd6ec..7b058f4 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -29,6 +29,7 @@ source "drivers/staging/iio/accel/Kconfig"
 source "drivers/staging/iio/adc/Kconfig"
 source "drivers/staging/iio/addac/Kconfig"
 source "drivers/staging/iio/cdc/Kconfig"
+source "drivers/staging/iio/common/Kconfig"
 source "drivers/staging/iio/frequency/Kconfig"
 source "drivers/staging/iio/gyro/Kconfig"
 source "drivers/staging/iio/impedance-analyzer/Kconfig"
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index fa6937d..c7ca152 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -17,6 +17,7 @@ obj-y += accel/
 obj-y += adc/
 obj-y += addac/
 obj-y += cdc/
+obj-y += common/
 obj-y += frequency/
 obj-y += gyro/
 obj-y += impedance-analyzer/
diff --git a/drivers/staging/iio/common/Kconfig b/drivers/staging/iio/common/Kconfig
new file mode 100644
index 0000000..bed569a
--- /dev/null
+++ b/drivers/staging/iio/common/Kconfig
@@ -0,0 +1,6 @@
+#
+# IIO common modules
+#
+
+source "drivers/staging/iio/common/hid-sensors/Kconfig"
+
diff --git a/drivers/staging/iio/common/Makefile b/drivers/staging/iio/common/Makefile
new file mode 100644
index 0000000..23852b6
--- /dev/null
+++ b/drivers/staging/iio/common/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for the IIO common modules.
+#
+
+obj-y += hid-sensors/
diff --git a/drivers/staging/iio/common/hid-sensors/Kconfig b/drivers/staging/iio/common/hid-sensors/Kconfig
new file mode 100644
index 0000000..da64fef
--- /dev/null
+++ b/drivers/staging/iio/common/hid-sensors/Kconfig
@@ -0,0 +1,21 @@
+#
+# Hid Sensor common modules
+#
+menu "Hid Sensor IIO Common"
+
+config HID_SENSOR_IIO_COMMON
+	tristate "Common modules for all HID Sensor IIO drivers"
+	depends on HID_SENSOR_HUB
+	select IIO_TRIGGER if IIO_BUFFER
+	help
+	  Say yes here to build support for HID sensor to use
+	  HID sensor common processing for attributes and IIO triggers.
+
+config HID_SENSOR_ENUM_BASE_QUIRKS
+	tristate "ENUM base quirks for HID Sensor IIO drivers"
+	depends on HID_SENSOR_IIO_COMMON
+	help
+	  Say yes here to build support for sensor hub FW using
+	  enumeration, which is using 1 as base instead of 0.
+
+endmenu
diff --git a/drivers/staging/iio/common/hid-sensors/Makefile b/drivers/staging/iio/common/hid-sensors/Makefile
new file mode 100644
index 0000000..1f463e0
--- /dev/null
+++ b/drivers/staging/iio/common/hid-sensors/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for the Hid sensor common modules.
+#
+
+obj-$(CONFIG_HID_SENSOR_IIO_COMMON) += hid-sensor-iio-common.o
+hid-sensor-iio-common-y := hid-sensor-attributes.o hid-sensor-trigger.o
diff --git a/drivers/staging/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/staging/iio/common/hid-sensors/hid-sensor-attributes.c
new file mode 100644
index 0000000..d39c93e
--- /dev/null
+++ b/drivers/staging/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -0,0 +1,182 @@
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
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/slab.h>
+#include <linux/hid-sensor-hub.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include "hid-sensor-attributes.h"
+
+#define MAXIMUM_SAMP_FREQUENCY 1000
+
+ssize_t hid_sensor_read_samp_freq(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	s32 value;
+	int len;
+	int ret;
+	int conv_value;
+
+	ret = sensor_hub_get_feature(st->hsdev,
+			st->poll.report_id,
+			st->poll.index, &value);
+	if (ret < 0 || value <= 0)
+		len = sprintf(buf, "0\n");
+	else {
+		if (st->poll.units == HID_USAGE_SENSOR_UNITS_MILLISECOND)
+			conv_value = 1000/value;
+		else if (st->poll.units == HID_USAGE_SENSOR_UNITS_SECOND)
+			conv_value = 1/value;
+		else
+			conv_value = value; /*Assume HZ*/
+		len = sprintf(buf, "%d\n", conv_value);
+	}
+	return len;
+}
+EXPORT_SYMBOL(hid_sensor_read_samp_freq);
+
+ssize_t hid_sensor_write_samp_freq(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	int value;
+	int conv_value;
+	int ret;
+
+	if (kstrtoint(buf, 10, &value) < 0)
+		return -EINVAL;
+
+	if (value > MAXIMUM_SAMP_FREQUENCY)
+		value = MAXIMUM_SAMP_FREQUENCY;
+
+	if (value && st->poll.units == HID_USAGE_SENSOR_UNITS_MILLISECOND)
+		conv_value = 1000/value;
+	else if (value && st->poll.units == HID_USAGE_SENSOR_UNITS_SECOND)
+		conv_value = 1/value;
+	else
+		conv_value = value; /*Assume HZ*/
+
+	ret = sensor_hub_set_feature(st->hsdev,
+		st->poll.report_id,
+		st->poll.index,
+		conv_value);
+
+	if (ret < 0)
+		return ret;
+	return strlen(buf);
+}
+EXPORT_SYMBOL(hid_sensor_write_samp_freq);
+
+ssize_t hid_sensor_read_hyst_raw(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	s32 value;
+	int len;
+	int ret;
+
+	ret = sensor_hub_get_feature(st->hsdev,
+		st->sensitivity.report_id,
+		st->sensitivity.index, &value);
+	if (ret < 0 || value < 0)
+		len = sprintf(buf, "0\n");
+	else
+		len = sprintf(buf, "units:%d,exp:%d,value:%d\n",
+				st->sensitivity.units,
+				st->sensitivity.unit_expo, value);
+	return len;
+}
+EXPORT_SYMBOL(hid_sensor_read_hyst_raw);
+
+ssize_t hid_sensor_write_hyst_raw(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	int value;
+	int ret;
+
+	if (kstrtoint(buf, 10, &value) < 0)
+		return -EINVAL;
+
+	if (value <= 0)
+		value = 0;
+	ret = sensor_hub_set_feature(st->hsdev,
+		st->sensitivity.report_id,
+		st->sensitivity.index,
+		value);
+
+	if (ret < 0)
+		return ret;
+
+	return strlen(buf);
+}
+EXPORT_SYMBOL(hid_sensor_write_hyst_raw);
+
+int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
+					u32 usage_id,
+					struct hid_sensor_attributes *st)
+{
+	int ret;
+
+	ret = sensor_hub_input_get_attribute_info(hsdev,
+					HID_FEATURE_REPORT, usage_id,
+					HID_SENSOR_POLLING, &st->poll);
+
+	ret = sensor_hub_input_get_attribute_info(hsdev,
+					HID_FEATURE_REPORT, usage_id,
+					HID_SENSOR_REPORT_STATE,
+					&st->report_state);
+
+	ret = sensor_hub_input_get_attribute_info(hsdev,
+					HID_FEATURE_REPORT, usage_id,
+					HID_SENSOR_POWER_STATE,
+					&st->power_state);
+
+	ret = sensor_hub_input_get_attribute_info(hsdev,
+			HID_FEATURE_REPORT, usage_id,
+			HID_USAGE_SENSOR_PROPERTY_CHANGE_SENSITIVITY_ABS,
+			 &st->sensitivity);
+
+	hid_dbg(hsdev->hdev, "common attributes: %x:%x, %x:%x, %x:%x %x:%x\n",
+			st->poll.index, st->poll.report_id,
+			st->report_state.index, st->report_state.report_id,
+			st->power_state.index, st->power_state.report_id,
+			st->sensitivity.index, st->sensitivity.report_id);
+
+	return 0;
+}
+EXPORT_SYMBOL(hid_sensor_parse_common_attributes);
+
+MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>");
+MODULE_DESCRIPTION("HID Sensor common attribute processing");
+MODULE_LICENSE("GPL");
diff --git a/drivers/staging/iio/common/hid-sensors/hid-sensor-attributes.h b/drivers/staging/iio/common/hid-sensors/hid-sensor-attributes.h
new file mode 100644
index 0000000..c859b7e
--- /dev/null
+++ b/drivers/staging/iio/common/hid-sensors/hid-sensor-attributes.h
@@ -0,0 +1,60 @@
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
+#ifndef _HID_SENSORS_ATTRIBUTES_H
+#define _HID_SENSORS_ATTRIBUTES_H
+
+/**
+ * IIO_DEV_ATTR_HYSTERESIS - sets hysterisis value
+ * @_mode: sysfs file mode/permissions
+ * @_show: output method for the attribute
+ * @_store: input method for the attribute
+ **/
+#define IIO_DEV_ATTR_HYSTERESIS(_mode, _show, _store)        \
+	IIO_DEVICE_ATTR(hyst_raw, _mode, _show, _store, 0)
+
+/* Common sysfs attributes for HID sensors */
+struct hid_sensor_attributes {
+	struct hid_sensor_hub_device *hsdev;
+	struct platform_device *pdev;
+	unsigned usage_id;
+	bool data_ready;
+	struct hid_sensor_hub_attribute_info poll;
+	struct hid_sensor_hub_attribute_info report_state;
+	struct hid_sensor_hub_attribute_info power_state;
+	struct hid_sensor_hub_attribute_info sensitivity;
+	void *private;
+};
+
+int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
+					u32 usage_id,
+					struct hid_sensor_attributes *st);
+ssize_t hid_sensor_read_hyst_raw(struct device *dev,
+				struct device_attribute *attr,
+				char *buf);
+ssize_t hid_sensor_write_hyst_raw(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len);
+ssize_t hid_sensor_read_samp_freq(struct device *dev,
+				struct device_attribute *attr,
+				char *buf);
+ssize_t hid_sensor_write_samp_freq(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len);
+
+#endif
diff --git a/drivers/staging/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/staging/iio/common/hid-sensors/hid-sensor-trigger.c
new file mode 100644
index 0000000..bef5560
--- /dev/null
+++ b/drivers/staging/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -0,0 +1,104 @@
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
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/slab.h>
+#include <linux/hid-sensor-hub.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/trigger.h>
+#include "hid-sensor-attributes.h"
+
+static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
+						bool state)
+{
+	struct iio_dev *indio_dev = trig->private_data;
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	int ret;
+	int state_val;
+
+	dev_dbg(&indio_dev->dev, "hid_sensor_data_rdy_trigger_set_state %d\n",
+			state);
+	state_val = state ? 1 : 0;
+#if (defined CONFIG_HID_SENSOR_ENUM_BASE_QUIRKS) || \
+	(defined CONFIG_HID_SENSOR_ENUM_BASE_QUIRKS_MODULE)
+	hid_dbg(st->hsdev, " Using ENUM base FW QUIRKS\n");
+	++state_val;
+#endif
+	st->data_ready = state;
+	ret = sensor_hub_set_feature(st->hsdev, st->power_state.report_id,
+					st->power_state.index,
+					(s32)state_val);
+
+	ret = sensor_hub_set_feature(st->hsdev, st->report_state.report_id,
+					st->report_state.index,
+					(s32)state_val);
+	return ret;
+}
+
+void hid_sensor_remove_trigger(struct iio_dev *indio_dev)
+{
+	iio_trigger_unregister(indio_dev->trig);
+	iio_trigger_free(indio_dev->trig);
+}
+EXPORT_SYMBOL(hid_sensor_remove_trigger);
+
+static const struct iio_trigger_ops hid_sensor_trigger_ops = {
+	.owner = THIS_MODULE,
+	.set_trigger_state = &hid_sensor_data_rdy_trigger_set_state,
+};
+
+int hid_sensor_setup_trigger(struct iio_dev *indio_dev, char *name)
+{
+	int ret;
+	struct iio_trigger *trig;
+
+	trig = iio_trigger_alloc("%s-dev%d", name, indio_dev->id);
+	if (trig == NULL) {
+		dev_err(&indio_dev->dev, "Trigger Allocate Failed\n");
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+
+	trig->dev.parent = indio_dev->dev.parent;
+	trig->private_data = (void *)indio_dev;
+	trig->ops = &hid_sensor_trigger_ops;
+	ret = iio_trigger_register(trig);
+
+	if (ret) {
+		dev_err(&indio_dev->dev, "Trigger Register Failed\n");
+		goto error_free_trig;
+	}
+	indio_dev->trig = trig;
+
+	return ret;
+
+error_free_trig:
+	iio_trigger_free(trig);
+error_ret:
+	return ret;
+}
+EXPORT_SYMBOL(hid_sensor_setup_trigger);
+
+MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>");
+MODULE_DESCRIPTION("HID Sensor trigger processing");
+MODULE_LICENSE("GPL");
diff --git a/drivers/staging/iio/common/hid-sensors/hid-sensor-trigger.h b/drivers/staging/iio/common/hid-sensors/hid-sensor-trigger.h
new file mode 100644
index 0000000..9ff3d02
--- /dev/null
+++ b/drivers/staging/iio/common/hid-sensors/hid-sensor-trigger.h
@@ -0,0 +1,27 @@
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
+#ifndef _HID_SENSOR_TRIGGER_H
+#define _HID_SENSOR_TRIGGER_H
+
+
+
+int hid_sensor_setup_trigger(struct iio_dev *indio_dev, char *name);
+void hid_sensor_remove_trigger(struct iio_dev *indio_dev);
+
+#endif
-- 
1.7.7.6
