Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1042A3090CD
	for <linux-input@vger.kernel.org>; Fri, 29 May 2026 00:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780014578; cv=none; b=LJGSONmLee7hmOmPI+0L9hJAU8RXS1Megrcsht0dJTUGHMOwO/K0WnyxVp+NWjNC7/LXnTvWjueoKdubfzkEtNi+WPjPeV59pGA1Yman6PoaSi6C3nxb2ay90WV7rbwFkkFK0pW2oKeOIHa7kh+hPmIZuv3qz/eIEIAqXOS8M5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780014578; c=relaxed/simple;
	bh=th9qRnXfgzUjgswjRMqhWSofabJpvU77NoC7ul6yNvE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CdwcZel2q7kZD1RhdrwI0Gqf8taGQ640n6P3R/AqK+B1Kh+TOGujyF/629+AjobLPaKynSpNaA6W+ZGTW2bSDRagL+cySUmVDs0H5yprkjI2BG5WM7aqM6VpBGXhduZGlw27T9tz6+1y6mUnaxVtgOcZMLXas5QaW9Wu8VHjyU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIZr3iZO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIZr3iZO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728F11F000E9;
	Fri, 29 May 2026 00:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780014576;
	bh=CI3BWuKD2FgvXp0LNDaXFBnvqtXkzjHnNTM7kzvu4lg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OIZr3iZOujFrgeOR6CPO1E9ptldp0Ud4Sb/uSq1riA4nvfpU9wl1T/nKpROV8GJ2W
	 kq+onUSkOqesf5j9Oy5Q2mtpYoR6gD+chUVaXJ1C4RghXa1zpVKfIiV4T1HwaT6QW0
	 FWf3OBxlUWwnyV3yIqDfsldKiykDjGC6cpjzz3Y9ccTqkaLwnlXDlpdxVquBiJRasv
	 B9o2Z1EtJMAuozFXSZo79WiDyN/71xPG1BAoWK+GYYMXNHxrMWVJHsiNMXHxcu53eB
	 Ap1Ac5hbYU0WqjkJR9tpdDND+O7TKsaoRs8zxkPxhPuskITQ8Lkkz5u+Wqn8+FDKFC
	 F/T4YzItWEVOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: mtk-pmic-keys: Count available keys during probe
 instead of pre-counting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260528235600.312045-1-rosenp@gmail.com>
References: <20260528235600.312045-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 00:29:36 +0000
Message-Id: <20260529002936.728F11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Skipping unavailable device tree child nodes shifts the loop index=
, breaking the implicit hardware mapping and incorrectly assigning register=
s and IRQs.
--

commit ddd98727b5f1967e1232c34c0d42b4d0d314c947
Author: Rosen Penev <rosenp@gmail.com>

Input: mtk-pmic-keys: Count available keys during probe instead of pre-coun=
ting

This commit replaces the separate pre-count of available keys with a
single pass using for_each_available_child_of_node_scoped(). It skips
unavailable nodes and bails out if the key count exceeds the maximum.
The match data lookup is also updated to use of_device_get_match_data().

> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keybo=
ard/mtk-pmic-keys.c
> index c78d9f6d97c4f..e34856693ee2c 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
[ ... ]
> @@ -356,31 +355,26 @@ static int mtk_pmic_keys_probe(struct platform_devi=
ce *pdev)
>  	input_dev->id.product =3D 0x0001;
>  	input_dev->id.version =3D 0x0001;
> =20
> -	keycount =3D of_get_available_child_count(node);
> -	if (keycount > MTK_PMIC_MAX_KEY_COUNT ||
> -	    keycount > ARRAY_SIZE(irqnames)) {
> -		dev_err(keys->dev, "too many keys defined (%d)\n", keycount);
> -		return -EINVAL;
> -	}
> +	for_each_available_child_of_node_scoped(node, child) {
> +		if (index >=3D MTK_PMIC_MAX_KEY_COUNT) {
> +			dev_err(&pdev->dev, "too many keys defined\n");
> +			return -EINVAL;
> +		}
> =20
> -	for_each_child_of_node_scoped(node, child) {
> -		keys->keys[index].regs =3D &mtk_pmic_regs->keys_regs[index];
> +		key =3D &keys->keys[index];
> +		key->regs =3D &mtk_pmic_regs->keys_regs[index];
> =20
> -		keys->keys[index].irq =3D
> -			platform_get_irq_byname(pdev, irqnames[index]);
> -		if (keys->keys[index].irq < 0)
> -			return keys->keys[index].irq;
> +		key->irq =3D platform_get_irq_byname(pdev, irqnames[index]);

[Severity: High]
Does switching to for_each_available_child_of_node_scoped() break the
strict index mapping for hardware registers and IRQs?

The original code iterated over all child nodes, preserving the device tree
order index (e.g., index 0 for powerkey, index 1 for homekey).

If a device tree has a disabled node first, skipping it will shift the index
for subsequent available nodes. For example, if the powerkey node is
disabled, the homekey node would be processed with index 0 instead of 1,
causing it to be incorrectly assigned the hardware IRQ and registers of the
powerkey.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528235600.3120=
45-1-rosenp@gmail.com?part=3D1
