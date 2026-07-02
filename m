Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1F41A682A
	for <linux-input@vger.kernel.org>; Thu,  2 Jul 2026 17:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783013336; cv=none; b=MXl8/mzOg6J7xAiBSesmHncNBk8H6LxyT8E0XEgN/WDs0rpk1dRFZiY87skMG0WEQXSHytCuC/NDpDfffpOIe3pv+0XAXOSkux861OWgAUM6N8wtTByOdzoSdYFBYxsTaHFdMP038A0eRWajlesVD/46T6u8/F5qf5ScfUiESxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783013336; c=relaxed/simple;
	bh=A/Rb0F3dAsnyFM6/202Jan7ZE8Yqnp57+CwKiuYyrT0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RxuzGkf+6QPNByVYkKHaygxvbqD3ZBJJNDlk6noObXG47YOnoG8XhJsb5zYk0IIgqQn3Bl5cTDMcYV3rYrAknH9QJYqq25CIpZHl0wFg8mn+xHDpKam5dbAARMfcJg9egeP0jY5be1bzChYCXexohxLjWkFDUdTZ1hFV1T3pxKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvVEHO5m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvVEHO5m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E50F1F000E9;
	Thu,  2 Jul 2026 17:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783013335;
	bh=VQk/QAyJJFRewyJ5ETHaVD58Y3wfZ7T6p3yxYPFljfY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HvVEHO5m3FgOQnuoZeo13/eBiuqzal59NQXCcAwtGpGvkjkQWpkKId5pZTaGFPf4Z
	 7KUWCKg2S+Qa3mzQ8SUOD0hIKglZ65YgYphZptVgpm8DRE3vjv6uK+f05PSwN8+kxv
	 ZFXftOwcXix01lQ/OgNwAUkoCl8ESixzRr+BPwqzGTT59vwdNomUcdc07knz8T4swm
	 savzGxoi1CpqB7jOZmTk3IjSzEdyxOUJkOC+vg6y7Crud+gmjYeu+Nu/14uyhYeJTe
	 Bvh3SRRwLyAJhwKv8Ti0Zjtb39eP7Lwew/xy67PhotozoFG9tHgP4wOAiR6c79yzKq
	 BJgv+1r1YfqiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] iio: temperature: hid-sensor-temperature: use
 common device for devres
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260702-15-jun-hid-iio-alignment-v2-6-b87f01f5efbc@gmail.com>
References: <20260702-15-jun-hid-iio-alignment-v2-0-b87f01f5efbc@gmail.com>
 <20260702-15-jun-hid-iio-alignment-v2-6-b87f01f5efbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 17:28:54 +0000
Message-Id: <20260702172855.5E50F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Changing the devm_kmemdup() parent from `&indio_dev->dev` to `&pde=
v->dev` introduces a Use-After-Free vulnerability by violating the IIO devi=
ce lifetime model.
--

commit f64b0b02100e325f644f897f84be1fbd188c0d40
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: temperature: hid-sensor-temperature: use common device for devres

This commit changes the device used for devm_kmemdup() from the IIO device
to the platform device. This aims to consolidate devres ownership under a
single parent device.

> diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/i=
io/temperature/hid-sensor-temperature.c
> index 18da85e6c60ed..6dfb606a53af3 100644
> --- a/drivers/iio/temperature/hid-sensor-temperature.c
> +++ b/drivers/iio/temperature/hid-sensor-temperature.c
> @@ -213,8 +213,8 @@ static int hid_temperature_probe(struct platform_devi=
ce *pdev)
>  	if (ret)
>  		return ret;
> =20
> -	temp_chans =3D devm_kmemdup(&indio_dev->dev, temperature_channels,
> -				sizeof(temperature_channels), GFP_KERNEL);
> +	temp_chans =3D devm_kmemdup(&pdev->dev, temperature_channels,
> +				  sizeof(temperature_channels), GFP_KERNEL);

[Severity: High]
Could tying the channel array allocated here in hid_temperature_probe() to
the platform device's devres introduce a use-after-free regression if an
in-kernel consumer holds a reference to the IIO device?

If an in-kernel IIO consumer, such as iio_hwmon, acquires a reference to a
channel of this device via iio_channel_get(), the reference count of the
logical IIO device (indio_dev) is incremented.

When the platform device (pdev) is unbound, the devres cleanup for pdev will
run and free the temp_chans array because its parent is now pdev->dev. The
devres cleanup then calls iio_device_unregister(), which drops the driver's
reference to indio_dev, but indio_dev itself remains alive due to the
consumer's reference.

If the consumer subsequently calls an IIO API like iio_read_channel_label()
or iio_get_channel_ext_info_count(), can these APIs directly dereference the
channel pointers into the freed temp_chans array without checking if the
device is unregistered?

Should the temp_chans array remain tied to &indio_dev->dev to ensure its
lifetime safely extends until the IIO device itself is fully released?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-15-jun-hid=
-iio-alignment-v2-0-b87f01f5efbc@gmail.com?part=3D6
