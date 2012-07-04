From: srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 8/8] HID-Sensors: Added ALS
Date: Wed,  4 Jul 2012 12:52:12 -0700
Message-ID: <1341431532-15060-9-git-send-email-srinivas.pandruvada@intel.com>
References: <1341431532-15060-1-git-send-email-srinivas.pandruvada@intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1341431532-15060-1-git-send-email-srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Added usage id processing for ALS. This uses IIO
interfaces for triggerred buffer to present data to user
mode.This uses HID sensor framework for registering callback
events from the sensor hub.

Signed-off-by: srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/staging/iio/light/Kconfig          |   10 +
 drivers/staging/iio/light/Makefile         |    3 +
 drivers/staging/iio/light/hid-sensor-als.c |  380 ++++++++++++++++++++++++++++
 3 files changed, 393 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/light/hid-sensor-als.c

diff --git a/drivers/staging/iio/light/Kconfig b/drivers/staging/iio/light/Kconfig
index 4bed30e..c131fe9 100644
--- a/drivers/staging/iio/light/Kconfig
+++ b/drivers/staging/iio/light/Kconfig
@@ -50,4 +50,14 @@ config TSL2x7x
 	 tmd2672, tsl2772, tmd2772 devices.
 	 Provides iio_events and direct access via sysfs.
 
+config HID_SENSOR_ALS
+	depends on HID_SENSOR_HUB
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	select HID_SENSOR_IIO_COMMON
+	tristate "HID ALS"
+	help
+	  Say yes here to build support for the HID SENSOR
+	  Ambient light sensor.
+
 endmenu
diff --git a/drivers/staging/iio/light/Makefile b/drivers/staging/iio/light/Makefile
index 141af1e..71f21be 100644
--- a/drivers/staging/iio/light/Makefile
+++ b/drivers/staging/iio/light/Makefile
@@ -7,3 +7,6 @@ obj-$(CONFIG_SENSORS_ISL29018)	+= isl29018.o
 obj-$(CONFIG_SENSORS_ISL29028)	+= isl29028.o
 obj-$(CONFIG_TSL2583)	+= tsl2583.o
 obj-$(CONFIG_TSL2x7x)	+= tsl2x7x_core.o
+
+hid-sensor-als-drv-y := hid-sensor-als.o
+obj-$(CONFIG_HID_SENSOR_ALS) += hid-sensor-als-drv.o
diff --git a/drivers/staging/iio/light/hid-sensor-als.c b/drivers/staging/iio/light/hid-sensor-als.c
new file mode 100644
index 0000000..e2560ec
--- /dev/null
+++ b/drivers/staging/iio/light/hid-sensor-als.c
@@ -0,0 +1,380 @@
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
+#define DRIVER_NAME "HID-SENSOR-200041"
+
+#define CHANNEL_SCAN_INDEX_ILLUM 0
+
+struct als_sample {
+	u16 illum;
+};
+
+struct als_state {
+	struct hid_sensor_hub_attribute_info als_illum;
+	struct als_sample als_sample_data;
+};
+
+static struct iio_chan_spec als_channels[] = {
+	{
+		.type = IIO_INTENSITY,
+		.modified = 1,
+		.channel2 = IIO_MOD_LIGHT_BOTH,
+		.info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.scan_index = CHANNEL_SCAN_INDEX_ILLUM,
+	}
+};
+
+static void als_adjust_channel_bit_mask(int channel, int size)
+{
+	als_channels[channel].scan_type.sign = 's';
+	als_channels[channel].scan_type.realbits = size * 8;
+	als_channels[channel].scan_type.storagebits = sizeof(u32) * 8;
+}
+
+static int als_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val, int *val2,
+			      long mask)
+{
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct als_state *als_state = (struct als_state *)st->private;
+	int report_id = -1;
+	u32 address;
+
+	*val = 0;
+	*val2 = 0;
+	switch (mask) {
+	case 0:
+		switch (chan->scan_index) {
+		case  CHANNEL_SCAN_INDEX_ILLUM:
+			report_id = als_state->als_illum.report_id;
+			address =
+			HID_USAGE_SENSOR_DATA_LIGHT_ILLUMINANCE;
+			break;
+		default:
+			report_id = -1;
+			break;
+		}
+		if (report_id >= 0)
+			*val = sensor_hub_input_attr_get_raw_value(
+				st->hsdev,
+				HID_USAGE_SENSOR_ALS, address,
+				report_id);
+		else
+			*val = 0;
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		*val = als_state->als_illum.units;
+		break;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = als_state->als_illum.unit_expo;
+		break;
+	default:
+		break;
+	}
+	return IIO_VAL_INT;
+}
+
+static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
+			hid_sensor_read_samp_freq,
+			hid_sensor_write_samp_freq);
+
+static IIO_DEV_ATTR_HYSTERESIS(S_IWUSR | S_IRUSR,
+			hid_sensor_read_hyst_raw,
+			hid_sensor_write_hyst_raw);
+
+static struct attribute *als_attributes[] = {
+	/* common attributes */
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	&iio_dev_attr_hyst_raw.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group als_attribute_group = {
+	.attrs = als_attributes,
+};
+
+static const struct iio_info als_info = {
+	.attrs = &als_attribute_group,
+	.driver_module = THIS_MODULE,
+	.read_raw = &als_read_raw,
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
+/* Function to push data to IIO buffer */
+int als_proc_event(struct hid_sensor_hub_device *hsdev, unsigned usage_id,
+			void *priv)
+{
+	struct iio_dev *indio_dev =
+				(struct iio_dev *)platform_get_drvdata(priv);
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct als_state *als_state = (struct als_state *)st->private;
+
+	dev_dbg(&indio_dev->dev, "als_proc_event\n");
+	if (st->data_ready)
+		hid_sensor_push_data(indio_dev,
+				(u8 *)&als_state->als_sample_data,
+				sizeof(struct als_sample));
+	return 0;
+}
+
+/* Capture samples in local storage */
+int als_capture_sample(struct hid_sensor_hub_device *hsdev,
+				unsigned usage_id,
+				size_t raw_len, char *raw_data,
+				void *priv)
+{
+	struct iio_dev *indio_dev =
+			(struct iio_dev *)platform_get_drvdata(priv);
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct als_state *als_state = (struct als_state *)st->private;
+
+	switch (usage_id) {
+	case HID_USAGE_SENSOR_DATA_LIGHT_ILLUMINANCE:
+		als_state->als_sample_data.illum =
+		*(u16 *)raw_data;
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+/* Parse report which is specific to an usage id*/
+static int als_parse_report(struct platform_device *pdev,
+				struct hid_sensor_hub_device *hsdev,
+				unsigned usage_id,
+				struct als_state *st)
+{
+	int ret;
+
+	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT,
+			usage_id,
+			HID_USAGE_SENSOR_DATA_LIGHT_ILLUMINANCE,
+			&st->als_illum);
+	als_adjust_channel_bit_mask(CHANNEL_SCAN_INDEX_ILLUM,
+					st->als_illum.size);
+
+	dev_dbg(&pdev->dev, "als %x:%x\n", st->als_illum.index,
+			st->als_illum.report_id);
+
+	return 0;
+}
+
+/* Function to initialize the processing for usage id */
+static int als_init(struct platform_device *pdev,
+			struct hid_sensor_hub_device *hsdev,
+			unsigned usage_id)
+{
+	int ret = 0;
+	static char *name = "als";
+	struct iio_dev *indio_dev;
+	struct als_state *als_state;
+	struct hid_sensor_attributes *st;
+
+	als_state = kzalloc(sizeof(struct als_state), GFP_KERNEL);
+	if (als_state == NULL) {
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
+	st->private = (void *)als_state;
+
+	ret = hid_sensor_parse_common_attributes(hsdev, usage_id, st);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to setup common attributes\n");
+		goto error_free_dev;
+	}
+
+	ret = als_parse_report(pdev, hsdev, usage_id, als_state);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to setup attributes\n");
+		goto error_free_dev;
+	}
+
+	indio_dev->channels = kmemdup(als_channels,
+					sizeof(als_channels),
+					GFP_KERNEL);
+	if (!indio_dev->channels) {
+		dev_err(&pdev->dev, "failed to duplicate channels\n");
+		goto error_free_dev;
+	}
+
+	indio_dev->num_channels =
+				ARRAY_SIZE(als_channels);
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->info = &als_info;
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
+			   CHANNEL_SCAN_INDEX_ILLUM);
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
+	kfree(als_state);
+error_ret:
+	return ret;
+}
+
+/* Function to deinitialize the processing for usage id */
+static int als_exit(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct als_state *als_state =
+			(struct als_state *)st->private;
+
+	iio_device_unregister(indio_dev);
+	hid_sensor_remove_trigger(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
+	kfree(indio_dev->channels);
+	iio_device_free(indio_dev);
+	kfree(als_state);
+	return ret;
+}
+
+static struct hid_sensor_hub_callbacks als_callbacks = {
+	.send_event = als_proc_event,
+	.capture_sample = als_capture_sample,
+};
+
+static int __devinit hid_als_probe(struct platform_device *pdev)
+{
+	int ret;
+	u32 *pdata = (u32 *)pdev->dev.platform_data;
+	struct hid_sensor_hub_device *hsdev;
+
+	hsdev = (struct hid_sensor_hub_device *)*pdata;
+	ret = als_init(pdev, hsdev, HID_USAGE_SENSOR_ALS);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "als_init failed\n");
+		return ret;
+	}
+	als_callbacks.pdev = pdev;
+	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_ALS,
+					&als_callbacks);
+	return 0;
+}
+
+static int __devinit hid_als_remove(struct platform_device *pdev)
+{
+	u32 *pdata = (u32 *)pdev->dev.platform_data;
+	struct hid_sensor_hub_device *hsdev;
+
+	hsdev = (struct hid_sensor_hub_device *)*pdata;
+	als_exit(pdev);
+	return sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_ALS);
+}
+
+static struct platform_driver hid_als_platform_driver = {
+	.driver = {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= hid_als_probe,
+	.remove		= hid_als_remove,
+};
+
+/*--------------------------------------------------------------------------*/
+
+static int __init hid_als_init(void)
+{
+	return platform_driver_register(&hid_als_platform_driver);
+}
+
+static void __exit hid_als_exit(void)
+{
+	platform_driver_unregister(&hid_als_platform_driver);
+}
+
+module_init(hid_als_init);
+module_exit(hid_als_exit);
+
+MODULE_DESCRIPTION("HID Sensor ALS");
+MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>");
+MODULE_LICENSE("GPL");
-- 
1.7.7.6
