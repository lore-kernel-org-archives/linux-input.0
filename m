From: srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH, 6/6] HID-Sensors: Added ALS
Date: Mon, 25 Jun 2012 17:54:14 -0700
Message-ID: <1340672054-16591-7-git-send-email-srinivas.pandruvada@intel.com>
References: <1340672054-16591-1-git-send-email-srinivas.pandruvada@intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340672054-16591-1-git-send-email-srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jic23.cam.ac.uk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Added usage id processing for ALS. This uses IIO
interfaces for triggerred buffer to present data to user
mode.This uses HID sensor framework for registering callback
events from the sensor hub.

Signed-off-by: srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/staging/iio/light/Kconfig          |   10 +
 drivers/staging/iio/light/Makefile         |    2 +
 drivers/staging/iio/light/hid-sensor-als.c |  478 ++++++++++++++++++++++++++++
 3 files changed, 490 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/light/hid-sensor-als.c

diff --git a/drivers/staging/iio/light/Kconfig b/drivers/staging/iio/light/Kconfig
index e7e9159..59e4745 100644
--- a/drivers/staging/iio/light/Kconfig
+++ b/drivers/staging/iio/light/Kconfig
@@ -31,4 +31,14 @@ config TSL2583
 	 Provides support for the TAOS tsl2580, tsl2581 and tsl2583 devices.
 	 Access ALS data via iio, sysfs.
 
+config HID_SENSOR_ALS
+	depends on HID_SENSOR_HUB
+	select IIO_BUFFER
+	select IIO_TRIGGER
+	select IIO_TRIGGERED_BUFFER
+	tristate "HID Ambient Light Sensor"
+	help
+	  Say yes here to build support for the HID SENSOR
+	  ALS.
+
 endmenu
diff --git a/drivers/staging/iio/light/Makefile b/drivers/staging/iio/light/Makefile
index 3011fbf..9b90d84 100644
--- a/drivers/staging/iio/light/Makefile
+++ b/drivers/staging/iio/light/Makefile
@@ -5,3 +5,5 @@
 obj-$(CONFIG_SENSORS_TSL2563)	+= tsl2563.o
 obj-$(CONFIG_SENSORS_ISL29018)	+= isl29018.o
 obj-$(CONFIG_TSL2583)	+= tsl2583.o
+hid-sensor-als-drv-y  := hid-sensor-als.o
+obj-$(CONFIG_HID_SENSOR_ALS) += hid-sensor-als-drv.o
diff --git a/drivers/staging/iio/light/hid-sensor-als.c b/drivers/staging/iio/light/hid-sensor-als.c
new file mode 100644
index 0000000..cfcda5d
--- /dev/null
+++ b/drivers/staging/iio/light/hid-sensor-als.c
@@ -0,0 +1,478 @@
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
+#define DRIVER_NAME "HID-SENSOR-200041"
+
+#define CHANNEL_SCAN_INDEX_ILLUM 0
+
+struct als_sample {
+	u16 illum;
+};
+
+struct als_state {
+	struct hid_sensor_hub_device *hsdev;
+	struct platform_device *pdev;
+	struct hid_sensor_common_attributes *common_attrb;
+	struct hid_sensor_hub_attribute_info als_illum;
+	struct als_sample als_sample_data;
+	bool data_ready;
+};
+
+static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
+						bool state)
+{
+	struct iio_dev *indio_dev = trig->private_data;
+	struct als_state *st = iio_priv(indio_dev);
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
+	struct als_state *als_state = iio_priv(indio_dev);
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
+				als_state->hsdev,
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
+static int als_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int val,
+			       int val2,
+			       long mask)
+{
+	dev_err(&indio_dev->dev, "%s\n", __func__);
+	return 0;
+}
+
+static ssize_t hid_sensor_als_read_hyst_raw(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	int len;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct als_state *als_state = iio_priv(indio_dev);
+	len = hid_sensor_read_hyst_raw(als_state->common_attrb, strlen(buf),
+					buf);
+	return len;
+}
+
+static ssize_t hid_sensor_als_write_hyst_raw(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct als_state *als_state = iio_priv(indio_dev);
+	return hid_sensor_write_hyst_raw(als_state->common_attrb,
+					strlen(buf), buf);
+}
+
+static ssize_t hid_sensor_read_als_samp_freq(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct als_state *als_state = iio_priv(indio_dev);
+
+	return hid_sensor_read_samp_freq(als_state->common_attrb,
+					strlen(buf), buf);
+}
+
+static ssize_t hid_sensor_write_als_samp_freq(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct als_state *als_state = iio_priv(indio_dev);
+
+	return hid_sensor_write_samp_freq(als_state->common_attrb,
+					strlen(buf), buf);
+}
+
+static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
+			hid_sensor_read_als_samp_freq,
+			hid_sensor_write_als_samp_freq);
+
+#define IIO_DEV_ATTR_HYSTERESIS(_mode, _show, _store, _addr)        \
+	IIO_DEVICE_ATTR(hyst_raw, _mode, _show, _store, _addr)
+
+static IIO_DEV_ATTR_HYSTERESIS(S_IWUSR | S_IRUSR,
+			hid_sensor_als_read_hyst_raw,
+			hid_sensor_als_write_hyst_raw,
+			HID_USAGE_SENSOR_PROPERTY_CHANGE_SENSITIVITY_ABS);
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
+	.write_raw = &als_write_raw,
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
+int als_proc_event(struct hid_sensor_hub_device *hsdev, unsigned usage_id,
+			void *priv)
+{
+	struct iio_dev *indio_dev =
+				(struct iio_dev *)platform_get_drvdata(priv);
+	struct als_state *als_state = iio_priv(indio_dev);
+
+	dev_dbg(&indio_dev->dev, "als_proc_event\n");
+	if (als_state->data_ready)
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
+	struct als_state *als_state = iio_priv(indio_dev);
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
+static int als_parse_report(struct hid_sensor_hub_device *hsdev,
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
+	dev_dbg(&st->pdev->dev, "als %x:%x\n", st->als_illum.index,
+			st->als_illum.report_id);
+
+	return 0;
+}
+
+/* Entry function to initialize the processing for usage id */
+static int als_init(struct platform_device *pdev,
+			struct hid_sensor_hub_device *hsdev,
+			unsigned usage_id)
+{
+	int ret = 0;
+	static char *name = "als";
+	struct iio_dev *indio_dev;
+	struct als_state *als_state;
+
+	indio_dev = iio_allocate_device(sizeof(struct als_state));
+	if (indio_dev == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+	platform_set_drvdata(pdev, indio_dev);
+	als_state = iio_priv(indio_dev);
+	als_state->hsdev = hsdev;
+	als_state->pdev = pdev;
+	als_state->common_attrb = sensor_hub_allocate_common_attributes(
+					hsdev, HID_USAGE_SENSOR_ALS);
+	if (als_state->common_attrb == NULL) {
+		ret = -ENOMEM;
+		goto error_free_dev;
+	}
+
+	ret = als_parse_report(hsdev, usage_id, als_state);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to setup attributes\n");
+		goto error_free_dev;
+	}
+
+	indio_dev->channels = als_channels;
+	indio_dev->num_channels =
+				ARRAY_SIZE(als_channels);
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->info = &als_info;
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
+			   CHANNEL_SCAN_INDEX_ILLUM);
+	als_state->data_ready = false;
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
+static int als_exit(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct als_state *st = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	hid_sensor_remove_trigger(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
+	sensor_hub_free_common_attributes(st->common_attrb);
+	iio_free_device(indio_dev);
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
