Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADE9222590;
	Sun, 16 Aug 2026 01:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786844200; cv=none; b=FsSDYzFe+4/ynDGxheGydMyGLCirreZZzKAJxmHMzrrE5s59H8dz8eVDsb8//lKIDF8ZgFvRpMYcpuxEzlkQ/Ct7baf8PKgmcDNedT8hRfJ/JHPdWeBR2Dt9f6dgw021ik/aCGFrsZZuixt2adW9QfMFCzSYNuEfEw96EBW0WQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786844200; c=relaxed/simple;
	bh=JCxotqvRpb6xUsqJndfEXmXxLgp5Us72BLyVEVMFV34=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSlpQkfiS2172AMefiVvMQf0i+v4hzlY1jfX3Y/l5fOhP1nsn7f5tTT8MgFIUCY7gLziNN6vrnU3ZqPZn+gvpNd/+xajOkmmJyNj/WnLWFlD8Lez1xBSdACyYFW5a+vwTrbisIZdlCQHmYN/N1fkSE+7Q9xrVeu+NIu6+7eWdkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6bnN0zJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6bnN0zJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBCA1F000E9;
	Sun, 16 Aug 2026 01:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786844199;
	bh=yzi0JJu1u9yb/XHs0OD6pXTCXG/3c+vyM8r5zwGN/8s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=W6bnN0zJOKShrvL1N0paL99p2ySNeCTCdkRySsGo73AdOxO3Q9k8LBe8gTB4W03jD
	 Y+jDG+iGrfEQYQ0AEIPlgbhrcx93me/Ea8hnJHAoOR2Wtk6j/bEpzOW4UtcNIT+Huc
	 gQ77PeigseFFk/G023PcL/3m7nq1C7m8fTYBpRhpM+WTsK2XvAvpVQvh7A1cUbzECe
	 Juylv0VtonF7boUgz5kQSArLKivkJgZodVNB7ambc3yXbNK2KrF3AwSe5FXdt8LnRK
	 wb7p4HUH/WNHjdFp5oqrVeisZawJjxF1JPzw4cfL71m0qoeTaNSJRZiURJb6KijKq3
	 8tnEKNILh54DQ==
Date: Sun, 16 Aug 2026 02:36:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda via B4 Relay
 <devnull+sanjayembeddedse.gmail.com@kernel.org>
Cc: sanjayembeddedse@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Benjamin Tissoires
 <bentiss@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v5 04/13] iio: gyro: hid-sensor-gyro-3d: convert probe
 and teardown to devm-managed resources
Message-ID: <20260816023634.37e4d859@jic23-huawei>
In-Reply-To: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-4-f1f92c1d830f@gmail.com>
References: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-0-f1f92c1d830f@gmail.com>
	<20260806-28-apr-iio-redundant-argument-v5-temp-v5-4-f1f92c1d830f@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 06 Aug 2026 17:55:50 +0530
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
> ---
>  drivers/iio/gyro/hid-sensor-gyro-3d.c | 41 ++++++++---------------------------

Nice stats - could be even better with some error printing cleanups though.
See below.  I appreciate you may not want to do that in this series, but
it's simple enough I wouldn't mind, even though lots of patches result.

>  1 file changed, 9 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> index cf049700d415..66778315e86d 100644
> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> @@ -264,7 +264,8 @@ static int gyro_3d_parse_report(struct platform_device *pdev,
>  /* Function to initialize the processing for usage id */
>  static int hid_gyro_3d_probe(struct platform_device *pdev)
>  {
> -	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
> +	struct device *dev = &pdev->dev;
> +	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
>  	int ret = 0;
>  	static const char *name = "gyro_3d";
>  	struct iio_dev *indio_dev;
> @@ -311,8 +312,8 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
>  
>  	atomic_set(&gyro_state->common_attributes.data_ready, 0);
>  
> -	ret = hid_sensor_setup_trigger(indio_dev, name,
> -				       &gyro_state->common_attributes);
> +	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
> +					    &gyro_state->common_attributes);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "trigger setup failed\n");

>  		return ret;
> @@ -321,38 +322,15 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
>  	gyro_state->callbacks.send_event = gyro_3d_proc_event;
>  	gyro_state->callbacks.capture_sample = gyro_3d_capture_sample;
>  	gyro_state->callbacks.pdev = pdev;
> -	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D,
> -					   &gyro_state->callbacks);
> +	ret = devm_sensor_hub_register_callback(dev, hsdev,
> +						HID_USAGE_SENSOR_GYRO_3D,
> +						&gyro_state->callbacks);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "callback reg failed\n");
Obviously makes for a larger patch set but error print cleaning up would
be nice.  This patch makes that easier to do as enables
return dev_err_probe() in a few places where we didn't have direct returns before.

There are also some prints in here that should be dropped (memory
allocation failures etc).

Jonathan

> -		goto error_remove_trigger;
> -	}
> -	iio_device_unregister(indio_dev);
> -	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
> -	hid_sensor_remove_trigger(&gyro_state->common_attributes);
> +	return devm_iio_device_register(dev, indio_dev);
>  }
>  
>  static const struct platform_device_id hid_gyro_3d_ids[] = {
> @@ -371,7 +349,6 @@ static struct platform_driver hid_gyro_3d_platform_driver = {
>  		.pm	= &hid_sensor_pm_ops,
>  	},
>  	.probe		= hid_gyro_3d_probe,
> -	.remove		= hid_gyro_3d_remove,
>  };
>  module_platform_driver(hid_gyro_3d_platform_driver);
>  
> 

