Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6F23242D8;
	Sun, 11 Oct 2026 17:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791738311; cv=none; b=IFY2kInK8gtk+FZyG0vq1qbTTn4bAQdpX1+uilOe1dN+dAzyyTjeIiqqEh6ZgU0IKvjEUzRTwCDJL2LiJSL0fqkGb9yBdV8OZV1PQ6b6H4igzJFdwwdCBG+0kKzcKtItm541QQl7fqV8Cbk8p1SYogK9a7n7rxLnzHT5CaXglv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791738311; c=relaxed/simple;
	bh=K7KF25Jg+LwJikLs2zLV/0wRog0Y3UBcUxhXgdd0r3o=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=hJtNjsNHqsR2bHfXmDzlEkdyj4kEFKvU5kWmnoKsrOVhCThD7DFZftNcdwZKjtjQoJTMdWgTRbMUVnr8EgFv7t9S/eSvaA5u10vbZlEtan7Cy67ooqdfYu5EYYzxormsgGMi/R3Qswq5jb0pZFY7fRGB9AYTh4rvy+BZ/F581Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0w/2jsK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0w/2jsK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FEC41F0089B;
	Sun, 11 Oct 2026 17:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791738303;
	bh=hrfaFFaEc84QrpMvfxT5GP7lIHWudDEUQLHon2eCjp8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C0w/2jsKW093gEV4qe50QQ3JlCgxnrM76+A+X1QabYlDTOEtJDjit8sWr9rtMdSVO
	 SeKnNv3ajQxDayt0CgrBqpqR2cGgt/iDBQKqQksvqGrS6VkLmAtqhNS7ewqBFj/NoF
	 HY5C4tjiY1j1yB1giEjxQl+nYi5wwHsTbDcp+OnspjEOFCTIeep9c7/0jRd18moLLu
	 H7HA1B+0ymu/vIP5GtvEI/gawgQXwpsdXO/AM2sZbezO9v1Zy5UYQ506vOmVIG9Xiv
	 IUtpD6HDkt6pRxzQyVpTtZ4s/XqbO/reHWy4GqgZ5naL/kZBZ+Tv4ancMAVhXNXYyQ
	 ciCyl8xUsbTdA==
Message-ID: <sashiko-outbox-167332@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/7] arm64: dts: qcom: generalmobile-shamrock: new
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: dmitry.torokhov@gmail.com, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20261011-msm8952-initial-support-v5-7-1857074992ec@mainlining.org>
References: <20261011-msm8952-initial-support-v5-0-1857074992ec@mainlining.org>
 <20261011-msm8952-initial-support-v5-7-1857074992ec@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 17:05:02 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] arm64: dts: missing status=3D"okay" for blsp1_uart2 console
- [Medium] arm64: dts: missing status=3D"okay" for primary usb controller
--

commit d4818cfa8bc0f829c17bbc9440ca720d3616017e
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

arm64: dts: qcom: generalmobile-shamrock: new device

Add General Mobile Shamrock (GM 5 Plus). Shamrock is designed similar to
L9300.

> diff --git a/arch/arm64/boot/dts/qcom/msm8952-generalmobile-shamrock.dts =
b/arch/arm64/boot/dts/qcom/msm8952-generalmobile-shamrock.dts
> new file mode 100644
> index 0000000000000..9114b232cb1bb
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8952-generalmobile-shamrock.dts
[ ... ]
> +	aliases {
> +		mmc0 =3D &sdhc_1; /* SDC1 eMMC slot */
> +		mmc1 =3D &sdhc_2; /* SDC2 SD card slot */
> +		serial0 =3D &blsp1_uart2;

[Severity: High]
This defines the serial alias for the console in the aliases node, but the
target node is never enabled in msm8952-generalmobile-shamrock.dts.

The blsp1_uart2 node defaults to status =3D "disabled" in the upstream
msm8952.dtsi and is never overridden to status =3D "okay" in this board fil=
e.

Will this cause the serial console to fail to probe, breaking standard seri=
al
output and early debugging?

> +	};
[ ... ]
> +&blsp2_i2c1 {
> +	status =3D "okay";
> +
> +	/* FUSB301 @25 USB-C Controller */
> +
> +	tpa6130a2: audio-controller@60 {
> +		compatible =3D "ti,tpa6130a2";
> +		reg =3D <0x60>;
> +		pinctrl-0 =3D <&tpa6130a2_default>;
> +		pinctrl-names =3D "default";
> +		power-gpio =3D <&tlmm 61 GPIO_ACTIVE_HIGH>;
> +		Vdd-supply =3D <&pm8950_l22>;
> +	};
> +
> +	tusb320: usb@67 {
> +		compatible =3D "ti,tusb320";

[Severity: Medium]
A Type-C port controller is instantiated here in blsp2_i2c1, clearly indica=
ting
USB functionality is present on this device.

However, the overarching &usb controller node is left disabled (its default
state in msm8952.dtsi).

Without enabling the main USB controller node with status =3D "okay" in
msm8952-generalmobile-shamrock.dts, will USB data communication remain
completely broken?

> +		reg =3D <0x67>;
> +		interrupts-extended =3D <&tlmm 45 IRQ_TYPE_EDGE_FALLING>;
> +	};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-msm8952-in=
itial-support-v5-0-1857074992ec@mainlining.org?part=3D7
