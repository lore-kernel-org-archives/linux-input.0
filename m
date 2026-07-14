Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878A835957
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 02:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994934; cv=none; b=q2d4DoCILJS+waYeLoul6sxgm/O9LyPIb/aMyYBTq5EN3mTK3kgsVIMEOsbKGsKLHIEP3gygfbZmpkCgx5Jmv0Gyfr1nkCWGuq4PSI+sWHtN1joAmZ1UyDfCVPhyu37F8suEF2G+Nw18H9c53KBmjIZasaHnJtw4MKS2UHAP2Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994934; c=relaxed/simple;
	bh=cL1EYY3xkS8fUsFysqjW1bMcBwdWWzAFX3oaF4QCH4o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FGdiUGMqGEFNOc3b4Kf3tCOwhpeuUn/Ge86Vsoe1WhkcQhfRB+9Hi1Lkq/+3P164TF+E/Wx5CCRnumEnhyzwsBb1sHk+SKhfs8t9/uo1OK7J5QWSOVQWchrTTQuy8RPEJiiOT110mvqilUDBNFvGE8YgD/cBC/986AzmMaP8QTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRJ9lW4y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRJ9lW4y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F661F000E9;
	Tue, 14 Jul 2026 02:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783994933;
	bh=ASaALTei0fbOUQE8Tj/DSl5e/lx4me/EgMOuq0isJ/Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QRJ9lW4yaAwj82aQ/OunZGZkk/Pw/oTIWeevSMaZz9WFTkPoF4b9okoWdvmEmjxuL
	 qcNbSdGuhZlthFuoi/zQ+QBXHAX9NxrvcM/lk19z4CXiOQQc6hokKoHpYvGmbT2cDk
	 swGwhaO+nlWmrKcmbP+y+9l5rGKt9LJ0uvvue+BOPrDkZkisjq7zxCb+okPB0TOx6t
	 qOeKugZy98VCAQ+75nwIGaqbPw/P2CDextOnzOC8vTlXks+eF2albIhfLBjcyTw1jh
	 I1Yp2KOcIl4FeAmKKpcQu3z5i7kMVODJYDoem0he2nDWcIo0usJVAibe/fvcMgeia8
	 ZtXZ7dfz6CREA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] Input: samsung-keypad - use pm_runtime_active guard
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260714015309.2140694-3-dmitry.torokhov@gmail.com>
References: <20260714015309.2140694-1-dmitry.torokhov@gmail.com>
 <20260714015309.2140694-3-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 02:08:52 +0000
Message-Id: <20260714020853.00F661F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing Error Handling for pm_runtime_get_sync() implicitly called=
 by guard(pm_runtime_active)
--

--- Patch [3]: [PATCH 3/3] Input: samsung-keypad - use pm_runtime_active gu=
ard ---
commit dabb4cc7edb73abb241db678d97750949e93ef10
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

    Input: samsung-keypad - use pm_runtime_active guard
   =20
    Simplify the driver by using the block-scope guard(pm_runtime_active)
    instead of manually invoking pm_runtime_get_sync() and
    pm_runtime_put().

> diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyb=
oard/samsung-keypad.c
> index 88e733c1eabea..5f6535b49761c 100644
> --- a/drivers/input/keyboard/samsung-keypad.c
> +++ b/drivers/input/keyboard/samsung-keypad.c
> @@ -142,7 +142,7 @@ static irqreturn_t samsung_keypad_irq(int irq, void *=
dev_id)
>  	unsigned int row_state[SAMSUNG_MAX_COLS];
>  	bool key_down;
> =20
> -	pm_runtime_get_sync(&keypad->pdev->dev);
> +	guard(pm_runtime_active)(&keypad->pdev->dev);
> =20
>  	do {
>  		readl(keypad->base + SAMSUNG_KEYIFSTSCLR);

[Severity: High]
This isn't a bug introduced by this patch, but does ignoring the return val=
ue
of the implicit pm_runtime_get_sync() call here leave the hardware access
vulnerable to crashes?

If resuming the device fails (e.g., due to a clock or regulator error), the
driver proceeds to access memory-mapped registers like SAMSUNG_KEYIFSTSCLR.
Reading or writing these registers while the power domain is unpowered can
trigger a Data Abort (kernel panic) on ARM.

[ ... ]

> @@ -167,7 +165,7 @@ static void samsung_keypad_start(struct samsung_keypa=
d *keypad)
>  {
>  	unsigned int val;
> =20
> -	pm_runtime_get_sync(&keypad->pdev->dev);
> +	guard(pm_runtime_active)(&keypad->pdev->dev);
> =20
>  	/* Tell IRQ thread that it may poll the device. */
>  	keypad->stopped =3D false;
> @@ -182,8 +180,6 @@ static void samsung_keypad_start(struct samsung_keypa=
d *keypad)
>  	/* KEYIFCOL reg clear. */
>  	writel(0, keypad->base + SAMSUNG_KEYIFCOL);

[Severity: High]
This is a pre-existing issue, but this function is reachable via userspace
opening the input device. If the resume fails, could the subsequent hardware
accesses like writel() to SAMSUNG_KEYIFCOL trigger a crash for the same
reason?

[ ... ]

> @@ -191,7 +187,7 @@ static void samsung_keypad_stop(struct samsung_keypad=
 *keypad)
>  {
>  	unsigned int val;
> =20
> -	pm_runtime_get_sync(&keypad->pdev->dev);
> +	guard(pm_runtime_active)(&keypad->pdev->dev);
> =20
>  	/* Signal IRQ thread to stop polling and disable the handler. */
>  	keypad->stopped =3D true;
> @@ -207,8 +203,6 @@ static void samsung_keypad_stop(struct samsung_keypad=
 *keypad)
>  	writel(val, keypad->base + SAMSUNG_KEYIFCON);
> =20
>  	clk_disable(keypad->clk);
> -
> -	pm_runtime_put(&keypad->pdev->dev);
>  }

[Severity: High]
This is also a pre-existing issue, but does this face the same risk when
writing to SAMSUNG_KEYIFCON if the device failed to wake?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714015309.2140=
694-1-dmitry.torokhov@gmail.com?part=3D3
