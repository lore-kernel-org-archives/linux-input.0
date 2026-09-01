Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243B9456E03;
	Tue,  1 Sep 2026 08:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788249731; cv=none; b=PQXPqmcFQ6/jDWhIhHEjBbNUVD0cYzwK+tncR5EH8nm1xv+8ngKY4p7vTSPEe6uBMRA5lQL4LkAJlsFvnLXDM7f/o3nfATN21Ub456aeAtYIbBLjZdjaXcSPvqkHwMMuWs80CXhkYpEHpSoRNAWncvV2UGugMQeb2AHLVWMIdvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788249731; c=relaxed/simple;
	bh=+dn9QOzh37CHFnPEKSyZdus65ZW4N0KRijsBBWuC2AU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hbzTXSKXyAOs8w6LXb9DcRIH4NbeJbA+0/hRO4uusSLRZRX+ZjQvX2tv4qPc/yfOQq3ZBPrgSILWL9cR0Kexguh+gSam+zREVQ7o0bsqhm20/L5SDZnDVvIomsyrf8Lsbh+VXi5g6TC1ZTVWuEzDwzFZAxyy4w5i/buM0RelxYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6UlYoaN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6UlYoaN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7381E1F000E9;
	Tue,  1 Sep 2026 08:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788249729;
	bh=bmrRHMPPxY+TaiUJDex7a1IqhzCb9029bQYPkmAZu/g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P6UlYoaNefr5NVYLPtr3xzjXZlKFWSLMlaLQPLM79DUxlBRCU9Qokl8pVlD3pRLcv
	 +2oZB9Byp2TvaMQiLVv11kj2YPIxv4HP94g77jvFEKMU5W2Y4KZktj9C0oMb/EDy89
	 MqPfDu953Q836KxD5kM+Wf9H5Ah+53P0/Yop7O7OoX2rVeO+TZVoUpuiNAWgI5M/vb
	 KPVAPit1hsKXi2Jp8Pcy0GR/uJzjm07CWcOJZRG04UzTq5JwV+loPVe3ZnEDb2SPfj
	 V6/c2pbyy9PgM5c5i6qt701mCLUbHeEPc14Pd8QoNzGgdoE0fLKJzzoHrRZqT/hD3y
	 AWoCx/6B3LBlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/8] i2c: of-prober: skip post-power-on delay if
 powered on sufficiently long
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen-Yu Tsai" <wenst@chromium.org>
Cc: devicetree@vger.kernel.org, robh@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, conor+dt@kernel.org
In-Reply-To: <20260901074930.764550-5-wenst@chromium.org>
References: <20260901074930.764550-1-wenst@chromium.org>
 <20260901074930.764550-5-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 08:02:08 +0000
Message-Id: <20260901080209.7381E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The i2c_of_probe_simple_get_supply function fails the probe if the=
 regulator is not found in the device tree, contradicting its stated intent=
 to treat missing regulators as optional.
--

commit c0491b6ceb5b608dbfb97b1a7a7116f271999495
Author: Chen-Yu Tsai <wenst@chromium.org>

i2c: of-prober: skip post-power-on delay if powered on sufficiently long

This patch switches the I2C of-prober to use the new=20
regulator_enable_and_wait() function to handle post-power-on delays. This
avoids unnecessary boot time penalties on devices where the power rail is
always-on or initialized by the bootloader.

> diff --git a/drivers/i2c/i2c-core-of-prober.c b/drivers/i2c/i2c-core-of-p=
rober.c
> index 6a82b03809d4f..f9f3c0ef93ff5 100644
> --- a/drivers/i2c/i2c-core-of-prober.c
> +++ b/drivers/i2c/i2c-core-of-prober.c

[ ... ]

> @@ -226,13 +227,11 @@ static int i2c_of_probe_simple_enable_regulator(str=
uct device *dev, struct i2c_o
> =20
>  	dev_dbg(dev, "Enabling regulator supply \"%s\"\n", ctx->opts->supply_na=
me);
> =20
> -	ret =3D regulator_enable(ctx->supply);
> +	ret =3D regulator_enable_and_wait(ctx->supply,
> +					ctx->opts->post_power_on_delay_ms * USEC_PER_MSEC);
>  	if (ret)
>  		return ret;
> =20
> -	if (ctx->opts->post_power_on_delay_ms)
> -		msleep(ctx->opts->post_power_on_delay_ms);
> -
>  	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but I noticed something related to the regula=
tor
handling in i2c_of_probe_simple_get_supply().

Does this code incorrectly fail the probe when a regulator is missing?

In i2c_of_probe_simple_get_supply(), we call of_regulator_get_optional():

	supply =3D of_regulator_get_optional(dev, node, supply_name);
	if (IS_ERR(supply)) {
		return dev_err_probe(dev, PTR_ERR(supply),
				     "Failed to get regulator supply \"%s\" from %pOF\n",
				     supply_name, node);
	}

Since of_regulator_get_optional() returns -ENODEV when the supply is not fo=
und
in the device tree, does this IS_ERR() check cause a fatal initialization
failure for valid hardware configurations where the supply is always-on or
not modeled?

Could this contradict the stated intent of treating missing regulators as
optional?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901074930.7645=
50-1-wenst@chromium.org?part=3D4
