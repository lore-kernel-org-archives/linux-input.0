Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2082937269C;
	Mon,  7 Sep 2026 05:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788760332; cv=none; b=Bnzil2uKOUkQVZK1CYFbv6MGpzRrN42LsH7F49TrF6s8DR0NopY++kuzKd5lnCCYD2H34ptL+YZ+FMG22rP//iudXwy56FWDWbb5ERFgRnRx+J2BTZYpdmnx6+JiUqyRCeNA0zao9PYoOyy79GwT/9/vYCTKmg3iEZWw3rO8gPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788760332; c=relaxed/simple;
	bh=KqN1DtfnlsLwvCdwjOL9LhGC8cGJrAodh8BmQRnLZC8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I2UvSnlYxrVXv6p8jzml9HOQntJPV5O3idIlN6EOeZXRFRkuzCyVK8s5k8dIJD9bm7CpxSIdvYRIohnOm/E6nNjCXg3bFeWF2HwUgKjT62rl0nQTatF8BukkAgkAuofvlrSkh9wsUn8BU2/TlikEu39oMg1BEM6XspqRm9l9xXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0GszrP3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0GszrP3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789771F00A3A;
	Mon,  7 Sep 2026 05:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788760330;
	bh=+Fs12ID3gahGrm2ic/dl4aFnf8OF+Qnbl4jtoabXuBs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I0GszrP3BHgt7XhOYy8CzCvfUn4gJTQq3WRn6j2amj6fEZqXpsR0iU11FRb+3MzTp
	 X9LvS7hjtA/HbRYFjjTBhAMm7ETQEjmkkU+C0pU/cF7/CUw7vxmkmNoLoY2FZSDkxT
	 EChaRNgtS7ddQ4R8i0DbXhoSQtScZqoPB4Ob+g0i2B+wuDoePTUt6bmXQzvlJuVBrF
	 rbfM4K6OEzduooyEoVXLmuqaoeLwpbA3wgrlbSKorOF2K9tI/7wyrLthlWcVf7lVbR
	 OJ92TZmM7xa1TotolAAmZ1yFeJJTTcaOcYO+y6oVi49BxpzHIKjGUi3OVKTQm+lyFn
	 ub/9SPqggCjnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: microsoft-romulus13: enable
 touchscreen
Reply-To: sashiko-reviews@lists.linux.dev
To: fQwQf <fqwqf@fqwqf.xyz>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, robh@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <010601a07a6524b4-0bac871e-cea3-4cbe-9a33-111003dd4808-000000@ap-northeast-1.amazonses.com>
References: <20260907054339.12409-1-fqwqf@fqwqf.xyz>
 <010601a07a6524b4-0bac871e-cea3-4cbe-9a33-111003dd4808-000000@ap-northeast-1.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 05:52:10 +0000
Message-Id: <20260907055210.789771F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing Pinctrl Configuration for Touchscreen GPIOs
--

commit bbc74de3ce23fd59e3587b624f0acdca53aaf32a
Author: fQwQf <fqwqf@fqwqf.xyz>

arm64: dts: qcom: microsoft-romulus13: enable touchscreen

This commit adds the device tree node for the ITCH MSHW0468 touchscreen on
the Microsoft Surface Laptop 7. It describes the I2C controller, interrupt,
reset GPIO, and HID descriptor address to allow enumeration by i2c-hid.

> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus13.dts b/=
arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus13.dts
> --- a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus13.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus13.dts
[ ... ]
> +&i2c8 {
> +	clock-frequency =3D <400000>;
> +
> +	status =3D "okay";
> +
> +	touchscreen@34 {
> +		compatible =3D "hid-over-i2c";
> +		reg =3D <0x34>;
> +		hid-descr-addr =3D <0x0000>;
> +
> +		interrupts-extended =3D <&tlmm 38 IRQ_TYPE_LEVEL_LOW>;
> +		reset-gpios =3D <&tlmm 31 GPIO_ACTIVE_LOW>;

[Severity: Medium]
Does this node need explicit pinctrl configuration for the touchscreen GPIO=
s?

Currently, the interrupts-extended and reset-gpios properties are claimed
without a corresponding pinctrl-0 array. On Qualcomm platforms, relying on
the bootloader's initial pinmux and pinconf state can be unreliable if power
domains cycle during system suspend, potentially losing the configuration.

For an active-low interrupt line, a missing pull-up bias could cause the
pin to float and generate spurious interrupts, while a missing pinmux might
prevent the device from resuming correctly.

> +	};
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907054339.1240=
9-1-fqwqf@fqwqf.xyz?part=3D2
