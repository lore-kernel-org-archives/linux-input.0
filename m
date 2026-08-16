Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E316233924;
	Sun, 16 Aug 2026 01:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786844366; cv=none; b=Xr1GnHxna56RFizSHW3HUC2xXnFQo6GNVTlJc+ogSDeDGpA98ADOb4rBQJOkN6yj6CrtaYhzoJvgRNYZOk9lSUWzeO4L5q95F0WHPa/lBASO6OCi9tZgiGuV5Tb9r44LagItVXmzu4ZXJ7gpXdYdAkAkoyjUXDjlW9hYr50yEPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786844366; c=relaxed/simple;
	bh=yasEtMOQDRd1MO6pog8BpYbUVCx3kCfg4E07jTRJNnA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Te9Udx3xPRD6XOXrRRCjGG5psgyOitj0w6eYw7MDw5wvAcSIKJY0vGFnkWhmFdPiWekXdri5OvRhwXPdOTTs+Ut/H1yOWA19jayk0HPFHrXcPshLq8mo8jLK7WIpJ+lZxFTbEygsu4GCb6dDHnUKegJmWc/Q0WxSa3Lt7k/IrMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnbZYCuv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnbZYCuv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00261F000E9;
	Sun, 16 Aug 2026 01:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786844365;
	bh=7ihNTARtHlqc+z4pKIV5HWt8HMTpwV9bggvrjwDrVxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fnbZYCuvrJ1pXkSGzod33tmgZIr+x33h4QX9ysDIm4K4U7n5/xpvJcuIbYKCAFt94
	 fvrXhRy5BcybH+hw2SAW/jO+yqo05elX6QtNqRV84TJdTZqvivrO+UHz+NfwX3e0Bv
	 8VUMmgdFqj3ClQyQQctqhu3mI9JYaCrS5Np/yeTqwC4rIDJfj1TKpx0q7H9ccSzsmT
	 Wz6joCwZHKrzlHEZP2UfGtIWl1LUR6XuVfMoMhKlaafEkK865aXgwYHrEYpN7YA//f
	 t//Mdk9b9qaDEUQ0rCwEsBjCd2zES3dTlXTkJJypOgubXmIc2E3vDczCgYyigL8xwS
	 pFt1oiy+2O1Gg==
Date: Sun, 16 Aug 2026 02:39:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda via B4 Relay
 <devnull+sanjayembeddedse.gmail.com@kernel.org>
Cc: sanjayembeddedse@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Benjamin Tissoires
 <bentiss@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v5 06/13] iio: humidity: hid-sensor-humidity: convert
 probe and teardown to devm-managed resources
Message-ID: <20260816023920.04f8c3bb@jic23-huawei>
In-Reply-To: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-6-f1f92c1d830f@gmail.com>
References: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-0-f1f92c1d830f@gmail.com>
	<20260806-28-apr-iio-redundant-argument-v5-temp-v5-6-f1f92c1d830f@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 06 Aug 2026 17:55:52 +0530
Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Convert HID IIO driver resource management to use devm-managed helpers,
> tying the lifetime of all resources to the device.
> 
> HID trigger setup, IIO registration, and sensor hub callback resource
> are now managed using devm APIs. Cleanup logic previously handled
> explicitly in probe error and teardown paths.
> 
> This simplifies the probe path by removing goto-based error handling,
> eliminates the remove callback entirely.
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
A passing comment inline.

> ---
> changes in v5:
> - Fully convert driver to devm usage, dropped Tested-by tag
> changes in v4:
> - No update in change, added Tested-by tag
> changes in v3:
> - Update commit message based on review comment from Andy
> - Based on discussion using parent device of HID platform driver used
>   with devres framework for this driver
> - v2 link -> https://lore.kernel.org/all/20260429175918.2541914-5-sanjayembedded@gmail.com/
> ---
>  drivers/iio/humidity/hid-sensor-humidity.c | 38 +++++++-----------------------
>  1 file changed, 8 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
> index 89daf9d534d1..12c88efe66be 100644
> --- a/drivers/iio/humidity/hid-sensor-humidity.c
> +++ b/drivers/iio/humidity/hid-sensor-humidity.c
> @@ -192,11 +192,12 @@ static struct hid_sensor_hub_callbacks humidity_callbacks = {
>  /* Function to initialize the processing for usage id */
>  static int hid_humidity_probe(struct platform_device *pdev)
>  {
> +	struct device *dev = &pdev->dev;
> +	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
>  	static const char *name = "humidity";
>  	struct iio_dev *indio_dev;
>  	struct hid_humidity_state *humid_st;
>  	struct iio_chan_spec *humid_chans;
> -	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*humid_st));
> @@ -233,42 +234,20 @@ static int hid_humidity_probe(struct platform_device *pdev)
>  
>  	atomic_set(&humid_st->common_attributes.data_ready, 0);
>  
> -	ret = hid_sensor_setup_trigger(indio_dev, name,
> -				       &humid_st->common_attributes);
> +	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
> +					    &humid_st->common_attributes);
>  	if (ret)
>  		return ret;
>  
>  	platform_set_drvdata(pdev, indio_dev);
>  
>  	humidity_callbacks.pdev = pdev;
> -	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY,
> -					   &humidity_callbacks);
> +	ret = devm_sensor_hub_register_callback(dev, hsdev, HID_USAGE_SENSOR_HUMIDITY,
> +						&humidity_callbacks);
>  	if (ret)
> -		goto error_remove_trigger;
> -
> -	ret = iio_device_register(indio_dev);
> -	if (ret)
> -		goto error_remove_callback;
> -
> -	return ret;
> -
> -error_remove_callback:
> -	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY);
> -error_remove_trigger:
> -	hid_sensor_remove_trigger(&humid_st->common_attributes);
> -	return ret;
> -}
> -
> -/* Function to deinitialize the processing for usage id */
> -static void hid_humidity_remove(struct platform_device *pdev)
> -{
> -	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
> -	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> -	struct hid_humidity_state *humid_st = iio_priv(indio_dev);
> +		return ret;
This made me wonder what was different as we didn't have a random
ret on it's own in the other patch.  Seems we have inconsistency
across the drivers on what we print on and what we don't.

If you do cleanup up the error prints either in this series
or a follow up, nice to make them consistent - either adding
messages or dropping them may make sense - I haven't thought much
about it!

Jonathan

>  
> -	iio_device_unregister(indio_dev);
> -	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY);
> -	hid_sensor_remove_trigger(&humid_st->common_attributes);
> +	return devm_iio_device_register(dev, indio_dev);
>  }
>  
>  static const struct platform_device_id hid_humidity_ids[] = {
> @@ -287,7 +266,6 @@ static struct platform_driver hid_humidity_platform_driver = {
>  		.pm	= &hid_sensor_pm_ops,
>  	},
>  	.probe		= hid_humidity_probe,
> -	.remove		= hid_humidity_remove,
>  };
>  module_platform_driver(hid_humidity_platform_driver);
>  
> 

