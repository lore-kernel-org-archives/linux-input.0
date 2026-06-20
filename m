Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168D6218EBA;
	Sat, 20 Jun 2026 20:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781986609; cv=none; b=kwQFux6lmuN2nhWHjtw6sAJ+/nzIeF43FNEE/1Ce1aK0tC8RTkBQCR6x43I/XFot/81Ek9RnQ1s5Y0amyXtX3nxzSYtwnrwFXy4ZPcRwX11/FEQFBjwpA0wWQseQxAZ3Cn/qTF5xDtIfqOpLff/0zQ8Qx5oekui1TRevqhh3erc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781986609; c=relaxed/simple;
	bh=tSrfq4P3tw99qyAeeXFyx3GeUUcgDojcChvEgpZYars=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FTPZqWI5qREuUKMYD8fCCFx8nB15TEd/LoiBIWVtmK6SMv05wVTq9VYAD96eghD95n9oFhuNfg/37IdwODw6PrPyVMW/O3tkD2tRIqrfO0z4WA+ww6dkfk+x6S29ZU/FbLhM6wF1AwWaG3iUNqAnVVu2MPM3I0z6xCs1TrmHICw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7MEGcgk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7MEGcgk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CED71F00A3A;
	Sat, 20 Jun 2026 20:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781986607;
	bh=38SKgxFBawAuLPGEYHfIK/6/1xNK9+uSY+5jPR1ENMo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m7MEGcgkiiGKDEQS5mdV6K2Eyw6hYu+d55UFFbuDn1qiH3VEYNvg56/MO+hIH8Mta
	 v8cvLn3raAD7VuODqxmCbDcQrj6V55fyIQ0p2XtxmEJXgETobxjyWEjsk17FyKDvSB
	 FgDQq+P1kQTOOl4wnqqC9FDiUOt0klfO8yVKR4gDdDOkaFg0NZu/PHP+dLO7lZbskF
	 y8vDlaxutKIZMOAMQHfTnh10SYWToHxYkiqU/CCP0koJFO5gZ68Izdvvp+tqeoyPn/
	 EEdHQZx8ZDDdfVgQxaqTKzl9lbWKijuCpdv/UN/VHZ0F1CjdRdxF9reqRrl0rLdewB
	 soxcGtyTGLGHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/9] input: keyboard: mtk-pmic-keys: Add MT6392
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260620200032.334192-7-l.scorcia@gmail.com>
References: <20260620200032.334192-1-l.scorcia@gmail.com>
 <20260620200032.334192-7-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 20:16:47 +0000
Message-Id: <20260620201647.9CED71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect reset bitmask used for MT6357 home key, causing register=
 corruption.
--

commit 1b3cefe34c0ab03bf79d61642de046924d4afa84
Author: Val Packett <val@packett.cool>

input: keyboard: mtk-pmic-keys: Add MT6392 support

Add support for the MT6392 PMIC to the keys driver.

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

[Severity: High]
This is a pre-existing issue, but while reviewing these new register
configurations I noticed a copy-paste typo in the mt6357_regs struct.

In mt6357_regs, the home key reset mask is initialized like this:

    .keys_regs[MTK_PMIC_HOMEKEY_INDEX] =3D
        MTK_PMIC_KEYS_REGS(MT6357_TOPSTATUS,
                   0x8, MT6357_PSC_TOP_INT_CON0, 0xa,
                   MTK_PMIC_HOMEKEY_INDEX),

Does this incorrectly use the array index MTK_PMIC_HOMEKEY_INDEX instead of
the reset bitmask MTK_PMIC_HOMEKEY_RST?

When mtk_pmic_keys_lp_reset_setup() is called during probe for an MT6357
device, wouldn't this inadvertently modify bit 0 of the MT6357_TOP_RST_MISC
register instead of bit 5?

It looks like this might corrupt an unrelated control bit in the PMIC regis=
ter
state, while also failing to manage the long-press reset functionality for =
the
home key.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620200032.3341=
92-1-l.scorcia@gmail.com?part=3D6
