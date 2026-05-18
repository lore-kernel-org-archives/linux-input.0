Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E655D382296
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 04:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779078851; cv=none; b=IoRUwWeM+LIcOK1M8tx+etJTVAQWQpWK2gLGMf6Is9eVJq41pSy9xVdiIJxnN+nZYwL6uE22bI3OcrUUNSly4Fx87MW2a8fbHkK3LwpyMQ0wluXdWwOYG+LJBwhJFMnJGUBXK2iBaKRxvs3sEjF6l88oTIE/9vKmCjYHJY6yGfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779078851; c=relaxed/simple;
	bh=CR+mOzC/oxHVQFk4Oa/lwRewxf5pVdf/+YY91S1D7ic=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FddJfCAyXgh5QRId4Ip2ia+6GxTZOkFs5zLY2SyLT4Cqnw+0jwEjjnkxyTJ6I05EWtSoP1XIj4nwvP67UQdKTlVLGIIw7PURDoxuEv+G/dbGKrjup+zfR8BiG14+WvUHCCf1/hCSUF3Z8lFYvsD+Hq5wkiqra01CqrmjUS08+qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxDKefih; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxDKefih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC97EC2BCB7;
	Mon, 18 May 2026 04:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779078850;
	bh=CR+mOzC/oxHVQFk4Oa/lwRewxf5pVdf/+YY91S1D7ic=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nxDKefih+5almxFOnFADQVdros+uRVpVOfCvW8WFgELlsVF6BA1WMoFvCmoaoYqjn
	 LryyuP0td1zQfcDfXVCYs5xBahBHqTjPKnj5fI41TDs1mt1nQ/7+GqPFObw3xJBPRT
	 bddnlq6qp6rNuzPZoVyis5X6aVq/sYDrMM8aSiGHqV/vUtaDcP5SDCEGZGLRIVPNxZ
	 A1cMoAB3IvYy+UPf0/PPyAEUwF3gGy/7CZNy6BAkdFQrGdsIwYVr3fB7cWU+oMtsRQ
	 UsxcUJWgXx9fXgAqct4bV2v9aefVrBJMk/bVjPrCKJlUGA6uFvjn8oKr9zokdq290z
	 SkZ1ZFgcBt0Sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: mtk-pmic-keys - use of_device_get_match_data()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260518042046.981861-1-rosenp@gmail.com>
References: <20260518042046.981861-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 04:34:09 +0000
Message-Id: <20260518043409.EC97EC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing NULL check for of_device_get_match_data() result leads to =
NULL pointer dereference.
- [High] Mismatch between child counting and iteration logic can cause out-=
of-bounds array accesses.
--

commit 0ee3fee49ccf02b7e629f90533e67fc9b40d2b9e
Author: Rosen Penev <rosenp@gmail.com>

Input: mtk-pmic-keys - use of_device_get_match_data()

This commit simplifies the driver to fetch PMIC key register data directly
using of_device_get_match_data(). It also removes the unneeded of_device.h
include.

> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keybo=
ard/mtk-pmic-keys.c
> index c78d9f6d97c4f..fd684ac169386 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
[ ... ]
> @@ -342,7 +339,7 @@ static int mtk_pmic_keys_probe(struct platform_device=
 *pdev)
> =20
>  	keys->dev =3D &pdev->dev;
>  	keys->regmap =3D pmic_chip->regmap;
> -	mtk_pmic_regs =3D of_id->data;
> +	mtk_pmic_regs =3D of_device_get_match_data(&pdev->dev);

While this isn't a new issue introduced by this patch, can mtk_pmic_regs be
NULL here if the device is bound manually via sysfs without a matching
device tree node?

If mtk_pmic_regs is NULL, it appears it is unconditionally dereferenced
later when calling mtk_pmic_keys_lp_reset_setup().

Would it make sense to add a check for !mtk_pmic_regs right after fetching
the match data?


Also, while reviewing this probe function, I noticed another pre-existing
issue further down:

	keycount =3D of_get_available_child_count(node);
	if (keycount > MTK_PMIC_MAX_KEY_COUNT ||
	    keycount > ARRAY_SIZE(irqnames)) {
		dev_err(keys->dev, "too many keys defined (%d)\n", keycount);
		return -EINVAL;
	}

	for_each_child_of_node_scoped(node, child) {
		keys->keys[index].regs =3D &mtk_pmic_regs->keys_regs[index];

Is there a mismatch between the child counting and iteration logic?

The validation check uses of_get_available_child_count(), which ignores
disabled nodes. But the loop uses for_each_child_of_node_scoped(), which
iterates over all children, including disabled ones.

If a disabled child node exists in the device tree alongside available ones,
could the loop execute more times than the initial validation accounted for?
This might increment the index variable past the allocated array bounds,
leading to out-of-bounds accesses on irqnames[] and keys->keys[].

Would updating the loop to use for_each_available_child_of_node_scoped()
prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518042046.9818=
61-1-rosenp@gmail.com?part=3D1
