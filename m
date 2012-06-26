From: srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH, 4/6] HID-Sensors: Added Gyroscope 3D
Date: Mon, 25 Jun 2012 17:54:12 -0700
Message-ID: <1340672054-16591-5-git-send-email-srinivas.pandruvada@intel.com>
References: <1340672054-16591-1-git-send-email-srinivas.pandruvada@intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340672054-16591-1-git-send-email-srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jic23.cam.ac.uk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Added usage id processing for Gyroscope 3D. This uses IIO
interfaces for triggerred buffer to present data to user
mode.This uses HID sensor framework for registering callback
events from the sensor hub.

Signed-off-by: srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/staging/iio/gyro/Kconfig              |   10 +
 drivers/staging/iio/gyro/Makefile             |    3 +
 drivers/staging/iio/gyro/hid-sensor-gyro-3d.c |  537 +++++++++++++++++++++++++
 3 files changed, 550 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/gyro/hid-sensor-gyro-3d.c

diff --git a/drivers/staging/iio/gyro/Kconfig b/drivers/staging/iio/gyro/Kconfig
index ea295b2..7744b1d 100644
--- a/drivers/staging/iio/gyro/Kconfig
+++ b/drivers/staging/iio/gyro/Kconfig
@@ -46,4 +46,14 @@ config ADXRS450
 	  This driver can also be built as a module.  If so, the module
 	  will be called adxrs450.
 
+config HID_SENSOR_GYRO_3D
+	depends on HID_SENSOR_HUB
+	select IIO_BUFFER
+	select IIO_TRIGGER
+	select IIO_TRIGGERED_BUFFER
+	tristate "HID Gyroscope 3D"
+	help
+	  Say yes here to build support for the HID SENSOR
+	  Gyroscope-3D.
+
 endmenu
diff --git a/drivers/staging/iio/gyro/Makefile b/drivers/staging/iio/gyro/Makefile
index 9ba5ec1..fa24d34 100644
--- a/drivers/staging/iio/gyro/Makefile
+++ b/drivers/staging/iio/gyro/Makefile
@@ -20,3 +20,6 @@ obj-$(CONFIG_ADIS16251) += adis16251.o
 
 adxrs450-y             := adxrs450_core.o
 obj-$(CONFIG_ADXRS450) += adxrs450.o
+
+hid-sensor-gyro-3d-drv-y  := hid-sensor-gyro-3d.o
+obj-$(CONFIG_HID_SENSOR_GYRO_3D) += hid-sensor-gyro-3d-drv.o
diff --git a/drivers/staging/iio/gyro/hid-sensor-gyro-3d.c b/drivers/staging/iio/gyro/hid-sensor-gyro-3d.c
new file mode 100644
index 0000000..5dddf6f
--- /dev/null
+++ b/drivers/staging/iio/gyro/hid-sensor-gyro-3d.c
@@ -0,0 +1,537 @@
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
+#define DRIVER_NAME "HID-SENSOR-200076"
+
+#define CHANNEL_SCAN_INDEX_X 0
+#define CHANNEL_SCAN_INDEX_Y 1
+#define CHANNEL_SCAN_INDEX_Z 2
+
+struct gyro_3d_sample {
+	u32 gyro_x;
+	u32 gyro_y;
+	u32 gyro_z;
+} __packed;
+
+struct gyro_3d_state {
+	struct hid_sensor_hub_device *hsdev;
+	struct platform_device *pdev;
+	struct hid_sensor_common_attributes *common_attrb;
+	struct hid_sensor_hub_attribute_info gyro_x;
+	struct hid_sensor_hub_attribute_info gyro_y;
+	struct hid_sensor_hub_attribute_info gyro_z;
+	struct gyro_3d_sample gyro_sample_data;
+	bool data_ready;
+};
+
+static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
+						bool state)
+{
+	struct iio_dev *indio_dev = trig->private_data;
+	struct gyro_3d_state *st = iio_priv(indio_dev);
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
+static struct iio_chan_spec gyro_3d_channels[] = {
+	{
+		.type = IIO_ANGL_VEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_X,
+		.info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.scan_index = CHANNEL_SCAN_INDEX_X,
+	}, {
+		.type = IIO_ANGL_VEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_Y,
+		.info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.scan_index = CHANNEL_SCAN_INDEX_Y,
+	}, {
+		.type = IIO_ANGL_VEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_Z,
+		.info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.scan_index = CHANNEL_SCAN_INDEX_Z,
+	}
+};
+
+static void gyro_3d_adjust_channel_bit_mask(int channel, int size)
+{
+	gyro_3d_channels[channel].scan_type.sign = 's';
+	gyro_3d_channels[channel].scan_type.realbits = size * 8;
+	gyro_3d_channels[channel].scan_type.storagebits = sizeof(u32) * 8;
+}
+
+static int gyro_3d_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val, int *val2,
+			      long mask)
+{
+	struct gyro_3d_state *gyro_state = iio_priv(indio_dev);
+	int report_id = -1;
+	u32 address;
+
+	*val = 0;
+	*val2 = 0;
+	switch (mask) {
+	case 0:
+		switch (chan->scan_index) {
+		case  CHANNEL_SCAN_INDEX_X:
+			report_id = gyro_state->gyro_x.report_id;
+			address =
+			HID_USAGE_SENSOR_DATA_MOTION_ANGULAR_VELOCITY_X_AXIS;
+			break;
+		case  CHANNEL_SCAN_INDEX_Y:
+			report_id = gyro_state->gyro_y.report_id;
+			address =
+			HID_USAGE_SENSOR_DATA_MOTION_ANGULAR_VELOCITY_Y_AXIS;
+			break;
+		case  CHANNEL_SCAN_INDEX_Z:
+			report_id = gyro_state->gyro_z.report_id;
+			address =
+			HID_USAGE_SENSOR_DATA_MOTION_ANGULAR_VELOCITY_Z_AXIS;
+			break;
+		default:
+			report_id = -1;
+			break;
+		}
+		if (report_id >= 0)
+			*val = sensor_hub_input_attr_get_raw_value(
+				gyro_state->hsdev,
+				HID_USAGE_SENSOR_GYRO_3D, address,
+				report_id);
+		else
+			*val = 0;
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		*val = gyro_state->gyro_x.units;
+		break;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = gyro_state->gyro_x.unit_expo;
+		break;
+	default:
+		break;
+	}
+	return IIO_VAL_INT;
+}
+
+static int gyro_3d_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int val,
+			       int val2,
+			       long mask)
+{
+	dev_err(&indio_dev->dev, "%s\n", __func__);
+	return 0;
+}
+
+static ssize_t hid_sensor_gyro_3d_read_hyst_raw(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	int len;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct gyro_3d_state *gyro_state = iio_priv(indio_dev);
+	len = hid_sensor_read_hyst_raw(gyro_state->common_attrb, strlen(buf),
+					buf);
+	return len;
+}
+
+static ssize_t hid_sensor_gyro_3d_write_hyst_raw(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct gyro_3d_state *gyro_state = iio_priv(indio_dev);
+	return hid_sensor_write_hyst_raw(gyro_state->common_attrb,
+					strlen(buf), buf);
+}
+
+static ssize_t hid_sensor_read_gyro_3d_samp_freq(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct gyro_3d_state *gyro_state = iio_priv(indio_dev);
+
+	return hid_sensor_read_samp_freq(gyro_state->common_attrb,
+					strlen(buf), buf);
+}
+
+static ssize_t hid_sensor_write_gyro_3d_samp_freq(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct gyro_3d_state *gyro_state = iio_priv(indio_dev);
+
+	return hid_sensor_write_samp_freq(gyro_state->common_attrb,
+					strlen(buf), buf);
+}
+
+static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
+			hid_sensor_read_gyro_3d_samp_freq,
+			hid_sensor_write_gyro_3d_samp_freq);
+
+#define IIO_DEV_ATTR_HYSTERESIS(_mode, _show, _store, _addr)        \
+	IIO_DEVICE_ATTR(hyst_raw, _mode, _show, _store, _addr)
+
+static IIO_DEV_ATTR_HYSTERESIS(S_IWUSR | S_IRUSR,
+			hid_sensor_gyro_3d_read_hyst_raw,
+			hid_sensor_gyro_3d_write_hyst_raw,
+			HID_USAGE_SENSOR_PROPERTY_CHANGE_SENSITIVITY_ABS);
+
+static struct attribute *gyro_3d_attributes[] = {
+	/* common attributes */
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	&iio_dev_attr_hyst_raw.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group gyro_3d_attribute_group = {
+	.attrs = gyro_3d_attributes,
+};
+
+static const struct iio_info gyro_3d_info = {
+	.attrs = &gyro_3d_attribute_group,
+	.driver_module = THIS_MODULE,
+	.read_raw = &gyro_3d_read_raw,
+	.write_raw = &gyro_3d_write_raw,
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
+int gyro_3d_proc_event(struct hid_sensor_hub_device *hsdev, unsigned usage_id,
+			void *priv)
+{
+	struct iio_dev *indio_dev =
+				(struct iio_dev *)platform_get_drvdata(priv);
+	struct gyro_3d_state *gyro_state = iio_priv(indio_dev);
+
+	dev_dbg(&indio_dev->dev, "gyro_3d_proc_event\n");
+	if (gyro_state->data_ready)
+		hid_sensor_push_data(indio_dev,
+				(u8 *)&gyro_state->gyro_sample_data,
+				sizeof(struct gyro_3d_sample));
+	return 0;
+}
+
+/* Capture samples in local storage */
+int gyro_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
+				unsigned usage_id,
+				size_t raw_len, char *raw_data,
+				void *priv)
+{
+	struct iio_dev *indio_dev =
+			(struct iio_dev *)platform_get_drvdata(priv);
+	struct gyro_3d_state *gyro_state = iio_priv(indio_dev);
+
+	switch (usage_id) {
+	case HID_USAGE_SENSOR_DATA_MOTION_ANGULAR_VELOCITY_X_AXIS:
+		gyro_state->gyro_sample_data.gyro_x =
+		*(u32 *)raw_data;
+		break;
+	case HID_USAGE_SENSOR_DATA_MOTION_ANGULAR_VELOCITY_Y_AXIS:
+		gyro_state->gyro_sample_data.gyro_y =
+		*(u32 *)raw_data;
+		break;
+	case HID_USAGE_SENSOR_DATA_MOTION_ANGULAR_VELOCITY_Z_AXIS:
+		gyro_state->gyro_sample_data.gyro_z =
+		*(u32 *)raw_data;
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+/* Parse report which is specific to an usage id*/
+static int gyro_3d_parse_report(struct hid_sensor_hub_device *hsdev,
+				unsigned usage_id,
+				struct gyro_3d_state *st)
+{
+	int ret;
+
+	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT,
+			usage_id,
+			HID_USAGE_SENSOR_DATA_MOTION_ANGULAR_VELOCITY_X_AXIS,
+			&st->gyro_x);
+	gyro_3d_adjust_channel_bit_mask(CHANNEL_SCAN_INDEX_X,
+					st->gyro_x.size);
+
+	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT,
+			usage_id,
+			HID_USAGE_SENSOR_DATA_MOTION_ANGULAR_VELOCITY_Y_AXIS,
+			&st->gyro_y);
+	gyro_3d_adjust_channel_bit_mask(CHANNEL_SCAN_INDEX_Y,
+					st->gyro_y.size);
+
+	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT,
+			usage_id,
+			HID_USAGE_SENSOR_DATA_MOTION_ANGULAR_VELOCITY_Z_AXIS,
+			&st->gyro_z);
+	gyro_3d_adjust_channel_bit_mask(CHANNEL_SCAN_INDEX_Z,
+					st->gyro_z.size);
+
+	dev_dbg(&st->pdev->dev, "gyro_3d %x:%x, %x:%x, %x:%x\n",
+			st->gyro_x.index,
+			st->gyro_x.report_id,
+			st->gyro_y.index, st->gyro_y.report_id,
+			st->gyro_z.index, st->gyro_z.report_id);
+
+	return 0;
+}
+
+/* Entry function to initialize the processing for usage id */
+static int gyro_3d_init(struct platform_device *pdev,
+			struct hid_sensor_hub_device *hsdev,
+			unsigned usage_id)
+{
+	int ret = 0;
+	static char *name = "gyro_3d";
+	struct iio_dev *indio_dev;
+	struct gyro_3d_state *gyro_state;
+
+	indio_dev = iio_allocate_device(sizeof(struct gyro_3d_state));
+	if (indio_dev == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+	platform_set_drvdata(pdev, indio_dev);
+	gyro_state = iio_priv(indio_dev);
+	gyro_state->hsdev = hsdev;
+	gyro_state->pdev = pdev;
+	gyro_state->common_attrb = sensor_hub_allocate_common_attributes(
+					hsdev, HID_USAGE_SENSOR_GYRO_3D);
+	if (gyro_state->common_attrb == NULL) {
+		ret = -ENOMEM;
+		goto error_free_dev;
+	}
+
+	ret = gyro_3d_parse_report(hsdev, usage_id, gyro_state);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to setup attributes\n");
+		goto error_free_dev;
+	}
+
+	indio_dev->channels = gyro_3d_channels;
+	indio_dev->num_channels =
+				ARRAY_SIZE(gyro_3d_channels);
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->info = &gyro_3d_info;
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
+	gyro_state->data_ready = false;
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
+static int gyro_3d_exit(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct gyro_3d_state *st = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	hid_sensor_remove_trigger(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
+	sensor_hub_free_common_attributes(st->common_attrb);
+	iio_free_device(indio_dev);
+	return ret;
+}
+
+static struct hid_sensor_hub_callbacks gyro_3d_callbacks = {
+	.send_event = gyro_3d_proc_event,
+	.capture_sample = gyro_3d_capture_sample,
+};
+
+static int __devinit hid_gyro_3d_probe(struct platform_device *pdev)
+{
+	int ret;
+	u32 *pdata = (u32 *)pdev->dev.platform_data;
+	struct hid_sensor_hub_device *hsdev;
+
+	hsdev = (struct hid_sensor_hub_device *)*pdata;
+	ret = gyro_3d_init(pdev, hsdev, HID_USAGE_SENSOR_GYRO_3D);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "gyro_3d_init failed\n");
+		return ret;
+	}
+	gyro_3d_callbacks.pdev = pdev;
+	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D,
+					&gyro_3d_callbacks);
+	return 0;
+}
+
+static int __devinit hid_gyro_3d_remove(struct platform_device *pdev)
+{
+	u32 *pdata = (u32 *)pdev->dev.platform_data;
+	struct hid_sensor_hub_device *hsdev;
+
+	hsdev = (struct hid_sensor_hub_device *)*pdata;
+	gyro_3d_exit(pdev);
+	return sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
+}
+
+static struct platform_driver hid_gyro_3d_platform_driver = {
+	.driver = {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= hid_gyro_3d_probe,
+	.remove		= hid_gyro_3d_remove,
+};
+
+/*--------------------------------------------------------------------------*/
+
+static int __init hid_gyro_3d_init(void)
+{
+	return platform_driver_register(&hid_gyro_3d_platform_driver);
+}
+
+static void __exit hid_gyro_3d_exit(void)
+{
+	platform_driver_unregister(&hid_gyro_3d_platform_driver);
+}
+
+module_init(hid_gyro_3d_init);
+module_exit(hid_gyro_3d_exit);
+
+MODULE_DESCRIPTION("HID Sensor Gyroscope 3D");
+MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>");
+MODULE_LICENSE("GPL");
-- 
1.7.7.6
