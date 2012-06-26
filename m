From: srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH, 3/6] HID-Sensors: Added accelerometer 3D
Date: Mon, 25 Jun 2012 17:54:11 -0700
Message-ID: <1340672054-16591-4-git-send-email-srinivas.pandruvada@intel.com>
References: <1340672054-16591-1-git-send-email-srinivas.pandruvada@intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340672054-16591-1-git-send-email-srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jic23.cam.ac.uk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Added usage id processing for Accelrometer 3D. This uses IIO
interfaces for triggerred buffer to present data to user
mode.This uses HID sensor framework for registering callback
events from the sensor hub.

Signed-off-by: srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/staging/iio/accel/Kconfig               |   10 +
 drivers/staging/iio/accel/Makefile              |    3 +
 drivers/staging/iio/accel/hid-sensor-accel-3d.c |  537 +++++++++++++++++++++++
 3 files changed, 550 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/accel/hid-sensor-accel-3d.c

diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig
index 5ab7167..bf93c6d 100644
--- a/drivers/staging/iio/accel/Kconfig
+++ b/drivers/staging/iio/accel/Kconfig
@@ -102,4 +102,14 @@ config SCA3000
 	  Say yes here to build support for the VTI SCA3000 series of SPI
 	  accelerometers. These devices use a hardware ring buffer.
 
+config HID_SENSOR_ACCEL_3D
+	depends on HID_SENSOR_HUB
+	select IIO_BUFFER
+	select IIO_TRIGGER
+	select IIO_TRIGGERED_BUFFER
+	tristate "HID Acelerometers 3D"
+	help
+	  Say yes here to build support for the HID SENSOR
+	  accelerometers.
+
 endmenu
diff --git a/drivers/staging/iio/accel/Makefile b/drivers/staging/iio/accel/Makefile
index 95c6666..d454c7d 100644
--- a/drivers/staging/iio/accel/Makefile
+++ b/drivers/staging/iio/accel/Makefile
@@ -33,3 +33,6 @@ obj-$(CONFIG_LIS3L02DQ)	+= lis3l02dq.o
 
 sca3000-y		:= sca3000_core.o sca3000_ring.o
 obj-$(CONFIG_SCA3000)	+= sca3000.o
+
+hid-sensor-accel-3d-drv-y		:= hid-sensor-accel-3d.o
+obj-$(CONFIG_HID_SENSOR_ACCEL_3D) += hid-sensor-accel-3d-drv.o
diff --git a/drivers/staging/iio/accel/hid-sensor-accel-3d.c b/drivers/staging/iio/accel/hid-sensor-accel-3d.c
new file mode 100644
index 0000000..77d4663
--- /dev/null
+++ b/drivers/staging/iio/accel/hid-sensor-accel-3d.c
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
+#define DRIVER_NAME "HID-SENSOR-200073"
+
+#define CHANNEL_SCAN_INDEX_X 0
+#define CHANNEL_SCAN_INDEX_Y 1
+#define CHANNEL_SCAN_INDEX_Z 2
+
+struct accel_3d_sample {
+	u32 accel_x;
+	u32 accel_y;
+	u32 accel_z;
+} __packed;
+
+struct accel_3d_state {
+	struct hid_sensor_hub_device *hsdev;
+	struct platform_device *pdev;
+	struct hid_sensor_common_attributes *common_attrb;
+	struct hid_sensor_hub_attribute_info accel_x;
+	struct hid_sensor_hub_attribute_info accel_y;
+	struct hid_sensor_hub_attribute_info accel_z;
+	struct accel_3d_sample accel_sample_data;
+	bool data_ready;
+};
+
+static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
+						bool state)
+{
+	struct iio_dev *indio_dev = trig->private_data;
+	struct accel_3d_state *st = iio_priv(indio_dev);
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
+static struct iio_chan_spec accel_3d_channels[] = {
+	{
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_X,
+		.info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.scan_index = CHANNEL_SCAN_INDEX_X,
+	}, {
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_Y,
+		.info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.scan_index = CHANNEL_SCAN_INDEX_Y,
+	}, {
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_Z,
+		.info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.scan_index = CHANNEL_SCAN_INDEX_Z,
+	}
+};
+
+static void accel_3d_adjust_channel_bit_mask(int channel, int size)
+{
+	accel_3d_channels[channel].scan_type.sign = 's';
+	accel_3d_channels[channel].scan_type.realbits = size * 8;
+	accel_3d_channels[channel].scan_type.storagebits = sizeof(u32) * 8;
+}
+
+static int accel_3d_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val, int *val2,
+			      long mask)
+{
+	struct accel_3d_state *accel_state = iio_priv(indio_dev);
+	int report_id = -1;
+	u32 address;
+
+	*val = 0;
+	*val2 = 0;
+	switch (mask) {
+	case 0:
+		switch (chan->scan_index) {
+		case  CHANNEL_SCAN_INDEX_X:
+			report_id = accel_state->accel_x.report_id;
+			address =
+			HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_X_AXIS;
+			break;
+		case  CHANNEL_SCAN_INDEX_Y:
+			report_id = accel_state->accel_y.report_id;
+			address =
+			HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_Y_AXIS;
+			break;
+		case  CHANNEL_SCAN_INDEX_Z:
+			report_id = accel_state->accel_z.report_id;
+			address =
+			HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_Z_AXIS;
+			break;
+		default:
+			report_id = -1;
+			break;
+		}
+		if (report_id >= 0)
+			*val = sensor_hub_input_attr_get_raw_value(
+				accel_state->hsdev,
+				HID_USAGE_SENSOR_ACCEL_3D, address,
+				report_id);
+		else
+			*val = 0;
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		*val = accel_state->accel_x.units;
+		break;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = accel_state->accel_x.unit_expo;
+		break;
+	default:
+		break;
+	}
+	return IIO_VAL_INT;
+}
+
+static int accel_3d_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int val,
+			       int val2,
+			       long mask)
+{
+	dev_err(&indio_dev->dev, "%s\n", __func__);
+	return 0;
+}
+
+static ssize_t hid_sensor_accel_3d_read_hyst_raw(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	int len;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct accel_3d_state *accel_state = iio_priv(indio_dev);
+	len = hid_sensor_read_hyst_raw(accel_state->common_attrb, strlen(buf),
+					buf);
+	return len;
+}
+
+static ssize_t hid_sensor_accel_3d_write_hyst_raw(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct accel_3d_state *accel_state = iio_priv(indio_dev);
+	return hid_sensor_write_hyst_raw(accel_state->common_attrb,
+					strlen(buf), buf);
+}
+
+static ssize_t hid_sensor_read_accel_3d_samp_freq(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct accel_3d_state *accel_state = iio_priv(indio_dev);
+
+	return hid_sensor_read_samp_freq(accel_state->common_attrb,
+					strlen(buf), buf);
+}
+
+static ssize_t hid_sensor_write_accel_3d_samp_freq(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct accel_3d_state *accel_state = iio_priv(indio_dev);
+
+	return hid_sensor_write_samp_freq(accel_state->common_attrb,
+					strlen(buf), buf);
+}
+
+static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
+			hid_sensor_read_accel_3d_samp_freq,
+			hid_sensor_write_accel_3d_samp_freq);
+
+#define IIO_DEV_ATTR_HYSTERESIS(_mode, _show, _store, _addr)        \
+	IIO_DEVICE_ATTR(hyst_raw, _mode, _show, _store, _addr)
+
+static IIO_DEV_ATTR_HYSTERESIS(S_IWUSR | S_IRUSR,
+			hid_sensor_accel_3d_read_hyst_raw,
+			hid_sensor_accel_3d_write_hyst_raw,
+			HID_USAGE_SENSOR_PROPERTY_CHANGE_SENSITIVITY_ABS);
+
+static struct attribute *accel_3d_attributes[] = {
+	/* common attributes */
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	&iio_dev_attr_hyst_raw.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group accel_3d_attribute_group = {
+	.attrs = accel_3d_attributes,
+};
+
+static const struct iio_info accel_3d_info = {
+	.attrs = &accel_3d_attribute_group,
+	.driver_module = THIS_MODULE,
+	.read_raw = &accel_3d_read_raw,
+	.write_raw = &accel_3d_write_raw,
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
+int accel_3d_proc_event(struct hid_sensor_hub_device *hsdev, unsigned usage_id,
+			void *priv)
+{
+	struct iio_dev *indio_dev =
+				(struct iio_dev *)platform_get_drvdata(priv);
+	struct accel_3d_state *accel_state = iio_priv(indio_dev);
+
+	dev_dbg(&indio_dev->dev, "accel_3d_proc_event\n");
+	if (accel_state->data_ready)
+		hid_sensor_push_data(indio_dev,
+				(u8 *)&accel_state->accel_sample_data,
+				sizeof(struct accel_3d_sample));
+	return 0;
+}
+
+/* Capture samples in local storage */
+int accel_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
+				unsigned usage_id,
+				size_t raw_len, char *raw_data,
+				void *priv)
+{
+	struct iio_dev *indio_dev =
+			(struct iio_dev *)platform_get_drvdata(priv);
+	struct accel_3d_state *accel_state = iio_priv(indio_dev);
+
+	switch (usage_id) {
+	case HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_X_AXIS:
+		accel_state->accel_sample_data.accel_x =
+		*(u32 *)raw_data;
+		break;
+	case HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_Y_AXIS:
+		accel_state->accel_sample_data.accel_y =
+		*(u32 *)raw_data;
+		break;
+	case HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_Z_AXIS:
+		accel_state->accel_sample_data.accel_z =
+		*(u32 *)raw_data;
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+/* Parse report which is specific to an usage id*/
+static int accel_3d_parse_report(struct hid_sensor_hub_device *hsdev,
+				unsigned usage_id,
+				struct accel_3d_state *st)
+{
+	int ret;
+
+	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT,
+			usage_id,
+			HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_X_AXIS,
+			&st->accel_x);
+	accel_3d_adjust_channel_bit_mask(CHANNEL_SCAN_INDEX_X,
+					st->accel_x.size);
+
+	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT,
+			usage_id,
+			HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_Y_AXIS,
+			&st->accel_y);
+	accel_3d_adjust_channel_bit_mask(CHANNEL_SCAN_INDEX_Y,
+					st->accel_y.size);
+
+	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT,
+			usage_id,
+			HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_Z_AXIS,
+			&st->accel_z);
+	accel_3d_adjust_channel_bit_mask(CHANNEL_SCAN_INDEX_Z,
+					st->accel_z.size);
+
+	dev_dbg(&st->pdev->dev, "accel_3d %x:%x, %x:%x, %x:%x\n",
+			st->accel_x.index,
+			st->accel_x.report_id,
+			st->accel_y.index, st->accel_y.report_id,
+			st->accel_z.index, st->accel_z.report_id);
+
+	return 0;
+}
+
+/* Entry function to initialize the processing for usage id */
+static int accel_3d_init(struct platform_device *pdev,
+			struct hid_sensor_hub_device *hsdev,
+			unsigned usage_id)
+{
+	int ret = 0;
+	static char *name = "accel_3d";
+	struct iio_dev *indio_dev;
+	struct accel_3d_state *accel_state;
+
+	indio_dev = iio_allocate_device(sizeof(struct accel_3d_state));
+	if (indio_dev == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+	platform_set_drvdata(pdev, indio_dev);
+	accel_state = iio_priv(indio_dev);
+	accel_state->hsdev = hsdev;
+	accel_state->pdev = pdev;
+	accel_state->common_attrb = sensor_hub_allocate_common_attributes(
+					hsdev, HID_USAGE_SENSOR_ACCEL_3D);
+	if (accel_state->common_attrb == NULL) {
+		ret = -ENOMEM;
+		goto error_free_dev;
+	}
+
+	ret = accel_3d_parse_report(hsdev, usage_id, accel_state);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to setup attributes\n");
+		goto error_free_dev;
+	}
+
+	indio_dev->channels = accel_3d_channels;
+	indio_dev->num_channels =
+				ARRAY_SIZE(accel_3d_channels);
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->info = &accel_3d_info;
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
+	accel_state->data_ready = false;
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
+static int accel_3d_exit(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct accel_3d_state *st = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	hid_sensor_remove_trigger(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
+	sensor_hub_free_common_attributes(st->common_attrb);
+	iio_free_device(indio_dev);
+	return ret;
+}
+
+static struct hid_sensor_hub_callbacks accel_3d_callbacks = {
+	.send_event = accel_3d_proc_event,
+	.capture_sample = accel_3d_capture_sample,
+};
+
+static int __devinit hid_accel_3d_probe(struct platform_device *pdev)
+{
+	int ret;
+	u32 *pdata = (u32 *)pdev->dev.platform_data;
+	struct hid_sensor_hub_device *hsdev;
+
+	hsdev = (struct hid_sensor_hub_device *)*pdata;
+	ret = accel_3d_init(pdev, hsdev, HID_USAGE_SENSOR_ACCEL_3D);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "accel_3d_init failed\n");
+		return ret;
+	}
+	accel_3d_callbacks.pdev = pdev;
+	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_ACCEL_3D,
+					&accel_3d_callbacks);
+	return 0;
+}
+
+static int __devinit hid_accel_3d_remove(struct platform_device *pdev)
+{
+	u32 *pdata = (u32 *)pdev->dev.platform_data;
+	struct hid_sensor_hub_device *hsdev;
+
+	hsdev = (struct hid_sensor_hub_device *)*pdata;
+	accel_3d_exit(pdev);
+	return sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_ACCEL_3D);
+}
+
+static struct platform_driver hid_accel_3d_platform_driver = {
+	.driver = {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= hid_accel_3d_probe,
+	.remove		= hid_accel_3d_remove,
+};
+
+/*--------------------------------------------------------------------------*/
+
+static int __init hid_accel_3d_init(void)
+{
+	return platform_driver_register(&hid_accel_3d_platform_driver);
+}
+
+static void __exit hid_accel_3d_exit(void)
+{
+	platform_driver_unregister(&hid_accel_3d_platform_driver);
+}
+
+module_init(hid_accel_3d_init);
+module_exit(hid_accel_3d_exit);
+
+MODULE_DESCRIPTION("HID Sensor Accel 3D");
+MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>");
+MODULE_LICENSE("GPL");
-- 
1.7.7.6
