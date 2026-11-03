Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793718556;
	b=A6d84S4d8rGyFD5xW0EmnHHxQC7hXVjMcWG3lvRkOyxYQngZtHUqUNb2i3jS3JwhfG1u
	 cNVqTMhgarH6KPxbg9Q/gzAZWwxfoGZllTA/TUyUQ/G6Vi402ESs5+IoQBXWEARdsIkIS
	 HEfPKCDbYyO+lRa1BBRIgkXeMmZuQE3iQXnkU1PAeVdFeXylNBt4MqXoE7jddJVInPT1Y
	 eAfb37sJfexGRFtkZaQGiWA4t8KZgzvUGcgqVnkl6QfrmN128m2gW4+4EwF2PLAyDwpTU
	 p9Jcb0nzksCWjUnVrpZHGoDyJDOC70s4h7HYriPPP83FUHZDQ5FK7GyA0wXRZlLQClA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718556;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-AI-Review-Draft;
	bh=04sRIO3MjeYbz6CJp5GZCOCBS65b5l82fPhVgQ5j8Ig=;
	b=V21CmhC2D5EL1JcCpLToV0V4oQB5pb6Gcjmv1hwR8wN0XFS0+Kw1WkJ+Hg1pz7hiNWM/
	 EXMJABwjcyikgiMmsizundS4nJMzwoqVB63dKnx8VM6Id0rAeoRfbgInNYoFNL/xZisT8
	 74gFaICbKCgbaK0B0Lq9O8Ak21XrbbjnV6zpviLqh6gisFrF+kSc6eikMliB3gtmQxgNe
	 GSJH4xZaPZGmiRRIkrqMF4n2/Hzr0HCpdUawa2OIG3FkQt1fxarfTr1tjAFqahs1PFHPJ
	 mq9MXrn+HGkZh2mYy7p62FyxCi9kXyx93AlwfM/VEccwy1nBx6C+hwedaNnhylejL8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ka8mU0zm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6186606B277;
	Tue,  3 Nov 2026 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ka8mU0zm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351961F000C1;
	Tue,  3 Nov 2026 15:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793718555;
	bh=04sRIO3MjeYbz6CJp5GZCOCBS65b5l82fPhVgQ5j8Ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ka8mU0zmAxKLwL2fFpD9CSalT3tGxn8R2vJaJEvx62sO5knzmnr8o+jvl3A4PXUYQ
	 Dxf4yVxdNUJRaSMFUbZXUszVhxd0knfdDWS6zjzIFpMB5n4bUVioUR8MiiThYK+RXG
	 oLntR6Y938oN1l2HEEGZwVORgG5aTsGwv/MxrYlWW+xz+HzsxFHbe8bsiksmJN+Eeg
	 st24vgn2YKrHIvg0UlZHV1ThyeHHuIY6Xm64crEiMYg8cxKwttwDLZNXlk3pCT3Gzq
	 wy9AdFSWAhMox5u4djhZqr3O3sxbk/vCdfLhvYIRh52/cce/Q/j73nK2lIrQ1r3h0O
	 ape4Kv2DAzHkg==
Date: Tue, 3 Nov 2026 15:09:07 +0000
From: Lee Jones <lee@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Val Packett <val@packett.cool>, Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, mfd@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v11 4/9] mfd: mt6397: Use MFD_CELL_* to describe
 sub-devices
Message-ID: <179310028255.2808517.13933580516140278450@kernel.org>
References: <20261021105109.199886-1-l.scorcia@gmail.com>
 <20261021105109.199886-5-l.scorcia@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021105109.199886-5-l.scorcia@gmail.com>
X-AI-Review-Draft: <20261021105109.199886-5-l.scorcia@gmail.com>

On Wed, 21 Oct 2026, Luca Leonardo Scorcia wrote:

> Use the MFD_CELL_* macros to describe sub-devices. No functional changes.
>
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/mfd/mt6397-core.c | 207 ++++++++++++--------------------------
>  1 file changed, 67 insertions(+), 140 deletions(-)
>
> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index 9ec951996588..3e08179002fa 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c
> @@ -124,165 +124,92 @@ static const struct resource mt6323_pwrc_resources[] = {
>  };
>
>  static const struct mfd_cell mt6323_devs[] = {
> -	{
> -		.name = "mt6323-auxadc",
> -		.of_compatible = "mediatek,mt6323-auxadc",
> -	}, {
> -		.name = "mt6323-efuse",
> -		.of_compatible = "mediatek,mt6323-efuse",
> -	}, {
> -		.name = "mt6323-rtc",
> -		.num_resources = ARRAY_SIZE(mt6323_rtc_resources),
> -		.resources = mt6323_rtc_resources,
> -		.of_compatible = "mediatek,mt6323-rtc",
> -	}, {
> -		.name = "mt6323-regulator",
> -		.of_compatible = "mediatek,mt6323-regulator"
> -	}, {
> -		.name = "mt6323-led",
> -		.of_compatible = "mediatek,mt6323-led"
> -	}, {
> -		.name = "mt6323-keys",
> -		.num_resources = ARRAY_SIZE(mt6323_keys_resources),
> -		.resources = mt6323_keys_resources,
> -		.of_compatible = "mediatek,mt6323-keys"
> -	}, {
> -		.name = "mt6323-pwrc",
> -		.num_resources = ARRAY_SIZE(mt6323_pwrc_resources),
> -		.resources = mt6323_pwrc_resources,
> -		.of_compatible = "mediatek,mt6323-pwrc"
> -	},
> +	MFD_CELL_OF("mt6323-auxadc", NULL, NULL, 0, 0,
> +		    "mediatek,mt6323-auxadc"),
> +	MFD_CELL_OF("mt6323-efuse", NULL, NULL, 0, 0,
> +		    "mediatek,mt6323-efuse"),
> +	MFD_CELL_OF("mt6323-rtc", mt6323_rtc_resources, NULL, 0, 0,
> +		    "mediatek,mt6323-rtc"),
> +	MFD_CELL_OF("mt6323-regulator", NULL, NULL, 0, 0,
> +		    "mediatek,mt6323-regulator"),
> +	MFD_CELL_OF("mt6323-led", NULL, NULL, 0, 0,
> +		    "mediatek,mt6323-led"),
> +	MFD_CELL_OF("mt6323-keys", mt6323_keys_resources, NULL, 0, 0,
> +		    "mediatek,mt6323-keys"),
> +	MFD_CELL_OF("mt6323-pwrc", mt6323_pwrc_resources, NULL, 0, 0,

Nit: This is non-blocking, but if you have to respin, please use the
100-char limit to keep these on single lines where possible. Same for
all the others below.

> +		    "mediatek,mt6323-pwrc"),
>  };
>
>  static const struct mfd_cell mt6328_devs[] = {
> -	{
> -		.name = "mt6328-regulator",
> -		.of_compatible = "mediatek,mt6328-regulator"
> -	}, {
> -		.name = "mt6328-keys",
> -		.num_resources = ARRAY_SIZE(mt6328_keys_resources),
> -		.resources = mt6328_keys_resources,
> -		.of_compatible = "mediatek,mt6328-keys"
> -	},
> +	MFD_CELL_OF("mt6328-regulator", NULL, NULL, 0, 0,
> +		    "mediatek,mt6328-regulator"),
> +	MFD_CELL_OF("mt6328-keys", mt6328_keys_resources, NULL, 0, 0,
> +		    "mediatek,mt6328-keys"),
>  };
>
>  static const struct mfd_cell mt6357_devs[] = {
> -	{
> -		.name = "mt6359-auxadc",
> -		.of_compatible = "mediatek,mt6357-auxadc"
> -	}, {
> -		.name = "mt6357-regulator",
> -	}, {
> -		.name = "mt6357-rtc",
> -		.num_resources = ARRAY_SIZE(mt6357_rtc_resources),
> -		.resources = mt6357_rtc_resources,
> -		.of_compatible = "mediatek,mt6357-rtc",
> -	}, {
> -		.name = "mt6357-sound",
> -		.of_compatible = "mediatek,mt6357-sound"
> -	}, {
> -		.name = "mt6357-keys",
> -		.num_resources = ARRAY_SIZE(mt6357_keys_resources),
> -		.resources = mt6357_keys_resources,
> -		.of_compatible = "mediatek,mt6357-keys"
> -	},
> +	MFD_CELL_OF("mt6359-auxadc", NULL, NULL, 0, 0,
> +		    "mediatek,mt6357-auxadc"),
> +	MFD_CELL_NAME("mt6357-regulator"),
> +	MFD_CELL_OF("mt6357-rtc", mt6357_rtc_resources, NULL, 0, 0,
> +		    "mediatek,mt6357-rtc"),
> +	MFD_CELL_OF("mt6357-sound", NULL, NULL, 0, 0,
> +		    "mediatek,mt6357-sound"),
> +	MFD_CELL_OF("mt6357-keys", mt6357_keys_resources, NULL, 0, 0,
> +		    "mediatek,mt6357-keys"),
>  };
>
>  /* MT6331 is always used in combination with MT6332 */
>  static const struct mfd_cell mt6331_mt6332_devs[] = {
> -	{
> -		.name = "mt6331-rtc",
> -		.num_resources = ARRAY_SIZE(mt6331_rtc_resources),
> -		.resources = mt6331_rtc_resources,
> -		.of_compatible = "mediatek,mt6331-rtc",
> -	}, {
> -		.name = "mt6331-regulator",
> -		.of_compatible = "mediatek,mt6331-regulator"
> -	}, {
> -		.name = "mt6332-regulator",
> -		.of_compatible = "mediatek,mt6332-regulator"
> -	}, {
> -		.name = "mt6331-keys",
> -		.num_resources = ARRAY_SIZE(mt6331_keys_resources),
> -		.resources = mt6331_keys_resources,
> -		.of_compatible = "mediatek,mt6331-keys"
> -	},
> +	MFD_CELL_OF("mt6331-rtc", mt6331_rtc_resources, NULL, 0, 0,
> +		    "mediatek,mt6331-rtc"),
> +	MFD_CELL_OF("mt6331-regulator", NULL, NULL, 0, 0,
> +		    "mediatek,mt6331-regulator"),
> +	MFD_CELL_OF("mt6332-regulator", NULL, NULL, 0, 0,
> +		    "mediatek,mt6332-regulator"),
> +	MFD_CELL_OF("mt6331-keys", mt6331_keys_resources, NULL, 0, 0,
> +		    "mediatek,mt6331-keys"),
>  };
>
>  static const struct mfd_cell mt6358_devs[] = {
> -	{
> -		.name = "mt6359-auxadc",
> -		.of_compatible = "mediatek,mt6358-auxadc"
> -	}, {
> -		.name = "mt6358-regulator",
> -		.of_compatible = "mediatek,mt6358-regulator"
> -	}, {
> -		.name = "mt6358-rtc",
> -		.num_resources = ARRAY_SIZE(mt6358_rtc_resources),
> -		.resources = mt6358_rtc_resources,
> -		.of_compatible = "mediatek,mt6358-rtc",
> -	}, {
> -		.name = "mt6358-sound",
> -		.of_compatible = "mediatek,mt6358-sound"
> -	}, {
> -		.name = "mt6358-keys",
> -		.num_resources = ARRAY_SIZE(mt6358_keys_resources),
> -		.resources = mt6358_keys_resources,
> -		.of_compatible = "mediatek,mt6358-keys"
> -	},
> +	MFD_CELL_OF("mt6359-auxadc", NULL, NULL, 0, 0,
> +		    "mediatek,mt6358-auxadc"),
> +	MFD_CELL_OF("mt6358-regulator", NULL, NULL, 0, 0,
> +		    "mediatek,mt6358-regulator"),
> +	MFD_CELL_OF("mt6358-rtc", mt6358_rtc_resources, NULL, 0, 0,
> +		    "mediatek,mt6358-rtc"),
> +	MFD_CELL_OF("mt6358-sound", NULL, NULL, 0, 0,
> +		    "mediatek,mt6358-sound"),
> +	MFD_CELL_OF("mt6358-keys", mt6358_keys_resources, NULL, 0, 0,
> +		    "mediatek,mt6358-keys"),
>  };
>
>  static const struct mfd_cell mt6359_devs[] = {
> -	{
> -		.name = "mt6359-auxadc",
> -		.of_compatible = "mediatek,mt6359-auxadc"
> -	},
> -	{ .name = "mt6359-regulator", },
> -	{
> -		.name = "mt6359-rtc",
> -		.num_resources = ARRAY_SIZE(mt6358_rtc_resources),
> -		.resources = mt6358_rtc_resources,
> -		.of_compatible = "mediatek,mt6358-rtc",
> -	},
> -	{ .name = "mt6359-sound", },
> -	{
> -		.name = "mt6359-keys",
> -		.num_resources = ARRAY_SIZE(mt6359_keys_resources),
> -		.resources = mt6359_keys_resources,
> -		.of_compatible = "mediatek,mt6359-keys"
> -	},
> -	{
> -		.name = "mt6359-accdet",
> -		.of_compatible = "mediatek,mt6359-accdet",
> -		.num_resources = ARRAY_SIZE(mt6359_accdet_resources),
> -		.resources = mt6359_accdet_resources,
> -	},
> +	MFD_CELL_OF("mt6359-auxadc", NULL, NULL, 0, 0,
> +		    "mediatek,mt6359-auxadc"),
> +	MFD_CELL_NAME("mt6359-regulator"),
> +	MFD_CELL_OF("mt6359-rtc", mt6358_rtc_resources, NULL, 0, 0,
> +		    "mediatek,mt6358-rtc"),
> +	MFD_CELL_NAME("mt6359-sound"),
> +	MFD_CELL_OF("mt6359-keys", mt6359_keys_resources, NULL, 0, 0,
> +		    "mediatek,mt6359-keys"),
> +	MFD_CELL_OF("mt6359-accdet", mt6359_accdet_resources, NULL, 0, 0,
> +		    "mediatek,mt6359-accdet"),
>  };
>
>  static const struct mfd_cell mt6397_devs[] = {
> -	{
> -		.name = "mt6397-rtc",
> -		.num_resources = ARRAY_SIZE(mt6397_rtc_resources),
> -		.resources = mt6397_rtc_resources,
> -		.of_compatible = "mediatek,mt6397-rtc",
> -	}, {
> -		.name = "mt6397-regulator",
> -		.of_compatible = "mediatek,mt6397-regulator",
> -	}, {
> -		.name = "mt6397-codec",
> -		.of_compatible = "mediatek,mt6397-codec",
> -	}, {
> -		.name = "mt6397-clk",
> -		.of_compatible = "mediatek,mt6397-clk",
> -	}, {
> -		.name = "mt6397-pinctrl",
> -		.of_compatible = "mediatek,mt6397-pinctrl",
> -	}, {
> -		.name = "mt6397-keys",
> -		.num_resources = ARRAY_SIZE(mt6397_keys_resources),
> -		.resources = mt6397_keys_resources,
> -		.of_compatible = "mediatek,mt6397-keys"
> -	}
> +	MFD_CELL_OF("mt6397-rtc", mt6397_rtc_resources, NULL, 0, 0,
> +		    "mediatek,mt6397-rtc"),
> +	MFD_CELL_OF("mt6397-regulator", NULL, NULL, 0, 0,
> +		    "mediatek,mt6397-regulator"),
> +	MFD_CELL_OF("mt6397-codec", NULL, NULL, 0, 0,
> +		    "mediatek,mt6397-codec"),
> +	MFD_CELL_OF("mt6397-clk", NULL, NULL, 0, 0,
> +		    "mediatek,mt6397-clk"),
> +	MFD_CELL_OF("mt6397-pinctrl", NULL, NULL, 0, 0,
> +		    "mediatek,mt6397-pinctrl"),
> +	MFD_CELL_OF("mt6397-keys", mt6397_keys_resources, NULL, 0, 0,
> +		    "mediatek,mt6397-keys"),
>  };
>
>  struct chip_data {
> -- 
> 2.43.0
>

-- 
Lee Jones
