Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990242BE051;
	Fri, 12 Jun 2026 20:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781296748; cv=none; b=RLCB/B4cyEyUa/eOT1PyLzWnuFRdtsc+vP3g62pezZr2rYMxTpoUseXASAULTXrsk1ASHcE1drK5W7QEk3zGwxuYDj0UNODy1eUAXVzcaLTnT+mu3hj2fJarGyKTKEIqzMdGliPoZL1R+i403HbN5Y+1a2gszCueosxI/WYtl9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781296748; c=relaxed/simple;
	bh=eicU+rt9aGU++NavoZzZRElg9JuqfKGQbf+nodk5C4k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B2mZwAgcgppwIUceyn6SjMshO8IPYy4RzRZOCRothWCXk2bLKzBVMoKxMNNxlWCNZAGclcNaDQlf+yWeRBOnM+zXVbC8tlQDYroA/4ouamaTGg+S+82fE7lgAT9S1ia2/Ls1J90WO+uomxJ8qpDgFqeVegYkFin+c+m9fJLnqa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJp+kr7k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJp+kr7k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53231F000E9;
	Fri, 12 Jun 2026 20:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781296747;
	bh=CFXkz/KtKZUVRH+VGbL5pBMt6IMlfPCCe2Qmgr4JUk4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YJp+kr7kRYl4REdCACrwSuJkBH583n3Z06PCltITAbDpmKUzEq6Ol5137pbXaNoPJ
	 7B2l5T1XjEhLBEWQaR2UQYN5CuULE3Rl8Mb6HXKoRlwK0c00dE1ZshATNqGKwbympx
	 LGVb1y33BcFjt1VP9uX2le6G4YHYRsf/4+bhKroPndcA+JW9Biwv3vrssq6IoXdTvc
	 LwicM6HEMjy7zUww/DltYmX8UbKpjFV9iUQpXuy072GjgMBF4hQfI3VFh2azuHMnw/
	 XsZXc1+iwkzJMwXccSohzI0y6f+VW4bemxZSYTbvY/1Ys0j68R3RqoZlc5X7ZKa+hS
	 BGWpUAVuAwj0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/7] input: keyboard: mtk-pmic-keys: Add MT6392
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260612200717.361018-6-l.scorcia@gmail.com>
References: <20260612200717.361018-6-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 20:39:06 +0000
Message-Id: <20260612203906.E53231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds array access and incorrect parsing of disabled DT no=
des in `mtk_pmic_keys_probe` due to a mismatch between child counting and i=
teration macros.
- [High] `mt6357_regs` incorrectly uses `MTK_PMIC_HOMEKEY_INDEX` instead of=
 `MTK_PMIC_HOMEKEY_RST` for the home key reset mask.
--

commit 2b2bdf18b713288536d3d56d4b82a48e65594233
Author: Val Packett <val@packett.cool>

    input: keyboard: mtk-pmic-keys: Add MT6392 support
   =20
This commit adds support for the MT6392 PMIC to the mediatek pmic keys driv=
er
by defining its specific register layout and adding the required compatible
string.

> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keybo=
ard/mtk-pmic-keys.c
> index c78d9f6d97c4f..8b4a89fce4fb1 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c

[ ... ]

> @@ -69,6 +70,19 @@ static const struct mtk_pmic_regs mt6397_regs =3D {
>  	.rst_lprst_mask =3D MTK_PMIC_RST_DU_MASK,
>  };
> =20
> +static const struct mtk_pmic_regs mt6392_regs =3D {
> +	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =3D
> +		MTK_PMIC_KEYS_REGS(MT6392_CHRSTATUS, 0x2,
> +				   MT6392_INT_MISC_CON, 0x10,
> +				   MTK_PMIC_PWRKEY_RST),
> +	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =3D
> +		MTK_PMIC_KEYS_REGS(MT6392_CHRSTATUS, 0x4,
> +				   MT6392_INT_MISC_CON, 0x8,
> +				   MTK_PMIC_HOMEKEY_RST),
> +	.pmic_rst_reg =3D MT6392_TOP_RST_MISC,
> +	.rst_lprst_mask =3D MTK_PMIC_RST_DU_MASK,
> +};
> +

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential
out-of-bounds access in mtk_pmic_keys_probe() due to a mismatch in child no=
de
parsing:

drivers/input/keyboard/mtk-pmic-keys.c:mtk_pmic_keys_probe() {
    ...
	keycount =3D of_get_available_child_count(node);
	if (keycount > MTK_PMIC_MAX_KEY_COUNT) {
		dev_err(dev, "too many keys defined (%d)\n", keycount);
		return -EINVAL;
	}

	for_each_child_of_node_scoped(node, child) {
		keys->keys[index].regs =3D &keys->mtk_regs->keys_regs[index];
    ...
}

The check uses of_get_available_child_count(), which skips nodes with
status=3D"disabled", but the loop uses for_each_child_of_node_scoped(), whi=
ch
iterates over all child nodes regardless of their availability.

If a device tree defines more than MTK_PMIC_MAX_KEY_COUNT nodes but disables
enough to pass the initial check, could the loop execute more than
MTK_PMIC_MAX_KEY_COUNT times?  Would this cause an out-of-bounds array acce=
ss
on the keys->keys[] and irqnames[] arrays?

[Severity: High]
This is a pre-existing issue as well, but looking at the existing register
definitions, mt6357_regs appears to use the wrong macro for the home key
reset mask:

drivers/input/keyboard/mtk-pmic-keys.c:
static const struct mtk_pmic_regs mt6357_regs =3D {
	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =3D
		MTK_PMIC_KEYS_REGS(MT6357_TOPSTATUS,
		0x2, MT6357_INT_MISC_CON, 0x10, MTK_PMIC_PWRKEY_RST),
	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =3D
		MTK_PMIC_KEYS_REGS(MT6357_TOPSTATUS,
		0x8, MT6357_INT_MISC_CON, 0x8, MTK_PMIC_HOMEKEY_INDEX),
    ...
};

Does this incorrectly use MTK_PMIC_HOMEKEY_INDEX instead of
MTK_PMIC_HOMEKEY_RST?

Because MTK_PMIC_HOMEKEY_INDEX is just an array index, would this result in
modifying the wrong bits in the reset register during
mtk_pmic_keys_lp_reset_setup() and failing to properly enable the long-press
hardware reset for the home key on MT6357?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612200717.3610=
18-1-l.scorcia@gmail.com?part=3D5
