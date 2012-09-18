From: Przemo Firszt <przemo@firszt.eu>
Subject: Re: [PATCH v2] HID: wacom: Fix wacom_probe error handling
Date: Tue, 18 Sep 2012 23:09:06 +0100
Message-ID: <1348006146.1991.1.camel@localhost>
References: <1347872034.7737.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wren.arvixe.com ([50.97.138.99]:48555 "EHLO wren.arvixe.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755351Ab2IRWJL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Sep 2012 18:09:11 -0400
In-Reply-To: <1347872034.7737.4.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pingc@wacom.com>, linux-input@vger.kernel.org

On Mon, 2012-09-17 at 16:53 +0800, Axel Lin wrote:
> OLEDs/LED are not critical for tablet functioning thus ignore OLED/LED
> initialisation failures.
> 
> This patch does clean up all the sysfs attribute files in error paths.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  drivers/hid/hid-wacom.c |   23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
> index a0fafac..2f60da9 100644
> --- a/drivers/hid/hid-wacom.c
> +++ b/drivers/hid/hid-wacom.c
> @@ -858,11 +858,9 @@ OLED_INIT(7);
>  	if (hdev->product == USB_DEVICE_ID_WACOM_INTUOS4_BLUETOOTH) {
>  		sprintf(hdev->name, "%s", "Wacom Intuos4 WL");
>  		ret = wacom_initialize_leds(hdev);
> -		if (ret) {
> +		if (ret)
>  			hid_warn(hdev,
>  				 "can't create led attribute, err: %d\n", ret);
> -			goto destroy_leds;
> -		}
>  	}
>  
>  	wdata->battery.properties = wacom_battery_props;
> @@ -875,8 +873,8 @@ OLED_INIT(7);
>  
>  	ret = power_supply_register(&hdev->dev, &wdata->battery);
>  	if (ret) {
> -		hid_warn(hdev, "can't create sysfs battery attribute, err: %d\n",
> -			 ret);
> +		hid_err(hdev, "can't create sysfs battery attribute, err: %d\n",
> +			ret);
>  		goto err_battery;
>  	}
>  
> @@ -891,8 +889,8 @@ OLED_INIT(7);
>  
>  	ret = power_supply_register(&hdev->dev, &wdata->ac);
>  	if (ret) {
> -		hid_warn(hdev,
> -			 "can't create ac battery attribute, err: %d\n", ret);
> +		hid_err(hdev,
> +			"can't create ac battery attribute, err: %d\n", ret);
>  		goto err_ac;
>  	}
>  
> @@ -902,10 +900,17 @@ OLED_INIT(7);
>  err_ac:
>  	power_supply_unregister(&wdata->battery);
>  err_battery:
> +	wacom_destroy_leds(hdev);
> +	device_remove_file(&hdev->dev, &dev_attr_oled0_img);
> +	device_remove_file(&hdev->dev, &dev_attr_oled1_img);
> +	device_remove_file(&hdev->dev, &dev_attr_oled2_img);
> +	device_remove_file(&hdev->dev, &dev_attr_oled3_img);
> +	device_remove_file(&hdev->dev, &dev_attr_oled4_img);
> +	device_remove_file(&hdev->dev, &dev_attr_oled5_img);
> +	device_remove_file(&hdev->dev, &dev_attr_oled6_img);
> +	device_remove_file(&hdev->dev, &dev_attr_oled7_img);
>  	device_remove_file(&hdev->dev, &dev_attr_speed);
>  	hid_hw_stop(hdev);
> -destroy_leds:
> -	wacom_destroy_leds(hdev);
>  err_free:
>  	kfree(wdata);
>  	return ret;

Tested-by: Przemo Firszt <przemo@firszt.eu>

