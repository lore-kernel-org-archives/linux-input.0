Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96A74137AE
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357295; cv=none; b=ss42+KJah019PEtjHmcj6NDpM5dl0wyfmLZSOylYG08XczU90na7OZ+U/fCwnu8+vdAMOd6pL9AJPk3CgCLMWdJcqQCvqOeryYyuZMRmEinrPUVtxSr3YoeMo2DSfORE+GCczA0K0ckD9E7pZQpexi/PJiop/oOvJDfI9w/TTq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357295; c=relaxed/simple;
	bh=Ge+ZEAKkEPejJ939TQ9T+kZVkHn7AUMjXowCxMD5pko=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tQh1X0yDZzjCa18IuWk2Hw8NtxCTl7eDGPgHbPDcoqt8jUtZgyUF0rah1P5OKvVZpOfnVEkB6DWQRm2oQnq2bSsDwaLfy39rP8WmmEsJZZt1ON5bmxOff7Er4MBf8UEW+6SvKaxZ8zkhQ8ZiCLJoC4k7ZgpTwC8NVlhkUTMsAeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Duiz3x33; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Duiz3x33"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9351F000E9;
	Wed,  2 Sep 2026 13:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788357293;
	bh=1JbNuAO8y+fyoD84I8dDFGXYO+q+ZlbqlR1DiO8IjM4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Duiz3x33tZT3FihknKotRi8UzDo+6ZIc1NiJAPcrZvjt+rNDY5jjQVzbQvq7hk/vb
	 yWVmxSaXnGJbVbCHZfmOBxmGQKnNuw5BTZCeHiGNKc4wU/bnnqCF02P39O2Cgl4He2
	 Uz6hyJ13g19Qvjab+pKXjvY8roOna3ELKMqib+Ki6neU356UqJD9HC6zbnXW6bvb2T
	 xJ2iljeP0gPkU80cUT8uyvliO9D7X4ovaX2UEfvSLHP5TauyVPfPtx3C0+NyvKDZ1F
	 dAQXvvYiaLhzKeguE74IDXpMgYFSZCaRpyKWfu3aGxzJoTM7AZdagZU+i2kNmoRJ5S
	 PzojUh93VPpjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] HID: amd_sfh: Add DMI quirk and module param to
 disable interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Basavaraj Natikar" <Basavaraj.Natikar@amd.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260902134431.3146117-2-Basavaraj.Natikar@amd.com>
References: <20260902134431.3146117-1-Basavaraj.Natikar@amd.com>
 <20260902134431.3146117-2-Basavaraj.Natikar@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 13:54:52 +0000
Message-Id: <20260902135453.5C9351F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The DMI quirk for ASUS VivoBook inadvertently ENABLES hardware int=
errupts, directly contradicting the commit message which states the device =
requires them DISABLED.
- [Medium] The DMI quirk unconditionally overwrites the module parameter du=
ring probe, making it impossible for a user to override the quirk on matchi=
ng hardware.
- [Low] The module parameter permissions are read-only, preventing the 'run=
time override' advertised in the commit message.
--

commit ec52ca66216e002a750c44dedd096bba34993086
Author: Helge Bahmann <hcb@chaoticmind.net>

HID: amd_sfh: Add DMI quirk and module param to disable interrupts

This commit exposes the intr_disable variable as a module parameter
and adds a DMI quirk for the ASUSTeK VivoBook.

> Expose intr_disable as a module parameter to allow runtime override.

[Severity: Low]
The commit message mentions allowing a runtime override, but the module
parameter is defined with 0444 permissions. Doesn't this make it read-only
and prevent runtime modification via sysfs?

> Add DMI quirk for ASUSTeK VivoBook TP420UA/TM420UA which requires
> interrupts disabled for correct sensor operation.
>=20
> Signed-off-by: Helge Bahmann <hcb@chaoticmind.net>
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh=
-hid/amd_sfh_pcie.c
> index eda26a094d3f1..92486f25460bc 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> @@ -41,6 +41,8 @@ module_param_named(sensor_mask, sensor_mask_override, i=
nt, 0444);
>  MODULE_PARM_DESC(sensor_mask, "override the detected sensors mask");
> =20
>  static bool intr_disable =3D true;
> +module_param_named(intr_disable, intr_disable, bool, 0444);

[Severity: Medium]
Does the DMI quirk evaluation in amd_mp2_pci_probe() unconditionally
overwrite this module parameter?

During probe, dmi_check_system(dmi_sfh_table) is called, which executes
mp2_disable_intr() for matching hardware. If a user attempts to override the
interrupt setting via module parameters, won't their setting be silently
ignored and clobbered by the quirk's callback?

> +MODULE_PARM_DESC(intr_disable, "override the interrupt disable sensor bi=
t");
> =20
>  static int amd_sfh_wait_response_v2(struct amd_mp2_dev *mp2, u8 sid, u32=
 sensor_sts)

[ ... ]

> @@ -313,6 +315,13 @@ static const struct dmi_system_id dmi_sfh_table[] =
=3D {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "HP ProBook x360 435 G7"),
>  		},
>  	},
> +	{
> +		.callback =3D mp2_disable_intr,

[Severity: High]
Does this quirk actually enable interrupts rather than disable them?

The commit message states the ASUS VivoBook requires interrupts disabled.
However, the mp2_disable_intr() callback sets the global intr_disable =3D f=
alse.

By setting this to false, the hardware is configured with
cmd_v2.intr_disable =3D 0, which turns interrupts on. Is this the intended
behavior for a device that requires them to be disabled?

> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "VivoBook_ASUSLaptop TP420UA_TM420UA"),
> +		},
> +	},
>  	{}
>  };
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902134431.3146=
117-1-Basavaraj.Natikar@amd.com?part=3D1
