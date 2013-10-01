From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] HID RTC: Open sensor hub open close
Date: Tue, 01 Oct 2013 09:42:52 +0100
Message-ID: <524A8B0C.3040009@kernel.org>
References: <1379524399-16995-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1379524399-16995-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379524399-16995-3-git-send-email-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jkosina-AlSwsSmVLrQ@public.gmane.org, holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 09/18/13 18:13, Srinivas Pandruvada wrote:
> Open sensor hub when module is loaded and close when module is removed.
> This helps saving power by opening HID transport only when there is an
> user.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Acked-by: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>
Hi,

It looks like there has been a fair bit of reorganising going on in this driver
that is making this a little fiddly to merge.

Could you send me an updated patch against what is currently in the togreg
branch of iio.git.  As we haven't touched this recently, that should be
the same as mainline.

Jonathan

> ---
>  drivers/rtc/rtc-hid-sensor-time.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-hid-sensor-time.c b/drivers/rtc/rtc-hid-sensor-time.c
> index 7273b01..1fe170c 100644
> --- a/drivers/rtc/rtc-hid-sensor-time.c
> +++ b/drivers/rtc/rtc-hid-sensor-time.c
> @@ -279,15 +279,28 @@ static int hid_time_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	ret = sensor_hub_device_open(hsdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to open sensor hub device!\n");
> +		goto err_open;
> +	}
> +
>  	time_state->rtc = devm_rtc_device_register(&pdev->dev,
>  					"hid-sensor-time", &hid_time_rtc_ops,
>  					THIS_MODULE);
>  
>  	if (IS_ERR(time_state->rtc)) {
>  		dev_err(&pdev->dev, "rtc device register failed!\n");
> -		return PTR_ERR(time_state->rtc);
> +		ret = PTR_ERR(time_state->rtc);
> +		goto err_rtc;
>  	}
>  
> +	return 0;
> +
> +err_rtc:
> +	sensor_hub_device_close(hsdev);
> +err_open:
> +	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_TIME);
>  	return ret;
>  }
>  
> @@ -295,6 +308,7 @@ static int hid_time_remove(struct platform_device *pdev)
>  {
>  	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
>  
> +	sensor_hub_device_close(hsdev);
>  	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_TIME);
>  
>  	return 0;
> 
