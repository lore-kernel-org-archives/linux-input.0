From: Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4] iio: hid: Add temperature sensor support
Date: Fri,  3 Mar 2017 21:44:32 +0800
Message-ID: <1488548672-16436-1-git-send-email-hongyan.song@intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Environmental temperature sensor is a hid defined sensor,
it measures temperature.

More information can be found in:
http://www.usb.org/developers/hidpage/HUTRR39b.pdf

According to IIO ABI definition, IIO_TEMP data output unit is
milli degrees Celsius. Add the unit convert from degree to milli degree.

Signed-off-by: Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 .../iio/common/hid-sensors/hid-sensor-attributes.c |   3 +
 drivers/iio/temperature/Kconfig                    |  14 +
 drivers/iio/temperature/Makefile                   |   1 +
 drivers/iio/temperature/hid-sensor-temperature.c   | 311 +++++++++++++++++++++
 include/linux/hid-sensor-ids.h                     |   4 +
 5 files changed, 333 insertions(+)
 create mode 100644 drivers/iio/temperature/hid-sensor-temperature.c

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index 7ef94a9..68c2bb0 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -58,6 +58,9 @@
 
 	{HID_USAGE_SENSOR_PRESSURE, 0, 100, 0},
 	{HID_USAGE_SENSOR_PRESSURE, HID_USAGE_SENSOR_UNITS_PASCAL, 0, 1000000},
+
+	{HID_USAGE_SENSOR_TEMPERATURE, 0, 1000, 0},
+	{HID_USAGE_SENSOR_TEMPERATURE, HID_USAGE_SENSOR_UNITS_DEGREES, 1000, 0},
 };
 
 static int pow_10(unsigned power)
diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
index 5ea77a7..5f7b9f7 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -19,6 +19,20 @@ config MAXIM_THERMOCOUPLE
 	  This driver can also be built as a module. If so, the module will
 	  be called maxim_thermocouple.
 
+config HID_SENSOR_TEMP
+	tristate "HID Environmental temperature sensor"
+	depends on HID_SENSOR_HUB
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	select HID_SENSOR_IIO_COMMON
+	select HID_SENSOR_IIO_TRIGGER
+	help
+	  Say yes here to build support for the HID SENSOR
+	  temperature driver
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called hid-sensor-temperature.
+
 config MLX90614
 	tristate "MLX90614 contact-less infrared sensor"
 	depends on I2C
diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
index 78c3de0..8233466 100644
--- a/drivers/iio/temperature/Makefile
+++ b/drivers/iio/temperature/Makefile
@@ -2,6 +2,7 @@
 # Makefile for industrial I/O temperature drivers
 #
 
+obj-$(CONFIG_HID_SENSOR_TEMP) += hid-sensor-temperature.o
 obj-$(CONFIG_MAXIM_THERMOCOUPLE) += maxim_thermocouple.o
 obj-$(CONFIG_MLX90614) += mlx90614.o
 obj-$(CONFIG_TMP006) += tmp006.o
diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
new file mode 100644
index 0000000..c01efec
--- /dev/null
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -0,0 +1,311 @@
+/*
+ * HID Sensors Driver
+ * Copyright (c) 2017, Intel Corporation.
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
+ * this program.
+ */
+#include <linux/device.h>
+#include <linux/hid-sensor-hub.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include "../common/hid-sensors/hid-sensor-trigger.h"
+
+struct temperature_state {
+	struct hid_sensor_common common_attributes;
+	struct hid_sensor_hub_attribute_info temperature_attr;
+	s32 temperature_data;
+	int scale_pre_decml;
+	int scale_post_decml;
+	int scale_precision;
+	int value_offset;
+};
+
+/* Channel definitions */
+static const struct iio_chan_spec temperature_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
+			BIT(IIO_CHAN_INFO_SCALE) |
+			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+			BIT(IIO_CHAN_INFO_HYSTERESIS),
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
+/* Adjust channel real bits based on report descriptor */
+static void temperature_adjust_channel_bit_mask(struct iio_chan_spec *channels,
+					int channel, int size)
+{
+	channels[channel].scan_type.sign = 's';
+	/* Real storage bits will change based on the report desc. */
+	channels[channel].scan_type.realbits = size * 8;
+	/* Maximum size of a sample to capture is s32 */
+	channels[channel].scan_type.storagebits = sizeof(s32) * 8;
+}
+
+static int temperature_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2, long mask)
+{
+	struct temperature_state *temp_st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (chan->type != IIO_TEMP)
+			return -EINVAL;
+		hid_sensor_power_state(
+			&temp_st->common_attributes, true);
+		*val = sensor_hub_input_attr_get_raw_value(
+			temp_st->common_attributes.hsdev,
+			HID_USAGE_SENSOR_TEMPERATURE,
+			HID_USAGE_SENSOR_DATA_ENVIRONMENTAL_TEMPERATURE,
+			temp_st->temperature_attr.report_id,
+			SENSOR_HUB_SYNC);
+		hid_sensor_power_state(
+				&temp_st->common_attributes,
+				false);
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = temp_st->scale_pre_decml;
+		*val2 = temp_st->scale_post_decml;
+		return temp_st->scale_precision;
+
+	case IIO_CHAN_INFO_OFFSET:
+		*val = temp_st->value_offset;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return hid_sensor_read_samp_freq_value(
+				&temp_st->common_attributes, val, val2);
+
+	case IIO_CHAN_INFO_HYSTERESIS:
+		return hid_sensor_read_raw_hyst_value(
+				&temp_st->common_attributes, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int temperature_write_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int val, int val2, long mask)
+{
+	struct temperature_state *temp_st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return hid_sensor_write_samp_freq_value(
+				&temp_st->common_attributes, val, val2);
+	case IIO_CHAN_INFO_HYSTERESIS:
+		return hid_sensor_write_raw_hyst_value(
+				&temp_st->common_attributes, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info temperature_info = {
+	.driver_module = THIS_MODULE,
+	.read_raw = &temperature_read_raw,
+	.write_raw = &temperature_write_raw,
+};
+
+/* Callback handler to send event after all samples are received and captured */
+static int temperature_proc_event(struct hid_sensor_hub_device *hsdev,
+				unsigned int usage_id, void *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct temperature_state *temp_st = iio_priv(indio_dev);
+
+	if (atomic_read(&temp_st->common_attributes.data_ready))
+		iio_push_to_buffers_with_timestamp(indio_dev,
+				&temp_st->temperature_data,
+				iio_get_time_ns(indio_dev));
+
+	return 0;
+}
+
+/* Capture samples in local storage */
+static int temperature_capture_sample(struct hid_sensor_hub_device *hsdev,
+				unsigned int usage_id, size_t raw_len,
+				char *raw_data, void *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct temperature_state *temp_st = iio_priv(indio_dev);
+
+	switch (usage_id) {
+	case HID_USAGE_SENSOR_DATA_ENVIRONMENTAL_TEMPERATURE:
+		temp_st->temperature_data = *(s32 *)raw_data;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+/* Parse report which is specific to an usage id*/
+static int temperature_parse_report(struct platform_device *pdev,
+				struct hid_sensor_hub_device *hsdev,
+				struct iio_chan_spec *channels,
+				unsigned int usage_id,
+				struct temperature_state *st)
+{
+	int ret;
+
+	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT,
+			usage_id,
+			HID_USAGE_SENSOR_DATA_ENVIRONMENTAL_TEMPERATURE,
+			&st->temperature_attr);
+	if (ret < 0)
+		return ret;
+
+	temperature_adjust_channel_bit_mask(channels, 0,
+					st->temperature_attr.size);
+
+	st->scale_precision = hid_sensor_format_scale(
+				HID_USAGE_SENSOR_TEMPERATURE,
+				&st->temperature_attr,
+				&st->scale_pre_decml, &st->scale_post_decml);
+
+	/* Set Sensitivity field ids, when there is no individual modifier */
+	if (st->common_attributes.sensitivity.index < 0)
+		sensor_hub_input_get_attribute_info(hsdev,
+			HID_FEATURE_REPORT, usage_id,
+			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
+			HID_USAGE_SENSOR_DATA_ENVIRONMENTAL_TEMPERATURE,
+			&st->common_attributes.sensitivity);
+
+	return ret;
+}
+
+static struct hid_sensor_hub_callbacks temperature_callbacks = {
+	.send_event = &temperature_proc_event,
+	.capture_sample = &temperature_capture_sample,
+};
+
+/* Function to initialize the processing for usage id */
+static int hid_temperature_probe(struct platform_device *pdev)
+{
+	static const char *name = "temperature";
+	struct iio_dev *indio_dev;
+	struct temperature_state *temp_st;
+	struct iio_chan_spec *temp_chans;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*temp_st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	temp_st = iio_priv(indio_dev);
+	temp_st->common_attributes.hsdev = hsdev;
+	temp_st->common_attributes.pdev = pdev;
+
+	ret = hid_sensor_parse_common_attributes(hsdev,
+					HID_USAGE_SENSOR_TEMPERATURE,
+					&temp_st->common_attributes);
+	if (ret)
+		return ret;
+
+	temp_chans = devm_kmemdup(&indio_dev->dev, temperature_channels,
+				sizeof(temperature_channels), GFP_KERNEL);
+	if (!temp_chans)
+		return -ENOMEM;
+
+	ret = temperature_parse_report(pdev, hsdev, temp_chans,
+				HID_USAGE_SENSOR_TEMPERATURE, temp_st);
+	if (ret)
+		return ret;
+
+	indio_dev->channels = temp_chans;
+	indio_dev->num_channels = ARRAY_SIZE(temperature_channels);
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->info = &temperature_info;
+	indio_dev->name = name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = devm_iio_triggered_buffer_setup(&pdev->dev, indio_dev,
+					&iio_pollfunc_store_time, NULL, NULL);
+	if (ret)
+		return ret;
+
+	atomic_set(&temp_st->common_attributes.data_ready, 0);
+	ret = hid_sensor_setup_trigger(indio_dev, name,
+				&temp_st->common_attributes);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	temperature_callbacks.pdev = pdev;
+	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_TEMPERATURE,
+					&temperature_callbacks);
+	if (ret)
+		goto error_remove_trigger;
+
+	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
+	if (ret)
+		goto error_remove_callback;
+
+	return ret;
+
+error_remove_callback:
+	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_TEMPERATURE);
+error_remove_trigger:
+	hid_sensor_remove_trigger(&temp_st->common_attributes);
+	return ret;
+}
+
+/* Function to deinitialize the processing for usage id */
+static int hid_temperature_remove(struct platform_device *pdev)
+{
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct temperature_state *temp_st = iio_priv(indio_dev);
+
+	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_TEMPERATURE);
+	hid_sensor_remove_trigger(&temp_st->common_attributes);
+
+	return 0;
+}
+
+static const struct platform_device_id hid_temperature_ids[] = {
+	{
+		/* Format: HID-SENSOR-usage_id_in_hex_lowercase */
+		.name = "HID-SENSOR-200033",
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, hid_temperature_ids);
+
+static struct platform_driver hid_temperature_platform_driver = {
+	.id_table = hid_temperature_ids,
+	.driver = {
+		.name	= "temperature-sensor",
+		.pm	= &hid_sensor_pm_ops,
+	},
+	.probe		= hid_temperature_probe,
+	.remove		= hid_temperature_remove,
+};
+module_platform_driver(hid_temperature_platform_driver);
+
+MODULE_DESCRIPTION("HID Environmental temperature sensor");
+MODULE_AUTHOR("Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index f2ee90a..364947f 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -45,6 +45,10 @@
 #define HID_USAGE_SENSOR_DATA_ATMOSPHERIC_PRESSURE              0x200430
 #define HID_USAGE_SENSOR_ATMOSPHERIC_PRESSURE                   0x200431
 
+/* Tempreture (200033) */
+#define	HID_USAGE_SENSOR_TEMPERATURE				0x200033
+#define	HID_USAGE_SENSOR_DATA_ENVIRONMENTAL_TEMPERATURE		0x200434
+
 /* Gyro 3D: (200076) */
 #define HID_USAGE_SENSOR_GYRO_3D				0x200076
 #define HID_USAGE_SENSOR_DATA_ANGL_VELOCITY			0x200456
-- 
1.9.1
