Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11BE4AA1CA;
	Wed,  2 Sep 2026 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788381468; cv=none; b=ckPxZehV3JLb/wnEDLdYF5RlxkIWmsaNAED1j85f1dJMRLRT1FlV86gp1ayuTIiAU6PD6aKhSRIbqk4MX7QxWMPj4gTpE1sYhtHUIU6SRk4dyzazUY/ZVu5LCqdLj6UEHKSZNRhasgqgrTb6z0s9mmNS71WetWHAYApdDesNQFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788381468; c=relaxed/simple;
	bh=Owt70xUXDhwuMdSXJ+xFM783KX41nmpIrz72os0JRe0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EaV2yfvpIQ8yrz4/40IXn8mpPzVFCuwizV/OO89+cSFxzOzTI+nvb3MrqMbg7Dvl9EfSj/2/Bmklbj0Yw3+pfYAfd5/wSy5fEqbIWQk7i9fk4y4SPYQ3DMgcuPjTh7HwVYUr/KWTxPUeZwREyc2O0PfYIpkL74fObsOwptOU9Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DipGL7JN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DipGL7JN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05A21F00A3E;
	Wed,  2 Sep 2026 20:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788381466;
	bh=iMoEO0xdj7+ah6tVSa9vIzmVF9zurQDc9q99sX/Pet0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DipGL7JNjxbtujnEHAytlnbC2ySornpNcml4NSkXavDQAqZXiyZv3NlwN+D593q93
	 zxnI16wBpHIlDevLDdkwMwhk7VBjFLY84VK0Vs+UB+rBAeaUCnhzuZSDgDMN5T1LsB
	 Du0zKJLPp8wDpW654VhKEdZO7A7wfYY6JnoplOvPzLX1T1BF1F7hED9jbTRP+Qlhtd
	 Y3i9M1J+c99wIZm15jbaqyw9wekiHykj47tPnnAuw3t40j1RM/hoYLZBUEyfEB8En6
	 K7EQ/gH5CQAczkLTmXdYjblPRCgAQu/gpByPv8TXZCXXFJvQcZHj4FrPilth98U6cJ
	 xRb74AwLN1BxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 6/9] input: keyboard: mtk-pmic-keys: Add MT6392
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: conor+dt@kernel.org, mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-input@vger.kernel.org, robh@kernel.org, dmitry.torokhov@gmail.com, lee@kernel.org
In-Reply-To: <20260902193351.185771-7-l.scorcia@gmail.com>
References: <20260902193351.185771-1-l.scorcia@gmail.com>
 <20260902193351.185771-7-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 20:37:45 +0000
Message-Id: <20260902203745.F05A21F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Array out-of-bounds read and write due to mismatched DT child node=
 counting and iteration.
- [High] Incorrect macro MTK_PMIC_HOMEKEY_INDEX used for homekey reset mask=
 in mt6357_regs configuration.
--

commit 93a2f6ac06eb96960eb8f140af657b42448c3d24
Author: Val Packett <val@packett.cool>

input: keyboard: mtk-pmic-keys: Add MT6392 support

Add support for the MT6392 PMIC to the keys driver.

> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keybo=
ard/mtk-pmic-keys.c
> index c78d9f6d97c4f..d758c7743f6a1 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c

[ ... ]

While reviewing this patch, I noticed two pre-existing issues in the same
file.

In mt6357_regs:

> 		MTK_PMIC_KEYS_REGS(MT6357_TOPSTATUS,
> 				   0x8, MT6357_PSC_TOP_INT_CON0, 0xa,
> 				   MTK_PMIC_HOMEKEY_INDEX),

[Severity: High]
This is a pre-existing issue, but does this incorrectly use
MTK_PMIC_HOMEKEY_INDEX instead of the intended reset mask
MTK_PMIC_HOMEKEY_RST?

If MTK_PMIC_HOMEKEY_INDEX is used, it expands to 1 instead of the correct
bitmask. This causes mtk_pmic_keys_lp_reset_setup() to clear the wrong bit
in the MT6357_TOP_RST_MISC register and fail to configure the home key's
reset mask.


In mtk_pmic_keys_probe():

> 	keycount =3D of_get_available_child_count(node);
> 	if (keycount > MTK_PMIC_MAX_KEY_COUNT ||
> 	    keycount > ARRAY_SIZE(irqnames)) {
> 		dev_err(keys->dev, "too many keys defined (%d)\n", keycount);
> 		return -EINVAL;
> 	}
>=20
> 	for_each_child_of_node_scoped(node, child) {
> 		keys->keys[index].regs =3D &mtk_pmic_regs->keys_regs[index];
>=20
> 		keys->keys[index].irq =3D
> 			platform_get_irq_byname(pdev, irqnames[index]);

[Severity: High]
This is a pre-existing issue, but can this lead to an out-of-bounds array
access if disabled nodes are present in the device tree?

The bounds check counts available children using
of_get_available_child_count(). However, the loop uses
for_each_child_of_node_scoped(), which iterates over all child nodes
regardless of their status.

If a device tree contains three or more child nodes, but some are disabled
such that the available count is 2 or fewer, the bounds check passes. The
loop then processes all nodes, causing the index variable to exceed
MTK_PMIC_MAX_KEY_COUNT and corrupt memory.

Could we change the loop to use for_each_available_child_of_node_scoped()
to match the bounds check?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902193351.1857=
71-1-l.scorcia@gmail.com?part=3D6
