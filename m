Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F60134A3BF;
	Thu,  2 Jul 2026 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012932; cv=none; b=t2B8HPikzS9SjFLpoKeoQMfqvF7IOr423GbqEWEyOln6FxMam+k6c6gKrMWexp9KCZRwcxqKcIvU669/59dNCk9haxRne+f+iIpVUe04KdGjCGDwikbA9zxF/I3R6kW+HxaH6fYYNbz3qieTkzv+682dShY/8Izuzoa9s9u/hzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012932; c=relaxed/simple;
	bh=ZBB66t8WyLQIT3JVDjLHS/W200cW/0xDGqh+hd4Miec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=espaw/22k/Y04u1KtizKKgbOxpWKESG9HI4b8Ewqo1QrD4vpa9KL7fha8DIA4rCpMOSvRLYVECSHk2Si5g+KcZNxnq9fTWfru0xX9qzF4hdPHrqT0a0/TQSaD76TrqRh0rDWgTRW0NzT1FpLPza5wJM/yhcaUt+AYnj0hWRWxlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QylNrum8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QylNrum8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDAA1F00A3A;
	Thu,  2 Jul 2026 17:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783012930;
	bh=iO4sKM5FdrYI36/wXVmvlcXxd3UjdFng0Frzli8KZls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QylNrum8/czXpINP1Ah4lWbDE5HD7mlWPPr6W/5TplmRfO6Rw8wDLj2hKDzNpupnf
	 FgNIHWKq0YohCHP+Y7ONv3HDbEQYl5GHe0HdiKcIV6rzqlekVCVblbG6jp6qe1hdHg
	 +1/9OQ2+z5IHslARQyRxV9UiqDhm6BAdJGyyNPi+KSNkD3CRbVU5Xfu00c/F6ZK3Oh
	 fiR7wDIOdnlBQyTttnrUlSczUDBMtMabpaszDp9+UToCSWoir9d4obgFMGSpvv+TKA
	 Rp5t21hanu3Xz+ck9Om9h5jr8Z9gREyhuIKz8JtoB+7UfuOkHu9r1B1j2HN/bCqeIJ
	 tf7ZTbsRwDVLg==
Date: Thu, 2 Jul 2026 18:22:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda via B4 Relay
 <devnull+sanjayembeddedse.gmail.com@kernel.org>
Cc: sanjayembeddedse@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Maxwell Doose
 <m32285159@gmail.com>
Subject: Re: [PATCH v2 3/6] iio: hid-sensors: Use implicit NULL pointer
 checks
Message-ID: <20260702182205.388efe24@jic23-huawei>
In-Reply-To: <20260702-15-jun-hid-iio-alignment-v2-3-b87f01f5efbc@gmail.com>
References: <20260702-15-jun-hid-iio-alignment-v2-0-b87f01f5efbc@gmail.com>
	<20260702-15-jun-hid-iio-alignment-v2-3-b87f01f5efbc@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 02 Jul 2026 21:48:00 +0530
Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Replace explicit NULL pointer comparisons with implicit checks across
> HID sensor IIO drivers to follow the preferred kernel coding style.
Is there anything in the kernel wide style guides about this?

I do prefer this style in IIO but perhaps we should document it
as local IIO style rather than implying general guidance (unless
there is some!)

> 
> Convert 'if (indio_dev == NULL)' -> 'if (!indio_dev)'.
> 
> No functional change.
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> Reviewed-by: Maxwell Doose <m32285159@gmail.com>
> ---
>  drivers/iio/accel/hid-sensor-accel-3d.c       | 2 +-
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c | 2 +-
>  drivers/iio/orientation/hid-sensor-incl-3d.c  | 2 +-
>  drivers/iio/orientation/hid-sensor-rotation.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
> index 9197f3424c0c..225f8dd65ab1 100644
> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
> @@ -325,7 +325,7 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
>  
>  	indio_dev = devm_iio_device_alloc(&pdev->dev,
>  					  sizeof(struct accel_3d_state));
> -	if (indio_dev == NULL)
> +	if (!indio_dev)
>  		return -ENOMEM;
>  
>  	platform_set_drvdata(pdev, indio_dev);
> diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> index ad10fa20fae0..738bad65d74d 100644
> --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> @@ -463,7 +463,7 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
>  
>  	indio_dev = devm_iio_device_alloc(&pdev->dev,
>  					  sizeof(struct magn_3d_state));
> -	if (indio_dev == NULL)
> +	if (!indio_dev)
>  		return -ENOMEM;
>  
>  	platform_set_drvdata(pdev, indio_dev);
> diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
> index 870c8929491e..c8efb0dab8b6 100644
> --- a/drivers/iio/orientation/hid-sensor-incl-3d.c
> +++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
> @@ -302,7 +302,7 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
>  
>  	indio_dev = devm_iio_device_alloc(&pdev->dev,
>  					  sizeof(struct incl_3d_state));
> -	if (indio_dev == NULL)
> +	if (!indio_dev)
>  		return -ENOMEM;
>  
>  	platform_set_drvdata(pdev, indio_dev);
> diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
> index 2dad0453fc67..6db253c1635d 100644
> --- a/drivers/iio/orientation/hid-sensor-rotation.c
> +++ b/drivers/iio/orientation/hid-sensor-rotation.c
> @@ -274,7 +274,7 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
>  
>  	indio_dev = devm_iio_device_alloc(&pdev->dev,
>  					  sizeof(struct dev_rot_state));
> -	if (indio_dev == NULL)
> +	if (!indio_dev)
>  		return -ENOMEM;
>  
>  	platform_set_drvdata(pdev, indio_dev);
> 

