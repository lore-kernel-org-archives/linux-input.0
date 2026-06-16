Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A7B35A3A4
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781609260; cv=none; b=ZKl2CGZjpY3OrUzlzyZ/ljHm+XoFbZLansMRN1cb/7sn0ZqYrHz0k9bWVLWyk21Bi9ALder3dkVZ2Et17T8DpV7BaQDrawjziGF2L+SF1IKNdRomDBAVYGMTL4UWjGabHrA5IAx6nlwYxzcJjfMgiiOsBsb+gCZ2L3Q8ELf/irQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781609260; c=relaxed/simple;
	bh=ak3cTdUBL3skR01NhAU6TJuhD0cOpK4Lnb/pDJThC+I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p5xfxtH70vYKHO3wOuD+kGRn/woCDpYkeI8zNPKHQ0q8TU8mlUcvUnvoq00AFDA/ZN21nN/ns1ENvTZkWoyh+GySxe3dCyxFDPLyV6DzFxmuFnBqpQn73JKxa70tSTeH+TPoxq0Eyb4J2382dkGlR5Hv8uCxtGsAfT8Nov37KWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Drz+qKSU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Drz+qKSU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11A41F000E9;
	Tue, 16 Jun 2026 11:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781609259;
	bh=E7fM5tLmzYShp9akg8HrVF35qydsX8AxJtMCtnjl0H0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Drz+qKSUZbNVKOMIczS33cuqxlW6pjkaCCXpbN6BkdKx4D/2lIH7KFSqvnXLG9orf
	 i7g/AAKlKFVHU1fNTf9NkDLcpBzZKJXBoTWwAXXBaxtUm6dKLve9VXUOxImWmmy8If
	 VvoE3ObuQGTvf+UXLSB07A7Q6rrnoXKEpec0qsebfEMQmrSHI8BxAQuq9EAId7wVms
	 3af8gbPxPxjfCmaGshGunWfmXPC5OadCFxHu/KPGJZN9bhc+9q0zDKXCEHQhad/Tiy
	 TlYqZKE1RpFaaQl0LOwcHJx6uTTmwQCb09UGJs1RK+0sd2BrzbG0njEGMPHfEiYbB8
	 hLFYLljePTlJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/11] iio: humidity: hid-sensor-humidity: use common
 device for devres
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260616-15-jun-hid-iio-alignment-v1-5-0cd544286575@gmail.com>
References: <20260616-15-jun-hid-iio-alignment-v1-5-0cd544286575@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 11:27:38 +0000
Message-Id: <20260616112738.D11A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Changing the devm allocation parent from the IIO device to the pla=
tform device creates a dangling pointer, as the IIO device can outlive the =
platform device.

Pre-existing issues:
- [High] The driver shares a single static global `struct hid_sensor_hub_ca=
llbacks humidity_callbacks` which is overwritten by each probed device, cau=
sing data corruption and Use-After-Free.
--

commit ba18caab7a04132bf9ca0d7432b6f7dcfedfbc00
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: humidity: hid-sensor-humidity: use common device for devres

This patch changes the devres allocation parent for the humidity channels
array. It moves the ownership from the IIO device to the HID platform
device to consolidate the devres ownership tree.

> diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/hum=
idity/hid-sensor-humidity.c
> index 6fed019f4099f..73120b87d641d 100644
> --- a/drivers/iio/humidity/hid-sensor-humidity.c
> +++ b/drivers/iio/humidity/hid-sensor-humidity.c
> @@ -215,7 +215,7 @@ static int hid_humidity_probe(struct platform_device =
*pdev)
>  	if (ret)
>  		return ret;
> =20
> -	humid_chans =3D devm_kmemdup(&indio_dev->dev, humidity_channels,
> +	humid_chans =3D devm_kmemdup(&pdev->dev, humidity_channels,
>  				   sizeof(humidity_channels), GFP_KERNEL);

[Severity: High]
Does changing the devm allocation parent to the platform device create a
dangling pointer here?

In the IIO subsystem, the iio_dev object is reference-counted and can outli=
ve
the platform device if userspace holds open file descriptors (for example,
/dev/iio:deviceX). Devres resources attached to pdev->dev are freed
unconditionally when the driver unbinds, but resources attached to
indio_dev->dev live until the iio_dev reference count drops to zero.

By moving the allocation of humidity_channels to pdev->dev, won't
indio_dev->channels point to freed memory immediately after unbind, leading
to a use-after-free if the IIO core or userspace continues to interact with
the still-alive iio_dev?

>  	if (!humid_chans)
>  		return -ENOMEM;

[ ... ]

While looking at hid_humidity_probe(), I noticed another detail:

drivers/iio/humidity/hid-sensor-humidity.c:hid_humidity_probe() {
	...
	humidity_callbacks.pdev =3D pdev;
	ret =3D sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY,
					   &humidity_callbacks);
	...
}

[Severity: High]
This is a pre-existing issue, but does assigning the local platform device =
to
the globally shared humidity_callbacks structure cause state corruption?

If a system has multiple humidity sensors probed, it appears the pdev of the
last probed sensor overwrites the pointer for all previous instances.

When sensor_hub_raw_event() dispatches an event for an earlier sensor, it
calls callback->capture_sample() with the overwritten pdev. Could this
corrupt the state of the newer sensor, or cause a use-after-free if the
newer sensor is unbound while the older one remains active?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616-15-jun-hid=
-iio-alignment-v1-0-0cd544286575@gmail.com?part=3D5
