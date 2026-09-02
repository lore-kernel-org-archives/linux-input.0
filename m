Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB83266565
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 01:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788312051; cv=none; b=K8XFTZIcy1cXZeDJiMO4FgmpBIxgUkOGMssZuaJYR6KL2jgo1Xt+OydUc7pcMEWfEQV04xD8H4qPQ/ZpDgTf4kcqu89hso0dreaSxcEf73k54PqlW3s+Cs151Rc2XD50ulzi1P5pnH6SEj2wAgfStaBBzZHFnfEXYPLRH4mUZcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788312051; c=relaxed/simple;
	bh=L9vQ/3W2+tll7C0ygLYIXxhpAA1cpn+IMbk+ZE+dJ/4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Of8cdM1pk/UMD7MKB+TRq7/ZpEarpJ3QAMrd+5++21acNh8F/xvG2mo6GbQIKZxff62b3fW/CROi6l1veYpyC6lUXl0rjlvSzThH3VkGK7UrZ6/HMh9Q+aOaGVbd81sGqSBa5tonzJQzOv3dqjp73kvH5+q2IZjd0Uojb4PmuVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeSXD9IO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeSXD9IO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A657A1F000E9;
	Wed,  2 Sep 2026 01:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788312049;
	bh=qi2cCkvpu0GZ/X8vSuetWgHX91l8Ie0p4YOtz8FNpBs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eeSXD9IOutpJ+x7rhyuPQFXMOH8YgpmuMKeIRmufW7fl9pwg2Qa8rVVj7B/Qljztv
	 gfOVu90T5UiTTl0gQLs4tqAP3TxmsM16Rc+t5CVJVMO/3h4kgQO8/VvmTE/azTj1xE
	 Ryr2XmVcdcvqSGR/7YaGaT8olj8Bn4uHw9HhEdwE3uxEZAzF9KQNeDVvBb/luoVqAc
	 2xQ915Qhyq5VWB6MLPasSte4d9NOvbjNCOBo2JgarjyPSODTWe3GWvy1mTm96j6AJY
	 840HLMROXMwuCzLEVNuLh4DGz/blb/x4kiWkDr6g33mn4NDerYjXsyrKFYeJ2/OM8S
	 tC7sg4sN7LURA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/12] Input: xbox_gip - Add controllable LED support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260902010237.865772-4-vi@endrift.com>
References: <20260902010237.865772-1-vi@endrift.com>
 <20260902010237.865772-4-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 01:20:49 +0000
Message-Id: <20260902012049.A657A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] LED classdev remains registered after driver disconnect, leading t=
o a Use-After-Free vulnerability.
--

commit c366b72f3332d21395d97672e39c1566b23f91d5
Author: Vicki Pfau <vi@endrift.com>

Input: xbox_gip - Add controllable LED support

This commit adds controllable LED support for Xbox One controllers. It supp=
orts
both monochrome white LEDs and RGBW addressable LEDs for Elite 2 controller=
s,
exposing them as LED class devices.

> diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joysti=
ck/gip/gip-core.c
> index 11196afdce33f..23ab0768580f5 100644
> --- a/drivers/input/joystick/gip/gip-core.c
> +++ b/drivers/input/joystick/gip/gip-core.c

[ ... ]

> +static int gip_guide_led_probe(struct gip_attachment *attachment, struct=
 device *dev)
> +{
> +	int rc =3D 0;
> +
> +	if (!gip_supports_system_message(attachment, GIP_CMD_LED, false))
> +		return 0;
> +
> +	if (attachment->features & GIP_FEATURE_GUIDE_COLOR) {
> +		struct mc_subled *mc_led_info;
> +		struct led_classdev_mc *mc_cdev =3D &attachment->guide_led.color;
> +		struct led_classdev *cdev =3D &mc_cdev->led_cdev;
> +
> +		mc_led_info =3D devm_kcalloc(dev, 4,
> +			sizeof(*mc_led_info), GFP_KERNEL);
> +		if (!mc_led_info)
> +			return -ENOMEM;
> +
> +		mc_led_info[0].color_index =3D LED_COLOR_ID_RED;
> +		mc_led_info[0].intensity =3D 51;
> +		mc_led_info[1].color_index =3D LED_COLOR_ID_GREEN;
> +		mc_led_info[1].intensity =3D 51;
> +		mc_led_info[2].color_index =3D LED_COLOR_ID_BLUE;
> +		mc_led_info[2].intensity =3D 51;
> +		mc_led_info[3].color_index =3D LED_COLOR_ID_WHITE;
> +		mc_led_info[3].intensity =3D 51;
> +
> +		mc_cdev->subled_info =3D mc_led_info;
> +		mc_cdev->num_colors =3D 4;
> +
> +		cdev->brightness =3D 51;
> +		cdev->max_brightness =3D 255;
> +		cdev->flags =3D LED_CORE_SUSPENDRESUME | LED_RETAIN_AT_SHUTDOWN;
> +		cdev->brightness_set_blocking =3D gip_guide_color_led_set;
> +		cdev->name =3D devm_kasprintf(dev, GFP_KERNEL,
> +			"%s:rgb:power", dev_name(dev));
> +		if (!cdev->name)
> +			rc =3D -ENOMEM;
> +
> +		if (!rc)
> +			rc =3D devm_led_classdev_multicolor_register(dev,
> +				mc_cdev);

[Severity: High]
Does binding this LED to the input device's lifecycle cause a use-after-free
if the controller is disconnected while an input event node is still open?

Since the devres action for unregistering the LED is bound to the input dev=
ice
(&input->dev), the LED will remain registered as long as userspace holds an
evdev file descriptor open.

However, during driver unbind, gip_disconnect() calls:
devm_kfree(to_gip_device(attachment), attachment);

This immediately frees the attachment structure containing the registered=20
led_classdev and led_classdev_mc structures. Subsequent accesses to the LED=
's=20
sysfs attributes (such as changing brightness via gip_guide_color_led_set)=
=20
would then dereference this freed memory.

Should this register against the physical device instead, such as=20
to_gip_device(attachment), to ensure the LED is unregistered synchronously=
=20
during driver unbind?

[ ... ]

> +	} else {
> +		struct led_classdev *cdev =3D &attachment->guide_led.standard;
> +
> +		cdev->max_brightness =3D GIP_LED_GUIDE_MAX_BRIGHTNESS;
> +		cdev->brightness =3D GIP_LED_GUIDE_INIT_BRIGHTNESS;
> +		cdev->flags =3D LED_CORE_SUSPENDRESUME | LED_RETAIN_AT_SHUTDOWN;
> +		cdev->brightness_set_blocking =3D gip_guide_led_set;
> +		cdev->name =3D devm_kasprintf(dev, GFP_KERNEL,
> +			"%s:white:power", dev_name(dev));
> +		if (!cdev->name)
> +			return -ENOMEM;
> +
> +		rc =3D devm_led_classdev_register(dev, cdev);

[Severity: High]
Can this similarly cause a use-after-free since the standard LED is also
registered using the input device as the devres parent?

[ ... ]

> @@ -1150,6 +1261,10 @@ static int gip_setup_input_device(struct gip_attac=
hment *attachment)
>  	if (rc)
>  		goto err_free_device;
> =20
> +	rc =3D gip_guide_led_probe(attachment, &input->dev);

[Severity: High]
By passing &input->dev instead of the physical device to gip_guide_led_prob=
e(),
the LED lifecycle becomes tied to the input device.

Input devices only run their devres actions when the last userspace referen=
ce
is released. If the LED memory resides in attachment, shouldn't the LED be
tied to the attachment's device so that unregistration happens before the
attachment is freed?

> +	if (rc)
> +		gip_err(attachment, "Failed to register LEDs: %d\n", rc);
> +
>  	return 0;
> =20
>  err_free_device:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902010237.8657=
72-1-vi@endrift.com?part=3D3
