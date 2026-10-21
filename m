Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792548000;
	b=WMdOkIWMPOZvRL9IAN1/84X4kj3ZoqjUOof4tZurlTobvFywirWcf0911e9FT2Fbnz8C
	 iU1A0PPh8A60e14YajaXJvqv7HTygB8V2Ak+ooLnFYiBAj0nGSAOa5t1YgO+UU0atO8EI
	 aKcppqpgwrD6/wyaNYh1nFdwXmCg6dmCNpNYO1MjDBdPi5nr6YgZuLP4CYYljq3VZF33D
	 EwL9HhbTrCwtpDzvA/azGOtZNtD4gWKX/AKe/vPoFJdh9ikXlrtOOala/rJRXU5pHj/aY
	 CQzPtHnqg4pakqsZPOohADNoeUXYjNUpgTUXzOKZ+gAaOFnBjruJncGRzZfJCZ/3b3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792548000;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yoGGo77ZNLX3gLb2D4s2EfUeQWCYXc/yhjQDqKkwKpM=;
	b=ezaVrdEBrC0qXJy816W0XsOUDVVjtNgaSUbMV413MyRVy8yr5SnHVxKTDPLepd5Mbvxn
	 EcUJZPB+kQL5WVFb5brwyfrxO83Nnff0cW0c6UHyQJHgGnIYaebQbGiTsHOou3NP+dj93
	 2IjLolchoDnqwEG09EyFDuJI+aGWveWr5laress68I82FXH35I0zHMjjs2gVXjaiWxzoV
	 tGYEj/Hhk8Dp+MFsfXTnc64Om3VI3NNqn4Joprta7Lh0JXglsRyeEqyK+rTvWtLygMW7D
	 cFKaQ03Sj/a5uXFbaJPaQ4kdS6jDXbBAPkS3BGcgottP3UR8IoxgCxnFhrGXaPd2U/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J9jZXjfK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBED606A31C;
	Wed, 21 Oct 2026 02:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J9jZXjfK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AB81F000C9;
	Wed, 21 Oct 2026 01:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792548000;
	bh=yoGGo77ZNLX3gLb2D4s2EfUeQWCYXc/yhjQDqKkwKpM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J9jZXjfK7Wk34ipzzng1U04k8qPwSYJ3S23Mi4P+YDyaYZ/bNpPiyaNI+hscw1G+L
	 RhlKEZsdieTztS2UuHF0Nf8Ke9Paeh+M44buE16Gvb25lBa1ng/AtYhU+1tOsADSp1
	 YSqL1VBjjua4FaJk3steqA77jlOatabMIeltOLOpDuaZqtjQJflkoR+GQYYB89dNzh
	 hgNG1WXSSqR5arI7OW0YgLrI1x02n+bUdRirGeKnTpuyVe7/1btC475xWauSyAZLIZ
	 emuaYVdTwVdEXS2BbELaa4S/jZgHRdPpO5Hu9zoCnlxyDci5it4PJ+GtwtfBkvYNjP
	 J6wAl2HEWzQdw==
Message-ID: <sashiko-outbox-179674@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] Input: soc_button_array - use resources to set up
 IRQ info for gpio-keys
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-gpio@vger.kernel.org
In-Reply-To: <20261021015004.1537738-1-dmitry.torokhov@gmail.com>
References: <20261021015004.1537738-1-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 01:59:59 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Input: mix of __free() and goto cleanup in soc_button_device_create=
()
--

commit 135ab963100f947c993746f76110c2ca70438cec
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: soc_button_array - use resources to set up IRQ info for gpio-keys

This commit switches soc_button_device_create() to pass IRQ information to
the gpio-keys platform device via platform device IRQ resources instead of
platform data, in preparation for converting the driver to static device
properties.

> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/s=
oc_button_array.c
> index dbf86ea778e67..d4dc4e7116a7d 100644
> --- a/drivers/input/misc/soc_button_array.c
> +++ b/drivers/input/misc/soc_button_array.c
[ ... ]
> @@ -167,6 +173,15 @@ soc_button_device_create(struct platform_device *pde=
v,
>  		if (info->autorepeat =3D=3D autorepeat)
>  			n_buttons++;
> =20
> +	struct resource *irq_resources __free(kfree) =3D NULL;
> +	/* See dmi_use_low_level_irq[] comment */
> +	if (!autorepeat && (use_low_level_irq ||
> +			    dmi_check_system(dmi_use_low_level_irq))) {
> +		irq_resources =3D kzalloc_objs(*irq_resources, n_buttons);
> +		if (!irq_resources)
> +			return ERR_PTR(-ENOMEM);
> +	}
> +

[Severity: Low]
In drivers/input/misc/soc_button_array.c, soc_button_device_create()
introduces irq_resources with __free(kfree) while still using goto-based
cleanup via err_free_mem to free gpio_keys_pdata on later failure paths:

drivers/input/misc/soc_button_array.c:soc_button_device_create() {
	...
	if (n_buttons =3D=3D 0) {
		error =3D -ENODEV;
		goto err_free_mem;
	}
	...
	pd =3D platform_device_register_full(&pdevinfo);
	error =3D PTR_ERR_OR_ZERO(pd);
	if (error) {
		dev_err(&pdev->dev,
			"failed registering gpio-keys: %d\n", error);
		goto err_free_mem;
	}

	return pd;

err_free_mem:
	devm_kfree(&pdev->dev, gpio_keys_pdata);
	return ERR_PTR(error);
}

Although irq_resources is declared and initialized before all of the
goto err_free_mem jumps, include/linux/cleanup.h recommends against mixing
__free() scope-based cleanup and goto cleanup labels within the same
function. Later in the series (in commit "Input: soc_button_array - convert
to software nodes"), err_free_mem is replaced by goto err_remove_swnodes
while keeping irq_resources __free(kfree).

Should soc_button_device_create() avoid mixing __free(kfree) with goto
cleanup here?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021015004.1537=
738-1-dmitry.torokhov@gmail.com?part=3D1
