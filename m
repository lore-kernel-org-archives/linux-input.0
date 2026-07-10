Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7AB3B8BD8;
	Fri, 10 Jul 2026 21:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783719177; cv=none; b=eOdBfUV//FNPNXwA7KbSOqYAaDH949J8pJxs1Ob3X34yFNVjF3oOBC8Xj8a6+2iwN8PZPjL7C8jYHoJlRv0hd8bcmEal/+WDTFZ+9ZBIrwIW3yyUE91rZGD+8i4k6cJ3XX5WXltumSIN3qJpyXCTJywMtNPTflDqIid1AjVOnyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783719177; c=relaxed/simple;
	bh=uU/LNt6tG7KZlKzNKNhws78cpOpbpgueRCo9q4qP1lA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MA8GzcorI1HRm00AbIBe502jIVw2mE5z4eDqYodOselAekJf/JtGPQ+gTQw52puuaPVFkpxe7P+vPhSHt601cJaSXmLeHMb3d6esgUg0iuhcneKGiZS734xJUZne00OGI1QPk1cmoEAsXyD6dlqC5UHpl908OPnHdsOgQ3qIDzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AA97LZwk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AA97LZwk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F2E1F000E9;
	Fri, 10 Jul 2026 21:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783719176;
	bh=FUJsyXP8f/qUNOyxH2UTHgoKM5yjztNPJcoBaebCXXM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AA97LZwkg18YcHu2zxir2JySg6lTfBmfxMnaKkb68jmnGG9WAEzXdoGhSnXktsR00
	 rMi3km27QKXZ5mqeyEWCMYbcxm78dhzQrenl16hCdAQM7QUc06M9aWvbVVSim6ZInj
	 BV5qEvGNRUXhY8nbs/5dRpczNSqgeO05xAriPGRLUYFcZpKydo4o5eJiRnYFnBGmOb
	 cdnEZm1XW+pPa9ihk2Mol8BxiAIqh9Vmfjg3YfQfaDpKLiV4AbYY8/lkCmVHdnxh5v
	 d2nWEy6A5JVgNt3hO7S4e44cpHSRYdp9iF2mXWQaYPZ7zUlFF3RkwCm7+h02BsBG5q
	 rM1IbKnaFn5uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] [v6] leds: gpio: make legacy gpiolib interface
 optional
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-leds@vger.kernel.org, linux-input@vger.kernel.org, lee@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260710211854.1371746-4-arnd@kernel.org>
References: <20260710211854.1371746-1-arnd@kernel.org>
 <20260710211854.1371746-4-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 21:32:55 +0000
Message-Id: <20260710213256.05F2E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Disabling CONFIG_GPIOLIB_LEGACY breaks compilation for unrelated no=
n-legacy drivers that set `struct gpio_led::active_low`.
- [Low] The commit message description is not capitalized, violating the LE=
D subsystem guidelines.
--

--- Patch [3]: [PATCH 3/6] [v6] leds: gpio: make legacy gpiolib interface o=
ptional ---
commit ad55bf4fa40ddbff55ee69fcb15b56da1f063668
Author: Arnd Bergmann <arnd@arndb.de>

> leds: gpio: make legacy gpiolib interface optional

[Severity: Low]
This isn't a bug, but should the commit description be capitalized after the
subsystem prefix to match the LED subsystem guidelines? For example,=20
"leds: gpio: Make legacy..."

This commit makes the legacy GPIO library interface optional in the leds-gp=
io
driver by guarding the platform_data handling with CONFIG_GPIOLIB_LEGACY.

Link: https://lore.kernel.org/all/e9252384-a55c-4a91-9c61-06e05a0b2ce4@app.=
fastmail.com/

[ ... ]

> diff --git a/include/linux/leds.h b/include/linux/leds.h
> index b16b803cc1ac5..e646bffcd8e74 100644
> --- a/include/linux/leds.h
> +++ b/include/linux/leds.h
> @@ -676,8 +676,10 @@ typedef int (*gpio_blink_set_t)(struct gpio_desc *de=
sc, int state,
>  struct gpio_led {
>  	const char *name;
>  	const char *default_trigger;
> +#ifdef CONFIG_GPIOLIB_LEGACY
>  	unsigned 	gpio;
>  	unsigned	active_low : 1;
> +#endif

[Severity: Low]
Does hiding active_low behind CONFIG_GPIOLIB_LEGACY break the build for
unrelated non-legacy drivers (such as ath10k) that still rely on setting th=
is
field in struct gpio_led?

>  	unsigned	retain_state_suspended : 1;
>  	unsigned	panic_indicator : 1;
>  	unsigned	default_state : 2;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710211854.1371=
746-1-arnd@kernel.org?part=3D3
