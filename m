Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5523F8ED3;
	Mon, 15 Jun 2026 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534078; cv=none; b=KA1g7Zk75ZkUiXksJVKrl/Y2XCJV0h0ZWZXN8s9MEFg/M+5gLyC34njK8x2XE+vp7w5LNTQKD0rxOvoMXKYWK6qKeAb/3SIlBD+3GIIqh8PCptI39z+BHrPopcEFPm2KkG1RvsZnFOhYq023f1GjArpwkNo/qWC6aHlxtIy+PBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534078; c=relaxed/simple;
	bh=iWZWj7L37iSmshZoi0widnyc7RCga1hkn2LxcKT6Xrs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d7V7gIpq9SF+s53QsYsb82N/TRJH8oQf87tMPjSk8+ePaN7JemqzNoCfJgbem9wpCc3etbV6okHwWhYXx5fKxl5tyODW3P4qcJkazKbxYCvsd49VXbRfDp8v9MEhS77ob0X02UqQsIU+sUoUNhkTBlXgQM5OlTV0dmgPRDrws38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/nm1f2M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/nm1f2M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183A71F000E9;
	Mon, 15 Jun 2026 14:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781534075;
	bh=5JvNdQbQCe0+C0G2rL7xFkELL7DEv2gcC/2GTnzxCI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D/nm1f2M2iUZVlxx4Iu3OetJD4RVArhhICOnGE66NqCEuZlm/wb1q4tHvOlFMvByy
	 w1IP9Kd29ziJDRtFON2Oxot2dpcuPHHYcm6c1eEfOH/1m6YuZ//uV9z8oAPWsPBoiM
	 RiDxUZZ1GVOarnQfW8Fg1jSNgffwpfMasUniXOvHAOz3GLMCUUNdvYHbmm7SLa/sjn
	 bA13idBvt0u37jBp2647Vt0tPYhbZVIwrf+JP3akzOA7va2ikg7gZ62rWBEGpRtUgB
	 0lGNnz/wtnE2ya0QdfYr32aIeBRTRmDqB+Lq0DS4LBnjyd4aPAOAj3tLGWd1BYpzwR
	 SOOYIckYjuegQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/10] Input: cap11xx - remove unused register macros
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jun Yan" <jerrysteve1101@gmail.com>
Cc: conor+dt@kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260615142103.352163-3-jerrysteve1101@gmail.com>
References: <20260615142103.352163-3-jerrysteve1101@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 14:34:34 +0000
Message-Id: <20260615143435.183A71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Removing sensor delta registers from the volatile register list =
causes regmap to incorrectly cache their values, breaking debugfs observabi=
lity.

Pre-existing issues:
- [High] The driver requests its IRQ after registering the input device, cr=
eating a race condition where an unhandled interrupt can permanently disabl=
e the device.
--

commit 72bbdd7bb3155f054afabfd004f5e097d568001b
Author: Jun Yan <jerrysteve1101@gmail.com>

Input: cap11xx - remove unused register macros
   =20
Remove unused register address macros and unused definitions in
the cap11xx_reg_defaults array and cap11xx_volatile_reg. This cleanup
reduces code clutter and makes the driver easier to maintain.

> diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/ca=
p11xx.c
> index 485d8ba977235..686174722204c 100644
> --- a/drivers/input/keyboard/cap11xx.c
> +++ b/drivers/input/keyboard/cap11xx.c

[ ... ]

> @@ -149,12 +97,6 @@ static bool cap11xx_volatile_reg(struct device *dev, =
unsigned int reg)
>  	switch (reg) {
>  	case CAP11XX_REG_MAIN_CONTROL:
>  	case CAP11XX_REG_SENSOR_INPUT:
> -	case CAP11XX_REG_SENOR_DELTA(0):
> -	case CAP11XX_REG_SENOR_DELTA(1):
> -	case CAP11XX_REG_SENOR_DELTA(2):
> -	case CAP11XX_REG_SENOR_DELTA(3):
> -	case CAP11XX_REG_SENOR_DELTA(4):
> -	case CAP11XX_REG_SENOR_DELTA(5):

[Severity: Medium]
Does removing the sensor delta registers from the volatile list cause a
regression for observability via the regmap debugfs interface?

These registers contain real-time capacitance delta hardware values that are
continuously updated by the device. Treating them as non-volatile causes
regmap to cache them on the first read, resulting in stale values for any
subsequent reads by tuning tools or developers.

>  		return true;
>  	}
> =20

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a pre-existing pro=
be
ordering flaw in cap11xx_i2c_probe():

	error =3D input_register_device(priv->idev);
	if (error)
		return error;

	error =3D devm_request_threaded_irq(dev, i2c_client->irq,
					  NULL, cap11xx_thread_func,
					  IRQF_ONESHOT, dev_name(dev), priv);

Could this sequence lead to the interrupt being permanently disabled?

Since input_register_device() exposes the device to userspace, a daemon
can immediately open the device, waking the sensor from deep sleep.

If the sensor generates a hardware interrupt before
devm_request_threaded_irq() completes, the generic IRQ core will receive an
interrupt with no registered handler.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615142103.3521=
63-1-jerrysteve1101@gmail.com?part=3D2
