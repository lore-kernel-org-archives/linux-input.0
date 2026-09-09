Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1B3579827;
	Wed,  9 Sep 2026 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788961133; cv=none; b=j+0832yhSHEJFuetqi2FIxFlVLItwDRq2+aOKW+pLiV3KTgFwVcBTMZrxJFC5SNJpm0gS3vXq50Yp9r/B017fIcuEMkAPFHokM91H6xu3yyK9hEOAQAgCelBgWUHsVIJOql2mVJfBdvQmi8GHEkFc2wRiNh8pJYADkWe89VCuZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788961133; c=relaxed/simple;
	bh=ofliS+GTstoNAge1etMSZcB3OORb59HBeWKRo0U+3H4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b47qeHBiZTNaX5F+/gNomL/GDpng3kLpsk/ooCW9gPF6DyWhY4iOBHHFiZcXAa5sk0BttLVAa3b24TItsCsDZX79ZwAz3QMaLJaWGcDN0QL7LALwOOd7N8UcXLo7vPnQWDTG6UJS0wftlo5fTGmT9AF32gUEzBnNKjx2IqqhL3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqOKe6PS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqOKe6PS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523701F00A3A;
	Wed,  9 Sep 2026 13:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788961132;
	bh=HGGR++Bxj12lmQW85xJhvJa3QTXaJAiswbiR+ZJCm7k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DqOKe6PS9CHLaioeKIf0kkI8CL/v6bN1wYR6BU4santnzUIBKfwXf4PwVg+RjF7ZY
	 QolWZxjJqf1RFBcMadN0tWoD5Ea8qp4Kq6fqc4dwE/inetf+cm2itcwzEpVmHyH/sd
	 eUbIDlPlstfxupEVtzHwAnfY/FCohMnDvv0m0ZFP5s1CrDNcUH7hG5h2QpcSW7fk+p
	 uOfi8yCSYPqOLEPriIDj5bXIPqCpKxrNsp0Vitrs5L091NL3zX0/BpJcCEjFFAz985
	 vqzo7mHWcs6UwlILreuIxpKM7EGP7gUKZnRsxrzYdOMjF7M8MRb5pHWs2lspapcl/F
	 caGns+iPpykZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/14] mfd: remove unused si476x driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-leds@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-watchdog@vger.kernel.org, linux-hwmon@vger.kernel.org, dmitry.torokhov@gmail.com, lee@kernel.org, linux-input@vger.kernel.org, mfd@lists.linux.dev, media-ci@linuxtv.org, robh@kernel.org, linux-rtc@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260909132153.1596191-4-arnd@kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-4-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 13:38:50 +0000
Message-Id: <20260909133851.523701F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The device tree binding 'fsl,imx-audio-si476x' is left orphaned in =
the fsl-asoc-card.yaml binding document.
--

commit d07c2cc9eb18a826ae9829a06854385c1084b44d
Author: Arnd Bergmann <arnd@arndb.de>

mfd: remove unused si476x driver
   =20
This commit removes the unused si476x driver, which was originally added
without devicetree support. It drops the MFD core, radio, and ASoC codec
drivers, along with cleaning up the corresponding build rules and the
fsl-asoc-card matching table.

> diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
> index 310ee4c282a1c..ff8ae6e514ea4 100644
> --- a/sound/soc/fsl/fsl-asoc-card.c
> +++ b/sound/soc/fsl/fsl-asoc-card.c

[ ... ]

> @@ -1398,7 +1391,6 @@ static const struct of_device_id fsl_asoc_card_dt_i=
ds[] =3D {
>  	{ .compatible =3D "fsl,imx-audio-wm8960",         .data =3D &fsl_asoc_w=
m8960_pdata },
>  	{ .compatible =3D "fsl,imx-audio-mqs",            .data =3D &fsl_asoc_m=
qs_pdata },
>  	{ .compatible =3D "fsl,imx-audio-wm8524",         .data =3D &fsl_asoc_w=
m8524_pdata },
> -	{ .compatible =3D "fsl,imx-audio-si476x",         .data =3D &fsl_asoc_s=
i476x_pdata },
>  	{ .compatible =3D "fsl,imx-audio-wm8958",         .data =3D &fsl_asoc_w=
m8958_pdata },
>  	{ .compatible =3D "fsl,imx-audio-nau8822",        .data =3D &fsl_asoc_n=
au8822_pdata },
>  	{ .compatible =3D "fsl,imx-audio-wm8904",         .data =3D &fsl_asoc_w=
m8904_pdata },

[Severity: Low]
Since this patch removes the fsl,imx-audio-si476x compatible string from the
fsl_asoc_card_dt_ids matching table, should the devicetree bindings
documentation in Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml
also be updated to remove the orphaned fsl,imx-audio-si476x entry?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909132153.1596=
191-1-arnd@kernel.org?part=3D3
