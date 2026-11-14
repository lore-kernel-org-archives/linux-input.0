Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794682550;
	b=xXOsNrVNe+ZecUC39VkEXB7sOdJPlioUDQ9OxnVNTseosIdMitmkv4NSdnMV7W/45mtW
	 5nOgZ0ovWkuFrshlYmjwDx+H75THzgUABLKkZe1eKhz9fa0MSB2G/V23eCqObPhD+p3Sb
	 25kADPql8+bp7Gv4Urx9us1bMlPHyrh2Vl/d8xNAeFRI9KGJz+s8iHT5KWN0u5nMzxtKS
	 dlEPUtJVMokXRuBV73x3V8WEsFJQMGFDOBvgmPFXK8Q/tB4d1OT431m/y+unUJHzyeVle
	 n2Mp9N6ln3KTna4BZEMnezEgfC9dPKNLMldTRoUNWyBUXjHdWJWy5Ckb/0FdSuUELIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794682550;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=36B4eOzVLwpj7Lqu3/UNfQHE6wNxoBrRS0PSkV8wVp8=;
	b=jTpwU0EK+nllH3/UXFOE5Nvqo9ByePB+kRBarxmEEOW9zFrHMJ3TPelSdBwQ3SlsSmFg
	 FInBZcwy1ujiZrAnXyvJXqc8dJ/0Ie1h5rwI7QVQuM0pK9vKIpy9VvPEaAb38mgREJJkY
	 XAgeZmJRB6yLUyg3w3lyexdDxW9qtVmTgwXS8WKdNS15DYsnN8Gkw+KRN6th/hx0miLF6
	 dz1B4ClEOdmjyZqN7D8le4RRJ7E/2eYsVVFuuU5MYo7x2Fz/AD4Ufs454L1d7z+q0IN0/
	 fP+4og8POMCNEqE9eQY844nTJndndnHpLRIuXnvV6A/D4dnn4t4hRrcwE9r9qI3lo4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hbkp6+tB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B0D606A323
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 18:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hbkp6+tB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F6F1F000C4;
	Sat, 14 Nov 2026 18:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794682550;
	bh=36B4eOzVLwpj7Lqu3/UNfQHE6wNxoBrRS0PSkV8wVp8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hbkp6+tB9rXRGZ0+XO9hcqCh9pBAolt8+q/hoMjgTghVJR3f4pY6zPocDQQcoSmC3
	 3vhZ4n2Qp8A8JT2IpsEKfMrMhje5GcbCITnTfUW1DBFmanr+f3FllWAkBxoegWgvyQ
	 zggVaGmY9zdil50bxiO0s+ChqiifStMTS22qD0bnpdLmsxQb09Q85Zi0qm5XJlZRcq
	 4QCp9iv10Zeyy5fMeuZ2pzOyfQnIp0uTPXL2XBzIbFSmr4HC4D+jvM/txUPU4AT208
	 DxVcNsEmG6aTxVoBa5YK4Feb1qe/Y2BsXmBx+x5uGOHtTx6bTzJ8tfvo3/hZu2feAL
	 FJJx4cQSe20Rw==
Message-ID: <sashiko-outbox-214921@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] HID: intel-thc-hid: intel-ipts: bring up the
 port
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261114183624.2379573-2-emfox@debian.org>
References: <20261114183624.2379573-1-emfox@debian.org>
 <20261114183624.2379573-2-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 18:55:49 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] HID: intel-thc-hid: intel-ipts: divisor 3 misses 41MHz gear
  in thc_ipts_spi_from_cfg()
--

commit d50186feb31fcf2b785998e4fb096fab0deec70b
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-ipts: bring up the port

This commit adds a PCI port driver for Intel Touch Host Controller ports in
IPTS mode, reading the controller configuration block over PIO and applying
SPI timing to enable the touch engine.

> diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c b/drivers/hid/in=
tel-thc-hid/intel-ipts/ipts.c
> new file mode 100644
> index 0000000000000..264479630ff6e
> --- /dev/null
> +++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
[ ... ]
> +static void thc_ipts_spi_from_cfg(struct thc_ipts *idev, u32 *hz, u32 *m=
ode)
> +{
> +	u32 cfg =3D le32_to_cpu(idev->cfg.spi_cfg);
> +	u32 div =3D THC_IPTS_SPI_CLKDIV(cfg);
> +
> +	if (!div) {
> +		/* Nothing valid asks for this; use the slowest gear. */
> +		dev_warn_once(idev->dev, "controller asks for divisor 0\n");
> +		*hz =3D THC_IPTS_SPI_MIN_HZ;
> +	} else {
> +		*hz =3D THC_IPTS_SPI_BASE_HZ / div;
> +		if (cfg & THC_IPTS_SPI_CLKDIV8)
> +			*hz /=3D THC_IPTS_SPI_CLKDIV8_DIV;
> +	}
> +
> +	if (*hz < THC_IPTS_SPI_MIN_HZ) {
> +		dev_warn_once(idev->dev,
> +			      "controller asks for %u Hz, slowest is %u Hz\n",
> +			      *hz, THC_IPTS_SPI_MIN_HZ);
> +		*hz =3D THC_IPTS_SPI_MIN_HZ;
> +	}
[ ... ]
> +int thc_ipts_port_start(struct thc_ipts *idev)
> +{
[ ... ]
> +	thc_ipts_spi_from_cfg(idev, &hz, &mode);
> +	ret =3D thc_ipts_spi_set(idev, hz, mode);
> +	if (ret) {
> +		dev_warn(idev->dev,
> +			 "cannot follow the SPI timing, going slow\n");
> +		ret =3D thc_ipts_spi_set(idev, THC_IPTS_BOOT_SPI_HZ,
> +				       THC_SINGLE_IO);
> +		if (ret)
> +			return ret;
> +	} else {
> +		dev_dbg(idev->dev, "SPI clock asked for %u Hz, rounded down\n",
> +			hz);
> +	}

[Severity: Medium]
Does THC_IPTS_SPI_BASE_HZ / div miss the 41 MHz gear when the controller
requests divisor 3?

With THC_IPTS_SPI_BASE_HZ set to 125000000, integer division by 3 yields
41666666 Hz, which is 34 Hz below THC_SPI_FREQUENCY_41M (41666700):

drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c:thc_spi_read_config() {
    ...
	/* 10M, 35M and 50M CLK need 1.5, 3.5 and 2.5 half divider */
	if ((freq_div =3D=3D THC_SPI_FRQ_DIV_2 && spi_freq_val >=3D  THC_SPI_FREQU=
ENCY_50M) ||
		(freq_div =3D=3D THC_SPI_FRQ_DIV_3 && spi_freq_val <  THC_SPI_FREQUENCY_4=
1M) ||
		(freq_div =3D=3D THC_SPI_FRQ_DIV_1 && spi_freq_val <  THC_SPI_FREQUENCY_1=
5M)) {
		regmap_write_bits(dev->thc_regmap, THC_M_PRT_SPI_DUTYC_CFG_OFFSET,
				  THC_M_PRT_SPI_DUTYC_CFG_SPI_TCRF_HALF_DIV_EN,
				  THC_M_PRT_SPI_DUTYC_CFG_SPI_TCRF_HALF_DIV_EN);

		regmap_write_bits(dev->thc_regmap, THC_M_PRT_SPARE_REG_OFFSET,
				  THC_M_PRT_SPARE_REG_SPI_CLK_INV_ENABLE,
				  THC_M_PRT_SPARE_REG_SPI_CLK_INV_ENABLE);
    ...
}

Because 41666666 < THC_SPI_FREQUENCY_41M, thc_spi_read_config() and
thc_spi_write_config() program the 3.5 half-divider (35.7 MHz) with SPI
clock inversion enabled instead of plain divisor 3.

Also, because thc_ipts_spi_from_cfg() clamps *hz to at least
THC_IPTS_SPI_MIN_HZ (7812500), thc_get_spi_freq_div_val() never returns
THC_SPI_FRQ_RESERVED, making the error fallback in thc_ipts_port_start()
unreachable.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114183624.2379=
573-1-emfox@debian.org?part=3D1
