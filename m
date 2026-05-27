Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A8B1940B0
	for <linux-input@vger.kernel.org>; Wed, 27 May 2026 23:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779923113; cv=none; b=F2m0S40+cenCWYX+6AkwTDTQ/eogWn15/gQnbY1mOlhWHPjdTZKgrD6hVXJsaw5oCOSCcLJafq5huczQp+x/dlqA3K9+mNL4PxVLwoJvCTz6nxmAbywCwVjBg+b98EByk95u2ihFFAmmk7ZLd3A322JxiIIMcilYzQpiihSGCPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779923113; c=relaxed/simple;
	bh=LjsXnKXsCKviHx7unQIAaYiAg1piafdV5ERXVhvz9YY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lFWB+mbVWLV4dzc7AEpZfntKIwkj9pSCg2IRgPWQiai/nVS6/AS/RM0/4301uBvcecLD5b1v6Bceqc5K+Htm2Xw1+24LacFRIj5sXrAUBBlqKgIjdCCz4hqY7F44HwwMccYyysi/0V5ejjFWWrBbMO0DHRsOrG6DBO1A0KOHmAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPyReScQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPyReScQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08341F00ADE;
	Wed, 27 May 2026 23:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779923112;
	bh=cHW37gmnH9MYwREYetqRvvkmToIvJCCgjavl1EQOQAE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NPyReScQMVgNwHCFDaljPKg53Fnays1cUCexgzPmy9wbQUG7eJqxSXb0ewiwTMT7P
	 AjsvDi7oN/DOhn0EPYAG20jvYKA5kRdgGs5NvtNNVNhSBFbrXueLm7vnpVJUqp+eia
	 vLM3OFIG4YlhT3xvGxP6k/2eleljeV323G+gioSld86Kt6GUQV/EodmnYRBOFVIdkq
	 OWC34CFRnI5XwXC82+wpDn+4oC5Jz5W/ei4GdimOrh+ghkL0D2qzj9j0P3VtGog+W3
	 /3nBjFFxAkb8/sBV5v6CnMPcCvoOk7ibygsbx7WQufYMNYlaYKqdm0kGQqwOVtf/J0
	 8VL4xFGDK5tlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: mtk-pmic-keys: Use flexible array member for
 keys
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260527223849.25139-1-rosenp@gmail.com>
References: <20260527223849.25139-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 23:05:11 +0000
Message-Id: <20260527230511.E08341F00ADE@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Removal of `platform_set_drvdata()` causes a NULL pointer derefere=
nce in power management callbacks.
- [High] Suspend and resume operations unconditionally iterate beyond the d=
ynamically allocated bounds of the `keys` flexible array.
- [High] Switching to `for_each_available_child_of_node_scoped()` shifts po=
sitional indexing, assigning incorrect hardware resources if a preceding no=
de is disabled.
--

commit d074164f8f2f21067dd0369cfcc1618c2f1c3553
Author: Rosen Penev <rosenp@gmail.com>

Input: mtk-pmic-keys: Use flexible array member for keys

Convert the fixed-size keys array to a flexible array member and allocate it
based on the available child node count. The patch also modifies the child
iteration to skip disabled nodes and drops the driver data assignment since=
 it
was mistakenly thought to be unused.

> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keybo=
ard/mtk-pmic-keys.c
> index c78d9f6d97c4f..5b8650f461050 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
[ ... ]
> @@ -332,17 +331,25 @@ static int mtk_pmic_keys_probe(struct platform_devi=
ce *pdev)
>  	static const char *const irqnames_r[] =3D { "powerkey_r", "homekey_r" };
>  	struct mtk_pmic_keys *keys;
>  	const struct mtk_pmic_regs *mtk_pmic_regs;
> +	struct mtk_pmic_keys_info *key;
>  	struct input_dev *input_dev;
> -	const struct of_device_id *of_id =3D
> -		of_match_device(of_mtk_pmic_keys_match_tbl, &pdev->dev);
> =20
> -	keys =3D devm_kzalloc(&pdev->dev, sizeof(*keys), GFP_KERNEL);
> +	keycount =3D of_get_available_child_count(node);
> +	if (keycount > MTK_PMIC_MAX_KEY_COUNT ||
> +	    keycount > ARRAY_SIZE(irqnames)) {
> +		dev_err(&pdev->dev, "too many keys defined (%d)\n", keycount);
> +		return -EINVAL;
> +	}
> +
> +	keys =3D devm_kzalloc(&pdev->dev, struct_size(keys, keys, keycount), GF=
P_KERNEL);

[Severity: High]
Does this dynamic allocation create an out-of-bounds access in the suspend
and resume callbacks?

The PM callbacks retain a hardcoded loop using MTK_PMIC_MAX_KEY_COUNT:

mtk_pmic_keys_suspend() {
    ...
	for (index =3D 0; index < MTK_PMIC_MAX_KEY_COUNT; index++) {
		if (keys->keys[index].wakeup) {
    ...
}

If keycount is less than MTK_PMIC_MAX_KEY_COUNT (for example, if only one k=
ey
is available), won't the loop read out of bounds by accessing unallocated
memory in the flexible array?

>  	if (!keys)
>  		return -ENOMEM;
[ ... ]
> @@ -356,31 +363,21 @@ static int mtk_pmic_keys_probe(struct platform_devi=
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

[Severity: High]
Does switching to for_each_available_child_of_node_scoped() assign incorrect
hardware resources if a preceding node is disabled?

The driver relies on positional indexing to map DT child nodes to specific
hardware registers and IRQs. For example:

	static const char *const irqnames[] =3D { "powerkey", "homekey" };
    ...
		key->irq =3D platform_get_irq_byname(pdev, irqnames[index]);

By skipping disabled nodes with the available child variant, if the first
node (powerkey) is disabled in the device tree, the second node (homekey)
will be processed at index 0. Won't this incorrectly assign the powerkey IRQ
and registers to the homekey node?

> +		key =3D &keys->keys[index];
> +		key->regs =3D &mtk_pmic_regs->keys_regs[index];
> =20
> -	for_each_child_of_node_scoped(node, child) {
> -		keys->keys[index].regs =3D &mtk_pmic_regs->keys_regs[index];
[ ... ]
> @@ -407,8 +404,6 @@ static int mtk_pmic_keys_probe(struct platform_device=
 *pdev)
> =20
>  	mtk_pmic_keys_lp_reset_setup(keys, mtk_pmic_regs);
> =20
> -	platform_set_drvdata(pdev, keys);
> -

[Severity: High]
Does removing this platform_set_drvdata() cause a NULL pointer dereference
during suspend and resume?

The power management callbacks mtk_pmic_keys_suspend() and
mtk_pmic_keys_resume() rely on dev_get_drvdata(dev) to retrieve the keys
pointer:

mtk_pmic_keys_suspend() {
	struct mtk_pmic_keys *keys =3D dev_get_drvdata(dev);
	int index;

	for (index =3D 0; index < MTK_PMIC_MAX_KEY_COUNT; index++) {
		if (keys->keys[index].wakeup) {
        ...
}

Because the driver data is no longer set, won't dev_get_drvdata() return NU=
LL
and crash when accessing keys->keys[index].wakeup?

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527223849.2513=
9-1-rosenp@gmail.com?part=3D1
