Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793311822;
	b=VfeVyXN+UVEfdn3VFlmsddNsIGSv2MS4JhyQEBeSUXXuI7XsTAxv/k0BKrebbJz9OP1C
	 WLKO93CMo64Q/8hiVnhKDWXonEnSK1oQ5bgtSTK8CYnU/Gr143gnF+1g6mhNFNnS2U2vu
	 H8/51viaszxDCpmIF9w5wIbDD9jzIYgfkpaZ1C+mgUq5XZCPrDTEQMmWUaUPGiNHftYGu
	 eXdbRjVvI+7WDTg25IUT1k+TLvg+se6dRphXr5h1Vl3MN7fptVlsv71P5N5iGb5cmF/F0
	 +hnj/ZMoVk1y904E6NMqPrYyBRt+6meKUUpaQeYw+RlRfWzyKDyejLrps3olb0AGZ/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793311822;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cER8Rp0mkVj+HJCMph+6srnNJM6smXhNIXGmscx1YwU=;
	b=jL6U1NRANsaIQrOOUdVeKSqLpNRThxF74R7DoiqCExthDBO1hxgSdPUc2h3t/s6Yetw5
	 eF9a3p5o6KSjrznPpIxGcxrzFN2mfeZ0fH+K5nJIABHMRi1l8Rvrt8g/d3l35fH8eU9V2
	 Nl+vzwtMC5WOY8oZyAaGeLq+DA7Y0ikWqhgnAzrOHU4yZImxrjD/RpiLURU6hi0ZDwuYD
	 17QqGLYXI1iWKbjJFv1k7dE/wPehT+K5SQZFJto1YkrNRm/Vzty4lOraxV46psHbAvKr7
	 gy3BB0fIqKuaH9ujdJbjDFejjmQ9LU5v8PwKYgIeiHytkHOLMY1EC1o7x0dXsx6aA4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iIedwWNr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36651606A31A;
	Thu, 29 Oct 2026 22:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iIedwWNr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61CDF1F01816;
	Thu, 29 Oct 2026 22:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793311821;
	bh=cER8Rp0mkVj+HJCMph+6srnNJM6smXhNIXGmscx1YwU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iIedwWNr6tCBfcz03QRbc75sNGsOaMj2hWA05O5TBAwYeNG5Jvg5GerXNZqK/dEdV
	 0fr4fojBA8G2Pt423oZIl5848i8fn1vhhI1GSlhkhlISnVLv9v7wd3C9Axa/w07it1
	 PYKegdeyohjI81Z5xkGh7KzuEklcIbV4WFcg+decIGiDsmZgys/V1LvG+O8naGjHlU
	 u+l3DHiIO50zk5EPosjF5Hyj0994TMjkyaW3qzwrTQPDqTxJ0BX7OaaM1AJwvtDpFA
	 cCv05+Eodvqrl+MejBKrjzgftGwLgvAFwbpvFWmV6J+BJTIEJjypJQ0XHtJSo1daKw
	 p9aEdnNi5a6Hg==
Message-ID: <sashiko-outbox-190050@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/11] arm64: dts: qcom: Add initial support for
 MSM8952
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261030-msm8952-initial-support-v7-9-ad748ace375d@mainlining.org>
References: <20261030-msm8952-initial-support-v7-0-ad748ace375d@mainlining.org>
 <20261030-msm8952-initial-support-v7-9-ad748ace375d@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 22:10:20 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] arm64: dts: qcom: msm8952: CPU cooling-maps bound to hot trips
- [High] arm64: dts: qcom: msm8952: MPM pin 53 collision between mdss and g=
pio62
- [High] arm64: dts: qcom: msm8952: missing bam_clk on cryptobam and usbbam
- [High] arm64: dts: qcom: msm8952: missing TBU clocks on mdss_mdp and gpu_=
iommu
--

commit 209938af6e516d37174e16e2a184d278eb7397c9
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

arm64: dts: qcom: Add initial support for MSM8952

This commit adds the initial device tree source include file for the
Qualcomm MSM8952 SoC, including support for CPUs, RPM, MPM, QFPROM,
TSENS, TLMM, GCC, MDSS, IOMMUs, SDHCI, BLSP, USB, and ADSP.

> diff --git a/arch/arm64/boot/dts/qcom/msm8952.dtsi b/arch/arm64/boot/dts/=
qcom/msm8952.dtsi
> new file mode 100644
> index 0000000000000..ee932f6b2a9c8
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8952.dtsi
> @@ -0,0 +1,2909 @@

[ ... ]

> +	rpm: remoteproc {
> +		compatible =3D "qcom,msm8952-rpm-proc",
> +			     "qcom,rpm-proc";
> +
> +		mpm: interrupt-controller {
> +			compatible =3D "qcom,mpm";
> +
> +			interrupts =3D <GIC_SPI 171 IRQ_TYPE_EDGE_RISING>;
> +
> +			mboxes =3D <&apcs1 1>;
> +			interrupt-controller;
> +			#interrupt-cells =3D <2>;
> +			#power-domain-cells =3D <0>;
> +			interrupt-parent =3D <&intc>;
> +			qcom,rpm-msg-ram =3D <&apss_mpm>;
> +			qcom,mpm-pin-count =3D <64>;
> +			qcom,mpm-pin-map =3D <2 184>, /* TSENS UPLOW */
> +					   <49 140>, /* USB ASYNC */
> +					   <53 72>, /* MDSS */
> +					   <58 134>, /* USB */
> +					   <62 190>; /* SPMI */
> +		};

[Severity: High]
Does mapping MPM pin 53 to GIC SPI 72 in qcom,mpm-pin-map (and routing
mdss through <&mpm 53 IRQ_TYPE_LEVEL_HIGH> below) collide with TLMM GPIO
62?

In drivers/pinctrl/qcom/pinctrl-msm8952.c, msm8952_mpm_map[] maps GPIO 62
to MPM wakeup pin 53:

	{ 45, 24 }, { 46, 25 }, { 48, 26 }, { 54, 14 }, { 58, 17 }, { 62, 53 },

When an interrupt is requested on a wakeup-capable TLMM GPIO via
msm_gpio_irq_domain_alloc() -> qcom_mpm_alloc(), drivers/irqchip/irq-qcom-m=
pm.c
checks whether the MPM pin is in qcom,mpm-pin-map:

	map =3D get_mpm_gic_map(priv, pin);
	if (map =3D=3D NULL)
		return irq_domain_disconnect_hierarchy(domain->parent, virq);

Because pin 53 is present in qcom,mpm-pin-map as <53 72>, get_mpm_gic_map()
does not return NULL for GPIO 62, so qcom_mpm_alloc() fails to disconnect
the GIC hierarchy and instead binds GPIO 62 to GIC SPI 72, colliding with
mdss on both MPM pin 53 and GIC SPI 72.

Since MDSS is in the collapsible MDSS_GDSC power domain rather than an
always-on MPM wakeup source, should <53 72> be dropped from
qcom,mpm-pin-map and mdss use interrupts =3D <GIC_SPI 72 IRQ_TYPE_LEVEL_HIG=
H>
directly?

[ ... ]

> +		cryptobam: dma-controller@704000 {
> +			compatible =3D "qcom,bam-v1.7.0";
> +			reg =3D <0x00704000 0x20000>;
> +			interrupts =3D <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells =3D <1>;
> +			num-channels =3D <16>;
> +			qcom,ee =3D <1>;
> +			qcom,num-ees =3D <4>;
> +			qcom,controlled-remotely;
> +		};

[Severity: High]
Could omitting clocks =3D <&gcc GCC_CRYPTO_AHB_CLK> and
clock-names =3D "bam_clk" on cryptobam (and similarly omitting
<&gcc GCC_USB_HS_AHB_CLK> on usbbam: dma-controller@78c4000 below) lead to
unclocked MMIO accesses?

When qcom,controlled-remotely is set without bam_clk in the DT node,
bam_dma_probe() in drivers/dma/qcom/bam_dma.c sets bdev->bamclk to NULL via
devm_clk_get_optional(bdev->dev, "bam_clk").

For cryptobam, qce_crypto_probe() in drivers/crypto/qce/core.c requests the
DMA channels and then autosuspends via qce_runtime_suspend(), gating off
GCC_CRYPTO_AHB_CLK (or suspends immediately via the
PM_RUNTIME_ACQUIRE_AUTOSUSPEND guard if probe fails after
devm_qce_dma_request()). If the crypto device is later unbound or unwinds
from a probe failure, qce_dma_release() -> dma_release_channel() ->
bam_free_chan() resets the BAM channels and masks interrupts at 0x00704000
while GCC_CRYPTO_AHB_CLK is disabled.

Similarly, usbbam is enabled by default while usb@78db000 is disabled, so
bam_dma_remove() will access 0x078c4000 with GCC_USB_HS_AHB_CLK gated off
if usbbam is unbound.

Should cryptobam and usbbam specify their respective AHB clocks as bam_clk?

[ ... ]

> +		mdss: display-subsystem@1a00000 {
> +			compatible =3D "qcom,mdss";
> +			reg =3D <0x01a00000 0x1000>,
> +			      <0x01ac8000 0x3000>;
> +			reg-names =3D "mdss_phys",
> +				    "vbif_phys";
> +
> +			ranges;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +
> +			power-domains =3D <&gcc MDSS_GDSC>;
> +
> +			clocks =3D <&gcc GCC_MDSS_AHB_CLK>,
> +				 <&gcc GCC_MDSS_AXI_CLK>,
> +				 <&gcc GCC_MDSS_VSYNC_CLK>;
> +			clock-names =3D "iface",
> +				      "bus",
> +				      "vsync";
> +
> +			interrupts-extended =3D <&mpm 53 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			interrupt-controller;
> +			#interrupt-cells =3D <1>;
> +
> +			resets =3D <&gcc GCC_MDSS_BCR>;
> +
> +			status =3D "disabled";
> +
> +			mdss_mdp: display-controller@1a01000 {
> +				compatible =3D "qcom,msm8952-mdp5",
> +					     "qcom,mdp5";
> +				reg =3D <0x01a01000 0x89000>;
> +				reg-names =3D "mdp_phys";
> +
> +				interrupt-parent =3D <&mdss>;
> +				interrupts =3D <0>;
> +
> +				clocks =3D <&gcc GCC_MDSS_AHB_CLK>,
> +					 <&gcc GCC_MDSS_AXI_CLK>,
> +					 <&gcc GCC_MDSS_MDP_CLK>,
> +					 <&gcc GCC_MDSS_VSYNC_CLK>;
> +				clock-names =3D "iface",
> +					      "bus",
> +					      "core",
> +					      "vsync";
> +
> +				operating-points-v2 =3D <&mdp_opp_table>;
> +				power-domains =3D <&gcc MDSS_GDSC>;
> +
> +				iommus =3D <&apps_iommu 0x17>;

[Severity: High]
Are mdss_mdp and gpu_iommu (iommu@1f08000 below) missing their TBU clocks?

In drivers/clk/qcom/gcc-msm8952.c, gcc_mdp_tbu_clk (GCC_MDP_TBU_CLK) and
gcc_gfx_tbu_clk (GCC_GFX_TBU_CLK) are registered as non-critical votable
branch clocks:

	static struct clk_branch gcc_gfx_tbu_clk =3D {
		.halt_reg =3D 0x12010,
		.halt_check =3D BRANCH_HALT_VOTED,
		.clkr =3D {
			.enable_reg =3D 0x4500c,
			.enable_mask =3D BIT(3),
	...
	static struct clk_branch gcc_mdp_tbu_clk =3D {
		.halt_reg =3D 0x1201c,
		.halt_check =3D BRANCH_HALT_VOTED,
		.clkr =3D {
			.enable_reg =3D 0x4500c,
			.enable_mask =3D BIT(4),

Because neither clock is referenced in msm8952.dtsi, clk_disable_unused()
will clear their vote bits at late_initcall. When mdss_mdp enables its
clocks in mdp5_enable() or gpu_iommu enables its clocks in
qcom_iommu_resume(), the MDP and GPU TBUs will remain unclocked during
IOMMU translations.

Should mdss_mdp include <&gcc GCC_MDP_TBU_CLK> with clock-names "tbu", and
gpu_iommu include <&gcc GCC_GFX_TBU_CLK> with clock-names "tbu"?

[ ... ]

> +	thermal-zones {
> +		qdsp-thermal {
> +			thermal-sensors =3D <&tsens 2>;
> +
> +			trips {
> +				qdsp_alert0: trip-point0 {
> +					temperature =3D <75000>;
> +					hysteresis =3D <2000>;
> +					type =3D "hot";
> +				};
> +			};
> +		};
> +
> +		cpu4-thermal {
> +			thermal-sensors =3D <&tsens 5>;
> +
> +			cooling-maps {
> +				map0 {
> +					trip =3D <&cpu4_alert1>;
> +					cooling-device =3D <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
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
> +
> +				cpu4_crit: cpu-crit {
> +					temperature =3D <110000>;
> +					hysteresis =3D <2000>;
> +					type =3D "critical";
> +				};
> +			};
> +		};

[Severity: High]
In cpu4-thermal (as well as cpu5-thermal, cpu6-thermal, cpu7-thermal, and
cpu0-3-thermal below), map0 binds the CPU cooling devices to cpuX_alert1
(which has type =3D "hot") while leaving cpuX_alert0 (type =3D "passive")
unbound, and omits polling-delay-passive.

In the thermal framework, thermal governors ignore THERMAL_TRIP_HOT trips
when managing cooling devices, for example in
drivers/thermal/gov_step_wise.c:step_wise_manage():

	for_each_trip_desc(tz, td) {
		const struct thermal_trip *trip =3D &td->trip;

		if (trip->temperature =3D=3D THERMAL_TEMP_INVALID ||
		    trip->type =3D=3D THERMAL_TRIP_CRITICAL ||
		    trip->type =3D=3D THERMAL_TRIP_HOT)
			continue;

		thermal_zone_trip_update(tz, td, td->threshold);
	}

In addition, without polling-delay-passive in these zones,
tz->passive_delay_jiffies is 0, so monitor_thermal_zone() in
drivers/thermal/thermal_core.c will not schedule periodic polling while a
passive trip is active (and pid_controller() in
drivers/thermal/gov_power_allocator.c divides by
jiffies_to_msecs(tz->passive_delay_jiffies)).

Should map0 in cpu4-thermal, cpu5-thermal, cpu6-thermal, cpu7-thermal, and
cpu0-3-thermal reference the passive trip (cpuX_alert0) instead of
cpuX_alert1 (or change cpuX_alert1 to type =3D "passive"), and define
polling-delay-passive on those zones?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-msm8952-in=
itial-support-v7-0-ad748ace375d@mainlining.org?part=3D9
