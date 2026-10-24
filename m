Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792804248;
	b=rkzKvJDnUfO7qIK9lHw9m/XA10xfBIQm53VaImXYKvlft2ja0kopyiIcPQyRzy4BZwGo
	 y/FQk/RMG54TwgO8pboByr7ApZIaGEuitGsD2Vi5B7bASg8sYBCm/d9izjynGcyDyLBDE
	 jdP4XINchm38x34tH2uSgAhEBkwl4BnZC8GALxOmZZgvH3tQPmhS3G9H391tGfv+sOTLr
	 zo3UsoIWOJoXD2dx2W5A1zAHu7TVnEkdiTIvFVgmQJUUdiXnD3WHh0/996mYTVoG+mwhD
	 2XYzAcjxyyGZaQFYFgiVSWoT/unPicSqJ3QJjgrNP1YvJ7AF7MsNR96cNdHxsttCAVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792804248;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=J99I71q/bUgZg59ZTPP8VsvrsiM0lD5PIHHmAKd5IXs=;
	b=4oAPGkJxxQufTviW4ssdpfrvc8kHRmKX3CbFX1Qls21VVSrPwa7JmsH35xhNbYo7gwDA
	 gC9kfH5/oeLAgM4fYBGJuzquUOE1FvBpz3hyK0ERO62ZBhCYl3RNJ0Krw6aCJidHLWBNP
	 fSWwcg3WOIE+TWPxgS4Vw0QOeAN6h+HiGDbb1qJQob3fNCr29f+b5EWeX7Ru8QfxFoulb
	 EfQD/Wx1H/A3qyftfH9vAVX3oeuxlmJgskQhnmwVTv/OrR2ObnRwG3uOVwXDHD0Zjas32
	 i4ZeXMiNl8byyGSAmLkpBiTYR6Vu/yR/q7IYDZ2aMe6ozs3SAeqQyBCjyW5XprrREbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cz8G5Fcq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484E4606A31A;
	Sat, 24 Oct 2026 01:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cz8G5Fcq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAADE1F01825;
	Sat, 24 Oct 2026 01:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792804248;
	bh=J99I71q/bUgZg59ZTPP8VsvrsiM0lD5PIHHmAKd5IXs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cz8G5FcqZ9ir6FByimBc5vCd8DCB/c8W8xiu1A2zCyPE53u8T4xtoZslwnFRPgSJQ
	 TOP0M3V/EPec93g6ELOSTcGEyMjUKUBPX4+KczdDH9IxKgMDsk67mzwhBxSEyY/Iet
	 GUhH2cKsF0ax2dBul1ssHSEHsnqOaOkj5GrB1uhgzG1GeYTGq7Y/KbheodUx0j3YTX
	 X2ySG7ciiWrTe8xaBm/0mx6l57PizlaUyaRQubB38SqX+OB9/kqSJlZaZfugusGZj9
	 LuX2GJbIgIpNMs8X+yukMtOLGA8VAwx0JqG3Ni/r1deG3YCqCqOVG7s7UhFFzP/OeU
	 7224lusmvrf1w==
Message-ID: <sashiko-outbox-183484@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/11] HID: spi-hid: add panel follower support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jingyuan Liang" <jingyliang@chromium.org>
Cc: linux-input@vger.kernel.org, linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261024-send-upstream-v7-11-abad13174b43@chromium.org>
References: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
 <20261024-send-upstream-v7-11-abad13174b43@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 01:10:47 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] HID: spi-hid: unrecovered deassert_reset() failure in spi_hid_re=
sume()
- [Medium] HID: spi-hid: improper wakeup teardown for panel followers in pr=
obe
--

commit 35d9a38c1b6ffa8dbb3ab740ec9ce120c5b2e7a1
Author: Jingyuan Liang <jingyliang@chromium.org>

HID: spi-hid: add panel follower support

This commit adds DRM panel follower support to spi-hid so that a follower
device powers up and suspends in coordination with its panel rather than
during initial probe and standard system PM callbacks.

> diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi=
-hid-core.c
> index 3b8874ca0e1cc..496b33cdf3d46 100644
> --- a/drivers/hid/spi-hid/spi-hid-core.c
> +++ b/drivers/hid/spi-hid/spi-hid-core.c

[ ... ]

> @@ -325,28 +328,30 @@ static int spi_hid_resume(struct spi_hid *shid)
>  		return 0;
>  	}
> =20
> -	if (!device_may_wakeup(dev)) {
> -		if (shid->power_state =3D=3D HIDSPI_OFF) {
> -			shid->ops->assert_reset(shid->ops);
> +	/*
> +	 * Check power_state, not device_may_wakeup(): power/wakeup can change
> +	 * while the device is off.
> +	 */
> +	if (shid->power_state =3D=3D HIDSPI_OFF) {
> +		shid->ops->assert_reset(shid->ops);
> =20
> -			shid->ops->sleep_minimal_reset_delay(shid->ops);
> +		shid->ops->sleep_minimal_reset_delay(shid->ops);
> =20
> -			error =3D shid->ops->power_up(shid->ops);
> -			if (error) {
> -				dev_err(dev, "%s: could not power up: %d\n", __func__, error);
> -				/* Suspend runs next even if resume fails. */
> -				enable_irq(shid->spi->irq);
> -				return error;
> -			}
> -			shid->power_state =3D HIDSPI_ON;
> -			reinit_completion(&shid->reset_done);
> -			error =3D shid->ops->deassert_reset(shid->ops);
> -			if (error)
> -				dev_err(dev, "%s: failed to deassert reset: %d\n",
> -					__func__, error);
> -			else
> -				was_reset =3D true;
> +		error =3D shid->ops->power_up(shid->ops);
> +		if (error) {
> +			dev_err(dev, "%s: could not power up: %d\n", __func__, error);
> +			/* Suspend runs next even if resume fails. */
> +			enable_irq(shid->spi->irq);
> +			return error;
>  		}
> +		shid->power_state =3D HIDSPI_ON;
> +		reinit_completion(&shid->reset_done);
> +		error =3D shid->ops->deassert_reset(shid->ops);
> +		if (error)
> +			dev_err(dev, "%s: failed to deassert reset: %d\n",
> +				__func__, error);
> +		else
> +			was_reset =3D true;
>  	}

[Severity: Medium]
What happens if shid->ops->deassert_reset(shid->ops) fails in
spi_hid_resume()?

For non-followers, initial power-up goes through spi_hid_dev_init(), which
powers down the device and returns the error when deassert_reset() fails.
For panel followers, spi_hid_core_probe() leaves shid->power_state as
HIDSPI_OFF and shid->hid as NULL, and spi_hid_panel_follower_work() relies
on spi_hid_resume() for the initial power-up as well as subsequent resumes.

When deassert_reset() fails in spi_hid_resume(), was_reset remains false
while shid->power_state is set to HIDSPI_ON and the IRQ is enabled with the
device still held in reset:

drivers/hid/spi-hid/spi-hid-core.c:spi_hid_resume() {
    ...
	if (shid->hid) {
		if (was_reset && spi_hid_wait_for_reset(shid)) {
			/* No reset response: let recovery retry. */
			set_bit(SPI_HID_ERROR, &shid->flags);
			schedule_work(&shid->reset_work);
			return -ETIMEDOUT;
		}
		/* HID requests would fail while the device is not ready. */
		if (!test_bit(SPI_HID_READY, &shid->flags))
			return 0;
    ...
}

On the first power-up of a panel follower, shid->hid is NULL, so
spi_hid_resume() returns 0 without scheduling shid->reset_work. On subseque=
nt
resumes where shid->hid is non-NULL, was_reset is false and SPI_HID_READY w=
as
cleared during spi_hid_suspend(), so spi_hid_resume() again returns 0 witho=
ut
setting SPI_HID_ERROR or scheduling shid->reset_work.

Should a deassert_reset() failure in spi_hid_resume() trigger recovery (or
clean up and return the error) so the device is not left powered on in reset
and permanently uninitialized?

> @@ -1447,6 +1452,108 @@ static struct hid_ll_driver spi_hid_ll_driver =3D=
 {

[ ... ]

> +static int spi_hid_register_panel_follower(struct spi_hid *shid)
> +{
> +	struct device *dev =3D &shid->spi->dev;
> +
> +	shid->panel_follower.funcs =3D &spi_hid_panel_follower_prepare_funcs;
> +
> +	/*
> +	 * If we're not in control of our own power up/power down then we can't
> +	 * do the logic to manage wakeups. Give a warning if a user thought
> +	 * that was possible then force the capability off.
> +	 */
> +	if (device_can_wakeup(dev)) {
> +		dev_warn(dev, "Can't wakeup if following panel\n");
> +		device_set_wakeup_capable(dev, false);
> +	}
> +
> +	return drm_panel_add_follower(dev, &shid->panel_follower);
> +}

[ ... ]

> @@ -1523,21 +1618,19 @@ int spi_hid_core_probe(struct spi_device *spi, st=
ruct spihid_ops *ops,
>  		}
>  	}
> =20
> -	error =3D shid->ops->power_up(shid->ops);
> -	if (error) {
> -		dev_err(dev, "%s: could not power up: %d\n", __func__, error);
> -		return error;
> -	}
> -
> -	error =3D shid->ops->deassert_reset(shid->ops);
> -	if (error) {
> -		dev_err(dev, "%s: failed to deassert reset: %d\n", __func__, error);
> -		shid->ops->power_down(shid->ops);
> -		return error;
> +	if (shid->is_panel_follower) {
> +		/* Like the IRQ: the first panel_prepared resume enables it. */
> +		disable_work(&shid->reset_work);
> +		error =3D spi_hid_register_panel_follower(shid);

[Severity: Medium]
Does calling device_set_wakeup_capable(dev, false) in
spi_hid_register_panel_follower() after devm_pm_set_wake_irq() in
spi_hid_core_probe() leave the wake IRQ configured and leak
dev->power.wakeup if wakeup was enabled on the device before probe?

In spi_hid_core_probe(), if the firmware node marked the device as wakeup
capable (for example via acpi_bind_one()), device_can_wakeup(dev) is true a=
nd
devm_pm_set_wake_irq(dev, spi->irq) attaches a wake IRQ before
shid->is_panel_follower is checked:

drivers/hid/spi-hid/spi-hid-core.c:spi_hid_core_probe() {
    ...
	if (device_can_wakeup(dev)) {
		error =3D devm_pm_set_wake_irq(dev, spi->irq);
		if (error) {
			dev_err(dev, "%s: failed to set wake IRQ\n", __func__);
			return error;
		}
	}

	if (shid->is_panel_follower) {
		/* Like the IRQ: the first panel_prepared resume enables it. */
		disable_work(&shid->reset_work);
		error =3D spi_hid_register_panel_follower(shid);
    ...
}

Furthermore, if a wakeup_source was attached to dev->power.wakeup (for
example via sysfs power/wakeup before async or deferred probe completes),
calling device_set_wakeup_capable(dev, false) directly sets
dev->power.can_wakeup =3D false without detaching the wakeup source first.
Subsequent calls to device_wakeup_disable(dev), including from
device_pm_remove() on unbind, check dev->power.can_wakeup and return early:

drivers/base/power/wakeup.c:device_wakeup_disable() {
	struct wakeup_source *ws;

	if (!dev || !dev->power.can_wakeup)
		return;

	ws =3D device_wakeup_detach(dev);
	wakeup_source_unregister(ws);
}

Should spi_hid_register_panel_follower() use device_init_wakeup(dev, false)
(which calls device_wakeup_disable(dev) before clearing wakeup capability),
and should spi_hid_core_probe() skip devm_pm_set_wake_irq() when
shid->is_panel_follower is true?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-send-upstr=
eam-v7-0-abad13174b43@chromium.org?part=3D11
