Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0764B4E2F09;
	Wed, 30 Sep 2026 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790785422; cv=none; b=CI8j5mxJHaGRcF8xUGSwFoyzuULN8LPAob4yGWuvYRApM4gq1OhNRdI034zCy18kHu6kGJsbVOW5JJXDt4d8t/pFEprfk7emkjSD9OzEmy4Y7JcvyP0mJ76S+0ZLUmVyYYW/IQoKo07Ic+wgnlxaqpGZKjC6ZASyJFZpKlx0Uy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790785422; c=relaxed/simple;
	bh=atwyxCTi0weASzdFn3X9QaKAwCwGrZxI/E6BpiMMqns=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nn66JJHuqvG5CPfFaCHwtnJjbeh9TQO1Q17PP1KgbbSd4xMB6X6vof9lVsVSbw4l1CD6sovZM6MRpJyuPKZYYY5MaOIA1iw8xAemdhkcp+O44+K59qhK2quPVNINwpBwn3AGEXS3cRw5swyZaoXaq8iziDayur9DerC7xqPesa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVICaYJu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVICaYJu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FFA1F0089B;
	Wed, 30 Sep 2026 16:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790785413;
	bh=PVxQzSUh521E64ZLEfSjTGPuTlCUiqftsl6zqpTeVFY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cVICaYJukHMEtlC2GgJCb4geC15iSN5WmCdctfK+UjY3dQ9TIkpa7YIbFLBXBbxmY
	 LF3kX0S0MVRxQ0Gvh/oH4m8eP0mnxOCiEsr2udWu3x0njo96wC+2rlvNuxJtmj6k6E
	 LSrJOrl+hmqSWi8HrRPOk7ooZGI9us7KDPxQh2paK/vTk1+7D9B9y+9wjXijvGb0Cq
	 01AhBVAEI1ggii7c2q8apKV3nuxlhe/qGfMQulj03zA/TyeiVOSMRq6tmZhKZGiMkY
	 E7uSyqxzJ+5RxZrlp6j2gh2AcjnyyD1qqAcSpVPpqxqGpZC/Nwsj1pJd4BFNpFiOda
	 ZmXYPX4cHMU+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] Input: aw8697 - Add Awinic AW8697 haptics driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Armandas Kvietkus" <armandas.kvietkus@proton.me>
Cc: dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260930-mainlining-v1-2-c303cbdb00c8@proton.me>
References: <20260930-mainlining-v1-0-c303cbdb00c8@proton.me>
 <20260930-mainlining-v1-2-c303cbdb00c8@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 16:23:32 +0000
Message-Id: <20260930162332.E8FFA1F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] input: aw8697: race condition during suspend can issue I2C transac=
tions on suspended bus
- [Low] input: aw8697: coding style violation using return action() instead=
 of returning 0
- [Low] input: aw8697: NULL devname passed to devm_request_threaded_irq() d=
egrades /proc/interrupts
--

commit dd92c3df60822c4f873b6120f364c5b675f8a5a7
Author: Armandas Kvietkus <armandas.kvietkus@proton.me>

Input: aw8697 - Add Awinic AW8697 haptics driver

This commit adds a driver for the Awinic AW8697 LRA haptic driver IC,
providing force feedback support with rumble capabilities.

> diff --git a/drivers/input/misc/aw8697.c b/drivers/input/misc/aw8697.c
> new file mode 100644
> index 0000000000000..3155321cb37be
> --- /dev/null
> +++ b/drivers/input/misc/aw8697.c
[ ... ]
> +static int aw8697_play(struct aw8697_data *haptics)
> +{
[ ... ]
> +	err =3D regmap_update_bits(haptics->regmap, AW8697_SYSCTRL_REG,
> +				 AW8697_SYSCTRL_PLAY_MODE_MASK |
> +					AW8697_SYSCTRL_BST_MODE_BOOST |
> +					AW8697_SYSCTRL_WORK_MODE_STANDBY,
> +				 FIELD_PREP(AW8697_SYSCTRL_PLAY_MODE_MASK,
> +					    AW8697_SYSCTRL_PLAY_MODE_RAM) |
> +					AW8697_SYSCTRL_BST_MODE_BOOST);
> +	if (err)
> +		return err;
> +
> +	return regmap_set_bits(haptics->regmap, AW8697_GO_REG, AW8697_GO);
> +}

[Severity: Low]
Does this violate the input subsystem maintainer style preference for
explicit error paths? The guideline suggests avoiding the return action()
pattern when returning error codes in functions with multiple failure
points, and instead explicitly checking the error and returning 0 on
success.

[ ... ]
> +static int aw8697_hw_init(struct aw8697_data *haptics)
> +{
[ ... ]
> +	err =3D regmap_write(haptics->regmap, AW8697_RSPARE_REG, 0x68);
> +	if (err)
> +		return err;
> +
> +	return regmap_clear_bits(haptics->regmap, AW8697_BSTAUTO_REG,
> +				 AW8697_BSTAUTO_AUTOSW);
> +}

[Severity: Low]
This isn't a bug, but should this also be updated to use the expanded
error check form, similar to the style suggestion above?

[ ... ]
> +static int aw8697_ram_init(struct aw8697_data *haptics)
> +{
[ ... ]
> +	err =3D regmap_noinc_write(haptics->regmap, AW8697_RAMDATA_REG,
> +				 aw8697_waveform, ARRAY_SIZE(aw8697_waveform));
> +	if (err)
> +		return err;
> +
> +	return regmap_clear_bits(haptics->regmap, AW8697_SYSCTRL_REG,
> +				 AW8697_SYSCTRL_RAMINIT);
> +}

[Severity: Low]
This isn't a bug, but it also uses the return action() pattern that is
discouraged by input subsystem style guidelines.

[ ... ]
> +static int aw8697_f0_calibrate(struct aw8697_data *haptics)
> +{
[ ... ]
> +	dev_dbg(haptics->dev, "LRA f0 %d.%d Hz, trim %d\n",
> +		f0 / 10, f0 % 10, step);
> +
> +	return regmap_write(haptics->regmap, AW8697_TRIMLRA_REG,
> +			    step & AW8697_TRIMLRA_MASK);
> +}

[Severity: Low]
This isn't a bug, but it also uses the return action() pattern.

[ ... ]
> +static int aw8697_probe(struct i2c_client *client)
> +{
[ ... ]
> +	err =3D regmap_read(haptics->regmap, AW8697_SYSINT_REG, &val);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to clear interrupts\n");
> +
> +	err =3D devm_request_threaded_irq(dev, client->irq, NULL, aw8697_irq,
> +					IRQF_ONESHOT, NULL, haptics);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to request irq\n");

[Severity: Low]
Does passing a NULL devname to devm_request_threaded_irq() degrade
/proc/interrupts readability? Since the IRQ core uses the devname pointer
to display the interrupt name, passing NULL causes it to display
generically as (null). Could this be replaced with a descriptive string?

[ ... ]
> +static int aw8697_suspend(struct device *dev)
> +{
> +	struct aw8697_data *haptics =3D dev_get_drvdata(dev);
> +
> +	guard(mutex)(&haptics->input_dev->mutex);
> +
> +	if (input_device_enabled(haptics->input_dev))
> +		aw8697_halt(haptics);
> +
> +	return 0;
> +}

[Severity: High]
Is there a race condition here during suspend that could issue I2C
transactions on a suspended bus?

When a force-feedback effect is active and the system enters suspend,
aw8697_suspend() halts the motor and cancels pending work via
aw8697_halt(). However, this doesn't appear to inhibit the ff-memless
background timer from re-firing.

If the timer fires concurrently or after this suspend callback, it will
call aw8697_play_effect() which schedules play_work on the non-freezable
system_wq:

aw8697_play_effect() {
        ...
        haptics->level =3D level;
        schedule_work(&haptics->play_work);
        ...
}

Could this cause the workqueue to execute and issue I2C writes
after the bus is suspended, leading to bus timeouts or a kernel hang?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-mainlining=
-v1-0-c303cbdb00c8@proton.me?part=3D2
