Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BBF2D0C62
	for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 10:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785061676; cv=none; b=exznYjsRmSo3aQkp0L4pY3woRJdoKAFR6H9/E16bovAj2ZQvMYg5PRM0YL0PMcOJ7EStT9bY9wuQKd/FmalzGSOoifXWK9c6eOQ1BkTLCUUUfNOdBSMiw2MN1LS0U/Z2GQYXR9P3wOA4TCY4wj7uSNlGbkGZUSuhG9TPbVksOiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785061676; c=relaxed/simple;
	bh=hpxNz0ulQAUL8xPdKaE03lR3/tlojSwz3Nz4R+mK60U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=czqecYibDNlaA6spw5nmdhRRDAqN7JCs+Zr6WjfYze5UCOMHW1tDVOSgLDKdYOeG4ZCylOdLxGxgmL2gfiea80TOy7v6KB0PBvIjkKtlPlho6c/SUG9V5hFjWkoudA4uz6A9+xavhF3xE+l6SjWJ9SNwZu0aowFr+BGseWPXpAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTpBNfQA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTpBNfQA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B172C1F000E9;
	Sun, 26 Jul 2026 10:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785061673;
	bh=2EIE8eYzTjXwsxWatBirTw4P8i6qmZ8rdoJGbfxKE9M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XTpBNfQAV0eD7PUGZzsLE2fPwZu52akleVidLoKxh4turtaKhC7OePvW3Bn8TeO/q
	 lAfWxezwZ7m/UAD4qnq5ABBi9m+wGN1l9zmkY3sjsJf/jjErFS2bLSnCHwGaecQCHO
	 wLdhCd/ZtVY/Pjq808ipKRvZNWB0xjz2IdXf22PXopgzYzm2GuwMYdlERb0pbCHG08
	 r+0elQspO9w2zEmPrnZ67xYC5+b3Jvgf/9v5W3/R1CQ2QcCCcg751ehAoivqMNvOMF
	 yNkZ6eyhN36IHDdG/6pXzCzl91ehZtRLlBpb/qD+Ua0TCewOuy+MNf7F3VYPMjE4Xj
	 Zi2OMqZ/rBvrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/13] gpio: adp5585: use
 devm_blocking_notifier_chain_register()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eliav Farber" <farbere@amazon.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260726101739.33170-6-farbere@amazon.com>
References: <20260726101739.33170-1-farbere@amazon.com>
 <20260726101739.33170-6-farbere@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 10:27:53 +0000
Message-Id: <20260726102753.B172C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-after-free of the gpiochip's IRQ domain during device unbindin=
g due to incorrect devres registration order.
--

--- Patch [5]: [PATCH v4 05/13] gpio: adp5585: use devm_blocking_notifier_c=
hain_register() ---
commit 44c510dbb3ca8a6273606da82607128231bd2e31
Author: Eliav Farber <farbere@amazon.com>

gpio: adp5585: use devm_blocking_notifier_chain_register()

This commit replaces the manual blocking_notifier_chain_register() and
devm_add_action_or_reset() pattern with a single call to
devm_blocking_notifier_chain_register(), dropping the standalone
unregister callback.

> diff --git a/drivers/gpio/gpio-adp5585.c b/drivers/gpio/gpio-adp5585.c
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
This is a pre-existing issue, but does this devres registration order create
a use-after-free during device unbind?

Because the notifier is registered before the GPIO chip is added via
devm_gpiochip_add_data() later in adp5585_gpio_probe(), devres will process
the teardown in LIFO order. This means the GPIO chip and its IRQ domain are
removed and freed first.

If an interrupt fires after the GPIO chip is removed but before the notifier
is unregistered, the notifier callback adp5585_gpio_key_event() will attempt
to access the freed domain:

drivers/gpio/gpio-adp5585.c:adp5585_gpio_key_event() {
    ...
	irq =3D irq_find_mapping(adp5585_gpio->gpio_chip.irq.domain, off);
	if (!irq)
		return NOTIFY_BAD;
    ...
}

Should the notifier registration be moved after devm_gpiochip_add_data() to
ensure a safe teardown sequence?

>  		if (ret)
>  			return ret;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726101739.3317=
0-1-farbere@amazon.com?part=3D5
