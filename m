Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C68363097;
	Mon, 21 Sep 2026 18:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015672; cv=none; b=QPKpwiomW/kXO+mY6TNH6BP2g816sKxZ7D8k8QjRlIboEb6h3x2zf4fS0ik7CZ9vDVFkUmD7XMcHvRonRHuy9zdUlJhHcZf46kSPLyjIim0zuTrge5hLxjyjENEWVoZjHefh3oTHVXn7RwQfFxnRZBpwosrVqqyMrnCuN3A9O4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015672; c=relaxed/simple;
	bh=dk3Fs0cpA0zMtsYsqShFh3dMrxoKlR07YnjThecHsb8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b4wto8oTLhS/3s7sn1hVOh7MoPeKhZlurJYSUZv7tQJpyx7lqnjqycob61YCMGpgkuFYYOh2jRq1t7YVFUe4iUml9h+y8LfF7l5I+AHTeToLb77PhRHTR3auWY3oNkQQRv+bQfYop7FF09Ho8qLMyKwavxVRX1bYfflPAdexNXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTOq6PM4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTOq6PM4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFBD1F000FF;
	Mon, 21 Sep 2026 18:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790015670;
	bh=K4nLHz9z6IQcGHmWPtSRGWzAX0Kugw/YmY22EH4TG4U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LTOq6PM4Loabuc4O1F5tiDkMymp923XxpCeXQVC3Ws1Wh+dVWju63c3jIr/bjfko2
	 o29Fbf1Me9nKgxu+hrpmzZ+n2Y0Xyy9l5SPmJd6pvqy/N1+rSrtFYegX1TcADLU59N
	 CtxuHex76kAXhFKDdNju2kSA/6QG382zkaKzHIxdrohNZENt7oW2rtYtmVUsDthOSX
	 LSnEZu5gGgTPPWcTUdt2hSofd/bAEUZvGD3ZeIzfmcxTzOJdezmdLsoL+rM0ZknDku
	 mOoi5ICWkT0GTosv/hzygADQuXkw52WgMGDt1VQKBzCG3z7WqAQGS56/uhLVzRVgR6
	 LYK1YzkmWuzmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 17/19] arm64: dts: qcom: Add initial support for
 MSM8952
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, mfd@lists.linux.dev, lee@kernel.org, linux-input@vger.kernel.org, robh@kernel.org, dmitry.torokhov@gmail.com, conor+dt@kernel.org
In-Reply-To: <20260921-msm8952-initial-support-v3-17-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-17-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:34:29 +0000
Message-Id: <20260921183429.DAFBD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] arm64: dts: qcom: cpu cooling devices bound to 'hot' instead of 'p=
assive' trip points
--

commit b31c2ca10f75d0572d43b7d8403a096fd44b8429
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>
arm64: dts: qcom: Add initial support for MSM8952

Adds initial device tree support for the MSM8952 SoC, porting it from a
downstream reference and adding calculation support for qfprom nodes.

Link: https://github.com/Asderdd/android_kernel_generalmobile_shamrock/blob=
/cm-14.1/arch/arm/boot/dts/qcom/msm8952.dtsi
Link: https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-w=
ear-7.0.0_r0.3/arch/arm/boot/dts/qcom/msm8952.dtsi
Link: https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-w=
ear-7.0.0_r0.3/drivers/thermal/msm-tsens.c#1621

> diff --git a/arch/arm64/boot/dts/qcom/msm8952.dtsi b/arch/arm64/boot/dts/=
qcom/msm8952.dtsi
> new file mode 100644
> index 0000000000000..fa343271a0249
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8952.dtsi

[ ... ]

> @@ -0,0 +1,2696 @@

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

[Severity: High]
Does this cooling map bind to the hot trip point instead of the passive one?

The Linux thermal subsystem's default step_wise governor ignores hot and
critical trip points for cooling devices. Binding CPU frequency cooling
devices to cpu4_alert1 (which is defined as type hot) completely prevents
thermal throttling.=20

Under sustained CPU load, the system will keep heating up until it hits the
critical trip point and undergoes a hard, uncontrolled thermal shutdown.=20
Should this bind to cpu4_alert0 instead?

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

[Severity: High]
Similarly for the little core cluster, does this also incorrectly bind to t=
he
hot trip point cpu0_alert1? This will prevent thermal throttling on these
cores as well.

> +							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D17
