Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793469561;
	b=YCWgDHjEvZTGuVwhwL+K1/LX30ZiRXcfNyjgVTsUpiq7KSM2vQ2LSWDyTNaOcH8OwwoM
	 jIeOd8G081Hp77ZxEsFV8SPuDX3sFJUCn+K28cIwNU869REGZ97xk+ID74jrss5vBLzlH
	 4yC6Eab8a5RtXPTHs/vQOFS+4EoqXc25NSpFnxsw7DGMGgQC+7u8bdJmmXbLhrz5uVZ3h
	 dOi/ns6lYBbkESygxTS9sbXTZ+I85Ze6NMrvO/rlDwDpNKMqxVIWtn6ikXeMqbtht8o0t
	 ycys6kQj95giPfMNEOdkXW/XeteLmBipUT+yTPqDPPU0ChmQWgyc1WdSmeP0jv7CKyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793469561;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4LDG4yLH9yEF5Qry9euVlY7NVUtBW0V6W8Iiuu6ZoNQ=;
	b=KoZsC/7UQrL1iasFfiK6pgQVmshHfDocC/ULcalTGZY9AvBi5+LHOO/3nnR6HszgfSJf
	 akwXGYUEMZY9UOUof2BOyN8ckajrDfPn3+Vv+sxeeZkIq7h0fuc+/wljpC8LZH4XN4BYv
	 bQEGbYkNAq7zXnjAfXzzOfHHJBM2dn0MwV0TTgwKa7tIG0mm3kHdYW1mwf1fEWQJK6uv2
	 ShEB4Np07DIhlyr1mO4iWDYcj92gbmNtMWnLGyp0wKknZ1d5gz7wpC679AGJ7A4qZ7o2n
	 /xpyS3/0Ck5H3RD4sEhM4p4hzZpSN7eLvEar2whj2wC6dElK1fWSWc9UqXrTRu+1ZKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OZfOcq3+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4F7606A31A
	for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 17:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OZfOcq3+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A02B1F000C1;
	Sat, 31 Oct 2026 17:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793469560;
	bh=4LDG4yLH9yEF5Qry9euVlY7NVUtBW0V6W8Iiuu6ZoNQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OZfOcq3+ixe/O6uiwZvmYbM33lhnDRYGk1Rki8q5HWlicMu57XsXz4ZjxC5mL/qdR
	 Fb59r4wbpx15QFjdHmkFGHrQQ0+c/hrHu+9RNxLgCFpuW/5+sm9kO//FVIWLpBzmq5
	 5EEfBDufWe8iA3+aIElY68u+EogPZ+IjefrzrmkMaFSfQYH2GvhbR/7Uj3SwHex3EL
	 DG9vymlOASr1pQBBCsD39TZVv/sBJpsPhlVljFSrq6qRARAySsARmnNfdvAe26FpSu
	 IgyAKFtlGa2GfviO/ePa5kyear/NKhpnCfBcKzap1dvJ9sChUmlUWQX0o0MLEGTbXy
	 qdx9wivsmHiFw==
Message-ID: <sashiko-outbox-192086@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 03/17] HID: asus: add gamepad configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261031174130.208240-4-denis.benato@linux.dev>
References: <20261031174130.208240-1-denis.benato@linux.dev>
 <20261031174130.208240-4-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 17:59:20 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] HID: asus: per-device sysfs group tracked by global sysfs_live f=
lag
--

commit 7492a3880439a824fa483d73553323c7d5fdab75
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add gamepad configuration

This commit adds ROG Ally gamepad capability detection, initializes the
controller state, and exposes the xbox_controller sysfs attribute. It also
updates hid_asus_ally_reset_resume() to wait for the gamepad MCU to become
ready.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 552d3b25a1d10..5f5393ea92b7e 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -729,6 +736,224 @@ static int ally_get_endpoint_address(struct hid_dev=
ice *hdev)
>  	return ep->desc.bEndpointAddress;
>  }
> =20
> +/*
> + * Settings that must survive the controller powering off and coming bac=
k.
> + * No device or input pointers live here: every transfer uses the interf=
ace
> + * that is bound right now.
> + *
> + * One set for the machine is by design. The Ally controller is
> + * part of the PC, so two ROG Ally HID devices are not bound at
> + * once. The only way to see a second one is to emulate it with
> + * uhid.
> + */
> +static struct ally_prefs {
> +	/* Guards every field below, including across the feature report. */
> +	struct mutex lock;
> +
> +	bool initialized;
> +	bool sysfs_live;

[ ... ]

> +static int ally_prefs_setup(struct hid_device *hdev)
> +{
> +	int ret, i;
> +
> +	ret =3D ally_detect_capabilities(hdev);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&ally_prefs.lock);
> +
> +	if (!ally_prefs.initialized) {
> +		ally_prefs.gamepad_mode =3D 0x01;
> +		ally_prefs.xbox_controller_enabled =3D true;
> +		ally_prefs.initialized =3D true;
> +	}
> +
> +	if (ally_prefs.sysfs_live)
> +		return 0;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(ally_attr_groups); i++) {
> +		ret =3D sysfs_create_group(&hdev->dev.kobj, &ally_attr_groups[i]);
> +		if (ret) {
> +			hid_err(hdev, "Failed to create Ally sysfs group '%s': %d\n",
> +				ally_attr_groups[i].name ?: "", ret);
> +			while (i--)
> +				sysfs_remove_group(&hdev->dev.kobj, &ally_attr_groups[i]);
> +			return ret;
> +		}
> +	}
> +
> +	ally_prefs.sysfs_live =3D true;
> +	return 0;
> +}
> +
> +static void ally_sysfs_remove(struct hid_device *hdev)
> +{
> +	int i;
> +
> +	if (ally_get_endpoint_address(hdev) !=3D HID_ALLY_INTF_CFG_IN)
> +		return;
> +
> +	scoped_guard(mutex, &ally_prefs.lock) {
> +		if (!ally_prefs.sysfs_live)
> +			return;
> +
> +		ally_prefs.sysfs_live =3D false;
> +	}
> +
> +	for (i =3D 0; i < ARRAY_SIZE(ally_attr_groups); i++)
> +		sysfs_remove_group(&hdev->dev.kobj, &ally_attr_groups[i]);
> +}

[Severity: Medium]
Can tracking per-device sysfs registration with the global
ally_prefs.sysfs_live boolean leave a dangling sysfs group on a device or
skip creating it on a newly probed one?

In hid_asus_ally_probe(), ally_prefs_setup() attaches ally_attr_groups to t=
he
per-device &hdev->dev.kobj and sets ally_prefs.sysfs_live =3D true on a fir=
st
HID_ALLY_INTF_CFG_IN device (hdev1).

If a second HID_ALLY_INTF_CFG_IN device (hdev2, for example via USB
emulation) is probed:

1. If ally_gamepad_check_ready(hdev2) fails in hid_asus_ally_probe(),
asus_probe() logs the error and still succeeds with drvdata->ally left as
NULL:

	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
		ally =3D hid_asus_ally_probe(hdev);
		if (IS_ERR(ally))
			hid_err(hdev, "Failed to initialize ROG Ally HID extensions: %ld\n",
				PTR_ERR(ally));
		else
			/* Readers take this with smp_load_acquire(). */
			smp_store_release(&drvdata->ally, ally);
	}

2. If ally_gamepad_check_ready(hdev2) succeeds, ally_prefs_setup(hdev2)
overwrites the global capability flags via ally_detect_capabilities(hdev2)
and then returns 0 early because ally_prefs.sysfs_live is already true,
without creating the sysfs group on &hdev2->dev.kobj.

When hdev2 is later unbound or removed, asus_remove(hdev2) unconditionally
calls ally_sysfs_remove(hdev2) without checking drvdata->ally or whether
hdev2 owns the registered sysfs group:

	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
		ally_quiesce(drvdata->ally);
		ally_sysfs_remove(hdev);
	}

Because hdev2 has endpoint HID_ALLY_INTF_CFG_IN and ally_prefs.sysfs_live is
true, ally_sysfs_remove(hdev2) clears ally_prefs.sysfs_live =3D false and c=
alls
sysfs_remove_group() on &hdev2->dev.kobj where the group was never created.

When hdev1 is later unbound or removed, ally_sysfs_remove(hdev1) sees
ally_prefs.sysfs_live =3D=3D false and returns early without removing the s=
ysfs
group from &hdev1->dev.kobj. Similarly, if hdev1 removal races with hdev2
probing before ally_sysfs_remove(hdev1) clears ally_prefs.sysfs_live,
ally_prefs_setup(hdev2) sees ally_prefs.sysfs_live =3D=3D true and skips cr=
eating
the sysfs group on hdev2.

Should sysfs group ownership be tracked per device (for instance on struct
ally_intf) rather than with a global boolean?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031174130.2082=
40-1-denis.benato@linux.dev?part=3D3
