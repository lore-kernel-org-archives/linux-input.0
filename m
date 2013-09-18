From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] HID: Delay opening HID device
Date: Wed, 18 Sep 2013 21:39:58 +0100
Message-ID: <523A0F9E.5080307@kernel.org>
References: <1379524399-16995-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379524399-16995-1-git-send-email-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 09/18/13 18:13, Srinivas Pandruvada wrote:
> Don't call hid_open_device till there is actually an user. This saves
> power by not opening underlying transport for HID. Also close device
> if there are no active mfd client using HID sensor hub.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

All look fine to me.  Ideally I'd like an Ack from Jiri to cover the bit
under drivers/hid/ before taking it through IIO.

Jonathan
> ---
>  drivers/hid/hid-sensor-hub.c   | 45 ++++++++++++++++++++++++++++++++----------
>  include/linux/hid-sensor-hub.h | 18 +++++++++++++++++
>  2 files changed, 53 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index 10e1581..88fc5ae 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -465,6 +465,39 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
>  	return 1;
>  }
>  
> +int sensor_hub_device_open(struct hid_sensor_hub_device *hsdev)
> +{
> +	int ret = 0;
> +	struct sensor_hub_data *data =  hid_get_drvdata(hsdev->hdev);
> +
> +	mutex_lock(&data->mutex);
> +	if (!hsdev->ref_cnt) {
> +		ret = hid_hw_open(hsdev->hdev);
> +		if (ret) {
> +			hid_err(hsdev->hdev, "failed to open hid device\n");
> +			mutex_unlock(&data->mutex);
> +			return ret;
> +		}
> +	}
> +	hsdev->ref_cnt++;
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(sensor_hub_device_open);
> +
> +void sensor_hub_device_close(struct hid_sensor_hub_device *hsdev)
> +{
> +	struct sensor_hub_data *data =  hid_get_drvdata(hsdev->hdev);
> +
> +	mutex_lock(&data->mutex);
> +	hsdev->ref_cnt--;
> +	if (!hsdev->ref_cnt)
> +		hid_hw_close(hsdev->hdev);
> +	mutex_unlock(&data->mutex);
> +}
> +EXPORT_SYMBOL_GPL(sensor_hub_device_close);
> +
>  static int sensor_hub_probe(struct hid_device *hdev,
>  				const struct hid_device_id *id)
>  {
> @@ -506,12 +539,6 @@ static int sensor_hub_probe(struct hid_device *hdev,
>  		hid_err(hdev, "hw start failed\n");
>  		return ret;
>  	}
> -	ret = hid_hw_open(hdev);
> -	if (ret) {
> -		hid_err(hdev, "failed to open input interrupt pipe\n");
> -		goto err_stop_hw;
> -	}
> -
>  	INIT_LIST_HEAD(&sd->dyn_callback_list);
>  	sd->hid_sensor_client_cnt = 0;
>  	report_enum = &hdev->report_enum[HID_INPUT_REPORT];
> @@ -520,7 +547,7 @@ static int sensor_hub_probe(struct hid_device *hdev,
>  	if (dev_cnt > HID_MAX_PHY_DEVICES) {
>  		hid_err(hdev, "Invalid Physical device count\n");
>  		ret = -EINVAL;
> -		goto err_close;
> +		goto err_stop_hw;
>  	}
>  	sd->hid_sensor_hub_client_devs = kzalloc(dev_cnt *
>  						sizeof(struct mfd_cell),
> @@ -528,7 +555,7 @@ static int sensor_hub_probe(struct hid_device *hdev,
>  	if (sd->hid_sensor_hub_client_devs == NULL) {
>  		hid_err(hdev, "Failed to allocate memory for mfd cells\n");
>  			ret = -ENOMEM;
> -			goto err_close;
> +			goto err_stop_hw;
>  	}
>  	list_for_each_entry(report, &report_enum->report_list, list) {
>  		hid_dbg(hdev, "Report id:%x\n", report->id);
> @@ -565,8 +592,6 @@ err_free_names:
>  	for (i = 0; i < sd->hid_sensor_client_cnt ; ++i)
>  		kfree(sd->hid_sensor_hub_client_devs[i].name);
>  	kfree(sd->hid_sensor_hub_client_devs);
> -err_close:
> -	hid_hw_close(hdev);
>  err_stop_hw:
>  	hid_hw_stop(hdev);
>  
> diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
> index 32ba451..a265af2 100644
> --- a/include/linux/hid-sensor-hub.h
> +++ b/include/linux/hid-sensor-hub.h
> @@ -47,11 +47,13 @@ struct hid_sensor_hub_attribute_info {
>   * @hdev:		Stores the hid instance.
>   * @vendor_id:		Vendor id of hub device.
>   * @product_id:		Product id of hub device.
> + * @ref_cnt:		Number of MFD clients have opened this device
>   */
>  struct hid_sensor_hub_device {
>  	struct hid_device *hdev;
>  	u32 vendor_id;
>  	u32 product_id;
> +	int ref_cnt;
>  };
>  
>  /**
> @@ -74,6 +76,22 @@ struct hid_sensor_hub_callbacks {
>  			 void *priv);
>  };
>  
> +/**
> +* sensor_hub_device_open() - Open hub device
> +* @hsdev:	Hub device instance.
> +*
> +* Used to open hid device for sensor hub.
> +*/
> +int sensor_hub_device_open(struct hid_sensor_hub_device *hsdev);
> +
> +/**
> +* sensor_hub_device_clode() - Close hub device
> +* @hsdev:	Hub device instance.
> +*
> +* Used to clode hid device for sensor hub.
> +*/
> +void sensor_hub_device_close(struct hid_sensor_hub_device *hsdev);
> +
>  /* Registration functions */
>  
>  /**
> 
