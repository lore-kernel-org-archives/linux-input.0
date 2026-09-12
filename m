Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2303546E1;
	Sat, 12 Sep 2026 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789203492; cv=none; b=L4lBY1+hUWK0w9TZSAWTIenuHsAisYtdQoGC/zBjg+cFs+SSbeKju6b5j5pA8pQUGn8ymIyp+1kgZu8KAvN0QDE/cQFFF1Frsncg8hT+ouC7zdo49dGoLA4MLVxYctmkKVsBEwpXOyzdOlJ6ChBvrtKWk+S+NJVxErvbv5+7ul8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789203492; c=relaxed/simple;
	bh=K8qHF5qNICeiV6jSXPOCn+t7fdtbTn6DYDkNhvxEZ8E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vssl0GQizzKzUfoBTALPffonwlShBOoXPsft9M3x8Es/lWH3QW6RajJchuR7IJ/onWhpZkFDIdjjDlABjjo3dubRVjucV5ycxYqTgVYc7melyVXMFgoa+EBSbKKoaP1PHcyNmjxk+JpY4vwnXrU8SuAMyMCpE76ugNwAmeCb6Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awiRR9Ri; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awiRR9Ri"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4EB1F000FF;
	Sat, 12 Sep 2026 08:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789203490;
	bh=ElyScURSqKHzWipX5rz4e/wUiRCnwlf8fg+wqO/8Ue4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=awiRR9RiKX0hTuLblNZe1l9JU+owt7BN/s0fFm0dNxszDmBsyzSnkHII8swk2gSAV
	 XcM8leM9Eao22zUOk8CIuGX99uAwuUNXXnQdKXqCbY8yJaSURCIpWe/U/k6IP3Kg5x
	 n0c0IMmWRzoYev+VPk+dbyJQS/2/FF0gr5qLqnTnnIVgtUDCpm8zx1ik9Zi2ueQ7H3
	 V2W8ABfJrhUqkc7lxq+EBpsag4JW7FYLjpsn7ZDC7bAyOzhk4mrWnkkzbxhxfYDTuw
	 lijMTuz18TY/v+B5fwv0wtVE06t/Sf6EVnxf3Az4ahtynUuIFRP3RhcMnT/KL1/Hxu
	 yYszHXmHl8R2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 20/20] arm64: dts: qcom: generalmobile-shamrock: new
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: lee@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org, linux-clk@vger.kernel.org, mfd@lists.linux.dev, robh@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260912-msm8952-initial-support-v1-20-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-20-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:58:09 +0000
Message-Id: <20260912085810.4D4EB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Hardware Interrupt Polarity: TUSB320 interrupt is configured as =
IRQ_TYPE_EDGE_RISING, but the INT_N pin is active low / open drain.
- [Medium] Hardware GPIO Polarity: SD card detect (cd-gpios) is configured =
as GPIO_ACTIVE_HIGH.
- [Low] DT Binding Violation: tpa6130a2 node uses 'power-gpios' instead of =
'power-gpio'.
--

commit 3d5d5ba8ff3606c0a6ed8dba09661107776c63ef
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

arm64: dts: qcom: generalmobile-shamrock: new device

This commit introduces support for the General Mobile Shamrock (GM 5 Plus)
device, which is based on the MSM8952 SoC. The design is similar to the
L9300 reference board.

[1] https://github.com/Asderdd/android_kernel_generalmobile_shamrock/blob/c=
m-14.1/arch/arm/boot/dts/qcom/msm8952-l9300.dtsi

> diff --git a/arch/arm64/boot/dts/qcom/msm8952-generalmobile-shamrock.dts =
b/arch/arm64/boot/dts/qcom/msm8952-generalmobile-shamrock.dts
> new file mode 100644
> index 0000000000000..22723b62d3d6c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8952-generalmobile-shamrock.dts

[ ... ]

> +&blsp2_i2c1 {
> +	status =3D "okay";
> +
> +	/* FUSB301 @25 USB-C Controller */
> +
> +	tpa6130a2: tpa6130a2@60 {
> +		compatible =3D "ti,tpa6130a2";
> +		pinctrl-0 =3D <&tpa6130a2_default>;
> +		pinctrl-names =3D "default";
> +		reg =3D <0x60>;
> +		power-gpios =3D <&tlmm 61 GPIO_ACTIVE_HIGH>;

[Severity: Low]
Does this violate the ti,tpa6130a2 device tree binding schema?

The schema explicitly expects the singular power-gpio property. Using
power-gpios will cause a schema validation error during dtbs_check.

> +		Vdd-supply =3D <&pm8950_l22>;
> +	};
> +
> +	tusb320: tusb320@67 {
> +		compatible =3D "ti,tusb320";
> +		reg =3D <0x67>;
> +		interrupts-extended =3D <&tlmm 45 IRQ_TYPE_EDGE_RISING>;

[Severity: Medium]
Is the interrupt polarity configured correctly for the tusb320 node?

The hardware specification indicates the INT_N pin is an open-drain,
active-low output. Using IRQ_TYPE_EDGE_RISING might cause the interrupt to
deadlock and be missed upon USB plug or unplug events, as the SoC expects a
rising edge rather than a falling edge.

[ ... ]

> +&sdhc_2 {
> +	cd-gpios =3D <&tlmm 67 GPIO_ACTIVE_HIGH>;

[Severity: Medium]
Should the SD card detect cd-gpios be configured as active low?

Standard SD slots typically use a normally-open active-low switch that
shorts to ground upon insertion. Configuring this as GPIO_ACTIVE_HIGH might
result in inverted card detection logic where the OS reports the card as
inserted when it is actually empty.

> +	vmmc-supply =3D <&pm8950_l11>;
> +	vqmmc-supply =3D <&pm8950_l12>;
> +
> +	status =3D "okay";
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D20
