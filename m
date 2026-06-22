Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802F02FE0F
	for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 05:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782107429; cv=none; b=qsnnc4QanmdBH0rU7bbxVqBjXzYbIqB3D+Y+H2w1+0IE7cCF0a5ilZ49hQmj4u0B8+CczW70kpLytpAo1HWokC5aKXgUWYU9C6yefcsbWKNqPlUyVW1z9/W8tudfjX8UtTxQwJ/cMV4mCDmi5KyEnS4vmprv+8exonMXSL+mu6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782107429; c=relaxed/simple;
	bh=NDmS9j8YQ28joA5ygp8f/XIjecR5j60NAsSJdki1WEo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=idGkndLXV5EQtjXp5AkLXb72uEWk4jMgFTRRDFMi4J454XIlGj9sIfs+dvZdEgyp47k1jB/jOPDmixgIn760DWnfKXp10HdXCw2SbDxX9ycK2bU2DA0X+iLogX6gHgc7pDLYBV6LQEnkiHd5STJ5UJTyZ5zLNjLxYwwDRer1Ruc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRM7cNGX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRM7cNGX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0037D1F000E9;
	Mon, 22 Jun 2026 05:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782107428;
	bh=xQpUJRR17/z33M9bdBsapiQtqeY5zg0Vj99Tu3K82gE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nRM7cNGXqGUiheAuWai+mOEGgNMKx1txsdjiFxwj8ysZjHCoGNBb3oCoYE4Zpc64z
	 9Lvb5VqMw+eOHD6v/CDN4FokZzY4aIYpbiTWTxRa5exDOvHE9hcmV1S7SKcjiUbyS1
	 KXCqo9d43X1cyDly5sdqGFmedEeXL4EfICgO2GHHiVFfAeIX+bbPqMWB9sODmqq5yr
	 Gmey9wYrnPjpKpvbGWhNc+zNeRg542EVV3+aniLSfZAJ17osPWdCH5mECMXuSp7Y9x
	 GZ4YDZvgQAQmn0ImsdiUo/AVcXgpx+B6XIz5oeKJDSpD6/piWK5hpHOwXaDOLS4IvS
	 cRcQ+6CouRvYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/8] iio: magnetometer: hid-sensor-magn-3d: Avoid
 race between callback setup and device exposure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260622-5-june-hid-iio-race-fixes-v2-7-1cfabcd1881e@gmail.com>
References: <20260622-5-june-hid-iio-race-fixes-v2-0-1cfabcd1881e@gmail.com>
 <20260622-5-june-hid-iio-race-fixes-v2-7-1cfabcd1881e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 05:50:27 +0000
Message-Id: <20260622055028.0037D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Reversing teardown order introduces severe race condition leading =
to list corruption and use-after-free.
- [High] Reordering probe sequence introduces a Use-After-Free (UAF) vulner=
ability on the error path.

Pre-existing issues:
- [High] Direct unaligned and out-of-bounds dereference of `raw_data` buffe=
r.
--

commit 88cf07ac8710a7390dc946776d5f89db30869a24
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: magnetometer: hid-sensor-magn-3d: Avoid race between callback setup an=
d device exposure

The driver currently exposes the IIO device to userspace before
completing sensor hub callback registration, and similarly removes
callbacks while the device can still be accessed during teardown.

> diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/=
magnetometer/hid-sensor-magn-3d.c
> --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
[ ... ]
> @@ -526,13 +520,19 @@ static int hid_magn_3d_probe(struct platform_device=
 *pdev)
>  					&magn_state->callbacks);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "callback reg failed\n");
> -		goto error_iio_unreg;
> +		goto error_remove_trigger;
> +	}
> +
> +	ret =3D iio_device_register(indio_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "device register failed\n");
> +		goto error_remove_callback;
>  	}
> =20
>  	return ret;
> =20
> -error_iio_unreg:
> -	iio_device_unregister(indio_dev);
> +error_remove_callback:
> +	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D);

[Severity: High]
If iio_device_register() fails, does this error path allow a use-after-free
if a concurrent HID event is processing?

sensor_hub_remove_callback() removes the callback from the list lock, but it
does not synchronize with currently executing events. If an event is execut=
ing
inside sensor_hub_raw_event() calling magn_3d_capture_sample(), and we retu=
rn
an error here, devres will immediately free the indio_dev and magn_state me=
mory.

Could the still-executing callback dereference freed memory?

>  error_remove_trigger:
>  	hid_sensor_remove_trigger(indio_dev, &magn_state->magn_flux_attributes);
>  	return ret;
> @@ -545,8 +545,8 @@ static void hid_magn_3d_remove(struct platform_device=
 *pdev)
>  	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
>  	struct magn_3d_state *magn_state =3D iio_priv(indio_dev);
> =20
> -	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D);
>  	iio_device_unregister(indio_dev);
> +	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D);

[Severity: High]
Does changing this teardown order introduce list corruption?

iio_device_unregister() disables IIO buffers, which iterates and modifies
the IIO device's buffer_list using list_del_init(). Because the callback
is still active here, a concurrent hardware event can invoke
magn_3d_proc_event() which calls iio_push_to_buffers_with_timestamp().

iio_push_to_buffers_with_timestamp() iterates the exact same buffer_list
locklessly. Can iterating this linked list concurrently with node deletion
cause list corruption and an eventual use-after-free?

>  	hid_sensor_remove_trigger(indio_dev, &magn_state->magn_flux_attributes);
>  }

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential alignm=
ent
and out-of-bounds problem in magn_3d_capture_sample():

magn_3d_capture_sample() {
    ...
    magn_state->timestamp =3D
        hid_sensor_convert_timestamp(&magn_state->magn_flux_attributes,
                                     *(s64 *)raw_data);
    ...
}

Does casting the raw_data buffer directly to an s64 pointer guarantee
alignment and bounds safety?

Since raw_data points directly into the parsed HID report, it might not be
8-byte aligned, which could cause an alignment fault on architectures that
do not support hardware unaligned access.

Additionally, if the device hardware reports a smaller data length (such as=
 a
32-bit timestamp), dereferencing it as an s64 will read past the valid
boundaries of the HID report payload.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-5-june-hid=
-iio-race-fixes-v2-0-1cfabcd1881e@gmail.com?part=3D7
