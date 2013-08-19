From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 3/4] hid-sensor-hub: move to devm_kzalloc
Date: Mon, 19 Aug 2013 08:31:08 -0700
Message-ID: <52123A3C.6010404@linux.intel.com>
References: <1376467631-20857-1-git-send-email-andriy.shevchenko@linux.intel.com> <1376467631-20857-3-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:18101 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740Ab3HSPYA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Aug 2013 11:24:00 -0400
In-Reply-To: <1376467631-20857-3-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@intel.com>

On 08/14/2013 01:07 AM, Andy Shevchenko wrote:
> devm_kzalloc() will manage resources freeing and allows to make error path
> smaller and nicer.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/hid/hid-sensor-hub.c | 17 +++++------------
>   1 file changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index d0687d0..4cb19df 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -477,16 +477,15 @@ static int sensor_hub_probe(struct hid_device *hdev,
>   	struct hid_field *field;
>   	int dev_cnt;
>   
> -	sd = kzalloc(sizeof(struct sensor_hub_data), GFP_KERNEL);
> +	sd = devm_kzalloc(&hdev->dev, sizeof(*sd), GFP_KERNEL);
>   	if (!sd) {
>   		hid_err(hdev, "cannot allocate Sensor data\n");
>   		return -ENOMEM;
>   	}
> -	sd->hsdev = kzalloc(sizeof(struct hid_sensor_hub_device), GFP_KERNEL);
> +	sd->hsdev = devm_kzalloc(&hdev->dev, sizeof(*sd->hsdev), GFP_KERNEL);
>   	if (!sd->hsdev) {
>   		hid_err(hdev, "cannot allocate hid_sensor_hub_device\n");
> -		ret = -ENOMEM;
> -		goto err_free_hub;
> +		return -ENOMEM;
>   	}
>   	hid_set_drvdata(hdev, sd);
>   	sd->hsdev->hdev = hdev;
> @@ -498,14 +497,14 @@ static int sensor_hub_probe(struct hid_device *hdev,
>   	ret = hid_parse(hdev);
>   	if (ret) {
>   		hid_err(hdev, "parse failed\n");
> -		goto err_free;
> +		return ret;
>   	}
>   	INIT_LIST_HEAD(&hdev->inputs);
>   
>   	ret = hid_hw_start(hdev, 0);
>   	if (ret) {
>   		hid_err(hdev, "hw start failed\n");
> -		goto err_free;
> +		return ret;
>   	}
>   	ret = hid_hw_open(hdev);
>   	if (ret) {
> @@ -570,10 +569,6 @@ err_close:
>   	hid_hw_close(hdev);
>   err_stop_hw:
>   	hid_hw_stop(hdev);
> -err_free:
> -	kfree(sd->hsdev);
> -err_free_hub:
> -	kfree(sd);
>   
>   	return ret;
>   }
> @@ -597,8 +592,6 @@ static void sensor_hub_remove(struct hid_device *hdev)
>   	kfree(data->hid_sensor_hub_client_devs);
>   	hid_set_drvdata(hdev, NULL);
>   	mutex_destroy(&data->mutex);
> -	kfree(data->hsdev);
> -	kfree(data);
>   }
>   
>   static const struct hid_device_id sensor_hub_devices[] = {
Agreed.

Thanks,
Srinivas
