From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 3/8] HID-Sensors: Sensor framework
Date: Sun, 08 Jul 2012 19:05:55 +0100
Message-ID: <4FF9CC03.7090905@kernel.org>
References: <1341431532-15060-1-git-send-email-srinivas.pandruvada@intel.com> <1341431532-15060-4-git-send-email-srinivas.pandruvada@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52317 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580Ab2GHSGA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 Jul 2012 14:06:00 -0400
In-Reply-To: <1341431532-15060-4-git-send-email-srinivas.pandruvada@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: srinivas pandruvada <srinivas.pandruvada@intel.com>
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org, jkosina@suse.cz, lars@metafoo.de, jic23@cam.ac.uk

On 07/04/2012 08:52 PM, srinivas pandruvada wrote:
> Adding processing for HID Sensor usage table as defined by
> HID 1.12, Request #: HUTRR39, dated 05 May, 2011.
> This driver uses HID driver framework to register, send and
> receive events.
> This uses MFD framework, so that actual processing for a
> specific usage id can be done in a different driver. For
> example an accelerometer driver can be a separate driver and
> use the interface provided by this driver to register for
> events.
> 
Generally looks pretty good to me.

Various comments inline.
> Signed-off-by: srinivas pandruvada <srinivas.pandruvada@intel.com>
> ---
>  drivers/hid/Kconfig            |   12 +
>  drivers/hid/Makefile           |    1 +
>  drivers/hid/hid-sensor-hub.c   |  630 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/hid-sensor-hub.h |   72 +++++
>  include/linux/hid-sensor-ids.h |  116 ++++++++
>  5 files changed, 831 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/hid/hid-sensor-hub.c
>  create mode 100644 include/linux/hid-sensor-hub.h
>  create mode 100644 include/linux/hid-sensor-ids.h
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 034c80a..1d0d42d 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -660,6 +660,18 @@ config HID_ZYDACRON
>  	---help---
>  	Support for Zydacron remote control.
>  
> +config HID_SENSOR_HUB
> +	tristate "HID Sensors framework support"
> +	depends on USB_HID
> +	select MFD_CORE
> +	default n
> +	-- help---
> +	  Support for HID Sensor framework. This will provide MFD framework for
> +	  adding different sensors, using HID sensor usage table. This defines
> +	  a set of interface functions to register callbacks for events so
> +	  that the events are transferred to user space using either input
> +	  or IIO ineterfaces.
Perhaps make it more explicit that there will be one MFD instance per
'sensor hub / usb device', off which will hang multiple drivers to handle
the different data streams.
> +
>  endmenu
>  
>  endif # HID_SUPPORT
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index ca6cc9f..08f9d8f 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -87,6 +87,7 @@ obj-$(CONFIG_HID_ZYDACRON)	+= hid-zydacron.o
>  obj-$(CONFIG_HID_WACOM)		+= hid-wacom.o
>  obj-$(CONFIG_HID_WALTOP)	+= hid-waltop.o
>  obj-$(CONFIG_HID_WIIMOTE)	+= hid-wiimote.o
> +obj-$(CONFIG_HID_SENSOR_HUB)	+= hid-sensor-hub.o
>  
>  obj-$(CONFIG_USB_HID)		+= usbhid/
>  obj-$(CONFIG_USB_MOUSE)		+= usbhid/
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> new file mode 100644
> index 0000000..4e2c021
> --- /dev/null
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -0,0 +1,630 @@
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
> +#include <linux/hid.h>
> +#include <linux/usb.h>
> +#include "usbhid/usbhid.h"
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/mfd/core.h>
> +#include <linux/list.h>
> +#include <linux/hid-sensor-ids.h>
> +#include <linux/hid-sensor-hub.h>
> +
> +#include "hid-ids.h"
> +
Having had the error of my own ways pointed out many times
I'm anti any arbitary size restrictions like this.
> +#define MAX_HUB_SENSORS	20
To avoid this one I guess the easiest option is to use a list.

> +#define MAX_DRIVER_NAME_SIZE 30
use kasprintf and this is irrelevant unless higher layers care,
but if they do then they should provide this constraint.

> +#define RAW_BUFFER_SIZE	128
Might not be worth making this one flexible...  Is it defined
by the spec, or is it just bigger than anything you've seen yet?

> +#define sensor_hub_in_report(id, dev) sensor_hub_report(id, dev,\
> +							HID_INPUT_REPORT)
I'd break these lines differently for length
#define sensor_hub_in_report(id, dev) \
	sensor_hub_report(id, dev, HID_INPUT_REPORT);
Actually do they add any real value anyway?  I guess it depends on how
often they get used...

> +#define sensor_hub_out_report(id, dev) sensor_hub_report(id, dev,\
> +							HID_OUTPUT_REPORT)
> +#define sensor_hub_feature_report(id, dev) sensor_hub_report(id, dev,\
> +							HID_FEATURE_REPORT)
> +
> +/* Description of in-progress IO operation, used for operations
> + * that trigger response from device */
> +struct sensor_hub_pending {
> +	struct completion ready;
> +	u32 usage_id;
> +	u32 attr_usage_id;
> +	int raw_size;
> +	u8 raw_data[RAW_BUFFER_SIZE];
> +};
> +
I would like to see kerneldoc for this structure. It's
not immediately obvious what they various locks etc are
for, hence documentation here would be good.
> +struct sensor_hub_data {
> +	struct hid_sensor_hub_device *hsdev;
> +	struct mutex mutex;
> +	spinlock_t lock;
> +	struct sensor_hub_pending *pending;
Given there is only (I think) one request ever in flight, would
it be simpler to just embed pending here directly and avoid
the dynamic allocation on each request?

I'm not sure either way on this one.
> +	struct list_head dyn_callback_list;
> +	spinlock_t dyn_lock;
> +	struct mfd_cell hid_sensor_hub_client_devs[MAX_HUB_SENSORS];
> +	int hid_sensor_client_cnt;
> +};
> +
Perhaps document that this corresponds to the interface to a child
of the mfd?
> +struct hid_sensor_hub_callbacks_list {
> +	struct list_head list;
> +	u32 usage_id;
> +	struct hid_sensor_hub_callbacks *usage_callback;

Looking so far only at this patch I'm not entirely sure when
intialized gets set.  Definitely could do with some documentation.
> +	int initialized;
> +	void *priv;
> +};
> +
> +static int sensor_hub_check_for_sensor_page(struct hid_device *hdev)
> +{
> +	int i;
> +	int ret = -EINVAL;
> +
> +	for (i = 0; i < hdev->maxcollection; i++) {
> +		struct hid_collection *col = &hdev->collection[i];
> +		if (col->type == HID_COLLECTION_PHYSICAL &&
> +		   (col->usage & HID_USAGE_PAGE) == HID_UP_SENSOR) {
> +			ret = 0;
> +			break;
> +		}
> +	}
blank line before the return. (It's Sunday evening, I'm allowed to be
petty;)
> +	return ret;
> +}
> +
> +static struct hid_report *sensor_hub_report(int id, struct hid_device *hdev,
> +						int dir)
> +{
> +	struct list_head *feature_report_list =
> +					&hdev->report_enum[dir].report_list;
Only used in one place, I'd just use it directly there.
     list_for_each_entry(report, &hdev->report_enum[dir].report_list,
			 list) {
}


> +	struct hid_report *report = NULL;
why set it to NULL?
> +
> +	list_for_each_entry(report, feature_report_list, list) {
> +		if (report->id == id)
> +			return report;
> +	}
> +	hid_warn(hdev, "No report with id 0x%x found\n", id);
convention puts a blank line here.
> +	return NULL;
> +}
> +
> +static struct hid_sensor_hub_callbacks *sensor_hub_get_callback(
> +					struct hid_device *hdev,
> +					u32 usage_id, void **priv)
> +{
> +	struct hid_sensor_hub_callbacks_list *callback = NULL;
Why set to NULL? (don't think I'm missing a reason for it)
> +	struct sensor_hub_data *pdata = hid_get_drvdata(hdev);
> +
> +
one blank line only please.
> +	spin_lock(&pdata->dyn_lock);
> +	list_for_each_entry(callback, &pdata->dyn_callback_list, list)
> +		if (callback->usage_id == usage_id) {
> +			*priv = callback->priv;
> +			spin_unlock(&pdata->dyn_lock);
> +			return callback->usage_callback;
> +		}
> +	spin_unlock(&pdata->dyn_lock);
blank line here please and everywhere similar.
> +	return NULL;
> +}
> +
> +int sensor_hub_register_callback(struct hid_sensor_hub_device *hsdev,
> +			u32 usage_id,
> +			struct hid_sensor_hub_callbacks *usage_callback)
> +{
> +	struct hid_sensor_hub_callbacks_list *callback;
> +	struct sensor_hub_data *pdata =
> +		(struct sensor_hub_data *)hid_get_drvdata(hsdev->hdev);
Don't need type cast from a void *
> +
> +	spin_lock(&pdata->dyn_lock);
> +	list_for_each_entry(callback, &pdata->dyn_callback_list, list)
> +		if (callback->usage_id == usage_id) {
> +			spin_unlock(&pdata->dyn_lock);
> +			return -EINVAL;
> +		}
> +	callback = kzalloc(sizeof(*callback), GFP_KERNEL);
> +	if (!callback) {
> +		spin_unlock(&pdata->dyn_lock);
> +		return -ENOMEM;
> +	}
> +	callback->usage_callback = usage_callback;
> +	callback->usage_id = usage_id;
> +	callback->priv = NULL;
> +	list_add_tail(&callback->list, &pdata->dyn_callback_list);
> +	spin_unlock(&pdata->dyn_lock);
blank line.
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(sensor_hub_register_callback);
> +
> +int sensor_hub_remove_callback(struct hid_sensor_hub_device *hsdev,
> +				u32 usage_id)
> +{
> +	struct hid_sensor_hub_callbacks_list *callback, *n;
> +	struct sensor_hub_data *pdata =
> +		(struct sensor_hub_data *)hid_get_drvdata(hsdev->hdev);
> +
> +	spin_lock(&pdata->dyn_lock);
you don't need the safe for as you aren't carrying on after deletion
(which is where the list will get messed up otherwise.)
> +	list_for_each_entry_safe(callback, n,
> +				&pdata->dyn_callback_list, list)
> +		if (callback->usage_id == usage_id) {
> +			list_del(&callback->list);
> +			kfree(callback);
> +			break;
> +		}
> +	spin_unlock(&pdata->dyn_lock);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(sensor_hub_remove_callback);
> +
> +int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
> +				u32 field_index, s32 value)
> +{
> +	struct hid_report *report;
> +	struct sensor_hub_data *data =  hid_get_drvdata(hsdev->hdev);
> +	int ret = 0;
> +
> +	if (report_id < 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&data->mutex);
> +	report = sensor_hub_feature_report(report_id, hsdev->hdev);

hmm. Two error conditions with the same path?
if (!report || (field_index >= report->maxfield))
> +	if (!report) {
> +		ret = -EINVAL;
> +		goto done_proc;
> +	}
> +	if (field_index >=  report->maxfield) {
> +		ret = -EINVAL;
> +		goto done_proc;
> +	}
> +	hid_set_field(report->field[field_index], 0, value);
> +	usbhid_submit_report(hsdev->hdev, report, USB_DIR_OUT);
> +	usbhid_wait_io(hsdev->hdev);
> +done_proc:
> +	mutex_unlock(&data->mutex);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(sensor_hub_set_feature);
> +
> +int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
> +				u32 field_index, s32 *value)
> +{
> +	struct hid_report *report;
> +	struct sensor_hub_data *data =  hid_get_drvdata(hsdev->hdev);
> +	int ret = 0;
> +
> +	if (report_id < 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&data->mutex);
> +	report = sensor_hub_feature_report(report_id, hsdev->hdev);
same as above.
> +	if (!report) {
> +		ret = -EINVAL;
> +		goto done_proc;
> +	}
> +	if (field_index >=  report->maxfield) {
> +		ret = -EINVAL;
> +		goto done_proc;
> +	}
> +	usbhid_submit_report(hsdev->hdev, report, USB_DIR_IN);
> +	usbhid_wait_io(hsdev->hdev);
> +	*value = report->field[field_index]->value[0];
> +done_proc:
> +	mutex_unlock(&data->mutex);
one of many blank lines convention would put in before return statements..
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(sensor_hub_get_feature);
> +
only one blank line here please.
> +
> +int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
> +					u32 usage_id,
> +					u32 attr_usage_id, u32 report_id)
> +{
> +	struct sensor_hub_data *data =  hid_get_drvdata(hsdev->hdev);
> +	struct sensor_hub_pending *work;
Now I'm not remotely familiar with usb cacheline requirements etc, but
could you just have..

struct sensor_hub_pending work = {
       .usage_id = usage_id,
       .attr_usage_id = attr_usage_id,
       .raw_size = 0,
};

given this function both creates and frees the structure...
(whatever else goes on inbetween).

As mentioned elsewhere I can't immediately see why you don't
just embed this in sensor_hub_data and avoid the allocation
entirely.

> +	unsigned long flags;
> +	struct hid_report *report;
> +	int ret_val = 0;
> +
> +	if (report_id < 0)
> +		return -EINVAL;
> +
> +	work = kzalloc(sizeof(*work), GFP_KERNEL);
> +	if (!work)
> +		return ret_val;
> +
> +	init_completion(&work->ready);
> +	work->usage_id = usage_id;
> +	work->attr_usage_id = attr_usage_id;
> +	work->raw_size = 0;
> +
> +	mutex_lock(&data->mutex);
> +	spin_lock_irqsave(&data->lock, flags);
> +	data->pending = work;
> +	report = sensor_hub_in_report(report_id, hsdev->hdev);
> +	if (!report)
> +		goto err_free;
> +	usbhid_submit_report(hsdev->hdev, report, USB_DIR_IN);
> +	spin_unlock_irqrestore(&data->lock, flags);
> +	wait_for_completion_interruptible_timeout(&work->ready, HZ*5);
> +	if (work->raw_size)
> +		ret_val = *(u32 *)work->raw_data;
> +
> +err_free:
> +	data->pending = NULL;
> +	mutex_unlock(&data->mutex);
> +
> +	kfree(work);
> +	return ret_val;
> +}
> +EXPORT_SYMBOL_GPL(sensor_hub_input_attr_get_raw_value);
> +
> +int sensor_hub_input_get_attribute_info(struct hid_sensor_hub_device *hsdev,
> +				u8 type,
> +				u32 usage_id,
> +				u32 attr_usage_id,
> +				struct hid_sensor_hub_attribute_info *info)
> +{
> +	int ret = -1;
> +	int i, j;
> +	int collection_index = -1;
> +	struct hid_report *report;
> +	struct hid_field *field;
> +	struct hid_report_enum *report_enum;
> +	struct hid_device *hdev = hsdev->hdev;
> +
> +	/* Initialize with defaults */
> +	info->usage_id = usage_id;
> +	info->attrib_id =  attr_usage_id;
> +	info->report_id = -1;
> +	info->index = -1;
> +	info->units = -1;
> +	info->unit_expo = -1;
> +
> +	for (i = 0; i < hdev->maxcollection; ++i) {
  	       why the temporary variable?
> +		struct hid_collection *collection = &hdev->collection[i];
> +		if (usage_id == collection->usage) {
> +			collection_index = i;
> +			break;
> +		}
> +	}
> +	if (collection_index == -1)
> +		goto err_ret;
> +
> +	report_enum = &hdev->report_enum[type];
> +	list_for_each_entry(report, &report_enum->report_list, list) {
> +		for (i = 0; i < report->maxfield; ++i) {
> +			field = report->field[i];
> +			if (field->physical == usage_id &&
> +				field->logical == attr_usage_id) {
> +				info->index = i;
> +				info->report_id = report->id;
> +				info->units = field->unit;
> +				info->unit_expo = field->unit_exponent;
> +				info->size = field->report_size/8;
> +				ret = 0;
> +			} else {
Perhaps add a few util functions to avoid the massive indentation?
> +				for (j = 0; j < field->maxusage; ++j) {
> +					if (field->usage[j].hid ==
> +					attr_usage_id &&
> +					field->usage[j].collection_index ==
> +					collection_index)  {
> +						info->index = i;
> +						info->report_id = report->id;
> +						info->units = field->unit;
> +						info->unit_expo =
> +							field->unit_exponent;
> +						info->size =
> +							field->report_size/8;
> +						ret = 0;
> +						break;
> +					}
> +				}
> +			}
> +			if (ret == 0)
> +				break;
> +		}
> +	}
> +err_ret:
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(sensor_hub_input_get_attribute_info);
> +
> +#ifdef CONFIG_PM
> +static int sensor_hub_suspend(struct hid_device *hdev, pm_message_t message)
> +{
> +	struct sensor_hub_data *pdata =  hid_get_drvdata(hdev);
> +	struct hid_sensor_hub_callbacks_list *callback;
> +
> +	hid_dbg(hdev, " sensor_hub_suspend\n");
> +	spin_lock(&pdata->dyn_lock);
> +	list_for_each_entry(callback, &pdata->dyn_callback_list, list) {
> +		if (callback->initialized && callback->usage_callback->suspend)
> +			callback->usage_callback->suspend(
> +					pdata->hsdev, callback->priv);
> +	}
> +	spin_unlock(&pdata->dyn_lock);
> +	return 0;
> +}
> +
> +static int sensor_hub_resume(struct hid_device *hdev)
> +{
> +	struct sensor_hub_data *pdata =  hid_get_drvdata(hdev);
> +	struct hid_sensor_hub_callbacks_list *callback;
> +
> +	hid_dbg(hdev, " sensor_hub_resume\n");
> +	spin_lock(&pdata->dyn_lock);
> +	list_for_each_entry(callback, &pdata->dyn_callback_list, list) {
> +		if (callback->initialized && callback->usage_callback->resume)
> +			callback->usage_callback->resume(
> +					pdata->hsdev, callback->priv);
> +	}
> +	spin_unlock(&pdata->dyn_lock);
> +	return 0;
> +}
> +
> +static int sensor_hub_reset_resume(struct hid_device *hdev)
> +{
> +	return 0;
> +}
> +#endif
> +/*
> + * Handle raw report as sent by device
> + */
> +static int sensor_hub_raw_event(struct hid_device *hdev,
> +		struct hid_report *report, u8 *raw_data, int size)
> +{
> +	int i;
> +	u8 *ptr;
> +	int sz;
> +	struct sensor_hub_data *pdata = hid_get_drvdata(hdev);
> +	unsigned long flags;
> +	struct hid_sensor_hub_callbacks *callback = NULL;
> +	struct hid_collection *collection = NULL;
> +	void *priv = NULL;
> +
> +	hid_dbg(hdev, "sensor_hub_raw_event report id:0x%x size:%d type:%d\n",
> +			 report->id, size, report->type);
> +	hid_dbg(hdev, "maxfield:%d\n", report->maxfield);
> +	if (report->type != HID_INPUT_REPORT)
> +		return 1;
> +
> +	ptr = raw_data;
> +	ptr++; /*Skip report id*/
> +
> +	if (!report)
> +		goto err_report;
> +
> +	spin_lock_irqsave(&pdata->lock, flags);
> +
> +	for (i = 0; i < report->maxfield; ++i) {
> +
> +		hid_dbg(hdev, "%d collection_index:%x hid:%x sz:%x\n",
> +				i, report->field[i]->usage->collection_index,
> +				report->field[i]->usage->hid,
> +				report->field[i]->report_size/8);
> +
> +		sz = report->field[i]->report_size/8;
> +		if (pdata->pending && pdata->pending->attr_usage_id ==
> +				report->field[i]->usage->hid) {
> +			hid_dbg(hdev, "data was pending ...\n");
> +			sz = (sz > RAW_BUFFER_SIZE) ? RAW_BUFFER_SIZE : sz;
> +			memcpy(pdata->pending->raw_data, ptr, sz);
> +			pdata->pending->raw_size  = sz;
> +			complete(&pdata->pending->ready);
> +		}
> +		collection = &hdev->collection[
> +				report->field[i]->usage->collection_index];
> +		hid_dbg(hdev, "collection->usage %x\n",
> +					collection->usage);
> +		callback = sensor_hub_get_callback(pdata->hsdev->hdev,
> +						report->field[i]->physical,
> +							&priv);
> +		if (callback && callback->capture_sample) {
> +			if (report->field[i]->logical)
> +				callback->capture_sample(pdata->hsdev,
> +					report->field[i]->logical, sz, ptr,
> +					callback->pdev);
> +			else
> +				callback->capture_sample(pdata->hsdev,
> +					report->field[i]->usage->hid, sz, ptr,
> +					callback->pdev);
> +		}
> +		ptr += sz;
> +	}
> +	if (callback && collection && callback->send_event)
> +		callback->send_event(pdata->hsdev, collection->usage,
> +				callback->pdev);
> +	spin_unlock_irqrestore(&pdata->lock, flags);
> +
> +err_report:
> +	return 1;
> +}
> +
> +static int sensor_hub_probe(struct hid_device *hdev,
> +				const struct hid_device_id *id)
> +{
> +	int ret;
> +	struct sensor_hub_data *sd;
> +	int i;
> +	char *name;
> +	struct hid_report *report;
> +	struct hid_report_enum *report_enum;
> +	struct hid_field *field;
> +
> +	sd = kzalloc(sizeof(struct sensor_hub_data), GFP_KERNEL);
> +	if (!sd) {
> +		hid_err(hdev, "cannot allocate Sensor data\n");
> +		return -ENOMEM;
> +	}
> +	sd->hsdev = kzalloc(sizeof(struct hid_sensor_hub_device), GFP_KERNEL);
> +	if (!sd->hsdev) {
> +		hid_err(hdev, "cannot allocate hid_sensor_hub_device\n");
> +		ret = -ENOMEM;
> +		goto err_free_hub;
> +	}
> +	hid_set_drvdata(hdev, sd);
> +	sd->hsdev->hdev = hdev;
> +	sd->hsdev->vendor_id = hdev->vendor;
> +	sd->hsdev->product_id = hdev->product;
> +	spin_lock_init(&sd->lock);
> +	spin_lock_init(&sd->dyn_lock);
> +	mutex_init(&sd->mutex);
> +	ret = hid_parse(hdev);
> +	if (ret) {
> +		hid_err(hdev, "parse failed\n");
> +		goto err_free;
> +	}
> +	if (sensor_hub_check_for_sensor_page(hdev) < 0) {
> +		hid_err(hdev, "sensor page not found\n");
> +		goto err_free;
> +	}
> +	INIT_LIST_HEAD(&hdev->inputs);
> +
> +	hdev->claimed = HID_CLAIMED_INPUT;
> +	ret = hid_hw_start(hdev, 0);
> +	if (ret) {
> +		hid_err(hdev, "hw start failed\n");
> +		goto err_free;
> +	}
> +	ret = hid_hw_open(hdev);
> +	if (ret) {
> +		hid_err(hdev, "failed to open input interrupt pipe\n");
> +		goto err_stop_hw;
> +	}
> +
> +	INIT_LIST_HEAD(&sd->dyn_callback_list);
> +	sd->hid_sensor_client_cnt = 0;
> +	report_enum = &hdev->report_enum[HID_INPUT_REPORT];
> +	list_for_each_entry(report, &report_enum->report_list, list) {
> +		hid_dbg(hdev, "Report id:%x\n", report->id);
> +		field = report->field[0];
> +		if (report->maxfield && field &&
> +					field->physical) {
> +			name = kmalloc(MAX_DRIVER_NAME_SIZE+1,
> +					GFP_KERNEL);
> +			if (name  == NULL) {
> +				hid_err(hdev,
> +					"Failed MFD device name\n");
> +					ret = -ENOMEM;
> +					goto err_close;
> +			}
> +			snprintf(name, MAX_DRIVER_NAME_SIZE,
> +					"HID-SENSOR-%x",
> +					field->physical);
kasprintf

> +			sd->hid_sensor_hub_client_devs[
> +				sd->hid_sensor_client_cnt].name = name;
> +			sd->hid_sensor_hub_client_devs[
> +				sd->hid_sensor_client_cnt].platform_data =
> +						&sd->hsdev;
> +			sd->hid_sensor_hub_client_devs[
> +				sd->hid_sensor_client_cnt].pdata_size =
> +						sizeof(sd->hsdev);
> +			hid_dbg(hdev, "Adding %s:%x\n", name,
> +					(unsigned int)sd);
> +			sd->hid_sensor_client_cnt++;
> +		}
> +	}
> +	ret = mfd_add_devices(&hdev->dev, 0, sd->hid_sensor_hub_client_devs,
> +		sd->hid_sensor_client_cnt, NULL, 0);
> +	if (ret < 0) {
would rather see this under an additional goto than here.
> +		for (i = 0; i < sd->hid_sensor_client_cnt ; ++i)
> +			kfree(sd->hid_sensor_hub_client_devs[i].name);
> +		goto err_close;
> +	}
> +
> +	return ret;
> +
> +err_close:
> +	hid_hw_stop(hdev);
> +	hid_hw_close(hdev);
> +err_stop_hw:
> +	hid_hw_stop(hdev);
> +err_free:
> +	kfree(sd->hsdev);
> +err_free_hub:
> +	kfree(sd);
> +
> +	return ret;
> +}
> +
> +static void sensor_hub_remove(struct hid_device *hdev)
> +{
> +	struct sensor_hub_data *data = hid_get_drvdata(hdev);
> +	unsigned long flags;
> +	int i;
> +
> +	hid_dbg(hdev, " hardware removed\n");
> +	hdev->claimed &= ~HID_CLAIMED_INPUT;
> +	hid_hw_stop(hdev);
> +	hid_hw_close(hdev);
> +	spin_lock_irqsave(&data->lock, flags);
> +	if (data->pending)
> +		complete(&data->pending->ready);
> +	spin_unlock_irqrestore(&data->lock, flags);
> +	mfd_remove_devices(&hdev->dev);
> +	for (i = 0; i < data->hid_sensor_client_cnt ; ++i)
> +		kfree(data->hid_sensor_hub_client_devs[i].name);
> +	hid_set_drvdata(hdev, NULL);
> +	mutex_destroy(&data->mutex);
> +	kfree(data->hsdev);
> +	kfree(data);
> +}
> +
> +static const struct hid_device_id sensor_hub_devices[] = {
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_INTEL_8086,
> +			USB_DEVICE_ID_SENSOR_HUB_1020) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_INTEL_8087,
> +			USB_DEVICE_ID_SENSOR_HUB_1020) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_INTEL_8086,
> +			USB_DEVICE_ID_SENSOR_HUB_09FA) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_INTEL_8087,
> +			USB_DEVICE_ID_SENSOR_HUB_09FA) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STANTUM_STM,
> +			USB_DEVICE_ID_SENSOR_HUB_7014) },
> +	{ }
> +};
> +
> +static const struct hid_usage_id sensor_hub_grabbed_usages[] = {
> +	{ HID_ANY_ID, HID_ANY_ID, HID_ANY_ID },
> +	{ HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1 }
> +};
> +
> +static struct hid_driver sensor_hub_driver = {
> +	.name = "hid-sensor-hub",
> +	.id_table = sensor_hub_devices,
> +	.probe = sensor_hub_probe,
> +	.remove = sensor_hub_remove,
> +	.raw_event = sensor_hub_raw_event,
> +#ifdef CONFIG_PM
> +	.suspend = sensor_hub_suspend,
> +	.resume =  sensor_hub_resume,
> +	.reset_resume =  sensor_hub_reset_resume,
> +#endif
> +};
> +
> +static int __init sensor_hub_init(void)
> +{
> +	return hid_register_driver(&sensor_hub_driver);
> +}
> +
> +static void __exit sensor_hub_exit(void)
> +{
> +	hid_unregister_driver(&sensor_hub_driver);
> +}
> +
Hid looks in need of a variant on module_i2c_driver etc.

> +module_init(sensor_hub_init);
> +module_exit(sensor_hub_exit);
> +
> +MODULE_DESCRIPTION("HID Sensor Hub driver");
> +MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@intel.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
> new file mode 100644
> index 0000000..b63fe85
> --- /dev/null
> +++ b/include/linux/hid-sensor-hub.h
> @@ -0,0 +1,72 @@
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
> +#ifndef _HID_SENSORS_HUB_H
> +#define _HID_SENSORS_HUB_H
> +
> +#include <linux/hid.h>
> +#include <linux/hid-sensor-ids.h>
> +
kernel-doc for all these structures please.
Actually whole file could do with more docs.

> +struct hid_sensor_hub_attribute_info {
> +	u32 usage_id;
> +	u32 attrib_id;
> +	s32 report_id;
> +	s32 index;
> +	s32 units;
> +	s32 unit_expo;
> +	s32 size;
> +};
> +
> +struct hid_sensor_hub_device {
> +	struct hid_device *hdev;
> +	u32 vendor_id;
> +	u32 product_id;
> +};
> +
one blank line only probably.
> +
> +struct hid_sensor_hub_callbacks {
> +	struct platform_device *pdev;
> +	int (*suspend)(struct hid_sensor_hub_device *hsdev, void *priv);
> +	int (*resume)(struct hid_sensor_hub_device *hsdev, void *priv);
> +	int (*capture_sample)(struct hid_sensor_hub_device *hsdev,
> +			u32 usage_id, size_t raw_len, char *raw_data,
> +			void *priv);
> +	int (*send_event)(struct hid_sensor_hub_device *hsdev, u32 usage_id,
> +			 void *priv);
> +};
> +
> +/* Registeration functions */
> +int sensor_hub_register_callback(struct hid_sensor_hub_device *hsdev,
> +			u32 usage_id,
> +			struct hid_sensor_hub_callbacks *usage_callback);
> +int sensor_hub_remove_callback(struct hid_sensor_hub_device *hsdev,
> +			u32 usage_id);
> +
> +/* Hid sensor hub core interfaces */
> +int sensor_hub_input_get_attribute_info(struct hid_sensor_hub_device *hsdev,
> +			u8 type,
> +			u32 usage_id, u32 attr_usage_id,
> +			struct hid_sensor_hub_attribute_info *info);
> +int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
> +			u32 usage_id,
> +			u32 attr_usage_id, u32 report_id);
> +int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
> +			u32 field_index, s32 value);
> +int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
> +			u32 field_index, s32 *value);
> +#endif
> diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
> new file mode 100644
> index 0000000..34cc779
> --- /dev/null
> +++ b/include/linux/hid-sensor-ids.h
> @@ -0,0 +1,116 @@
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
> +#ifndef _HID_SENSORS_IDS_H
> +#define _HID_SENSORS_IDS_H
> +
Some of these defines are really really long.  I'd normally
be in favour of nice clear naming, but these are going to
get really unweildy.  Is there any clear structure to them?

i.e. can we build them up from smaller parts?

Otherwise, obvious abreivations such as ORIENTATION -> ORIENT and
ANGULAR_VELOCITY -> ANG_VEL shouldn't loose too much detail.

> +#define HID_UP_SENSOR		0x00200000
> +#define HID_SENSOR_POLLING      0x0020030E
> +#define HID_SENSOR_REPORT_STATE 0x00200316
> +#define HID_SENSOR_POWER_STATE  0x00200319
> +
> +
> +/* Accel 3D (200073) */
> +#define HID_USAGE_SENSOR_ACCEL_3D				0x200073
> +#define HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_X_AXIS	0x200453
> +#define HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_Y_AXIS	0x200454
> +#define HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_Z_AXIS	0x200455
> +
> +/* ALS (200041) */
> +#define HID_USAGE_SENSOR_ALS				        0x200041
> +#define HID_USAGE_SENSOR_DATA_LIGHT_ILLUMINANCE			0x2004d1
> +
> +/* Compass 3D: (200083) */
> +
> +/* Gyro 3D: (200076) */
> +#define HID_USAGE_SENSOR_GYRO_3D				0x200076
> +#define HID_USAGE_SENSOR_DATA_MOTION_ANGULAR_VELOCITY_X_AXIS	0x200457
> +#define HID_USAGE_SENSOR_DATA_MOTION_ANGULAR_VELOCITY_Y_AXIS	0x200458
> +#define HID_USAGE_SENSOR_DATA_MOTION_ANGULAR_VELOCITY_Z_AXIS	0x200459
> +
> +/*ORIENTATION: Compass 3D: (200083) */
> +#define HID_USAGE_SENSOR_COMPASS_3D				0x200083
> +#define HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_HEADING	0x200471
> +#define HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_HEADING_X	0x200472
> +#define HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_HEADING_Y	0x200473
> +#define HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_HEADING_Z	0x200474
> +
> +#define HID_USAGE_SENSOR_DATA_ORIENTATION_COMPENSATED_MAGNETIC_NORTH 0x200475
> +#define HID_USAGE_SENSOR_DATA_ORIENTATION_COMPENSATED_TRUE_NORTH 0x200476
> +#define HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_NORTH	0x200477
> +#define HID_USAGE_SENSOR_DATA_ORIENTATION_TRUE_NORTH		0x200478
> +
> +#define HID_USAGE_SENSOR_DATA_ORIENTATION_DISTANCE		0x200479
> +#define HID_USAGE_SENSOR_DATA_ORIENTATION_DISTANCE_X		0x20047A
> +#define HID_USAGE_SENSOR_DATA_ORIENTATION_DISTANCE_Y		0x20047B
> +#define HID_USAGE_SENSOR_DATA_ORIENTATION_DISTANCE_Z		0x20047C
> +#define HID_USAGE_SENSOR_DATA_ORIENTATION_DISTANCE_OUT_OF_RANGE 0x20047D
> +#define HID_USAGE_SENSOR_DATA_ORIENTATION_TILT			0x20047E
> +#define HID_USAGE_SENSOR_DATA_ORIENTATION_TILT_X		0x20047F
> +#define HID_USAGE_SENSOR_DATA_ORIENTATION_TILT_Y		0x200480
> +#define HID_USAGE_SENSOR_DATA_ORIENTATION_TILT_Z		0x200481
> +#define HID_USAGE_SENSOR_DATA_ORIENTATION_ROTATION_MATRIX	0x200482
> +#define HID_USAGE_SENSOR_DATA_ORIENTATION_QUATERNION		0x200483
> +#define HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX		0x200484
> +
> +#define HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_X_AXIS	0x200485
> +#define HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_Y_AXIS	0x200486
> +#define HID_USAGE_SENSOR_DATA_ORIENTATION_MAGNETIC_FLUX_Z_AXIS	0x200487
> +
> +/* Units */
> +#define HID_USAGE_SENSOR_UNITS_NOT_SPECIFIED			0x00
> +#define HID_USAGE_SENSOR_UNITS_LUX				0x01
> +#define HID_USAGE_SENSOR_UNITS_KELVIN				0x01000100
> +#define HID_USAGE_SENSOR_UNITS_FAHRENHEIT			0x03000100
> +#define HID_USAGE_SENSOR_UNITS_PASCAL				0xF1E1
> +#define HID_USAGE_SENSOR_UNITS_NEWTON				0x11E1
> +#define HID_USAGE_SENSOR_UNITS_METERS_PER_SECOND		0x11F0
> +#define HID_USAGE_SENSOR_UNITS_METERS_PER_SEC_SQRD		0x11E0
> +#define HID_USAGE_SENSOR_UNITS_FARAD				0xE14F2000
> +#define HID_USAGE_SENSOR_UNITS_AMPERE				0x01001000
> +#define HID_USAGE_SENSOR_UNITS_WATT				0x21d1
> +#define HID_USAGE_SENSOR_UNITS_HENRY				0x21E1E000
> +#define HID_USAGE_SENSOR_UNITS_OHM				0x21D1E000
> +#define HID_USAGE_SENSOR_UNITS_VOLT				0x21D1F000
> +#define HID_USAGE_SENSOR_UNITS_HERTZ				0x01F0
> +#define HID_USAGE_SENSOR_UNITS_DEGREES_PER_SEC_SQRD		0x14E0
> +#define HID_USAGE_SENSOR_UNITS_RADIANS				0x12
> +#define HID_USAGE_SENSOR_UNITS_RADIANS_PER_SECOND		0x12F0
> +#define HID_USAGE_SENSOR_UNITS_RADIANS_PER_SEC_SQRD		0x12E0
> +#define HID_USAGE_SENSOR_UNITS_SECOND				0x0110
> +#define HID_USAGE_SENSOR_UNITS_GAUSS				0x01E1F000
> +#define HID_USAGE_SENSOR_UNITS_GRAM				0x0101
> +#define HID_USAGE_SENSOR_UNITS_CENTIMETER			0x11
> +#define HID_USAGE_SENSOR_UNITS_G				0x1A
> +#define HID_USAGE_SENSOR_UNITS_MILLISECOND			0x19
> +#define HID_USAGE_SENSOR_UNITS_PERCENT				0x17
> +#define HID_USAGE_SENSOR_UNITS_DEGREES				0x14
> +#define HID_USAGE_SENSOR_UNITS_DEGREES_PER_SECOND		0x15
> +
> +/* Common selectors */
> +#define HID_USAGE_SENSOR_PROPERTY_REPORT_INTERVAL		0x20030E
> +#define HID_USAGE_SENSOR_PROPERTY_CHANGE_SENSITIVITY_ABS	0x20030F
> +#define HID_USAGE_SENSOR_PROPERTY_CHANGE_SENSITIVITY_RANGE_PCT	0x200310
> +#define HID_USAGE_SENSOR_PROPERTY_CHANGE_SENSITIVITY_REL_PCT	0x200311
> +#define HID_USAGE_SENSOR_PROPERTY_ACCURACY			0x200312
> +#define HID_USAGE_SENSOR_PROPERTY_RESOLUTION			0x200313
> +#define HID_USAGE_SENSOR_PROPERTY_RANGE_MAXIMUM			0x200314
> +#define HID_USAGE_SENSOR_PROPERTY_RANGE_MINIMUM			0x200315
> +#define HID_USAGE_SENSOR_PROPERTY_REPORTING_STATE		0x200316
> +
> +#endif
> 


