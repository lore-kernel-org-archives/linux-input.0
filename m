From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/8] HID-Sensors: Added accelerometer 3D
Date: Sun, 08 Jul 2012 19:57:34 +0100
Message-ID: <4FF9D81E.2030002@kernel.org>
References: <1341431532-15060-1-git-send-email-srinivas.pandruvada@intel.com> <1341431532-15060-6-git-send-email-srinivas.pandruvada@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1341431532-15060-6-git-send-email-srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 07/04/2012 08:52 PM, srinivas pandruvada wrote:
> Added usage id processing for Accelerometer 3D.This uses IIO
> interfaces for triggerred buffer to present data to user
> mode.This uses HID sensor framework for registering callback
> events from the sensor hub.
> 
Mostly fine, but in need of some cleanup. Various suggestions inline.
> Signed-off-by: srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/staging/iio/accel/Kconfig               |   10 +
>  drivers/staging/iio/accel/Makefile              |    3 +
>  drivers/staging/iio/accel/hid-sensor-accel-3d.c |  451 +++++++++++++++++++++++
>  3 files changed, 464 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/staging/iio/accel/hid-sensor-accel-3d.c
> 
> diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig
> index 5ab7167..6ab1efa 100644
> --- a/drivers/staging/iio/accel/Kconfig
> +++ b/drivers/staging/iio/accel/Kconfig
> @@ -102,4 +102,14 @@ config SCA3000
>  	  Say yes here to build support for the VTI SCA3000 series of SPI
>  	  accelerometers. These devices use a hardware ring buffer.
>  
> +config HID_SENSOR_ACCEL_3D
> +	depends on HID_SENSOR_HUB
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	select HID_SENSOR_IIO_COMMON
> +	tristate "HID Acelerometers 3D"
> +	help
> +	  Say yes here to build support for the HID SENSOR
> +	  accelerometers 3G.
> +
>  endmenu
> diff --git a/drivers/staging/iio/accel/Makefile b/drivers/staging/iio/accel/Makefile
> index 95c6666..2ae9865 100644
> --- a/drivers/staging/iio/accel/Makefile
> +++ b/drivers/staging/iio/accel/Makefile
> @@ -33,3 +33,6 @@ obj-$(CONFIG_LIS3L02DQ)	+= lis3l02dq.o
>  
>  sca3000-y		:= sca3000_core.o sca3000_ring.o
>  obj-$(CONFIG_SCA3000)	+= sca3000.o
> +
> +hid-sensor-accel-3d-drv-y := hid-sensor-accel-3d.o
> +obj-$(CONFIG_HID_SENSOR_ACCEL_3D) += hid-sensor-accel-3d-drv.o
> diff --git a/drivers/staging/iio/accel/hid-sensor-accel-3d.c b/drivers/staging/iio/accel/hid-sensor-accel-3d.c
> new file mode 100644
> index 0000000..1ee65ce
> --- /dev/null
> +++ b/drivers/staging/iio/accel/hid-sensor-accel-3d.c
> @@ -0,0 +1,451 @@
> +/*
> + * HID Sensors Driver
> + * Copyright (c) 2012, Intel Corporation.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
> + *
> + */
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/slab.h>
> +#include <linux/hid-sensor-hub.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/sysfs.h>
> +#include "../common/hid-sensors/hid-sensor-attributes.h"
> +#include "../common/hid-sensors/hid-sensor-trigger.h"
> +
> +/*Format: HID-SENSOR-usage_id_in_hex*/
> +#define DRIVER_NAME "HID-SENSOR-200073"
> +
Make this an enum, then....
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
struct hid_sensor_hub_attribute_info accel[3]; (using above enum)

> +	struct hid_sensor_hub_attribute_info accel_x;
> +	struct hid_sensor_hub_attribute_info accel_y;
> +	struct hid_sensor_hub_attribute_info accel_z;
> +	struct accel_3d_sample accel_sample_data;
u32 accel_val[3] (also using enum).
> +};
> +
> +/* Channel definitions */
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
> +/* Adjust channel real bits based on report descriptor */
> +static void accel_3d_adjust_channel_bit_mask(int channel, int size)
> +{
> +	accel_3d_channels[channel].scan_type.sign = 's';
> +	accel_3d_channels[channel].scan_type.realbits = size * 8;
> +	accel_3d_channels[channel].scan_type.storagebits = sizeof(u32) * 8;
Always true?  Can't do 16 bit channels in 16 bits?
> +}
> +
> +/* Channel read_raw handler */
> +static int accel_3d_read_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int *val, int *val2,
> +			      long mask)
> +{
> +	struct hid_sensor_attributes *st = iio_priv(indio_dev);
> +	struct accel_3d_state *accel_state =
> +			(struct accel_3d_state *)st->private;
> +	int report_id = -1;
> +	u32 address;
> +
> +	*val = 0;
> +	*val2 = 0;
> +	switch (mask) {
> +	case 0:
With the alternative layout above this becomes
const u32 addresses[3] {
       HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_X_AXIS,
       HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_Y_AXIS,
       HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_Z_AXIS
}; //move this outside as useful elsewhere...
     report_id = accel_state->accel[chan->scan_index].report_id;
     address =  addresses[chan->scan_index];

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
> +				st->hsdev,
> +				HID_USAGE_SENSOR_ACCEL_3D, address,
> +				report_id);
> +		else
> +			*val = 0;
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
This works as they are all the same, but more obviously true
(with the above defines as)
      	  *val = accel_state->accel[chan->scan_index].units;

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
> +
> +
> +static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
> +			hid_sensor_read_samp_freq,
> +			hid_sensor_write_samp_freq);
> +
> +static IIO_DEV_ATTR_HYSTERESIS(S_IWUSR | S_IRUSR,
> +			hid_sensor_read_hyst_raw,
> +			hid_sensor_write_hyst_raw);
rant about formatting of hystersis in previous email.
Anyhow, I'd like to have hystersis defined as an
element of the chan_spec info_mask as it keeps coming
up. That cuts us down to just sampling frequency and
we could do that as
accel_sampling_frequency which already exists.

The key thing is that if it isn't in info_mask, then
it pretty much isn't available to any in kernel
users of the device...

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
> +};
> +
> +/* Function to push data to buffer */
> +void hid_sensor_push_data(struct iio_dev *indio_dev, u8 *data, int len)
> +{
> +	struct iio_buffer *buffer = indio_dev->buffer;
> +	s64 timestamp = iio_get_time_ns();
> +	int datum_sz;
> +
> +	dev_dbg(&indio_dev->dev, "hid_sensor_push_data\n");
> +	if (!buffer) {
> +		dev_err(&indio_dev->dev, "Buffer == NULL\n");
> +		return;
> +	}
> +	datum_sz = buffer->access->get_bytes_per_datum(buffer);
> +	if (len > datum_sz) {
> +		dev_err(&indio_dev->dev, "Datum size mismatch %d:%d\n", len,
> +				datum_sz);
> +		return;
> +	}
> +	buffer->access->store_to(buffer, (u8 *)data, timestamp);
> +}
> +
> +/* Callback handler to send event after all samples are received and captured */
> +int accel_3d_proc_event(struct hid_sensor_hub_device *hsdev, unsigned usage_id,
> +			void *priv)
> +{
> +	struct iio_dev *indio_dev =
> +				(struct iio_dev *)platform_get_drvdata(priv);
Please clear out all these casts from void *'s just makes for messy code.
> +	struct hid_sensor_attributes *st = iio_priv(indio_dev);
> +	struct accel_3d_state *accel_state =
> +			(struct accel_3d_state *)st->private;
> +
> +	dev_dbg(&indio_dev->dev, "accel_3d_proc_event [%d]\n", st->data_ready);
> +	if (st->data_ready)
> +		hid_sensor_push_data(indio_dev,
> +				(u8 *)&accel_state->accel_sample_data,
> +				sizeof(struct accel_3d_sample));
> +	return 0;
> +}
> +
> +/* Capture samples in local storage */
> +int accel_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
> +				unsigned usage_id,
> +				size_t raw_len, char *raw_data,
> +				void *priv)
> +{
> +	struct iio_dev *indio_dev =
> +			(struct iio_dev *)platform_get_drvdata(priv);
> +	struct hid_sensor_attributes *st = iio_priv(indio_dev);
> +	struct accel_3d_state *accel_state =
> +			(struct accel_3d_state *)st->private;
> +
Feels like one ought to be able to decode an axis from that usage_id
and make this much shorter. Would have to look back at the earlier
patch to find out what would work and I'm lazy ;)
> +	switch (usage_id) {
> +	case HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_X_AXIS:
> +		accel_state->accel_sample_data.accel_x =
> +		*(u32 *)raw_data;
> +		break;
> +	case HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_Y_AXIS:
> +		accel_state->accel_sample_data.accel_y =
> +		*(u32 *)raw_data;
> +		break;
> +	case HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_Z_AXIS:
> +		accel_state->accel_sample_data.accel_z =
> +		*(u32 *)raw_data;
> +		break;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
> +/* Parse report which is specific to an usage id*/
> +static int accel_3d_parse_report(struct platform_device *pdev,
> +				struct hid_sensor_hub_device *hsdev,
> +				unsigned usage_id,
> +				struct accel_3d_state *st)
> +{
> +	int ret;
> +
Lots of missing error handling.  Fix this.
Structures should also allow this to be a simple loop over the channels.

> +	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT,
> +			usage_id,
> +			HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_X_AXIS,
> +			&st->accel_x);
> +	accel_3d_adjust_channel_bit_mask(CHANNEL_SCAN_INDEX_X,
> +					st->accel_x.size);
> +
> +	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT,
> +			usage_id,
> +			HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_Y_AXIS,
> +			&st->accel_y);
> +	accel_3d_adjust_channel_bit_mask(CHANNEL_SCAN_INDEX_Y,
> +					st->accel_y.size);
> +
> +	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT,
> +			usage_id,
> +			HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_Z_AXIS,
> +			&st->accel_z);
> +	accel_3d_adjust_channel_bit_mask(CHANNEL_SCAN_INDEX_Z,
> +					st->accel_z.size);
> +
> +	dev_dbg(&pdev->dev, "accel_3d %x:%x, %x:%x, %x:%x\n",
> +			st->accel_x.index,
> +			st->accel_x.report_id,
> +			st->accel_y.index, st->accel_y.report_id,
> +			st->accel_z.index, st->accel_z.report_id);
> +
> +	return 0;
> +}
> +
> +/* Function to initialize the processing for usage id */
> +static int accel_3d_init(struct platform_device *pdev,
> +			struct hid_sensor_hub_device *hsdev,
> +			unsigned usage_id)
> +{
> +	int ret = 0;
> +	static char *name = "accel_3d";
> +	struct iio_dev *indio_dev;
> +	struct accel_3d_state *accel_state;
> +	struct hid_sensor_attributes *st;
> +
> +	accel_state = kzalloc(sizeof(struct accel_3d_state), GFP_KERNEL);
> +	if (accel_state == NULL) {
> +		ret = -ENOMEM;
> +		goto error_ret;
> +	}
> +
> +	indio_dev = iio_device_alloc(sizeof(struct hid_sensor_attributes));
I'd normally expect accel_state to be in iio_priv(indio_dev)... That
might then embed st.
> +	if (indio_dev == NULL) {
> +		ret = -ENOMEM;
> +		goto error_free_state;
> +	}
> +	platform_set_drvdata(pdev, indio_dev);
> +	st = iio_priv(indio_dev);
> +	st->hsdev = hsdev;
> +	st->pdev = pdev;
> +	st->private = (void *)accel_state;
> +
> +	ret = hid_sensor_parse_common_attributes(hsdev, usage_id, st);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to setup common attributes\n");
> +		goto error_free_dev;
> +	}
> +
> +	ret = accel_3d_parse_report(pdev, hsdev, usage_id, accel_state);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to setup attributes\n");
> +		goto error_free_dev;
> +	}
> +
> +	indio_dev->channels = kmemdup(accel_3d_channels,
> +					sizeof(accel_3d_channels),
> +					GFP_KERNEL);
> +	if (!indio_dev->channels) {
> +		dev_err(&pdev->dev, "failed to duplicate channels\n");
> +		goto error_free_dev;
> +	}
> +
> +	indio_dev->num_channels =
> +				ARRAY_SIZE(accel_3d_channels);
> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->info = &accel_3d_info;
> +	indio_dev->name = name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
> +		NULL, NULL);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to initialize trigger buffer\n");
> +		goto error_free_dev_mem;
> +	}
Convention is to nor enable anything initially. Leaves everything
up to userspace (and avoids some annoying race conditions that
have a habit of showing up!)
> +	iio_scan_mask_set(indio_dev, indio_dev->buffer,
> +			   CHANNEL_SCAN_INDEX_X);
> +	iio_scan_mask_set(indio_dev, indio_dev->buffer,
> +			   CHANNEL_SCAN_INDEX_Y);
> +	iio_scan_mask_set(indio_dev, indio_dev->buffer,
> +			   CHANNEL_SCAN_INDEX_Z);
> +	st->data_ready = false;
> +	ret = hid_sensor_setup_trigger(indio_dev, name);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "trigger setup failed\n");
> +		goto error_unreg_buffer_funcs;
> +	}
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "device register failed\n");
> +		goto error_remove_trigger;
> +	}
> +	return ret;
> +
> +error_remove_trigger:
> +	hid_sensor_remove_trigger(indio_dev);
> +error_unreg_buffer_funcs:
> +	iio_triggered_buffer_cleanup(indio_dev);
> +error_free_dev_mem:
> +	kfree(indio_dev->channels);
> +error_free_dev:
> +	iio_device_free(indio_dev);
> +error_free_state:
> +	kfree(accel_state);
> +error_ret:
> +	return ret;
> +}
> +
> +/* Function to deinitialize the processing for usage id */
> +static int accel_3d_exit(struct platform_device *pdev)
> +{
> +	int ret = 0;
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct hid_sensor_attributes *st = iio_priv(indio_dev);
> +	struct accel_3d_state *accel_state =
> +			(struct accel_3d_state *)st->private;
st->private is void * so shouldn't need type cast to assign it
to anything.
> +
> +	iio_device_unregister(indio_dev);
> +	hid_sensor_remove_trigger(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
> +	kfree(indio_dev->channels);
> +	iio_device_free(indio_dev);
> +	kfree(accel_state);
> +	return ret;
> +}
> +
> +static struct hid_sensor_hub_callbacks accel_3d_callbacks = {
> +	.send_event = accel_3d_proc_event,
> +	.capture_sample = accel_3d_capture_sample,
> +};
> +
> +static int __devinit hid_accel_3d_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	u32 *pdata = (u32 *)pdev->dev.platform_data;
> +	struct hid_sensor_hub_device *hsdev;
> +
> +	hsdev = (struct hid_sensor_hub_device *)*pdata;
> +	ret = accel_3d_init(pdev, hsdev, HID_USAGE_SENSOR_ACCEL_3D);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "accel_3d_init failed\n");
> +		return ret;
> +	}
> +	accel_3d_callbacks.pdev = pdev;
> +	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_ACCEL_3D,
> +					&accel_3d_callbacks);
> +	return 0;
> +}
> +
> +static int __devinit hid_accel_3d_remove(struct platform_device *pdev)
> +{
> +	u32 *pdata = (u32 *)pdev->dev.platform_data;
> +	struct hid_sensor_hub_device *hsdev;
> +
> +	hsdev = (struct hid_sensor_hub_device *)*pdata;
why all the type casting mess here?  If pdev->dev.platform_data is not
an hid_sensor_hub_device * then we need a really really clear
explation of why not.

> +	accel_3d_exit(pdev);
> +	return sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_ACCEL_3D);
> +}
> +
> +static struct platform_driver hid_accel_3d_platform_driver = {
> +	.driver = {
> +		.name	= DRIVER_NAME,
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe		= hid_accel_3d_probe,
> +	.remove		= hid_accel_3d_remove,
> +};
> +
> +/*--------------------------------------------------------------------------*/
> +
> +static int __init hid_accel_3d_init(void)
> +{
> +	return platform_driver_register(&hid_accel_3d_platform_driver);
> +}
> +
> +static void __exit hid_accel_3d_exit(void)
> +{
> +	platform_driver_unregister(&hid_accel_3d_platform_driver);
> +}
> +
> +module_init(hid_accel_3d_init);
> +module_exit(hid_accel_3d_exit);

module_platform_driver

> +
> +MODULE_DESCRIPTION("HID Sensor Accel 3D");
> +MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>");
> +MODULE_LICENSE("GPL");
> 
