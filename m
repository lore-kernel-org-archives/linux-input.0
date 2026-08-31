Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58494184
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 00:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788134741; cv=none; b=eHt2sCKI3XtNkhluWthuPwkqg9/I5PIKwExr5YqMFmSkUJNnc5SumacgSfz/ct8WhPFPDbg8YsZRqfuea0abURDHOJzo2+b0P1dfyEtE/k1C0qzUvDvtdeF8i0SCGWqqx74efjMhFUEqAYhS8SnesdzmsgE/hTRItdubV8EYx2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788134741; c=relaxed/simple;
	bh=5ADp2iUZsCq4m2WlVIDp8K0jQ0CWjrxszyAStLoIq2E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JeFOZzESPeowKBzvNutWpd9MzqKGa3nUh865F9PaBIAwEF5FOV19+RFKZ7TyHpr4MOhyefeNEpJZh3i38yqPtY0GVrWvKbc7lk9aTMI92epc/D4zM8X9fTE5WInJ2ULp+0f2mU37lxtTsPF+LFe94bCsTTLX7UodDvrCwidi6B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYHZJud3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYHZJud3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8D51F000E9;
	Mon, 31 Aug 2026 00:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788134739;
	bh=k/zZ+w2nQEBlGIfnbVqFSt5hDaxl39CG3EPBgbs8YEY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cYHZJud3YL7n1jLbZK8habiVg87EgCJb0p1LXIKvYQP6DMtsmYweBmyfDrwGEjeBX
	 GEPEaLDjHbCJPimHYnh/A6QRPZrNYpZUm7KMAY37wp6+GiPHVMZVUUbX91BO2/eFr2
	 ksLYhsRHe4Xc/AN7jc13fPOGkuOdN79eBcCxjo6oDC8RCdWJRfZS5KhMMwHH5UeuVy
	 kElgOnixZOvW0/VJDYbui3yqr9l9BAsZxf6sOaO1HU88yAthlTO8qk8QR/ahNV11a3
	 pBx7OvZ+P2CNgcUgRHESiW5z9gzPHbvBSPNjYw5fIj2z5qRBNPRITUfWJpfaRppUEo
	 mWHJQJG3fstZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/13] HID: asus: add joysticks inner and outer range
 configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260830234320.114356-7-denis.benato@linux.dev>
References: <20260830234320.114356-1-denis.benato@linux.dev>
 <20260830234320.114356-7-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 00:05:39 +0000
Message-Id: <20260831000539.BB8D51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Hardware state desynchronization across suspend/resume: joystick t=
hresholds are not restored to the MCU.
- [High] Missing sysfs group removal in `ally_config_remove()` allows concu=
rrent hardware I/O during device unbind, leading to UAF.

Pre-existing issues:
- [High] Missing assignment of ally->config makes all sysfs attributes unco=
nditionally fail with -ENODEV.
--

commit 6419ae2426ffa2d2dc7640592bc7176d31b6c150
Author: Denis Benato <denis.benato@linux.dev>

    HID: asus: add joysticks inner and outer range configuration
   =20
    ROG Ally devices supports configuring joysticks inner and outer range:
    add sysfs attributes to allow userspace modifying the sensitivity
    of those controllers.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index f825d650e1b7d..7702427bde451 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -973,6 +973,351 @@ static struct device_attribute dev_attr_right_vibra=
tion_intensity =3D
>  static struct device_attribute dev_attr_right_vibration_intensity_range =
=3D
>  	__ATTR(intensity_range, 0444, right_vibration_intensity_range_show, NUL=
L);
> =20
[ ... ]
> +static ssize_t left_joystick_inner_threshold_show(struct device *dev, st=
ruct device_attribute *attr,
> +						  char *buf)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct asus_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	struct ally_handheld *const ally =3D drvdata->rog_ally;
> +	struct ally_config *cfg;
> +
> +	if (!ally)
> +		return -ENODEV;
> +
> +	cfg =3D ally_get_config(ally);
> +	if (!cfg)
> +		return -ENODEV;

[Severity: High]
This isn't a bug introduced by this patch, but will these new sysfs attribu=
tes
unconditionally fail with -ENODEV?

Looking at hid_asus_ally_probe(), the ally_cfg pointer allocated by
ally_config_create() is never assigned to ally_drvdata.config:

    spin_lock_irqsave(&ally_data_lock, flags);
    ally_drvdata.cfg_hdev =3D hdev;
    spin_unlock_irqrestore(&ally_data_lock, flags);

Because ally_drvdata.config is missing, won't ally_get_config(ally) always
return NULL here and cause every new sysfs callback to fail immediately?

> +
> +	guard(mutex)(&cfg->config_mutex);
> +
> +	if (!cfg->user_cal_support)
> +		return -EOPNOTSUPP;
> +
> +	return sysfs_emit(buf, "%u\n", cfg->left_deadzone);
> +}
[ ... ]
> @@ -1028,6 +1411,19 @@ static struct ally_config *ally_config_create(stru=
ct hid_device *hdev, struct al
>  		goto ally_config_create_err;
>  	}
> =20
> +	/* Skip the calibration groups when the capability is missing. */
> +	if (cfg->user_cal_support) {
> +		for (sysfs_i =3D 0; sysfs_i < ARRAY_SIZE(ally_cal_attr_groups); sysfs_=
i++) {
> +			ret =3D devm_device_add_group(&hdev->dev,
> +						    ally_cal_attr_groups[sysfs_i]);

[Severity: High]
Can concurrent sysfs writes during device unbind cause a use-after-free by
racing with hid_hw_stop()?

The driver manually calls sysfs_remove_group() for its older attributes in
ally_config_remove() to ensure active callbacks drain completely before
hardware teardown:

    for (i =3D 0; i < ARRAY_SIZE(ally_attr_groups); i++)
        sysfs_remove_group(&hdev->dev.kobj, &ally_attr_groups[i]);

Since ally_cal_attr_groups is not added to this manual removal loop, won't =
the
new sysfs store callbacks fail to drain? This could allow them to call
hid_hw_raw_request() concurrently while hid_hw_stop() is dismantling the
transport.

> +			if (ret < 0) {
> +				hid_err(hdev, "Failed to create sysfs group '%s': %d\n",
> +					ally_cal_attr_groups[sysfs_i]->name, ret);
> +				goto ally_config_create_sysfs_err;
> +			}
> +		}
> +	}
> +
>  	cfg->gamepad_mode =3D 0x01;
>  	cfg->left_deadzone =3D 10;
>  	cfg->left_outer_threshold =3D 90;

[Severity: High]
Will the hardware state for joystick thresholds become desynchronized after=
 a
suspend/resume cycle?

The MCU loses its state upon reset/suspend, so hid_asus_ally_init() is
explicitly invoked on resume to restore the software-cached state:

    /* The MCU may have just been reset: restore the cached state. */
    guard(mutex)(&cfg->config_mutex);

    if (cfg->xbox_controller_enabled) {
        ret =3D ally_set_xbox_controller(hdev, ally, cfg, true);
        ...
    }

Since hid_asus_ally_init() completely omits restoring the new joystick
threshold parameters added in this patch, won't the hardware operate with
factory defaults while sysfs falsely reports the user's customized values?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830234320.1143=
56-1-denis.benato@linux.dev?part=3D6
