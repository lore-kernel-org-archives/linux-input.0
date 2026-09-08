Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AD132BF5D
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 03:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788838777; cv=none; b=fGPYEisBZYZGR1tMJWun0iWaJXjlGoYS5F/sewOan0Yj+F5/FBDBFkeFVnbwCu7Vz55nMYJBDTNSKcYRl1h58CvKMJeMVOdCDcrRRCYzGrBLV2TyNGy9tRhsmqp8vLd3rKn92/aDQKebI3i0xXzZeRfCdD9MAX8hEXGYVPViVJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788838777; c=relaxed/simple;
	bh=Sd6mkQeqzd/lmEpDE0ja02/N0ObcF5wMlEVHYmzwnO8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rtwPPWpDShEGrdOjj8a7loJrhqnIrLcKSAPWaQKEa+5zHhsfxHNTTjHvMxtsp8OKguufQVEzLpN3Kq/rwPqums9xP+UtK8yLPzGEl2MghwCbwoP9MT0i2g+7ncjKEJnRdm+Gz+sIpNu2cMV2A5//cQrFeCkvt6+sqrGjjEgGWMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6yWFpFM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6yWFpFM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57111F00A3A;
	Tue,  8 Sep 2026 03:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788838751;
	bh=XHiymsNd9baz+rK0X1DNIvrBZQA89PVt4HYAlPzOHko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y6yWFpFM0mRvu5q+chYyoQCDgn0pqU55+nmY+/31IAUh1saFJTmy5oIdS7FmO25qT
	 DJJvBTYuuO3MbcRgE/Qp3cI4Fh3par+iE1eiePMtl186YHdJyuLpgqLRa7DZrgzVky
	 oK8sBljYSJ2qf4bgrideE7Yw+VAAa+zAMVTKFWfFkB7CD2Uklc8lRzk9GvlmADVhfV
	 hqZwCKbiwUU9Iw5tfxc6gatFMKC0ExtryqWxU3DqKbCOiio2jT8/zhCHxL1KZW96eM
	 DKolppM8GBLydh5C6QFD8wdXtlDxinQoaMdoiqi5VL3n9tuF9x8husSu8FsnnM1JSs
	 WYpcRA8DSIj8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/12] Input: xbox_gip - Add controllable LED support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260908032145.2118234-4-vi@endrift.com>
References: <20260908032145.2118234-1-vi@endrift.com>
 <20260908032145.2118234-4-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 03:39:11 +0000
Message-Id: <20260908033911.C57111F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Registering a managed LED classdev against an input device creates=
 a circular dependency, leading to memory leaks, list corruption, and kerne=
l crashes on device reconnect.

Pre-existing issues:
- [High] Repeatedly calling `devm_input_allocate_device()` against the USB =
interface without unbinding leaks `input_dev` structures on every device re=
connect.
--

commit 170b2e9725cebf9b1d26ed7fb1bf1a2b52d452c6
Author: Vicki Pfau <vi@endrift.com>
Input: xbox_gip - Add controllable LED support

This commit adds controllable LED support for Xbox One controllers. It expo=
ses=20
both monochrome white and RGBW addressable LEDs as led class devices depend=
ing=20
on the controller capabilities.

> diff --git a/drivers/input/joystick/gip/gip.h b/drivers/input/joystick/gi=
p/gip.h
> index 605149834269f..69eef001d91ff 100644
> --- a/drivers/input/joystick/gip/gip.h
> +++ b/drivers/input/joystick/gip/gip.h
> @@ -234,6 +235,10 @@ struct gip_attachment {
>  	uint8_t seq_vendor;
> =20
>  	uint8_t device_state;
> +	union {
> +		struct led_classdev standard;
> +		struct led_classdev_mc color;
> +	} guide_led;

[Severity: High]
Does embedding the led_classdev directly inside the long-lived
gip_attachment structure risk list corruption?

If the input device is reset and re-probed (for example, via a reset
message), the driver recreates the device and could call
devm_led_classdev_register() again on the exact same already-registered
led_classdev struct. This would corrupt the global leds_list and cause a
kernel crash.

> diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joysti=
ck/gip/gip-core.c
> index 0e23811a6ecc1..a5ed5f3bf3fed 100644
> --- a/drivers/input/joystick/gip/gip-core.c
> +++ b/drivers/input/joystick/gip/gip-core.c
[ ... ]
> +static int gip_guide_led_probe(struct gip_attachment *attachment, struct=
 device *dev)
> +{
[ ... ]
> +		if (!rc)
> +			rc =3D devm_led_classdev_multicolor_register(dev,
> +				mc_cdev);

[Severity: High]
Can this create a circular dependency?=20

By using devm_led_classdev_multicolor_register() in gip_guide_led_probe()
with the input_dev as the parent device, the LED child device takes a
reference to the input_dev. Since input_dev devres actions only execute when
its reference count drops to zero, the LED device is never automatically
unregistered, creating a circular reference and leaking memory.

[ ... ]
> +	} else {
> +		struct led_classdev *cdev =3D &attachment->guide_led.standard;
[ ... ]
> +		rc =3D devm_led_classdev_register(dev, cdev);

[Severity: High]
Similarly, does registering the standard LED classdev against the input dev=
ice
here create the same circular dependency preventing automatic unregistratio=
n?

[ ... ]
> @@ -1157,6 +1268,10 @@ static int gip_setup_input_device(struct gip_attac=
hment *attachment)
>  	if (rc)
>  		goto err_free_device;
> =20
> +	rc =3D gip_guide_led_probe(attachment, &input->dev);
> +	if (rc)
> +		gip_err(attachment, "Failed to register LEDs: %d\n", rc);
> +
>  	return 0;

[Severity: High]
This isn't a bug introduced by this patch, but does the allocation of the
input device earlier in gip_setup_input_device() leak input_dev structures =
on
every reconnect?

The code uses devm_input_allocate_device() with the long-lived USB interface
as the parent. When the controller resets (by sending a reset packet),
the driver correctly calls input_unregister_device(), but the devm free act=
ion
remains attached to the USB interface's devres list. A new input_dev is then
allocated for the re-initialization, leaking an entire input_dev structure
each time until the USB dongle is physically unplugged.

[Severity: High]
Also, if a controller reset causes gip_setup_input_device() to run again, d=
oes
calling gip_guide_led_probe() register the LEDs a second time without
ensuring the previous LED instances were unregistered?

Combined with embedding the led_classdev inside the attachment, this seems
like it would trigger list corruption.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908032145.2118=
234-1-vi@endrift.com?part=3D3
