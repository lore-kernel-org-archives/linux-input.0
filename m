From: srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH, 6/7] HID-Sensors: Added Compass 3D
Date: Wed,  6 Jun 2012 08:39:23 -0700
Message-ID: <1338997164-5077-7-git-send-email-srinivas.pandruvada@intel.com>
References: <1338997164-5077-1-git-send-email-srinivas.pandruvada@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:50077 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756660Ab2FFPuh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 6 Jun 2012 11:50:37 -0400
In-Reply-To: <1338997164-5077-1-git-send-email-srinivas.pandruvada@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-iio@vger.kernel.org, Srinivas pandruvada <srinivas.pandruvada@intel.com>

From: Srinivas pandruvada <srinivas.pandruvada@intel.com>

Added usage id processing for Compass 3D. This uses IIO
interfaces "ring/buffer and trigger interface" to present
data to user mode.

Signed-off-by: Srinivas pandruvada <srinivas.pandruvada@intel.com>
---
 drivers/staging/hid-sensors/Makefile               |    1 +
 .../staging/hid-sensors/hid-sensor-compass-3d.c    |  385 ++++++++++++++++++++
 drivers/staging/hid-sensors/hid-sensor-hub.c       |    1 +
 drivers/staging/hid-sensors/hid-sensor-interface.h |    1 +
 4 files changed, 388 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-compass-3d.c

diff --git a/drivers/staging/hid-sensors/Makefile b/drivers/staging/hid-sensors/Makefile
index 9c975a0..9762232 100644
--- a/drivers/staging/hid-sensors/Makefile
+++ b/drivers/staging/hid-sensors/Makefile
@@ -11,4 +11,5 @@ hid-sensors-y += hid-sensor-ring.o
 hid-sensors-y += hid-sensor-trigger.o
 hid-sensors-y += hid-sensor-accel-3d.o
 hid-sensors-y += hid-sensor-gyro-3d.o
+hid-sensors-y += hid-sensor-compass-3d.o
 obj-$(CONFIG_HID_SENSORS) += hid-sensors.o
diff --git a/drivers/staging/hid-sensors/hid-sensor-compass-3d.c b/drivers/staging/hid-sensors/hid-sensor-compass-3d.c
new file mode 100644
index 0000000..fb24059
--- /dev/null
+++ b/drivers/staging/hid-sensors/hid-sensor-compass-3d.c
@@ -0,0 +1,385 @@
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
+#include "iio/iio.h"
+#include "iio/sysfs.h"
+#include "iio/ring_sw.h"
+#include "iio/trigger.h"
+#include "hid-sensor-ids.h"
+#include "hid-sensor-interface.h"
+#include "hid-sensor-attributes.h"
+
+
+struct compass_3d_sample {
+	u16 x_sz;
+	u32 compass_x;
+	u16 y_sz;
+	u32 compass_y;
+	u16 z_sz;
+	u32 compass_z;
+} __packed;
+
+struct compass_3d_state {
+	struct hid_sensor_hub_attribute_info compass_x;
+	struct hid_sensor_hub_attribute_info compass_y;
+	struct hid_sensor_hub_attribute_info compass_z;
+	struct compass_3d_sample compass_sample_data;
+};
+
+
+enum compass_3d_chan {
+	COMPASS_X_Y_Z,
+};
+
+enum compass_3d_scan {
+	COMPASS_3D_SCAN_ACC_X_Y_Z,
+};
+
+static struct iio_chan_spec compass_3d_channels[] = {
+	IIO_CHAN(IIO_MAGN, 1, 0, 0, NULL, 0, IIO_MOD_X_AND_Y_AND_Z,
+	IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
+	IIO_CHAN_INFO_OFFSET_SEPARATE_BIT,
+	COMPASS_X_Y_Z, COMPASS_3D_SCAN_ACC_X_Y_Z,
+		 IIO_ST('u', sizeof(struct compass_3d_sample) * 8,
+			 sizeof(struct compass_3d_sample) * 8, 0), 0),
+};
+
+static ssize_t compass_3d_read_compass(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct compass_3d_state *compass_state =
+			(struct compass_3d_state *)st->private;
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int report_id = -1;
+
+	switch (this_attr->address) {
+	case HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_X_AXIS:
+		report_id = compass_state->compass_x.report_id;
+		break;
+	case HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_Y_AXIS:
+		report_id = compass_state->compass_y.report_id;
+		break;
+	case HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_Z_AXIS:
+		report_id = compass_state->compass_z.report_id;
+		break;
+	default:
+		break;
+	}
+	if (report_id < 0)
+		return -EINVAL;
+
+	return sensor_hub_input_attr_get_value(st->hdev,
+			HID_USAGE_SENSOR_COMPASS_3D, this_attr->address,
+			report_id, 4, buf);
+}
+
+static int compass_3d_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val, int *val2,
+			      long mask)
+{
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct compass_3d_state *compass_state =
+			(struct compass_3d_state *)st->private;
+	*val = 0;
+	*val2 = 0;
+
+	switch (mask) {
+	case 0:
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		*val = compass_state->compass_x.units;
+		break;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = compass_state->compass_x.unit_expo;
+		break;
+	default:
+		break;
+
+	}
+	return IIO_VAL_INT;
+}
+
+static int compass_3d_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int val,
+			       int val2,
+			       long mask)
+{
+	printk(KERN_ERR "%s\n", __func__);
+
+	return 0;
+}
+
+/* Usage specific attributes */
+#define IIO_DEV_ATTR_MAGN_OFFSET(_mode, _show, _store, _addr)  \
+	IIO_DEVICE_ATTR(compass_offset, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_MAGN_X_OFFSET(_mode, _show, _store, _addr)        \
+	IIO_DEVICE_ATTR(compass_x_offset, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_MAGN_Y_OFFSET(_mode, _show, _store, _addr)        \
+	IIO_DEVICE_ATTR(compass_y_offset, _mode, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_MAGN_Z_OFFSET(_mode, _show, _store, _addr)        \
+	IIO_DEVICE_ATTR(compass_z_offset, _mode, _show, _store, _addr)
+
+static IIO_DEV_ATTR_MAGN_X_OFFSET(S_IWUSR | S_IRUGO, compass_3d_read_compass,
+		 NULL, HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_X_AXIS);
+static IIO_DEV_ATTR_MAGN_Y_OFFSET(S_IWUSR | S_IRUGO, compass_3d_read_compass,
+		 NULL, HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_Y_AXIS);
+static IIO_DEV_ATTR_MAGN_Z_OFFSET(S_IWUSR | S_IRUGO, compass_3d_read_compass,
+		 NULL, HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_Z_AXIS);
+
+static struct attribute *compass_3d_attributes[] = {
+	/* common attributes */
+	&iio_dev_attr_poll_interval.dev_attr.attr,
+	&iio_dev_attr_sensitivity.dev_attr.attr,
+	&iio_dev_attr_activate.dev_attr.attr,
+	/* Usage specific attributes */
+	&iio_dev_attr_compass_x_offset.dev_attr.attr,
+	&iio_dev_attr_compass_y_offset.dev_attr.attr,
+	&iio_dev_attr_compass_z_offset.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group compass_3d_attribute_group = {
+	.attrs = compass_3d_attributes,
+};
+
+static const struct iio_info compass_3d_info = {
+	.attrs = &compass_3d_attribute_group,
+	.driver_module = THIS_MODULE,
+	.read_raw = &compass_3d_read_raw,
+	.write_raw = &compass_3d_write_raw,
+};
+
+
+/* Function to push data to IIO ring */
+int compass_3d_proc_event(struct hid_device *hdev, unsigned usage_id,
+			void *priv)
+{
+	struct iio_dev *indio_dev = (struct iio_dev *)priv;
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct compass_3d_state *compass_state =
+			(struct compass_3d_state *)st->private;
+
+	hid_dbg(hdev, "compass_3d_proc_event\n");
+	if (st->data_ready)
+		hid_sensor_push_data_to_ring(indio_dev,
+				(u8 *)&compass_state->compass_sample_data,
+				sizeof(struct compass_3d_sample));
+	else
+		hid_dbg(hdev, "compass_3d_proc_event data not ready\n");
+	return 0;
+}
+
+/* Capture samples in local storage */
+int compass_3d_capture_sample(struct hid_device *hdev, unsigned usage_id,
+				 size_t raw_len, char *raw_data, void *priv)
+{
+	struct iio_dev *indio_dev = (struct iio_dev *)priv;
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct compass_3d_state *compass_state =
+			(struct compass_3d_state *)st->private;
+
+	switch (usage_id) {
+	case HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_X_AXIS:
+		compass_state->compass_sample_data.x_sz = raw_len;
+		compass_state->compass_sample_data.compass_x =
+		*(u32 *)raw_data;
+		break;
+	case HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_Y_AXIS:
+		compass_state->compass_sample_data.y_sz = raw_len;
+		compass_state->compass_sample_data.compass_y =
+		*(u32 *)raw_data;
+		break;
+	case HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_Z_AXIS:
+		compass_state->compass_sample_data.z_sz = raw_len;
+		compass_state->compass_sample_data.compass_z =
+		*(u32 *)raw_data;
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+
+/* Parse report which is specific to an usage id*/
+static int compass_3d_parse_report(struct hid_device *hdev, unsigned usage_id,
+				struct compass_3d_state *st)
+{
+	int ret;
+
+	ret = sensor_hub_input_get_attribute_info(hdev, HID_INPUT_REPORT,
+			usage_id,
+			HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_X_AXIS,
+			&st->compass_x);
+	if (!ret)
+		hid_dbg(hdev, "No Gyro X attribute\n");
+
+
+	ret = sensor_hub_input_get_attribute_info(hdev, HID_INPUT_REPORT,
+			usage_id,
+			HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_Y_AXIS,
+			&st->compass_y);
+	if (!ret)
+		hid_dbg(hdev, "No Gyro Y attribute\n");
+
+
+	ret = sensor_hub_input_get_attribute_info(hdev, HID_INPUT_REPORT,
+			usage_id,
+			HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_Z_AXIS,
+			&st->compass_z);
+	if (!ret)
+		hid_dbg(hdev, "No Gyro Z attribute\n");
+
+	hid_dbg(hdev, "compass_3d %x:%x, %x:%x, %x:%x\n", st->compass_x.index,
+			st->compass_x.report_id,
+			st->compass_y.index, st->compass_y.report_id,
+			st->compass_z.index, st->compass_z.report_id);
+
+	return 0;
+}
+
+/* Entry function to initialize the processing for usage id */
+static int compass_3d_enter(struct hid_device *hdev, unsigned usage_id,
+				void **priv)
+{
+	int ret = 0;
+	static char *name = "compass_3d";
+	struct iio_dev *indio_dev;
+	struct compass_3d_state *compass_state;
+	struct hid_sensor_attributes *st;
+
+	compass_state = kzalloc(sizeof(struct compass_3d_state), GFP_KERNEL);
+	if (compass_state == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+
+	indio_dev = iio_allocate_device(sizeof(struct hid_sensor_attributes));
+	if (indio_dev == NULL) {
+		ret = -ENOMEM;
+		goto error_free_state;
+	}
+	st = iio_priv(indio_dev);
+	st->usage_id = usage_id;
+	st->hdev = hdev;
+	st->private = (void *)compass_state;
+
+	ret = hid_sensor_parse_common_attributes(hdev, usage_id, st);
+	if (ret) {
+		hid_err(hdev, "failed to setup common attributes\n");
+		goto error_free_dev;
+	}
+	ret = compass_3d_parse_report(hdev, usage_id, compass_state);
+	if (ret) {
+		hid_err(hdev, "failed to setup attributes\n");
+		goto error_free_dev;
+	}
+
+	indio_dev->channels = compass_3d_channels;
+	indio_dev->num_channels =
+				ARRAY_SIZE(compass_3d_channels);
+	indio_dev->dev.parent = &hdev->dev;
+	indio_dev->info = &compass_3d_info;
+	indio_dev->name = name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = hid_sensor_configure_ring(indio_dev);
+	if (ret) {
+		hid_err(hdev, "failed to initialize the ring\n");
+		goto error_free_dev;
+	}
+
+	ret = iio_buffer_register(indio_dev,
+					compass_3d_channels,
+					ARRAY_SIZE(compass_3d_channels));
+	if (ret) {
+		hid_err(hdev, "failed to initialize the ring\n");
+		goto error_unreg_ring_funcs;
+	}
+	st->data_ready = true;
+	ret = hid_sensor_setup_trigger(indio_dev, name);
+	if (ret < 0) {
+		hid_err(hdev, "trigger setup failed\n");
+		goto error_uninit_ring;
+	}
+
+	ret = iio_device_register(indio_dev);
+	if (ret) {
+		hid_err(hdev, "device register failed\n");
+		goto error_remove_trigger;
+	}
+	*priv = (void *)indio_dev;
+	return ret;
+
+error_remove_trigger:
+		hid_sensor_remove_trigger(indio_dev);
+error_uninit_ring:
+		iio_buffer_unregister(indio_dev);
+error_unreg_ring_funcs:
+		hid_sensor_ring_cleanup(indio_dev);
+error_free_dev:
+		iio_free_device(indio_dev);
+error_free_state:
+		kfree(compass_state);
+error_ret:
+		return ret;
+}
+
+static int compass_3d_exit(struct hid_device *hdev, void *priv)
+{
+	int ret = 0;
+	struct iio_dev *indio_dev = (struct iio_dev *)priv;
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct compass_3d_state *compass_state =
+			(struct compass_3d_state *)st->private;
+
+	iio_device_unregister(indio_dev);
+	hid_sensor_remove_trigger(indio_dev);
+	iio_buffer_unregister(indio_dev);
+	hid_sensor_ring_cleanup(indio_dev);
+	iio_free_device(indio_dev);
+
+	kfree(compass_state);
+	return ret;
+}
+
+static struct sensor_hub_callbacks compass_3d_callbacks = {
+	.enter = compass_3d_enter,
+	.exit = compass_3d_exit,
+	.send_event = compass_3d_proc_event,
+	.capture_sample = compass_3d_capture_sample,
+};
+
+struct sensor_hub_callbacks  *compass_3d_register_callbacks(void)
+{
+	return &compass_3d_callbacks;
+}
diff --git a/drivers/staging/hid-sensors/hid-sensor-hub.c b/drivers/staging/hid-sensors/hid-sensor-hub.c
index f98b5fe..d61affa 100644
--- a/drivers/staging/hid-sensors/hid-sensor-hub.c
+++ b/drivers/staging/hid-sensors/hid-sensor-hub.c
@@ -62,6 +62,7 @@ struct sensor_hub_callbacks_list {
 static struct sensor_hub_callbacks_list usage_callbacks[] = {
 	{HID_USAGE_SENSOR_ACCEL_3D, accel_3d_register_callbacks},
 	{HID_USAGE_SENSOR_GYRO_3D, gyro_3d_register_callbacks},
+	{HID_USAGE_SENSOR_COMPASS_3D, compass_3d_register_callbacks},
 	{0}
 };
 
diff --git a/drivers/staging/hid-sensors/hid-sensor-interface.h b/drivers/staging/hid-sensors/hid-sensor-interface.h
index b242d87..b0df328 100644
--- a/drivers/staging/hid-sensors/hid-sensor-interface.h
+++ b/drivers/staging/hid-sensors/hid-sensor-interface.h
@@ -87,5 +87,6 @@ void hid_sensor_remove_trigger(struct iio_dev *indio_dev);
 /* Sensor usage id processing callbacks */
 struct sensor_hub_callbacks  *accel_3d_register_callbacks(void);
 struct sensor_hub_callbacks  *gyro_3d_register_callbacks(void);
+struct sensor_hub_callbacks  *compass_3d_register_callbacks(void);
 
 #endif
-- 
1.7.7.6

