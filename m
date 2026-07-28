Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A6540B109
	for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 21:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785274314; cv=none; b=DwcHPih/j0Dm2a0ANUKhyWlsQzUh/s+p3SjLD0yfAScC/eH014I3HcZt8q+PS2bnEP1LKn01edKR0PfWx7f98DDtHaDUQik3iqg5ze+QQCRzWmcnUds7W28Bdn4Ou8krptJLUuGPce9aDclzGTsX+DEb84zFMWw5R7R0i2+9eW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785274314; c=relaxed/simple;
	bh=+izbRbkpsEhywclegHwlmFD58IdV3ukFsFctXB6Hxzw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W8iCukPELO0Khnz63D7aiK/iLjSyto8B71jQCJ9N0gXQ5xal03G5KW9cYcbsBIZcdfXkFAE2fv4z78Ur2s5kwUONOz001yeFoDD8sZ3e6R+FsFR/JsylFFrNkx1jGs5tMvWvRnYS4lnbpg+6SGow9t2R80q+uf7gxf6oWd6hpWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QECXN7QT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QECXN7QT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5B21F00A3A;
	Tue, 28 Jul 2026 21:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785274312;
	bh=CWiwlUBdDISvXO39jRxXMgyTCGMVn52zsV8tCen3lrY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QECXN7QTHv0od0N2xZkLeh36yXclXUs7kIz5UhGLhuyP1wI/23HgnNqmg8h2q+Yqk
	 l/+4jecyW6y+HJ8VSXuzJSydTVSolzL3C/PU7QhUIXg3KMo+AgbhbRF6pmTOHon7ks
	 w5ydfYM9G60ew8FhMe25t4pHwapNa4tqCM0GPCOf5Oe33ZzFJKnuowsdXXD/UZgkgX
	 9X9iOzDlnHVMnEXndVDKcLl86OEATivkU1ZZ2YoISISWsUcgIgljnNQJrJPKZO1rCc
	 dh7DwVMDajQf2lO8SbblBTOzEgafSgG4C9fJQkKdXUl3GO+Xyok+Vh4zxcHr2CKZof
	 5+fvPpUx0d5bA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 1/2] Input: mtk-pmic-keys: use
 of_device_get_match_data()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260728212438.54078-2-rosenp@gmail.com>
References: <20260728212438.54078-1-rosenp@gmail.com>
 <20260728212438.54078-2-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 21:31:51 +0000
Message-Id: <20260728213152.5D5B21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Mismatch between counting available child nodes and iterating over=
 all child nodes leads to an out-of-bounds array access.
--

--- Patch [1]: [PATCHv2 1/2] Input: mtk-pmic-keys: use of_device_get_match_=
data() ---
commit 8b3f8694df03175d2fcd1e69a487343b4d70d629
Author: Rosen Penev <rosenp@gmail.com>

Input: mtk-pmic-keys: use of_device_get_match_data()

This commit replaces open-coded match data retrieval with
of_device_get_match_data() and removes the of_device.h include.

> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keybo=
ard/mtk-pmic-keys.c
> index c78d9f6d97c4f..fd684ac169386 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
[ ... ]
> @@ -333,8 +332,6 @@ static int mtk_pmic_keys_probe(struct platform_device=
 *pdev)
>  	struct mtk_pmic_keys *keys;
>  	const struct mtk_pmic_regs *mtk_pmic_regs;
>  	struct input_dev *input_dev;
> -	const struct of_device_id *of_id =3D
> -		of_match_device(of_mtk_pmic_keys_match_tbl, &pdev->dev);
> =20
>  	keys =3D devm_kzalloc(&pdev->dev, sizeof(*keys), GFP_KERNEL);
>  	if (!keys)
> @@ -342,7 +339,7 @@ static int mtk_pmic_keys_probe(struct platform_device=
 *pdev)
> =20
>  	keys->dev =3D &pdev->dev;
>  	keys->regmap =3D pmic_chip->regmap;
> -	mtk_pmic_regs =3D of_id->data;
> +	mtk_pmic_regs =3D of_device_get_match_data(&pdev->dev);
> =20
>  	keys->input_dev =3D input_dev =3D devm_input_allocate_device(keys->dev);

[Severity: High]
This is a pre-existing issue, but while reviewing mtk_pmic_keys_probe(),
I noticed a potential out-of-bounds array access further down in the
function.

The function correctly limits the expected number of keys by checking
the count of available child nodes:

drivers/input/keyboard/mtk-pmic-keys.c:mtk_pmic_keys_probe() {
    ...
    keycount =3D of_get_available_child_count(node);
    if (keycount > MTK_PMIC_MAX_KEY_COUNT ||
        keycount > ARRAY_SIZE(irqnames)) {
            dev_err(keys->dev, "too many keys defined (%d)\n", keycount);
            return -EINVAL;
    }
    ...
}

However, it then iterates over all child nodes, not just the available ones:

drivers/input/keyboard/mtk-pmic-keys.c:mtk_pmic_keys_probe() {
    ...
    for_each_child_of_node_scoped(node, child) {
        keys->keys[index].regs =3D &mtk_pmic_regs->keys_regs[index];
        keys->keys[index].irq =3D
            platform_get_irq_byname(pdev, irqnames[index]);
    ...
}

If a device tree provides more child nodes than MTK_PMIC_MAX_KEY_COUNT
but only a subset are marked as available (for example, with
status =3D "okay"), the bounds check will pass. Because the loop iterates o=
ver
all child nodes regardless of their availability status, could index exceed
the array limits?

Would it be safer to use for_each_available_child_of_node_scoped() here to
ensure the loop matches the earlier available child count check and prevents
an out-of-bounds read on irqnames[] and write to keys->keys[]?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728212438.5407=
8-2-rosenp@gmail.com?part=3D1
