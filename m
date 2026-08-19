Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFF936B913
	for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 20:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787170369; cv=none; b=Sl6AXXg9WBjW7zDXXaP6UH2FBdAfMWWGvyyu3ske/BVwd8zwK9oMYkt25YTGjPyrkMjo8EdTlKotn0ABX3TtXBfrcfpPMrSR35/BNrYfnxq4kqHaPpG6258YxchmKTPdmNapI5uoCv+8UWvVM+wnkps0kbVmjtM6mLPor0o519A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787170369; c=relaxed/simple;
	bh=BnVBT85f53VbTxg6kdvt6QvyHaPob7UHZ5k3jz8Nfmg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J/e90BnqRFrX+gIM60MrWJCv+FGXC+F1f89TWPBaDvTpfdphbPckW9o1UfBscR/jMc/kOkSBUcoREwAFlCaXHoxEJjLUjLvjdjs/2fLunC5hVY1CN9F7CdE+Pwe1GkyR03U3ZFDODmXiWct21mUkHtnrPgvEdkLVCAeiNiWu3Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNNp810Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNNp810Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D111F000E9;
	Wed, 19 Aug 2026 20:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787170368;
	bh=NWHdCA77LyhS4U9QltYTEFFYB0qANBXIB4p2DyXalBg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UNNp810YemOvaE38IB0tFgMEUVSdfzzmxNzDK060Nf4PPOPwHvcxePzMCrVB1MiNW
	 LPxcNTDIJnRHTm7G3oJCz6iTF2jS3X2v0Qxb2r/4VRnYOl9o8xnkXxqaQYtHdGoiI4
	 v2pXaM2dWlqq9bDbdPpZNeQDn7v5PRy+vzlSOJzXeAtYllORzb6ftX16TSmlxW55s4
	 ApN5rG/4rvTP/I2WGF3cLJuPUrdpbTF93tvJB/6DM2xsSU1gaqnRdmbJ5Ni7P2I3Ht
	 sdmxtpRNVrn3sV+ay6WIo+iGtQg4XWabn34wkyOOSfKf75bq7GAEjhsC588dbC1YFH
	 n/otSCkT9kFrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/12] HID: asus: add vibration strength
 configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260819195835.1649657-5-denis.benato@linux.dev>
References: <20260819195835.1649657-1-denis.benato@linux.dev>
 <20260819195835.1649657-5-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 20:12:47 +0000
Message-Id: <20260819201247.C3D111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] `ally_set_vibration_intensity()` directly sends raw HID requests=
 without acquiring the required `ally->intf_mutex`, leading to potential ra=
ce conditions and device state corruption.
- [Low] If `devm_device_add_group()` fails for one of the newly added vibra=
tion sysfs groups, the previously registered groups are not rolled back if =
the overall device probe succeeds.
--

--- Patch [4]: [PATCH v2 04/12] HID: asus: add vibration strength configura=
tion ---
commit fd873329418038e807b5d4833861817dc262fc2b
Author: Denis Benato <denis.benato@linux.dev>
Subject: HID: asus: add vibration strength configuration

This patch adds support for configuring the vibration strength of ASUS ROG
Ally handhelds. It introduces sysfs attributes to allow userspace to control
the intensity of the left and right motors.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 900914d21ca46..6b005afe01a24 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -771,15 +775,189 @@ static ssize_t xbox_controller_store(struct device=
 *dev,
> =20
>  static DEVICE_ATTR_RW(xbox_controller);
> =20
> +/**
> + * ally_set_vibration_intensity() - Set vibration intensity values
> + * @hdev: HID device
> + * @left: Left motor intensity (0-100)
> + * @right: Right motor intensity (0-100)
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +static int ally_set_vibration_intensity(struct hid_device *hdev, u8 left=
, u8 right)
> +{
> +	const u8 data[] =3D { left, right };
> +	int ret;
> +
> +	u8 *buf __free(kfree) =3D ally_alloc_cmd(CMD_SET_VIBRATION_INTENSITY, d=
ata, sizeof(data));
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret =3D ally_dev_set_report(hdev, buf, ROG_ALLY_REPORT_SIZE);

[Severity: Medium]
Does this direct call to ally_dev_set_report() need to be protected by=20
ally->intf_mutex?

Other commands like CMD_SET_XBOX_CONTROLLER use ally_gamepad_send_packet()=
=20
which takes the mutex:

static int ally_gamepad_send_packet(...)
{
        scoped_guard(mutex, &ally->intf_mutex)
                return ally_dev_set_report(hdev, buf, len);
}

Without the lock, could concurrent sysfs writes to the vibration attributes
race with other hardware communication on the IN interface, potentially bre=
aking
the strict SET/GET pairing expected by initialization routines?

> +	if (ret < 0) {
> +		hid_err(hdev, "Failed to set vibration intensity: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}

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

[Severity: Low]
If devm_device_add_group() fails for one of these newly added sysfs groups
during the registration loop in ally_config_create(), and the overall device
probe continues and succeeds, are the previously registered groups properly
cleaned up?

Since devres actions are only rolled back when the probe fails or the device
is unbound, it looks like a failure partway through the loop might leave
partially registered sysfs groups visible indefinitely.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819195835.1649=
657-1-denis.benato@linux.dev?part=3D4
