Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793188261;
	b=p0QFFn8eh95sA1XEbNzKhPrv8bvd7ziVCUZMBP6TEprmO4ERNpx8N234hOrFNMbRuFe/
	 rl0e0ZbkbX0xDCP2cMZnxddWoKt3WiDwdaldWLjCeowvO9ykXnT9QH9oQSypkBLpzKt7u
	 yNWytqBCRQP/PeJREAtxGGnM2Man0pnvtVoFIAG1Ct+fPsLgx9YRcacWBbSzvI3ns7aYw
	 a/aVA6XlpKtQVamaUP/7a6AkW1jVP1Pcs43DgDLNzj2H0Gndr1ybKOfNQ+ZxRnIb9uSbG
	 G9T2dX3C+lLr4qSDrnwMi5s1ZQAsv7/aBcXErj9tdteURhAKhDSy8UPMa2nNSV+yhhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188261;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FdmVKHopEvu7xCfFX72jUxUUbMwzF+8jpKUwOvP2anw=;
	b=TUyZ7MSmQ+aVavIC4L/wzPeiWd/njfNeKAZlHmg2g2zB0CHIFTXo6MBvu++aP3Lg8zO4
	 vTMyLqzEvaGrKVEZ5cylT7lSmfeBQBDT1nzWepcm6OJksSdAhT5KASaoBbbAPPsYG80x6
	 fYR0i5vQRS2wqd8gFT2Mk8L3hlOehLAVAsw51TC8VZBjbIvtsa+Bd6Lw5hAEBjHzFVtER
	 jSiY4TTYt5CBlFjJsgoSgF+mUhE7l9TtyhDiybKM7puVRflzTvkUDqYmpECoUel3YqtZg
	 O8BCCtQJMdY5jUNxbQQv/gQUccao6guQm39X2PqGBvOhRHY4AzNyfm4DnpAzHE4QaYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fDoS5Q1R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57393606A31A;
	Wed, 28 Oct 2026 11:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fDoS5Q1R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A9D1F01825;
	Wed, 28 Oct 2026 11:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793188261;
	bh=FdmVKHopEvu7xCfFX72jUxUUbMwzF+8jpKUwOvP2anw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fDoS5Q1RAVCkOGvBzFLNmkcvug83ww/MGU09N2Y0bBDXWV5sWqngI7dU/tPdAv9p7
	 Jffn5M+md5iK9w66oNFV/XgOLVWtWrfjNjJkz1jrrL47AURB+l+jX+wCDcj6VInd6b
	 bERsbWt9lb5+NCp36k+JvqJS3VfOZAsbAvrBEqVrmzG0E3ePif/Liv9vqdfrc5v3Hb
	 czmEqHX6Cu4qpvEnZ3CKwRlRVWD5sIcSw6coft/KI9Laf4DX6zkAuT7BJ1BzcXP3Sy
	 /jaJjcOkCAQz5QkO5cTj7AmTO7M74d8bk4KWzmp/DT/6ET4f/ttMsdv/QeYwlNU3U0
	 o/QAG+ye48BTg==
Message-ID: <sashiko-outbox-187844@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/11] arm64: dts: qcom: Add initial support for
 MSM8952
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261028-msm8952-initial-support-v6-9-e07ddd8bcf4c@mainlining.org>
References: <20261028-msm8952-initial-support-v6-0-e07ddd8bcf4c@mainlining.org>
 <20261028-msm8952-initial-support-v6-9-e07ddd8bcf4c@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 11:51:00 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] arm64: dts: qcom: msm8952: broken CPU thermal cooling and L2 criti=
cal trip
- [High] arm64: dts: qcom: msm8952: MPM pin 53 mapping collides with GPIO 6=
2 and MDSS
- [High] arm64: dts: qcom: msm8952: missing bam_clk in crypto_dma and usb_d=
ma nodes
- [High] arm64: dts: qcom: msm8952: missing TBU clocks in mdss_mdp and gpu_=
iommu
- [Medium] arm64: dts: qcom: msm8952: undersized rpm_msg_ram master-stats S=
RAM regions
- [Medium] arm64: dts: qcom: msm8952: smsm hexagon@1 mixes Modem reg with A=
DSP IRQ
--

commit 3b6974623411799bae0925eac2cbe5847d66336d
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

arm64: dts: qcom: Add initial support for MSM8952

This commit adds the initial device tree source include file for the
Qualcomm MSM8952 SoC, including support for CPUs, RPM, MPM, master-stats,
SMP2P, SMSM, QFPROM, TSENS, TLMM, GCC, MDSS, GPU, IOMMU, SDHCI, BLSP,
USB, and ADSP.

> diff --git a/arch/arm64/boot/dts/qcom/msm8952.dtsi b/arch/arm64/boot/dts/=
qcom/msm8952.dtsi
> new file mode 100644
> index 0000000000000..a7180d694fc76
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8952.dtsi
> @@ -0,0 +1,2884 @@

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
Does including <53 72> in qcom,mpm-pin-map under mpm in
arch/arm64/boot/dts/qcom/msm8952.dtsi cause an interrupt allocation conflict
between TLMM GPIO 62 and mdss?

In drivers/pinctrl/qcom/pinctrl-msm8952.c, msm8952_mpm_map maps GPIO 62 to =
MPM
wakeup pin 53:

drivers/pinctrl/qcom/pinctrl-msm8952.c:
	static const struct msm_gpio_wakeirq_map msm8952_mpm_map[] =3D {
		...
		{ 45, 24 }, { 46, 25 }, { 48, 26 }, { 54, 14 }, { 58, 17 }, { 62, 53 },

When a consumer requests an interrupt on GPIO 62,
msm_gpio_irq_domain_alloc() -> qcom_mpm_alloc() looks up MPM pin 53 via
get_mpm_gic_map():

drivers/irqchip/irq-qcom-mpm.c:qcom_mpm_alloc() {
	...
	map =3D get_mpm_gic_map(priv, pin);
	if (map =3D=3D NULL)
		return irq_domain_disconnect_hierarchy(domain->parent, virq);
	...
	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &fwspec);
}

For TLMM wakeup GPIOs, get_mpm_gic_map() needs to return NULL so that
qcom_mpm_alloc() disconnects the GIC parent hierarchy, since GPIO interrupts
are routed through the TLMM summary interrupt (GIC_SPI 208). With <53 72>
present in qcom,mpm-pin-map while mdss connects directly to &intc on
GIC_SPI 72, requesting an interrupt on GPIO 62 will instead attempt to
allocate GIC_SPI 72 in the GIC domain as its parent interrupt, colliding wi=
th
mdss.

[ ... ]

> +	smsm {
> +		compatible =3D "qcom,smsm";
> +
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		mboxes =3D <0>,
> +			 <&apcs1 13>,
> +			 <&apcs1 9>,
> +			 <&apcs1 19>;
> +
> +		apps_smsm: apps@0 {
> +			reg =3D <0>;
> +
> +			#qcom,smem-state-cells =3D <1>;
> +		};
> +
> +		hexagon_smsm: hexagon@1 {
> +			reg =3D <1>;
> +			interrupts =3D <GIC_SPI 290 IRQ_TYPE_EDGE_RISING>;
> +
> +			interrupt-controller;
> +			#interrupt-cells =3D <2>;
> +		};

[Severity: Medium]
In the smsm node in arch/arm64/boot/dts/qcom/msm8952.dtsi, does
hexagon_smsm: hexagon@1 mix the Modem SMSM state entry index with the ADSP
SMSM interrupt?

In qcom_smsm_probe() in drivers/soc/qcom/smsm.c, each child node's reg
property selects the SMSM state entry and subscription row:

drivers/soc/qcom/smsm.c:qcom_smsm_probe() {
	...
		ret =3D of_property_read_u32(node, "reg", &id);
		...
		entry =3D &smsm->entries[id];

		entry->smsm =3D smsm;
		entry->remote_state =3D states + id;
}

Here mboxes lists host 0 (APPS), host 1 (Modem/MPSS on <&apcs1 13>), host 2
(ADSP/LPASS on <&apcs1 9>), and host 3 (WCNSS on <&apcs1 19>). Entry 1 is
Modem (whose SMSM interrupt is GIC_SPI 26), whereas GIC_SPI 290 is the ADSP
SMSM interrupt corresponding to entry 2. Pairing reg =3D <1> with GIC_SPI 2=
90
causes smsm_intr() to read Modem's state word (states + 1) when the ADSP SM=
SM
interrupt fires, while leaving Modem's SMSM interrupt unhandled.

[ ... ]

> +		rpm_msg_ram: sram@60000 {
> +			compatible =3D "qcom,rpm-msg-ram",
> +				     "mmio-sram";
> +			reg =3D <0x00060000 0x8000>;
> +
> +			ranges =3D <0 0x00060000 0x8000>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +
> +			apss_master_stats: sram@150 {
> +				reg =3D <0x150 0x14>;
> +			};
> +
> +			apss_mpm: sram@1d0 {
> +				reg =3D <0x1d0 0x64>;
> +			};
> +
> +			mpss_master_stats: sram@1150 {
> +				reg =3D <0x1150 0x14>;
> +			};
> +
> +			pronto_master_stats: sram@2550 {
> +				reg =3D <0x2550 0x14>;
> +			};
> +
> +			tz_master_stats: sram@3550 {
> +				reg =3D <0x3550 0x14>;
> +			};
> +
> +			lpass_master_stats: sram@4550 {
> +				reg =3D <0x4550 0x14>;
> +			};
> +		};

[Severity: Medium]
Should the reg sizes for apss_master_stats, mpss_master_stats,
pronto_master_stats, tz_master_stats, and lpass_master_stats under
rpm_msg_ram in arch/arm64/boot/dts/qcom/msm8952.dtsi be 0x50 (80 bytes)
instead of 0x14 (20 bytes)?

In drivers/soc/qcom/rpm_master_stats.c, master_stats_probe() maps each regi=
on
using resource_size(&res), and master_stats_show() reads
sizeof(struct rpm_master_stats), which is 80 (0x50) bytes (20 32-bit words):

drivers/soc/qcom/rpm_master_stats.c:master_stats_show() {
	struct master_stats_data *data =3D s->private;
	struct rpm_master_stats stat;

	memcpy_fromio(&stat, data->base, sizeof(stat));
}

With 0x14 specified in reg, master_stats_show() reads 60 bytes past the end
of the 20-byte ioremapped resource, and sram_reserve_regions() in
drivers/misc/sram.c leaves the remaining 60 bytes of each master-stats block
unreserved in the allocatable mmio-sram pool.

[ ... ]

> +		crypto_dma: dma-controller@704000 {
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
What keeps GCC_CRYPTO_AHB_CLK enabled when bam_dma accesses registers in
crypto_dma: dma-controller@704000 (and similarly GCC_USB_HS_AHB_CLK in
usb_dma: dma-controller@78c4000) in arch/arm64/boot/dts/qcom/msm8952.dtsi?

Because crypto_dma sets qcom,controlled-remotely and omits clocks =3D
<&gcc GCC_CRYPTO_AHB_CLK> and clock-names =3D "bam_clk", bam_dma_probe() se=
ts
bdev->bamclk =3D NULL.

When crypto: crypto@73a000 probes in qce_crypto_probe()
(drivers/crypto/qce/core.c), it requests crypto_dma channels 2 and 3 via
devm_qce_dma_request() and enables runtime PM autosuspend. Once
qce_runtime_suspend() runs after the 100ms autosuspend delay (or on probe
failure cleanup), it disables GCC_CRYPTO_AHB_CLK:

drivers/crypto/qce/core.c:qce_runtime_suspend() {
	struct qce_device *qce =3D dev_get_drvdata(dev);
	int ret;

	clk_disable_unprepare(qce->core);
	clk_disable_unprepare(qce->iface);
	clk_disable_unprepare(qce->bus);
}

If the crypto device is later unbound, the qcrypto module is unloaded, or
qce_crypto_probe() unwinds after a failure, qce_dma_release() ->
dma_release_channel() -> bam_free_chan() -> bam_reset_channel() performs MM=
IO
reads and writes to crypto_dma at 0x00704000 while GCC_CRYPTO_AHB_CLK is
gated off, which triggers an unclocked bus access crash.

Similarly, usb_dma: dma-controller@78c4000 is enabled without bam_clk while
usb: usb@78db000 is disabled, so unbinding usb_dma or unloading bam_dma
executes bam_dma_remove() MMIO writes at 0x078c4000 while GCC_USB_HS_AHB_CLK
is off.

[ ... ]

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
Does mdss_mdp: display-controller@1a01000 need <&gcc GCC_MDP_TBU_CLK> ("tbu=
")
and gpu_iommu: iommu@1f08000 need <&gcc GCC_GFX_TBU_CLK> ("tbu") in
arch/arm64/boot/dts/qcom/msm8952.dtsi?

In drivers/clk/qcom/gcc-msm8952.c, gcc_mdp_tbu_clk and gcc_gfx_tbu_clk are
registered as votable branch clocks without CLK_IS_CRITICAL or
CLK_IGNORE_UNUSED, so clk_disable_unused() gates them off if unclaimed.

For display, mdss_mdp uses iommus =3D <&apps_iommu 0x17>, and mdp5_dev_prob=
e()
in drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c looks up the "tbu" clock to ena=
ble
in mdp5_enable():

drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c:mdp5_dev_probe() {
	...
	get_clk(pdev, &mdp5_kms->lut_clk, "lut", false);
	get_clk(pdev, &mdp5_kms->tbu_clk, "tbu", false);
	get_clk(pdev, &mdp5_kms->tbu_rt_clk, "tbu_rt", false);
}

For the GPU IOMMU, qcom_iommu_device_probe() in
drivers/iommu/arm/arm-smmu/qcom_iommu.c requests the "tbu" clock and enables
it in qcom_iommu_resume() so that TLB invalidation in qcom_iommu_tlb_sync()
does not time out on Adreno 405 SoCs (as described in commit 5bc1cf1466f6
("iommu/qcom: add optional 'tbu' clock for TLB invalidate")). Without these
clocks in mdss_mdp and gpu_iommu, the MDP and GFX TBUs remain unclocked.

[ ... ]

> +		l2-thermal {
> +			thermal-sensors =3D <&tsens 4>;
> +
> +			trips {
> +				l2_alert0: trip-point0 {
> +					temperature =3D <50000>;
> +					hysteresis =3D <2000>;
> +					type =3D "passive";
> +				};
> +
> +				l2_alert1: trip-point1 {
> +					temperature =3D <55000>;
> +					hysteresis =3D <2000>;
> +					type =3D "hot";
> +				};
> +
> +				l2_crit: l2-crit {
> +					temperature =3D <75000>;
> +					hysteresis =3D <2000>;
> +					type =3D "critical";
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
> +
> +				cpu4_crit: cpu-crit {
> +					temperature =3D <110000>;
> +					hysteresis =3D <2000>;
> +					type =3D "critical";
> +				};
> +			};
> +		};
> +
> +		cpu5-thermal {
> +			thermal-sensors =3D <&tsens 6>;
> +
> +			cooling-maps {
> +				map0 {
> +					trip =3D <&cpu5_alert1>;
> +					cooling-device =3D <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};

[ ... ]

> +		cpu0-3-thermal {
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
Will passive CPU frequency throttling ever activate in thermal-zones in
arch/arm64/boot/dts/qcom/msm8952.dtsi with this configuration, and will
l2-thermal shut the system down prematurely at 75C?

There appear to be four related issues in thermal-zones:

1. In cpu4-thermal, cpu5-thermal, cpu6-thermal, cpu7-thermal, and
cpu0-3-thermal, cooling-maps binds map0 to cpuX_alert1 (type =3D "hot") rat=
her
than cpuX_alert0 (type =3D "passive"). Thermal governors ignore THERMAL_TRI=
P_HOT
trips when throttling cooling devices:

drivers/thermal/gov_step_wise.c:step_wise_manage() {
	...
	for_each_trip_desc(tz, td) {
		const struct thermal_trip *trip =3D &td->trip;

		if (trip->temperature =3D=3D THERMAL_TEMP_INVALID ||
		    trip->type =3D=3D THERMAL_TRIP_CRITICAL ||
		    trip->type =3D=3D THERMAL_TRIP_HOT)
			continue;

		thermal_zone_trip_update(tz, td, td->threshold);
	}
}

Because no cooling-maps are attached to the passive trips, CPU frequency
throttling will never engage.

2. In cpu5-thermal, cpu6-thermal, and cpu7-thermal, cooling-device only
references <&cpu5 ...>, <&cpu6 ...>, and <&cpu7 ...> respectively. Because
cpu4..cpu7 share &apcs1 and cpu_opp_table_c1 (opp-shared),
of_cpufreq_cooling_register() in drivers/thermal/cpufreq_cooling.c register=
s a
single cooling device for the cluster policy with cdev->np set to
of_get_cpu_node(policy->cpu, NULL) (&cpu4). When thermal_of_get_cooling_spe=
c()
in drivers/thermal/thermal_of.c checks cooling_spec.np !=3D cdev->np,
cpu5-thermal, cpu6-thermal, and cpu7-thermal will fail to bind to the clust=
er
cooling device unless <&cpu4 ...> (or all four cluster CPUs) is included.

3. None of the thermal zones set polling-delay-passive, which leaves
tz->passive_delay_jiffies at 0 so monitor_thermal_zone() in
drivers/thermal/thermal_core.c does not schedule periodic polling while a
passive trip is crossed.

4. In l2-thermal, l2_crit has temperature =3D <75000> (75C), which is the s=
ame
temperature where the CPU passive trips start, causing handle_critical_trip=
s()
to trigger an emergency system shutdown as soon as the L2 sensor reaches 75=
C.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-msm8952-in=
itial-support-v6-0-e07ddd8bcf4c@mainlining.org?part=3D9
