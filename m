From: srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH 6/8] HID-Sensors: Added Gyroscope 3D
Date: Wed,  4 Jul 2012 12:52:10 -0700
Message-ID: <1341431532-15060-7-git-send-email-srinivas.pandruvada@intel.com>
References: <1341431532-15060-1-git-send-email-srinivas.pandruvada@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:35298 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755689Ab2GDUCs (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Jul 2012 16:02:48 -0400
In-Reply-To: <1341431532-15060-1-git-send-email-srinivas.pandruvada@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-iio@vger.kernel.org
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, lars@metafoo.de, jic23@cam.ac.uk, srinivas pandruvada <srinivas.pandruvada@intel.com>

Added usage id processing for Gyroscope 3D. This uses IIO
interfaces for triggerred buffer to present data to user
mode.This uses HID sensor framework for registering callback
events from the sensor hub.

Signed-off-by: srinivas pandruvada <srinivas.pandruvada@intel.com>
---
 drivers/staging/iio/gyro/Kconfig              |   10 +
 drivers/staging/iio/gyro/Makefile             |    3 +
 drivers/staging/iio/gyro/hid-sensor-gyro-3d.c |  451 +++++++++++++++++++++++++
 3 files changed, 464 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/gyro/hid-sensor-gyro-3d.c

diff --git a/drivers/staging/iio/gyro/Kconfig b/drivers/staging/iio/gyro/Kconfig
index ea295b2..a02e7dc 100644
--- a/drivers/staging/iio/gyro/Kconfig
+++ b/drivers/staging/iio/gyro/Kconfig
@@ -46,4 +46,14 @@ config ADXRS450
 	  This driver can also be built as a module.  If so, the module
 	  will be called adxrs450.
 
+config HID_SENSOR_GYRO_3D
+	depends on HID_SENSOR_HUB
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	select HID_SENSOR_IIO_COMMON
+	tristate "HID Gyroscope 3D"
+	help
+	  Say yes here to build support for the HID SENSOR
+	  Gyroscope 3G.
+
 endmenu
diff --git a/drivers/staging/iio/gyro/Makefile b/drivers/staging/iio/gyro/Makefile
index 9ba5ec1..9d30039 100644
--- a/drivers/staging/iio/gyro/Makefile
+++ b/drivers/staging/iio/gyro/Makefile
@@ -20,3 +20,6 @@ obj-$(CONFIG_ADIS16251) += adis16251.o
 
 adxrs450-y             := adxrs450_core.o
 obj-$(CONFIG_ADXRS450) += adxrs450.o
+
+hid-sensor-gyro-3d-drv-y := hid-sensor-gyro-3d.o
+obj-$(CONFIG_HID_SENSOR_GYRO_3D) += hid-sensor-gyro-3d-drv.o
diff --git a/drivers/staging/iio/gyro/hid-sensor-gyro-3d.c b/drivers/staging/iio/gyro/hid-sensor-gyro-3d.c
new file mode 100644
index 0000000..c5bd126
--- /dev/null
+++ b/drivers/staging/iio/gyro/hid-sensor-gyro-3d.c
@@ -0,0 +1,451 @@
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
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/sysfs.h>
+#include "../common/hid-sensors/hid-sensor-attributes.h"
+#include "../common/hid-sensors/hid-sensor-trigger.h"
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
+	struct hid_sensor_hub_attribute_info gyro_x;
+	struct hid_sensor_hub_attribute_info gyro_y;
+	struct hid_sensor_hub_attribute_info gyro_z;
+	struct gyro_3d_sample gyro_sample_data;
+};
+
+/* Channel definitions */
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
+/* Adjust channel real bits based on report descriptor */
+static void gyro_3d_adjust_channel_bit_mask(int channel, int size)
+{
+	gyro_3d_channels[channel].scan_type.sign = 's';
+	gyro_3d_channels[channel].scan_type.realbits = size * 8;
+	gyro_3d_channels[channel].scan_type.storagebits = sizeof(u32) * 8;
+}
+
+/* Channel read_raw handler */
+static int gyro_3d_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val, int *val2,
+			      long mask)
+{
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct gyro_3d_state *gyro_state =
+			(struct gyro_3d_state *)st->private;
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
+				st->hsdev,
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
+
+
+static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
+			hid_sensor_read_samp_freq,
+			hid_sensor_write_samp_freq);
+
+static IIO_DEV_ATTR_HYSTERESIS(S_IWUSR | S_IRUSR,
+			hid_sensor_read_hyst_raw,
+			hid_sensor_write_hyst_raw);
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
+};
+
+/* Function to push data to buffer */
+void hid_sensor_push_data(struct iio_dev *indio_dev, u8 *data, int len)
+{
+	struct iio_buffer *buffer = indio_dev->buffer;
+	s64 timestamp = iio_get_time_ns();
+	int datum_sz;
+
+	dev_dbg(&indio_dev->dev, "hid_sensor_push_data\n");
+	if (!buffer) {
+		dev_err(&indio_dev->dev, "Buffer == NULL\n");
+		return;
+	}
+	datum_sz = buffer->access->get_bytes_per_datum(buffer);
+	if (len > datum_sz) {
+		dev_err(&indio_dev->dev, "Datum size mismatch %d:%d\n", len,
+				datum_sz);
+		return;
+	}
+	buffer->access->store_to(buffer, (u8 *)data, timestamp);
+}
+
+/* Callback handler to send event after all samples are received and captured */
+int gyro_3d_proc_event(struct hid_sensor_hub_device *hsdev, unsigned usage_id,
+			void *priv)
+{
+	struct iio_dev *indio_dev =
+				(struct iio_dev *)platform_get_drvdata(priv);
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct gyro_3d_state *gyro_state =
+			(struct gyro_3d_state *)st->private;
+
+	dev_dbg(&indio_dev->dev, "gyro_3d_proc_event [%d]\n", st->data_ready);
+	if (st->data_ready)
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
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct gyro_3d_state *gyro_state =
+			(struct gyro_3d_state *)st->private;
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
+static int gyro_3d_parse_report(struct platform_device *pdev,
+				struct hid_sensor_hub_device *hsdev,
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
+	dev_dbg(&pdev->dev, "gyro_3d %x:%x, %x:%x, %x:%x\n",
+			st->gyro_x.index,
+			st->gyro_x.report_id,
+			st->gyro_y.index, st->gyro_y.report_id,
+			st->gyro_z.index, st->gyro_z.report_id);
+
+	return 0;
+}
+
+/* Function to initialize the processing for usage id */
+static int gyro_3d_init(struct platform_device *pdev,
+			struct hid_sensor_hub_device *hsdev,
+			unsigned usage_id)
+{
+	int ret = 0;
+	static char *name = "gyro_3d";
+	struct iio_dev *indio_dev;
+	struct gyro_3d_state *gyro_state;
+	struct hid_sensor_attributes *st;
+
+	gyro_state = kzalloc(sizeof(struct gyro_3d_state), GFP_KERNEL);
+	if (gyro_state == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+
+	indio_dev = iio_device_alloc(sizeof(struct hid_sensor_attributes));
+	if (indio_dev == NULL) {
+		ret = -ENOMEM;
+		goto error_free_state;
+	}
+	platform_set_drvdata(pdev, indio_dev);
+	st = iio_priv(indio_dev);
+	st->hsdev = hsdev;
+	st->pdev = pdev;
+	st->private = (void *)gyro_state;
+
+	ret = hid_sensor_parse_common_attributes(hsdev, usage_id, st);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to setup common attributes\n");
+		goto error_free_dev;
+	}
+
+	ret = gyro_3d_parse_report(pdev, hsdev, usage_id, gyro_state);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to setup attributes\n");
+		goto error_free_dev;
+	}
+
+	indio_dev->channels = kmemdup(gyro_3d_channels,
+					sizeof(gyro_3d_channels),
+					GFP_KERNEL);
+	if (!indio_dev->channels) {
+		dev_err(&pdev->dev, "failed to duplicate channels\n");
+		goto error_free_dev;
+	}
+
+	indio_dev->num_channels =
+				ARRAY_SIZE(gyro_3d_channels);
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->info = &gyro_3d_info;
+	indio_dev->name = name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
+		NULL, NULL);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to initialize trigger buffer\n");
+		goto error_free_dev_mem;
+	}
+	iio_scan_mask_set(indio_dev, indio_dev->buffer,
+			   CHANNEL_SCAN_INDEX_X);
+	iio_scan_mask_set(indio_dev, indio_dev->buffer,
+			   CHANNEL_SCAN_INDEX_Y);
+	iio_scan_mask_set(indio_dev, indio_dev->buffer,
+			   CHANNEL_SCAN_INDEX_Z);
+	st->data_ready = false;
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
+error_free_dev_mem:
+	kfree(indio_dev->channels);
+error_free_dev:
+	iio_device_free(indio_dev);
+error_free_state:
+	kfree(gyro_state);
+error_ret:
+	return ret;
+}
+
+/* Function to deinitialize the processing for usage id */
+static int gyro_3d_exit(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct gyro_3d_state *gyro_state =
+			(struct gyro_3d_state *)st->private;
+
+	iio_device_unregister(indio_dev);
+	hid_sensor_remove_trigger(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
+	kfree(indio_dev->channels);
+	iio_device_free(indio_dev);
+	kfree(gyro_state);
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
+MODULE_DESCRIPTION("HID Sensor Gyro 3D");
+MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@intel.com>");
+MODULE_LICENSE("GPL");
-- 
1.7.7.6

