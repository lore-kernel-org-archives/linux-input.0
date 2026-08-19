Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E97C44064B
	for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 20:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787170253; cv=none; b=BFdltyo/jYWSG/WlhfBBwcfbonECjEA/zx2V12zZWhfYn5ccvRscTFwh1z9xnsr4oL3b2cW7Us/2AkhjffxR+6DRQWJFb9A7WeoBr8M02vA8M/0ClGFLmMo/0xbC+x6I4ZMCNZBp9KzTxql4m0s9snUsxC6ClCNI/8RtZQG5Yn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787170253; c=relaxed/simple;
	bh=s/ezZhip1fK1gDaT+tuoQEDJoNedRyA4HiYhhNJ2tVM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B2s3Y68CyUS/E1QMepdSuGptHdO8uY/2hBWviR72btlEQzv+fLnuF6h59wj1LpLz5Tya8knk7bCxZDzMuzNn3BBsc0nrAWYNmXCf1g1/W0aSZ+vMUjeju4MEMUZPlrwTekvEpPgH+W3mDFESFm7DnksSK3LCFR9WL1dmWY3BNXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+hF8B6H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+hF8B6H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2E91F00A3A;
	Wed, 19 Aug 2026 20:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787170250;
	bh=MWYh01EuLrkTRQKwB99MlEejH/r45jmfF0PrJjuaqIo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y+hF8B6Hm6yun+eIlEO3WDwc25zyTVc1mvqC6pKvdySjMBSAfhxJ4SARK/WUGqxKl
	 JJrh/GHYtVKAjOdieP6Fd4wQIjNuIa4JcegR4KM08MmfEJOgTZxzlehocwoRuVPVCV
	 onBE6tCVRhVybVYVrgXO3XT5AX1tFMMWr8IywcZQoyxDscuUp4k+yeXYE3l+bJ8S+F
	 Jq3HkP044NDmwwJSFsid/0rCDHr6kLOYzF3HPef9OO4U9JIR/riD0F+u4r6ixh56M3
	 xgFLRGVnmpiesIpJm3/HJ7rkWB1gQWNZKJWJeLLEUSk+yTiMK4FyCF+q/u87G4QWhk
	 SVESjIuhXbW7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/12] HID: asus: add gamepad configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260819195835.1649657-4-denis.benato@linux.dev>
References: <20260819195835.1649657-1-denis.benato@linux.dev>
 <20260819195835.1649657-4-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 20:10:50 +0000
Message-Id: <20260819201050.AF2E91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The device state (e.g., Xbox controller mode) is not restored du=
ring `hid_asus_ally_reset_resume()` after a device reset, leading to desync=
hronization between the hardware state and the cached sysfs state.
- [Low] Passing implicitly NULL sysfs group name to %s format specifier in =
error message.
--

--- Patch [3]: [PATCH v2 03/12] HID: asus: add gamepad configuration ---
commit 9e908c106ea4b31ecf33a0f67456da287b68ca3a
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add gamepad configuration

Add the base configuration structures for the gamepad configuration,
detect capabilities and initialize the device in a known state.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 88b30726f6c67..900914d21ca46 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> +static const struct attribute_group ally_attr_groups[] =3D {
> +	{
> +		.attrs =3D ally_config_attrs,
> +	},
> +};
> +
> +/**
> + * ally_config_create() - Initialize configuration and create sysfs entr=
ies
> + * @hdev: HID device
> + * @ally: non-NULL ally device data with uninitialized config pointer
> + *
> + * Return: valid pointer on success, error pointer on failure
> + */
> +static struct ally_config *ally_config_create(struct hid_device *hdev, s=
truct ally_handheld *ally)
> +{
> +	struct ally_config *cfg;
> +	int ret, sysfs_i;

[ ... ]

> +	for (sysfs_i =3D 0; sysfs_i < ARRAY_SIZE(ally_attr_groups); sysfs_i++) {
> +		ret =3D devm_device_add_group(&hdev->dev, &ally_attr_groups[sysfs_i]);
> +		if (ret < 0) {
> +			hid_err(hdev, "Failed to create sysfs group '%s': %d\n",
> +				ally_attr_groups[sysfs_i].name, ret);

[Severity: Low]
Is this going to print (null) in the error message? The ally_attr_groups
definition doesn't seem to have a .name field set for the group.

> +			goto ally_config_create_sysfs_err;
> +		}
> +	}

[ ... ]

> @@ -994,6 +1292,16 @@ static int hid_asus_ally_reset_resume(struct hid_de=
vice *hdev, struct ally_handh
>  	if (ep !=3D HID_ALLY_INTF_CFG_IN)
>  		return 0;
> =20
> +	/*
> +	 * This function assumes the asus-specific initialization
> +	 * to have been performed already at this point.
> +	 */
> +	ret =3D ally_gamepad_check_ready(ally, hdev);
> +	if (ret < 0) {
> +		hid_err(hdev, "ROG Ally device is not ready: %d\n", ret);
> +		return ret;
> +	}
> +
>  	ret =3D hid_asus_ally_init(hdev, ally);
>  	if (ret < 0)
>  		return ret;

[Severity: Medium]
Does this code need to restore the device configuration state, such as the =
Xbox
controller mode, after a device reset?

Since hid_asus_ally_init() only disables force-feedback, it looks like a sy=
stem
suspend and resume cycle could cause the hardware to revert to defaults, wh=
ile
the cached ally->config still holds the previous settings.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819195835.1649=
657-1-denis.benato@linux.dev?part=3D3
