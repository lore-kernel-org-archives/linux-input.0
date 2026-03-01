Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4112D94A7;
	Sun,  1 Mar 2026 11:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772365499; cv=none; b=Mwxg7BEbLL1/EEls2tD1rVz2RX1L/K2+3VeTy9FlWw5Em/2umEDHy7V9gn1lOlMnq4ZMSJXxfsoDTkQGcrGioNb44u+h3D20KLtMFh03gGFuJ+Vr0e0sS/ZiADR5kWT5mLCZW/2Cuh4OSgEIB37WHiPlTL6P+uKHTl77ArGYe6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772365499; c=relaxed/simple;
	bh=mtKvxHJPTCi6LZo5NyJ947gjmjouofJ/GDyOeU2SZKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2X2PEOvrCnmW1PiZ5/QE5en+AQNkOx2AqrL5wcoG8A2oS0lVlclhJxT4JoII84h9LGBTbj2xc28yD7wpwnJr2TLAGnugHYgCrgqM8Oe5kO4LKdp+z6f1EMjuxfiUFVE/pd5zhrxIpaK6uVF+Ons7oIFnGTUDWXrKQ9wkZuBae4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBGdLJ2r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBGdLJ2r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A4AC116C6;
	Sun,  1 Mar 2026 11:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772365498;
	bh=mtKvxHJPTCi6LZo5NyJ947gjmjouofJ/GDyOeU2SZKQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WBGdLJ2rawLzIo+7xaUFWY/P/rHyHPFLm16p7BMQ0rom1l0eMT0/U0xnO1r1FcS4C
	 BRzBxOHod6wJtA5jxcgRDvnxV7erbBmb68El+JZgLoofZk0Ok5sW423Rkf5WPH5A/9
	 CjZN+ZZn8xGVyVBbUspc50L8igyH5WQX0j6wrveH1sj6L2FCnmuoOKGt9kacshY3dJ
	 lAHiXW25aIRJt48TYE7uBZ6C23N4LenHCm+16eYLveScZWiuojPmIZvY7FO+nTmyz5
	 xyg4hSScOfJ8lMNE/2Ca2kj/XBF+CNby+EYA8hS+j3s5H1Knje/Loy0XSSvYPhWHIk
	 gVKZBvU/FkdYg==
Date: Sun, 1 Mar 2026 11:44:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Bhargav Joshi <rougueprince47@gmail.com>
Cc: jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: hid-sensor-gyro-3d: move iio_device_register()
 to end of probe()
Message-ID: <20260301114450.17f79213@jic23-huawei>
In-Reply-To: <20260228191400.19244-2-rougueprince47@gmail.com>
References: <20260228191400.19244-1-rougueprince47@gmail.com>
	<20260228191400.19244-2-rougueprince47@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  1 Mar 2026 00:43:59 +0530
Bhargav Joshi <rougueprince47@gmail.com> wrote:

> Currently, calling iio_device_register() before
> sensor_hub_register_callback() may create a race condition where the
> device is exposed to userspace before callbacks are wired.

We needs some more here on 'why' this is a problem.
Whilst this is an unusual arrangement, I couldn't immediately find
anything that was actually broken.  It's possible data will turn up
after we tear down the callbacks and before the userspace interfaces
are removed, but I think that just results in dropping data. Given it's
in a race anyway I don't think we care about that. The callbacks
don't seem to be involved in device configuration which can go on whether
or not the callbacks are registered.  Maybe there is something that
won't get acknowledged if they aren't in place in time?

For a fix like this we'd normally want to see a clear flow that
leads to a bug.

Also a fixes tag so we know how far to backport.

> 
> Move iio_device_register() to the end of the probe() function to prevent
> race condition.
> 
> Consequently, update the error handling path in probe() and in remove()
> ensuring that iio_device_unregister() is called first to cut off
> userspace access before the hardware callbacks are removed.
> 
> Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>
> ---
>  drivers/iio/gyro/hid-sensor-gyro-3d.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> index c43990c518f7..8e3628cd8529 100644
> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> @@ -333,12 +333,6 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	ret = iio_device_register(indio_dev);
> -	if (ret) {
> -		dev_err(&pdev->dev, "device register failed\n");
> -		goto error_remove_trigger;
> -	}
> -
>  	gyro_state->callbacks.send_event = gyro_3d_proc_event;
>  	gyro_state->callbacks.capture_sample = gyro_3d_capture_sample;
>  	gyro_state->callbacks.pdev = pdev;
> @@ -346,13 +340,19 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
>  					&gyro_state->callbacks);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "callback reg failed\n");
> -		goto error_iio_unreg;
> +		goto error_remove_trigger;
> +	}
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "device register failed\n");
> +		goto error_remove_callback;
>  	}
>  
>  	return ret;
>  
> -error_iio_unreg:
> -	iio_device_unregister(indio_dev);
> +error_remove_callback:
> +	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
>  error_remove_trigger:
>  	hid_sensor_remove_trigger(indio_dev, &gyro_state->common_attributes);
>  	return ret;
> @@ -365,8 +365,8 @@ static void hid_gyro_3d_remove(struct platform_device *pdev)
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>  	struct gyro_3d_state *gyro_state = iio_priv(indio_dev);
>  
> -	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
>  	iio_device_unregister(indio_dev);
> +	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
>  	hid_sensor_remove_trigger(indio_dev, &gyro_state->common_attributes);
>  }
>  

