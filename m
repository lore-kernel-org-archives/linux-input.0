Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0683EFFA8
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 07:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789372314; cv=none; b=sQMNhg7Y2dGq3I/6k5AFQWI2lvQd3ewZsE4clVi3wRGi/m3GYvs5QQhOMxzPkxz3PZeQfgnDPJRmhOSlz3Ed10b8qZUUTL64GHupDrmXNnnUvrwPKsK0r/0M2Sx+tk21MwDOnzyMVqFdvY8ZCh2LqvkQnMgX2LuNRJlrBN4fdsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789372314; c=relaxed/simple;
	bh=WwWbIqSDOJ+qV9SKI9J586/vs2UZGdEGjYPUxiNFyQ4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=NZaccGUzdie5VZZJl/syFJLNjIiQNc8DmmX9MBSPZZf0QPeFdNvxUEVznRDyX/VqQgeg1ALC+5vr7+6FCm4k6Kjx/KgHLbezI8Z7mo2WdbiJKCXJk+Lkr+/cFOXllacWkQXKILJC2UmixYvbL0oMlPgrpn2DrVTyK3kmRCoWzec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=BujHPMc6; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="BujHPMc6"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843f22dc83so1105105f8f.1
        for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 00:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789372310; x=1789977110; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IlCQLgA1I6Tlq7Eawq8974ry400ZD6uMfidPXTvqpL8=;
        b=BujHPMc6lXh3EijUpzfR1khdP8mYFxWcP0EGoWis0G9S0hfzr25q+RRQrbP2X6M8oq
         zULSzarveZYPLLyJ/K9fA9OQZNiwuRTxo7Ga5lI6zt2vuO8UMbHmqZehuPjCk87C8SUR
         Y/1K+RkUMiN5JrgpQRlrBPO+M+PjhQoB+7FqI05qsKAkP+2MVPDBMiK69LaYRtdrTpwR
         ct9mLwvgvrTkEBjjJeQzkODkL827fm6PEPhPCbOhU8wM/VvNL/4WgCUTqF8zcew/GUOc
         zjusiHgjM4Xb1VGBqGRN7x360jhdbHceCALLZBb4ika+3WJr6vwirGlEsWSfdOUMcKdG
         194g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789372310; x=1789977110;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IlCQLgA1I6Tlq7Eawq8974ry400ZD6uMfidPXTvqpL8=;
        b=CM2/xC2buNfLCSOvzET/6K5RU/dy7mFuCyPIGy2U9tzboNcPTz41CYe9ngqDQnhnsY
         gpU6zOp7c+e8sJXKoxwalZndIthR7IocKVbNeNRH/u2XJYWTUN0WNnwXLOlvX0e/uNMS
         yQEC5U9gEUBdhV5u6jPm41P7yTmJo/kyG0rkO45F83EbttqTundv2UXNg50sqevtafHk
         mRKZKs97C5p2+KZAHcMTkKNwVzF+SEKLB7s0Q4Mk61JnjgVClZHOX19WOkx0fQGwNv9s
         qckhZ5pntbMfjZMw0RFSDzpIlXMHx4Sx7G+TQMS8KWg1MHrzQgEeqdaCHK2upwN5QLP2
         Fz2A==
X-Forwarded-Encrypted: i=1; AKwUvBz4bN62OLD2eGrnpmuN1yBGr0WJvl9KWeAvO7BXz98LFdLbnhNfazShksVNmGhVdMUe2HBXX471umzwjA==@vger.kernel.org
X-Gm-Message-State: AFuF++kHQZbYwyPRghdR/H0dNtCLaM6PnDBXv7IP7LcW6gIvB8vSCdQ0
	I3vxyFNc06bq7B2Gz+HvhFU5Lt8s/NVCWWPoHw+lcpgtTMCYofgYjRTt88h4b54rlFWK43BKS8K
	1/hxN
X-Gm-Gg: AYBFou2HgVYzxSlHXbwxOUimmoxVkL5wnsdpIO59S6+FgjteLrTy3W30afV5IqGP2Dz
	ud+PY2t4WOjJpnwB04O+JDHkqyHvYtxi7F1lbPUkAkJpqRzLo353+Ld3SOAYE5/8IH4Z/4qUDn8
	B0Q8EqQwtlG+jEK+qb+hU67w61Zwdv+wsvHo963LywjMOgVOGnmWEPlhlYkVykxGZ1dG6DwYDu3
	9MwJ7bIZIsL0hfCPzYL4d+AV72tkeZbE8Huisym4tZAYBY00ABhAlUAp011wR83I3GSgtPFTOKp
	Vb2p9fapG5bQgaDGqdl5XOwxOlo1OB86gVNGQ7W5K2yjUjUeBjSBb3ovUEJvfIOKrKiOIHKWsu7
	wFVHBcQ7oQ3cOfeEhFYmkGb+bPmLKeM47Ld88+0fOR2m/9aVU1E/a72LS14HkQMd7km1HMt2YlQ
	lGRcwt/A7M7YsPvBoXGeFa/Y+M0sDBvitYF5qC48o3LBVNoujlprqTq9d+hALsT+vrLg==
X-Received: by 2002:a5d:5e8c:0:b0:486:f76f:f2ea with SMTP id ffacd0b85a97d-48702b2a6f6mr1438636f8f.51.1789372310252;
        Mon, 14 Sep 2026 00:51:50 -0700 (PDT)
Received: from localhost ([2001:4091:a245:8029:665d:b7b:5fa4:7ad0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33ee5csm24980103f8f.20.2026.09.14.00.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 00:51:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=569c53e9584ef61498e821a4338055056548e03f1b97846d365c71442448;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 14 Sep 2026 09:51:39 +0200
Message-Id: <DLEVJIB1SL4O.2WZY8O2F54YL4@baylibre.com>
Subject: Re: [PATCH 2/2] Input: gpio-keys - support wakeup pinctrl state on
 suspend
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Kendall Willis" <k-willis@ti.com>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
Cc: <msp@baylibre.com>, <s-kochidanadu@ti.com>, <a-kaur@ti.com>,
 <s-tripathi1@ti.com>, <vishalm@ti.com>, <linux-input@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
X-Mailer: aerc 0.21.0-146-gb5c16ebe1835
References: <20260912-upstream-gpio-wakeup-v1-0-f0e12484b836@ti.com>
 <20260912-upstream-gpio-wakeup-v1-2-f0e12484b836@ti.com>
In-Reply-To: <20260912-upstream-gpio-wakeup-v1-2-f0e12484b836@ti.com>

--569c53e9584ef61498e821a4338055056548e03f1b97846d365c71442448
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Kendall,

On Sat Sep 12, 2026 at 11:33 PM CEST, Kendall Willis wrote:
> GPIO can be used as a wakeup source for TI K3 AM62 devices during
> suspend to RAM states. The GPIO controller is powered off in these
> states, so a wakeup enable flag must be set on the GPIO pin in the
> pinctrl in order to allow wakeup.
>
> If the device is wakeup enabled, select the 'wakeup' pinctrl state on
> suspend and restore the default pinctrl state on resume.
>
> Signed-off-by: Kendall Willis <k-willis@ti.com>
> ---
>  drivers/input/keyboard/gpio_keys.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/=
gpio_keys.c
> index 129fc4212a5ed126496b331ce626682d441c53bf..b409e179705195e5fec172ff6=
2088395109cd758 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -28,6 +28,7 @@
>  #include <linux/of.h>
>  #include <linux/of_irq.h>
>  #include <linux/spinlock.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <dt-bindings/input/gpio-keys.h>
> =20
>  struct gpio_button_data {
> @@ -60,6 +61,8 @@ struct gpio_keys_drvdata {
>  	struct input_dev *input;
>  	struct mutex disable_lock;
>  	unsigned short *keymap;
> +	struct pinctrl *pinctrl;
> +	struct pinctrl_state *pinctrl_wakeup;
>  	struct gpio_button_data data[];
>  };
> =20
> @@ -884,6 +887,10 @@ static int gpio_keys_probe(struct platform_device *p=
dev)
>  	platform_set_drvdata(pdev, ddata);
>  	input_set_drvdata(input, ddata);
> =20
> +	ddata->pinctrl =3D devm_pinctrl_get(dev);
> +	if (!IS_ERR_OR_NULL(ddata->pinctrl))
> +		ddata->pinctrl_wakeup =3D pinctrl_lookup_state(ddata->pinctrl, "wakeup=
");
> +
>  	input->name =3D pdata->name ? : pdev->name;
>  	input->phys =3D "gpio-keys/input0";
>  	input->dev.parent =3D dev;
> @@ -1010,6 +1017,9 @@ gpio_keys_enable_wakeup(struct gpio_keys_drvdata *d=
data)
>  	int error;
>  	int i;
> =20
> +	if (!IS_ERR_OR_NULL(ddata->pinctrl_wakeup))
> +		pinctrl_select_state(ddata->pinctrl, ddata->pinctrl_wakeup);

If wakeup state selection failed, should it really just continue here?

> +
>  	for (i =3D 0; i < ddata->pdata->nbuttons; i++) {
>  		bdata =3D &ddata->data[i];
>  		if (bdata->button->wakeup) {

There is some error handling below in this function. The selected
pinctrl state is not rolled back in the error path.

Best
Markus

> @@ -1039,6 +1049,9 @@ gpio_keys_disable_wakeup(struct gpio_keys_drvdata *=
ddata)
>  	struct gpio_button_data *bdata;
>  	int i;
> =20
> +	if (!IS_ERR_OR_NULL(ddata->pinctrl_wakeup))
> +		pinctrl_pm_select_default_state(ddata->input->dev.parent);
> +
>  	for (i =3D 0; i < ddata->pdata->nbuttons; i++) {
>  		bdata =3D &ddata->data[i];
>  		bdata->suspended =3D false;



--569c53e9584ef61498e821a4338055056548e03f1b97846d365c71442448
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaqenjBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlNt
TQD/c7MnXiIvcG3gG7E2Zu1Y5tUTvEOFzAkx75oJO+cS5BkBAMsQqdj/0BD9A8lR
clBJhgIZ87/YOz4F1lVPFwWtX4cN
=SuGg
-----END PGP SIGNATURE-----

--569c53e9584ef61498e821a4338055056548e03f1b97846d365c71442448--
