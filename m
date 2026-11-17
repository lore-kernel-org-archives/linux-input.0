Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920955;
	b=fhxdrfMXpWKfQc/FVm+/GNuv5+3Azz+ty5/vmWzC1Yyev5eQ6Iu2gMvgfqB/8p08DzXm
	 LQZJIrGMm+Pvqb+bFCbE+kCD33Y9CEmV3qxoW+Q9z+3DD1lAD2qr+ae6CciXrwl+STbIW
	 2eJfakjyiFVu2Gt+jvDFteckoOBWk8qk8zSG09VspK6V1y7+QlAFB4TiV+DGIfoju2vGS
	 CcFeCmD++sBYDbjKi3iKPcZ4st6rXJWkagg2kWZH5LdiUmkynEiiPvoFLDtngTo6X3vjG
	 tyj/THk6P33TiIh6KAy4bIpFrmyltH/LseWrs7P0erhlorus6LHdTeMrPitIQlpouCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920955;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tqwfXbj3ZR7mRZUcNEreZ1uIDndR1OB4dKoeTEFs4pc=;
	b=xGcFxmI8Q4L5WdyFXRXGizgqKKMSwSivXdWJuOpcBtAWHsoftIF/c1U3YbZ1Ve7VeWTC
	 /NL9V8hTgFrJhShK6LjOCtoYuuPzTxBBDeAK3MwfTV+yNRKPpviKX8pKwrq4qiDiJs2oh
	 869iRPjflXRAIQpjGha0IWZOBmzuwl1AymV3VExfeExcyJkt3EadMbpkRHJxjs5uiNyYX
	 DtYUFWGphs0tlFFG4gd4l3rljBGnPiYRHVIMQt9rklKB1FrloufwimSJ/mzHUegWSzh+E
	 Re+KkH0NmRJkbKvblqgL4KDVKqZGs+Jbxe3VkW3QGDYdlnII23XRzJlDIB73uQO++OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QFrkNRPC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AABE606A338;
	Tue, 17 Nov 2026 13:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QFrkNRPC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F9C1F000C4;
	Tue, 17 Nov 2026 13:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920954;
	bh=tqwfXbj3ZR7mRZUcNEreZ1uIDndR1OB4dKoeTEFs4pc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QFrkNRPCLNgFrdbcUQ0CR0aOhr8TILgrCZCB9zl1CeqvFgJ9Pd8VYouqAp+b1j4Fv
	 D3pLWlJPzbWTpiC3BMjY5RFWDXZRL6iE8LK5Z6/g9F0TenC3TkjL7/2lCNpN0Y3DYp
	 MyWgT36FnxjBWJU5zGK9t6cX4xtjdUgCUM6ppDWj62eEXalVQtapTl7rquzdK+zmO0
	 nZs2/EV8yXFaRx+IA5GDOPZBJkNXcwc+pmlCRMYSQpvQoKP3LCpAwE4S0zVilWMy/J
	 OeslIAdIZPMeLlizPzZzl6Wa1IbS2ho+tYdYDoqRv6vpkF2hNrxG++vF/uC8DO+t7u
	 tzohtIbAuLCjA==
Message-ID: <sashiko-outbox-218840@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 11/11] arm64: dts: qcom: sm8250-lge-timelm: add
 QCA6390 Bluetooth
Reply-To: sashiko-reviews@lists.linux.dev
To: rofikkerneldev <rofikcoga@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261117123946.668557-12-rofikcoga@gmail.com>
References: <20261117123946.668557-1-rofikcoga@gmail.com>
 <20261117123946.668557-12-rofikcoga@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 13:09:13 +0000
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
- [High] arm64: dts: qcom: non-real-name handle in Signed-off-by trailer
- [High] arm64: dts: qcom: sm8250-lge-timelm: under-volted QCA6390 PMU
  supplies
--

commit c689e882729fccea2deb0c720da66bf756537580
Author: rofikkerneldev <rofikcoga@gmail.com>

> arm64: dts: qcom: sm8250-lge-timelm: add QCA6390 Bluetooth
>
> Describe the QCA6390 power sequencer and its PMU regulators. Enable the
> Bluetooth HCI controller on GENI UART6 with the supplies provided by the
> PMU.
>
> Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>

[Severity: High]
The Author header and Signed-off-by trailer use an account handle
(rofikkerneldev) instead of a known real human name, which does not meet
the Developer's Certificate of Origin requirements in
Documentation/process/submitting-patches.rst.

> diff --git a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts b/arch/arm64/=
boot/dts/qcom/sm8250-lge-timelm.dts
> index 6b57c658cf918..38816268fcf53 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
> @@ -95,6 +95,67 @@ key-assistant {
>  		};
>  	};
> =20
> +	qca6390-pmu {
> +		compatible =3D "qcom,qca6390-pmu";
> +
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&bt_en_state>, <&wlan_en_state>;
> +
> +		vddaon-supply =3D <&vreg_s6a_0p6>;
> +		vddpmu-supply =3D <&vreg_s6a_0p6>;
> +		vddrfa0p95-supply =3D <&vreg_s6a_0p6>;
> +		vddrfa1p3-supply =3D <&vreg_s8c_1p2>;
> +		vddrfa1p9-supply =3D <&vreg_s5a_1p9>;
> +		vddpcie1p3-supply =3D <&vreg_s8c_1p2>;
> +		vddpcie1p9-supply =3D <&vreg_s5a_1p9>;
> +		vddio-supply =3D <&vreg_s4a_1p8>;

[Severity: High]
Does wiring vddaon-supply, vddpmu-supply and vddrfa0p95-supply to
vreg_s6a_0p6, and vddrfa1p3-supply and vddpcie1p3-supply to vreg_s8c_1p2,
under-volt the QCA6390 PMU?

pwrseq-qcom-wcn only enables these regulators without calling
regulator_set_voltage(), so the RPMh regulator driver initializes them to
their regulator-min-microvolt constraints when enabled.  In this board DT,
vreg_s6a_0p6 has regulator-min-microvolt =3D <600000> and vreg_s8c_1p2 has
regulator-min-microvolt =3D <1200000>, with no other consumer voting a high=
er
voltage.  That drives the 0.95V PMU inputs at 0.6V (below the PMU's own
0.8V and 0.85V LDO outputs) and the 1.35V inputs at 1.2V.  Should the
minimum voltages on smps6 and smps8 be raised to ~950000 uV and ~1350000 uV
like on other SM8250 QCA6390 boards?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117123946.6685=
57-1-rofikcoga@gmail.com?part=3D11
