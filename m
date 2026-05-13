Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E36299923;
	Wed, 13 May 2026 20:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778705089; cv=none; b=fWBVDOCQPhgDBLuF+GlU6dqm48Va95VGKOauzb23W+9aXdWkqOgRFExgITDaNtqBIFEBY8uj8YXxBsQ8rlxECtqo6gKAj8gPirjakgM55TvkwB3fy+qSEVjQiUgJ5PmVWrA3eWW/2gS45aKMokULedkQrd5ZUD21OkCUgWEFEbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778705089; c=relaxed/simple;
	bh=fF8d51+pHo8Db4qt5V1Jf0RoJXvWOIYA3ub4DGmrJU0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DYwg9YuE8QMzs8tQ7apGourwamk7x7ftq/hXSHQgZ75dppfDN7AcBYj+HT12GrWup3ibxdEzrkiMwwGlpo4OSbn4ob6IxL0G+/NQdUKIQ05wXG9P+PFwTAkuWBptB2I7S6dACGZMSWPy0k6TijzKDADa+XExrrwDr3E0AIVnyi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQZ3wJqD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQZ3wJqD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90706C19425;
	Wed, 13 May 2026 20:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778705088;
	bh=fF8d51+pHo8Db4qt5V1Jf0RoJXvWOIYA3ub4DGmrJU0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=rQZ3wJqDpjVQz2QIhisGHX/yxaWax1YtDhXE8xErU4ZSPTi0mo6UOVJkOK424u2hP
	 As8c6/VdsWZuj9E5fSDZYNCYt3Hq0DWm+mqpmNG+okienrg2vVF6hg36NkB8sQV7vN
	 O2e+mpNQXsEIc5GajwMKBIbFDW4HyisltJkaub4266pMuQRo/QzZdCGHpYKc9jnZbl
	 WcRSOo2/9FubI8XujVurnEKIduCpIB3FkdZHVjGxRX/YIcpcSQP5EEb6pwHj91EoFe
	 MwIaZwtYdIF6UKT1zaJdogq40nV39p6v9xTlKRAou215yP443wBEJMjU7iyXRsu6hw
	 1huQFZZCpjd8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] Input: isa1200 - new driver for Imagis ISA1200
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: linux-input@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260512102445.55372-3-clamor95@gmail.com>
References: <20260512102445.55372-3-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 20:44:47 +0000
Message-Id: <20260513204448.90706C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Flawed interaction between isa1200_stop, suspend, and isa->level l=
eads to lost haptic state on resume and power leaks.
- [High] Missing workqueue cancellation and timer cleanup on driver unbind =
causes Use-After-Free.
- [High] Data races around hardware state transitions lead to resource leak=
s and I2C corruption.
- [Medium] Stack out-of-bounds read due to unvalidated GPIO descriptor coun=
t.
--

commit 87a2f648deb0c974007e802b082c1ec62d4fb097
Author: Linus Walleij <linusw@kernel.org>

Input: isa1200 - new driver for Imagis ISA1200

This commit introduces a new input driver for the Imagis ISA1200 haptic
feedback unit, adding support for controlling its motors over I2C and
PWM interfaces.

> diff --git a/drivers/input/misc/isa1200.c b/drivers/input/misc/isa1200.c
> new file mode 100644
> index 0000000000000..ff82252a08e1b
> --- /dev/null
> +++ b/drivers/input/misc/isa1200.c
[ ... ]
> +static void isa1200_start(struct isa1200 *isa)
> +{
> +	struct isa1200_config *config =3D &isa->config;
> +	struct device *dev =3D &isa->input->dev;
> +	struct pwm_state state;
> +	u8 hctrl0 =3D 0, hctrl1 =3D 0;
> +	DECLARE_BITMAP(values, ISA1200_EN_PINS_MAX);
> +	int err;
> +
> +	if (!isa->active) {
> +		err =3D regulator_bulk_enable(ARRAY_SIZE(isa1200_supplies),
> +					    isa->supplies);

Are isa1200_start() and isa1200_stop() vulnerable to data races on the
isa->active state?

The active flag is read and modified here without holding any locks.
If the workqueue and PM resume callbacks execute concurrently, could both
threads observe isa->active as false? This might lead to double
initialization of the clocks and regulators, leaking their reference
counts when isa1200_stop() only disables them once.

[ ... ]
> +static void isa1200_stop(struct isa1200 *isa)
> +{
[ ... ]
> +	isa->active =3D false;
> +	isa->level =3D 0;
> +}

[ ... ]
> +static int isa1200_of_probe(struct i2c_client *client)
> +{
[ ... ]
> +	isa->enable_gpios =3D devm_gpiod_get_array_optional(dev, "control",
> +							  GPIOD_OUT_LOW);

Should this validate the number of returned GPIO descriptors against
ISA1200_EN_PINS_MAX?

In isa1200_start() and isa1200_stop(), a local bitmap is declared on the
stack with DECLARE_BITMAP(values, ISA1200_EN_PINS_MAX). If a malformed
device tree provides more GPIOs than expected, could
gpiod_multi_set_value_cansleep() read past the stack bounds of the values
bitmap?

[ ... ]
> +static int isa1200_probe(struct i2c_client *client)
> +{
[ ... ]
> +	INIT_WORK(&isa->play_work, isa1200_play_work);

The isa structure is allocated via devm_kzalloc() and will be freed
automatically when the device is unbound. Because there is no remove
callback or devm action to cancel isa->play_work, could the workqueue
execute after unbind and cause a use-after-free if an effect is playing
during unbind?

Similarly, the ff_memless timer is tied to the input_dev, which can
outlive the I2C device if userspace holds an open file descriptor. Does
the timer also need to be cleaned up on driver unbind to prevent it from
accessing freed memory?

[ ... ]
> +static int isa1200_suspend(struct device *dev)
> +{
> +	struct isa1200 *isa =3D dev_get_drvdata(dev);
> +
> +	guard(mutex)(&isa->input->mutex);
> +
> +	if (input_device_enabled(isa->input)) {
> +		cancel_work_sync(&isa->play_work);
> +		if (isa->level)
> +			isa1200_stop(isa);
> +	}
> +
> +	return 0;
> +}

If the user has already requested the motor to stop (level is 0), this
skips calling isa1200_stop(). If the workqueue is cancelled before it
gets a chance to shut down the hardware, would this leave the device
active and leak power throughout suspend?

Additionally, looking at the resume function:

[ ... ]
> +static int isa1200_resume(struct device *dev)
> +{
> +	struct isa1200 *isa =3D dev_get_drvdata(dev);
> +
> +	guard(mutex)(&isa->input->mutex);
> +
> +	if (input_device_enabled(isa->input))
> +		if (isa->level)
> +			isa1200_start(isa);
> +
> +	return 0;
> +}

Since isa1200_stop() unconditionally sets isa->level to 0 during suspend,
will this check always evaluate to false, causing the driver to permanently
lose its haptic state after resuming?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512102445.5537=
2-1-clamor95@gmail.com?part=3D2
