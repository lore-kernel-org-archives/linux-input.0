From: Song Hongyan <hongyan.song@intel.com>
Subject: [PATCH v3] iio: hid: Add temperature sensor support
Date: Mon, 13 Feb 2017 17:49:35 +0800
Message-ID: <1486979375-44684-1-git-send-email-hongyan.song@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:33703 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751193AbdBMB06 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 12 Feb 2017 20:26:58 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@intel.com, Song Hongyan <hongyan.song@intel.com>

Environmental temperature sensor is a hid defined sensor,
it measures temperature.

More information can be found in:
http://www.usb.org/developers/hidpage/HUTRR39b.pdf

According to IIO ABI definition, IIO_TEMP data output unit is
milli degrees Celsius. Add the unit convert from degree to milli degree.

Signed-off-by: Song Hongyan <hongyan.song@intel.com>
---
 .../iio/common/hid-sensors/hid-sensor-attributes.c |   3 +
 drivers/iio/temperature/Kconfig                    |  14 +
 drivers/iio/temperature/Makefile                   |   1 +
 drivers/iio/temperature/hid-sensor-temperature.c   | 326 +++++++++++++++++++++
 include/linux/hid-sensor-ids.h                     |   4 +
 5 files changed, 348 insertions(+)
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
index 78c3de0..e157eda 100644
--- a/drivers/iio/temperature/Makefile
+++ b/drivers/iio/temperature/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_MLX90614) += mlx90614.o
 obj-$(CONFIG_TMP006) += tmp006.o
 obj-$(CONFIG_TSYS01) += tsys01.o
 obj-$(CONFIG_TSYS02D) += tsys02d.o
+obj-$(CONFIG_HID_SENSOR_TEMP)   += hid-sensor-temperature.o
diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
new file mode 100644
index 0000000..84abd2d
--- /dev/null
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -0,0 +1,326 @@
+/* HID Sensors Driver
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
+ *
+ */
+#include <linux/device.h>
+#include <linux/hid-sensor-hub.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
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
+		.scan_index = 0,
+	}
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
+/* Channel read_raw handler */
+static int temperature_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2, long mask)
+{
+	struct temperature_state *temperature_state = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (chan->type == IIO_TEMP) {
+			hid_sensor_power_state(
+				&temperature_state->common_attributes, true);
+			*val = sensor_hub_input_attr_get_raw_value(
+				temperature_state->common_attributes.hsdev,
+				HID_USAGE_SENSOR_TEMPERATURE,
+				HID_USAGE_SENSOR_DATA_ENVIRONMENTAL_TEMPERATURE,
+				temperature_state->temperature_attr.report_id,
+				SENSOR_HUB_SYNC);
+			hid_sensor_power_state(
+					&temperature_state->common_attributes,
+					false);
+		}
+		ret = IIO_VAL_INT;
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		*val = temperature_state->scale_pre_decml;
+		*val2 = temperature_state->scale_post_decml;
+		ret = temperature_state->scale_precision;
+		break;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = temperature_state->value_offset;
+		ret = IIO_VAL_INT;
+		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = hid_sensor_read_samp_freq_value(
+				&temperature_state->common_attributes,
+				val, val2);
+		break;
+	case IIO_CHAN_INFO_HYSTERESIS:
+		ret = hid_sensor_read_raw_hyst_value(
+				&temperature_state->common_attributes,
+				val, val2);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+/* Channel write_raw handler */
+static int temperature_write_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int val, int val2, long mask)
+{
+	struct temperature_state *temperature_state = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = hid_sensor_write_samp_freq_value(
+				&temperature_state->common_attributes, val,
+				val2);
+		break;
+	case IIO_CHAN_INFO_HYSTERESIS:
+		ret = hid_sensor_write_raw_hyst_value(
+				&temperature_state->common_attributes, val,
+				val2);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
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
+	struct temperature_state *temperature_state = iio_priv(indio_dev);
+
+	if (atomic_read(&temperature_state->common_attributes.data_ready))
+		iio_push_to_buffers(indio_dev,
+					&temperature_state->temperature_data);
+	return 0;
+}
+
+/* Capture samples in local storage */
+static int temperature_capture_sample(struct hid_sensor_hub_device *hsdev,
+				unsigned int usage_id, size_t raw_len,
+				char *raw_data, void *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct temperature_state *temperature_state = iio_priv(indio_dev);
+
+	switch (usage_id) {
+	case HID_USAGE_SENSOR_DATA_ENVIRONMENTAL_TEMPERATURE:
+		temperature_state->temperature_data = *(s32 *)raw_data;
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
+	struct temperature_state *temperature_state;
+	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev,
+				sizeof(struct temperature_state));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	temperature_state = iio_priv(indio_dev);
+	temperature_state->common_attributes.hsdev = hsdev;
+	temperature_state->common_attributes.pdev = pdev;
+
+	ret = hid_sensor_parse_common_attributes(hsdev,
+					HID_USAGE_SENSOR_TEMPERATURE,
+					&temperature_state->common_attributes);
+	if (ret)
+		return ret;
+
+	indio_dev->channels = devm_kmemdup(&indio_dev->dev,
+					temperature_channels,
+					sizeof(temperature_channels),
+					GFP_KERNEL);
+	if (!indio_dev->channels)
+		return -ENOMEM;
+
+	ret = temperature_parse_report(pdev, hsdev,
+				(struct iio_chan_spec *)indio_dev->channels,
+				HID_USAGE_SENSOR_TEMPERATURE,
+				temperature_state);
+	if (ret)
+		return ret;
+
+	indio_dev->num_channels = ARRAY_SIZE(temperature_channels);
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->info = &temperature_info;
+	indio_dev->name = name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = devm_iio_triggered_buffer_setup(&pdev->dev, indio_dev,
+					&iio_pollfunc_store_time,
+					NULL, NULL);
+	if (ret)
+		return ret;
+
+	atomic_set(&temperature_state->common_attributes.data_ready, 0);
+	ret = hid_sensor_setup_trigger(indio_dev, name,
+				&temperature_state->common_attributes);
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
+	hid_sensor_remove_trigger(&temperature_state->common_attributes);
+	return ret;
+}
+
+/* Function to deinitialize the processing for usage id */
+static int hid_temperature_remove(struct platform_device *pdev)
+{
+	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct temperature_state *temperature_state = iio_priv(indio_dev);
+
+	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_TEMPERATURE);
+	hid_sensor_remove_trigger(&temperature_state->common_attributes);
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
+		.name	= KBUILD_MODNAME,
+		.pm	= &hid_sensor_pm_ops,
+	},
+	.probe		= hid_temperature_probe,
+	.remove		= hid_temperature_remove,
+};
+module_platform_driver(hid_temperature_platform_driver);
+
+MODULE_DESCRIPTION("HID Environmental temperature sensor");
+MODULE_AUTHOR("Song Hongyan <hongyan.song@intel.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index bab8375..ecec978 100644
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

