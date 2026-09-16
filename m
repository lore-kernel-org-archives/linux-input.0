Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F503546D6;
	Wed, 16 Sep 2026 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789570168; cv=none; b=cpoKGcGwZfZ6BEgTQkZYTpfaHXjlXn9i61whVdiPfG0UVZbbXzRDuNgaAdESWMK9OcL8kYanFJW2vo0D+9jFfbGOW7WfQo+JWpAu+xFOVUGsQzfoSuGS2u4UGCBIUVqaKNgYsFXZgILAmp4lE/DOHqe72lAGEmpWa08oUfTDKd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789570168; c=relaxed/simple;
	bh=kKf8q40ivlUve7sk8VUJ8prieyyC82f9wIB0uY5g3v4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ahTlH5x0ly1Gr8go4lIR1KA0AtMpdbzwgysku4GhB7FjLQ5MOwMtf46Wngv8HIkF4hBdc+iglgwOL6TEjEb3hbJzeiqfyJrdX4PWwuQtjN/dL+3s6hj6tAnSgp2y8D8kFVGB7SNntn3V6s/6c0NQYA51A2RXB7l2Ra+zg9TJrtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3J6kFAc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3J6kFAc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67BA1F00898;
	Wed, 16 Sep 2026 14:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789570166;
	bh=uihw067Bjjkxp+tfN4OE3iIGmuUHKnGVX8YN0FWRMbo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n3J6kFAcDjpT+D2Od4dyZNn95WhwUA7DSNsPtz6Zt64NhkXMUeEUSD4ZXdHpP/SFh
	 Lr0NXeiTKM0BYpSVcvB7sUjdv/mc4gV8cJv2jgP1FjNnljpEKjiEwVReomTYyv9hAj
	 xq3uFLSo4HuFWmc9pCwHBqHFLjjviBcIrJJdJq2hjrz0UtHc59whjOjdh2jx0h16bF
	 +UtC+sdPFXMxYNp7FDotv9XLtovltrwxKNdnjeP7no0QPomTmJx4dyG0K8lfmbrZZg
	 Hd9c5gxr9rIn0gJxHXLo4H/arO7jRCzkQxvjxGTME3lyuN3i40anjKbzdV++n7dDwE
	 7Z9XdrRT2emSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 17/19] arm64: dts: qcom: Add initial support for
 MSM8952
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: robh@kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org, mfd@lists.linux.dev, lee@kernel.org, dmitry.torokhov@gmail.com, linux-clk@vger.kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260916-msm8952-initial-support-v2-17-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-17-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:49:25 +0000
Message-Id: <20260916144925.E67BA1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] dt-bindings: msm8952: truncated GIC memory map breaks virtualizati=
on and GICC_DIR
- [High] dt-bindings: msm8952: cpu cooling maps bound to hot trips bypass t=
hrottling
--

commit 73b8bd2eec3d6e15eddbef720325773b07756c99
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

arm64: dts: qcom: Add initial support for MSM8952

This commit adds initial support for the MSM8952 SoC. It introduces the
device tree source file covering core components like CPUs, RPM, MDSS,
USB, pinctrl, and basic thermal zones.

Link: https://github.com/Asderdd/android_kernel_generalmobile_shamrock/blob=
/cm-14.1/arch/arm/boot/dts/qcom/msm8952.dtsi
Link: https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-w=
ear-7.0.0_r0.3/arch/arm/boot/dts/qcom/msm8952.dtsi
Link: https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-w=
ear-7.0.0_r0.3/drivers/thermal/msm-tsens.c#1621

> diff --git a/arch/arm64/boot/dts/qcom/msm8952.dtsi b/arch/arm64/boot/dts/=
qcom/msm8952.dtsi
> new file mode 100644
> index 0000000000000..a73032f75a8b7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8952.dtsi
[ ... ]
> +		intc: interrupt-controller@b000000 {
> +			compatible =3D "qcom,msm-qgic2";
> +			interrupt-controller;
> +			#interrupt-cells =3D <3>;
> +			reg =3D <0x0b000000 0x1000>,
> +			      <0x0b002000 0x1000>;
> +		};

[Severity: High]
Does this node omit the GICH and GICV mappings along with the maintenance
interrupt?=20

Additionally, the CPU interface size at 0x0b002000 appears to be truncated =
to
0x1000 instead of 0x2000. Mapping only 0x1000 bytes for the CPU interface
prevents access to the GICC_DIR register, which breaks interrupt deactivati=
on
if the kernel uses EOI mode 1.=20

Without the 0x2000-sized CPU interface mapping and the missing GICH/GICV
regions and maintenance interrupt, KVM initialization will fail and guest V=
Ms
cannot run.

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
Are these cooling maps binding to the correct trip points?=20

The cooling device is bound to cpu4_alert1, which is a hot trip point. The
kernel thermal governors (like step_wise or power_allocator) explicitly ign=
ore
THERMAL_TRIP_HOT trips for cooling device actuation. Cooling maps must be
bound to passive or active trips to invoke throttling.=20

By binding to a hot trip instead of the alert0 passive trip, the CPUs will
never be thermally throttled, allowing the system to overheat until it hits
the critical trip and forcefully shuts down.

[ ... ]
> +		cpu0-3-thermal {
> +			polling-delay-passive =3D <250>;
> +
> +			thermal-sensors =3D <&tsens 9>;
> +
> +			cooling-maps {
> +				map0 {
> +					trip =3D <&cpu0_alert1>;
> +					cooling-device =3D <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +
> +			trips {
> +				cpu0_alert0: trip-point0 {
> +					temperature =3D <75000>;
> +					hysteresis =3D <2000>;
> +					type =3D "passive";
> +				};
> +
> +				cpu0_alert1: trip-point1 {
> +					temperature =3D <85000>;
> +					hysteresis =3D <2000>;
> +					type =3D "hot";
> +				};

[Severity: High]
Does this face the same throttling issue as cpu4-thermal?=20

Binding the cpu0-3 cluster to the cpu0_alert1 hot trip point will also bypa=
ss
thermal throttling for these CPUs, resulting in unmanaged heating until a
critical thermal shutdown is triggered.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D17
