Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEA4219E8;
	Fri, 29 May 2026 02:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780020962; cv=none; b=mTMxFau/qXHFN6P4QrwMgGqtoeYGutipxhokCI9OwUgLn2kN8lCE3cbSrzwyfl/zQSvCtpGytmiJgdHPfBwSmk0cEoYmeSGI7YCG8nfywS6gvB673yhUgEKe7yDYJAzbbhLfqRsjq8+5DpU0en1dfc6GWKTsBPo6FVfFlQ21AMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780020962; c=relaxed/simple;
	bh=GjCoKVSvXPT6XMhdo1208ATuL3DJMNp9l6ZS6PuuzvE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K2FXrwwOFzk/QlL96V7SqfLpxwNxUV6bvLCbS5agIC7CDbhTToCStYASFgHZ9sEt/CajWkSiBzLXh3U6Va7z8GfXenxD1NgM9CzyUHjSuNeAHxu9Yc4uuzKHbCbFwrgw3i2bXfGD5jUPfZk4lJbumFNpnEImynXD0x7dmxLwl0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdettnED; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdettnED"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4111F000E9;
	Fri, 29 May 2026 02:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780020960;
	bh=K6wmokOiS3Pw2guTmP3P+FzoA0B3SJRxPk3z7S3WAfY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jdettnEDVG8G9H5WFq9q5aRFK3VFfWpcJ4osbCcu44wFKrMkN0c6WhmtR0Mp1sT2B
	 kKOADI3i49rnSKUUxmR3cWSm6+91wyuILiUdXDQ/qgryqmCfJE02dBJXPCg83Ia+K6
	 7xf4kdgmSqoVm+clRLN3VQo8vUfZmAcBQwBuZ0hc6Fgjq+uVCCu4wFR/49Vxy1+UxW
	 BdgPF9UOBKLktH9ERiX5NRR4juLCkclkGzyL52JTKJx79SXAYFr6RZiCLfY+9pOhI9
	 6tu3pchDsZ0aqrCBD4wSTEXrAjjf/7EvbR2Y5hF0qXqhx4kk7P4jvfbXjne/3xMnKo
	 wOpX2PdNOIGCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: Add Microsoft Surface Pro 12in
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harrison Vanderbyl" <harrison.vanderbyl@gmail.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260529011619.9586-3-harrison.vanderbyl@gmail.com>
References: <20260529011619.9586-3-harrison.vanderbyl@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 02:15:59 +0000
Message-Id: <20260529021600.6E4111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] LDO regulators defined across PMICs c, d, e, i, and j are missing =
their corresponding parent 'vdd-lX-supply' properties.
--

commit ad40084fe87bf7f45bba2d17354ba7647d363116
Author: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>

arm64: dts: qcom: Add Microsoft Surface Pro 12in

This commit introduces the initial device tree for the Microsoft Surface
Pro 12in based on the Snapdragon X Elite platform. It enables basic
hardware support including ufs, touchscreen, display, and various
connectivity peripherals.

> diff --git a/arch/arm64/boot/dts/qcom/x1p42100-microsoft-sp12in.dts b/arc=
h/arm64/boot/dts/qcom/x1p42100-microsoft-sp12in.dts
> new file mode 100644
> index 0000000000000..983966e123e55
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/x1p42100-microsoft-sp12in.dts
[ ... ]
> +	regulators-6 {
> +		compatible =3D "qcom,pm8550ve-rpmh-regulators";
> +		qcom,pmic-id =3D "i";
> +
> +		vdd-l1-supply =3D <&vreg_s4c_1p8>;
> +		vdd-l2-supply =3D <&vreg_s5j_1p2>;
> +		vdd-s1-supply =3D <&vph_pwr>;
> +		vdd-s2-supply =3D <&vph_pwr>;

[Severity: High]
Are we missing the parent supply properties (such as vdd-l3-supply) for the
ldos defined across pmics c, d, e, i, and j?

Without linking these child ldos to their active parent buck converters on =
this
board (for example, vreg_s1i_0p9), the regulator core cannot track the hard=
ware
dependency hierarchy.

Because the parent buck converter has no explicitly recorded consumers in t=
he
device tree, will the Linux regulator core forcefully disable it during late
initcall as an unused regulator?

Since ldos like vreg_l3i_0p8 supply essential components such as the ufs ph=
y,
could this regression disconnect the storage and result in an unavoidable
kernel panic?

> +
> +		vreg_s1i_0p9: smps1 {
> +			regulator-name =3D "vreg_s1i_0p9";
> +			regulator-min-microvolt =3D <900000>;
> +			regulator-max-microvolt =3D <920000>;
> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> +		};
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529011619.9586=
-1-harrison.vanderbyl@gmail.com?part=3D2
