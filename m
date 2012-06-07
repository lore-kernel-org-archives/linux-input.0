From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: [PATCH, 4/7] HID-Sensors: Added accelerometer 3D
Date: Thu, 07 Jun 2012 09:10:58 +0100
Message-ID: <4FD06212.7000204@cam.ac.uk>
References: <1338997164-5077-1-git-send-email-srinivas.pandruvada@intel.com> <1338997164-5077-5-git-send-email-srinivas.pandruvada@intel.com> <c31622ba-ce24-494c-8c28-d66747eff659@email.android.com> <4FA419E87744DF4DAECD5BCE1214B7A91931B547@ORSMSX104.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FA419E87744DF4DAECD5BCE1214B7A91931B547-P5GAC/sN6hk64kNsxIetb7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 6/6/2012 5:57 PM, Pandruvada, Srinivas wrote:
> The USB sensor spec has a report structure which it sends as part of report descriptor we get during initial plug in. This report structure describes elements and their sizes. For example, it may say that an Accelerometer X axis value as 4 bytes long and what is the exponent and unit. Also it sends what control elements it has.
> The sequence is
> - Set sensitivity, interval, activate sys-fs interface. The USB sensor will send an event by USB-IN report when the captured sample is changed by sensitivity value and stable for at least interval. Also you need to activate the sensor so that the usb will start sending events.
>
> - Once USB report with the captured sample arrives, I format the data as defined in " struct accel_3d_sample" below and push to IIO ring buffer.
> I define a single channel
> 	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_X_AND_Y_AND_Z,
> 	IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
> 	IIO_CHAN_INFO_OFFSET_SEPARATE_BIT,
> 	ACCEL_X_Y_Z, ACCEL_3D_SCAN_ACC_X_Y_Z,
> 		 IIO_ST('u', sizeof(struct accel_3d_sample) * 8,
> 		sizeof(struct accel_3d_sample) * 8, 0), 0), };
>
> Please suggest me if this is not the way IIO channel used.
You have 3 channels here.  The iio buffer interface will handle the
fact that they are 'at the same time' on it's own.

Btw I've killed off that macro so this won't build against current 
tree...  Feel free if sensible to define a local macro.  The global one
was a maintenance nightmare hence we scrapped it...

Sketching out what you should have

{
          .type = IIO_ACCEL,
          .modified = 1,
          .channel2 = IIO_MOD_X,
          .info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
  		      IIO_CHAN_INFO_OFFSET_SEPARATE_BIT,
          .scan_index = 0,
          .scan_type = {
               .sign = 's',
               .realbits = 12,
               .storagebits = 16,
          },
}, {
          .type = IIO_ACCEL,
          .modified = 1,
          .channel2 = IIO_MOD_Y,
          .info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
  		      IIO_CHAN_INFO_OFFSET_SEPARATE_BIT,
          .scan_index = 1,
          .scan_type = {
               .sign = 's',
               .realbits = 12,
               .storagebits = 16,
          },
}, {
          .type = IIO_ACCEL,
          .modified = 1,
          .channel2 = IIO_MOD_Y,
          .info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
  		      IIO_CHAN_INFO_OFFSET_SEPARATE_BIT,
          .scan_index = 2,
          .scan_type = {
               .sign = 's',
               .realbits = 12,
               .storagebits = 16,
          },
Actually given you had scale and offset for your combined channel, those 
should probably be the SHARED versions.

The scan type is for a device that needs bits masked...

Hope that is enough for you to be getting on with.  Feel free to
post a v2 without waiting for a formal review!

Jonathan
> Thanks,
> Srinivas
>
>
>
> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org]
> Sent: Wednesday, June 06, 2012 9:29 AM
> To: Pandruvada, Srinivas; linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH, 4/7] HID-Sensors: Added accelerometer 3D
>
>
>
> srinivas pandruvada<srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>  wrote:
>
>> From: Srinivas pandruvada<srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>>
>> Added usage id processing for Accelrometer 3D. This uses IIO interfaces
>> "ring/buffer and trigger interface" to present data to user mode.
>
> I do not understand the data format.  The way iio describes the format is done through sysfs attrs built from the iio_Chan spec... that way a scan is made up of a number of channel readings each taken at roughly the same time.  However each is separately described.  Perhaps the description needs extending.  Please describe the format.
>>
>> Signed-off-by: Srinivas pandruvada<srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> ---
>> drivers/staging/hid-sensors/Makefile               |    1 +
>> drivers/staging/hid-sensors/hid-sensor-accel-3d.c  |  387
>> ++++++++++++++++++++
>> drivers/staging/hid-sensors/hid-sensor-hub.c       |    1 +
>> drivers/staging/hid-sensors/hid-sensor-interface.h |    3 +
>> 4 files changed, 392 insertions(+), 0 deletions(-) create mode 100644
>> drivers/staging/hid-sensors/hid-sensor-accel-3d.c
>>
>> diff --git a/drivers/staging/hid-sensors/Makefile
>> b/drivers/staging/hid-sensors/Makefile
>> index 9a03953..4412079 100644
>> --- a/drivers/staging/hid-sensors/Makefile
>> +++ b/drivers/staging/hid-sensors/Makefile
>> @@ -9,4 +9,5 @@ hid-sensors-y := hid-sensor-hub.o  hid-sensors-y +=
>> hid-sensor-attributes.o  hid-sensors-y += hid-sensor-ring.o
>> hid-sensors-y += hid-sensor-trigger.o
>> +hid-sensors-y += hid-sensor-accel-3d.o
>> obj-$(CONFIG_HID_SENSORS) += hid-sensors.o diff --git
>> a/drivers/staging/hid-sensors/hid-sensor-accel-3d.c
>> b/drivers/staging/hid-sensors/hid-sensor-accel-3d.c
>> new file mode 100644
>> index 0000000..ffe2639
>> --- /dev/null
>> +++ b/drivers/staging/hid-sensors/hid-sensor-accel-3d.c
>> @@ -0,0 +1,387 @@
>> +/*
>> + * HID Sensors Driver
>> + * Copyright (c) 2012, Intel Corporation.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but
>> WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
>> or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
>> License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> along with
>> + * this program; if not, write to the Free Software Foundation, Inc.,
>> + * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
>> + *
>> + */
>> +#include<linux/device.h>
>> +#include<linux/hid.h>
>> +#include<linux/usb.h>
>> +#include "usbhid/usbhid.h"
>> +#include<linux/module.h>
>> +#include<linux/slab.h>
>> +#include "iio/iio.h"
>> +#include "iio/sysfs.h"
>> +#include "iio/ring_sw.h"
>> +#include "iio/trigger.h"
>> +#include "hid-sensor-ids.h"
>> +#include "hid-sensor-interface.h"
>> +#include "hid-sensor-attributes.h"
>> +
>> +
>> +struct accel_3d_sample {
>> +	u16 x_sz;
>> +	u32 accel_x;
>> +	u16 y_sz;
>> +	u32 accel_y;
>> +	u16 z_sz;
>> +	u32 accel_z;
>> +} __packed;
>> +
>> +struct accel_3d_state {
>> +	struct hid_sensor_hub_attribute_info accel_x;
>> +	struct hid_sensor_hub_attribute_info accel_y;
>> +	struct hid_sensor_hub_attribute_info accel_z;
>> +	struct accel_3d_sample accel_sample_data; };
>> +
>> +
>> +enum accel_3d_chan {
>> +	ACCEL_X_Y_Z,
>> +};
>> +
>> +enum accel_3d_scan {
>> +	ACCEL_3D_SCAN_ACC_X_Y_Z,
>> +};
>> +
>> +static struct iio_chan_spec accel_3d_channels[] = {
>> +	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_X_AND_Y_AND_Z,
>> +	IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
>> +	IIO_CHAN_INFO_OFFSET_SEPARATE_BIT,
>> +	ACCEL_X_Y_Z, ACCEL_3D_SCAN_ACC_X_Y_Z,
>> +		 IIO_ST('u', sizeof(struct accel_3d_sample) * 8,
>> +		sizeof(struct accel_3d_sample) * 8, 0), 0), };
>> +
>> +static ssize_t accel_3d_read_accel(struct device *dev,
>> +				struct device_attribute *attr,
>> +				char *buf)
>> +{
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +	struct hid_sensor_attributes *st = iio_priv(indio_dev);
>> +	struct accel_3d_state *accel_state =
>> +			(struct accel_3d_state *)st->private;
>> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>> +	int report_id = -1;
>> +
>> +	switch (this_attr->address) {
>> +	case HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_X_AXIS:
>> +		report_id = accel_state->accel_x.report_id;
>> +		break;
>> +	case HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_Y_AXIS:
>> +		report_id = accel_state->accel_y.report_id;
>> +		break;
>> +	case HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_Z_AXIS:
>> +		report_id = accel_state->accel_z.report_id;
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +	if (report_id<  0)
>> +		return -EINVAL;
>> +
>> +	return sensor_hub_input_attr_get_value(st->hdev,
>> +			HID_USAGE_SENSOR_ACCEL_3D, this_attr->address,
>> +			report_id, 4, buf);
>> +}
>> +
>> +static int accel_3d_read_raw(struct iio_dev *indio_dev,
>> +			      struct iio_chan_spec const *chan,
>> +			      int *val, int *val2,
>> +			      long mask)
>> +{
>> +	struct hid_sensor_attributes *st = iio_priv(indio_dev);
>> +	struct accel_3d_state *accel_state =
>> +			(struct accel_3d_state *)st->private;
>> +	*val = 0;
>> +	*val2 = 0;
>> +
>> +	switch (mask) {
>> +	case 0:
>> +		break;
>> +	case IIO_CHAN_INFO_SCALE:
>> +		*val = accel_state->accel_x.units;
>> +		break;
>> +	case IIO_CHAN_INFO_OFFSET:
>> +		*val = accel_state->accel_x.unit_expo;
>> +		break;
>> +	default:
>> +		break;
>> +
>> +	}
>> +	return IIO_VAL_INT;
>> +}
>> +
>> +static int accel_3d_write_raw(struct iio_dev *indio_dev,
>> +			       struct iio_chan_spec const *chan,
>> +			       int val,
>> +			       int val2,
>> +			       long mask)
>> +{
>> +	printk(KERN_ERR "%s\n", __func__);
>> +
>> +	return 0;
>> +}
>> +
>> +/* Usage specific attributes */
>> +#define IIO_DEV_ATTR_ACCEL_OFFSET(_mode, _show, _store, _addr)  \
>> +	IIO_DEVICE_ATTR(accel_offset, _mode, _show, _store, _addr)
>> +
>> +#define IIO_DEV_ATTR_ACCEL_X_OFFSET(_mode, _show, _store, _addr)
>> \
>> +	IIO_DEVICE_ATTR(accel_x_offset, _mode, _show, _store, _addr)
>> +
>> +#define IIO_DEV_ATTR_ACCEL_Y_OFFSET(_mode, _show, _store, _addr)
>> \
>> +	IIO_DEVICE_ATTR(accel_y_offset, _mode, _show, _store, _addr)
>> +
>> +#define IIO_DEV_ATTR_ACCEL_Z_OFFSET(_mode, _show, _store, _addr)
>> \
>> +	IIO_DEVICE_ATTR(accel_z_offset, _mode, _show, _store, _addr)
>> +
>> +#define IIO_DEV_ATTR_ACCEL_SENSITIVITY(_mode, _show, _store, _addr)
>>     \
>> +	IIO_DEVICE_ATTR(accel_sensitivity, _mode, _show, _store, _addr)
>> +
>> +static IIO_DEV_ATTR_ACCEL_X_OFFSET(S_IWUSR | S_IRUGO,
>> accel_3d_read_accel,
>> +		 NULL, HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_X_AXIS);
>> +static IIO_DEV_ATTR_ACCEL_Y_OFFSET(S_IWUSR | S_IRUGO,
>> accel_3d_read_accel,
>> +		 NULL, HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_Y_AXIS);
>> +static IIO_DEV_ATTR_ACCEL_Z_OFFSET(S_IWUSR | S_IRUGO,
>> accel_3d_read_accel,
>> +		 NULL, HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_Z_AXIS);
>> +
>> +static struct attribute *accel_3d_attributes[] = {
>> +	/* common attributes */
>> +	&iio_dev_attr_poll_interval.dev_attr.attr,
>> +	&iio_dev_attr_sensitivity.dev_attr.attr,
>> +	&iio_dev_attr_activate.dev_attr.attr,
>> +	/* Usage specific attributes */
>> +	&iio_dev_attr_accel_x_offset.dev_attr.attr,
>> +	&iio_dev_attr_accel_y_offset.dev_attr.attr,
>> +	&iio_dev_attr_accel_z_offset.dev_attr.attr,
>> +	NULL,
>> +};
>> +
>> +static const struct attribute_group accel_3d_attribute_group = {
>> +	.attrs = accel_3d_attributes,
>> +};
>> +
>> +static const struct iio_info accel_3d_info = {
>> +	.attrs =&accel_3d_attribute_group,
>> +	.driver_module = THIS_MODULE,
>> +	.read_raw =&accel_3d_read_raw,
>> +	.write_raw =&accel_3d_write_raw,
>> +};
>> +
>> +
>> +/* Function to push data to IIO ring */ int accel_3d_proc_event(struct
>> +hid_device *hdev, unsigned usage_id,
>> void *priv)
>> +{
>> +	struct iio_dev *indio_dev = (struct iio_dev *)priv;
>> +	struct hid_sensor_attributes *st = iio_priv(indio_dev);
>> +	struct accel_3d_state *accel_state =
>> +			(struct accel_3d_state *)st->private;
>> +
>> +	hid_dbg(hdev, "accel_3d_proc_event\n");
>> +	if (st->data_ready)
>> +		hid_sensor_push_data_to_ring(indio_dev,
>> +				(u8 *)&accel_state->accel_sample_data,
>> +				sizeof(struct accel_3d_sample));
>> +	else
>> +		hid_dbg(hdev, "accel_3d_proc_event data not ready\n");
>> +	return 0;
>> +}
>> +
>> +/* Capture samples in local storage */ int
>> +accel_3d_capture_sample(struct hid_device *hdev, unsigned
>> usage_id,
>> +				 size_t raw_len, char *raw_data, void *priv) {
>> +	struct iio_dev *indio_dev = (struct iio_dev *)priv;
>> +	struct hid_sensor_attributes *st = iio_priv(indio_dev);
>> +	struct accel_3d_state *accel_state =
>> +			(struct accel_3d_state *)st->private;
>> +
>> +	switch (usage_id) {
>> +	case HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_X_AXIS:
>> +		accel_state->accel_sample_data.x_sz = raw_len;
>> +		accel_state->accel_sample_data.accel_x =
>> +		*(u32 *)raw_data;
>> +		break;
>> +	case HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_Y_AXIS:
>> +		accel_state->accel_sample_data.y_sz = raw_len;
>> +		accel_state->accel_sample_data.accel_y =
>> +		*(u32 *)raw_data;
>> +		break;
>> +	case HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_Z_AXIS:
>> +		accel_state->accel_sample_data.z_sz = raw_len;
>> +		accel_state->accel_sample_data.accel_z =
>> +		*(u32 *)raw_data;
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +	return 0;
>> +}
>> +
>> +
>> +/* Parse report which is specific to an usage id*/ static int
>> +accel_3d_parse_report(struct hid_device *hdev, unsigned
>> usage_id,
>> +				struct accel_3d_state *st)
>> +{
>> +	int ret;
>> +
>> +	ret = sensor_hub_input_get_attribute_info(hdev, HID_INPUT_REPORT,
>> +			usage_id,
>> +			HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_X_AXIS,
>> +			&st->accel_x);
>> +	if (!ret)
>> +		hid_dbg(hdev, "No Accel X attribute\n");
>> +
>> +
>> +	ret = sensor_hub_input_get_attribute_info(hdev, HID_INPUT_REPORT,
>> +			usage_id,
>> +			HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_Y_AXIS,
>> +			&st->accel_y);
>> +	if (!ret)
>> +		hid_dbg(hdev, "No Accel Y attribute\n");
>> +
>> +
>> +	ret = sensor_hub_input_get_attribute_info(hdev, HID_INPUT_REPORT,
>> +			usage_id,
>> +			HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_Z_AXIS,
>> +			&st->accel_z);
>> +	if (!ret)
>> +		hid_dbg(hdev, "No Accel Z attribute\n");
>> +
>> +	hid_dbg(hdev, "accel_3d %x:%x, %x:%x, %x:%x\n", st->accel_x.index,
>> +			st->accel_x.report_id,
>> +			st->accel_y.index, st->accel_y.report_id,
>> +			st->accel_z.index, st->accel_z.report_id);
>> +
>> +	return 0;
>> +}
>> +
>> +/* Entry function to initialize the processing for usage id */ static
>> +int accel_3d_enter(struct hid_device *hdev, unsigned usage_id,
>> +				void **priv)
>> +{
>> +	int ret = 0;
>> +	static char *name = "accel_3d";
>> +	struct iio_dev *indio_dev;
>> +	struct accel_3d_state *accel_state;
>> +	struct hid_sensor_attributes *st;
>> +
>> +	accel_state = kzalloc(sizeof(struct accel_3d_state), GFP_KERNEL);
>> +	if (accel_state == NULL) {
>> +		ret = -ENOMEM;
>> +		goto error_ret;
>> +	}
>> +
>> +	indio_dev = iio_allocate_device(sizeof(struct
>> hid_sensor_attributes));
>> +	if (indio_dev == NULL) {
>> +		ret = -ENOMEM;
>> +		goto error_free_state;
>> +	}
>> +	st = iio_priv(indio_dev);
>> +	st->usage_id = usage_id;
>> +	st->hdev = hdev;
>> +	st->private = (void *)accel_state;
>> +
>> +	ret = hid_sensor_parse_common_attributes(hdev, usage_id, st);
>> +	if (ret) {
>> +		hid_err(hdev, "failed to setup common attributes\n");
>> +		goto error_free_dev;
>> +	}
>> +	ret = accel_3d_parse_report(hdev, usage_id, accel_state);
>> +	if (ret) {
>> +		hid_err(hdev, "failed to setup attributes\n");
>> +		goto error_free_dev;
>> +	}
>> +
>> +	indio_dev->channels = accel_3d_channels;
>> +	indio_dev->num_channels =
>> +				ARRAY_SIZE(accel_3d_channels);
>> +	indio_dev->dev.parent =&hdev->dev;
>> +	indio_dev->info =&accel_3d_info;
>> +	indio_dev->name = name;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +
>> +	ret = hid_sensor_configure_ring(indio_dev);
>> +	if (ret) {
>> +		hid_err(hdev, "failed to initialize the ring\n");
>> +		goto error_free_dev;
>> +	}
>> +
>> +	ret = iio_buffer_register(indio_dev,
>> +					accel_3d_channels,
>> +					ARRAY_SIZE(accel_3d_channels));
>> +	if (ret) {
>> +		hid_err(hdev, "failed to initialize the ring\n");
>> +		goto error_unreg_ring_funcs;
>> +	}
>> +	st->data_ready = true;
>> +	ret = hid_sensor_setup_trigger(indio_dev, name);
>> +	if (ret<  0) {
>> +		hid_err(hdev, "trigger setup failed\n");
>> +		goto error_uninit_ring;
>> +	}
>> +
>> +	ret = iio_device_register(indio_dev);
>> +	if (ret) {
>> +		hid_err(hdev, "device register failed\n");
>> +		goto error_remove_trigger;
>> +	}
>> +	*priv = (void *)indio_dev;
>> +	return ret;
>> +
>> +error_remove_trigger:
>> +		hid_sensor_remove_trigger(indio_dev);
>> +error_uninit_ring:
>> +		iio_buffer_unregister(indio_dev);
>> +error_unreg_ring_funcs:
>> +		hid_sensor_ring_cleanup(indio_dev);
>> +error_free_dev:
>> +		iio_free_device(indio_dev);
>> +error_free_state:
>> +		kfree(accel_state);
>> +error_ret:
>> +		return ret;
>> +}
>> +
>> +static int accel_3d_exit(struct hid_device *hdev, void *priv) {
>> +	int ret = 0;
>> +	struct iio_dev *indio_dev = (struct iio_dev *)priv;
>> +	struct hid_sensor_attributes *st = iio_priv(indio_dev);
>> +	struct accel_3d_state *accel_state =
>> +			(struct accel_3d_state *)st->private;
>> +
>> +	iio_device_unregister(indio_dev);
>> +	hid_sensor_remove_trigger(indio_dev);
>> +	iio_buffer_unregister(indio_dev);
>> +	hid_sensor_ring_cleanup(indio_dev);
>> +	iio_free_device(indio_dev);
>> +
>> +	kfree(accel_state);
>> +	return ret;
>> +}
>> +
>> +static struct sensor_hub_callbacks accel_3d_callbacks = {
>> +	.enter = accel_3d_enter,
>> +	.exit = accel_3d_exit,
>> +	.send_event = accel_3d_proc_event,
>> +	.capture_sample = accel_3d_capture_sample, };
>> +
>> +struct sensor_hub_callbacks  *accel_3d_register_callbacks(void)
>> +{
>> +	return&accel_3d_callbacks;
>> +}
>> diff --git a/drivers/staging/hid-sensors/hid-sensor-hub.c
>> b/drivers/staging/hid-sensors/hid-sensor-hub.c
>> index 384e0d0..55ae562 100644
>> --- a/drivers/staging/hid-sensors/hid-sensor-hub.c
>> +++ b/drivers/staging/hid-sensors/hid-sensor-hub.c
>> @@ -60,6 +60,7 @@ struct sensor_hub_callbacks_list {  };
>>
>> static struct sensor_hub_callbacks_list usage_callbacks[] = {
>> +	{HID_USAGE_SENSOR_ACCEL_3D, accel_3d_register_callbacks},
>> 	{0}
>> };
>>
>> diff --git a/drivers/staging/hid-sensors/hid-sensor-interface.h
>> b/drivers/staging/hid-sensors/hid-sensor-interface.h
>> index 477494f..3f4fe57 100644
>> --- a/drivers/staging/hid-sensors/hid-sensor-interface.h
>> +++ b/drivers/staging/hid-sensors/hid-sensor-interface.h
>> @@ -84,4 +84,7 @@ void hid_sensor_push_data_to_ring(struct iio_dev
>> *indio_dev, u8 *data,  int hid_sensor_setup_trigger(struct iio_dev
>> *indio_dev, char *name);  void hid_sensor_remove_trigger(struct iio_dev
>> *indio_dev);
>>
>> +/* Sensor usage id processing callbacks */ struct sensor_hub_callbacks
>> +*accel_3d_register_callbacks(void);
>> +
>> #endif
>> --
>> 1.7.7.6
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info
>> at  http://vger.kernel.org/majordomo-info.html
>
> --
> Sent from my Android phone with K-9 Mail. Please excuse my brevity.
