Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958B531280C;
	Sun, 11 Oct 2026 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791738133; cv=none; b=ZWxdTtiF2W1FV9Tam2wdeeMh1xVXVYLWrqd/t2gMFKIx1yrABy/+ZonzNFLkUynLNAHMHw+xtiZPFs9Q5Hm7wEvuPqKsxdxGwejFe1IWp3epDUFI+P60xIJxnAtvsI4aZyR80z8e5zPMWBLjZ/GG5DTacA4zzzt7M3dNYpWq8kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791738133; c=relaxed/simple;
	bh=LYy+VSiVSGJzFYKrNe+ayOLOKl9lZ5wzlFiBI2EsrO4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=WZrY6C6dq5uarBlaq/JuQtFshe/YO/zn/Q6ZQa2ABXfcqeYXfDzUh8deBn2ge6JLXuYbqg7N6RD/vYQRkcF3CGcZGCKXuQB9Vx5KuLggHDh/acQIG7wQBWj2xY2gBfoGT+ieWSuMBG3dhwrvnwm4uGoxIXiuoBU4gfDI27zvbXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZPp8ZCL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZPp8ZCL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9391F0089B;
	Sun, 11 Oct 2026 17:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791738132;
	bh=1xaBRatMDs5igjtmDFa+l0ggLtRWCT5Utm5Y6RCNMHo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FZPp8ZCLtSZX2+vvK5kJgFaAg7+CF6gMfFJZ27U84Ccv7/KJQve5l3udXXTYDUWr7
	 RTmPT3jh4q0VsuGhL+m8dd5SusjkcdB4fCgAo2xWVH+M2arEaRBwUZBttK2t+Vc4zA
	 D7KEkj9gX/lnTxRjvRlL9a0PeiMokrN9nCjrwqA/JwD8LxzSZkMHDpDrwL9uXAQE3n
	 qm3brjRU3wbMgVHFVQDyKVR07nDfFWBsH3kISoEE53xUnJuj1yn9ldF3Yws44VrodM
	 UvFmzBKT6WtPbE5TUSrDO4AbN8DfeeKYY8LEmQq3zcqKQDMy0H3GKgaVBp5GoTqfUi
	 nYTirHOy2ZtJg==
Message-ID: <sashiko-outbox-167330@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/7] thermal: qcom: tsens: Add support for MSM8952
 tsens
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: dmitry.torokhov@gmail.com, conor+dt@kernel.org, linux-input@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20261011-msm8952-initial-support-v5-4-1857074992ec@mainlining.org>
References: <20261011-msm8952-initial-support-v5-0-1857074992ec@mainlining.org>
 <20261011-msm8952-initial-support-v5-4-1857074992ec@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 17:02:11 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] thermal: qcom: tsens: OOB write in init_8952() due to missing DT b=
ounds check
- [High] thermal: qcom: tsens: UAF in probe due to __init on init_8952
- [Medium] thermal: qcom: tsens: hardware interrupt left enabled on probe e=
rror
--

commit 348b40706a606c87400c1bc3052d8b80b1d7ed76
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

thermal: qcom: tsens: Add support for MSM8952 tsens

This commit adds support for the TSENS v1 block found on the MSM8952 SoC. It
introduces initialization functions, operations, and platform data for the =
11
sensors present on the device. Sensor offsets are adapted from downstream
sources.

Link: https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-w=
ear-7.0.0_r0.3/drivers/thermal/msm-tsens.c#1621

> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens=
-v1.c
> index faa5d00788ca6..7bda8e6087c40 100644
> --- a/drivers/thermal/qcom/tsens-v1.c
> +++ b/drivers/thermal/qcom/tsens-v1.c
> @@ -145,6 +145,34 @@ static const struct reg_field tsens_v1_regfields[MAX=
_REGFIELDS] =3D {
>  	[TRDY] =3D REG_FIELD(TM_TRDY_OFF, 0, 0),
>  };
> =20
> +static int __init init_8952(struct tsens_priv *priv)

[Severity: High]
Does marking this new initialization callback with __init lead to a
use-after-free during a late probe?

The __init attribute means this function's memory is discarded after system
or module initialization.

The tsens_probe() function is not marked __init and executes
priv->ops->init(priv) during its setup phase.

If the platform device defers probing until after .init.text is freed, or
if a user unbinds and rebinds the driver via sysfs, will tsens_probe() jump
to the freed function pointer and cause a use-after-free?

> +{
> +	priv->sensor[0].p1_calib_offset =3D 2;
> +	priv->sensor[0].p2_calib_offset =3D -1;

[ ... ]

> +	priv->sensor[9].p2_calib_offset =3D 0;
> +	priv->sensor[10].p1_calib_offset =3D -3;
> +	priv->sensor[10].p2_calib_offset =3D -2;

[Severity: High]
Can this code overflow priv->sensor[]?

In tsens_probe(), the flexible array priv->sensor is dynamically allocated
based on the #qcom,sensors device tree property:

drivers/thermal/qcom/tsens.c:tsens_probe() {
	...
	if (np)
		of_property_read_u32(np, "#qcom,sensors", &num_sensors);
	...
	priv =3D devm_kzalloc(dev,
			     struct_size(priv, sensor, num_sensors),
			     GFP_KERNEL);
	...
}

If a device tree provides a #qcom,sensors value less than 11, could this
initialization write beyond the allocated bounds of the array and cause a
heap buffer overflow?

> +
> +	return init_common(priv);
> +}

[Severity: Medium]
If a subsequent step in the probe fails, is the hardware interrupt left
enabled?

init_common() sets the INT_EN hardware interrupt flag.

If a later step in tsens_probe() fails, the driver returns directly without
cleaning up the interrupt:

drivers/thermal/qcom/tsens.c:tsens_probe() {
	...
		ret =3D priv->ops->calibrate(priv);
		if (ret < 0)
			return dev_err_probe(dev, ret, "%s: calibration failed\n",
					     __func__);
	...
	ret =3D tsens_register(priv);
	if (!ret)
		tsens_debug_init(pdev);

	return ret;
}

If the interrupt fires after the probe exits with an error, the Linux IRQ
subsystem will receive it without a registered handler.

Could this lead to a temporary interrupt storm until the kernel disables the
IRQ line?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-msm8952-in=
itial-support-v5-0-1857074992ec@mainlining.org?part=3D4
