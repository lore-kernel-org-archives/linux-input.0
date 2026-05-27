Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B13303CAE
	for <linux-input@vger.kernel.org>; Wed, 27 May 2026 01:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779844553; cv=none; b=kQu95L+rxwj9E8+ADezfg48yWB5ZU9EjIwNGiaYm/5/LuBc2Cn7BiwNNqebzknvxzU2VCDIeyFpKtOehfQqSLCRWdfAY8EiXyfppLBXuTBbI/I05ZGnFNjcfRanfqkFGQCLDGxoE+udmCfgX/SWfQEAwj3O+OHpvGUZg888XYY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779844553; c=relaxed/simple;
	bh=oHJOh30l2VyuiBv9AnUTKu7Y+afe86zrB0VupBeQ8JE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kbJtmquz9mtIrwGdZpJ9BiIAchrw8QnBJqvUAkfy1fG/shccuPp315T3jvOCT2S9lk+WtqmOJ58jEEZ5hRmz9MORJmRY6OPUhumdhl/ZV9HUNnJziCV2IZVJY/yxX4SKGPUW1QOy5AvetFx3isGoPrF9Tx5DCYa9MMtygyp4cX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asTEqrDz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asTEqrDz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F67F1F000E9;
	Wed, 27 May 2026 01:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779844550;
	bh=7m2XRBzEW893L0c+bVyOU8W1pBpGJJu/91m577SGMJM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=asTEqrDzSy8B0Ckpw7s4icnN4zv7NjfL6+/warQwZoO698pA57JOfKWribo+Ks7nt
	 iyzvXmQfGmnnuXu189Mjhv8ARDxyK1ilxg7bcko0+u1oMW8V2Wle2aiJ+zjour5ner
	 ++b2w7eimQ07UYa12JZqolEM3u3AH6l6p3364EEaMQPnXoXmW3inATCfxCHrOUa9ov
	 7LM77xqHAFi0HtvkfE7P+/QyqVr8zY5jZpqL2kDWx422RCzFF8ikjiCg2j5fCFVWal
	 6YyBR2A1ADfEFWvB2rbwG44VqA+eqIaTbBhHF95bkCnJDopyzNCuHEIHiMoLrZ+f8L
	 TX81OUiWJkiUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: mtk-pmic-keys - match loop with count
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260527004543.22875-1-rosenp@gmail.com>
References: <20260527004543.22875-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 01:15:50 +0000
Message-Id: <20260527011550.6F67F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Switching to `for_each_available_child_of_node_scoped` shifts the =
hardware mapping index if a preceding node is disabled, leading to incorrec=
t physical key configuration.
--

commit 999599e1545f7dcb987f1a3ede455f57f6a980e6
Author: Rosen Penev <rosenp@gmail.com>

Input: mtk-pmic-keys - match loop with count

This commit changes the child node iteration in mtk_pmic_keys_probe() to
only iterate over available child nodes, preventing an out-of-bounds array
access if a disabled node exists alongside available ones.

> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keybo=
ard/mtk-pmic-keys.c
> index c78d9f6d97c4f..5d4ebbafd2765 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> @@ -363,7 +363,7 @@ static int mtk_pmic_keys_probe(struct platform_device=
 *pdev)
>  		return -EINVAL;
>  	}
> =20
> -	for_each_child_of_node_scoped(node, child) {
> +	for_each_available_child_of_node_scoped(node, child) {

[Severity: High]
Does this change in iteration cause a regression with the positional mapping
of keys to hardware?

The driver maps device tree child nodes to physical key hardware (IRQ and
registers) based strictly on the loop iteration index (index =3D 0 for
powerkey, index =3D 1 for homekey).

Before this patch, for_each_child_of_node_scoped() iterated over all defined
child nodes, ensuring that positional mapping was maintained even if the fi=
rst
node (e.g., powerkey) had status =3D "disabled".

By changing the iterator to for_each_available_child_of_node_scoped(),
disabled nodes are now skipped. If the powerkey node is disabled in the
device tree, it is skipped, and the homekey node becomes the first available
child. It is then processed with index =3D 0.

Consequently, the driver would configure the powerkey hardware registers
and request the powerkey IRQ, but bind them to the properties
(like linux,keycodes) of the homekey node.

Could this result in the physical powerkey incorrectly emitting the homekey=
's
code, while the physical homekey remains uninitialized?

>  		keys->keys[index].regs =3D &mtk_pmic_regs->keys_regs[index];
> =20
>  		keys->keys[index].irq =3D

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527004543.2287=
5-1-rosenp@gmail.com?part=3D1
