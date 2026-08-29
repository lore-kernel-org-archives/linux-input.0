Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBCA33F5A9
	for <linux-input@vger.kernel.org>; Sat, 29 Aug 2026 11:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788002843; cv=none; b=W1Cv8r4HnB25OVsTjUG/Mumfc086jP316cg1tLwH1UyeLeQ1RCug7hSHFRzGpk8bC7eFGyPAwwjchzX/x9HVTLhgoCetKTQ+U++wE6hyXw/Fx3jRHS0x/vZqI6jEQRM5DF8u1X6/itlubzYPNblJ1465MW6QRUP3PSAhGn1fkWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788002843; c=relaxed/simple;
	bh=JWzsOc5kLTs8EUA4l9R7PIQzeQKd5x06DWI745OQfqw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pPg54Uuf9rATS4Xmw63oSvJ/A2yYin4B+4XKUS9c6g2oOjpuW3a+KtAf03UvXTVD76iJHGX6jVBRuQ0NqEv5n1lg94HMuso5pqm7G1OPqD2cHip7RdgSwPVmx2lybGFneQcjJs2iO5PnzCda3BMOQQ5bOMCmpyLAM5dpWsGtl80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eac2zsaf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eac2zsaf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F46C1F000E9;
	Sat, 29 Aug 2026 11:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788002841;
	bh=zuLbzE8tkFQSM8FcFmMEg6Cgm5EAPP1ia/72clCKusY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eac2zsafSx3r0pWF1dCKmvBUuO414bvCWw6HtoKp6BSohdOwUJh1fDco0enJW/ZUZ
	 DAKYZDWJN51L1t/a3xYO1AN19TDmQUgVRh+zIrTYWAo7oBzNXDoGlEY+tJI0s0dUbQ
	 SHxrPDw2VguEGRIMPgWGpsC67a6m2MiNYB7jr7aGLp5ZhdLEjUlU0kQuPzO5eYeqoB
	 8jd+usFWR5ymlnYWgTLrdQjECJ3+snsSkLh7CGY7drb0/95n6BOXPdg6bsQTfdf8sn
	 SE/qBSLFWSX5LtFU0Xo2lzgL+EAp+AOmdToc+CYI59qHReaXkam/6Fkotw9cU+FWSJ
	 8mx5hKrRl2Viw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: st-keyscan - disable interrupt while clock is
 gated
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <apK-PZ5c97mCxBSC@google.com>
References: <apK-PZ5c97mCxBSC@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 11:27:20 +0000
Message-Id: <20260829112721.3F46C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Removing the hardware stop sequence in probe() fails to clear th=
e hardware state left by the bootloader. If the bootloader left the keypad =
active and asserting an interrupt, this state persists, leading to immediat=
e spurious wakeups that permanently prevent system sleep when the device is=
 configured as a wakeup source.

Pre-existing issues:
- [High] If keyscan_start() fails during system resume (e.g. clock enable f=
ails), the device remains marked as enabled. A subsequent close of the devi=
ce will invoke keyscan_stop(). This triggers a bus fault (synchronous exter=
nal abort) because writel() is called while the clock is gated, and causes =
unbalanced disable_irq() and clk_disable() calls.
--

commit cfa9ab2fa10d41e20ca2124965465f938faf3789
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: st-keyscan - disable interrupt while clock is gated

This commit fixes a bus fault during system suspend by requesting the
interrupt with IRQF_NO_AUTOEN. It also drops the clock enable and stop
sequence in probe, leaving the hardware untouched until opened.

> diff --git a/drivers/input/keyboard/st-keyscan.c b/drivers/input/keyboard=
/st-keyscan.c
> --- a/drivers/input/keyboard/st-keyscan.c
> +++ b/drivers/input/keyboard/st-keyscan.c
[ ... ]
> @@ -82,6 +84,8 @@ static void keyscan_stop(struct st_keyscan *keypad)
>  {
>  	writel(0, keypad->base + KEYSCAN_CONFIG_OFF);
> =20
> +	disable_irq(keypad->irq);
> +
>  	clk_disable(keypad->clk);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does this unconditional
teardown risk a bus fault during close if resume fails?

If keyscan_start() fails during keyscan_resume() (for instance, if
clk_enable() fails), keyscan_start() returns an error and skips enable_irq(=
).
The PM core aborts or logs the resume error, but the input device remains
marked as enabled and open.

When userspace subsequently closes the device, keyscan_stop() will execute
writel() with the clock still gated, which triggers a synchronous external
abort. Additionally, it will call disable_irq() and clk_disable(), causing
an unbalanced state since they were never enabled in resume.

The patch adds the unbalanced IRQ disable to the existing bus fault.

[ ... ]
> @@ -177,20 +181,12 @@ static int keyscan_probe(struct platform_device *pd=
ev)
>  		return dev_err_probe(&pdev->dev, PTR_ERR(keypad_data->clk),
>  				     "cannot get clock\n");
> =20
> -	error =3D clk_enable(keypad_data->clk);
> -	if (error) {
> -		dev_err(&pdev->dev, "failed to enable clock\n");
> -		return error;
> -	}
> -
> -	keyscan_stop(keypad_data);
> -
>  	keypad_data->irq =3D platform_get_irq(pdev, 0);
>  	if (keypad_data->irq < 0)
>  		return keypad_data->irq;

[Severity: Medium]
Could removing the hardware stop sequence in keyscan_probe() cause spurious
wakeups if the bootloader leaves the hardware active?

Previously, this code ensured the hardware was quiescent and its interrupt
line deasserted before registering the device. If the bootloader hands off
the hardware in an active, interrupt-asserting state, that state now
persists.

When the system suspends and enable_irq_wake() is called, could a pending
interrupt from the bootloader's hardware state immediately wake the system,
permanently preventing sleep when the device is configured as a wakeup
source?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/apK-PZ5c97mCxBSC@go=
ogle.com?part=3D1
