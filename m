Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C563F0773;
	Mon,  1 Jun 2026 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780339309; cv=none; b=mch4bApFpYLKIFlYJ/AopgYKY/2Xrr8qhTfyiPZt63NZDSMfQVxVhcQ7h67cCasjJ+dEjmJSEoua7QLGxaJxvyK1YUtpry+Bkh2mVrUw75z8pl3E/EEGBc2KV2nJzeb7kNyQQfHKwX+1fCwSu16SOyOgn3qtunUQQJIGbEZQmwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780339309; c=relaxed/simple;
	bh=oAv+yOlOnZ8HXQygCAWOPVZwktiVreI6JYkUAtuqHts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpBakycYGUaIBf1eMqCb5zwgnFg85zV6QDBGhsKYepmxxQuP65pNjuNeOko/wgtI1SOFc/k6xK7ASoWcLEO97V9nMgZbeflDM+PMfnIUHYaxbUakoG92x0pewdcVVh/og4qDuBn3Bp+W+Y25twPqhV+JJJkVyu0wPVskr3+b2dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ex9uII4i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ex9uII4i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2033F1F00893;
	Mon,  1 Jun 2026 18:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780339303;
	bh=wW2I9IQOgQPeKJJKfmoCD2QasKn5Lkl/P+IL+G1Ddug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ex9uII4irekVurRAmQj59bEAJ3EVPb5zJ7FnuwdPimG0xK9XK8aFGGUyfDkjikOuW
	 LIJ51F7aQ/r7xBCVjEdJZ8tqUHEEUU9MDbIyFWND3/FvZ4af6bXvNDNt9/AXmOvyyQ
	 zvPPeuPawPyr62qJtpv/FndtkMObgMItdKBFXm54N8ej7R8IoZQ1Ux1kaL5SPkukyy
	 f0FeUwI08+XAleI0hrzAQO/ANR/HGEp4JfyQUlkDDFg6uYAn/A0rvMJF5hX5KRZUf5
	 MV3lT4gqTkAtgeTySEHAGgeZ6e4yH9ZS4zjqiJep63xwBFZzN3w1LGGARFDijkEU0d
	 uBgMv4ieGgYFA==
Date: Mon, 1 Jun 2026 19:41:37 +0100
From: Mark Brown <broonie@kernel.org>
To: y.oudjana@protonmail.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Flora Fu <flora.fu@mediatek.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 3/4] regulator: Add driver for MediaTek MT6328 PMIC
 regulators
Message-ID: <c94c94b4-c3f4-4369-a110-dfb825c5f103@sirena.org.uk>
References: <20260531-mt6735-pwrap-mt6328-pmic-v2-0-dac37bf92894@protonmail.com>
 <20260531-mt6735-pwrap-mt6328-pmic-v2-3-dac37bf92894@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hTo5YyAF2wDum4dv"
Content-Disposition: inline
In-Reply-To: <20260531-mt6735-pwrap-mt6328-pmic-v2-3-dac37bf92894@protonmail.com>
X-Cookie: Have a nice day!


--hTo5YyAF2wDum4dv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 31, 2026 at 11:10:44AM +0200, Yassine Oudjana via B4 Relay wrote:
> @@ -0,0 +1,500 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * MediaTek MT6328 regulator driver
> + * Based on MT6323 driver.
> + *
> + * Copyright (c) 2016 MediaTek Inc.
> + * Copyright (c) 2022 Yassine Oudjana <y.oudjana@protonmail.com>
> + */

Please make the entire comment a C++ one so things look more
intentional.

> +static const unsigned int ldo_volt_table3[] = {
> +	0, 0, 0, 1800000, 1900000, 2000000, 2100000, 2200000
> +};

Use linear_min_sel for the first three values.

> +static const struct linear_range ldo_volt_range1[] = {
> +	REGULATOR_LINEAR_RANGE(700000, 0, 0x7f, 6250)
> +};

If there's just one range there's no need for a lookup table, use
regulator_map_voltage_linar().

> +static int mt6328_get_status(struct regulator_dev *rdev)
> +{
> +	int ret;
> +	u32 regval;
> +	struct mt6328_regulator_info *info = rdev_get_drvdata(rdev);
> +
> +	ret = regmap_read(rdev->regmap, info->desc.enable_reg, &regval);
> +	if (ret != 0) {
> +		dev_err(&rdev->dev, "Failed to get enable reg: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return (regval & info->qi) ? REGULATOR_STATUS_ON : REGULATOR_STATUS_OFF;
> +}

get_status() should report the actual status of the regulator, not what
was configured.  If the device can't report this just omit the
operation.

> +		if (mt6328_regulators[i].vselctrl_reg) {
> +			if (regmap_read(mt6328->regmap,
> +				mt6328_regulators[i].vselctrl_reg,
> +				&regval) < 0) {
> +				dev_err(&pdev->dev,
> +					"Failed to read buck ctrl\n");
> +				return -EIO;

Better to return the actual error.

> +		rdev = devm_regulator_register(&pdev->dev,
> +				&mt6328_regulators[i].desc, &config);
> +		if (IS_ERR(rdev)) {
> +			dev_err(&pdev->dev, "failed to register %s\n",
> +				mt6328_regulators[i].desc.name);
> +			return PTR_ERR(rdev);

dev_err_probe().

--hTo5YyAF2wDum4dv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmod0mAACgkQJNaLcl1U
h9Cowgf/TR/qzesVBhChXAa4+FjLbC3YcC3giv6TuI0GVikEdxuWGTDvD2iipvAK
p+sJYyV5B+BuTDI6NaYr4CrVsJNIpV+ci7qoXixlUV9ju7qY/L6GmjdYJY+l/XcF
W+fZFCQfqkIRFB3V87HJPY81af0WQLJ0c9G4euXtdmzusaWOGaHhecMu2Sic1IZn
FMjUVSMriahgusOeO6uikaa86FqoXcJtHB6aLGX654xLky6UJCNaLJJ4G/PitxEZ
py6OsBALpjjImVOGWziwKrIsMqxdFPH8/15+N8Kv5fT8VkEG2rT0Gh+LhmBvKTA7
j2oF8Qysg9lhLOv6gc9Aw3i+nMZ5PQ==
=Ua+8
-----END PGP SIGNATURE-----

--hTo5YyAF2wDum4dv--
