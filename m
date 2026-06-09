Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318BF3438B1;
	Tue,  9 Jun 2026 04:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780981108; cv=none; b=MY+6lKnQLAYZnEUgBdWq3Iy4LZp11X4bA2AbhXpHPkpvmLDWzcvlUKbgvCoxfF+kh6vKFfrlVrWfK67Hvfe2OO2qD+wXtDO+iMB6hgElC0KcGTp0YO+EX4N9JKNSXG65wOwrRlX7AE1eRjYUhMtHkSc2vGh71+wpvXD9cgBp3GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780981108; c=relaxed/simple;
	bh=mopOCMEkKSqpIWipc4qYug5GxH/n/2wC+69F+Hb0ElQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZNqV33w/E4WxCEiOQjRSVTmO73frEkOVdYbt8aFRfuIFKXNOR7yzsc3p2QGEd2W4XVGwaO8nJf+e2Syz0UZzsheoXMKB94LqCrJ3YDkR+1MvMdDKq9RtNwqRk/+rZyYlDI3QtHwILYQcwigwx3FKHu+4FZRA5uR/GDy8ycBfnJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpG7W/uf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpG7W/uf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94131F00893;
	Tue,  9 Jun 2026 04:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780981107;
	bh=Hl4p8ylyhKoSW0YKOxCEQjpf+gzC3VCt7gt11L1iXPk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CpG7W/uf67NtJethrO70cWARNFzaZ7KIDvdhRFk8jB9KrtgaTWBlALa4PbA2fyiCC
	 R8fhBiZCBcTsiaOi9XpGOSKhes1Moa/3C5eba7Tiv55Sh0dvHMtAN1aBINoJT56lmU
	 6uBdhWIQYzqvgLRUUpSLio6j679Tn44STeMzPzukEk0CCxXh/DzMdCdTHawdfyuBce
	 7ubAM+ZfcBOd87tHcHFGu2pAIIKDDWLin7NUubpipUv1XrnI8Rl1xfKb+Mt4FscEkV
	 n9QEjXUrjLuRxQTIuwvQCvEcqocsYCmkE/Yq9bwWoHE8yPFv5Rg5V4trybvlunkYcf
	 g2Cm6xUcW4mhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/11] HID: spi-hid: add panel follower support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jingyuan Liang" <jingyliang@chromium.org>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260609-send-upstream-v4-11-b843d5e6ced3@chromium.org>
References: <20260609-send-upstream-v4-11-b843d5e6ced3@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 04:58:26 +0000
Message-Id: <20260609045826.A94131F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Leak of wake IRQ structure on probe failure or driver unbind for p=
anel followers.
- [High] Unbalanced regulator power_down during remove() for unbound panel =
followers.
- [High] Missing power_state update in spi_hid_dev_init() breaks device and=
 leaks regulator after suspend.

Pre-existing issues:
- [High] Preexisting Use-After-Free due to race between cancel_work_sync() =
and hid_destroy_device() timeouts.
--

commit 6b1c4605757961c511d63ab9f2108f26f48fd916
Author: Jingyuan Liang <jingyliang@chromium.org>

HID: spi-hid: add panel follower support

Add support to spi-hid to be a panel follower.

> diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi=
-hid-core.c
> index 517f069134775..27f25d95ed280 100644
> --- a/drivers/hid/spi-hid/spi-hid-core.c
> +++ b/drivers/hid/spi-hid/spi-hid-core.c
> @@ -1281,6 +1281,106 @@ const struct attribute_group *spi_hid_groups[] =
=3D {

[ ... ]

> +static int spi_hid_dev_init(struct spi_hid *shid)
> +{
> +	struct spi_device *spi =3D shid->spi;
> +	struct device *dev =3D &spi->dev;
> +	int error;
> +
> +	shid->ops->assert_reset(shid->ops);
> +
> +	shid->ops->sleep_minimal_reset_delay(shid->ops);
> +
> +	error =3D shid->ops->power_up(shid->ops);
> +	if (error) {
> +		dev_err(dev, "%s: could not power up\n", __func__);
> +		shid->regulator_error_count++;
> +		shid->regulator_last_error =3D error;
> +		return error;
> +	}
> +
> +	shid->ops->deassert_reset(shid->ops);
> +
> +	enable_irq(spi->irq);
> +
> +	return 0;
> +}

[Severity: High]
If a panel follower suspends before it successfully receives its hid_versio=
n,
spi_hid_suspend() will legitimately power down the device and set power_sta=
te =3D
HIDSPI_OFF.

Upon resume, spi_hid_panel_follower_work() retries initialization by calling
spi_hid_dev_init(). Since spi_hid_dev_init() does not update power_state to
HIDSPI_ON, does the state remain HIDSPI_OFF?

If so, when the reset response interrupt arrives, would spi_hid_dev_irq() d=
rop
it because it believes the device is off, leaving the device broken?
Furthermore, would any subsequent suspend return early because power_state =
=3D=3D
HIDSPI_OFF, failing to power down the regulator and causing a power leak?

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

[Severity: High]
Does explicitly executing device_set_wakeup_capable(dev, false) mutate the
dev->power.can_wakeup flag to false, which would then break the symmetry of=
 the
wake IRQ cleanup conditions?

In spi_hid_core_probe(), the wake IRQ is successfully registered if
device_may_wakeup(dev) is true. During error cleanup (err_wake_irq) or driv=
er
removal (spi_hid_core_remove()), the code conditionally calls
dev_pm_clear_wake_irq(dev) based on if (device_may_wakeup(dev)).

Since the capability was previously cleared here, will this check evaluate =
to
false and cause the driver to skip the cleanup, leaking the wake IRQ
registration?

[ ... ]

> @@ -1300,6 +1400,7 @@ int spi_hid_core_probe(struct spi_device *spi, stru=
ct spihid_ops *ops,
>  	shid->ops =3D ops;
>  	shid->conf =3D conf;
>  	set_bit(SPI_HID_RESET_PENDING, &shid->flags);
> +	shid->is_panel_follower =3D drm_is_panel_follower(&spi->dev);

[Severity: High]
During spi_hid_core_probe(), shid->power_state is unconditionally initializ=
ed
to HIDSPI_ON. For a panel follower, the actual hardware initialization and
regulator power_up() are deferred to spi_hid_panel_follower_work().

If the driver is unbound (or probe fails gracefully after device registrati=
on)
before the panel prepares, power_up() is never called. However,
spi_hid_core_remove() checks if (shid->power_state !=3D HIDSPI_OFF) and cal=
ls
power_down().

Will this trigger a power_down() on an already disabled regulator, resultin=
g in
an unbalanced regulator use-count?

[ ... ]

> @@ -1376,15 +1470,21 @@ void spi_hid_core_remove(struct spi_device *spi)
>  	struct device *dev =3D &spi->dev;
>  	int error;
> =20
> -	disable_irq(spi->irq);
> +	if (shid->is_panel_follower)
> +		drm_panel_remove_follower(&shid->panel_follower);
> +	else
> +		disable_irq(spi->irq);
> +
>  	cancel_work_sync(&shid->reset_work);
> =20
>  	spi_hid_stop_hid(shid);

[Severity: High]
This is a pre-existing issue, but is there a use-after-free risk due to a r=
ace
between cancel_work_sync() and hid_destroy_device() timeouts?

In spi_hid_core_remove(), cancel_work_sync(&shid->reset_work) is called pri=
or
to spi_hid_stop_hid(shid), which destroys the HID device. Because
disable_irq(spi->irq) is called beforehand, any concurrent HID request (lik=
e a
userspace GET_REPORT ioctl) waiting in
wait_for_completion_interruptible_timeout() will inevitably time out.

Upon timing out, the sync request handler sets the error flag and executes
schedule_work(&shid->reset_work). Since this timeout can occur after
cancel_work_sync() has already finished but before remove() concludes, the
work is freshly queued. The remove() function then frees shid, resulting in
the reset_work executing on freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-send-upstr=
eam-v4-0-b843d5e6ced3@chromium.org?part=3D11
