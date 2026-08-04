Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D7A3B1029
	for <linux-input@vger.kernel.org>; Tue,  4 Aug 2026 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785856533; cv=none; b=N1AicY9821HZqzwzLOGIGLcMzJZsyqXlJgKMozCY3owhFO6n+GJtmUXTdHEl4TCtHZYTBluaG9lvwkeSmPYZ6Cwg/FaVtXHzD4llT6yLcXDw9y8QzkQOIF5FerUgw3/3KyM6f9Mg6/be38B8MGUpAcaFAq+FaayN7zp1G5ST9mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785856533; c=relaxed/simple;
	bh=2c8rN5AVsbgGzZ4O175/AIayNlLWwqu+cdQRxX0q1vM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RipZVXXudBj56dTFFtV9sRAcXp8BbSHxK4HAl0dU4KFrDhbyGwhwE1uTE/pdR9fP41aByXOSgmrvLWm0NiNzk8OqEyGysIen/5KxuYZBBRrXW582Y71h4eNxCWi1xIujErv/99U5x4Y1o/fDLi0wua+gYHRwegKSDYc98Y+1ad0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQTZhslC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQTZhslC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0881F000E9;
	Tue,  4 Aug 2026 15:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785856530;
	bh=q4DPEolo3b+vrWVfcWFgKwApzb+loCD6AnF/wHczHCA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aQTZhslCQv4ww2b//Zd0fUzQvPF6LNf5JeQ1foA+6PsXuTVwAgZl2Ld7lItFZbdAW
	 1aJCO0QKdza+p912C6BxF7c5PPH6CQfvK+owiN9/ETiosWGKsXgqy8VkZgyr6+yGZ0
	 8AXg3TwRwtiZLeJF2E9tT+ML/hjI9HBVSefkitRz0hJE1HRB2ZmdBBt8b6mDsRPelW
	 S/WefU1Dp5NfGCqGJ1PuEiTeQFS233ihY6eeUR0veBQNE4vWulK8l+m+bHz45ftf0W
	 wCH2VpYRQSXcJKaym8MWbm6LNBIg0sRP1GpirRCqCohvXx4Ea/xtX+E/wAqY98FT3F
	 jz91+U+gJKHTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: stmpe-keypad - disable keypad on probe failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260804141525.39388-1-mhun512@gmail.com>
References: <20260804141525.39388-1-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 15:15:29 +0000
Message-Id: <20260804151530.8D0881F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Disabling hardware before freeing managed IRQ creates a race con=
dition on probe failure.

Pre-existing issues:
- [High] Logic bug in `stmpe_keypad_altfunc_init()` aborts pull-up configur=
ation on non-zero register values and ignores errors.
- [High] Heap buffer overflow in `keymap` parsing when device tree specifie=
s dimensions exceeding 8x8.
--

--- Patch [1]: [PATCH] Input: stmpe-keypad - disable keypad on probe failur=
e ---
commit 849a668c20609a76cff8c0630950b6029798e3f9
Author: Myeonghun Pak <mhun512@gmail.com>
Subject: Input: stmpe-keypad - disable keypad on probe failure

stmpe_keypad_chip_init() enables the keypad block before programming
its registers, but does not disable it on failure. This patch routes
initialization and probe failures through a cleanup path so a failed
probe does not leave the keypad block enabled.

Fixes: 76f10845318b ("input: Add STMPE keypad driver")
Cc: stable@vger.kernel.org

> diff --git a/drivers/input/keyboard/stmpe-keypad.c b/drivers/input/keyboa=
rd/stmpe-keypad.c
> --- a/drivers/input/keyboard/stmpe-keypad.c
> +++ b/drivers/input/keyboard/stmpe-keypad.c
[ ... ]
> @@ -280,35 +280,44 @@ static int stmpe_keypad_chip_init(struct stmpe_keyp=
ad *keypad)
> =20
>  	ret =3D stmpe_keypad_altfunc_init(keypad);
>  	if (ret < 0)
> -		return ret;
> +		goto disable_keypad;
> =20

[Severity: High]
This is a pre-existing issue, but does this logic correctly handle the retu=
rn
value of the configuration function?

Looking at stmpe_keypad_altfunc_init(), it reads a register which returns a
positive value on success, but it treats any non-zero value as an error:

drivers/input/keyboard/stmpe-keypad.c:stmpe_keypad_altfunc_init() {
    ...
    ret =3D stmpe_reg_read(stmpe, pureg);
    if (ret)
        return ret;
    ...
}

This causes stmpe_keypad_altfunc_init() to return a positive value, skipping
the rest of the pull-up configuration. Because the check here in
stmpe_keypad_chip_init() only looks for (ret < 0), the positive error code =
is
silently ignored, leaving the matrix columns floating.

[ ... ]
> @@ -389,19 +398,24 @@ static int stmpe_keypad_probe(struct platform_devic=
e *pdev)
>  					  IRQF_ONESHOT, "stmpe-keypad", keypad);
>  	if (error) {
>  		dev_err(&pdev->dev, "unable to get irq: %d\n", error);
> -		return error;
> +		goto disable_keypad;
>  	}
> =20
>  	error =3D input_register_device(input);
>  	if (error) {
>  		dev_err(&pdev->dev,
>  			"unable to register input device: %d\n", error);
> -		return error;
> +		goto disable_keypad;
>  	}

[Severity: High]
This is a pre-existing issue, but could the matrix_keypad_build_keymap()
call earlier in this probe function cause a heap buffer overflow?

The keypad->keymap array is statically sized to 64 elements
(STMPE_KEYPAD_MAX_ROWS * STMPE_KEYPAD_MAX_COLS). However, the device tree
parsing does not validate that the parsed rows and cols fit within these 8x8
bounds.

If a variant like STMPE24xx supports and specifies 12 rows in the device
tree, won't matrix_keypad_build_keymap() write up to 96 elements into the
64-element keypad->keymap array?

> =20
>  	platform_set_drvdata(pdev, keypad);
> =20
>  	return 0;
> +
> +disable_keypad:
> +	stmpe_disable(stmpe, STMPE_BLOCK_KEYPAD);
> +
> +	return error;
>  }

[Severity: Medium]
Because the IRQ is managed by devres via devm_request_threaded_irq(), it
won't be freed until after the probe function returns. By manually disabling
the keypad block here, does this introduce a race condition?

If an interrupt fires before devres cleans up the IRQ, won't the interrupt
handler (stmpe_keypad_irq) execute and attempt to read from the disabled
hardware registers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804141525.3938=
8-1-mhun512@gmail.com?part=3D1
