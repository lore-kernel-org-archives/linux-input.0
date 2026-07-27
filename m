Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C69F800;
	Mon, 27 Jul 2026 01:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785115381; cv=none; b=rnoqdvBHYkx03JluiAwClgYyIdRN8C5Ec3da9fAWMg+MRJNURWhIgEgRNqkWR10QegkCNPW+En/E0nmlTZKQkSgF8ha51jQxP90FqLrlC0y+ru0EyGdPA7/of5Yzo4Pnp6r2RnJSjD7Dg004T2li9i9PtFhwG0XAZD3onhBbbC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785115381; c=relaxed/simple;
	bh=QTwJAmkz3LtQ0xC2B9mL3DfjnPs6tHTDx6ZYhm+vrHU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tqM0S9MRQCfeYtOdRuYZb9supXVTCPaHp6I1hVZfEKLnye0IqhRWAv0QOQY3B8H2hKdUB9YeldSMPTnokKBFZOOYfMKADAFMm1KdBR1Rt5Z2/R5vT6CS9vXf72IpzAWvw7/OR/G5/mTh954aPR9jFR7nKycGt+8XRP3zNXnBnbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NponoEPa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NponoEPa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD3B1F000E9;
	Mon, 27 Jul 2026 01:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785115379;
	bh=Z4DboY6sRBgoS+jghlHO2xvb1IotdMYW2iC682uRGbI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NponoEPaQB0HupU1X9Gw8V/0rPjzCch3t2oiiy2RZt2MCl2peyzDy4gKNW5fEu8gx
	 qitiTyiVbaQPWL/P/qKQi0UPwBKv7187XoD8fYzSHp1lxXY0I553jZrntc87ums80R
	 EGO/re62i+8PVa8jwKlGc3+CB3MWZiZgPRCQylCAkJ6gmhhQXtwuWIaqTP7pZo6p/x
	 6BR4rh/XA4SmjrN2jKO4HTeGubQURvvP+5JRowLhOShH9cd5sCgBj5w+ORe90ddkhG
	 D8crG8FecisYTiQbo6icK+G0mBvl/k/yRlovXXfdzyPAwo9TrjGt1AITyfvtpO0FRi
	 GrCT+42X5puIg==
Date: Mon, 27 Jul 2026 02:22:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda via B4 Relay
 <devnull+sanjayembeddedse.gmail.com@kernel.org>
Cc: sanjayembeddedse@gmail.com, Jiri Kosina <jikos@kernel.org>, Srinivas
 Pandruvada <srinivas.pandruvada@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: gyro: hid-sensor-gyro-3d: Remove redundant
 dev_err()
Message-ID: <20260727022253.117f21cb@jic23-huawei>
In-Reply-To: <20260724-24-july-hid-gyro-dev-log-clenaup-v2-1-01671b07b181@gmail.com>
References: <20260724-24-july-hid-gyro-dev-log-clenaup-v2-0-01671b07b181@gmail.com>
	<20260724-24-july-hid-gyro-dev-log-clenaup-v2-1-01671b07b181@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 22:57:20 +0530
Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Respective APIs used during probe setup already emit detailed error
> messages or return appropriate standard error codes on failure.
> 
> Remove the redundant/dead driver-specific dev_err() calls to avoid
> duplicate error reporting.
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
>  drivers/iio/gyro/hid-sensor-gyro-3d.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> index 58250a972567..bcf53e267701 100644
> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
>  	gyro_state->callbacks.pdev = pdev;
>  	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D,
>  					   &gyro_state->callbacks);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "callback reg failed\n");

Hmm. Just about on this one returning sufficient error codes.
However the caller of this can't differentiate those values from
the same values from other calls in this function.

> +	if (ret < 0)
>  		goto error_remove_trigger;
> -	}
>  
>  	ret = iio_device_register(indio_dev);
This one I'm more dubious about.  There is a lot of work done
iio_device_register() and traditionally we haven't been that
focused on printing error messages. There are some paths covered
but some others are not.

I'm not sure it is useful to just return the error code as that
matches with other paths that will give similar error codes.

Maybe it is worth considering doing an audit of iio_device_register()
and making sure that suitable errors are printed in all locations
but that will be hard to do and I'm not sure I want to see the churn
of ripping out prints on this in every driver because we now think
the core is doing enough.

I'm definitely open to gathering some more opinions on this though
so let us see if others reply to the thread.

Jonathan

> -	if (ret) {
> -		dev_err(&pdev->dev, "device register failed\n");
> +	if (ret)
>  		goto error_remove_callback;
> -	}
>  
>  	return ret;
>  
> 

