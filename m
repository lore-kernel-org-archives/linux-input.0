From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v1 2/2] HID: hid-sensor-hub: Add support for application
 collection
Date: Mon, 09 Mar 2015 14:53:03 +0000
Message-ID: <54FDB3CF.5020901@kernel.org>
References: <1424388686-18125-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1424388686-18125-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44003 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932536AbbCIOxG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Mar 2015 10:53:06 -0400
In-Reply-To: <1424388686-18125-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, jkosina@suse.cz
Cc: linux-input@vger.kernel.org

On 19/02/15 23:31, Srinivas Pandruvada wrote:
> Section 4.2.5 of HID Sensor hub specification allows two methods
> defining sensor devices.
> - Each sensor device by its own collection
> - A top level application collection object, including multiple
> sensors.
> In the first method, each sensor can be in its own sensor application
> collection without a physical collection.
> In the second method there is a usage id for collection type, which
> is defined as an application collection, with multiple physical
> collections in it. It is possible to define fusion sensor with this
> and may have its own handler. If there is a callback registered
> for the collection type, then forward all reports for sensors in
> its collection to this handler.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Whilst superficially seems fine to me, this is somewhat out of my
area so I'd rather not give a formal ack / reviewed by.

> ---
>  drivers/hid/hid-sensor-hub.c   | 30 ++++++++++++++++++++++++++----
>  include/linux/hid-sensor-ids.h |  2 ++
>  2 files changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index 865cd56..b855a60 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -86,7 +86,8 @@ static int sensor_hub_get_physical_device_count(struct hid_device *hdev)
>  
>  	for (i = 0; i < hdev->maxcollection; ++i) {
>  		struct hid_collection *collection = &hdev->collection[i];
> -		if (collection->type == HID_COLLECTION_PHYSICAL)
> +		if (collection->type == HID_COLLECTION_PHYSICAL ||
> +		    collection->type == HID_COLLECTION_APPLICATION)
>  			++count;
>  	}
>  
> @@ -119,7 +120,8 @@ static struct hid_sensor_hub_callbacks *sensor_hub_get_callback(
>  
>  	spin_lock_irqsave(&pdata->dyn_callback_lock, flags);
>  	list_for_each_entry(callback, &pdata->dyn_callback_list, list)
> -		if (callback->usage_id == usage_id &&
> +		if ((callback->usage_id == usage_id ||
> +		     callback->usage_id == HID_USAGE_SENSOR_COLLECTION) &&
>  			(collection_index >=
>  				callback->hsdev->start_collection_index) &&
>  			(collection_index <
> @@ -159,7 +161,18 @@ int sensor_hub_register_callback(struct hid_sensor_hub_device *hsdev,
>  	callback->usage_callback = usage_callback;
>  	callback->usage_id = usage_id;
>  	callback->priv = NULL;
> -	list_add_tail(&callback->list, &pdata->dyn_callback_list);
> +	/*
> +	 * If there is a handler registered for the collection type, then
> +	 * it will handle all reports for sensors in this collection. If
> +	 * there is also an individual sensor handler registration, then
> +	 * we want to make sure that the reports are directed to collection
> +	 * handler, as this may be a fusion sensor. So add collection handlers
> +	 * to the beginning of the list, so that they are matched first.
> +	 */
> +	if (usage_id == HID_USAGE_SENSOR_COLLECTION)
> +		list_add(&callback->list, &pdata->dyn_callback_list);
> +	else
> +		list_add_tail(&callback->list, &pdata->dyn_callback_list);
>  	spin_unlock_irqrestore(&pdata->dyn_callback_lock, flags);
>  
>  	return 0;
> @@ -557,6 +570,7 @@ static int sensor_hub_probe(struct hid_device *hdev,
>  	int dev_cnt;
>  	struct hid_sensor_hub_device *hsdev;
>  	struct hid_sensor_hub_device *last_hsdev = NULL;
> +	struct hid_sensor_hub_device *collection_hsdev = NULL;
>  
>  	sd = devm_kzalloc(&hdev->dev, sizeof(*sd), GFP_KERNEL);
>  	if (!sd) {
> @@ -603,7 +617,8 @@ static int sensor_hub_probe(struct hid_device *hdev,
>  	for (i = 0; i < hdev->maxcollection; ++i) {
>  		struct hid_collection *collection = &hdev->collection[i];
>  
> -		if (collection->type == HID_COLLECTION_PHYSICAL) {
> +		if (collection->type == HID_COLLECTION_PHYSICAL ||
> +		    collection->type == HID_COLLECTION_APPLICATION) {
>  
>  			hsdev = devm_kzalloc(&hdev->dev, sizeof(*hsdev),
>  					     GFP_KERNEL);
> @@ -640,10 +655,17 @@ static int sensor_hub_probe(struct hid_device *hdev,
>  			hid_dbg(hdev, "Adding %s:%d\n", name,
>  					hsdev->start_collection_index);
>  			sd->hid_sensor_client_cnt++;
> +			if (collection_hsdev)
> +				collection_hsdev->end_collection_index = i;
> +			if (collection->type == HID_COLLECTION_APPLICATION &&
> +			    collection->usage == HID_USAGE_SENSOR_COLLECTION)
> +				collection_hsdev = hsdev;
>  		}
>  	}
>  	if (last_hsdev)
>  		last_hsdev->end_collection_index = i;
> +	if (collection_hsdev)
> +		collection_hsdev->end_collection_index = i;
>  
>  	ret = mfd_add_hotplug_devices(&hdev->dev,
>  			sd->hid_sensor_hub_client_devs,
> diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
> index 109f0e6..f2ee90a 100644
> --- a/include/linux/hid-sensor-ids.h
> +++ b/include/linux/hid-sensor-ids.h
> @@ -21,6 +21,8 @@
>  
>  #define HID_MAX_PHY_DEVICES					0xFF
>  
> +#define HID_USAGE_SENSOR_COLLECTION				0x200001
> +
>  /* Accel 3D (200073) */
>  #define HID_USAGE_SENSOR_ACCEL_3D				0x200073
>  #define HID_USAGE_SENSOR_DATA_ACCELERATION			0x200452
> 

