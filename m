Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA23B3655C0
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 02:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994905; cv=none; b=PEjrXWHyJmGq19w/IzKrX7lX5YG2l9B6X4hlWRoF4SvN/48syt/WSktvDbE3bfrod2/2sLnRx4++aXTGh5pUQiKUo6sRsGdt1RWmYRN5n/DLRTlMhC5Z6GR6ER5V7vKtj9i0hBKqkZ0RFsDCZaJaQ+A1J7XjHj7EWVGfLmhwCl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994905; c=relaxed/simple;
	bh=sShaEIaC9vyP55YrP1SNzODTrsMX/jATGZguV7qxRvg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fOeNNrH3/XfU3upxc50EZ4S8HXfMzd0mbRKflpt2YbRlfcOv+2sIMgvi7ep0BItgl7NySmbfE85ho7HDAS0c92enoPZPnvTQYUjZWIZj73mWDos9lHnRwBh22EYkLVdpOV676SUORLiar90W/LOYScej6XknJyZr/vCP7MAfFKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNbQVgYD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNbQVgYD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA241F000E9;
	Tue, 14 Jul 2026 02:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783994904;
	bh=kyeNQB2nls9Xzqj8L6O2XdD5H92r/WrnkdEZR9u0q00=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TNbQVgYD5sgwy401RswMRntoAO1VixlRSnqOICej59X6FGfyqvWlHBSFvr73CsaLM
	 BxYSfXAsoqU6TiD5/8f4bAUUP4cRC/rlQw/4tR1x1YJ44Oudtej36M3ODnOUaF3LY8
	 zO0uhymYjUv3zBzvXDeh/iIDp4tZFcIJma3jNNmM8VWaZUs//7cMAyXe9RM/dNTha1
	 Lf2hs45naC9q86LLESNrozvvPix7afkaVA+LzC++lJN9rF5F3NTyPJ+stSnWhObayH
	 zrVDm0TRKhzwx+fZHi8b22XVlv4N5vMiHd+M0hlo8ysYXezce6L2daX28R7L93K9gd
	 XK6C28PmrBKpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] Input: samsung-keypad - keep interrupt disabled
 while closed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260714015309.2140694-2-dmitry.torokhov@gmail.com>
References: <20260714015309.2140694-1-dmitry.torokhov@gmail.com>
 <20260714015309.2140694-2-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 02:08:23 +0000
Message-Id: <20260714020824.7CA241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch unconditionally clears the pending hardware interrupt du=
ring system resume even when the keypad is open, discarding legitimate wake=
up key events.

Pre-existing issues:
- [High] Missing check for pm_runtime_get_sync() return value in hardware a=
ccess paths leads to clock-gated hardware access.
--

--- Patch [2]: [PATCH 2/3] Input: samsung-keypad - keep interrupt disabled =
while closed ---
commit 4f3c0f99ee50c72647a3ac611009b6d19d9c230d
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: samsung-keypad - keep interrupt disabled while closed

The driver requests the interrupt during probe, which by default enables
it. If the bootloader left the keypad interrupts enabled, or if a
spurious interrupt fires early before the driver is fully initialized
and clocks are enabled, the interrupt handler will attempt to read
registers and may cause a synchronous external abort. Fix this by
requesting the interrupt with IRQF_NO_AUTOEN, keeping it disabled during
probe.

> diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyb=
oard/samsung-keypad.c
> index a578f429d1009..88e733c1eabea 100644
> --- a/drivers/input/keyboard/samsung-keypad.c
> +++ b/drivers/input/keyboard/samsung-keypad.c
> @@ -183,6 +183,8 @@ static void samsung_keypad_start(struct samsung_keypa=
d *keypad)
>  	writel(0, keypad->base + SAMSUNG_KEYIFCOL);
> =20
>  	pm_runtime_put(&keypad->pdev->dev);

[Severity: High]
This is a pre-existing issue, but I noticed that earlier in
samsung_keypad_start() (as well as in samsung_keypad_stop() and
samsung_keypad_irq()), we seem to call pm_runtime_get_sync() without
checking its return value.

If runtime PM fails to resume the device (for example, due to a power
domain failure), the device clock remains disabled.

Could this lead to a kernel panic from a synchronous external abort when
the driver subsequently accesses hardware registers via readl() and writel()
on disabled hardware?

> +
> +	enable_irq(keypad->irq);
>  }

[ ... ]

> @@ -499,6 +496,9 @@ static void samsung_keypad_toggle_wakeup(struct samsu=
ng_keypad *keypad,
>  		val &=3D ~SAMSUNG_KEYIFCON_WAKEUPEN;
>  		writel(val, keypad->base + SAMSUNG_KEYIFCON);
>  		disable_irq_wake(keypad->irq);
> +
> +		if (keypad->stopped)
> +			writel(~0x0, keypad->base + SAMSUNG_KEYIFSTSCLR);

[Severity: High]
Does this unconditionally clear the pending hardware interrupt during system
resume, even for open devices, potentially discarding legitimate wakeup
events?

During system suspend, samsung_keypad_suspend() stops open devices, which
sets keypad->stopped =3D true:

samsung_keypad_suspend()
  if (input_device_enabled(input_dev))
    samsung_keypad_stop(keypad);

On resume, samsung_keypad_resume() calls samsung_keypad_toggle_wakeup(..., =
false)
before restarting the device:

samsung_keypad_resume()
  if (device_may_wakeup(dev))
    samsung_keypad_toggle_wakeup(keypad, false);
  if (input_device_enabled(input_dev))
    samsung_keypad_start(keypad);

Because keypad->stopped is still true here for both closed and open devices,
the if (keypad->stopped) condition evaluates to true.

Will this execute writel(~0x0, keypad->base + SAMSUNG_KEYIFSTSCLR) and
silently discard the keystroke that woke the system before the IRQ is
re-enabled by samsung_keypad_start()?

>  	}
> =20
>  	clk_disable(keypad->clk);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714015309.2140=
694-1-dmitry.torokhov@gmail.com?part=3D2
