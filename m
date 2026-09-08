Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFC13E6DEB
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 21:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788904466; cv=none; b=e5U9WF8xR5s4uekuIiHgWgOlqyv1GcocNuDDAcswf1ccA2zjJhLqvOL9lkOMgt5kIMSwSy07fqxgoOZufMCCek1S888boU5w69xbejbjIzr1TQNgS2ZpPfc2Jddw8+irQyla04z76NaYrfJThb20FN6gU9mqD5iT0+ZoLewmb3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788904466; c=relaxed/simple;
	bh=oYjXez9q4BgnM/OBlS8UUntdhK01CZAuW9gqpM6M5/w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JwlMVg8MR6RZcUW4pfv3Yf4RU/Rbg9KoTdkwM1LOQF8R10gBLuZ9RUKlWVhwGcyb2BwLQudiff0NluR4yewchZ6XA5tmZY5HKlnFZjkm7iP0RT1YauuiCRkt3FyL2HF4rorJ4FopOQBPspm9IudkEPUQF+Im99ht3ebp3whtHsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjRNLyNN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjRNLyNN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBB81F00A3D;
	Tue,  8 Sep 2026 21:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788904465;
	bh=HBi9GfOamkuiks9RDhGuMcET6LO8hwZPoFo6zTmT2Ow=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XjRNLyNNuvNVSRUfOY4pvPjvqbfISVZmE4PwoOz0Mg7ZXwJpBkESXAU2sv4iroQBc
	 TGzZ8jTtwGpI1iQesZ4OyjRWPOYQNfyR7nD3RVg1g1Rjhx6kgoMOvHHey/rqn+2/Bp
	 nQNRkgFLrW7Ae0PLG4uNfqmU9H4sBxt/jr5FcAxpOVK9xwQfqfCXw/kIbdTk5io0O1
	 2V98souNFT9KBoryeKt0FwtlD5ymWAzCyz11a9FuccCejZqYTZr7qW2J+F8YwTQAay
	 i1VVbJpR7Whs5RPc3reQaiuC6JwNyEfX89y/nxyC7kxD843dYTVFnABC/AbKJCJH23
	 cPotlAoE10YVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: soc_button_array - fix MS Surface Pro 11 probe
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans de Goede" <johannes.goede@oss.qualcomm.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260908214410.70422-1-johannes.goede@oss.qualcomm.com>
References: <20260908214410.70422-1-johannes.goede@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 21:54:24 +0000
Message-Id: <20260908215424.CFBB81F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Failure to propagate -EPROBE_DEFER when gpiod_to_irq() defers pr=
obe.
- [Low] Redundant #ifdef wrapping and misplaced #include directive in the m=
iddle of a .c file.
--

commit 96cf5f0eb3e99312a52ef035fbd723de02a88be5
Author: Hans de Goede <johannes.goede@oss.qualcomm.com>

Input: soc_button_array - fix MS Surface Pro 11 probe failure

This patch modifies error handling in soc_button_array to propagate=20
-EPROBE_DEFER on non-BYT/CHT platforms. This resolves a probe race with the=
=20
GPIO driver on the MS Surface Pro 11.

Closes: https://lore.kernel.org/lkml/20260830141355.55898-1-lsa.uz@pm.me/

> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/s=
oc_button_array.c
> index b8cad415c62ca..6ed32c622d530 100644
> --- a/drivers/input/misc/soc_button_array.c
> +++ b/drivers/input/misc/soc_button_array.c
> @@ -149,6 +149,16 @@ static int soc_button_lookup_gpio(struct device *dev=
, int acpi_index,
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_X86
> +#include <linux/platform_data/x86/soc.h>
> +static bool soc_intel_is_byt_or_cht(void)
> +{
> +	return soc_intel_is_byt() || soc_intel_is_cht();
> +}
> +#else
> +static bool soc_intel_is_byt_or_cht(void) { return false; }
> +#endif

[Severity: Low]
This isn't a bug, but is this #ifdef CONFIG_X86 block and mid-file include
necessary?

The <linux/platform_data/x86/soc.h> header already contains
#if IS_ENABLED(CONFIG_X86) internally and provides fallback stubs for other
architectures, so the wrapping appears redundant. Placing #include directiv=
es
in the middle of a .c file is also generally discouraged.

[ ... ]

> @@ -201,6 +212,9 @@ soc_button_device_create(struct platform_device *pdev,
>  			 * we do not have a driver for these so they will never
>  			 * show up, therefore we ignore -EPROBE_DEFER.
>  			 */
> +			if (error =3D=3D -EPROBE_DEFER && !soc_intel_is_byt_or_cht())
> +				goto err_free_mem;
> +

[Severity: Medium]
Does this check properly handle a deferred probe from the irqchip?

When soc_button_lookup_gpio() is called, gpiod_get_index() might succeed
(leaving error =3D 0), but gpiod_to_irq() can return -EPROBE_DEFER if the
irqchip is not yet initialized.

In this scenario, irq will be -517 (-EPROBE_DEFER), but error remains 0.
Since this condition only checks if error =3D=3D -EPROBE_DEFER, the check
evaluates to false, the code falls through to continue, and the button
is silently skipped instead of propagating the deferral as intended.

>  			continue;
>  		}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908214410.7042=
2-1-johannes.goede@oss.qualcomm.com?part=3D1
