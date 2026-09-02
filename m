Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ABB3A9DB6;
	Wed,  2 Sep 2026 19:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788378658; cv=none; b=i2fmdBuLU9mzEXspXs61bdu4S9qXEBrM0e9r8ObPVqQexGN8PrWq6PP81BrvxiQB16HZS46FiIJFSiTsR5Dp5nRCKPZ6dJsfGwz0SClx4VXPhHaPHxIUYPL+XADzUMgBubwrx7UsygDTMcksPa2s88HTjetJJyu2H1fEke1wYb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788378658; c=relaxed/simple;
	bh=j4++eVBY2Iq68WbxkPsFW6V3u/uPt4aF19hRfPsid2o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bnbkoam4dM7EDWZMfDLeWAWhqH4ogoR/iLrvDAF4RoGULQ33UjBZqNzvVLyIVdiYwUhqAOm6LM/+WkdF4ndl8tV6+GYAzhzSuzi/3Raat+1dKMfgO6sTSnJZ5E7wqHdJr8984mjI7xW8bxUOC3XmVeFXVT9To5F3bHualS65j5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJqRrzsF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJqRrzsF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0471F000E9;
	Wed,  2 Sep 2026 19:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788378654;
	bh=5jWRd+ua0Tn8wvnDcx4BwfrLhSvCvFan1Py5Kj94oFc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gJqRrzsFDGTt06XEw/J089ayYDoxaflSbjnh5P45r5tiGRxHuzgSgdEwRuBfq2104
	 nK5wHVKl09QC6e9tNYtdmhi7vDHApnKIM3bXEMsekV+g4GFAubOaDrglKZ5UJHE96J
	 VjOSatvGBV/pxwea0XmI1om6pIQHPsX5s40VVQw9UddvFYza90307501BOGZ2f0vfy
	 EkJgBYCaDRgcZPVU7PKrLN9XOO8/YtqyBKGoZlCYBfPXcMbCN/tYJ+Yc6YtZRrUusf
	 WnFZcR1LJEHy3N3P4YJHqN5APYK9zPcjKExvPYD8cIqO+DDleo2iqkZTDDtF0Xzl6F
	 MYKdBSHg6nHXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/9] dt-bindings: input: mtk-pmic-keys: Add MT6392
 PMIC keys
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: linux-input@vger.kernel.org, mfd@lists.linux.dev, conor+dt@kernel.org, robh@kernel.org, lee@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260902193351.185771-3-l.scorcia@gmail.com>
References: <20260902193351.185771-1-l.scorcia@gmail.com>
 <20260902193351.185771-3-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 19:50:53 +0000
Message-Id: <20260902195053.AC0471F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Driver blindly assumes DT child node ordering corresponds to speci=
fic physical keys (Power vs Home).
--

commit 60da1299ae1ca5678f1be4e16da6d490bbacc023
Author: Fabien Parent <parent.f@gmail.com>
dt-bindings: input: mtk-pmic-keys: Add MT6392 PMIC keys

This commit adds the binding documentation for the MT6392 PMIC keys to the
mediatek,pmic-keys device tree binding schema.

> diff --git a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.y=
aml b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
> index 140a862ecfbeb..ff720588128be 100644
> --- a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
> +++ b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
> @@ -31,6 +31,7 @@ properties:
>            - mediatek,mt6357-keys
>            - mediatek,mt6358-keys
>            - mediatek,mt6359-keys
> +          - mediatek,mt6392-keys
>            - mediatek,mt6397-keys

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the bindings
for these PMIC keys, I noticed a pre-existing issue in the corresponding
driver implementation that consumes these device tree nodes.

Does the driver blindly assume device tree child node ordering corresponds =
to
specific physical keys?

Looking at mtk_pmic_keys_probe() in drivers/input/keyboard/mtk-pmic-keys.c:

	for_each_child_of_node_scoped(node, child) {
		keys->keys[index].regs =3D &mtk_pmic_regs->keys_regs[index];

		keys->keys[index].irq =3D
			platform_get_irq_byname(pdev, irqnames[index]);
        ...

Because for_each_child_of_node_scoped() yields child nodes in an undefined
order, could this sequential assignment swap the physical Power and Home ke=
ys
(index 0 vs index 1) if a device tree author defines the home node before t=
he
power node, or if an external bootloader/overlay reorders them?

Since the device tree is a strict ABI, relying on undefined node ordering
might lead to functionally broken hardware (such as the physical power butt=
on
acting as the home button). Would it make sense to explicitly check the chi=
ld
node name or use a specific property to identify which node corresponds to
which key instead of relying on the iteration index?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902193351.1857=
71-1-l.scorcia@gmail.com?part=3D2
