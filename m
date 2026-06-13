Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC09F3C454F
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 08:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781338840; cv=none; b=Dlzym0l6Y9APhQmAsXidzJ0JArpuf/jcG6ySzSXIwNvEeL6KlKoup0QzxCASOJuTpK63DrtgGXFKgSLZcK2ovAYs8U3WfRivQw+Wc8Mg+ZMo8TosVapbri05TkdgK8Vvw1Mz83DhxQbZdSxBmFYHeKAnhrUKXRUezG1bkgRYBVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781338840; c=relaxed/simple;
	bh=sv6/e/ZTEkkgP8TdkpODVWO7G+8MZcZpFN0/dqmSQ2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=snrhwG39r58f+VRd4/RdWJqJtSMl2QeZsP6pthrAkZwRgt56+nD/7P2CoZ5B3jEAwOmPms/YCL7fFfLhSXBRXRTC3AX/uMrSZZWo94eFm+8qJUtXfOl9sQ9MQ1zE5HJ95ZIWafEJu4E7D75QsA9HEjncXyNAUWrnosjbnnDSIq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5wM6jYe; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5wM6jYe"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b915ded5so16781775e9.3
        for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 01:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781338837; x=1781943637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ud8CqUMs31Lbag+rPY0L/C65qKiCj6gLmHREZB+Ipfw=;
        b=a5wM6jYeOzlQFGFEgovDEwHqTGHDsbXcWZV95mfihKJpW1g+6dGbf91NPDWL/x5dn7
         Ny5YrLt0FRcaSK3H0YpfyXFxZOaIcPZMqQmtoIroZ2OzScgVAUtExD4+xfHxgFq3Ydvf
         FFg3+ZtpeMJq0dugsrXMifsZl+w63rxzdffm0mVhPm9hKEudK5I9b7tZfcYZvOecxhrI
         mzJjxy+WurhqhnrQVi6dyF0Tiu1WHkspFYfDvk59qoDsuGqoEe74qNEsBI9dw7iK4Xei
         OpXLDKfqiTuo1n4Tq9AqT/NjJ8o0RA8NklmHM92DHPt0D1P8kFx4xec6ag28ip5N1fqF
         uMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781338837; x=1781943637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ud8CqUMs31Lbag+rPY0L/C65qKiCj6gLmHREZB+Ipfw=;
        b=naMwU/wkCJKnR0NDkafdCIoZwSulof2oF1IBM0zVML1DtuAxot92nQIPQNfpjcHW3E
         55GAafn1rKRZFXjkwKSQgStIbaADC/OojSs2qht7coNETeFhD2z7pmUcp0oI9itbW7KH
         unUh0Ur4YIcfWLHFoY3P2BCeiwazv4kdUQZ6gJtAR0BHIWEfxOUFjgsYiNNO0Dqk3a6F
         eOd/aePXVBWdZyLpo/taAmCJqRr5r9xNDIRnqv5YSkybIcwdnYzOeZbUZZLu2kvha+XX
         tlGQoDxipHah2RTHAryuOiGz8a18qQIVb3S+Go3EwUHfeuf1BtD2gUDLgSwqWuLkCvXw
         68/A==
X-Forwarded-Encrypted: i=1; AFNElJ8MxhFsKqj5cR0rTuJ+FOBXvsbwk2ttrwAgHqHO47fy52Yn5/i1rnp9o4IzXxhlZf7LU9RqRqJV4uds6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNinkO/Q3qptV5uWO2SpLrAyiF4CIOinCZXd1No8EnHdB2qbGq
	0sjk1M9lq7u6Z16c4P3klkunRDp1kDmq15Hf5IID+phKtj5M9wQENxqA
X-Gm-Gg: Acq92OFALbomY3kX4KhJSFkZ7qGB4jnai3iu8Row1H/WeQrqDX7HFc90H6Uk+IMumQ9
	TNu9dpvq1pzmAOghOvwLwfA9vl3UfgR7cqRurPsDOlESXDFq37cWCBTtkMQB6M2MwMPPXEqV7KS
	SGeyNyp+SWpNlxHSZ67hCKhCxH81JbLQ3OkoZS6VvS7umnVqUAP22hdCT7AcBiuvXu+H/Ga2bma
	kqfqy+twKNIecBzHyxaFrcIfoK+0axHrQ1CZETNzeQ0/dBHe3pfe/RCCRXYwIuXxDHPktOT99Un
	tgEbVbb4QKZ8iJIaXJCDrpqS3mPxqc+7WmFqxohDJL9pyT7OyH3iPLpqN7yLYs6XP7hrPAta8Om
	TWit15GAr1dax1VegCDDwrG5G1WuDlnOZbDvLCpttEOz0LxhAWijqpTxvDxNhOqGnVQMXwSdmmY
	86+t8eCymCQ4c00fmHcp2VXGNcUAr5M+kWSOVFG14zAvms
X-Received: by 2002:a05:600c:c3cd:20b0:490:d3ef:fa4a with SMTP id 5b1f17b1804b1-490ec4ea4f1mr58033045e9.14.1781338837061;
        Sat, 13 Jun 2026 01:20:37 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922032ae56sm54483765e9.7.2026.06.13.01.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 01:20:36 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Hans de Goede <hansg@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Jun Yan <jerrysteve1101@gmail.com>,
 Lukas Schmid <lukas.schmid@netcube.li>,
 =?UTF-8?B?Si4gTmV1c2Now6RmZXI=?= <j.ne@posteo.net>,
 Eric Biggers <ebiggers@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Luca Weiss <luca@lucaweiss.eu>, Sven Peter <sven@kernel.org>,
 Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v4 5/7] arm64: dts: allwinner: a100: Add LRADC node
Date: Sat, 13 Jun 2026 10:20:35 +0200
Message-ID: <5lITDd8mTsaQJaoJhGu1EA@gmail.com>
In-Reply-To: <20260605070923.3045073-6-alexander.sverdlin@gmail.com>
References:
 <20260605070923.3045073-1-alexander.sverdlin@gmail.com>
 <20260605070923.3045073-6-alexander.sverdlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 5. junij 2026 ob 09:09:19 Srednjeevropski poletni =C4=8Das je Al=
exander Sverdlin napisal(a):
> A100/A133 SoCs feature a Low Rate ADC (LRADC) for Key application.
>=20
> Specs:
> - Power supply voltage: 1.8 V
> - Reference voltage: 1.35 V
> - Interrupt support
> - Support Hold Key and General Key
> - Support normal, continue and single work mode
> - 6-bits resolution, sample rate up to 2 kHz
> - Voltage input range between 0 and 1.35 V
>=20
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> ---
> Changelog:
> v4:
> - added allwinner,sun50i-a100-lradc compatible
> v3:
> - new patch
>=20
>  arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/=
boot/dts/allwinner/sun50i-a100.dtsi
> index b3fb1e0ee796..7cb06b19b5a5 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> @@ -466,6 +466,15 @@ ths: thermal-sensor@5070400 {
>  			#thermal-sensor-cells =3D <1>;
>  		};
> =20
> +		lradc: lradc@5070800 {
> +			compatible =3D "allwinner,sun50i-a100-lradc", "allwinner,sun50i-r329-=
lradc";

Break this into two lines, like usb_otg below. With that:
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej Skrabec

> +			reg =3D <0x05070800 0x400>;
> +			interrupts =3D <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&ccu CLK_BUS_LRADC>;
> +			resets =3D <&ccu RST_BUS_LRADC>;
> +			status =3D "disabled";
> +		};
> +
>  		usb_otg: usb@5100000 {
>  			compatible =3D "allwinner,sun50i-a100-musb",
>  				     "allwinner,sun8i-a33-musb";
>=20




