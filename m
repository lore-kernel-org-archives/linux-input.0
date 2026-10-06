Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429043BB689;
	Tue,  6 Oct 2026 12:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791289784; cv=none; b=mm8Q+KW9AqneQT16CSWh7TopX0qFbYIoFheiU7EaFcVme6/OBtJEuMbTCHqFjeBVabGHBqq8Vs/WFf2nDaKHnHwovnbbbYhvu7xepfgK6i9mtwwfvhVQHVSx5FmPE7CBjv6mwkhHexU2CNxHs6UL8JeE2GYmUAzNuU2+lJ0CalU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791289784; c=relaxed/simple;
	bh=bz9uO39+brldwL3w2unJUv7dgWzYbEOwsevD/XhEGGU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O1oC+rlIyvB9MshqAuJvAN5fo58ROdY3U+2mMxeIZh1hs4pyp5+FKaxzd3x41PYdX1NRHGaQyVRUO5fvqsCQp9+YEq+r++QRpIv6bGUP+OmFZbiPfPIAkzdQCVHt62tXqlTlZixBLGYA8MmiA6Jv2Liftq6cYvwDmChShRI9Hfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1H7L/DN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1H7L/DN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9D71F00898;
	Tue,  6 Oct 2026 12:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791289783;
	bh=ZOh5OTWnSCQB/+F8H88uuXhggtOk0rAjX6imCxMvRRo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A1H7L/DNsai31xGm9ryDxf/yMrq+cFB3RDKLf7I9Ny338XG1StmmIfdUxC6ck7QC8
	 jc2JPoQs/C3WAXbCwzK7g52ejxpl3DeSwg3tcxnQtn5dP7pFQ+5rDETSsmAiCe8xfu
	 mqBBtoeLVIOGgBMkjXWmw28R7Sn3hzUgETX3VbGnG991NuK8qC6mLlw02ieUeaDkxX
	 37ZJMospoI36MpxzsX/gmOlK8h+zTXNxhN4X+6ynPBM0R0aEstQ/ho6qh2XwoClVEF
	 71jo1rdMkPXlwD/6vrBtN94mW5y9PMbYZXZpy8CV4Sd/kbykUbUB7MSHdIcOP6M/TT
	 G0y3W/T0vKlQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/7] arm64: dts: qcom: Add initial support for
 MSM8952
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261006-msm8952-initial-support-v4-5-ecdcc1ac620c@mainlining.org>
References: <20261006-msm8952-initial-support-v4-0-ecdcc1ac620c@mainlining.org>
 <20261006-msm8952-initial-support-v4-5-ecdcc1ac620c@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 12:29:42 +0000
Message-Id: <20261006122942.AB9D71F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] dts: qcom: cpu cooling maps bound to hot trip point bypass throttl=
ing
- [Medium] dts: qcom: l2-thermal trip points are logically inverted
--

commit c4936635298c623962f4d3f4da19ed5ec1644619
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

arm64: dts: qcom: Add initial support for MSM8952
   =20
Add initial support for MSM8952 SoC, including internal storage, MDSS,
basic Adsp remote proc, i2c/spi, Tsens, USB, and RPM support.

Link: https://github.com/Asderdd/android_kernel_generalmobile_shamrock/blob=
/cm-14.1/arch/arm/boot/dts/qcom/msm8952.dtsi
Link: https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-w=
ear-7.0.0_r0.3/arch/arm/boot/dts/qcom/msm8952.dtsi
Link: https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-w=
ear-7.0.0_r0.3/drivers/thermal/msm-tsens.c#1621

> diff --git a/arch/arm64/boot/dts/qcom/msm8952.dtsi b/arch/arm64/boot/dts/=
qcom/msm8952.dtsi
> new file mode 100644
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8952.dtsi
[ ... ]
> +		l2-thermal {
> +			polling-delay-passive =3D <250>;
> +
> +			thermal-sensors =3D <&tsens 4>;
> +
> +			trips {
> +				l2_alert0: trip-point0 {
> +					temperature =3D <50000>;
> +					hysteresis =3D <2000>;
> +					type =3D "hot";
> +				};
> +
> +				l2_alert1: trip-point1 {
> +					temperature =3D <55000>;
> +					hysteresis =3D <2000>;
> +					type =3D "passive";
> +				};
> +
> +				l2_crit: l2-crit {

[Severity: Medium]
Are these l2-thermal trip points logically inverted?

The hot trip point is placed at 50 degrees Celsius, which is lower than the
passive trip point at 55 degrees Celsius. Because a hot trip point represen=
ts
a more severe thermal condition designed to notify userspace of overheating,
while passive initiates kernel-level throttling, firing a hot trip before t=
he
passive mitigation tier can lead to premature userspace warnings.

[ ... ]
> +		cpu4-thermal {
> +			polling-delay-passive =3D <250>;
> +
> +			thermal-sensors =3D <&tsens 5>;
> +
> +			cooling-maps {
> +				map0 {
> +					trip =3D <&cpu4_alert1>;
> +					cooling-device =3D <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +
> +			trips {
> +				cpu4_alert0: trip-point0 {
> +					temperature =3D <75000>;
> +					hysteresis =3D <2000>;
> +					type =3D "passive";
> +				};
> +
> +				cpu4_alert1: trip-point1 {
> +					temperature =3D <85000>;
> +					hysteresis =3D <2000>;
> +					type =3D "hot";
> +				};

[Severity: High]
Does binding the cooling device to cpu4_alert1 bypass kernel thermal
throttling?

The cooling-maps tie the cpu cooling device to cpu4_alert1, which is
configured as a hot trip point. In the Linux thermal subsystem, the default
governors do not engage cooling devices for hot trip points, as they are
intended for userspace notification.

If the CPU hits 85 degrees Celsius, it appears throttling will not engage,
causing it to continue heating until it reaches the 110 degrees Celsius
emergency shutdown trip point and abruptly powers off the system. This patt=
ern
seems to be repeated for all other CPU thermal zones in this file.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-msm8952-in=
itial-support-v4-0-ecdcc1ac620c@mainlining.org?part=3D5
