Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9822A3016F7
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 05:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784008301; cv=none; b=Cwjj1gCioaLp7TClnd2+RUI0y6EwcANDROuoO8FGDKt6yKY5ndmra5J0vXqs6sbXv7Ea9UxQLgdvo9o/uE+R+wHCapduP101eygnyVaDNSKaYfpPek5RvFR1ju2ogszykBW1fua67A7jGS3TQMy9/8e5gDDED0ei+1ns2G7HUP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784008301; c=relaxed/simple;
	bh=3XFCbLtWMqGawLpM5ct0kquZydKRx6wuEhR+tHz8eRk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GoIbDAq6x5YPX9NARDiwGQNcCNB9qxW5WL72vVfsuIwS/WfQzx6MTG7N3bSpTZ901ZlcCN2zn3iL4ZJtHfyidubaK5AYcD0ehH+TB4cYt3jx6tQqGK8n4onhJc5o7pEYzkUfbLQvNuiGb1gtzFjocPiYwaB3r8cqj2/+0fPeAB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQpJjYEf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQpJjYEf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020041F000E9;
	Tue, 14 Jul 2026 05:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784008300;
	bh=SrZ1H49Pxi7IV8yGhd2gLoZo5DZEbp1O4gRHk5Uqv8c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iQpJjYEf/2PvqDXVG8S2WcFZiHRPOD8yj9i/yiqbC1aQWgjpGrzhTCWXzAcYwb7rk
	 omjS2Zf5fi2/Oc7HJ5HPgOOAQSk7UcWoR+4v1JKhu417VogQfJaoj0Y1DLFzz0U7q6
	 iF6JlJRCQrMITDpfGt9sypslIOxXEfLfqbSUeyxlYK/cIXn5EwYfCykcd9vhDXTzmC
	 xEpwwf320vjwE7ZHTYAEz2/szmHNqXJL3Bt8cqgcvuj74YIE49HdHIYWvY0O5LhZQX
	 t/+y53BtKhIwGPVHgqY+acjG57opLue91LEn35eeILEazC2RuDYDWPqYUOYOgUEu+R
	 2xBGYVtOCjf1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] Input: samsung-keypad - clean up wakeup
 configuration logic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260713-samsung-kp-irq-v2-1-acc84b6daf9a@gmail.com>
References: <20260713-samsung-kp-irq-v2-0-acc84b6daf9a@gmail.com>
 <20260713-samsung-kp-irq-v2-1-acc84b6daf9a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 05:51:39 +0000
Message-Id: <20260714055140.020041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The threaded IRQ handler accesses memory-mapped registers without =
ensuring the peripheral clock is enabled if a wakeup interrupt fires while =
the device is closed, leading to a kernel crash.
--

--- Patch [1]: [PATCH v2 1/3] Input: samsung-keypad - clean up wakeup confi=
guration logic ---
commit c263408953e10fb025a3702953499e150bde4016
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: samsung-keypad - clean up wakeup configuration logic
   =20
This commit refactors the wakeup configuration logic in the samsung-keypad
driver. It moves the device_may_wakeup check to the caller and adjusts the
ordering of register writes and interrupt configuration.

> diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyb=
oard/samsung-keypad.c
> index 17127269e3f05..a578f429d1009 100644
> --- a/drivers/input/keyboard/samsung-keypad.c
> +++ b/drivers/input/keyboard/samsung-keypad.c

[ ... ]

> @@ -516,7 +515,8 @@ static int samsung_keypad_suspend(struct device *dev)
>  	if (input_device_enabled(input_dev))
>  		samsung_keypad_stop(keypad);
> =20
> -	samsung_keypad_toggle_wakeup(keypad, true);
> +	if (device_may_wakeup(dev))
> +		samsung_keypad_toggle_wakeup(keypad, true);
> =20
>  	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but could a wakeup interrupt firing while the
device is closed cause an unclocked register access and crash the system?

If the device is closed by all users, samsung_keypad_stop() sets
keypad->stopped to true. When the system suspends, the code above enables
wakeup if device_may_wakeup() returns true.

If a key press triggers a wakeup interrupt, upon resume the primary IRQ
handler schedules the threaded handler samsung_keypad_irq():

drivers/input/keyboard/samsung-keypad.c:samsung_keypad_irq() {
	...
	pm_runtime_get_sync(&keypad->pdev->dev);

	do {
		readl(keypad->base + SAMSUNG_KEYIFSTSCLR);
	...
}

However, pm_runtime_get_sync() calls samsung_keypad_runtime_resume(), which
skips enabling the clock because keypad->stopped is true:

drivers/input/keyboard/samsung-keypad.c:samsung_keypad_runtime_resume() {
	...
	if (keypad->stopped)
		return 0;

	clk_enable(keypad->clk);
	...
}

Will the subsequent readl() in samsung_keypad_irq() trigger a synchronous
external abort since the peripheral clock was never enabled?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-samsung-kp=
-irq-v2-0-acc84b6daf9a@gmail.com?part=3D1
