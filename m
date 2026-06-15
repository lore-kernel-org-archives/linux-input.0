Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8053F410A;
	Mon, 15 Jun 2026 14:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533752; cv=none; b=eJaCooAyVqvzin91PZPcLDbV1aveleawPyJdW4ptfh0G3oGmyLa8AU8XOP+s8S/Dw9for2H1p57khlMsN6DMRjZvgGzzDi1K3hfYfnsGonBO3pG1kmnY73aJYEpPjVSuxU5wgzgkXS6ihjS8wwbLfyaabcVzn9WcqS07N9k7KKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533752; c=relaxed/simple;
	bh=rayzWICmGvFb3tX2zNCX4jQZLQUpwdDIqFudedq9w38=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AwzVilNJyXI9UEBcRiD6ndZMi4YXnlhh9GAEHyiiFWec3lnOHRnXhSI5Yziy6vnE9XCvcTsn+OEVPW/mYhD1U3W1x23Uias+4wROW2ekf8MZCILKZYxBI44BC2hneWGXxWB3d9hXXPdXcROp9QTMbR5rjCyge9JDnAjPInqoNZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYzdBjdG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYzdBjdG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4061F000E9;
	Mon, 15 Jun 2026 14:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781533751;
	bh=Wgrm6nSxP4K6SAcQo8nbIqdcVusm06iSvy1X3gZt+5c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kYzdBjdGObA2T/W0s2lIU3AOO7p7WnacKDJxYIrh9h5uOPv9KtldoH50diypNCK9x
	 SvU9lCJk8GfQFM58rUOBWWkI846Wx3LWXX3DPcJfGEnitQ0ChUyWNeSP61eaFkv3E3
	 qIhaqnYv3t6Vdzud5H1qpLBt3AW+H2MXN12WW7L/nyv66Y+z10WO23mQWPSWhu7MpX
	 U8rTq7Eb27PBNgbhmEOPrhwuj2A1RYWuOl5fnNTzvTpXxQJK8ppB7hk2nSz/rzqAXE
	 kGkKX3rcvglJwURjQLX8GYktafR9VmnJCTzQ2IIzds2K+RMest1jo/wp69sCjJqwyg
	 NXDcBRUlGJD1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/10] Input: cap11xx - add reset gpio support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jun Yan" <jerrysteve1101@gmail.com>
Cc: linux-input@vger.kernel.org, robh@kernel.org, dmitry.torokhov@gmail.com, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260615142103.352163-7-jerrysteve1101@gmail.com>
References: <20260615142103.352163-7-jerrysteve1101@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 14:29:10 +0000
Message-Id: <20260615142911.2B4061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Coding style violations: redundant 'else' after 'return' and incons=
istent brace usage.
--

commit 2a7317102372f10d4bd76864cfeaec2d7955c415
Author: Jun Yan <jerrysteve1101@gmail.com>

Input: cap11xx - add reset gpio support

This commit adds support for an optional hardware reset pin on CAP11xx
devices to improve reliability and ensure proper initialization during prob=
e.

> diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/ca=
p11xx.c
> --- a/drivers/input/keyboard/cap11xx.c
> +++ b/drivers/input/keyboard/cap11xx.c
[ ... ]
> @@ -452,6 +457,16 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_=
client)
>  	if (IS_ERR(priv->regmap))
>  		return PTR_ERR(priv->regmap);
> =20
> +	priv->reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HI=
GH);
> +	if (IS_ERR(priv->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(priv->reset_gpio),
> +				     "Failed to get 'reset' GPIO\n");
> +	else if (priv->reset_gpio) {

[Severity: Low]
This isn't a bug, but does this follow the standard kernel coding style?

Since the preceding if statement ends with a return, the else keyword here
is redundant. Additionally, kernel style guidelines generally prefer that if
one branch of a conditional requires braces, all branches should use them.

Could this be simplified by dropping the else and just using a separate if
statement for checking priv->reset_gpio?

> +		usleep_range(CAP11XX_T_RST_FILT_MIN_US, CAP11XX_T_RST_FILT_MIN_US * 2);
> +		gpiod_set_value_cansleep(priv->reset_gpio, 0);
> +		msleep(CAP11XX_T_RST_ON_MIN_MS);
> +	}
> +
>  	error =3D regmap_read(priv->regmap, CAP11XX_REG_PRODUCT_ID, &val);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615142103.3521=
63-1-jerrysteve1101@gmail.com?part=3D6
