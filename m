Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794123640;
	b=XemgfIqc2/ikWkfJFnJR1ft7f52pft6PrFqgsz3eOFGeeNcxpKfVgKS5U1N1TM/u9VMR
	 ndamYNH0+jV3O0G+iAOnYdnpSE54MLioBOn87UGrfP8pfmNkXTvl161VsnLzzA9gh1hUI
	 baTnPYQIhDG/eELlrgbHyFdJDTaHgHtm8cYtSsp/lbnqeAbZg4k3preT0RVm2RbaWCGlG
	 179PnLL7X2l75AEfCp/vvZADITjsJUxROunSYMFmcWIdooRHsTwHOhMu9z6e+s1nzAnzj
	 Frjxm6A7/ACvxvnaF+YGJX3e/TSgKnanRE2rq+1wSBHsJ8ToZhrmFGFhh8cUz3hKVVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794123640;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AR4cUy9xsPoPS7nt98pkg3PkAnjW20K1vGcyHgflvns=;
	b=GffrarjGMcMnozAErH9M52AG3RXCR3x90UKrVJ0h/m6xOaRObW54r6ll7B7Rl4OJ44+k
	 X2N/awC+pZdPpLIsIFCXCEaEOAEChP68fmSHFJqH476E7xH5N5nMGW5d9Bf5UzrTNxQZc
	 2m6XZB6V5BoyYd1baMKiC9bgnh/S3zgNDdKVmvGKxZl8oHLgpRVYle6QlI9bgej2lRLUC
	 SdoUHqtA95HD+LJUsRAwnzpxo0J4CxoszB83DLS3ArLQVLoRpaTnM48gs2eb1fpKicZFs
	 VgUMeYqT4XL4TorTlAnxsSV/SGqVyph5EgGiVSCRjcinskVlEkAfZkCz9OchyVj5k4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e7x+DcDg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04721606A31C;
	Sun,  8 Nov 2026 07:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e7x+DcDg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBA21F0089F;
	Sun,  8 Nov 2026 07:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794123639;
	bh=AR4cUy9xsPoPS7nt98pkg3PkAnjW20K1vGcyHgflvns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e7x+DcDg49QMR0b0a7EwOuSvEhJ0qiyPK/ltuTU2L+Dp6L1b7nqgZeeu3O2i9vv6H
	 Pp4IDfa8xqgIP6L9QVqKQRO7ttUTHSnSVSB0D5yBiqt0AHdakOwliK2CFhwf92zqB1
	 4U0etWOhOOslxee3pa/0Iq/fUZn+k7LPMjOV3L5EAfYEPjwaC8GYFalQsUTLY5ld+L
	 b6LXM+OAb0Lz35JqilTox04yA+5VKlEsNBdbXCOfn8l4PfdG1ey3yrvDVRxwxyrDSz
	 y1ad0iHiVo0VAuJuDFKa83xoARchESflU8Y0KhLYBbrDa6IWs0EaABUnleTVrUWBjw
	 lUqNkRe6SYunA==
Message-ID: <sashiko-outbox-203632@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/8] arm64: dts: apple: Add MTP DockChannel HID nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Reeves" <michael.reeves077@gmail.com>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261108-b4-apple-mtp-keyboard-v5-7-e2c97b82669a@gmail.com>
References: <20261108-b4-apple-mtp-keyboard-v5-0-e2c97b82669a@gmail.com>
 <20261108-b4-apple-mtp-keyboard-v5-7-e2c97b82669a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 07:40:38 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] arm64: dts: apple: undocumented mtp_mbox and mtp_dart
  compatibles on M3 SoCs
- [Low] arm64: dts: apple: MTP nodes violate ascending unit-address
  sorting order
--

commit c67685ca53359623ed7c777d5acba1746d1c1301
Author: Michael Reeves <michael.reeves077@gmail.com>

arm64: dts: apple: Add MTP DockChannel HID nodes

This commit adds disabled MTP ASC mailbox, DART IOMMU, DockChannel
mailbox, and DockChannel HID device tree nodes for Apple M2 and M3 SoCs.

> diff --git a/arch/arm64/boot/dts/apple/t6030.dtsi b/arch/arm64/boot/dts/a=
pple/t6030.dtsi
> index 524e532830e20..15c102758097b 100644
> --- a/arch/arm64/boot/dts/apple/t6030.dtsi
> +++ b/arch/arm64/boot/dts/apple/t6030.dtsi
> @@ -492,6 +492,53 @@ wdt: watchdog@3642b0000 {
>  			interrupts =3D <AIC_IRQ 480 IRQ_TYPE_LEVEL_HIGH>;
>  		};
> =20
> +		mtp_mbox: mbox@37a408000 {
> +			compatible =3D "apple,t6030-asc-mailbox", "apple,asc-mailbox-v4";
> +			reg =3D <0x3 0x7a408000 0x0 0x4000>;
> +			interrupt-parent =3D <&aic>;
> +			interrupts =3D <AIC_IRQ 953 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 954 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 955 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 956 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names =3D "send-empty", "send-not-empty",
> +					  "recv-empty", "recv-not-empty";
> +			#mbox-cells =3D <0>;
> +			status =3D "disabled";
> +		};
> +
> +		mtp_dart: iommu@37a808000 {
> +			compatible =3D "apple,t6030-dart", "apple,t8110-dart";

[Severity: Low]
Are the M3-family compatible strings in mtp_mbox and mtp_dart documented
in the binding schemas?

Running make dtbs_check fails because apple,t6030-asc-mailbox,
apple,t6031-asc-mailbox, and apple,t8122-asc-mailbox are not listed in
Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml, and
apple,t6030-dart, apple,t6031-dart, and apple,t8122-dart are not listed in
Documentation/devicetree/bindings/iommu/apple,dart.yaml (the same applies
to t6031-die0.dtsi and t8122.dtsi below).

> +			reg =3D <0x3 0x7a808000 0x0 0x4000>;
> +			interrupt-parent =3D <&aic>;
> +			interrupts =3D <AIC_IRQ 937 IRQ_TYPE_LEVEL_HIGH>;
> +			#iommu-cells =3D <1>;
> +			status =3D "disabled";
> +		};
> +
> +		mtp_dockchannel: mailbox@37ab14000 {
> +			compatible =3D "apple,t6030-dockchannel", "apple,t8112-dockchannel";
> +			reg =3D <0x3 0x7ab14000 0x0 0x4000>,
> +			      <0x3 0x7ab30000 0x0 0x4000>,
> +			      <0x3 0x7ab34000 0x0 0x4000>;
> +			reg-names =3D "irq", "config", "data";
> +			interrupt-parent =3D <&aic>;
> +			interrupts =3D <AIC_IRQ 939 IRQ_TYPE_LEVEL_HIGH>;
> +			#mbox-cells =3D <0>;
> +			apple,irq-index =3D <1>;
> +			status =3D "disabled";
> +		};
> +
> +		mtp_hid: hid@37a400000 {
> +			compatible =3D "apple,t6030-dockchannel-hid", "apple,t8112-dockchanne=
l-hid";
> +			reg =3D <0x3 0x7a400000 0x0 0x4000>,
> +			      <0x3 0x7ac00000 0x0 0x100000>;
> +			reg-names =3D "asc", "sram";
> +			mboxes =3D <&mtp_mbox>, <&mtp_dockchannel>;
> +			mbox-names =3D "asc", "dockchannel";
> +			iommus =3D <&mtp_dart 1>;
> +			status =3D "disabled";
> +		};
> +
>  		pinctrl_smc: pinctrl@36c820000 {

[Severity: Low]
This isn't a bug, but the new MTP nodes are out of unit-address order,
which triggers dt-check-style child-address-order warnings.

In all five files, mtp_hid (hid@...400000) is placed after mtp_mbox
(mbox@...408000), mtp_dart (iommu@...808000), and mtp_dockchannel
(mailbox@...b14000) despite having a lower unit address.  In t6030.dtsi,
the MTP block at 37a400000..37ab14000 is also placed before
pinctrl@36c820000 and pinctrl@374824000, and in t6031-die0.dtsi the MTP
block at 2ac400000..2acb14000 is placed after serial@391200000 instead of
between pinctrl@2a4820000 and i2c@391010000.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-b4-apple-m=
tp-keyboard-v5-0-e2c97b82669a@gmail.com?part=3D7
