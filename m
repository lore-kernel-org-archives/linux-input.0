Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC6144A3FF;
	Sat, 12 Sep 2026 08:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202775; cv=none; b=EzDLiolweIJn9zjCQvurgwq+iYxz8yyanH2HKnty3et78T+v12Td/uglP9cq0m0y99FayVZMICbbhJd5weFn1V5Y+CoLKcUGuSJ9M4ob6jyt7Be2WFJAnK93ExMMC2dgBDSqWjnpmF1du1rNfVS+blSb8DTnzcN3q4pXbdqdnto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202775; c=relaxed/simple;
	bh=AvKM5OdLUDjOXcd11ipVuO9zyaZkQKQ3fcCy2aOGD0Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jPRx6JTpnFbqn0REg4uYRtCgRn0Kt1FjutISE/3CSsqAx6722rNUrse7r20p26Bdwx2jG02AqqYBuoAVL4EezvsEQJvh6hgYtqfRItUHas1ua5VhLsn+br5vcO0HlGYhKReyqbR19doZjIO8r9b3HY/RIFYRF3tWKwxt81BZOpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCpOTbJn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCpOTbJn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F19C1F000FF;
	Sat, 12 Sep 2026 08:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789202773;
	bh=ecWOxmhoq7Ic5zx5rNbRf+/ALXOeZ3rZSpCd1T2lK/k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OCpOTbJnTuiITASaRHXfPhN8Ai0zfGYOw4LqP6OLrS76Fu7KIAx4b/hCASfl9SvU5
	 3bA/KJNSj0dtUW5HOyH2H1uTBBxa2D7261nupkvRhGWnLkhu26gwr/WnzqZcrYG68L
	 6U2agJ+9bVnOaIYWLycC2KQyzkBCfqx0ukwGNk+Vk4IscAXRY34+c/wCCg0wVLgI3H
	 eYtRYDMW1e/UBY8UUl7ANlY3F0UFP3V2Q3DOeY54ru5uHg7hWYyq4eQZexyhQ6W2A9
	 hMkFRtHdrwyCkvN90q06wpX8ycJj4bdkbG8gpn5X/BwD+fArvERQYsLnSDhFIU30wh
	 3kQw3yGdTRSzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 13/20] clk: qcom: smd-rpm: Add clocks for MSM8952
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: dmitry.torokhov@gmail.com, linux-clk@vger.kernel.org, conor+dt@kernel.org, linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org, mfd@lists.linux.dev, robh@kernel.org, lee@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260912-msm8952-initial-support-v1-13-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-13-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:46:12 +0000
Message-Id: <20260912084613.4F19C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unnecessary duplication of clock array and descriptor structures fo=
r MSM8952, which are identical to MSM8976.
--

commit cc0d394f5055e6be5a5f88b51a807761e8dafacc
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

clk: qcom: smd-rpm: Add clocks for MSM8952

This commit adds clock definitions for the MSM8952 platform. The commit=20
message notes that MSM8952 shares the same clocks as MSM8976 and MSM8940.

> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rp=
m.c
> --- a/drivers/clk/qcom/clk-smd-rpm.c
> +++ b/drivers/clk/qcom/clk-smd-rpm.c
> @@ -740,6 +740,34 @@ static const struct rpm_smd_clk_desc rpm_clk_msm8940=
 =3D {
>  	.num_icc_clks =3D ARRAY_SIZE(bimc_pcnoc_snoc_smmnoc_icc_clks),
>  };
> =20
> +static struct clk_smd_rpm *msm8952_clks[] =3D {
> +	[RPM_SMD_XO_CLK_SRC] =3D &clk_smd_rpm_branch_bi_tcxo,
[ ... ]
> +static const struct rpm_smd_clk_desc rpm_clk_msm8952 =3D {
> +	.clks =3D msm8952_clks,
> +	.num_clks =3D ARRAY_SIZE(msm8952_clks),
> +	.icc_clks =3D bimc_pcnoc_snoc_smmnoc_icc_clks,
> +	.num_icc_clks =3D ARRAY_SIZE(bimc_pcnoc_snoc_smmnoc_icc_clks),
> +};
> +
[ ... ]
> @@ -1292,6 +1320,7 @@ static const struct of_device_id rpm_smd_clk_match_=
table[] =3D {
>  	{ .compatible =3D "qcom,rpmcc-msm8936", .data =3D &rpm_clk_msm8936 },
>  	{ .compatible =3D "qcom,rpmcc-msm8937", .data =3D &rpm_clk_msm8937 },
>  	{ .compatible =3D "qcom,rpmcc-msm8940", .data =3D &rpm_clk_msm8940 },
> +	{ .compatible =3D "qcom,rpmcc-msm8952", .data =3D &rpm_clk_msm8952 },

[Severity: Low]
Since the commit message notes that MSM8952 has the exact same clocks as
MSM8976, could we avoid duplicating msm8952_clks and rpm_clk_msm8952 by
simply reusing the existing rpm_clk_msm8976 descriptor here?

Other devices in this driver use this pattern to avoid redundancy, such as
qcom,rpmcc-msm8226 which reuses rpm_clk_msm8974. Would setting the data
pointer to &rpm_clk_msm8976 work for MSM8952 as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D13
