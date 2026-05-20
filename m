Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1F61CDFCA
	for <linux-input@vger.kernel.org>; Wed, 20 May 2026 00:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779237074; cv=none; b=IOoh8k5MezP36r04sXeW1RC0/vO6LdhnkSmJRWT+4xXSkDx6cAczSaPPzbdrGQ1JVfaO0ZtZV8YoJ6K0uaQNzvAf2dVTt8VhmVY1exURU1dmJ4V9wVTNrexiQFQfUSPiK7YJxVkdjKch6Fn57vrlOPztrnCjAqwd8Ch0tX5PAH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779237074; c=relaxed/simple;
	bh=tUo1IP5ZmNTw5xHtHw5Br/odn/NihB/hg2ZIjrBcTFk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZPvr9GkNGfrVGoUGJ8vTfWVEEm8ymFwSsdUHbyz0JLc2fHat9YfB+P8ts395uYTh8yTP53JXCfIgnd54u/Wx9KK2H5+Zd7SN9SZFtK7IDHIbHzp835Nqi49smZAQc25WwlFZY6cwgGAyyvAsP4qV7sqSbwjRdOlfQlSD2yOiA9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvNk39Vk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvNk39Vk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9A51F000E9;
	Wed, 20 May 2026 00:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779237072;
	bh=cL4xCf8viwrPcUjcmCFzE4rYQpB5vV1HTjZ8Il5MW+k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZvNk39VklckHbqBkTrnH/gb54dLB7Nh3stZj56f7FWVIcWKX+qaeDcbV1k4iOaJiU
	 N4o3tWZsPL6MPA+vRJYmKfK0ryKNXc5j7ucO9wdN5wDMeBhFhCfnm2po3MZc4keXxF
	 TrIpI5062nFIc2gWb/oa8ZWlW+tAIGIth9K63NNUzk/Y+GJGd1kCupjHbEQ0+QJWGh
	 UaKl0/i9UmPtSVVOeYAd2Vgbdl11Po3Ck7tR0XHOu7B2SWsDZAb6BktVcFzyejkekT
	 nHJN8hH3GxQFCBUxsGLHFAbzYK13Ir1nE64PAsAOp6cb1bq0UbjrhSKM1zGiSvQHcq
	 BnDjAnT9P2G5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/6] iio: gyro: HID: hid-sensor-gyro-3d: Refactor
 channel initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TmF0w6FsaWEgU2FsdmlubyBBbmRyw6k=?= <natalia.andre@ime.usp.br>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260519234752.23911-3-natalia.andre@ime.usp.br>
References: <20260519234752.23911-3-natalia.andre@ime.usp.br>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 00:31:12 +0000
Message-Id: <20260520003112.6F9A51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The `struct iio_scan_type` is incorrectly initialized with a non-ex=
istent `.format` member, causing a build failure.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but a teardown race =
condition exists when the driver is unbound, leading to a potential Use-Aft=
er-Free of `gyro_state` inside the HID raw event handler.
--

commit fa4886d3bbba316658546fb6162186593b204b9c
Author: Nat=C3=A1lia Salvino Andr=C3=A9 <natalia.andre@ime.usp.br>

iio: gyro: HID: hid-sensor-gyro-3d: Refactor channel initialization

This commit replaces the local gyro_3d_adjust_channel_bit_mask() function
with a compound literal for scan_type initialization to improve code
readability. It also cleans up the channel initialization loop by iterating
directly over the channel scan indices.

> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid=
-sensor-gyro-3d.c
> index c43990c518f77..ee7bde8620b41 100644
> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
[ ... ]
> @@ -248,19 +238,20 @@ static int gyro_3d_parse_report(struct platform_dev=
ice *pdev,
>  				struct gyro_3d_state *st)
>  {
>  	int ret;
> -	int i;
> =20
> -	for (i =3D 0; i <=3D CHANNEL_SCAN_INDEX_Z; ++i) {
> +	for (unsigned int ch =3D CHANNEL_SCAN_INDEX_X; ch <=3D CHANNEL_SCAN_IND=
EX_Z; ch++) {
>  		ret =3D sensor_hub_input_get_attribute_info(hsdev,
>  				HID_INPUT_REPORT,
>  				usage_id,
> -				HID_USAGE_SENSOR_ANGL_VELOCITY_X_AXIS + i,
> -				&st->gyro[CHANNEL_SCAN_INDEX_X + i]);
> +				HID_USAGE_SENSOR_ANGL_VELOCITY_X_AXIS + ch,
> +				&st->gyro[ch]);
>  		if (ret < 0)
>  			break;
> -		gyro_3d_adjust_channel_bit_mask(channels,
> -				CHANNEL_SCAN_INDEX_X + i,
> -				st->gyro[CHANNEL_SCAN_INDEX_X + i].size);
> +		channels[ch].scan_type =3D (struct iio_scan_type) {
> +			.format =3D 's',

[Severity: Low]
Does this initialization cause a build failure?

Looking at struct iio_scan_type, it designates the field for signedness as =
sign,
not format. The original code correctly assigned 's' to
channels[channel].scan_type.sign. Using format here will likely cause a com=
piler
error about having no member named format.

> +			.realbits =3D BYTES_TO_BITS(st->gyro[ch].size),
> +			.storagebits =3D BITS_PER_TYPE(u32),
> +		};
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but could a teardown race condit=
ion
exist when the driver is unbound, leading to a potential use-after-free of
gyro_state inside the HID raw event handler?

When the driver is manually unbound, hid_gyro_3d_remove() calls
sensor_hub_remove_callback(). This core function unregisters the callback l=
ist
entry but does not flush or synchronize with concurrently running
sensor_hub_raw_event() asynchronous dispatches.

Consequently, remove completes and devres proceeds to free indio_dev, which
embeds gyro_state and the callback structure. A concurrent
sensor_hub_raw_event() that fetched the callback pointer prior to removal (=
after
dropping dyn_callback_lock) could then execute callback->capture_sample() a=
nd
callback->send_event() on freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519234752.2391=
1-1-natalia.andre@ime.usp.br?part=3D2
