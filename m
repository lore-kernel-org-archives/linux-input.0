Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E40930148C
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 13:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617187; cv=none; b=KqV/BGATxcdc4ogmcUFv+ahzTv9xUI65PhsCBRor8W/EEtjXk6J8voBSvHvRIFrbMye3V7pekCzuyJewQMu8Y2gHVLtwdOmM5P4rphsrjMu3/sl/Q42OJVcZeyXNsjgFolasLz2ZvL/SsKgWXlRJc2VU96ChqFnP/Hl7L9Spaf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617187; c=relaxed/simple;
	bh=HLGKdJ3y4JgqXCZLHldCPm/gbTaciV9O8MYor18PLOE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QEs1ePW5D9XmnmehE1qfmDB0khWXhm93ARhOxJsGqia2EpzC983nlW3fk02Y5zbyBAqfFdQ9uFKC/q1LGpJeSaty4g3XgmhaGiFQWhKA5QpAgS5e9yy/rElC4OY1GeRvJOelLQxmLQKBIIdewUKtHI+vdZ+Cd6OGk503RiA4IUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjUTrucR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjUTrucR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4F31F000E9;
	Tue, 16 Jun 2026 13:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781617186;
	bh=QmrQZjAhRjTw5ShEw4gHobj4vZJpV37itM3ia9YCA3g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JjUTrucR4TIStB7GRut02zfqIme9buOjw7ypr5jK37ao0rsWVoFFZ19wQzYmtJZPX
	 XdBwA0FaFii2zVOkjdgGsSQE4G9YN7UAy+YPRhfJTGOrXkYhYLO0DHyYyx8FTzFsjW
	 j8/tKq8AhivHlTCaAyzHRMs3Nu3aGYw31GdYwZGwIePUxXq9trtkOfR65bibOw+gB/
	 QrhkldGmhQmQHufy3qXu6l1SEleJK2rPJDZqEDPJUnfLXH9XcGuXtr+230m3Rj57zK
	 Kd2+jDO/ZA19y0lxk/pGG3B+s5ZF9Lc9KzaBz8Wuw+Z0PUhnh0ZXCM0acC8SkUPAgp
	 QlOTrsAtCYpHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] iio: hid-sensor-temperature: use u32 instead of
 unsigned int
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260616-16-jun-hid-iio-u32-api-type-v1-1-952c74195f46@gmail.com>
References: <20260616-16-jun-hid-iio-u32-api-type-v1-1-952c74195f46@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 13:39:45 +0000
Message-Id: <20260616133945.DB4F31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Tear-down Order Inversion / Use-After-Free
--

commit fd38c3c8f2adbbb955807f745b5f193e1fd40a85
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: hid-sensor-temperature: use u32 instead of unsigned int
   =20
This commit updates the type of the usage_id variable from unsigned int
to u32 in the callback API. This improves code clarity and matches the
expected callback API type.

> diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/i=
io/temperature/hid-sensor-temperature.c
> index 9f628a8e5cfbe..a8d3a15f9c531 100644
> --- a/drivers/iio/temperature/hid-sensor-temperature.c
> +++ b/drivers/iio/temperature/hid-sensor-temperature.c

[ ... ]

> @@ -159,7 +159,7 @@ static int temperature_capture_sample(struct hid_sens=
or_hub_device *hsdev,
>  static int temperature_parse_report(struct platform_device *pdev,
>  				struct hid_sensor_hub_device *hsdev,
>  				struct iio_chan_spec *channels,
> -				unsigned int usage_id,
> +				u32 usage_id,
>  				struct temperature_state *st)
>  {
>  	int ret;

[Severity: High]
This is a pre-existing issue, but does hid_temperature_remove() tear down
the trigger and callback too early?

Because the driver uses devm_iio_device_register(), the IIO device will not
be unregistered until after the driver's remove function returns.

However, hid_temperature_remove() manually unregisters the trigger and
callbacks before that:

drivers/iio/temperature/hid-sensor-temperature.c:hid_temperature_remove() {
	...
	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_TEMPERATURE);
	hid_sensor_remove_trigger(indio_dev, &temp_st->common_attributes);
}

Could this leave a race condition window where the IIO device and its
sysfs/char interfaces are still fully accessible to userspace, but its
backing trigger and callbacks have already been destroyed?

Can concurrent access from userspace during this window lead to a
use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616-16-jun-hid=
-iio-u32-api-type-v1-0-952c74195f46@gmail.com?part=3D1
