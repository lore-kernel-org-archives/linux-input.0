Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2216C28C5B1
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 23:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788134009; cv=none; b=I5AGNpKkRHd6qH70O+zzUT8qAbqUrF+0HHhGNoYzvQZVz/s8zZZE/OW85P8ccX/2kKmLrG9mEF3TLACIDqemMmLDx928cnUt92iuyO4g0kxC3l1MtlU4ci1Vo2cWPjZjTC1ubDO7Fxl1RdG4DBTsdSKSnn6pGnypITbxfkwR3eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788134009; c=relaxed/simple;
	bh=TMawuYA/Zs0vHCKOP/FHkKyLURyIUlZSsw3Qm4EU438=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ekuXySJBc9MfyQ3oE3XESLM2a9f7XwhPv4+sMs+H5BBobdaBoQSKey40L+RWeh5hFiAPh7jkffRK3huFiR7R2dW0bMr+lDEhNrXqMZCVpVqQc5lxSgYNDsCOOYnxaHNw/nHx96qXTQWtaQV6Vx24aIJizyj4OoqqEdaQInSzGaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odBewrPS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odBewrPS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B071A1F000E9;
	Sun, 30 Aug 2026 23:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788134007;
	bh=OmrrNzln7MzcXbeO7Ewa5vz/PWEADLBOynpdd2tFrVc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=odBewrPSKmmybO+sSEmiGE9Bdsnncg9aWGwMCpx2TwsAQHNZOfX6xhCbF7sY4VELM
	 gi6RdrtDvWPJrs01WYEe5H/603ribO2XSWaqp+a6eU8bzVs/ksytLwILCAv6GnsAg0
	 4v3yU8hg1UvDQNVhzaZU543bgb9suW9bQ88XE0hDXIXpTi5VmQ/fb0hs/b1wRZ4BUi
	 JEhcz/nHRo5UWWarzTKBTyVysgvoqa2wPOoa1rmBoqWApZBN8YSEgsy77JwSb8W7l9
	 2Jlw8K1zyJjIKHPQARzyh973z7SJ8oYY+Le6pSmtHod1NJao7mNPBKP0Nn26R988MQ
	 Nx0hwnRvzVwuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/13] HID: asus: add gamepad configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260830234320.114356-5-denis.benato@linux.dev>
References: <20260830234320.114356-1-denis.benato@linux.dev>
 <20260830234320.114356-5-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 23:53:27 +0000
Message-Id: <20260830235327.B071A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The allocated configuration structure `ally_cfg` is never assign=
ed to the global driver data, making all sysfs attributes non-functional an=
d initialization logic dead code.
--

commit 801faddce1ca16f0ffe78534d10cc73ce08c6da4
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add gamepad configuration

This patch adds the base configuration structures for the gamepad
configuration, detects capabilities, and initializes the device in a
known state.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index f36cf93e380d5..7fdb77432171e 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
[ ... ]
> @@ -1004,6 +1307,14 @@ static struct ally_handheld *hid_asus_ally_probe(s=
truct hid_device *hdev)
>  			return ERR_PTR(ret);
>  		}
> =20
> +		ally_cfg =3D ally_config_create(hdev, &ally_drvdata);
> +		if (IS_ERR(ally_cfg)) {
> +			hid_err(hdev, "Failed to create Ally cfg: %ld\n",
> +				PTR_ERR(ally_cfg));
> +			ally_put_udev_if_orphaned();
> +			return ERR_PTR(PTR_ERR(ally_cfg));
> +		}
> +

[Severity: Medium]
Does this code intentionally skip assigning the newly created configuration
to the driver data?

Looking at hid_asus_ally_probe(), ally_cfg is allocated via
ally_config_create(), but it is never assigned to ally_drvdata.config
(for example, alongside the ally_drvdata.cfg_hdev =3D hdev assignment later
in the function).

Without this assignment, won't ally_get_config() always return NULL?
This appears to make the gamepad sysfs attributes non-functional, as
subsequent sysfs callbacks will unconditionally return -ENODEV when
attempting to read or write the unassigned configuration.

>  		ret =3D hid_asus_ally_init(hdev, &ally_drvdata);
>  		if (ret < 0) {
>  			ally_put_udev_if_orphaned();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830234320.1143=
56-1-denis.benato@linux.dev?part=3D4
