Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793107346;
	b=GnaRgoXht2wiE3F2o95l96QrJVYqD+bc14BAjy9A+9EVMc0oNkTY+epZm69IzKqTj8OA
	 TOCfQL6DdsxJxh/u1mEXAZ7mbCObfOWWjJZu+VacQbzy1atTcgCUBteHrArwWmrbC1ACn
	 1KYoH6JyQdr+0zOGO+ZYgsafVgG9HIpohrJ8hjjNjKE0YaCYCW2GPEvyB8AAj+IREIzEV
	 qqRxz4k78faNz43hW6cU9bexzqq/PWJfc2d9fhd9lSqFmp2ThwlM+mMw03FIDm87v9lbw
	 XAx3+X2dcSKKt/ny1gJjiBTeEqVeLohu/2CBunAU0S83qjvE1FfbJRAWkodjFCsFIzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793107346;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Xj67NiJh2Z4pdwze/JwyyrlvFS2Frq0bavp1aNAOF+Y=;
	b=y3ZBdxLsPK2WIywQAKyM1BBTH8l6WLOHB/S9yG7WnQSAkUgb91lvApRy1qq6gplcSa7M
	 pFs+cqvymC9x+kiJsjcj7hrVBH2i10cpbOgAENpep1GqKmZfjmT/ZB7tZ4VITsrAqFWnK
	 b9PF7JRPSihjzwCD5m0v9+Nrr3UmViKTxcVvfUJ2nlVeP4rwcobxqrQMRPvHeNu4YSf5/
	 V7a6iy45DJcdWXvph4Liy2ZDlHE7WyjAVuxdWlfPmp9zyDbUdpTe1W2tR8dUoIhtQ00yo
	 +OVrut1YcfWJJgzAo5A8GeN4FMFYeDmsIqUv5J6kPN1kW/s+5dApWrL2LAAl4gRThpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mainlining.org;
	spf=pass smtp.mailfrom=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=mxxbttXc;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=eTsWZ5U5;
	arc=none smtp.remote-ip=5.75.144.95
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B08B606A31D;
	Tue, 27 Oct 2026 13:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B08B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=mxxbttXc;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=eTsWZ5U5
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1793107318; bh=Xj67NiJh2Z4pdwze/Jwyyrl
	vFS2Frq0bavp1aNAOF+Y=; b=mxxbttXc1kwRAw4uFr6Joln+wd89lpfwXB3f0rPAO4vYimMZh7
	jvVbJ/fWa2pt91BX37u4bOR1QAyWdKL/UBi9irf9pvF6r1GsNgAAdAOBCggwJdYbYd8MGYbKBcb
	IC8a5slECJdOA/6e+GRAJupr0Z3LlxDEoRrOPQqYt5QNtKh2g2rNfHOjHC4IEgG6U7P4aDgRLxE
	4FrXQHIR1FTK9819rifvTRK2ku6pUXnTGP6noUTAxhSXGTmAep0w/Uo888MdzxZza7w9yo98LAC
	w5cleacP1J8MXMNn+7DtOuZMy7sgE7iZVCS3leZn1nar8BkA2KG1+SoegpudNixb3pg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1793107318; bh=Xj67NiJh2Z4pdwze/Jwyyrl
	vFS2Frq0bavp1aNAOF+Y=; b=eTsWZ5U5a1kSPxUaMDFdlMnVdcfluYbi3UyR/neQ+3HarpYrgO
	xKOLXAksCoxT2sfC1Nn2S6fCPflmtLkTAiCw==;
Message-ID: <524ccb0f-8880-4552-8549-88a9d68e3faa@mainlining.org>
Date: Tue, 27 Oct 2026 16:21:55 +0300
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] arm64: dts: qcom: Add initial support for MSM8952
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Bjorn Andersson <andersson@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Kees Cook <kees@kernel.org>,
 Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-pm@vger.kernel.org, linux-input@vger.kernel.org
References: <20261011-msm8952-initial-support-v5-0-1857074992ec@mainlining.org>
 <20261011-msm8952-initial-support-v5-5-1857074992ec@mainlining.org>
 <cf9aa65d-5603-425e-b09e-0a5ae86fa551@oss.qualcomm.com>
From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Content-Language: en-US
In-Reply-To: <cf9aa65d-5603-425e-b09e-0a5ae86fa551@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Konrad,

Thanks a lot for review,

On Mon, 26 Oct 2026 16:01:49 +0100, Konrad Dybcio wrote:
> On 10/11/26 6:51 PM, Muzaffer Kadir via B4 Relay wrote:
>> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>>
>> Add initial support for MSM8952 SoC.
>>
>> AI help is used for calculating qfprom nodes.
>>
>> Downstream reference for port is [1] which is very lightly modified
>> version of [2].
> 
> Generally this looks good, couple more comments
> 
> [...]
> 
>> +	soc: soc@0 {
>> +		compatible = "simple-bus";
>> +		ranges = <0 0 0 0xffffffff>;
> 
> this is equal to `ranges;`

Changing this to empty ranges would make ranges property
to expect parent and child size-cells and address-cells to
be equal but root size-cells and address-cells are 2 and soc
size-cells and address-cells are 1.

The Devicetree Specification describes an empty ranges as:
"If the property is defined with an <empty> value, it
specifies that the parent and child address space is identical,
and no address translation is required."
(Devicetree Specification v0.4, section 2.3.8)

So this change creates these warnings:
/soc@0:ranges: empty "ranges" property but its #address-cells (1) differs from / (2)
/soc@0:ranges: empty "ranges" property but its #size-cells (1) differs from / (2)

I will keep this unchanged.

> 
> [...]
> 
> 
>> +		sdhc_1: mmc@7824900 {
>> +			compatible = "qcom,msm8952-sdhci", "qcom,sdhci-msm-v4";
>> +			reg = <0x07824900 0x500>, <0x07824000 0x800>, <0x7824e00 0x200>;
>> +			reg-names = "hc", "core", "cqhci";
> 
> Please break up these into one-per-line (also for properties below)
> the last reg entry needs a leading zero
> 
> (in general one-per-line is cool)
> 
> [...]
> 
> 
>> +		usb: usb@78db000 {
>> +			compatible = "qcom,ci-hdrc";
>> +			reg = <0x078db000 0x200>,
>> +			      <0x078db200 0x200>;
>> +			interrupts-extended = <&mpm 58 IRQ_TYPE_LEVEL_HIGH>,
>> +					      <&mpm 49 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_USB_HS_AHB_CLK>,
>> +				 <&gcc GCC_USB_HS_SYSTEM_CLK>;
>> +			clock-names = "iface",
>> +				      "core";
>> +			assigned-clocks = <&gcc GCC_USB_HS_SYSTEM_CLK>;
>> +			assigned-clock-rates = <80000000>;
>> +			resets = <&gcc GCC_USB_HS_BCR>;
>> +			reset-names = "core";
>> +			hnp-disable;
>> +			srp-disable;
>> +			adp-disable;
>> +			ahb-burst-config = <0>;
>> +			dr_mode = "otg";
> 
> dr_mode = otg is default - you can drop it
> 
> [...]
> 
>> +			pll_opp_table_c1: opp-table {
>> +				compatible = "operating-points-v2";
>> +
>> +				opp-499200000 {
>> +					opp-hz = /bits/ 64 <499200000>;
>> +				};
>> +
>> +				opp-806400000 {
>> +					opp-hz = /bits/ 64 <806400000>;
>> +				};
>> +
>> +				opp-960000000 {
>> +					opp-hz = /bits/ 64 <960000000>;
>> +				};
>> +
>> +				opp-1094400000 {
>> +					opp-hz = /bits/ 64 <1094400000>;
>> +				};
>> +
>> +				opp-1344000000 {
>> +					opp-hz = /bits/ 64 <1344000000>;
>> +				};
>> +
>> +				opp-1440000000 {
>> +					opp-hz = /bits/ 64 <1440000000>;
>> +				};
>> +
>> +				opp-1516800000 {
>> +					opp-hz = /bits/ 64 <1516800000>;
>> +				};
>> +
>> +				opp-1651200000 {
>> +					opp-hz = /bits/ 64 <1651200000>;
>> +				};
> 
> Drop the last entry for the same reasons you explained
> 
> [...]
> 
> 
>> +		a53pll_cci: clock@b1d0000 {
>> +			compatible = "qcom,msm8939-a53pll";
> 
> This needs a 8952-specific compatible (bindings-only fallback
> is fine)
> 
>> +			reg = <0x0b1d0000 0x40>;
>> +			clocks = <&xo_board>;
>> +			clock-names = "xo";
>> +			#clock-cells = <0>;
>> +		};
>> +
>> +		apcs2: mailbox@b1d1000 {
>> +			compatible = "qcom,msm8939-apcs-kpss-global", "syscon";
> 
> Likewise
>> +			reg = <0x0b1d1000 0x1000>;
>> +			clocks = <&a53pll_cci>,
>> +				 <&gcc GPLL0_VOTE>,
>> +				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
>> +			clock-names = "pll",
>> +				      "aux",
>> +				      "ref";
>> +			#clock-cells = <0>;
>> +			#mbox-cells = <1>;
>> +		};
>> +
>> +		adsp: remoteproc@c200000 {
>> +			compatible = "qcom,msm8996-adsp-pil";
> 
> And likewise
> 
> also IMEM, DSI, RPMPD, RPMCC
> 
> [...]
> 
>> +	thermal-zones {
>> +		aoss0-thermal {
>> +			polling-delay-passive = <250>;
> 
> TSENS sensors are interrupt-driven so you don't need polling
> 
> AOSS is surely the wrong name - that hw didn't come until years
> later than 8952 was released. I can't find a mapping of the
> sensors for this SoC right now, so either drop these or give them
> some generic names

Understood, I will change these to generic names
(excluding known ones from downstream)

> 
> [...]
> 
>> +	timer {
>> +		compatible = "arm,armv8-timer";
>> +		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
>> +		clock-frequency = <19200000>;
> 
> Drop this property, it's only needed for very broken FWs

For other parts I will change them as requested.

Best Regards,
Muzaffer Kadir
