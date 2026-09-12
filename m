Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB51E37E5F3;
	Sat, 12 Sep 2026 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789203087; cv=none; b=WT5RC1/n/OU20vM6LeBVpSLaoF4XtvSZQqpxgmyKQsPX/8PMUg8nsCGckAdqcxAy/oi4jWepnbgNnwG3Q7ex+I8VV5aHepB4/i95QtzuFFBRWFIfzTtm+B6wiiI1/eXBw6uJt+6aYf+XK/GrmtMpYvjhydtBIeB0raQgMgHB9hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789203087; c=relaxed/simple;
	bh=RMMswATTjbtFJnE9NF7ztfoDWtTzN9CB+01HwhdOJzE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hr4L/AmyTxaHpfufKTWZrkk5Jssz9KxvApq1q2QCQwJhQrjEG1cSPXy0liC1k7yKM3pLs8xntpExywflrJdPk18RRyrDvuRx01JKh5CoLaDbXDZb4ArZIJZ1u4dFKinJpixgiCUwKE2q2wEqq4QNPivmak/kLZGYAnZpCBs/LAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcGmhrdP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcGmhrdP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422BD1F000FF;
	Sat, 12 Sep 2026 08:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789203085;
	bh=ODPsh160UbnsA7ODNyf6Eev5Vn1YdxIcSEej72cJkY4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RcGmhrdPI3C6ZmL6piwomcCndbq8svweriHDqQZRfY448RRI/ImQHaROTSYY0S5WJ
	 XZAqqflX4TfTZOaOoProyFoY7n9yXP00sPEst06PHIgVAjNRsoi+TwIQn/kZ7uvyvf
	 /zEgHWiZbrIWvi5+THYeJnkvnnGDirZzWOkrBQEoS5u8eSL2UWHYoR1OxO2Yea9aAH
	 61YrE7ubE+2Ck140HixmkDryXz1srTgg7bRDtO3bqsols3EQoZt1qyxLcxhR06C/sj
	 yUlsuDHhwlntHT+pykfeC5CocjMcbxHSN9plfPRzp2jykkiEKy5o3vOIPok2iyi1o5
	 uIe1ZNYO77oow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 17/20] thermal: qcom: tsens: Add support for MSM8952
 tsens
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, mfd@lists.linux.dev, lee@kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260912-msm8952-initial-support-v1-17-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-17-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:51:24 +0000
Message-Id: <20260912085125.422BD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Heap Out-Of-Bounds Write in `init_8952` when device tree overrides=
 `#qcom,sensors`.
- [High] Use-After-Free via Section Mismatch: `init_8952` is annotated with=
 `__init`, but can be called after boot memory is freed.
- [Medium] Potential thermal calibration inaccuracy by replacing SoC-specif=
ic logic with hardcoded generics.
--

commit 7ec3bedeaa96c98b6f844188546432e42095ad77
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

thermal: qcom: tsens: Add support for MSM8952 tsens
   =20
Add MSM8952 support for tsens.
   =20
Downstream does a lot of advanced things with calculations.
But seems like using tsens-v1 directly works too.

Link: https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-w=
ear-7.0.0_r0.3/drivers/thermal/msm-tsens.c#1621

> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens=
-v1.c
> index faa5d00788ca6..f4201748ea297 100644
> --- a/drivers/thermal/qcom/tsens-v1.c
> +++ b/drivers/thermal/qcom/tsens-v1.c
> @@ -145,6 +145,37 @@ static const struct reg_field tsens_v1_regfields[MAX=
_REGFIELDS] =3D {
>  	[TRDY] =3D REG_FIELD(TM_TRDY_OFF, 0, 0),
>  };
> =20
> +static int __init init_8952(struct tsens_priv *priv)

[Severity: High]
Since the tsens driver probe can be deferred due to nvmem calibration data
dependencies, or the device could be manually unbound and rebound via sysfs,
could this __init annotation cause a use-after-free?

The ops_8952 struct stores the pointer to this function in .rodata. If the
function is freed after boot memory is reclaimed, calling priv->ops->init()
during a deferred probe will jump to a freed address.

[Severity: Medium]
The commit message notes that downstream does advanced calculations, but th=
is
implementation replaces them with static generic offsets. Could this lead to
thermal calibration inaccuracies?

If these static offsets do not accurately reflect the physical thermal
curves of all MSM8952 chips, could the kernel read skewed temperatures
and fail to act on thermal events?

> +{
> +	for (int i =3D 0; i < priv->num_sensors; ++i)
> +		priv->sensor[i].slope =3D 3200;
> +
> +	priv->sensor[0].p1_calib_offset =3D 2;
> +	priv->sensor[0].p2_calib_offset =3D -1;

[ ... ]

> +	priv->sensor[9].p1_calib_offset =3D 0;
> +	priv->sensor[9].p2_calib_offset =3D 0;
> +	priv->sensor[10].p1_calib_offset =3D -3;
> +	priv->sensor[10].p2_calib_offset =3D -2;

[Severity: High]
Could this result in a heap out-of-bounds write?

In tsens_probe(), num_sensors defaults to 11 but can be overridden by the
"#qcom,sensors" device tree property. The priv->sensor array is then
dynamically allocated based on this count using struct_size().

If a device tree specifies a num_sensors value less than 11, these hardcoded
unconditional assignments will write beyond the bounds of the allocated heap
array.

> +
> +	return init_common(priv);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D17
