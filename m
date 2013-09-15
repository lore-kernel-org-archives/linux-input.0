From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] HID RTC: Open sensor hub open close
Date: Sun, 15 Sep 2013 11:18:40 +0100
Message-ID: <52358980.4030000@kernel.org>
References: <1378843432-5113-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1378843432-5113-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1378843432-5113-3-git-send-email-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jc23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

cc'd Alessandro and rtc list as this is within RTC. I'll happilly take
it through IIO given the dependency, but I would like an Ack from the RTC
side.

On 09/10/13 21:03, Srinivas Pandruvada wrote:
> Open sensor hub when module is loaded and close when module is removed.
> This helps saving power by opening HID transport only when there is an
> user.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
