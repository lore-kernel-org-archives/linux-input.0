Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB5D3D524E
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540946; cv=none; b=uGoTE0BOO77tS/DlYlDaqSymz+FZaZQatGfkPdTb/EvWRv6OAoUSEu/KKEUa7LpTfu5vdczhrLGP0yRR2Sq1W8IQyFUIyI4JNM2Ey/ku0oQQppU7h8UPZnNuVBoF2b+YxbjSZdQzdNEQBX768pqB/Shrd4Zb96eANKi3shhZJU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540946; c=relaxed/simple;
	bh=RYxzO0wXG6bnifioaSfiSo/ppLL/ZspPteoM12r+5BQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YpPJKktFFy2gob2OcNQ9h63FB0wmXM2f46N7kHoBPSdQ4RLmDDI3mhagsSDuiBUmZaqFU9oKYlL1Qt2zzASuzcJLoCJodWexqznhFK6xOUX/jqnbxp7Ilq/1WE202+oCD6I5kdokLrduCgX9109iRtOZ86f1iUbvRH7s5Z4Vkss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfaxKhiD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfaxKhiD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333371F000E9;
	Mon, 20 Jul 2026 09:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784540944;
	bh=WKVpHsz/6a/8xxTChJ01iiL87EP98iNYjjHoG3Y4l5Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IfaxKhiDSpmtv89wNw3lYvPeKH3vIYbBUigGeBD4Rl+G4cdOT4BIx33c0K6TY6Jwi
	 rAQtcWmxaYZubUYbzCYinEI8HkXwvJLLLG72qnUCwwhe5LtAMH5GIbQb3qIg6IroGU
	 gCCKEnV3LFKMbo82p/GWzYd8qWAX5i/xUr1DANkim4Omjxyr8YN+OO94JiRWnPuExZ
	 P16D8UaHQR5HXrYIxIam9F8J2UcGDAgSpToTF18eizNabDqln332xfx3C7SXXeJPiY
	 xn575UbEZe4ybhzEzOyUdeO1I8zU1OGUYnOsdvC8Is/L8hiYZv1E7Pw98O0zkrc7WY
	 RTKag7e5T7zNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/10] iio: humidity: hid-sensor-humidity: use local
 struct device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260720-hid-iio-local-struct-device-v1-1-74496fee6327@gmail.com>
References: <20260720-hid-iio-local-struct-device-v1-0-74496fee6327@gmail.com>
 <20260720-hid-iio-local-struct-device-v1-1-74496fee6327@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 09:49:03 +0000
Message-Id: <20260720094904.333371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver shares a single, global static `struct hid_sensor_hub_c=
allbacks humidity_callbacks` across all device instances, leading to cross-=
device data corruption and potential Use-After-Free if multiple devices are=
 probed.
--

--- Patch [1]: [PATCH 01/10] iio: humidity: hid-sensor-humidity: use local =
struct device ---
commit e9be49bc2265ade3aeb3c548b989cbea2029fdd4
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: humidity: hid-sensor-humidity: use local struct device

This commit introduces a local struct device pointer derived from pdev->dev
in hid_humidity_probe() to avoid repeated usage and improve readability.

> diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/hum=
idity/hid-sensor-humidity.c
> index 7cec81ff56856..1b254d3aeee90 100644
> --- a/drivers/iio/humidity/hid-sensor-humidity.c
> +++ b/drivers/iio/humidity/hid-sensor-humidity.c
> @@ -196,10 +196,11 @@ static int hid_humidity_probe(struct platform_devic=
e *pdev)

[Severity: High]
This is a pre-existing issue, but does sharing a single global static
humidity_callbacks structure across all device instances lead to cross-devi=
ce
data corruption?

Looking at hid_humidity_probe(), it unconditionally overwrites the shared
static callback structure with the pdev of the most recently probed instanc=
e:

hid_humidity_probe(struct platform_device *pdev)
{
        ...
        humidity_callbacks.pdev =3D pdev;
        ret =3D sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_HUMIDI=
TY,
                                           &humidity_callbacks);
        ...
}

If multiple HID humidity sensors are probed, the static humidity_callbacks
struct is overwritten. If an earlier probed device generates an event, the
callback functions will receive the wrong pdev.

Additionally, if the most recently probed device is disconnected, its pdev =
is
freed. If the remaining connected device generates an event, could the driv=
er
dereference a dangling pointer?

Should the callbacks struct be allocated per-device inside the dynamically
allocated state structure instead of being defined globally as a static
variable?

>  	struct iio_dev *indio_dev;
>  	struct hid_humidity_state *humid_st;
>  	struct iio_chan_spec *humid_chans;
> -	struct hid_sensor_hub_device *hsdev =3D dev_get_platdata(&pdev->dev);
> +	struct device *dev =3D &pdev->dev;
> +	struct hid_sensor_hub_device *hsdev =3D dev_get_platdata(dev);
>  	int ret;
> =20
> -	indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*humid_st));
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*humid_st));
>  	if (!indio_dev)
>  		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-hid-iio-lo=
cal-struct-device-v1-0-74496fee6327@gmail.com?part=3D1
