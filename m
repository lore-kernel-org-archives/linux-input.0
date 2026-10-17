Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0455488229;
	Sat, 17 Oct 2026 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792247414; cv=none; b=CZF9FXw7++kjXij5v+xaYZVnwWM35PQH0ts872LN/v6gYYfQ4YTWQBXjJejSCqq+RPGJLhiK7ls0k7X2owoH25H9I72VCRh7OSHL/hE6HSYI2E3yc/KVboLdNJ3NGDvH+Pb8W5jn/zcYjiIX93nonArXLiRRn5yr+Il/tKDGplo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792247414; c=relaxed/simple;
	bh=JUgB8qcsBCx0dybmRAogIg6/M8EEEY/ZVlfeGspN6ZQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=a4tBQwRwfhn3BuoJjlpY8wIqjGYtgDQm1rgWJVsEFdaNpC/mqiGJsiWE4C8RYh3RSSQ15zBCTLWI6v7IhRYleKUorce9YIg11b0z5IwqU8JosShBGNaHFFydK0LU8tNUmGOF0W7wQs8Ope8fGK0Jisy1Du3GSSUkCj4xOaiFcNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJRJaIzF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJRJaIzF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA46D1F000C4;
	Sat, 17 Oct 2026 14:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792247413;
	bh=XzGEY10x01v57dxjatZmPh4di6pE2tCeemqhGQ+7bSo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dJRJaIzFXLRVyT+QOvo0PqkcbeonKhNAsG38yxU/IOuRuHY6mY4sWmnzuDSlz8a7p
	 a6ffX9vN4aCPu8YymCrUHJBnbd7p6geu5p0A8v3S+1oPGZHUNKfLskSPNDyxFMQHiz
	 5qWfBkuxeVPCEeWj3bmXLKQqBSW4L/LpYavE+dRkrxMZf1y+uEi8V1YtpDk/Cwl+rF
	 6GP3Re3iXxpNmnd3D2rzY4XDWMeIg4mpQe6woGg+NbpRCEKYc8tz1S+OKCosv0IMUk
	 zevg4Y7RKoe75NqxPzjRZbsIv9ylxXVhTxEecuPD9vWy7FmI5CsNH36sxaKAFxdz9n
	 B6TaOikuqpdEQ==
Message-ID: <sashiko-outbox-175550@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] Input: edt-ft5x06 - support following a DRM panel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luka Panio" <lukapanio@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261017140827.290666-8-lukapanio@gmail.com>
References: <20261017140827.290666-1-lukapanio@gmail.com>
 <20261017140827.290666-8-lukapanio@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 14:30:12 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Input: edt-ft5x06 - unbind race between panel_work and remove/devr=
es teardown
- [High] Input: edt-ft5x06 - non-idempotent edt_ft5x06_ts_init_hw() retried=
 in panel_work
- [Medium] Input: edt-ft5x06 - reset_gpio left deasserted on boot failure i=
n panel_work
- [Medium] Input: edt-ft5x06 - missing powered_off check and factory_mode r=
estore for panel follower
- [Medium] Input: edt-ft5x06 - unlocked sysfs reads in model_show() and fw_=
version_show()
--

commit 8d0f54b6a0e4f2aafd88896b2e7280382657e313
Author: Luka Panio <lukapanio@gmail.com>

Input: edt-ft5x06 - support following a DRM panel

This commit adds DRM panel follower support to the edt-ft5x06 touchscreen
driver for TDDI controllers that share power and reset lines with a display
panel. When following a panel, initial hardware probing and subsequent power
transitions are deferred to a workqueue triggered by the panel follower
callbacks.

> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touch=
screen/edt-ft5x06.c
> index 7bcc48e07d629..b2fca6c372052 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c

[ ... ]

> @@ -1206,9 +1217,117 @@ static int edt_ft5x06_ts_init_hw(struct edt_ft5x0=
6_ts_data *tsdata)
> =20
>  	edt_ft5x06_ts_prepare_debugfs(tsdata);
> =20
> +	tsdata->hw_initialized =3D true;
> +
> +	return 0;
> +}
> +
> +/*
> + * TDDI controllers share their power and reset with the display panel. =
When
> + * following a panel, power the touch controller down before the panel g=
oes
> + * off and bring it back once the panel is up again.
> + */
> +static void edt_ft5x06_panel_work(struct work_struct *work)
> +{
> +	struct edt_ft5x06_ts_data *tsdata =3D
> +		container_of(work, struct edt_ft5x06_ts_data, panel_work);
> +	int error;
> +
> +	guard(mutex)(&tsdata->mutex);
> +
> +	if (!tsdata->powered_off)
> +		return;
> +
> +	if (!tsdata->hw_initialized) {
> +		error =3D edt_ft5x06_ts_init_hw(tsdata);
> +		if (error) {
> +			/* try again the next time the panel comes up */
> +			gpiod_set_value_cansleep(tsdata->reset_gpio, 1);
> +			dev_err(tsdata->dev,
> +				"Failed to initialize the controller: %d\n",
> +				error);
> +			return;
> +		}
> +		goto out;
> +	}

[Severity: High]
Is it safe to retry edt_ft5x06_ts_init_hw() on a subsequent panel prepare
cycle if the first attempt fails?

edt_ft5x06_ts_init_hw() performs several one-shot actions that do not roll
back on error:

1. In edt_ft5x06_ts_init_hw() -> edt_ft5x06_ts_identify(), if an EDT_M06
   chip is detected, it destroys tsdata->regmap and replaces it:

	regmap_exit(tsdata->regmap);
	tsdata->regmap =3D regmap_init_i2c(client,
					 &edt_M06_i2c_regmap_config);
	if (IS_ERR(tsdata->regmap)) {
		dev_err(tsdata->dev, "regmap allocation failed\n");
		return PTR_ERR(tsdata->regmap);
	}

   If regmap_init_i2c() returns an error pointer, the next retry will pass
   that error pointer into regmap_bulk_read() and dereference it. Even if
   regmap_init_i2c() succeeds and a later step in edt_ft5x06_ts_init_hw()
   fails, the next retry will call edt_ft5x06_ts_identify() using
   edt_M06_i2c_regmap_config, which masks the 0xBB identification register
   to 0x3B and only reads a single byte, breaking M06 identification.

2. edt_ft5x06_ts_init_hw() calls input_register_device(tsdata->input) on the
   input_dev allocated once in edt_ft5x06_probe(). If input_register_device=
()
   fails, struct input_dev cannot be passed to input_register_device() a
   second time on the next retry.

3. In edt_ft5x06_ts_init_hw(), if tsdata->boot() fails, it calls
   dev_err_probe() from the background panel_work workqueue after
   edt_ft5x06_probe() has already returned.

> +
> +	gpiod_set_value_cansleep(tsdata->reset_gpio, 0);
> +
> +	if (tsdata->boot) {
> +		error =3D tsdata->boot(tsdata->dev, tsdata->reset_gpio);
> +		if (error) {
> +			dev_err(tsdata->dev,
> +				"Failed to boot the controller: %d\n", error);
> +			return;
> +		}
> +	} else {
> +		msleep(300);
> +	}

[Severity: Medium]
Should reset_gpio be re-asserted to 1 if tsdata->boot() fails here, just as
is done in the !tsdata->hw_initialized error path above?

Because tsdata->powered_off remains true on this early return, a subsequent
call to edt_ft5x06_panel_unpreparing() will see tsdata->powered_off =3D=3D =
true
and return early without asserting reset_gpio to 1:

	if (tsdata->powered_off)
		return 0;

	disable_irq(tsdata->irq);
	gpiod_set_value_cansleep(tsdata->reset_gpio, 1);
	tsdata->powered_off =3D true;

That leaves reset_gpio deasserted (0) while the shared TDDI panel power goes
off, and also prevents a 1 -> 0 reset transition on the next panel wake-up.

> +
> +	edt_ft5x06_restore_reg_parameters(tsdata);
> +out:
> +	tsdata->powered_off =3D false;
> +	enable_irq(tsdata->irq);
> +}

[Severity: Medium]
What happens if tsdata->factory_mode is active across a panel power cycle, =
or
if the debugfs files are accessed while tsdata->powered_off is true?

In edt_ft5x06_debugfs_mode_set() and edt_ft5x06_debugfs_raw_data_read(),
tsdata->mutex is acquired, but unlike edt_ft5x06_setting_show() and
edt_ft5x06_setting_store(), neither function checks tsdata->powered_off
before accessing the controller over regmap or toggling IRQ state.

In addition, if factory mode was enabled before the panel turned off
(calling disable_irq(tsdata->irq) once and setting tsdata->factory_mode =3D
true), edt_ft5x06_panel_unpreparing() will call disable_irq(tsdata->irq) a
second time and assert reset_gpio. When edt_ft5x06_panel_work() runs on
resume, the controller comes out of reset in work mode while
tsdata->factory_mode is still true, causing edt_ft5x06_restore_reg_paramete=
rs()
on M06 to format writes as factory-mode requests, and leaving tsdata->irq
disabled after the single enable_irq(tsdata->irq) call because
edt_ft5x06_factory_mode() is not called as in edt_ft5x06_ts_resume():

	edt_ft5x06_restore_reg_parameters(tsdata);
	enable_irq(tsdata->irq);

	if (tsdata->factory_mode)
		ret =3D edt_ft5x06_factory_mode(tsdata);

[ ... ]

> +static void edt_ft5x06_cancel_panel_work(void *data)
> +{
> +	struct edt_ft5x06_ts_data *tsdata =3D data;
> +
> +	cancel_work_sync(&tsdata->panel_work);
> +}
> +
> +static int edt_ft5x06_register_panel_follower(struct edt_ft5x06_ts_data =
*tsdata)
> +{
> +	struct device *dev =3D tsdata->dev;
> +	int error;
> +
> +	INIT_WORK(&tsdata->panel_work, edt_ft5x06_panel_work);
> +	error =3D devm_add_action_or_reset(dev, edt_ft5x06_cancel_panel_work,
> +					 tsdata);
> +	if (error)
> +		return error;
> +
> +	tsdata->panel_follower.funcs =3D &edt_ft5x06_panel_follower_funcs;
> +
> +	return devm_drm_panel_add_follower(dev, &tsdata->panel_follower);
> +}

[Severity: High]
Can deferring panel follower removal and cancel_work_sync(&tsdata->panel_wo=
rk)
to devres actions race with edt_ft5x06_remove() and devres teardown when the
driver is unbound while edt_ft5x06_panel_work() is running?

When unbinding the driver:

1. edt_ft5x06_remove() runs before devres release:

	void edt_ft5x06_remove(struct device *dev)
	{
		struct edt_ft5x06_ts_data *tsdata =3D dev_get_drvdata(dev);

		edt_ft5x06_ts_teardown_debugfs(tsdata);
	}

   For I2C devices, i2c_device_remove() then immediately calls
   debugfs_remove_recursive(client->debugfs) before devres_release_group().
   Because panel_work has not been cancelled yet, a concurrent execution of
   edt_ft5x06_panel_work() -> edt_ft5x06_ts_init_hw() ->
   edt_ft5x06_ts_prepare_debugfs() can dereference the freed tsdata->debugfs
   dentry and allocate tsdata->raw_buffer after teardown has already run.

2. During devres teardown, remove_nodes() drains dev->devres_head into a
   local todo list before release_nodes() invokes the devm actions for
   drm_panel_remove_follower and edt_ft5x06_cancel_panel_work. If
   edt_ft5x06_panel_work() is mid-flight inside edt_ft5x06_ts_init_hw()
   waiting to finish while edt_ft5x06_cancel_panel_work() blocks in
   cancel_work_sync(), input_register_device(tsdata->input) will append
   devm_input_device_unregister to dev->devres_head after dev->devres_head
   was already drained into todo. release_nodes() will then execute
   devm_input_device_release from todo without having run
   devm_input_device_unregister.

> @@ -1331,14 +1450,24 @@ int edt_ft5x06_probe(struct device *dev, struct r=
egmap *regmap, int irq,
>  	tsdata->factory_mode =3D false;
>  	dev_set_drvdata(dev, tsdata);
> =20
> -	error =3D edt_ft5x06_ts_init_hw(tsdata);
> -	if (error)
> -		return error;
> +	/*
> +	 * A controller sharing its power with a panel can only be accessed
> +	 * once the panel is up, so leave it in reset and do the rest of the
> +	 * initialization from the panel follower callback.
> +	 */
> +	tsdata->is_panel_follower =3D drm_is_panel_follower(dev);
> +	if (!tsdata->is_panel_follower) {
> +		error =3D edt_ft5x06_ts_init_hw(tsdata);
> +		if (error)
> +			return error;
> +	}

[Severity: Medium]
When tsdata->is_panel_follower is true and edt_ft5x06_ts_init_hw() is
deferred to edt_ft5x06_panel_work(), should model_show() and
fw_version_show() hold tsdata->mutex when reading tsdata->name and
tsdata->fw_version?

	static ssize_t model_show(struct device *dev,
				  struct device_attribute *attr, char *buf)
	{
		struct edt_ft5x06_ts_data *tsdata =3D dev_get_drvdata(dev);

		return sysfs_emit(buf, "%s\n", tsdata->name);
	}

	static ssize_t fw_version_show(struct device *dev,
				       struct device_attribute *attr, char *buf)
	{
		struct edt_ft5x06_ts_data *tsdata =3D dev_get_drvdata(dev);

		return sysfs_emit(buf, "%s\n", tsdata->fw_version);
	}

Previously, tsdata->name and tsdata->fw_version were populated synchronously
in edt_ft5x06_probe() before the sysfs attributes in edt_ft5x06_groups were
registered. With hardware initialization deferred to edt_ft5x06_panel_work(=
),
edt_ft5x06_ts_identify() now writes to tsdata->name and tsdata->fw_version
under tsdata->mutex after the sysfs files are already visible to userspace,
so unlocked reads in model_show() and fw_version_show() can race with
edt_ft5x06_ts_identify().

[ ... ]

>
>
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017140827.2906=
66-1-lukapanio@gmail.com?part=3D7
