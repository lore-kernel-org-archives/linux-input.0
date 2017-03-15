From: Song Hongyan <hongyan.song@intel.com>
Subject: [PATCH] iio: hid: Add humidity sensor support
Date: Wed, 15 Mar 2017 19:15:15 +0800
Message-ID: <1489576515-33346-1-git-send-email-hongyan.song@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:56357 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750848AbdCOCwe (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Mar 2017 22:52:34 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@intel.com, Song Hongyan <hongyan.song@intel.com>

Environmental humidity sensor is a hid defined sensor,
it shows raw humidity measurement of air.

More information can be found in:
http://www.usb.org/developers/hidpage/HUTRR39b.pdf

According to IIO ABI definition, humidityrelative data output unit is
milli percent. Add the unit convert from percent to milli percent.

Signed-off-by: Song Hongyan <hongyan.song@intel.com>
---
 .../iio/common/hid-sensors/hid-sensor-attributes.c |   2 +
 drivers/iio/humidity/Kconfig                       |  14 +
 drivers/iio/humidity/Makefile                      |   3 +
 drivers/iio/humidity/hid-sensor-humidity.c         | 314 +++++++++++++++++++++
 include/linux/hid-sensor-ids.h                     |   4 +
 5 files changed, 337 insertions(+)
 create mode 100644 drivers/iio/humidity/hid-sensor-humidity.c

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index 7afdac42..4f280ae 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -62,6 +62,8 @@
 	{HID_USAGE_SENSOR_TIME_TIMESTAMP, 0, 1000000000, 0},
 	{HID_USAGE_SENSOR_TIME_TIMESTAMP, HID_USAGE_SENSOR_UNITS_MILLISECOND,
 		1000000, 0},
+
+	{HID_USAGE_SENSOR_HUMIDITY, 0, 1000, 0},
 };
 
 static int pow_10(unsigned power)
diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
index 912477d..14b9ce4 100644
--- a/drivers/iio/humidity/Kconfig
+++ b/drivers/iio/humidity/Kconfig
@@ -36,6 +36,20 @@ config HDC100X
 	  To compile this driver as a module, choose M here: the module
 	  will be called hdc100x.
 
+config HID_SENSOR_HUMIDITY
+	tristate "HID Environmental humidity sensor"
+	depends on HID_SENSOR_HUB
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	select HID_SENSOR_IIO_COMMON
+	select HID_SENSOR_IIO_TRIGGER
+	help
+	  Say yes here to build support for the HID SENSOR
+	  humidity driver
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called hid-sensor-humidity.
+
 config HTS221
 	tristate "STMicroelectronics HTS221 sensor Driver"
 	depends on (I2C || SPI)
diff --git a/drivers/iio/humidity/Makefile b/drivers/iio/humidity/Makefile
index a6850e4..be0dede 100644
--- a/drivers/iio/humidity/Makefile
+++ b/drivers/iio/humidity/Makefile
@@ -5,6 +5,7 @@
 obj-$(CONFIG_AM2315) += am2315.o
 obj-$(CONFIG_DHT11) += dht11.o
 obj-$(CONFIG_HDC100X) += hdc100x.o
+obj-$(CONFIG_HID_SENSOR_HUMIDITY) += hid-sensor-humidity.o
 
 hts221-y := hts221_core.o \
 	    hts221_buffer.o
@@ -15,3 +16,5 @@ obj-$(CONFIG_HTS221_SPI) += hts221_spi.o
 obj-$(CONFIG_HTU21) += htu21.o
 obj-$(CONFIG_SI7005) += si7005.o
 obj-$(CONFIG_SI7020) += si7020.o
+
+ccflags-y += -I$(srctree)/drivers/iio/common/hid-sensors
diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
new file mode 100644
index 0000000..bff4ceb
--- /dev/null
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -0,0 +1,314 @@
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
+#include "hid-sensor-trigger.h"
+
+struct humidity_state {
+	struct hid_sensor_common common_attributes;
+	struct hid_sensor_hub_attribute_info humidity_attr;
+	s32 humidity_data;
+	int scale_pre_decml;
+	int scale_post_decml;
+	int scale_precision;
+	int value_offset;
+};
+
+/* Channel definitions */
+static const struct iio_chan_spec humidity_channels[] = {
+	{
+		.type = IIO_HUMIDITYRELATIVE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
+			BIT(IIO_CHAN_INFO_SCALE) |
+			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+			BIT(IIO_CHAN_INFO_HYSTERESIS),
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(3)
+};
+
+/* Adjust channel real bits based on report descriptor */
+static void humidity_adjust_channel_bit_mask(struct iio_chan_spec *channels,
+					int channel, int size)
+{
+	channels[channel].scan_type.sign = 's';
+	/* Real storage bits will change based on the report desc. */
+	channels[channel].scan_type.realbits = size * 8;
+	/* Maximum size of a sample to capture is s32 */
+	channels[channel].scan_type.storagebits = sizeof(s32) * 8;
+}
+
+static int humidity_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2, long mask)
+{
+	struct humidity_state *humid_st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (chan->type != IIO_HUMIDITYRELATIVE)
+			return -EINVAL;
+		hid_sensor_power_state(&humid_st->common_attributes, true);
+		*val = sensor_hub_input_attr_get_raw_value(
+				humid_st->common_attributes.hsdev,
+				HID_USAGE_SENSOR_HUMIDITY,
+				HID_USAGE_SENSOR_ATMOSPHERIC_HUMIDITY,
+				humid_st->humidity_attr.report_id,
+				SENSOR_HUB_SYNC);
+		hid_sensor_power_state(&humid_st->common_attributes, false);
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = humid_st->scale_pre_decml;
+		*val2 = humid_st->scale_post_decml;
+
+		return humid_st->scale_precision;
+
+	case IIO_CHAN_INFO_OFFSET:
+		*val = humid_st->value_offset;
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return hid_sensor_read_samp_freq_value(
+				&humid_st->common_attributes, val, val2);
+
+	case IIO_CHAN_INFO_HYSTERESIS:
+		return hid_sensor_read_raw_hyst_value(
+				&humid_st->common_attributes, val, val2);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int humidity_write_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int val, int val2, long mask)
+{
+	struct humidity_state *humid_st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return hid_sensor_write_samp_freq_value(
+				&humid_st->common_attributes, val, val2);
+
+	case IIO_CHAN_INFO_HYSTERESIS:
+		return hid_sensor_write_raw_hyst_value(
+				&humid_st->common_attributes, val, val2);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info humidity_info = {
+	.driver_module = THIS_MODULE,
+	.read_raw = &humidity_read_raw,
+	.write_raw = &humidity_write_raw,
+};
+
+/* Callback handler to send event after all samples are received and captured */
+static int humidity_proc_event(struct hid_sensor_hub_device *hsdev,
+				unsigned int usage_id, void *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct humidity_state *humid_st = iio_priv(indio_dev);
+
+	if (atomic_read(&humid_st->common_attributes.data_ready))
+		iio_push_to_buffers_with_timestamp(indio_dev,
+					&humid_st->humidity_data,
+					iio_get_time_ns(indio_dev));
+
+	return 0;
+}
+
+/* Capture samples in local storage */
+static int humidity_capture_sample(struct hid_sensor_hub_device *hsdev,
+				unsigned int usage_id, size_t raw_len,
+				char *raw_data, void *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct humidity_state *humid_st = iio_priv(indio_dev);
+
+	switch (usage_id) {
+	case HID_USAGE_SENSOR_ATMOSPHERIC_HUMIDITY:
+		humid_st->humidity_data = *(s32 *)raw_data;
+
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+/* Parse report which is specific to an usage id*/
+static int humidity_parse_report(struct platform_device *pdev,
+				struct hid_sensor_hub_device *hsdev,
+				struct iio_chan_spec *channels,
+				unsigned int usage_id,
+				struct humidity_state *st)
+{
+	int ret;
+
+	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT,
+					usage_id,
+					HID_USAGE_SENSOR_ATMOSPHERIC_HUMIDITY,
+					&st->humidity_attr);
+	if (ret < 0)
+		return ret;
+
+	humidity_adjust_channel_bit_mask(channels, 0, st->humidity_attr.size);
+
+	st->scale_precision = hid_sensor_format_scale(
+						HID_USAGE_SENSOR_HUMIDITY,
+						&st->humidity_attr,
+						&st->scale_pre_decml,
+						&st->scale_post_decml);
+
+	/* Set Sensitivity field ids, when there is no individual modifier */
+	if (st->common_attributes.sensitivity.index < 0)
+		sensor_hub_input_get_attribute_info(hsdev,
+			HID_FEATURE_REPORT, usage_id,
+			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
+			HID_USAGE_SENSOR_ATMOSPHERIC_HUMIDITY,
+			&st->common_attributes.sensitivity);
+
+	return ret;
+}
+
+static struct hid_sensor_hub_callbacks humidity_callbacks = {
+	.send_event = &humidity_proc_event,
+	.capture_sample = &humidity_capture_sample,
+};
+
+/* Function to initialize the processing for usage id */
+static int hid_humidity_probe(struct platform_device *pdev)
+{
+	static const char *name = "humidity";
+	struct iio_dev *indio_dev;
+	struct humidity_state *humid_st;
+	struct iio_chan_spec *humid_chans;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*humid_st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	humid_st = iio_priv(indio_dev);
+	humid_st->common_attributes.hsdev = hsdev;
+	humid_st->common_attributes.pdev = pdev;
+
+	ret = hid_sensor_parse_common_attributes(hsdev,
+					HID_USAGE_SENSOR_HUMIDITY,
+					&humid_st->common_attributes);
+	if (ret)
+		return ret;
+
+	humid_chans = devm_kmemdup(&indio_dev->dev, humidity_channels,
+					sizeof(humidity_channels), GFP_KERNEL);
+	if (!humid_chans)
+		return -ENOMEM;
+
+	ret = humidity_parse_report(pdev, hsdev, humid_chans,
+				HID_USAGE_SENSOR_HUMIDITY, humid_st);
+	if (ret)
+		return ret;
+
+	indio_dev->channels = humid_chans;
+	indio_dev->num_channels = ARRAY_SIZE(humidity_channels);
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->info = &humidity_info;
+	indio_dev->name = name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = devm_iio_triggered_buffer_setup(&pdev->dev, indio_dev,
+					&iio_pollfunc_store_time, NULL, NULL);
+	if (ret)
+		return ret;
+
+	atomic_set(&humid_st->common_attributes.data_ready, 0);
+	ret = hid_sensor_setup_trigger(indio_dev, name,
+				&humid_st->common_attributes);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	humidity_callbacks.pdev = pdev;
+	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY,
+					&humidity_callbacks);
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
+	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY);
+error_remove_trigger:
+	hid_sensor_remove_trigger(&humid_st->common_attributes);
+	return ret;
+}
+
+/* Function to deinitialize the processing for usage id */
+static int hid_humidity_remove(struct platform_device *pdev)
+{
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct humidity_state *humid_st = iio_priv(indio_dev);
+
+	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY);
+	hid_sensor_remove_trigger(&humid_st->common_attributes);
+
+	return 0;
+}
+
+static const struct platform_device_id hid_humidity_ids[] = {
+	{
+		/* Format: HID-SENSOR-usage_id_in_hex_lowercase */
+		.name = "HID-SENSOR-200032",
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, hid_humidity_ids);
+
+static struct platform_driver hid_humidity_platform_driver = {
+	.id_table = hid_humidity_ids,
+	.driver = {
+		.name	= "humidity-sensor",
+		.pm	= &hid_sensor_pm_ops,
+	},
+	.probe		= hid_humidity_probe,
+	.remove		= hid_humidity_remove,
+};
+module_platform_driver(hid_humidity_platform_driver);
+
+MODULE_DESCRIPTION("HID Environmental humidity sensor");
+MODULE_AUTHOR("Song Hongyan <hongyan.song@intel.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index 30c7dc4..719c928 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -45,6 +45,10 @@
 #define HID_USAGE_SENSOR_DATA_ATMOSPHERIC_PRESSURE              0x200430
 #define HID_USAGE_SENSOR_ATMOSPHERIC_PRESSURE                   0x200431
 
+/* humidity */
+#define HID_USAGE_SENSOR_HUMIDITY                              0x200032
+#define HID_USAGE_SENSOR_ATMOSPHERIC_HUMIDITY                  0x200433
+
 /* Gyro 3D: (200076) */
 #define HID_USAGE_SENSOR_GYRO_3D				0x200076
 #define HID_USAGE_SENSOR_DATA_ANGL_VELOCITY			0x200456
-- 
1.9.1

