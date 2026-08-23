Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47A33603FB
	for <linux-input@vger.kernel.org>; Sun, 23 Aug 2026 19:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787512680; cv=none; b=oTJDW1LFEcen2QQ+6AJtRY0dyCI6wzyzE3V2leGBG4rJSDUFUHRsb4x4Fv0k7lErvC2l5ATa1Z79RQcmpHBie2TtptoXXPyJmXh0zf9ATjy8fBU3e9Al64ASPtCNiFY2YAAKXWc15tarJAf4/S9IIhotJSK2PmlkW/upIHqxZPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787512680; c=relaxed/simple;
	bh=+YFNudzNn4vhlZFH5pNzpnbQs/xI+PzUX7QpgAVuNy8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hwXSyxp4UX4Bhv3IHM2xWNLpamBO+KNW43NecPf8hE/EP7UtkXFRnwP+9bRlL2smXGryVYbxZpsNiLWMcfS9ZGn2MQJ4QLywjsP/gnLKh0kR0UK9RwYkOeclLrUXeqRD0TsZzDIsPWX2qiQ1sG6KOjVLfOPPln9FT/avxJqQqls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljGKyLnX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljGKyLnX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249C21F000E9;
	Sun, 23 Aug 2026 19:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787512679;
	bh=rhkGjz0bAGRZiE2mjlfONETwjHQaLGUCBud80YEBsP0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ljGKyLnXxMWJD0SK0S/jOO/bOz6zsAFkx8teikc0XjCdXFhRmj9QsqzUohhtCLULZ
	 IRviyqFcXFsjbme86CM+89mXG9B4UV2YSDLtW2ZJjq8qfrp9zzL+AMna2G1/tD12rR
	 4m8XCbjudAeQ0q5Pi1CEQYfXiUpJiFp8iKVyb3FYZTiCsOdm63UR6Bs+0/TTB77ou5
	 Q2BcP4CgLTKDGsX6nOSKesk4uD5c53kPiVrUVfvsYcL/vDmh4LSSIIOIj6i2FIfizZ
	 d3S6LofnBobhtjfy+IGGBSGr1B4Y0C/2OkPSUNXWpFw/+bETKTHrlCr0IXLmQOA+8/
	 7O6e75hA2glXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/12] HID: asus: add vibration strength
 configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260823185849.2478673-5-denis.benato@linux.dev>
References: <20260823185849.2478673-1-denis.benato@linux.dev>
 <20260823185849.2478673-5-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 19:17:58 +0000
Message-Id: <20260823191759.249C21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing hardware state restoration for vibration intensity on de=
vice resume.
- [Medium] Partial failure of the sysfs initialization loop leaves dangling=
 sysfs groups and leaks devres actions.
--

--- Patch [4]: [PATCH v3 04/12] HID: asus: add vibration strength configura=
tion ---
commit bae59c4354c6c0f337acefd797d650cf39840ae7
Author: Denis Benato <denis.benato@linux.dev>

    HID: asus: add vibration strength configuration
   =20
    ASUS ROG Ally handhelds support the vibration strength to be configured:
    add sysfs attributes to allow userspace configure motors vibration
    intensity.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 04f41294edf67..dc1a4fb6c9e9e 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -206,6 +206,10 @@ struct ally_config {
>  	u8 left_trigger_max;
>  	u8 right_trigger_min;
>  	u8 right_trigger_max;
> +
> +	/* Vibration settings */
> +	u8 vibration_intensity_left;
> +	u8 vibration_intensity_right;
>  };
> =20

[Severity: Medium]
Will this newly added state be lost after a system suspend/resume cycle?

Looking at hid_asus_ally_init(), it restores the gamepad mode and Xbox
controller state after an MCU reset, but doesn't seem to restore these
vibration intensity values:

drivers/hid/hid-asus.c:hid_asus_ally_init() {
	...
	if (cfg->xbox_controller_enabled) {
		ret =3D ally_set_xbox_controller(hdev, ally, cfg, true);
	...
}

Could this lead to a state desynchronization? After resume, the controller
hardware resets its vibration intensity to the default 100%, but the sysfs
files might still report the user's previously set custom value until manua=
lly
overwritten.

[ ... ]

> @@ -811,15 +815,193 @@ static ssize_t xbox_controller_store(struct device=
 *dev,

[ ... ]

>  static const struct attribute_group ally_attr_groups[] =3D {
>  	{
>  		.attrs =3D ally_config_attrs,
>  	},
> +	{
> +		.name =3D "left_vibration",
> +		.attrs =3D ally_left_vibration_attrs,
> +	},
> +	{
> +		.name =3D "right_vibration",
> +		.attrs =3D ally_right_vibration_attrs,
> +	},
>  };

[Severity: Medium]
Does adding new groups here expose a partial failure cleanup issue during
initialization?

If devm_device_add_group() fails for the second or third element in
ally_attr_groups, ally_config_create() returns an error without rolling
back the successfully added groups:

drivers/hid/hid-asus.c:ally_config_create() {
	...
	for (sysfs_i =3D 0; sysfs_i < ARRAY_SIZE(ally_attr_groups); sysfs_i++) {
		ret =3D devm_device_add_group(&hdev->dev, &ally_attr_groups[sysfs_i]);
		if (ret < 0) {
			hid_err(hdev, "Failed to create sysfs group '%s': %d\n",
				ally_attr_groups[sysfs_i].name ?: "", ret);
			goto ally_config_create_sysfs_err;
		}
	...
}

This error propagates up to asus_probe(), which explicitly ignores the
failure and returns 0. Since the overall device probe succeeds, the devres
rollback that would normally remove the successfully added groups is bypass=
ed.

Could this leave dangling sysfs files registered on the device while the
cfg structure is freed via devm_kfree(), since the sysfs actions are never
cleaned up?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823185849.2478=
673-1-denis.benato@linux.dev?part=3D4
