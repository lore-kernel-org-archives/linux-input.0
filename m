Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CB13A6B6C;
	Thu,  1 Oct 2026 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870523; cv=none; b=GeKzrPAwMj/7qDgEFkD0f4Dnn44yht7ghpiNF29EXaNUJmkJq297F+mx7HBLO0nevogBQeSVPV9c08scy0zCflQPoaZ6PDehtgAkO/YrNmUcKDQWFQFDg7O9fpu24pVe4DijkjFdWur9mJRjGIDVQcfo//RPVHOp2mJIFks/y60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870523; c=relaxed/simple;
	bh=MZ6uAo/jM/BKKzyAedUlZugCxd4f3AttOUdyJqzUvmI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ch2UmzWvHcmgLR1Gx8iX3KIaQJZjoGek1LgndOhT+OoUP2iYY0OE2gpm7HbTxnUchx4nDef712/p/BO8X3SxmEp9APJE8OlRFcR2zE3pA7+q1XS6EYUXiN2Ow7y+atRPwDy+3TLGas5T8rhCqub75bZywfzxoILQryKUKV3+K00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pyi4rC8c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pyi4rC8c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F53D1F00898;
	Thu,  1 Oct 2026 16:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790870521;
	bh=vCGXuhHmdwWl6D2vxQNlJ9dSK5DWMJDkuH9n1qMUJsU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pyi4rC8cAB1YlkAiGAT8JR8g8zhjo3PYTKwryy9lfXtNDnzHqrIau2yajdmM28c51
	 nTPuNy5g2ockwmbUgJLZOyjtgVpGu4RUFo8BZHPuAzhHdCRQiub311VbSKYaWCkGsX
	 K8sRsoIHEgRXgISqDCKuzzI3Yz+dYQqBiY8DaJvamUCgmH9lM3HWb3+lm2TGozwV1p
	 859bKBu+HbWSop7nxJDRqbPT6ahPt/Kz81euaK0tzSV4XnC+WhG+0XMTmy/MewBgqB
	 GBSWImC1fb5dK1lmIoPX3tkfEoUOPjaUMlgzr8M8Ys7vKGOxlDOUek2jNpPg1kTcun
	 XcX70rnyotmrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] Input: gpio-keys - support wakeup pinctrl state
 on suspend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kendall Willis" <k-willis@ti.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261001-upstream-gpio-wakeup-v3-2-6f3bcde367a3@ti.com>
References: <20261001-upstream-gpio-wakeup-v3-0-6f3bcde367a3@ti.com>
 <20261001-upstream-gpio-wakeup-v3-2-6f3bcde367a3@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 16:02:00 +0000
Message-Id: <20261001160201.4F53D1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] input: gpio-keys: silent masking of pinctrl resource acquisition=
 errors
--

commit f85782ff9c9eb4bfa803e47eea6427b48cb93f09
Author: Kendall Willis <k-willis@ti.com>

Input: gpio-keys - support wakeup pinctrl state on suspend

This commit adds support for selecting a wakeup pinctrl state during suspend
to RAM on TI K3 AM62 devices. It retrieves the pinctrl state using
devm_pinctrl_get() and looks up the wakeup state if the device is enabled.

> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/=
gpio_keys.c
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c

[ ... ]

> @@ -884,6 +887,15 @@ static int gpio_keys_probe(struct platform_device *p=
dev)
>  	platform_set_drvdata(pdev, ddata);
>  	input_set_drvdata(input, ddata);
> =20
> +	ddata->pinctrl =3D devm_pinctrl_get(dev);
> +	if (IS_ERR(ddata->pinctrl)) {
> +		error =3D PTR_ERR(ddata->pinctrl);
> +		if (error =3D=3D -EPROBE_DEFER)
> +			return error;

[Severity: Medium]
Does this code intentionally swallow all error codes from devm_pinctrl_get()
other than -EPROBE_DEFER?

If devm_pinctrl_get() fails for other reasons, such as a memory allocation
failure (-ENOMEM) or an invalid device tree configuration (-EINVAL), the
error is silently ignored. This allows the driver to probe successfully but
with silently broken wakeup functionality.=20

Should the error be returned for all failure cases to avoid masking resource
acquisition failures?

> +	} else if (ddata->pinctrl) {
> +		ddata->pinctrl_wakeup =3D pinctrl_lookup_state(ddata->pinctrl, "wakeup=
");
> +	}
> +
>  	input->name =3D pdata->name ? : pdev->name;
>  	input->phys =3D "gpio-keys/input0";
>  	input->dev.parent =3D dev;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-upstream-g=
pio-wakeup-v3-0-6f3bcde367a3@ti.com?part=3D2
