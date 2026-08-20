Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C32E445ACD;
	Thu, 20 Aug 2026 12:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230069; cv=none; b=bY+K1bg1CUZwhgkVk3M9VsfRCl0HN0q+bsqkfDA5AQack0vtpir/G728mnhMGDVgxh/9vEiL5k2ydiBFIa66PGlCStmoWq0KVnCRPO40aPeokTmnAmKJrXRsl+pSDyY4kT6glS1eeDENFqU2tCD+1sE5rF/IzHWimGfAfj+LbLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230069; c=relaxed/simple;
	bh=/RLes/qkOJgobxykF741qQXn6WOO94g2Pril5u0AaGQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YqC4IJN1YdvEFf6zfFLZJ6La85sWjuvpkgf/63VJwF82Cnts6Q0/mYzozXO867OrIFa7qOk203B1PfsKybup9zz//NrBsY4pJn16LB0XQEaFOR0QiFVwwysTO1nm1eFUVvtDK/H/osMXv2YMWsdZZAgoPYv3FVilVPBS4KJKWzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLQPREYt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLQPREYt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756411F000E9;
	Thu, 20 Aug 2026 12:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787230067;
	bh=4VdqzTTJbGsDVjw80JRvgJDAILT1g/Solzk/ipYp/FA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YLQPREYt0GIgvLTSVMYinHLNNd/gaKy+8nxvgiXZzXhQhd3zLqFefxoBIY5+1AnFh
	 us5cXvnJ3gjL6LrVeeosTD2yQ0rcylD3GuedcjaelYh8U0dBC3JtefLFAKUHL9F0xO
	 GDmcemCEN04MkLh0Y37sjvWF7oDFN/wOXlEmSd1XmMfLd9nNzgqBX1XM8S0kFp/+4r
	 Axt5D9SWhcBIGfuCcO2TTIywlCw3r+D/TyfV2CFTJZVBN4SHvYhPmhRHHiM+26Iz/x
	 co0qSjn2JX6TxIe+SBv+hhQr7cnVmGBPP0hPIbbtyK0czpyL0674UZqCss65Uq/pls
	 rlFv7rz9L0/pA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/9] mfd: mt6397: Use MFD_CELL_* to describe
 sub-devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: lee@kernel.org, robh@kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org, mfd@lists.linux.dev, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260820122242.120039-5-l.scorcia@gmail.com>
References: <20260820122242.120039-1-l.scorcia@gmail.com>
 <20260820122242.120039-5-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 12:47:46 +0000
Message-Id: <20260820124747.756411F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but missing PM notif=
ier cleanup in the probe error path and lack of a .remove hook leads to a u=
se-after-free on suspend/resume or driver unbind.
--

--- Patch [4]: [PATCH v9 4/9] mfd: mt6397: Use MFD_CELL_* to describe sub-d=
evices ---
commit 0c24567f61112fe4c7555b7e30256529aae1d5d6
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>

mfd: mt6397: Use MFD_CELL_* to describe sub-devices
   =20
This commit updates the mfd_cell arrays for various MediaTek MT6397 family
PMICs to use the standard MFD_CELL_OF() and MFD_CELL_NAME() macros instead =
of
manual field initialization. No functional changes are intended.

> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index 1bdacda9a933f..ccd97d66d7f1c 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c

[ ... ]

> @@ -272,11 +202,14 @@ static const struct mfd_cell mt6397_devs[] =3D {
> -	}, {
> -		.name =3D "mt6397-keys",
> -		.num_resources =3D ARRAY_SIZE(mt6397_keys_resources),
> -		.resources =3D mt6397_keys_resources,
> -		.of_compatible =3D "mediatek,mt6397-keys"
> -	}
> +	MFD_CELL_OF("mt6397-keys", mt6397_keys_resources, NULL, 0, 0,
> +		    "mediatek,mt6397-keys"),
>  };

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential
use-after-free issue in the driver's error handling and unbind paths.

In drivers/mfd/mt6397-irq.c:mt6397_irq_init(), the PM notifier is registered
globally with register_pm_notifier() but without devres management.

In drivers/mfd/mt6397-core.c:mt6397_probe(), if devm_mfd_add_devices() fail=
s,
the error path removes the IRQ domain but fails to unregister the PM notifi=
er
before returning.

Furthermore, mt6397_driver lacks a .remove hook entirely. Unbinding the dri=
ver
via sysfs completely bypasses cleanup for both the PM notifier and the IRQ
domain.

In both the probe failure and driver unbind scenarios, the devres subsystem
subsequently frees the memory containing the notifier block and IRQ domain =
host
data. When the system later enters suspend or resume, pm_notifier_call_chai=
n()
will iterate over the freed memory.

Could this lead to a kernel panic? Should a .remove hook be added and the
probe error path updated to ensure the PM notifier is properly unregistered?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820122242.1200=
39-1-l.scorcia@gmail.com?part=3D4
