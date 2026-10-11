Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7360242D75F;
	Sun, 11 Oct 2026 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723492; cv=none; b=bbIrjEcz2MMnR6cisbQplZnxFT7Yv/poDzBCGFp/Epxu17C9jqePBRm9ZNI4iyg4QWvcQ/QcAIxi7YoaJf72oXBql3jOoIHmNEnWQNV5XQN/E1ZWdjC8zPylnQdbelUrhgC+lc8vtUAXiLdEJWP+f6TbhvEZonfVeOLoOHLC0oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723492; c=relaxed/simple;
	bh=DX6llhpFtoDb4aFjD5zaFUIgYPU5tnEvYZ0rafn2GAc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=KoIbA3ZiCVRWQKZuZM5QAhz1i7joLwKIyiToIvE6PLE2wlkpfJaiVzDhf8YTvVk9SYlOraxyxKOiwr1YOaT34i5DrZxcLYNj5xumpIvpqhRVdhU4Tlr9ZillIL5kGgahPhjiaAjcWQxAK+EDvgmuhqn/JBFzcZn6LJ8meYsboDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COSFPMIu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COSFPMIu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CDC1F0089B;
	Sun, 11 Oct 2026 12:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791723491;
	bh=qdKtLbkoT5VGP98wqAKW3666wxFngeILpnpmWR84u3o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=COSFPMIui2XQL805LqLXF41ofmaFBJwh0IL/0hgXhLdMcJ10hiT7g0g8IzI0cB/ov
	 5hzAM2b9fjd7GJzFE+yqgw0MRO/hz4qkJnLX806QOSGYkZrL4CQMHzn14ZgHMkOS0N
	 Xjl3Ed72JSsvwCzECvsNOeK+dqafiDG2fLUniX25YFgooa75MjjLb1/Q48BVl3Y7GJ
	 ffDrBylgQdFvRQc8/OsRfpjhx8FwgGrfffXK/eQl8HMaY+Hpz0QvVAEm8uzcEmb2Vk
	 okvkBddtDglKZSxdh3lKb9PCpzJB+l+LWPCf/PFa6DE6+MY0RDs2dYR1oWDAifJ3Ym
	 cL8zg0kLGCrUQ==
Message-ID: <sashiko-outbox-167233@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] Input: s6sy761 - add reset GPIO support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Timmermann" <foss@timmermann.space>
Cc: conor+dt@kernel.org, linux-input@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261011-lat3st-google-raven-touch-upstream-v1-3-2a9f55159b9e@timmermann.space>
References: <20261011-lat3st-google-raven-touch-upstream-v1-0-2a9f55159b9e@timmermann.space>
 <20261011-lat3st-google-raven-touch-upstream-v1-3-2a9f55159b9e@timmermann.space>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 12:58:10 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] input: Unbalanced devm cleanup calling disable_irq() and regulator=
_bulk_disable()
- [Medium] input: Regulator and GPIO state leak on resume failure
- [Low] input: Unconditional 10ms delay for optional reset GPIO
--

commit 4cab9258eec8d868d79c658c070f807a7b520161
Author: Lukas Timmermann <foss@timmermann.space>

Input: s6sy761 - add reset GPIO support

This commit introduces support for an optional reset GPIO to the s6sy761 dr=
iver.
It asserts the reset line on power down and deasserts it 10 ms after enabli=
ng
supplies during power on. This ensures the controller is held in reset while
supplies are coming up, mirroring the vendor driver's behavior.

> diff --git a/drivers/input/touchscreen/s6sy761_core.c b/drivers/input/tou=
chscreen/s6sy761_core.c
> index 0e455060dbc0b..8541cd9aa930b 100644
> --- a/drivers/input/touchscreen/s6sy761_core.c
> +++ b/drivers/input/touchscreen/s6sy761_core.c

[ ... ]

> @@ -297,6 +299,9 @@ static int s6sy761_power_on(struct s6sy761_data *sdat=
a)
>  	if (ret)
>  		return ret;
> =20
> +	usleep_range(10000, 11000);
> +	gpiod_set_value_cansleep(sdata->reset_gpio, 0);

[Severity: Low]
Could this delay be skipped if reset_gpio is NULL?

The commit message states "The GPIO is optional, so boards without it are
unaffected", but the 10ms sleep appears to execute regardless of whether
reset_gpio is valid or NULL.

Would this unnecessarily slow down probe and system resume on boards without
the GPIO?

[Severity: Medium]
Will an early return later in this function fail to clean up the regulators
and the newly added reset GPIO?

If the hardware stops responding during the I2C boot checks in system resum=
e,
s6sy761_power_on() returns an error here:

    /* double check whether the touch is functional */
    ret =3D s6sy761_read(sdata, S6SY761_READ_ONE_EVENT,
                       S6SY761_EVENT_SIZE, buffer);
    if (ret < 0)
        return ret;

Since devres does not run on resume failures, this error propagates to the =
PM
core without cleanup. Could this permanently leak the regulator enable count
and leave the GPIO deasserted?

> +
>  	msleep(140);
> =20
>  	/* double check whether the touch is functional */

[ ... ]

> @@ -370,6 +375,7 @@ static void s6sy761_power_off(void *data)
>  	struct s6sy761_data *sdata =3D data;
> =20
>  	disable_irq(sdata->irq);
> +	gpiod_set_value_cansleep(sdata->reset_gpio, 1);
>  	regulator_bulk_disable(ARRAY_SIZE(sdata->regulators),
>  						sdata->regulators);
>  }

[ ... ]

> @@ -406,6 +412,12 @@ int s6sy761_probe(struct device *dev, const struct s=
6sy761_bus_ops *bus_ops, int
>  	if (err)
>  		return err;
> =20
> +	sdata->reset_gpio =3D devm_gpiod_get_optional(dev, "reset",
> +						    GPIOD_OUT_HIGH);
> +	if (IS_ERR(sdata->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(sdata->reset_gpio),
> +				     "failed to get reset GPIO\n");
> +
>  	err =3D devm_add_action_or_reset(dev, s6sy761_power_off, sdata);

[Severity: High]
Does this queue the devm action before the regulators are enabled and before
the IRQ is requested?

If probe fails early, devres unwinds and executes s6sy761_power_off(). Also,
on a successful probe, devres will execute in LIFO order during unbind, fir=
st
freeing the IRQ via devm_free_irq(), and then executing s6sy761_power_off().

In both cases, this would blindly call disable_irq() on an unrequested or
already-freed IRQ, and call regulator_bulk_disable() on unenabled regulator=
s.

Could this corrupt the IRQ disable depth and trigger regulator framework
underflow warnings?

>  	if (err)
>  		return err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-lat3st-goo=
gle-raven-touch-upstream-v1-0-2a9f55159b9e@timmermann.space?part=3D3
