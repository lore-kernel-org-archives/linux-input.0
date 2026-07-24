Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C371E3A960A
	for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 07:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784879136; cv=none; b=HBxg2wZMF31xcxyDOIjij+4fiWuU/CiJYDaZ2bSbkDno5JcoICX4TlE4cPFEFesP5KMBWDMR2lx2Rl0TAME7U/Wv6TUL4uEsNxZqWbj+DTChv7wiDmi8BCQGKQX5SalTWwFPsWqUOFLDsVrEdjAe2MOAZ2kkT+7z1wVZgRKQhEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784879136; c=relaxed/simple;
	bh=Ga5EKR4S/Vz92tUd1yWNaId5dCO8C7LhZwYgnvT+zk8=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xefk3LPzLpKlYpgT0fYGaPZ3OjUM2gpyM6rvvzwar9i7JpUN7IojnNHK+fFAn/0wTcsxyGtXSlXfD2hQ8LP7ZjOiUSdgD+1Z/fZd6gaSAboN5UXn2xkPD74RO6aiLVrsA7WBD06/wCfcplkMyu9ids95rg928F8p87ZabH1v9KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFTGtRPi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFTGtRPi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600651F00A3A
	for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 07:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784879135;
	bh=GrrnEVjLeDYohAytxd9LGHL0XtaF/3QpIP+vjIXf7kY=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=QFTGtRPiljZBiO3q7FgTkHoETpqGXso5vKPegYuHLZmgv2Duzuk3mbNV2nfqUnvkm
	 PDBjWMh8zLZdOunZGKGtIjoIvxd8HHpCTxfuiNMfyIjIcaWrsL/x/DO2IB5nqIj2ZS
	 v/lqV3N9C4+EvEc+XIonse6p7T/r0+aL/XXVTB2Tt2jlcbNGuqQUptKFocEoP+LxQm
	 V9H6Ze/8gJ6BR1qUo6aqPO1e+W3jT2AFI3lppwWGbXmNOHJKwvXS/DLvzrzpHmuaIZ
	 Hq68lo1n2IwKrQ5nly3a3NmLvMbNdXC4cgUi22r7kQ3BsF8Dv1hYHeVtt6NrjWYqyq
	 FjNohO9xi377A==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39c7fd45465so1009341fa.1
        for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 00:45:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rox4MowrdBmTVxHe/xB909/yN7ioYRFzRH/gbrYvEqOCck5wjsR7zdQ+iHBwn3RdQEXzGhKRaNjFPHhdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YymifYdPDispquNYTEiw+k4DkKSAPtkUxOjBFiTMTUFIGv9bpHJ
	zGDOTALDjlw2f0foiJkaQh1AJRMBi5mrEgAd/dpBN0JRiTTDwVXSATYJoccbZJ9yPbGvajeBh+x
	iZ6KFJGqgdplOXsFriqAHwd4Ay7+z2ZTVPb/Qnl28Tw==
X-Received: by 2002:a2e:9193:0:b0:39b:2df2:9014 with SMTP id
 38308e7fff4ca-39f07c63c72mr10175241fa.7.1784879133867; Fri, 24 Jul 2026
 00:45:33 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 00:45:31 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 00:45:31 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260723175325.37397-2-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723175325.37397-1-farbere@amazon.com> <20260723175325.37397-2-farbere@amazon.com>
Date: Fri, 24 Jul 2026 00:45:31 -0700
X-Gmail-Original-Message-ID: <CAMRc=MeE_FdDMpXzzBB2dwH18DWmmT9B=CeouoaG1tV=y6-fXQ@mail.gmail.com>
X-Gm-Features: AUfX_mxqAq5L_5_Kqqzi2lfcFgjsyeDKqIXC9pdA6t902qhg92eJpMfCKmh9flc
Message-ID: <CAMRc=MeE_FdDMpXzzBB2dwH18DWmmT9B=CeouoaG1tV=y6-fXQ@mail.gmail.com>
Subject: Re: [PATCH 01/12] notifier: add device-managed registration APIs
To: Eliav Farber <farbere@amazon.com>
Cc: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com, 
	mchehab@kernel.org, xueshuai@linux.alibaba.com, lenb@kernel.org, 
	laurent.pinchart@ideasonboard.com, linusw@kernel.org, brgl@kernel.org, 
	orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	dmitry.torokhov@gmail.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	W_Armin@gmx.de, ukleinek@kernel.org, fabio.m.de.francesco@linux.intel.com, 
	kaihengf@nvidia.com, ankita@nvidia.com, leitao@debian.org, 
	jason@os.amperecomputing.com, pedro.pbg@usp.br, paulmck@kernel.org, 
	frederic@kernel.org, kees@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Jul 2026 19:53:14 +0200, Eliav Farber <farbere@amazon.com> said:
> Add devm_atomic_notifier_chain_register(),
> devm_blocking_notifier_chain_register(), and
> devm_raw_notifier_chain_register() that automatically unregister the
> notifier when the device is unbound.
>
> Many drivers repeat the same boilerplate pattern:
>
>   1. Register the notifier with *_notifier_chain_register()
>   2. Check for error
>   3. Register a devm action to unregister on teardown
>   4. Implement a per-driver static unregister callback
>
> With the new devm_*_notifier_chain_register() APIs, this reduces to a
> single call with one error path, eliminating per-driver unregister
> callbacks entirely.
>
> The implementation follows the established devres pattern used by other
> device-managed kernel APIs.
>
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>  include/linux/notifier.h |  10 +++
>  kernel/notifier.c        | 151 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 161 insertions(+)
>
> diff --git a/include/linux/notifier.h b/include/linux/notifier.h
> index 01b6c9d9956f..aa3745d7459b 100644
> --- a/include/linux/notifier.h
> +++ b/include/linux/notifier.h
> @@ -46,6 +46,7 @@
>   * often but notifier_blocks will seldom be removed.
>   */
>
> +struct device;
>  struct notifier_block;
>
>  typedef	int (*notifier_fn_t)(struct notifier_block *nb,
> @@ -145,10 +146,19 @@ extern void srcu_init_notifier_head(struct srcu_notifier_head *nh);
>
>  extern int atomic_notifier_chain_register(struct atomic_notifier_head *nh,
>  		struct notifier_block *nb);
> +extern int devm_atomic_notifier_chain_register(struct device *dev,
> +		struct atomic_notifier_head *nh,
> +		struct notifier_block *nb);

Please don't use extern with function prototypes in new code.

>  extern int blocking_notifier_chain_register(struct blocking_notifier_head *nh,
>  		struct notifier_block *nb);
> +extern int devm_blocking_notifier_chain_register(struct device *dev,
> +		struct blocking_notifier_head *nh,
> +		struct notifier_block *nb);
>  extern int raw_notifier_chain_register(struct raw_notifier_head *nh,
>  		struct notifier_block *nb);
> +extern int devm_raw_notifier_chain_register(struct device *dev,
> +		struct raw_notifier_head *nh,
> +		struct notifier_block *nb);
>  extern int srcu_notifier_chain_register(struct srcu_notifier_head *nh,
>  		struct notifier_block *nb);
>
> diff --git a/kernel/notifier.c b/kernel/notifier.c
> index 2f9fe7c30287..b811638aa878 100644
> --- a/kernel/notifier.c
> +++ b/kernel/notifier.c
> @@ -1,4 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/device.h>
>  #include <linux/kdebug.h>
>  #include <linux/kprobes.h>
>  #include <linux/export.h>
> @@ -197,6 +198,55 @@ int atomic_notifier_chain_unregister(struct atomic_notifier_head *nh,
>  }
>  EXPORT_SYMBOL_GPL(atomic_notifier_chain_unregister);
>
> +struct atomic_notifier_chain_devres {
> +	struct atomic_notifier_head *nh;
> +	struct notifier_block *nb;
> +};
> +
> +static void devm_atomic_notifier_chain_unregister(struct device *dev, void *res)
> +{
> +	struct atomic_notifier_chain_devres *dr = res;
> +
> +	atomic_notifier_chain_unregister(dr->nh, dr->nb);
> +}
> +
> +/**
> + *	devm_atomic_notifier_chain_register - Device-managed atomic notifier registration
> + *	@dev: Device to tie the notifier lifetime to
> + *	@nh: Pointer to head of the atomic notifier chain
> + *	@n: New entry in notifier chain
> + *
> + *	Adds a notifier to an atomic notifier chain and registers a cleanup
> + *	action to automatically unregister it when @dev is unbound.
> + *
> + *	Returns 0 on success, negative errno on error.

Should be:

Returns:
0 on success...

Bart
