From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 2/2] HID: hid-sensor-hub: Add collection device
Date: Thu, 19 Feb 2015 15:54:48 -0800
Message-ID: <1424390088.5172.13.camel@spandruv-mobl2>
References: <1420655051-6587-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1420655051-6587-3-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <54C01FC8.2040501@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54C01FC8.2040501-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: jkosina-AlSwsSmVLrQ@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, 2015-01-21 at 21:53 +0000, Jonathan Cameron wrote:
> On 07/01/15 18:24, Srinivas Pandruvada wrote:
> > HID sensor hub exports several sensor which are fusion sensors, where
> > data is interpreted from one or more sensors. Some of them can't be
> > exported via IIO like sysfs as the user space download some firmware,
> > which defines what sensor will look like. They can be a part of a
> > collection.
> This functionality is beginning to turn up on a number of devices.
> I'd argue that where at all possible, we should try for standard
> interfaces on the resulting 'fused sensors'.  Still you do indeed
> always need a means of uploading the firmware!
I will submitted RFCs, once I see in production releases.

Currently planning to use misc driver for FW update.
What do you think about using dev/iio:deviceX for such case to download
FW for each sensor? We also need mechanism to initiate and reset after
FW download.

Thanks,
Srinivas

> > Creating a MFD cell for a collection to write a standalone driver
> > to manage collections. Most of the time they will be propritery drivers
> > may not be even upstreamed. This patch allows framework to have
> > capability to write such drivers.
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> >
> 
> A few comments inline...
> 
> How does userspace download a firmware?
> 
>  
>  ---
> >  drivers/hid/hid-sensor-hub.c   | 50 ++++++++++++++++++++++++++++++++++++++----
> >  include/linux/hid-sensor-ids.h |  2 ++
> >  2 files changed, 48 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> > index 865cd56..83b6e15 100644
> > --- a/drivers/hid/hid-sensor-hub.c
> > +++ b/drivers/hid/hid-sensor-hub.c
> > @@ -119,11 +119,12 @@ static struct hid_sensor_hub_callbacks *sensor_hub_get_callback(
> >  
> >  	spin_lock_irqsave(&pdata->dyn_callback_lock, flags);
> >  	list_for_each_entry(callback, &pdata->dyn_callback_list, list)
> > -		if (callback->usage_id == usage_id &&
> > +		if (callback->usage_id == HID_USAGE_SENSOR_TYPE_COLLECTION ||
> > +			(callback->usage_id == usage_id &&
> >  			(collection_index >=
> >  				callback->hsdev->start_collection_index) &&
> >  			(collection_index <
> > -				callback->hsdev->end_collection_index)) {
> > +				callback->hsdev->end_collection_index))) {
> >  			*priv = callback->priv;
> >  			*hsdev = callback->hsdev;
> >  			spin_unlock_irqrestore(&pdata->dyn_callback_lock,
> > @@ -159,7 +160,12 @@ int sensor_hub_register_callback(struct hid_sensor_hub_device *hsdev,
> >  	callback->usage_callback = usage_callback;
> >  	callback->usage_id = usage_id;
> >  	callback->priv = NULL;
> > -	list_add_tail(&callback->list, &pdata->dyn_callback_list);
> > +	/* Give higher priority to collection device, so add to front */
> Comment should probably state why we want to give them higher priorities.
> 
> > +	if (usage_id == HID_USAGE_SENSOR_TYPE_COLLECTION)
> > +		list_add(&callback->list, &pdata->dyn_callback_list);
> > +	else
> > +		list_add_tail(&callback->list, &pdata->dyn_callback_list);
> > +
> >  	spin_unlock_irqrestore(&pdata->dyn_callback_lock, flags);
> >  
> >  	return 0;
> > @@ -547,6 +553,37 @@ static __u8 *sensor_hub_report_fixup(struct hid_device *hdev, __u8 *rdesc,
> >  	return rdesc;
> >  }
> >  
> > +static int sensor_hub_add_collection_device(struct hid_device *hdev,
> > +					    struct sensor_hub_data *sd)
> > +{
> > +	struct hid_sensor_hub_device *hsdev;
> > +	char *name;
> > +
> > +	hsdev = devm_kzalloc(&hdev->dev, sizeof(*hsdev), GFP_KERNEL);
> > +	if (!hsdev)
> > +		return -ENOMEM;
> > +
> > +	hsdev->hdev = hdev;
> > +	hsdev->vendor_id = hdev->vendor;
> > +	hsdev->product_id = hdev->product;
> > +	hsdev->usage = HID_USAGE_SENSOR_TYPE_COLLECTION;
> > +	mutex_init(&hsdev->mutex);
> > +	name = devm_kasprintf(&hdev->dev, GFP_KERNEL, "HID-SENSOR-%x",
> > +			      HID_USAGE_SENSOR_TYPE_COLLECTION);
> > +	if (name == NULL) {
> > +		hid_err(hdev, "Failed MFD device name\n");
> > +		return -ENOMEM;
> > +	}
> > +	sd->hid_sensor_hub_client_devs[sd->hid_sensor_client_cnt].name = name;
> > +	sd->hid_sensor_hub_client_devs[
> > +			sd->hid_sensor_client_cnt].platform_data = hsdev;
> Odd breaking up of the line...  Perhaps break before .platform_data instead?
> > +	sd->hid_sensor_hub_client_devs[
> > +			sd->hid_sensor_client_cnt].pdata_size = sizeof(*hsdev);
> > +	sd->hid_sensor_client_cnt++;
> > +
> > +	return 0;
> > +}
> > +
> >  static int sensor_hub_probe(struct hid_device *hdev,
> >  				const struct hid_device_id *id)
> >  {
> > @@ -591,7 +628,8 @@ static int sensor_hub_probe(struct hid_device *hdev,
> >  		ret = -EINVAL;
> >  		goto err_stop_hw;
> >  	}
> > -	sd->hid_sensor_hub_client_devs = devm_kzalloc(&hdev->dev, dev_cnt *
> > +	sd->hid_sensor_hub_client_devs = devm_kzalloc(&hdev->dev,
> > +						      (dev_cnt + 1) *
> >  						      sizeof(struct mfd_cell),
> >  						      GFP_KERNEL);
> >  	if (sd->hid_sensor_hub_client_devs == NULL) {
> > @@ -645,6 +683,10 @@ static int sensor_hub_probe(struct hid_device *hdev,
> >  	if (last_hsdev)
> >  		last_hsdev->end_collection_index = i;
> >  
> > +	ret = sensor_hub_add_collection_device(hdev, sd);
> > +	if (ret)
> > +		goto err_stop_hw;
> > +
> >  	ret = mfd_add_hotplug_devices(&hdev->dev,
> >  			sd->hid_sensor_hub_client_devs,
> >  			sd->hid_sensor_client_cnt);
> > diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
> > index 109f0e6..300ffea 100644
> > --- a/include/linux/hid-sensor-ids.h
> > +++ b/include/linux/hid-sensor-ids.h
> > @@ -21,6 +21,8 @@
> >  
> >  #define HID_MAX_PHY_DEVICES					0xFF
> >  
> > +#define HID_USAGE_SENSOR_TYPE_COLLECTION			0x200001
> > +
> >  /* Accel 3D (200073) */
> >  #define HID_USAGE_SENSOR_ACCEL_3D				0x200073
> >  #define HID_USAGE_SENSOR_DATA_ACCELERATION			0x200452
> > 
> 
