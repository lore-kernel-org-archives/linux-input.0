Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99476276049;
	Mon, 27 Jul 2026 01:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785115565; cv=none; b=Qa86WYUSy3xNvTAK6WAzwLCumPuuvC0Y2yf4vfdjvaT34NpDu9h+Sz/Q4Zb0eszqYG/N3RgIRrBxei424KI/gAmlqgDoR2QWJWxUWHlRsd2k/DCU377dhIl+SwbvtQk7kVsfzhq/jlSmWwBUuUuaWWfxx3dogp7qXucgDyK/eUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785115565; c=relaxed/simple;
	bh=7jD7vi8Es+6zuoXszupk+jevcF0tBzGj/UfF2xIvSiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oz7aXjatDyppIiG76ICEMYobgk5b9ShbaxqbxTIIpH77nlya3vGi70PP+dDUIPab6+cshpGDkb1jTmWPfnWj/7+5FMk2Rx2Z+ZgBN53UA7zniolgVwTotjsInK3Ge6q3XBIUyjvhSSVh9OPKZbK8nT/SMW1an4bdLtCIrax7cK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZ8jFFdd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZ8jFFdd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B2F1F00A3A;
	Mon, 27 Jul 2026 01:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785115564;
	bh=dAHKXwg6BWXrykxg56jMkNSBdHYaOM7dlRmt74x6MKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XZ8jFFddL22dTYTuYzGKceHD7IR3R3hXMdqke/8asUPDqd9Uiy42x+fsYnrX9lVqT
	 2b1Zi263cYzWIANL2lWcteL8kFem81GOpr5qwG0/5DUMIiKJj+ydvya8LzzQSbTw2p
	 aCMHh/GrfXXSSDXQkHwik+EF1NrffJg35yE2rKBA8UgSbGrLrg/7WBlgGdrLpbTj7t
	 hJOl1MbavDVhbwSdU3W7dvoDRLhHiXLGYPBbMqEJnLLewp18pml8anzz/J3u7YFssT
	 +D0H1NwyWJefzwxxm5P5Vmj6pyLuPOF3O8/Fp1vl3Hra0GJJSFVEK9UmC78UW/426l
	 a8ew8pEk61Jew==
Date: Mon, 27 Jul 2026 02:25:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda via B4 Relay
 <devnull+sanjayembeddedse.gmail.com@kernel.org>
Cc: sanjayembeddedse@gmail.com, Jiri Kosina <jikos@kernel.org>, Srinivas
 Pandruvada <srinivas.pandruvada@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: gyro: hid-sensor-gyro-3d: Use
 dev_err_probe()
Message-ID: <20260727022546.6d5336e6@jic23-huawei>
In-Reply-To: <20260724-24-july-hid-gyro-dev-log-clenaup-v2-2-01671b07b181@gmail.com>
References: <20260724-24-july-hid-gyro-dev-log-clenaup-v2-0-01671b07b181@gmail.com>
	<20260724-24-july-hid-gyro-dev-log-clenaup-v2-2-01671b07b181@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 22:57:21 +0530
Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Replace dev_err() calls with dev_err_probe() during probe.
> 
> dev_err_probe() makes error code handling simpler and handle
> deferred probe nicely (avoid spamming logs).

There are changes in here that aren't mentioned.

A common way to handle this is to add.  

"To simplify the added dev_err_probe() calls, add a local struct devic
 variable." 

Then in a follow up patch do the rest and state something like

"Use the local struct device *dev to replace &pdev->dev, simplifying
code."

> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
>  drivers/iio/gyro/hid-sensor-gyro-3d.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> index bcf53e267701..749a2ecbc2d1 100644
> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> @@ -264,13 +264,14 @@ static int gyro_3d_parse_report(struct platform_device *pdev,
>  /* Function to initialize the processing for usage id */
>  static int hid_gyro_3d_probe(struct platform_device *pdev)
>  {
> -	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
> +	struct device *dev = &pdev->dev;
> +	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
>  	int ret = 0;
>  	static const char *name = "gyro_3d";
>  	struct iio_dev *indio_dev;
>  	struct gyro_3d_state *gyro_state;
>  
> -	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*gyro_state));
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*gyro_state));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  	platform_set_drvdata(pdev, indio_dev);
> @@ -284,12 +285,10 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
>  						&gyro_state->common_attributes,
>  						gyro_3d_sensitivity_addresses,
>  						ARRAY_SIZE(gyro_3d_sensitivity_addresses));
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to setup common attributes\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to setup common attributes\n");
>  
> -	indio_dev->channels = devm_kmemdup(&pdev->dev, gyro_3d_channels,
> +	indio_dev->channels = devm_kmemdup(dev, gyro_3d_channels,
>  					   sizeof(gyro_3d_channels), GFP_KERNEL);
This is the case I'm saying doesn't belong in this patch.

Jonathan

>  	if (!indio_dev->channels)
>  		return -ENOMEM;
> @@ -297,10 +296,8 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
>  	ret = gyro_3d_parse_report(pdev, hsdev,
>  				   (struct iio_chan_spec *)indio_dev->channels,
>  				   HID_USAGE_SENSOR_GYRO_3D, gyro_state);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to setup attributes\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to setup attributes\n");
>  
>  	indio_dev->num_channels = ARRAY_SIZE(gyro_3d_channels);
>  	indio_dev->info = &gyro_3d_info;
> 

