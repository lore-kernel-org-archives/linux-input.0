From: srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 7/8] HID-Sensors: Added Compass/Magnetometer 3D
Date: Wed,  4 Jul 2012 12:52:11 -0700
Message-ID: <1341431532-15060-8-git-send-email-srinivas.pandruvada@intel.com>
References: <1341431532-15060-1-git-send-email-srinivas.pandruvada@intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1341431532-15060-1-git-send-email-srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Added usage id processing for Compass 3D. This uses IIO
interfaces for triggerred buffer to present data to user
mode.This uses HID sensor framework for registering callback
events from the sensor hub.

Signed-off-by: srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/staging/iio/magnetometer/Kconfig           |   10 +
 drivers/staging/iio/magnetometer/Makefile          |    3 +
 .../staging/iio/magnetometer/hid-sensor-magn-3d.c  |  451 ++++++++++++++++++++
 3 files changed, 464 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/magnetometer/hid-sensor-magn-3d.c

diff --git a/drivers/staging/iio/magnetometer/Kconfig b/drivers/staging/iio/magnetometer/Kconfig
index df5e0d4..ad6edd5 100644
--- a/drivers/staging/iio/magnetometer/Kconfig
+++ b/drivers/staging/iio/magnetometer/Kconfig
@@ -24,4 +24,14 @@ config SENSORS_HMC5843
 	  To compile this driver as a module, choose M here: the module
 	  will be called hmc5843.
 
+config HID_SENSOR_MAGNETOMETER_3D
+	depends on HID_SENSOR_HUB
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	select HID_SENSOR_IIO_COMMON
+	tristate "HID Magenetometer 3D"
+	help
+	  Say yes here to build support for the HID SENSOR
+	  Magnetometer 3G.
+
 endmenu
diff --git a/drivers/staging/iio/magnetometer/Makefile b/drivers/staging/iio/magnetometer/Makefile
index f2a753f..d14f05e 100644
--- a/drivers/staging/iio/magnetometer/Makefile
+++ b/drivers/staging/iio/magnetometer/Makefile
@@ -4,3 +4,6 @@
 
 obj-$(CONFIG_SENSORS_AK8975)	+= ak8975.o
 obj-$(CONFIG_SENSORS_HMC5843)	+= hmc5843.o
+
+hid-sensor-magn-3d-drv-y := hid-sensor-magn-3d.o
+obj-$(CONFIG_HID_SENSOR_MAGNETOMETER_3D) += hid-sensor-magn-3d-drv.o
diff --git a/drivers/staging/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/staging/iio/magnetometer/hid-sensor-magn-3d.c
new file mode 100644
index 0000000..333a2c5
--- /dev/null
+++ b/drivers/staging/iio/magnetometer/hid-sensor-magn-3d.c
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
+#define DRIVER_NAME "HID-SENSOR-200083"
+
+#define CHANNEL_SCAN_INDEX_X 0
+#define CHANNEL_SCAN_INDEX_Y 1
+#define CHANNEL_SCAN_INDEX_Z 2
+
+struct magn_3d_sample {
+	u32 magn_x;
+	u32 magn_y;
+	u32 magn_z;
+} __packed;
+
+struct magn_3d_state {
+	struct hid_sensor_hub_attribute_info magn_x;
+	struct hid_sensor_hub_attribute_info magn_y;
+	struct hid_sensor_hub_attribute_info magn_z;
+	struct magn_3d_sample magn_sample_data;
+};
+
+/* Channel definitions */
+static struct iio_chan_spec magn_3d_channels[] = {
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
+/* Adjust channel real bits based on report descriptor */
+static void magn_3d_adjust_channel_bit_mask(int channel, int size)
+{
+	magn_3d_channels[channel].scan_type.sign = 's';
+	magn_3d_channels[channel].scan_type.realbits = size * 8;
+	magn_3d_channels[channel].scan_type.storagebits = sizeof(u32) * 8;
+}
+
+/* Channel read_raw handler */
+static int magn_3d_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val, int *val2,
+			      long mask)
+{
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct magn_3d_state *magn_state =
+			(struct magn_3d_state *)st->private;
+	int report_id = -1;
+	u32 address;
+
+	*val = 0;
+	*val2 = 0;
+	switch (mask) {
+	case 0:
+		switch (chan->scan_index) {
+		case  CHANNEL_SCAN_INDEX_X:
+			report_id = magn_state->magn_x.report_id;
+			address =
+			HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_X_AXIS;
+			break;
+		case  CHANNEL_SCAN_INDEX_Y:
+			report_id = magn_state->magn_y.report_id;
+			address =
+			HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_Y_AXIS;
+			break;
+		case  CHANNEL_SCAN_INDEX_Z:
+			report_id = magn_state->magn_z.report_id;
+			address =
+			HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_Z_AXIS;
+			break;
+		default:
+			report_id = -1;
+			break;
+		}
+		if (report_id >= 0)
+			*val = sensor_hub_input_attr_get_raw_value(
+				st->hsdev,
+				HID_USAGE_SENSOR_COMPASS_3D, address,
+				report_id);
+		else
+			*val = 0;
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		*val = magn_state->magn_x.units;
+		break;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = magn_state->magn_x.unit_expo;
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
+static struct attribute *magn_3d_attributes[] = {
+	/* common attributes */
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	&iio_dev_attr_hyst_raw.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group magn_3d_attribute_group = {
+	.attrs = magn_3d_attributes,
+};
+
+static const struct iio_info magn_3d_info = {
+	.attrs = &magn_3d_attribute_group,
+	.driver_module = THIS_MODULE,
+	.read_raw = &magn_3d_read_raw,
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
+int magn_3d_proc_event(struct hid_sensor_hub_device *hsdev, unsigned usage_id,
+			void *priv)
+{
+	struct iio_dev *indio_dev =
+				(struct iio_dev *)platform_get_drvdata(priv);
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct magn_3d_state *magn_state =
+			(struct magn_3d_state *)st->private;
+
+	dev_dbg(&indio_dev->dev, "magn_3d_proc_event [%d]\n", st->data_ready);
+	if (st->data_ready)
+		hid_sensor_push_data(indio_dev,
+				(u8 *)&magn_state->magn_sample_data,
+				sizeof(struct magn_3d_sample));
+	return 0;
+}
+
+/* Capture samples in local storage */
+int magn_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
+				unsigned usage_id,
+				size_t raw_len, char *raw_data,
+				void *priv)
+{
+	struct iio_dev *indio_dev =
+			(struct iio_dev *)platform_get_drvdata(priv);
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct magn_3d_state *magn_state =
+			(struct magn_3d_state *)st->private;
+
+	switch (usage_id) {
+	case HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_X_AXIS:
+		magn_state->magn_sample_data.magn_x =
+		*(u32 *)raw_data;
+		break;
+	case HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_Y_AXIS:
+		magn_state->magn_sample_data.magn_y =
+		*(u32 *)raw_data;
+		break;
+	case HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_Z_AXIS:
+		magn_state->magn_sample_data.magn_z =
+		*(u32 *)raw_data;
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+/* Parse report which is specific to an usage id*/
+static int magn_3d_parse_report(struct platform_device *pdev,
+				struct hid_sensor_hub_device *hsdev,
+				unsigned usage_id,
+				struct magn_3d_state *st)
+{
+	int ret;
+
+	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT,
+			usage_id,
+			HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_X_AXIS,
+			&st->magn_x);
+	magn_3d_adjust_channel_bit_mask(CHANNEL_SCAN_INDEX_X,
+					st->magn_x.size);
+
+	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT,
+			usage_id,
+			HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_Y_AXIS,
+			&st->magn_y);
+	magn_3d_adjust_channel_bit_mask(CHANNEL_SCAN_INDEX_Y,
+					st->magn_y.size);
+
+	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT,
+			usage_id,
+			HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_Z_AXIS,
+			&st->magn_z);
+	magn_3d_adjust_channel_bit_mask(CHANNEL_SCAN_INDEX_Z,
+					st->magn_z.size);
+
+	dev_dbg(&pdev->dev, "magn_3d %x:%x, %x:%x, %x:%x\n",
+			st->magn_x.index,
+			st->magn_x.report_id,
+			st->magn_y.index, st->magn_y.report_id,
+			st->magn_z.index, st->magn_z.report_id);
+
+	return 0;
+}
+
+/* Function to initialize the processing for usage id */
+static int magn_3d_init(struct platform_device *pdev,
+			struct hid_sensor_hub_device *hsdev,
+			unsigned usage_id)
+{
+	int ret = 0;
+	static char *name = "compass_3d";
+	struct iio_dev *indio_dev;
+	struct magn_3d_state *magn_state;
+	struct hid_sensor_attributes *st;
+
+	magn_state = kzalloc(sizeof(struct magn_3d_state), GFP_KERNEL);
+	if (magn_state == NULL) {
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
+	st->private = (void *)magn_state;
+
+	ret = hid_sensor_parse_common_attributes(hsdev, usage_id, st);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to setup common attributes\n");
+		goto error_free_dev;
+	}
+
+	ret = magn_3d_parse_report(pdev, hsdev, usage_id, magn_state);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to setup attributes\n");
+		goto error_free_dev;
+	}
+
+	indio_dev->channels = kmemdup(magn_3d_channels,
+					sizeof(magn_3d_channels),
+					GFP_KERNEL);
+	if (!indio_dev->channels) {
+		dev_err(&pdev->dev, "failed to duplicate channels\n");
+		goto error_free_dev;
+	}
+
+	indio_dev->num_channels =
+				ARRAY_SIZE(magn_3d_channels);
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->info = &magn_3d_info;
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
+	kfree(magn_state);
+error_ret:
+	return ret;
+}
+
+/* Function to deinitialize the processing for usage id */
+static int magn_3d_exit(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct magn_3d_state *magn_state =
+			(struct magn_3d_state *)st->private;
+
+	iio_device_unregister(indio_dev);
+	hid_sensor_remove_trigger(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
+	kfree(indio_dev->channels);
+	iio_device_free(indio_dev);
+	kfree(magn_state);
+	return ret;
+}
+
+static struct hid_sensor_hub_callbacks magn_3d_callbacks = {
+	.send_event = magn_3d_proc_event,
+	.capture_sample = magn_3d_capture_sample,
+};
+
+static int __devinit hid_magn_3d_probe(struct platform_device *pdev)
+{
+	int ret;
+	u32 *pdata = (u32 *)pdev->dev.platform_data;
+	struct hid_sensor_hub_device *hsdev;
+
+	hsdev = (struct hid_sensor_hub_device *)*pdata;
+	ret = magn_3d_init(pdev, hsdev, HID_USAGE_SENSOR_COMPASS_3D);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "magn_3d_init failed\n");
+		return ret;
+	}
+	magn_3d_callbacks.pdev = pdev;
+	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D,
+					&magn_3d_callbacks);
+	return 0;
+}
+
+static int __devinit hid_magn_3d_remove(struct platform_device *pdev)
+{
+	u32 *pdata = (u32 *)pdev->dev.platform_data;
+	struct hid_sensor_hub_device *hsdev;
+
+	hsdev = (struct hid_sensor_hub_device *)*pdata;
+	magn_3d_exit(pdev);
+	return sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D);
+}
+
+static struct platform_driver hid_magn_3d_platform_driver = {
+	.driver = {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= hid_magn_3d_probe,
+	.remove		= hid_magn_3d_remove,
+};
+
+/*--------------------------------------------------------------------------*/
+
+static int __init hid_magn_3d_init(void)
+{
+	return platform_driver_register(&hid_magn_3d_platform_driver);
+}
+
+static void __exit hid_magn_3d_exit(void)
+{
+	platform_driver_unregister(&hid_magn_3d_platform_driver);
+}
+
+module_init(hid_magn_3d_init);
+module_exit(hid_magn_3d_exit);
+
+MODULE_DESCRIPTION("HID Sensor Magnetometer 3D");
+MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>");
+MODULE_LICENSE("GPL");
-- 
1.7.7.6
