From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: [PATCH, 3/7] HID-Sensors: Common attributes and interfaces
Date: Thu, 07 Jun 2012 08:54:31 +0100
Message-ID: <4FD05E37.2060501@cam.ac.uk>
References: <1338997164-5077-1-git-send-email-srinivas.pandruvada@intel.com> <1338997164-5077-4-git-send-email-srinivas.pandruvada@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1338997164-5077-4-git-send-email-srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 6/6/2012 4:39 PM, srinivas pandruvada wrote:
> From: Srinivas pandruvada<srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>
> Added IIO Ring interface and trigger functions, which can be
> used by all sensors. In addition a set of interface functions
> for setting common attributes for all sensors like polling
> interval, sensitivity and activate etc.

Couple of quick points as I'm probably not going to get time to review
this today.

ring_sw is pretty certain to go away - please switch to kfifo. You may
need the poll patch I sent out the other day...

We have a fairly tight abi definition.  Now it can be
extended of course, but only with a very good reason.  Quite
a few of your elements really don't conform to it.

I'm not yet sure how to handle the fact these devices are outputing
a very unusual form of floating point (actually I suspect almost
none of them them actually use that)  Perhaps a useful exercise is
for you to list some examples of the formats that are actually found
in devices?  If we have to support true floating point then we will
but it is going to be very painful.

Probably the most important element of IIO (and any other subsystem)
is generality. Hence drivers often need to blugeon data into the formats
that are expected.

Few quick comments inline.
>
> Signed-off-by: Srinivas pandruvada<srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>   drivers/staging/hid-sensors/Makefile               |    3 +
>   .../staging/hid-sensors/hid-sensor-attributes.c    |  203 ++++++++++++++++++++
>   .../staging/hid-sensors/hid-sensor-attributes.h    |   67 +++++++
>   drivers/staging/hid-sensors/hid-sensor-interface.h |   12 ++
>   drivers/staging/hid-sensors/hid-sensor-ring.c      |  104 ++++++++++
>   drivers/staging/hid-sensors/hid-sensor-trigger.c   |   81 ++++++++
>   6 files changed, 470 insertions(+), 0 deletions(-)
>   create mode 100644 drivers/staging/hid-sensors/hid-sensor-attributes.c
>   create mode 100644 drivers/staging/hid-sensors/hid-sensor-attributes.h
>   create mode 100644 drivers/staging/hid-sensors/hid-sensor-ring.c
>   create mode 100644 drivers/staging/hid-sensors/hid-sensor-trigger.c
>
> diff --git a/drivers/staging/hid-sensors/Makefile b/drivers/staging/hid-sensors/Makefile
> index 13591b2..9a03953 100644
> --- a/drivers/staging/hid-sensors/Makefile
> +++ b/drivers/staging/hid-sensors/Makefile
> @@ -6,4 +6,7 @@ ccflags-y += -Idrivers/staging
>   ccflags-$(CONFIG_HID_SENSOR_DEBUG) += -DDEBUG
>
>   hid-sensors-y := hid-sensor-hub.o
> +hid-sensors-y += hid-sensor-attributes.o
> +hid-sensors-y += hid-sensor-ring.o
> +hid-sensors-y += hid-sensor-trigger.o
>   obj-$(CONFIG_HID_SENSORS) += hid-sensors.o
> diff --git a/drivers/staging/hid-sensors/hid-sensor-attributes.c b/drivers/staging/hid-sensors/hid-sensor-attributes.c
> new file mode 100644
> index 0000000..6f07d50
> --- /dev/null
> +++ b/drivers/staging/hid-sensors/hid-sensor-attributes.c
> @@ -0,0 +1,203 @@
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
> +#include<linux/interrupt.h>
> +#include<linux/irq.h>
> +#include<linux/mutex.h>
> +#include<linux/device.h>
> +#include<linux/kernel.h>
> +#include<linux/spi/spi.h>
> +#include<linux/slab.h>
> +#include<linux/sysfs.h>
> +
> +#include "iio/iio.h"
> +#include "iio/sysfs.h"
> +#include "hid-sensor-ids.h"
> +#include "hid-sensor-interface.h"
> +
> +ssize_t hid_sensor_read_poll_interval(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct hid_sensor_attributes *st = iio_priv(indio_dev);
> +	__s32 value;
> +	int len;
> +	int ret;
> +
> +	ret = sensor_hub_get_feature(st->hdev,
> +			st->poll.report_id,
> +			st->poll.index,&value);
> +	if (ret<  0 || value<  0)
> +		len = sprintf(buf, "0\n");
> +	else
> +		len = sprintf(buf, "units:0x%2x,exp:0x%x,value:0x%2x\n",
> +			st->poll.units, st->poll.unit_expo, value);
It's sampling_frequency for iio and it's in hz.
> +	return len;
> +}
> +
> +
> +ssize_t hid_sensor_write_poll_interval(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct hid_sensor_attributes *st = iio_priv(indio_dev);
> +	long int value;
> +	int ret;
> +
> +	if (kstrtol(buf, 10,&value)<  0)
> +		return -EINVAL;
> +
> +	if (value<= 0)
> +		value = 0;
> +
> +	ret = sensor_hub_set_feature(st->hdev,
> +		st->poll.report_id,
> +		st->poll.index,
> +		value);
This implies to my mind that the units are fixed for a given
device?  Anyhow you also need to convert from hz here.
> +
> +	if (ret<  0)
> +		return ret;
> +	return strlen(buf);
> +
> +}
> +
> +ssize_t hid_sensor_read_report_state(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct hid_sensor_attributes *st = iio_priv(indio_dev);
> +	long int value;
> +	int len;
> +	int ret;
> +
> +	ret = sensor_hub_get_feature(st->hdev,
> +			st->activate.report_id,
> +			st->activate.index, (s32 *)&value);
> +	if (ret<  0 || value<  0)
> +		len = sprintf(buf, "0\n");
> +	else
> +		len = sprintf(buf, "units:0x%2x,exp:0x%x,value:0x%2x\n",
> +			st->activate.units, st->activate.unit_expo,
> +			(unsigned int)value);
> +	return len;
> +
> +}
> +
> +ssize_t hid_sensor_write_report_state(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t len)
> +{
> +
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct hid_sensor_attributes *st = iio_priv(indio_dev);
> +	int ret;
> +	long int value;
> +
> +	if (kstrtol(buf, 10,&value)<  0)
> +		return -EINVAL;
> +
> +	ret = sensor_hub_set_feature(st->hdev, st->activate.report_id,
> +					st->activate.index,
> +					(s32)value);
> +	if (ret<  0)
> +		return ret;
> +
> +	return strlen(buf);
> +}
> +
> +ssize_t hid_sensor_read_sensitivity(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct hid_sensor_attributes *st = iio_priv(indio_dev);
> +	__s32 value;
> +	int len;
> +	int ret;
> +
> +	ret = sensor_hub_get_feature(st->hdev,
> +		st->sensitivity.report_id,
> +		st->sensitivity.index,&value);
> +	if (ret<  0 || value<  0)
> +		len = sprintf(buf, "0\n");
> +	else
> +		len = sprintf(buf, "units:0x%2x,exp:0x%x,value:0x%2x\n",
> +				st->sensitivity.units,
> +				st->sensitivity.unit_expo, value);
> +	return len;
> +}
> +
> +
> +ssize_t hid_sensor_write_sensitivity(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct hid_sensor_attributes *st = iio_priv(indio_dev);
> +	long int value;
> +	int ret;
> +
> +	if (kstrtol(buf, 10,&value)<  0)
> +		return -EINVAL;
> +
> +	if (value<= 0)
> +		value = 0;
> +
> +	ret = sensor_hub_set_feature(st->hdev,
> +		st->sensitivity.report_id,
> +		st->sensitivity.index,
> +		value);
> +
> +	if (ret<  0)
> +		return ret;
> +
> +	return strlen(buf);
> +}
> +
> +
> +
> +int hid_sensor_parse_common_attributes(struct hid_device *hdev, u32 usage_id,
> +					struct hid_sensor_attributes *st)
> +{
> +	int ret;
> +
> +	ret = sensor_hub_input_get_attribute_info(hdev,
> +					HID_FEATURE_REPORT, usage_id,
> +					HID_SENSOR_POLLING,&st->poll);
> +
> +	ret = sensor_hub_input_get_attribute_info(hdev,
> +					HID_FEATURE_REPORT, usage_id,
> +					HID_SENSOR_REPORT_STATE,
> +					&st->activate);
> +
> +	ret = sensor_hub_input_get_attribute_info(hdev,
> +			HID_FEATURE_REPORT, usage_id,
> +			HID_USAGE_SENSOR_PROPERTY_CHANGE_SENSITIVITY_ABS,
> +			&st->sensitivity);
> +
> +	hid_dbg(hdev, "common attributes: %x:%x, %x:%x, %x:%x\n",
> +			st->poll.index, st->poll.report_id,
> +			st->activate.index, st->activate.report_id,
> +			st->sensitivity.index, st->sensitivity.report_id);
> +
> +	return 0;
> +}
> diff --git a/drivers/staging/hid-sensors/hid-sensor-attributes.h b/drivers/staging/hid-sensors/hid-sensor-attributes.h
> new file mode 100644
> index 0000000..b1f4ac9
> --- /dev/null
> +++ b/drivers/staging/hid-sensors/hid-sensor-attributes.h
> @@ -0,0 +1,67 @@
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
> +#ifndef _HID_SENSORS_ATTRIBUTES_H
> +#define _HID_SENSORS_ATTRIBUTES_H
> +
> +/* Common sysfs attributes for HID sensors */
> +
> +int hid_sensor_parse_common_attributes(struct hid_device *hdev, u32 usage_id,
> +					struct hid_sensor_attributes *st);
> +
> +ssize_t hid_sensor_read_poll_interval(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf);
> +ssize_t hid_sensor_write_poll_interval(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t len);
> +
> +ssize_t hid_sensor_read_report_state(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf);
> +ssize_t hid_sensor_write_report_state(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t len);
> +ssize_t hid_sensor_read_sensitivity(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf);
> +ssize_t hid_sensor_write_sensitivity(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t len);
> +
> +
> +#define IIO_DEV_ATTR_POLL_INTERVAL(_mode, _show, _store, _addr)  \
> +	IIO_DEVICE_ATTR(poll_interval, _mode, _show, _store, _addr)
sampling_frequency
> +#define IIO_DEV_ATTR_SENSITIVITY(_mode, _show, _store, _addr)        \
> +	IIO_DEVICE_ATTR(sensitivity, _mode, _show, _store, _addr)
probably maps to hysteresis. Also this one is weird given it's probably 
a parameter of the trigger rather than the sensor read out...  hmm.
> +#define IIO_DEV_ATTR_REPORT_STATE(_mode, _show, _store, _addr)        \
> +	IIO_DEVICE_ATTR(activate, _mode, _show, _store, _addr)
This one needs some docs (sorry if I've missed them).  I'd almost 
guarantee this will map to something more standard....
> +
> +static IIO_DEV_ATTR_POLL_INTERVAL(S_IWUSR | S_IRUSR,
> +			hid_sensor_read_poll_interval,
> +			hid_sensor_write_poll_interval,
> +			HID_SENSOR_POLLING);
> +static IIO_DEV_ATTR_SENSITIVITY(S_IWUSR | S_IRUSR,
> +			hid_sensor_read_sensitivity,
> +			hid_sensor_write_sensitivity,
> +			HID_USAGE_SENSOR_PROPERTY_CHANGE_SENSITIVITY_ABS);
> +static IIO_DEV_ATTR_REPORT_STATE(S_IWUSR | S_IRUSR,
> +			hid_sensor_read_report_state,
> +			hid_sensor_write_report_state,
> +			HID_SENSOR_REPORT_STATE);
> +#endif
> diff --git a/drivers/staging/hid-sensors/hid-sensor-interface.h b/drivers/staging/hid-sensors/hid-sensor-interface.h
> index 18a2e09..477494f 100644
> --- a/drivers/staging/hid-sensors/hid-sensor-interface.h
> +++ b/drivers/staging/hid-sensors/hid-sensor-interface.h
> @@ -72,4 +72,16 @@ ssize_t sensor_hub_input_attr_get_value(struct hid_device *hdev, u32 usage_id,
>   					u32 buf_len, u8 *buf);
>   int sensor_hub_input_get_unit_expo(struct hid_device *hdev, u32 field_usage_id,
>   					s32 *unit, s32 *unit_expo);
> +
> +/* Common IIO Ring Processing Functions */
> +int hid_sensor_configure_ring(struct iio_dev *indio_dev);
> +void hid_sensor_ring_cleanup(struct iio_dev *indio_dev);
> +void hid_sensor_ring_set_datum_size(struct iio_dev *indio_dev, int size);
> +void hid_sensor_push_data_to_ring(struct iio_dev *indio_dev, u8 *data,
> +								int len);
> +
> +/* Trigger functions */
> +int hid_sensor_setup_trigger(struct iio_dev *indio_dev, char *name);
> +void hid_sensor_remove_trigger(struct iio_dev *indio_dev);
> +
>   #endif
> diff --git a/drivers/staging/hid-sensors/hid-sensor-ring.c b/drivers/staging/hid-sensors/hid-sensor-ring.c
> new file mode 100644
> index 0000000..c63ff26
> --- /dev/null
> +++ b/drivers/staging/hid-sensors/hid-sensor-ring.c
> @@ -0,0 +1,104 @@
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
> +#include<linux/interrupt.h>
> +#include<linux/irq.h>
> +#include<linux/mutex.h>
> +#include<linux/device.h>
> +#include<linux/kernel.h>
> +#include<linux/spi/spi.h>
> +#include<linux/slab.h>
> +#include<linux/sysfs.h>
> +
> +#include "iio/iio.h"
> +#include "iio/sysfs.h"
> +#include "iio/ring_sw.h"
> +#include "iio/trigger_consumer.h"
> +#include "iio/trigger.h"
> +
> +static const struct iio_buffer_setup_ops hid_sensors_buffer_setup_ops = {
> +	.preenable =&iio_sw_buffer_preenable,
> +	.postenable =&iio_triggered_buffer_postenable,
> +	.predisable =&iio_triggered_buffer_predisable,
> +};
Not that I've reviews them yet, but a lot of this looks similar to the
patch series Lars-Peter sent out the other day.
[PATCH 0/9] iio: Add helper function for initializing triggered buffers
> +
> +static irqreturn_t hid_sensor_trigger_handler(int irq, void *p)
> +{
> +	return IRQ_HANDLED;
That's novel...
> +}
> +
> +void hid_sensor_push_data_to_ring(struct iio_dev *indio_dev, u8 *data, int len)
> +{
> +	struct iio_buffer *ring = indio_dev->buffer;
> +	s64 timestamp = iio_get_time_ns();
> +	int datum_sz;
> +
> +	if (!ring)
> +		return;
> +	datum_sz = ring->access->get_bytes_per_datum(ring);
> +	if (len>  datum_sz) {
> +		dev_err(&indio_dev->dev, "Datum size mismatch %d:%d\n", len,
> +				datum_sz);
> +		return;
> +	} else if (datum_sz>  0&&  datum_sz != len) {
> +		dev_dbg(&indio_dev->dev, "Updating Datum size%d:%d\n", len,
> +				datum_sz);
> +		if (ring->access->set_bytes_per_datum)
> +			ring->access->set_bytes_per_datum(ring, len);
You don't want to do this (and my gut feeling is it won't work).  Buffer 
size should be set up during the bring up of the buffer not on
an element read.
> +	}
Do a read through and clean up white space.  One blank line is almost 
always enough and certainly is here!
> +
> +
> +	ring->access->store_to(ring, (u8 *)data, timestamp);
> +}
> +
This one maps directly to one of Lars-Peter's suggestions.  As they
say - great minds think alike!
> +int hid_sensor_configure_ring(struct iio_dev *indio_dev)
> +{
> +	struct iio_buffer *ring;
> +	int ret = 0;
> +
> +	ring = iio_sw_rb_allocate(indio_dev);
> +	if (!ring)
> +		return -ENOMEM;
> +
> +	ring->scan_timestamp = true;
> +	indio_dev->buffer = ring;
> +	indio_dev->setup_ops =&hid_sensors_buffer_setup_ops;
> +
> +	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
> +						&hid_sensor_trigger_handler,
> +						 IRQF_ONESHOT,
> +						 indio_dev,
> +						 "hid_sensor%d",
> +						 indio_dev->id);
> +	if (indio_dev->pollfunc == NULL) {
> +		ret = -ENOMEM;
> +		goto error_iio_free;
> +	}
> +
> +	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
> +
> +	return ret;
> +error_iio_free:
> +	iio_sw_rb_free(indio_dev->buffer);
> +	return ret;
> +}
> +
> +void hid_sensor_ring_cleanup(struct iio_dev *indio_dev)
> +{
> +	iio_sw_rb_free(indio_dev->buffer);
> +}
> diff --git a/drivers/staging/hid-sensors/hid-sensor-trigger.c b/drivers/staging/hid-sensors/hid-sensor-trigger.c
> new file mode 100644
> index 0000000..49d8740
> --- /dev/null
> +++ b/drivers/staging/hid-sensors/hid-sensor-trigger.c
> @@ -0,0 +1,81 @@
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
> +#include<linux/device.h>
> +#include<linux/hid.h>
> +#include<linux/usb.h>
> +#include "usbhid/usbhid.h"
> +#include<linux/module.h>
> +#include<linux/slab.h>
> +#include "iio/iio.h"
> +#include "iio/trigger.h"
> +#include "hid-sensor-interface.h"
> +
> +static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
> +						bool state)
> +{
> +	struct iio_dev *indio_dev = trig->private_data;
> +	struct hid_sensor_attributes *st = iio_priv(indio_dev);
> +
again 1 blank line is plenty.  I'm fussy about this one ;)
> +
> +	st->data_ready = state;
> +
> +	return 0;
> +}
> +
> +void hid_sensor_remove_trigger(struct iio_dev *indio_dev)
> +{
Hmm. The need for this check smells bad... I'd expect the driver
to have a higher level knowledge of whether this exists...
> +	if (indio_dev->trig) {
> +		iio_trigger_unregister(indio_dev->trig);
> +		iio_free_trigger(indio_dev->trig);
> +	}
> +}
> +
> +static const struct iio_trigger_ops hid_sensor_trigger_ops = {
> +	.owner = THIS_MODULE,
> +	.set_trigger_state =&hid_sensor_data_rdy_trigger_set_state,
> +};
> +
> +int hid_sensor_setup_trigger(struct iio_dev *indio_dev, char *name)
> +{
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
> +	trig->ops =&hid_sensor_trigger_ops;
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
