Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4106E340286
	for <linux-input@vger.kernel.org>; Sun, 16 Aug 2026 06:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786860902; cv=none; b=Gn5SFRp4oh55ixtyqf8+V5dFG+6lMWoy8gZJuVGms8b+1jdMrKOpmxzP1pBZBRVe8qWWA7MAeufmptRFnSemXTtO1xy3lEENPH0Ub1EL91hsDYb5ZucRwxgB4oxo5sQHyphBBp1kilZLIj3PNdzNNI4MKe8j5h69FHw/aDuPi14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786860902; c=relaxed/simple;
	bh=y/QKtJxr2MNr5OX/x3uMOhzqSe9jeS45GVtHJr6FFSs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sqy6RvJ0q0eQ3lIK7MsuRvrHee/J31oQxbWsMGmRYwpScZFCXKT1p49p1bbHBFTQLwG8xce9WRrrVwjwwrCtFREVwbRUKDyB7ruQkdhiWpPtf2PRrqD3QZsuoG7GLKGXwxmT/JvtIrPdiWyRoNLOLuWlT2EyEDklx5XteYvNaNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/1mDAhq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/1mDAhq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33B81F000E9;
	Sun, 16 Aug 2026 06:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786860900;
	bh=eMWT2Z2Qfwe0uzn28pIuUPrETnYUDnSrazDZZZOweSQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H/1mDAhq4Bq5ORfx6cRmDqE788Ftii9w2I/CBYG37lCs+vfNfCSkV9Aqf3s19rtZj
	 WAX3RDoyqnx2mjvGXpYyo27RO/Q/nNe2E+3qEb0Zrz2jVkpEbfQwyRipSLkevQMBzo
	 fAWa2hJX1twyFklTOWaXNrcjXUlxHjcaK+RzaI6p6uNeBNN7+RKHHKMu0JhXeKfUlG
	 Kuk5GpdoELfgSfI90W3+N5qAIHyrJb0s0lZkW4rA+9QFEQHWys3VJq5BiBPyzidzIv
	 ES2uHKtFRYH5TaX6dBbtYyTaoPPGe2SC4jYdm1XUVaMLMB7lkXnrpT2WwcjQD+63m1
	 /YaXkdKoZbR3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/13] gpio: adp5585: use
 devm_blocking_notifier_chain_register()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eliav Farber" <farbere@amazon.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260816060648.4030-6-farbere@amazon.com>
References: <20260816060648.4030-1-farbere@amazon.com>
 <20260816060648.4030-6-farbere@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 06:14:59 +0000
Message-Id: <20260816061459.D33B81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The device-managed event notifier is registered before the gpiochi=
p is added, leading to a Use-After-Free of the IRQ domain during device tea=
rdown.
--

--- Patch [5]: [PATCH v5 05/13] gpio: adp5585: use devm_blocking_notifier_c=
hain_register() ---
commit c5fe212287473e8e21c8d2bae802d7b8fa665fcd
Author: Eliav Farber <farbere@amazon.com>

gpio: adp5585: use devm_blocking_notifier_chain_register()

This commit replaces the manual registration of a blocking notifier and
its associated devm_add_action_or_reset() cleanup with the new
devm_blocking_notifier_chain_register() helper.

> diff --git a/drivers/gpio/gpio-adp5585.c b/drivers/gpio/gpio-adp5585.c
> index 6f10fc6460080..7c04a7e86c8f8 100644
> --- a/drivers/gpio/gpio-adp5585.c
> +++ b/drivers/gpio/gpio-adp5585.c
[ ... ]
> @@ -450,13 +440,9 @@ static int adp5585_gpio_probe(struct platform_device=
 *pdev)
>  		girq->threaded =3D true;
> =20
>  		adp5585_gpio->nb.notifier_call =3D adp5585_gpio_key_event;
> -		ret =3D blocking_notifier_chain_register(&adp5585->event_notifier,
> -						       &adp5585_gpio->nb);
> -		if (ret)
> -			return ret;
> -
> -		ret =3D devm_add_action_or_reset(dev, adp5585_gpio_unreg_notifier,
> -					       adp5585_gpio);
> +		ret =3D devm_blocking_notifier_chain_register(dev,
> +							    &adp5585->event_notifier,
> +							    &adp5585_gpio->nb);

[Severity: High]
This is a pre-existing issue, but does this devres registration order
leave a use-after-free window during device unbind?

Because devm_blocking_notifier_chain_register() is called before
devm_gpiochip_add_data() (which happens later in adp5585_gpio_probe),
devres will destroy the gpiochip and its IRQ domain before unregistering
this notifier during device teardown.

If the user unbinds the adp5585-gpio child device via sysfs while the
parent device remains bound, and a hardware interrupt fires on the
parent device during this teardown window, the parent's IRQ handler
executes adp5585_gpio_key_event(). This dereferences the already freed
irq.domain pointer:

adp5585_gpio_key_event() {
	...
	irq =3D irq_find_mapping(adp5585_gpio->gpio_chip.irq.domain, off);
	...
}

>  		if (ret)
>  			return ret;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260816060648.4030=
-1-farbere@amazon.com?part=3D5
