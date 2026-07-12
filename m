Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECF73A1DB;
	Sun, 12 Jul 2026 02:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783822823; cv=none; b=vCclq3A+FMQ9AG6ET+D0Yhy3Fa4eRdL914Dt0My8nKyYjcDfbY7cLB/4nyoY1g4Bk6NbPnLZ0Rfy1dFSyNFx7ueG4PPW+z9wcgtbTjPBELKNLD1gnHUqPG9vtxPlCGbIanRfWxCHhgKtS3blUjcJyiAIBh12vzt5bfBgQJCCkHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783822823; c=relaxed/simple;
	bh=UEwSnQrc0GNNxPQ2OPlcG3g+wLgSUjmNF9m4rA1RmSI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OEKdpm08ruoY0GsCH14gvrTkgK9+3xKWXU+TwivtUgb5kFIMZchbGHCf4ELgjI6ItVRgtchWUg5eGIFhxwkbnjlTpP4oPdUaBRjGADj7W3xfLzaN0NsS2d9J79Iu86AlPUPN3B84JCFx6Jmy0YNZTVbBTg5se6awBudM3M1Hzyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtcvAv9q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtcvAv9q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E022D1F000E9;
	Sun, 12 Jul 2026 02:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783822822;
	bh=V9vudyrkc+/SJFAx6PZQZqWLDoFIx7qC14Tm8rZKvf4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JtcvAv9quCN34jXr+kD8nk0p33z/XFu4+EnTYZfROTJsIEvZ4KD5NxHXTJrQ1/FUf
	 yovMAEE5AIDzk87jMQVtEQDDcS2tYtSv+YjATBwrImfDw1xoa0Wyr1YMTmEX5OnisA
	 5+AvUFAaPdAlY3k/PL9SAO416O0XkMeQ/pNA6IEiHBj74aJiWHSNKuys4WeXXEO4NS
	 3MEgW1tOKAgWy7/tWhwElE3m36YDIUCk8lqIUp5TsGfYD1DpJMQ55dLBBbfhSaseUQ
	 XjpdsH9AtjbNaIsnKpfKmDytnuctT1dFF1VMXy7FcBXAIBiL3gdtV6hKcowbldhJvN
	 k6wyfizjgPkyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/10] mfd: wm831x: support software nodes for DCDC
 regulators
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: conor+dt@kernel.org, robh@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260711-samsung-kp-v3-7-b2fcaba77aff@gmail.com>
References: <20260711-samsung-kp-v3-0-b2fcaba77aff@gmail.com>
 <20260711-samsung-kp-v3-7-b2fcaba77aff@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 02:20:21 +0000
Message-Id: <20260712022021.E022D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The patch dynamically duplicates and modifies an `mfd_cell` arra=
y to inject software nodes, directly violating MFD subsystem guidelines.
- [Low] The commit message description starts with a lowercase letter, viol=
ating MFD subsystem formatting rules.
--

--- Patch [7]: [PATCH v3 07/10] mfd: wm831x: support software nodes for DCD=
C regulators ---
commit 3d69bbb3a9fcf1555157438b7a85ed2a2744e94b
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

mfd: wm831x: support software nodes for DCDC regulators

This commit allows passing software nodes to wm831x DCDC regulators via PMIC
platform data. It adds dcdc_swnodes to the PMIC platform data and dynamical=
ly
assigns these software nodes to the buckv cells during device addition.

> mfd: wm831x: support software nodes for DCDC regulators

[Severity: Low]
This isn't a bug, but should the description after the subsystem prefix be
capitalized? The MFD subsystem conventions generally expect:
"mfd: wm831x: Support software nodes for DCDC regulators".

> diff --git a/drivers/mfd/wm831x-core.c b/drivers/mfd/wm831x-core.c
> --- a/drivers/mfd/wm831x-core.c
> +++ b/drivers/mfd/wm831x-core.c

[ ... ]

> @@ -1449,6 +1450,32 @@ const struct of_device_id wm831x_of_match[] =3D {
>  };
>  EXPORT_SYMBOL_GPL(wm831x_of_match);
> =20
> +static int wm831x_add_devices(struct wm831x *wm831x, int wm831x_num,
> +			      const struct mfd_cell *cells, int num_cells)
> +{
> +	struct wm831x_pdata *pdata =3D &wm831x->pdata;
> +	int i;
> +
> +	struct mfd_cell *local_cells __free(kfree) =3D
> +		kmemdup_array(cells, num_cells, sizeof(*cells), GFP_KERNEL);

[Severity: Medium]
Does this code dynamically duplicate the mfd_cell array to amend it?

The MFD subsystem guidelines advise that mfd_cell arrays should remain stat=
ic
references, and we should avoid creating local copies for dynamic amendment=
s.
Is there an alternative way to pass the software nodes without allocating a=
nd
modifying a duplicated cell array?

> +	if (!local_cells)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < num_cells; i++) {
> +		struct mfd_cell *cell =3D &local_cells[i];
> +
> +		if (strcmp(cell->name, "wm831x-buckv") =3D=3D 0) {
> +			int id =3D cell->id - 1;
> +
> +			if (id >=3D 0 && id < WM831X_MAX_DCDC)
> +				cell->swnode =3D pdata->dcdc_swnodes[id];
> +		}
> +	}
> +
> +	return mfd_add_devices(wm831x->dev, wm831x_num, local_cells, num_cells,
> +			       NULL, 0, NULL);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711-samsung-kp=
-v3-0-b2fcaba77aff@gmail.com?part=3D7
