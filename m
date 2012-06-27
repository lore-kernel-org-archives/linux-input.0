From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: RE: [PATCH, 3/6] HID-Sensors: Added accelerometer 3D
Date: Wed, 27 Jun 2012 15:28:05 +0000
Message-ID: <4FA419E87744DF4DAECD5BCE1214B7A91933F4DA@ORSMSX104.amr.corp.intel.com>
References: <1340672054-16591-1-git-send-email-srinivas.pandruvada@intel.com>
 <1340672054-16591-4-git-send-email-srinivas.pandruvada@intel.com>
 <4FEACE58.20008@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26577 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756108Ab2F0P2Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Jun 2012 11:28:25 -0400
In-Reply-To: <4FEACE58.20008@metafoo.de>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "jic23.cam.ac.uk@vger.kernel.org" <jic23.cam.ac.uk@vger.kernel.org>, "jkosina@suse.cz" <jkosina@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi,

Thanks for the comments. 

<IIO has moved out of staging in 3.5, so this won't build with the latest upstream>
Can you please let me know which tree it is merged? I don't see in Linus's tree. I can see in gregkh/staging.git. But don't see your latest changes.

<The trigger code looks pretty similar in all your IIO drivers, maybe it makes sense to put this into a common module.>
I had this separate before, but once I had to move each driver to its sensor type directory, I merged it. I like to have common module for this. Where are the common modules go in iio directory? 

Thanks,
Srinivas








-----Original Message-----
From: Lars-Peter Clausen [mailto:lars@metafoo.de] 
Sent: Wednesday, June 27, 2012 2:12 AM
To: Pandruvada, Srinivas
Cc: linux-iio@vger.kernel.org; jic23.cam.ac.uk@vger.kernel.org; jkosina@suse.cz; linux-input@vger.kernel.org
Subject: Re: [PATCH, 3/6] HID-Sensors: Added accelerometer 3D

On 06/26/2012 02:54 AM, srinivas pandruvada wrote:
> Added usage id processing for Accelrometer 3D. This uses IIO 
> interfaces for triggerred buffer to present data to user mode.This 
> uses HID sensor framework for registering callback events from the 
> sensor hub.

Hi,

Some comments inline, similar comments also apply for the other IIO drivers in this series.

> [...]
> diff --git a/drivers/staging/iio/accel/hid-sensor-accel-3d.c 
> b/drivers/staging/iio/accel/hid-sensor-accel-3d.c
> new file mode 100644
> index 0000000..77d4663
> --- /dev/null
> +++ b/drivers/staging/iio/accel/hid-sensor-accel-3d.c
> @@ -0,0 +1,537 @@
> [...]
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/slab.h>
> +#include <linux/hid-sensor-hub.h>
> +#include "../iio.h"
> +#include "../sysfs.h"
> +#include "../trigger.h"
> +#include "../kfifo_buf.h"
> +#include "../trigger_consumer.h"
> +#include "../triggered_buffer.h"

IIO has moved out of staging in 3.5, so this wont build with the latest upstream.

> +
> +/*Format: HID-SENSOR-usage_id_in_hex*/ #define DRIVER_NAME 
> +"HID-SENSOR-200073"
> +
> +#define CHANNEL_SCAN_INDEX_X 0
> +#define CHANNEL_SCAN_INDEX_Y 1
> +#define CHANNEL_SCAN_INDEX_Z 2
> +
> +struct accel_3d_sample {
> +	u32 accel_x;
> +	u32 accel_y;
> +	u32 accel_z;
> +} __packed;
> +
> +struct accel_3d_state {
> +	struct hid_sensor_hub_device *hsdev;
> +	struct platform_device *pdev;
> +	struct hid_sensor_common_attributes *common_attrb;
> +	struct hid_sensor_hub_attribute_info accel_x;
> +	struct hid_sensor_hub_attribute_info accel_y;
> +	struct hid_sensor_hub_attribute_info accel_z;
> +	struct accel_3d_sample accel_sample_data;
> +	bool data_ready;
> +};
> +
> +static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
> +						bool state)
> +{
> +	struct iio_dev *indio_dev = trig->private_data;
> +	struct accel_3d_state *st = iio_priv(indio_dev);
> +	int state_val;
> +	char buffer[16];
> +
> +	dev_dbg(&indio_dev->dev, "hid_sensor_data_rdy_trigger_set_state %d\n",
> +					state);
> +	st->data_ready = state;
> +	state_val = state ? 1 : 0;
> +	sprintf(buffer, "%d", state_val);
> +	hid_sensor_write_report_state(st->common_attrb, strlen(buffer), buffer);
> +	hid_sensor_write_power_state(st->common_attrb, strlen(buffer), 
> +buffer);


This looks kind of odd, passing a integer by using a string.

> +
> +	return 0;
> +}
> +
> +void hid_sensor_remove_trigger(struct iio_dev *indio_dev) {
> +	iio_trigger_unregister(indio_dev->trig);
> +	iio_free_trigger(indio_dev->trig);
> +}
> +
> +static const struct iio_trigger_ops hid_sensor_trigger_ops = {
> +	.owner = THIS_MODULE,
> +	.set_trigger_state = &hid_sensor_data_rdy_trigger_set_state,
> +};
> +
> +int hid_sensor_setup_trigger(struct iio_dev *indio_dev, char *name) {
> +	int ret;
> +	struct iio_trigger *trig;
> +
> +	trig = iio_allocate_trigger("%s-dev%d", name, indio_dev->id);
> +	if (trig == NULL) {
> +		ret = -ENOMEM;
> +		goto error_ret;
> +	}
> +
> +	trig->dev.parent = indio_dev->dev.parent;
> +	trig->private_data = (void *)indio_dev;
> +	trig->ops = &hid_sensor_trigger_ops;
> +	ret = iio_trigger_register(trig);
> +
> +	/* select default trigger */
> +	indio_dev->trig = trig;
> +	if (ret)
> +		goto error_free_trig;
> +
> +	return ret;
> +
> +error_free_trig:
> +	iio_free_trigger(trig);
> +error_ret:
> +	return ret;
> +}
> +

The trigger code looks pretty similar in all your IIO drivers, maybe it makes sense to put this into a common module.


> +static struct iio_chan_spec accel_3d_channels[] = {
> +	{
> +		.type = IIO_ACCEL,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_X,
> +		.info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
> +		IIO_CHAN_INFO_SCALE_SHARED_BIT,
> +		.scan_index = CHANNEL_SCAN_INDEX_X,
> +	}, {
> +		.type = IIO_ACCEL,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_Y,
> +		.info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
> +		IIO_CHAN_INFO_SCALE_SHARED_BIT,
> +		.scan_index = CHANNEL_SCAN_INDEX_Y,
> +	}, {
> +		.type = IIO_ACCEL,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_Z,
> +		.info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
> +		IIO_CHAN_INFO_SCALE_SHARED_BIT,
> +		.scan_index = CHANNEL_SCAN_INDEX_Z,
> +	}
> +};
> +
> +static void accel_3d_adjust_channel_bit_mask(int channel, int size) {
> +	accel_3d_channels[channel].scan_type.sign = 's';
> +	accel_3d_channels[channel].scan_type.realbits = size * 8;
> +	accel_3d_channels[channel].scan_type.storagebits = sizeof(u32) * 8;

I would this expect to fail badly if there were two devices with different specs registered at the same time.

> +}
> +
> +static int accel_3d_read_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int *val, int *val2,
> +			      long mask)
> +{
> +	struct accel_3d_state *accel_state = iio_priv(indio_dev);
> +	int report_id = -1;
> +	u32 address;
> +
> +	*val = 0;
> +	*val2 = 0;
> +	switch (mask) {
> +	case 0:
> +		switch (chan->scan_index) {
> +		case  CHANNEL_SCAN_INDEX_X:
> +			report_id = accel_state->accel_x.report_id;
> +			address =
> +			HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_X_AXIS;
> +			break;
> +		case  CHANNEL_SCAN_INDEX_Y:
> +			report_id = accel_state->accel_y.report_id;
> +			address =
> +			HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_Y_AXIS;
> +			break;
> +		case  CHANNEL_SCAN_INDEX_Z:
> +			report_id = accel_state->accel_z.report_id;
> +			address =
> +			HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_Z_AXIS;
> +			break;
> +		default:
> +			report_id = -1;
> +			break;
> +		}
> +		if (report_id >= 0)
> +			*val = sensor_hub_input_attr_get_raw_value(
> +				accel_state->hsdev,
> +				HID_USAGE_SENSOR_ACCEL_3D, address,
> +				report_id);
> +		else
> +			*val = 0;
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = accel_state->accel_x.units;
> +		break;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = accel_state->accel_x.unit_expo;
> +		break;
> +	default:
> +		break;
> +	}
> +	return IIO_VAL_INT;
> +}
> +
> +static int accel_3d_write_raw(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       int val,
> +			       int val2,
> +			       long mask)
> +{
> +	dev_err(&indio_dev->dev, "%s\n", __func__);
> +	return 0;
> +}

If you don't want to do anything here just don't set the callback in the iio_info struct.

> +
> +static ssize_t hid_sensor_accel_3d_read_hyst_raw(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	int len;
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct accel_3d_state *accel_state = iio_priv(indio_dev);
> +	len = hid_sensor_read_hyst_raw(accel_state->common_attrb, strlen(buf),
> +					buf);
> +	return len;
> +}
> +
> +static ssize_t hid_sensor_accel_3d_write_hyst_raw(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct accel_3d_state *accel_state = iio_priv(indio_dev);
> +	return hid_sensor_write_hyst_raw(accel_state->common_attrb,
> +					strlen(buf), buf);
> +}
> +
> +static ssize_t hid_sensor_read_accel_3d_samp_freq(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct accel_3d_state *accel_state = iio_priv(indio_dev);
> +
> +	return hid_sensor_read_samp_freq(accel_state->common_attrb,
> +					strlen(buf), buf);

This doesn't make sense, buf is empty at this point, so a strlen will return 0.

> +}
> +
> +static ssize_t hid_sensor_write_accel_3d_samp_freq(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct accel_3d_state *accel_state = iio_priv(indio_dev);
> +
> +	return hid_sensor_write_samp_freq(accel_state->common_attrb,
> +					strlen(buf), buf);
> +}
> +
> +static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
> +			hid_sensor_read_accel_3d_samp_freq,
> +			hid_sensor_write_accel_3d_samp_freq);
> +
> +#define IIO_DEV_ATTR_HYSTERESIS(_mode, _show, _store, _addr)        \
> +	IIO_DEVICE_ATTR(hyst_raw, _mode, _show, _store, _addr)
> +
> +static IIO_DEV_ATTR_HYSTERESIS(S_IWUSR | S_IRUSR,
> +			hid_sensor_accel_3d_read_hyst_raw,
> +			hid_sensor_accel_3d_write_hyst_raw,
> +			HID_USAGE_SENSOR_PROPERTY_CHANGE_SENSITIVITY_ABS);
> +
> +static struct attribute *accel_3d_attributes[] = {
> +	/* common attributes */
> +	&iio_dev_attr_sampling_frequency.dev_attr.attr,
> +	&iio_dev_attr_hyst_raw.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group accel_3d_attribute_group = {
> +	.attrs = accel_3d_attributes,
> +};
> +
> +static const struct iio_info accel_3d_info = {
> +	.attrs = &accel_3d_attribute_group,
> +	.driver_module = THIS_MODULE,
> +	.read_raw = &accel_3d_read_raw,
> +	.write_raw = &accel_3d_write_raw,
> +};
> +
> +void hid_sensor_push_data(struct iio_dev *indio_dev, u8 *data, int 
> +len) {
> +	struct iio_buffer *buffer = indio_dev->buffer;
> +	s64 timestamp = iio_get_time_ns();
> +	int datum_sz;
> +
> +	if (!buffer)
> +		return;
> +	datum_sz = buffer->access->get_bytes_per_datum(buffer);
> +	if (len > datum_sz) {
> +		dev_err(&indio_dev->dev, "Datum size mismatch %d:%d\n", len,
> +				datum_sz);
> +		return;
> +	}
> +	buffer->access->store_to(buffer, (u8 *)data, timestamp); }
> +
> +static irqreturn_t hid_sensor_trigger_handler(int irq, void *p) {
> +	return IRQ_HANDLED;
> +}

If you don't want to do anything here just pass NULL to iio_triggered_buffer_setup.

> [...]
> +static int __init hid_accel_3d_init(void) {
> +	return platform_driver_register(&hid_accel_3d_platform_driver);
> +}
> +
> +static void __exit hid_accel_3d_exit(void) {
> +	platform_driver_unregister(&hid_accel_3d_platform_driver);
> +}
> +
> +module_init(hid_accel_3d_init);
> +module_exit(hid_accel_3d_exit);

module_platform_driver(hid_accel_3d_platform_driver);

> +
> +MODULE_DESCRIPTION("HID Sensor Accel 3D"); MODULE_AUTHOR("Srinivas 
> +Pandruvada <srinivas.pandruvada@intel.com>");
> +MODULE_LICENSE("GPL");

