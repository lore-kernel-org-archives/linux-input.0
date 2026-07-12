Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3903A1DB;
	Sun, 12 Jul 2026 02:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783822944; cv=none; b=tWz0g/uPrU0s7WV2XnMY/pMJX46XleirdlSU016XgFMhkQ6ldp6XZLzUV2tTp0YiGxM6ObYWiDCr8bWidbrr9RuFEQnqRLepB5z9RZ66vhJlKDtWc1k7/KDAqSNhDTpkzbHUSQtCyjj3z/WBvtfadFSxHQs+jOY+IS0LaR0MAhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783822944; c=relaxed/simple;
	bh=+8oTWjHr4Dlpii67QNx3ZKcmfOMwmi+J5aYj00E8iUY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OPFM++xXOwg8Ix/OgS0taPqL/7DRDDhvYYVMBPQ85xNKLPlnWkFJIQMjiwwycNO+SDOxsfgxzvL3/rV9liJd1X/qCBh//w/OLmbhlrsL9RjEx49cVGx1CjjJhQ3uI5IzHX9LwW/T3eRSWArpWla/0GnWiNRzCMYxLvpygui3LT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIHtQCtq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIHtQCtq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6DB1F000E9;
	Sun, 12 Jul 2026 02:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783822942;
	bh=mOO7NWMe1BhhMIfVGzr/Ztj1CHJNomAQg1hb4FWNG2M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WIHtQCtqM/B/0BZV5RtpX5asrBvynhk+gmq+GL8aqnVQGrYxwIkXyBrM/z8KB1eEJ
	 hs0HspSE8CWeDhXxZWqP7STeeeov11H+u+2ZDgzXn2UzTIdMSfWZCNBapYTS8xVWdH
	 ac5TL1wYxWdb+2j1aVWTBURYGynbxFpTtT65k0Wr30Pp6iRPZjEBigT01Yde0+1qGA
	 bNwEmH08MmfOQav9ZZ0rGCZNduz1YRWeZ2XKWzF8eU2GFHKK8RJHZHXS+9IpJ6Xqf5
	 kgiJW9e8M+cTAOMt4i3CKmF3a3qGeEhNYzUClin1a9ecYZ3w9LNr/kzo7DerffO8j9
	 D8Jgdz7SoOWkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/10] Input: samsung-keypad - remove support for
 platform data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, linux-input@vger.kernel.org, robh@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260711-samsung-kp-v3-5-b2fcaba77aff@gmail.com>
References: <20260711-samsung-kp-v3-0-b2fcaba77aff@gmail.com>
 <20260711-samsung-kp-v3-5-b2fcaba77aff@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 02:22:21 +0000
Message-Id: <20260712022222.5B6DB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Premature IRQ enablement leads to unclocked hardware access and ke=
rnel panic.
--

--- Patch [5]: [PATCH v3 05/10] Input: samsung-keypad - remove support for =
platform data ---
commit 66287716c4c767b7655e9d4647ac5fd73fc2b713
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: samsung-keypad - remove support for platform data

This commit removes platform data support from the samsung-keypad driver,
as there are no remaining users in the kernel. The driver now relies entire=
ly
on generic device properties for configuration.

> diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyb=
oard/samsung-keypad.c
> index cc34f0146161e..e54b3b9f2cf2e 100644
> --- a/drivers/input/keyboard/samsung-keypad.c
> +++ b/drivers/input/keyboard/samsung-keypad.c

[ ... ]

> @@ -424,7 +388,11 @@ static int samsung_keypad_probe(struct platform_devi=
ce *pdev)
>  		return error;
>  	}
> =20
> -	device_init_wakeup(&pdev->dev, pdata->wakeup);
> +	wakeup =3D device_property_read_bool(dev, "wakeup-source") ||
> +		 /* legacy name */
> +		 device_property_read_bool(dev, "linux,input-wakeup");
> +	device_init_wakeup(&pdev->dev, wakeup);
> +
>  	platform_set_drvdata(pdev, keypad);
> =20
>  	error =3D devm_pm_runtime_enable(&pdev->dev);

[Severity: High]
This is a pre-existing issue, but I noticed that the IRQ is requested
and unmasked before runtime PM is enabled.

In samsung_keypad_probe(), devm_request_threaded_irq() is called just before
this point without IRQF_NO_AUTOEN. If a pending interrupt is left by the
bootloader or a spurious interrupt occurs, it will fire immediately.

When samsung_keypad_irq() executes, it calls pm_runtime_get_sync() (which
skips enabling the clock because keypad->stopped is true at probe time) and
then accesses hardware registers:

drivers/input/keyboard/samsung-keypad.c:samsung_keypad_irq() {
    ...
    do {
        readl(keypad->base + SAMSUNG_KEYIFSTSCLR);
    ...
}

Can this unconditional access to unclocked peripheral registers trigger a
synchronous external abort and result in a kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711-samsung-kp=
-v3-0-b2fcaba77aff@gmail.com?part=3D5
