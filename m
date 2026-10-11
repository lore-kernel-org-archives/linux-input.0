Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DF6352018;
	Sun, 11 Oct 2026 17:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791738331; cv=none; b=CYVfbrLdaPqV8BLVEOXJuw+TacPmgQDlXZqBywUipM12/P3XiETfH2qLkNYyR4Ancl0AFo8KubkZn0HleoLeqgJgmqNrSsNJZex8/rMbHJVFCzoUg44yvAUYuNKQ5bzzNqhFh1xmznHJhN7ktDd7MeGYjl/hONVvgjFy22CMFyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791738331; c=relaxed/simple;
	bh=mb1pfsKStAtOWi0JjAKyCXnmZ4JpO6beOtEbcuGKXOE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Bx37sNFpjOh9n2RALg+FZZU9kMpSnIxEGo1Ap7Zkxf+EhXVyyyANifg3B1EKz5VFIt/3hSiKQBdxdM11PZ+pwUxeHJlpVLYFtY0dLR15ljv3qrrwtwHUpXq1qjTbH9ocmQAApc0BLCJn4GDD6c138ihy/GuoFZV9AAx70Le9Ivk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDt/J8kE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDt/J8kE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E97E1F0089B;
	Sun, 11 Oct 2026 17:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791738324;
	bh=bSbnPJwXPaMgLz/4E+GvY9XRN2SpViYwTCmV9XCwNV4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XDt/J8kEoThMhx2nRDKuifvoYftN9R9h41zBlt2fNUFJLzWPqAtFEpx3KWKxnn1Nh
	 +inmqlsZekPUKYhadK25q5NBz+aWYSN4DnpMDv1LCWsAVrYg/Rg3HAD/ZG6eAiDIbg
	 mZTy17BtFCeVkFWkiy/gnV+XK0ypcooPsmqLj3FGMLSoohyU+8exyzKpX5DcdhFsiM
	 RtR+RvrYYPFrIPHAAlnWYPpqMVL3pAMEXTNNfjXZyOFpHRTwJpWQW7rqCEz2caKB+E
	 6z4ewUAM1ZCuHvz/kenxOQqDGXokpxsjGV/nr9yns8ST+8IuTR+/9e97WdjR8tlIjO
	 iWVsOd+Wcv9Ug==
Message-ID: <sashiko-outbox-167333@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/7] arm64: dts: qcom: Add initial support for
 MSM8952
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: dmitry.torokhov@gmail.com, conor+dt@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20261011-msm8952-initial-support-v5-5-1857074992ec@mainlining.org>
References: <20261011-msm8952-initial-support-v5-0-1857074992ec@mainlining.org>
 <20261011-msm8952-initial-support-v5-5-1857074992ec@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 17:05:23 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] dts: thermal: CPU cooling-maps improperly bound to 'hot' trip poin=
ts
--

commit cc303e4c44111ecaf69188771f4ff5a8e34c3552
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

arm64: dts: qcom: Add initial support for MSM8952

This commit adds initial device tree support for the Qualcomm MSM8952 SoC.
It introduces the base dtsi file containing CPU topology, memory maps,
system controllers, and thermal configurations.

Link: https://github.com/Asderdd/android_kernel_generalmobile_shamrock/blob=
/cm-14.1/arch/arm/boot/dts/qcom/msm8952.dtsi
Link: https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-w=
ear-7.0.0_r0.3/arch/arm/boot/dts/qcom/msm8952.dtsi
Link: https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-w=
ear-7.0.0_r0.3/drivers/thermal/msm-tsens.c#1621

> diff --git a/arch/arm64/boot/dts/qcom/msm8952.dtsi b/arch/arm64/boot/dts/=
qcom/msm8952.dtsi
> new file mode 100644
> index 0000000000000..18010f56ac5d0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8952.dtsi

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
					^^^^^^^^^^^

[Severity: High]
Will the thermal governor ignore this cooling action? Under the step_wise
governor, hot trip points are typically ignored for CPU throttling, which
might leave the CPU unprotected from overheating.

Would it be better to alter the trip point type to passive to ensure
throttling engages properly before shutdown limits are reached?

> +				};
> +
> +				cpu4_crit: cpu-crit {
> +					temperature =3D <110000>;
> +					hysteresis =3D <2000>;
> +					type =3D "critical";
> +				};
> +			};
> +		};

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
					^^^^^^^^^^^

[Severity: High]
This appears to apply the same logical pattern to the little cores thermal
zone. Since cpu0_alert1 is also defined as a hot trip point, could this
likewise fail to throttle the cluster and leave the SoC unprotected?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-msm8952-in=
itial-support-v5-0-1857074992ec@mainlining.org?part=3D5
