Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389604457A4;
	Thu, 20 Aug 2026 12:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787229817; cv=none; b=CmY52b9UR4ZwNLK6sfgpF1+/y4f/0Mwx1w+0ROfCTq5omfil2tOBntwz2s+B8iaqwr2fKihNM6fgHgjzk/rxeFf6B2Vm1+VEug9Fmsz1S7cnWiQA4WBJBd2AUaydjwPGIrKGXSfXSkhzmv6NV9qxdNa7lusSMlpLlwEWmTmA3BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787229817; c=relaxed/simple;
	bh=3O/S7ny/JZbxTurdks1hBR1zmRU5dxN8MiX/mbagccc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eJrSmAMiEW5/fpA7xjS9wpuPu3Tu0jym++6prpAiG++oeqqMBXAgVlbujbgFDPNp0YlYz0jBhf/6QhS9iIAHRVaIWfhFN4kSEneXsddnoH9USEpQUs3osjT7dBgpPLBFc5tdD0+vghScPIYc2B748GnprSzAOAh/aVHJ40upJTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1OkUsUr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1OkUsUr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B0D1F000E9;
	Thu, 20 Aug 2026 12:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787229815;
	bh=L2TBVFsUMUGcQqDcsBpW3KDv075jK57mgpHJPZ36+CY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F1OkUsUrWggqi0zA1YuMwRdCEN5HBPY8xTr/ItXoCUIl7Vtu7Myvcs4iegXIM0jRP
	 7x7o3PyZ/mOqkVgXuwS78/Iu6LxCQxh1PC5BtcFthEBGyWXxZt78W9hX7S7smiHC1S
	 U5RlLkFhc1g+70RBX1XyYRBArGJQ1IzLMBsgQHzcmm7+luJCQcds0hgvZmTvP5Zdtf
	 y7ICU9fXbwrcHwNGV5LY/snhQ/JSSDcaPpYx2bHOV0B1uZgB+SKwB6aoNoaXUjQwiK
	 +qoYjzDSSPC9Rqk2y++jf8LeBIdVzyK9AmlEetRp6yX1th18AiEaaFpeduNx+bNgkU
	 qyKjAtAHYMSdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 6/9] input: keyboard: mtk-pmic-keys: Add MT6392
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: conor+dt@kernel.org, lee@kernel.org, mfd@lists.linux.dev, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260820122242.120039-7-l.scorcia@gmail.com>
References: <20260820122242.120039-1-l.scorcia@gmail.com>
 <20260820122242.120039-7-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 12:43:34 +0000
Message-Id: <20260820124335.41B0D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Mismatch between bounds checking and child node iteration causes o=
ut-of-bounds array accesses if disabled child nodes are present.
- [High] Physical keys mapped to incorrect hardware resources and IRQs due =
to strict dependency on DT node parsing order.
--

--- Patch [6]: [PATCH v9 6/9] input: keyboard: mtk-pmic-keys: Add MT6392 su=
pport ---
commit 7d4906573abcc4f44ff8cbf94c0c7919e5484f08
Author: Val Packett <val@packett.cool>

input: keyboard: mtk-pmic-keys: Add MT6392 support

This commit adds support for the MT6392 PMIC to the keys driver.

> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keybo=
ard/mtk-pmic-keys.c
> index c78d9f6d97c4f..8b4a89fce4fb1 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
[ ... ]
> @@ -301,6 +315,9 @@ static const struct of_device_id of_mtk_pmic_keys_mat=
ch_tbl[] =3D {
>  	{
>  		.compatible =3D "mediatek,mt6397-keys",
>  		.data =3D &mt6397_regs,
> +	}, {
> +		.compatible =3D "mediatek,mt6392-keys",
> +		.data =3D &mt6392_regs,

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential
out-of-bounds array access in mtk_pmic_keys_probe() when handling these key=
s.

The probe function limits the maximum number of keys by checking the count =
of
available nodes:

	keycount =3D of_get_available_child_count(node);
	if (keycount > MTK_PMIC_MAX_KEY_COUNT ||
	    keycount > ARRAY_SIZE(irqnames)) {
		dev_err(keys->dev, "too many keys defined (%d)\n", keycount);
		return -EINVAL;
	}

However, it then iterates over all child nodes, including disabled ones:

	for_each_child_of_node_scoped(node, child) {
		keys->keys[index].regs =3D &mtk_pmic_regs->keys_regs[index];

		keys->keys[index].irq =3D
			platform_get_irq_byname(pdev, irqnames[index]);

If a device tree defines disabled child nodes alongside available ones, such
that the available count passes the check but the total child count exceeds
MTK_PMIC_MAX_KEY_COUNT, could this loop iterate past the bounds of keys->ke=
ys[]
and irqnames[]?


[Severity: High]
This is also a pre-existing issue, but does this mapping logic safely corre=
late
device tree nodes to the correct physical hardware?

The driver maps the nodes based entirely on their iteration order (index)
rather than checking the node names:

	for_each_child_of_node_scoped(node, child) {
		keys->keys[index].regs =3D &mtk_pmic_regs->keys_regs[index];

Since index 0 is unconditionally treated as the power key and index 1 as the
home key, what happens if a device tree omits the power key and only defines
a home key? Will the home key node be improperly mapped to the power key
hardware resources and IRQs?

>  	}, {
>  		.compatible =3D "mediatek,mt6323-keys",
>  		.data =3D &mt6323_regs,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820122242.1200=
39-1-l.scorcia@gmail.com?part=3D6
