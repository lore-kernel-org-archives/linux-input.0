Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40123395AE9;
	Wed,  2 Sep 2026 20:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788379858; cv=none; b=OsJu3TtxSgiLI8mP34U3NP/izmiFO4mKfOXs0W7Fz3ReIHxGps9eRDyZL3ez+fb8eQK5nWdia0xc0NaGkxFlIZwV66J3LJfVkqLQTFxDxW/yOBCQg7+bvoX0sOdtHzCsqzzwtoMU8WNa6xf+AKZo408UQJNlVAHTzWOq8sa3AE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788379858; c=relaxed/simple;
	bh=ZQ/b9PDsQsPfQuGBXzgd3cgXZgte0WnN6uex/E7gz6Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mp7fWz2VOKlk3L3bxWybUWpNpASoi7l1gNkiioU/pq4ecf6pBEpkD4bTMuEqrWh9ka0xqddCT914gBhLUNncm9kVLN9BCAMaognAvEmAaSAMsW4chgxVGQeX32Wgg7HaMlei2E+NHIHkPsSRFbdT4XlgUo27ftpAOe/+aqVDlYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIEuytdm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIEuytdm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006B61F00A3A;
	Wed,  2 Sep 2026 20:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788379852;
	bh=uMFpygn72Dn+dYJFWe9y3IgF5qG7Zfpz62g92hOkRNc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GIEuytdm67aWwHrxOJM9/RoxWsHmSMkI84Ymqd+tgLU/FTWA61jJCOgOfvulLSXv7
	 cpYKkJRUkPYkSE7/zkwNk+YCUJv/ELoMsSKhNIbjIJQ2i1KTfo/7Gmt0kNrjvZWlAK
	 Gkrb98ldIS+VoL/E+LpSX3swFmEX4YWRk0is8sjuM+Em7a5JBdVB/IflyaSDBd7ikI
	 pfP0j1t0izzxtVD/Z3ObmVWxWmxTE43RICM09EW0xbyfxEck/H3iqFwJaqCBsJAXdQ
	 sxef9z+ds/Yc3Ymklw79V9hiDO8eDBgD3ii3XGDL4fCHYk4/nOvTlP5cyR4gClioTD
	 soxTVe11xwZcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 4/9] mfd: mt6397: Use MFD_CELL_* to describe
 sub-devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, mfd@lists.linux.dev, robh@kernel.org, linux-input@vger.kernel.org, lee@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260902193351.185771-5-l.scorcia@gmail.com>
References: <20260902193351.185771-1-l.scorcia@gmail.com>
 <20260902193351.185771-5-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 20:10:51 +0000
Message-Id: <20260902201052.006B61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing .remove callback leads to PM notifier use-after-free and I=
RQ domain memory leak on module unload.
--

commit 6a7d774cdf490c33501d839d753ee001e1219166
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>

mfd: mt6397: Use MFD_CELL_* to describe sub-devices

Use the MFD_CELL_* macros to describe sub-devices. No functional changes.

> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index 9ec9519965887..3e08179002fad 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c
> @@ -124,165 +124,92 @@ static const struct resource mt6323_pwrc_resources=
[] =3D {

[ ... ]

>  static const struct mfd_cell mt6397_devs[] =3D {
> -	{
> -		.name =3D "mt6397-rtc",
> -		.num_resources =3D ARRAY_SIZE(mt6397_rtc_resources),
> -		.resources =3D mt6397_rtc_resources,
> -		.of_compatible =3D "mediatek,mt6397-rtc",
> -	}, {
> -		.name =3D "mt6397-regulator",
> -		.of_compatible =3D "mediatek,mt6397-regulator",
> -	}, {

[ ... ]

> +	MFD_CELL_OF("mt6397-keys", mt6397_keys_resources, NULL, 0, 0,
> +		    "mediatek,mt6397-keys"),
>  };
> =20
>  struct chip_data {

[Severity: High]
This is a pre-existing issue, but looking at the platform driver definition:

drivers/mfd/mt6397-core.c:
    static struct platform_driver mt6397_driver =3D {
        .probe =3D mt6397_probe,
        .driver =3D {
            .name =3D "mt6397",
            ...
        },
        ...
    };

Could the absence of a .remove callback lead to a PM notifier use-after-free
and IRQ domain memory leak on module unload?

During probe, mt6397_probe() calls mt6397_irq_init() which registers a PM
notifier with register_pm_notifier(&chip->pm_nb) and creates an IRQ domain
with irq_domain_create_linear().

Because the mt6397_driver struct lacks a .remove callback, unbinding the
driver (via module unload or sysfs) triggers standard devm teardown, freeing
the chip structure that was allocated via devm_kzalloc().

Doesn't this leave the kernel's PM notifier chain with a dangling pointer
to the freed chip->pm_nb, causing a crash on the next suspend/resume cycle,
and leave the IRQ domain unremoved?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902193351.1857=
71-1-l.scorcia@gmail.com?part=3D4
