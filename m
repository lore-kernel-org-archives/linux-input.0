From: srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH, 5/6] HID-Sensors: Added Compass 3D
Date: Mon, 25 Jun 2012 17:54:13 -0700
Message-ID: <1340672054-16591-6-git-send-email-srinivas.pandruvada@intel.com>
References: <1340672054-16591-1-git-send-email-srinivas.pandruvada@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56353 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757794Ab2FZBEq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jun 2012 21:04:46 -0400
In-Reply-To: <1340672054-16591-1-git-send-email-srinivas.pandruvada@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-iio@vger.kernel.org
Cc: jic23.cam.ac.uk@vger.kernel.org, jkosina@suse.cz, linux-input@vger.kernel.org, srinivas pandruvada <srinivas.pandruvada@intel.com>

Added usage id processing for Gyroscope 3D. This uses IIO
interfaces for triggerred buffer to present data to user
mode.This uses HID sensor framework for registering callback
events from the sensor hub.

Signed-off-by: srinivas pandruvada <srinivas.pandruvada@intel.com>
---
 drivers/staging/iio/magnetometer/Kconfig           |   10 +
 drivers/staging/iio/magnetometer/Makefile          |    2 +
 .../iio/magnetometer/hid-sensor-compass-3d.c       |  538 ++++++++++++++++++++
 3 files changed, 550 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/magnetometer/hid-sensor-compass-3d.c

diff --git a/drivers/staging/iio/magnetometer/Kconfig b/drivers/staging/iio/magnetometer/Kconfig
index 722c4e1..2999daf 100644
--- a/drivers/staging/iio/magnetometer/Kconfig
+++ b/drivers/staging/iio/magnetometer/Kconfig
@@ -24,4 +24,14 @@ config SENSORS_HMC5843
 	  To compile this driver as a module, choose M here: the module
 	  will be called hmc5843
 
+config HID_SENSOR_COMPASS_3D
+	depends on HID_SENSOR_HUB
+	select IIO_BUFFER
+	select IIO_TRIGGER
+	select IIO_TRIGGERED_BUFFER
+	tristate "HID Compass 3D"
+	help
+	  Say yes here to build support for the HID SENSOR
+	  Compass-3D.
+
 endmenu
diff --git a/drivers/staging/iio/magnetometer/Makefile b/drivers/staging/iio/magnetometer/Makefile
index f2a753f..85f6a70 100644
--- a/drivers/staging/iio/magnetometer/Makefile
+++ b/drivers/staging/iio/magnetometer/Makefile
@@ -4,3 +4,5 @@
 
 obj-$(CONFIG_SENSORS_AK8975)	+= ak8975.o
 obj-$(CONFIG_SENSORS_HMC5843)	+= hmc5843.o
+hid-sensor-compass-3d-drv-y  := hid-sensor-compass-3d.o
+obj-$(CONFIG_HID_SENSOR_COMPASS_3D) += hid-sensor-compass-3d-drv.o
diff --git a/drivers/staging/iio/magnetometer/hid-sensor-compass-3d.c b/drivers/staging/iio/magnetometer/hid-sensor-compass-3d.c
new file mode 100644
index 0000000..58908b7
--- /dev/null
+++ b/drivers/staging/iio/magnetometer/hid-sensor-compass-3d.c
@@ -0,0 +1,538 @@
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
+#include "../iio.h"
+#include "../sysfs.h"
+#include "../trigger.h"
+#include "../kfifo_buf.h"
+#include "../trigger_consumer.h"
+#include "../triggered_buffer.h"
+
+/*Format: HID-SENSOR-usage_id_in_hex*/
+#define DRIVER_NAME "HID-SENSOR-200083"
+
+#define CHANNEL_SCAN_INDEX_X 0
+#define CHANNEL_SCAN_INDEX_Y 1
+#define CHANNEL_SCAN_INDEX_Z 2
+
+struct compass_3d_sample {
+	u32 compass_x;
+	u32 compass_y;
+	u32 compass_z;
+} __packed;
+
+struct compass_3d_state {
+	struct hid_sensor_hub_device *hsdev;
+	struct platform_device *pdev;
+	struct hid_sensor_common_attributes *common_attrb;
+	struct hid_sensor_hub_attribute_info compass_x;
+	struct hid_sensor_hub_attribute_info compass_y;
+	struct hid_sensor_hub_attribute_info compass_z;
+	struct compass_3d_sample compass_sample_data;
+	bool data_ready;
+};
+
+static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
+						bool state)
+{
+	struct iio_dev *indio_dev = trig->private_data;
+	struct compass_3d_state *st = iio_priv(indio_dev);
+	int state_val;
+	char buffer[16];
+
+	dev_dbg(&indio_dev->dev, "hid_sensor_data_rdy_trigger_set_state %d\n",
+					state);
+	st->data_ready = state;
+	state_val = state ? 1 : 0;
+	sprintf(buffer, "%d", state_val);
+	hid_sensor_write_report_state(st->common_attrb, strlen(buffer), buffer);
+	hid_sensor_write_power_state(st->common_attrb, strlen(buffer), buffer);
+
+	return 0;
+}
+
+void hid_sensor_remove_trigger(struct iio_dev *indio_dev)
+{
+	iio_trigger_unregister(indio_dev->trig);
+	iio_free_trigger(indio_dev->trig);
+}
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
+	trig = iio_allocate_trigger("%s-dev%d", name, indio_dev->id);
+	if (trig == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+
+	trig->dev.parent = indio_dev->dev.parent;
+	trig->private_data = (void *)indio_dev;
+	trig->ops = &hid_sensor_trigger_ops;
+	ret = iio_trigger_register(trig);
+
+	/* select default trigger */
+	indio_dev->trig = trig;
+	if (ret)
+		goto error_free_trig;
+
+	return ret;
+
+error_free_trig:
+	iio_free_trigger(trig);
+error_ret:
+	return ret;
+}
+
+static struct iio_chan_spec compass_3d_channels[] = {
+	{
+		.type = IIO_MAGN,
+		.modified = 1,
+		.channel2 = IIO_MOD_X,
+		.info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.scan_index = CHANNEL_SCAN_INDEX_X,
+	}, {
+		.type = IIO_MAGN,
+		.modified = 1,
+		.channel2 = IIO_MOD_Y,
+		.info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.scan_index = CHANNEL_SCAN_INDEX_Y,
+	}, {
+		.type = IIO_MAGN,
+		.modified = 1,
+		.channel2 = IIO_MOD_Z,
+		.info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.scan_index = CHANNEL_SCAN_INDEX_Z,
+	}
+};
+
+static void compass_3d_adjust_channel_bit_mask(int channel, int size)
+{
+	compass_3d_channels[channel].scan_type.sign = 's';
+	compass_3d_channels[channel].scan_type.realbits = size * 8;
+	compass_3d_channels[channel].scan_type.storagebits = sizeof(u32) * 8;
+}
+
+static int compass_3d_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val, int *val2,
+			      long mask)
+{
+	struct compass_3d_state *compass_state = iio_priv(indio_dev);
+	int report_id = -1;
+	u32 address;
+
+	*val = 0;
+	*val2 = 0;
+	switch (mask) {
+	case 0:
+		switch (chan->scan_index) {
+		case  CHANNEL_SCAN_INDEX_X:
+			report_id = compass_state->compass_x.report_id;
+			address =
+			HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_X_AXIS;
+			break;
+		case  CHANNEL_SCAN_INDEX_Y:
+			report_id = compass_state->compass_y.report_id;
+			address =
+			HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_Y_AXIS;
+			break;
+		case  CHANNEL_SCAN_INDEX_Z:
+			report_id = compass_state->compass_z.report_id;
+			address =
+			HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_Z_AXIS;
+			break;
+		default:
+			report_id = -1;
+			break;
+		}
+		if (report_id >= 0)
+			*val = sensor_hub_input_attr_get_raw_value(
+				compass_state->hsdev,
+				HID_USAGE_SENSOR_COMPASS_3D, address,
+				report_id);
+		else
+			*val = 0;
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		*val = compass_state->compass_x.units;
+		break;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = compass_state->compass_x.unit_expo;
+		break;
+	default:
+		break;
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
+	dev_err(&indio_dev->dev, "%s\n", __func__);
+	return 0;
+}
+
+static ssize_t hid_sensor_compass_3d_read_hyst_raw(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	int len;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct compass_3d_state *compass_state = iio_priv(indio_dev);
+	len = hid_sensor_read_hyst_raw(compass_state->common_attrb, strlen(buf),
+					buf);
+	return len;
+}
+
+static ssize_t hid_sensor_compass_3d_write_hyst_raw(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct compass_3d_state *compass_state = iio_priv(indio_dev);
+	return hid_sensor_write_hyst_raw(compass_state->common_attrb,
+					strlen(buf), buf);
+}
+
+static ssize_t hid_sensor_read_compass_3d_samp_freq(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct compass_3d_state *compass_state = iio_priv(indio_dev);
+
+	return hid_sensor_read_samp_freq(compass_state->common_attrb,
+					strlen(buf), buf);
+}
+
+static ssize_t hid_sensor_write_compass_3d_samp_freq(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct compass_3d_state *compass_state = iio_priv(indio_dev);
+
+	return hid_sensor_write_samp_freq(compass_state->common_attrb,
+					strlen(buf), buf);
+}
+
+static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
+			hid_sensor_read_compass_3d_samp_freq,
+			hid_sensor_write_compass_3d_samp_freq);
+
+#define IIO_DEV_ATTR_HYSTERESIS(_mode, _show, _store, _addr)        \
+	IIO_DEVICE_ATTR(hyst_raw, _mode, _show, _store, _addr)
+
+static IIO_DEV_ATTR_HYSTERESIS(S_IWUSR | S_IRUSR,
+			hid_sensor_compass_3d_read_hyst_raw,
+			hid_sensor_compass_3d_write_hyst_raw,
+			HID_USAGE_SENSOR_PROPERTY_CHANGE_SENSITIVITY_ABS);
+
+static struct attribute *compass_3d_attributes[] = {
+	/* common attributes */
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	&iio_dev_attr_hyst_raw.dev_attr.attr,
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
+void hid_sensor_push_data(struct iio_dev *indio_dev, u8 *data, int len)
+{
+	struct iio_buffer *buffer = indio_dev->buffer;
+	s64 timestamp = iio_get_time_ns();
+	int datum_sz;
+
+	if (!buffer)
+		return;
+	datum_sz = buffer->access->get_bytes_per_datum(buffer);
+	if (len > datum_sz) {
+		dev_err(&indio_dev->dev, "Datum size mismatch %d:%d\n", len,
+				datum_sz);
+		return;
+	}
+	buffer->access->store_to(buffer, (u8 *)data, timestamp);
+}
+
+static irqreturn_t hid_sensor_trigger_handler(int irq, void *p)
+{
+	return IRQ_HANDLED;
+}
+
+int compass_3d_proc_event(struct hid_sensor_hub_device *hsdev,
+			unsigned usage_id,
+			void *priv)
+{
+	struct iio_dev *indio_dev =
+				(struct iio_dev *)platform_get_drvdata(priv);
+	struct compass_3d_state *compass_state = iio_priv(indio_dev);
+
+	dev_dbg(&indio_dev->dev, "compass_3d_proc_event\n");
+	if (compass_state->data_ready)
+		hid_sensor_push_data(indio_dev,
+				(u8 *)&compass_state->compass_sample_data,
+				sizeof(struct compass_3d_sample));
+	return 0;
+}
+
+/* Capture samples in local storage */
+int compass_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
+				unsigned usage_id,
+				size_t raw_len, char *raw_data,
+				void *priv)
+{
+	struct iio_dev *indio_dev =
+			(struct iio_dev *)platform_get_drvdata(priv);
+	struct compass_3d_state *compass_state = iio_priv(indio_dev);
+
+	switch (usage_id) {
+	case HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_X_AXIS:
+		compass_state->compass_sample_data.compass_x =
+		*(u32 *)raw_data;
+		break;
+	case HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_Y_AXIS:
+		compass_state->compass_sample_data.compass_y =
+		*(u32 *)raw_data;
+		break;
+	case HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_Z_AXIS:
+		compass_state->compass_sample_data.compass_z =
+		*(u32 *)raw_data;
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+/* Parse report which is specific to an usage id*/
+static int compass_3d_parse_report(struct hid_sensor_hub_device *hsdev,
+				unsigned usage_id,
+				struct compass_3d_state *st)
+{
+	int ret;
+
+	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT,
+			usage_id,
+			HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_X_AXIS,
+			&st->compass_x);
+	compass_3d_adjust_channel_bit_mask(CHANNEL_SCAN_INDEX_X,
+					st->compass_x.size);
+
+	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT,
+			usage_id,
+			HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_Y_AXIS,
+			&st->compass_y);
+	compass_3d_adjust_channel_bit_mask(CHANNEL_SCAN_INDEX_Y,
+					st->compass_y.size);
+
+	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT,
+			usage_id,
+			HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_Z_AXIS,
+			&st->compass_z);
+	compass_3d_adjust_channel_bit_mask(CHANNEL_SCAN_INDEX_Z,
+					st->compass_z.size);
+
+	dev_dbg(&st->pdev->dev, "compass_3d %x:%x, %x:%x, %x:%x\n",
+			st->compass_x.index,
+			st->compass_x.report_id,
+			st->compass_y.index, st->compass_y.report_id,
+			st->compass_z.index, st->compass_z.report_id);
+
+	return 0;
+}
+
+/* Entry function to initialize the processing for usage id */
+static int compass_3d_init(struct platform_device *pdev,
+			struct hid_sensor_hub_device *hsdev,
+			unsigned usage_id)
+{
+	int ret = 0;
+	static char *name = "compass_3d";
+	struct iio_dev *indio_dev;
+	struct compass_3d_state *compass_state;
+
+	indio_dev = iio_allocate_device(sizeof(struct compass_3d_state));
+	if (indio_dev == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+	platform_set_drvdata(pdev, indio_dev);
+	compass_state = iio_priv(indio_dev);
+	compass_state->hsdev = hsdev;
+	compass_state->pdev = pdev;
+	compass_state->common_attrb = sensor_hub_allocate_common_attributes(
+					hsdev, HID_USAGE_SENSOR_COMPASS_3D);
+	if (compass_state->common_attrb == NULL) {
+		ret = -ENOMEM;
+		goto error_free_dev;
+	}
+
+	ret = compass_3d_parse_report(hsdev, usage_id, compass_state);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to setup attributes\n");
+		goto error_free_dev;
+	}
+
+	indio_dev->channels = compass_3d_channels;
+	indio_dev->num_channels =
+				ARRAY_SIZE(compass_3d_channels);
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->info = &compass_3d_info;
+	indio_dev->name = name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
+		&hid_sensor_trigger_handler, NULL);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to initialize trigger buffer\n");
+		goto error_free_dev;
+	}
+	iio_scan_mask_set(indio_dev, indio_dev->buffer,
+			   CHANNEL_SCAN_INDEX_X);
+	iio_scan_mask_set(indio_dev, indio_dev->buffer,
+			   CHANNEL_SCAN_INDEX_Y);
+	iio_scan_mask_set(indio_dev, indio_dev->buffer,
+			   CHANNEL_SCAN_INDEX_Z);
+	compass_state->data_ready = false;
+	ret = hid_sensor_setup_trigger(indio_dev, name);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "trigger setup failed\n");
+		goto error_unreg_buffer_funcs;
+	}
+
+	ret = iio_device_register(indio_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "device register failed\n");
+		goto error_remove_trigger;
+	}
+	return ret;
+
+error_remove_trigger:
+	hid_sensor_remove_trigger(indio_dev);
+error_unreg_buffer_funcs:
+	iio_triggered_buffer_cleanup(indio_dev);
+error_free_dev:
+	iio_free_device(indio_dev);
+error_ret:
+	return ret;
+}
+
+static int compass_3d_exit(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct compass_3d_state *st = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	hid_sensor_remove_trigger(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
+	sensor_hub_free_common_attributes(st->common_attrb);
+	iio_free_device(indio_dev);
+	return ret;
+}
+
+static struct hid_sensor_hub_callbacks compass_3d_callbacks = {
+	.send_event = compass_3d_proc_event,
+	.capture_sample = compass_3d_capture_sample,
+};
+
+static int __devinit hid_compass_3d_probe(struct platform_device *pdev)
+{
+	int ret;
+	u32 *pdata = (u32 *)pdev->dev.platform_data;
+	struct hid_sensor_hub_device *hsdev;
+
+	hsdev = (struct hid_sensor_hub_device *)*pdata;
+	ret = compass_3d_init(pdev, hsdev, HID_USAGE_SENSOR_COMPASS_3D);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "compass_3d_init failed\n");
+		return ret;
+	}
+	compass_3d_callbacks.pdev = pdev;
+	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D,
+					&compass_3d_callbacks);
+	return 0;
+}
+
+static int __devinit hid_compass_3d_remove(struct platform_device *pdev)
+{
+	u32 *pdata = (u32 *)pdev->dev.platform_data;
+	struct hid_sensor_hub_device *hsdev;
+
+	hsdev = (struct hid_sensor_hub_device *)*pdata;
+	compass_3d_exit(pdev);
+	return sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D);
+}
+
+static struct platform_driver hid_compass_3d_platform_driver = {
+	.driver = {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= hid_compass_3d_probe,
+	.remove		= hid_compass_3d_remove,
+};
+
+/*--------------------------------------------------------------------------*/
+
+static int __init hid_compass_3d_init(void)
+{
+	return platform_driver_register(&hid_compass_3d_platform_driver);
+}
+
+static void __exit hid_compass_3d_exit(void)
+{
+	platform_driver_unregister(&hid_compass_3d_platform_driver);
+}
+
+module_init(hid_compass_3d_init);
+module_exit(hid_compass_3d_exit);
+
+MODULE_DESCRIPTION("HID Sensor Compass 3D");
+MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@intel.com>");
+MODULE_LICENSE("GPL");
-- 
1.7.7.6

