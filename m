Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920776;
	b=WA+CdDCgCMpOet3crTfgEYaEkfR97T2FMVLOMWMiamPKdfHLCRkXvaeXg+WcbToAabO2
	 n40GfaqM7sbuBEmSOYh4rfm+kSt9tCiD6IWyOGSvsC6Kg0TofajVeYqf35YAj9mM/LoXm
	 YwbaDCeNeuoy/5ZNnn7FDXn/ikMzUCTyBVq22GsJ8UxzPWzkVq2U+eH8czdRfyrFDCoS9
	 ycqU6NJIRL6fOxXzo1xoEAH6SqkCV7tsL0+aUeun0k38kOg3CNuxZyW3TcajhuLCf75C3
	 adoyaJItNNW3DZu/6pM+b1X5lGvl88E/ta0McqhPEU7qbmYvyf5jCMX4cGdfoNdg5mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920776;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bEb8JE7H1WfLfSZIcuIT6DiE7p89Md6x6CunK0Ga4Mk=;
	b=MEyPYYrSsYHhtehp1l3AqKrWglhBI7dB6Km/ShdfTYFuhmcj4kqklO3xrLIaX0osfQNA
	 Ym/w9LL/ZU4ykMJrzluZDFAi/o6yWhMZwdmoc0IB/Q37A5yiWFkH+EyBqn8DLyG6bwMl4
	 WYubgsnPTWIRf1Msl42BJkfesOc7Cg2ir0zxRaAvKHmkwKAvTUKqAt1isYSzRAl15oKEQ
	 NRUVmrUVUjrrduIZP2J5sDIoXYYpNN4RViKfknqwBw2nK2ymt4hWf+B7LJFxBoNVgcqsG
	 JI9E6lFO3NcrUOxGIdeHz1g9coeP5HuhZYczfSXqDsl0Y4sJHwsYmAAGUdgvG9k3sEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WsRM+Bqb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D50E606A335;
	Tue, 17 Nov 2026 13:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WsRM+Bqb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CFF1F000CD;
	Tue, 17 Nov 2026 13:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920775;
	bh=bEb8JE7H1WfLfSZIcuIT6DiE7p89Md6x6CunK0Ga4Mk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WsRM+BqbWypLRj6qNSO/fCOHvpqpCIp8ZJLtXv8oxK3PGZgSkkfUEoGdBUb0GziRU
	 FCihXTnzohUx0lqwQ6EV4BcooQ54o/k/DvDLOa+ErcJMPzsik1MERuqgJk8mxgzCUr
	 bx+pKLd0PxPaYkO8HG7Bn26LZsTSqKqdsKn2K6QdyT4MsQ4vDPBdPawzIJ4OURS3R2
	 U1CxN+G8ot+dKp2IYeXNZlId/K0z8YH1Qjbdarvqdiqnu9tgPmnb9XEh57xQLpvulE
	 NBCY5dBSkXBHQ7COXP4xPQh4L7ma9sEb84SD5CyDiRTQUGNCsQYeoNcJfCTKduNymt
	 HZeazdlJlEhmQ==
Message-ID: <sashiko-outbox-218836@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 02/11] arm64: dts: qcom: add LG V60 ThinQ 5G (timelm)
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: rofikkerneldev <rofikcoga@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261117123946.668557-3-rofikcoga@gmail.com>
References: <20261117123946.668557-1-rofikcoga@gmail.com>
 <20261117123946.668557-3-rofikcoga@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 13:06:14 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 8 potential
issues to consider:
- [High] arm64: dts: qcom: timelm: enabling gpu without gmu fails
  a6xx_gmu_init()
- [High] arm64: dts: qcom: timelm: invalid 1.05V constraint on PM8009
  ldo4
- [High] arm64: dts: qcom: handle used instead of real name in DCO and
  MAINTAINERS
- [Medium] arm64: dts: qcom: timelm: swapped vdda-phy and vdda-pll on
  usb_1_qmpphy
- [Medium] arm64: dts: qcom: timelm: missing pinctrl states on sdhc_2
  node
- [Medium] arm64: dts: qcom: ramoops sub-buffers exhaust region and
  disable dmesg dumps
- [Low] arm64: dts: qcom: missing DRMS properties on UFS supply
  regulators
- [Low] arm64: dts: qcom: unused dt-bindings headers in
  sm8250-lge-timelm.dts
--

commit e0c6ddf610453315a993fcf369aad59d6f783910
Author: rofikkerneldev <rofikcoga@gmail.com>

arm64: dts: qcom: add LG V60 ThinQ 5G (timelm) support

This commit adds initial device tree support and a MAINTAINERS entry for
the Qualcomm SM8250-based LG V60 ThinQ 5G (timelm) smartphone.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 222b7fc2c3aab..c88fc0e019296 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15231,6 +15231,12 @@ Q:	http://patchwork.linuxtv.org/project/linux-me=
dia/list/
>  T:	git git://linuxtv.org/mkrufky/tuners.git
>  F:	drivers/media/dvb-frontends/lgdt3305.*
> =20
> +LG V60 THINQ 5G (TIMELM) SUPPORT
> +M:	rofikkerneldev <rofikcoga@gmail.com>
> +L:	linux-arm-msm@vger.kernel.org
> +S:	Maintained
> +F:	arch/arm64/boot/dts/qcom/sm8250-lge-timelm*
> +
>  LIBATA PATA ARASAN COMPACT FLASH CONTROLLER
>  M:	Viresh Kumar <vireshk@kernel.org>
>  L:	linux-ide@vger.kernel.org

[Severity: High]
The MAINTAINERS entry, commit author, Signed-off-by trailer, and
sm8250-lge-timelm.dts copyright header use the account handle
rofikkerneldev instead of a real name, which does not satisfy the
Developer's Certificate of Origin in
Documentation/process/submitting-patches.rst.

> diff --git a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts b/arch/arm64/=
boot/dts/qcom/sm8250-lge-timelm.dts
> new file mode 100644
> index 0000000000000..74b673ebbeb9d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
> @@ -0,0 +1,543 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2026 rofikkerneldev <rofikcoga@gmail.com>
> + * Device Tree for LG V60 ThinQ 5G (timelm / LM-V600)
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include <dt-bindings/sound/qcom,q6afe.h>
> +#include <dt-bindings/sound/qcom,q6asm.h>
> +#include <dt-bindings/usb/pd.h>

[Severity: Low]
This isn't a bug, but dt-bindings/leds/common.h,
dt-bindings/sound/qcom,q6afe.h, and dt-bindings/sound/qcom,q6asm.h are
unused throughout the series, while dt-bindings/phy/phy.h and
dt-bindings/usb/pd.h are only needed starting in commit "arm64: dts: qcom:
sm8250-lge-timelm: enable SW43103 panel" and commit "arm64: dts: qcom:
sm8250-lge-timelm: enable USB Type-C".

[ ... ]

> +	reserved-memory {
> +		ramoops: ramoops@b0000000 {
> +			compatible =3D "ramoops";
> +			reg =3D <0x0 0xb0000000 0x0 0x280000>;
> +			record-size =3D <0x1000>;
> +			console-size =3D <0x40000>;
> +			ftrace-size =3D <0x40000>;
> +			pmsg-size =3D <0x200000>;
> +		};

[Severity: Medium]
Does ramoops@b0000000 leave any space for record-size?

console-size (0x40000), ftrace-size (0x40000), and pmsg-size (0x200000)
consume the entire 0x280000 region, so ramoops_probe() computes
dump_mem_sz as 0 and disables dmesg oops and panic dumps.  While commit
"arm64: dts: qcom: sm8250-lge-timelm: add reserved memory regions" adds
no-map to this node, the sizes remain unchanged.

[ ... ]

> +	regulators-2 {
> +		compatible =3D "qcom,pm8009-rpmh-regulators";
> +		qcom,pmic-id =3D "f";
> +
> +		vdd-s1-supply =3D <&vph_pwr>;
> +		vdd-s2-supply =3D <&vreg_bob>;
> +		vdd-l2-supply =3D <&vreg_s8c_1p2>;
> +		vdd-l5-l6-supply =3D <&vreg_bob>;
> +		vdd-l7-supply =3D <&vreg_s4a_1p8>;
> +
> +		vreg_s1f_1p2: smps1 {
> +			regulator-name =3D "vreg_s1f_1p2";
> +			regulator-min-microvolt =3D <1200000>;
> +			regulator-max-microvolt =3D <1200000>;
> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s2f_0p5: smps2 {
> +			regulator-name =3D "vreg_s2f_0p5";
> +			regulator-min-microvolt =3D <512000>;
> +			regulator-max-microvolt =3D <1100000>;
> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2f_1p3: ldo2 {
> +			regulator-name =3D "vreg_l2f_1p3";
> +			regulator-min-microvolt =3D <1304000>;
> +			regulator-max-microvolt =3D <1304000>;
> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l4f_1p05: ldo4 {
> +			regulator-name =3D "vreg_l4f_1p05";
> +			regulator-min-microvolt =3D <1050000>;
> +			regulator-max-microvolt =3D <1050000>;
> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> +		};

[Severity: High]
Does vreg_l4f_1p05 cause rpmh_regulator_probe() to fail for the entire
regulators-2 node?

In pm8009_vreg_data, ldo4 uses pmic5_nldo, which has a 320000 uV base and
an 8000 uV step.  Because 1050000 uV lies between the 1048000 uV and
1056000 uV steps, machine_constraints_voltage() returns -EINVAL and aborts
registration of all PM8009 regulators in regulators-2.  In addition,
regulators-2 omits vdd-l4-supply.

[ ... ]

> +&gpu {
> +	status =3D "okay";
> +
> +	zap-shader {
> +		memory-region =3D <&gpu_mem>;
> +		firmware-name =3D "qcom/sm8250/a650_zap.mbn";
> +	};
> +};

[Severity: High]
Does enabling &gpu without enabling &gmu cause GPU initialization to fail?

In sm8250.dtsi, gmu has status =3D "disabled" by default, so no platform
device is created for it and a6xx_gpu_init() -> a6xx_gmu_init() returns
-ENODEV.  Also, memory-region =3D <&gpu_mem> is already set on
gpu_zap_shader in sm8250.dtsi.

[ ... ]

> +&ufs_mem_hc {
> +	status =3D "okay";
> +
> +	vcc-supply =3D <&vreg_l17a_3p0>;
> +	vcc-max-microamp =3D <800000>;
> +	vccq-supply =3D <&vreg_l6a_1p2>;
> +	vccq-max-microamp =3D <800000>;
> +	vccq2-supply =3D <&vreg_s4a_1p8>;
> +	vccq2-max-microamp =3D <800000>;
> +};

[Severity: Low]
Should vreg_l17a_3p0, vreg_l6a_1p2, and vreg_s4a_1p8 set
regulator-allow-set-load and regulator-allowed-modes?

Without those properties on the regulator nodes, the max-microamp limits
here have no effect when ufshcd calls regulator_set_load(), leaving the
three UFS rails in RPMH_REGULATOR_MODE_HPM during UFS low-power states.

[ ... ]

> +&sdhc_2 {
> +	status =3D "okay";
> +
> +	cd-gpios =3D <&tlmm 77 GPIO_ACTIVE_LOW>;
> +	vmmc-supply =3D <&vreg_l9c_2p9>;
> +	vqmmc-supply =3D <&vreg_l6c_2p9>;
> +	bus-width =3D <4>;
> +	no-sdio;
> +	no-mmc;
> +};

[Severity: Medium]
Should &sdhc_2 configure default and sleep pinctrl states?

sdhc_2 in sm8250.dtsi does not define pinctrl properties, so the SDCC2
pads (sdc2_clk, sdc2_cmd, sdc2_data) and card-detect pin (gpio77) are left
unconfigured by the kernel and will not transition to sdc2_sleep_state
across suspend and resume.

[ ... ]

> +&usb_1_qmpphy {
> +	status =3D "okay";
> +
> +	vdda-phy-supply =3D <&vreg_l9a_1p2>;
> +	vdda-pll-supply =3D <&vreg_l18a_0p9>;
> +};

[Severity: Medium]
Are vdda-phy-supply and vdda-pll-supply swapped on &usb_1_qmpphy?

On SM8250, the QMP PHY core rail (vdda-phy-supply) is powered by the 0.9V
vreg_l18a_0p9 regulator and the PLL rail (vdda-pll-supply) is powered by
the 1.2V vreg_l9a_1p2 regulator; swapping them applies the driver's
21800 uA and 36000 uA load votes to the wrong LDOs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117123946.6685=
57-1-rofikcoga@gmail.com?part=3D2
