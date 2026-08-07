Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8AF383C86;
	Fri,  7 Aug 2026 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118202; cv=none; b=W74dTsGdP/1OVtrMHKRLTVK4jj43C8aBPIybzE+txkO43MnhT2BT/gudVw5zScXDWzmJl1TwoGuXPaREwYr9Y9N8D3tyjwTM5MtYKrtQkR9AjyyjdAVTVFMnG1HQhX+jL+xJo9EsQil3fx2hNXAHPzpclF51bpwLb6bcBGsGCf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118202; c=relaxed/simple;
	bh=VA70aSST0+oXzeKBLFAIe/feNAXy4mW5hiharidblwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ls/7lG7TP3aw63mpWmemub3RVK5aYgP22IyCf5Kffix3psIES+/3Q313QA1NV+SDySGin28Yue71ay9Rcyu+spkeV16vj7nqqmku1ki4E8MXl6EvwSVsYbV4kbPJ296d8PS/4+r+xr7yx3xIvSVEYOfn/zeZVJVbm9r5zraiCuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsV/FfWR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsV/FfWR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90391F000E9;
	Fri,  7 Aug 2026 15:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786118200;
	bh=MRMaX8bBod1PGkHnlzs/1ZV4S9uRJLKErxlT+0jAdrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BsV/FfWRD+MvrNV5aAa3PYVyjOp9O24nf4pHGLqYuQoIB/DGF+HV2KmS8cd9BvUJb
	 /1bOtDW5RljLVug4XNjPEeMtQSjaIDX72+SqNGnds6Wv9CYHdafzoyNpzA1h8u9iln
	 V//adPr6RuqCnsKeQ0fsImSItT1ItcHoCbP6Ha8xDRnEoginVVeX6AD/q1MfoX46ZO
	 1I75zHtOCWS3LjTzoWGlTGAMXAn4pletnBOmtRmUwNEyhMZZp5Yy8sOtkezQ9s4G0N
	 8TpD2w05vrRpXOXY4HI7BjQorQxmPmWFa/sK9cEVTjEfVr1dklRIEJQZapM3iSAr7/
	 2UAVNLkG2HuFA==
Date: Fri, 7 Aug 2026 10:56:40 -0500
From: Rob Herring <robh@kernel.org>
To: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	David Collins <david.collins@oss.qualcomm.com>,
	Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
	Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: input: Add Qualcomm SPMI PMIC haptics
Message-ID: <20260807155640.GA893689-robh@kernel.org>
References: <20260806-qcom-spmi-haptics-v6-0-19fcecd5204f@oss.qualcomm.com>
 <20260806-qcom-spmi-haptics-v6-1-19fcecd5204f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806-qcom-spmi-haptics-v6-1-19fcecd5204f@oss.qualcomm.com>

On Thu, Aug 06, 2026 at 11:21:40PM -0700, Fenglin Wu wrote:
> Add binding document for the haptics module inside Qualcomm PMIC
> PMIH0108.
> 
> Assisted-by: Claude:claude-4-8-opus
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> ---
>  .../bindings/input/qcom,spmi-haptics.yaml          | 136 +++++++++++++++++++++
>  1 file changed, 136 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml b/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml
> new file mode 100644
> index 000000000000..b1a69e9886ee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml
> @@ -0,0 +1,136 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/qcom,spmi-haptics.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Haptics device inside Qualcomm Technologies, Inc. PMIC
> +
> +maintainers:
> +  - Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> +
> +description: |
> +  Certain Qualcomm PMICs integrate a haptics module, such as the HAP530_HV haptics
> +  module in the PMIH0108 PMIC, which drives an LRA (Linear Resonant Actuator) with
> +  an output voltage up to 10 V. Several play modes are supported in HAP530_HV:
> +
> +    DIRECT_PLAY: The hardware outputs sinusoidal waveforms whose period is
> +      defined by qcom,lra-period-us and whose peak voltage is defined by
> +      qcom,vmax-microvolt. The driving amplitude can be scaled in the range
> +      [0, 255] via a single register byte.  Hardware-based LRA auto-resonance
> +      tracking is enabled by default in this mode, allowing the haptics engine
> +      to follow the actual resonant frequency of the LRA and update the driving
> +      period accordingly to achieve stronger vibration magnitude.
> +
> +    FIFO: The hardware can play an arbitrary waveform composed of a sequence
> +      of 8-bit samples at a configurable play rate.  Samples are pre-filled
> +      into the internal FIFO memory of the haptics module and continuously
> +      replenished via the FIFO-empty IRQ until all samples have been played.
> +      An 8K-byte FIFO memory bank is available in the HAP530_HV haptics module,
> +      shared between the FIFO and PAT_MEM play modes. The memory partition
> +      between the two modes is configurable via registers, and FIFO mode always
> +      uses the 1st partition starting from offset 0.
> +
> +    PAT_MEM: This mode is very similar to FIFO streaming mode but without the
> +      data refilling capability. It is designed mainly for short, latency-critical
> +      vibrations. The memory space for PAT_MEM mode must be reserved for dedicated
> +      usage, and the waveform data should be preloaded and remain unchanged
> +      thereafter. The haptics module can play the waveform data from the memory
> +      region specified by the PAT_MEM play start address and length registers.
> +
> +    In either FIFO mode or PAT_MEM mode, the following play rates are supported:
> +      -- 0(T_LRA): each FIFO byte drives one full sinusoidal cycle with the
> +        period defined in qcom,lra-period-us.
> +      -- 1/2/3(T_LRA_DIV_2/4/8): each FIFO byte drives a half/quarter/eighth
> +        sinusoidal cycle with the period defined in qcom,lra-period-us.
> +      -- 4/5/6(T_LRA_X_2/4/8): each FIFO byte drives 2/4/8 sinusoidal cycles
> +        with the period defined in qcom,lra-period-us.
> +      -- 8/9/10/11/12/13(8KHz/16KHz/24KHz/32KHz/44.1KHz/48KHz): the FIFO
> +        data is treated as PCM samples and drives the output with an
> +        arbitrarily shaped waveform.  This mode is typically used to define
> +        custom driving waveforms for specific vibration effects such as fast
> +        attack, crisp brake, etc.
> +
> +    The drive voltage in FIFO or PAT_MEM mode can exceed the value defined in
> +    qcom,vmax-microvolt to achieve a special vibration effect, but the waveform
> +    must be short enough to prevent the LRA from being damaged by operating at
> +    an overvoltage.
> +
> +    Also, hardware-based LRA auto-resonance tracking is normally disabled in
> +    FIFO or PAT_MEM mode, as these modes are intended to drive arbitrary
> +    waveforms that may not follow the resonant frequency; autonomous hardware
> +    resonance correction would interfere with the intended output.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: qcom,pmih0108-haptics
> +      - const: qcom,spmi-haptics
> +
> +  reg:
> +    items:
> +      - description: HAP_CFG module base address
> +      - description: HAP_PTN module base address
> +
> +  reg-names:
> +    items:
> +      - const: cfg
> +      - const: ptn
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    items:
> +      - const: fifo-empty
> +
> +  qcom,vmax-microvolt:
> +    description:
> +      Maximum allowed output driving voltage in microvolts, must be a multiple
> +      of 50,000 uV. This is the peak driving voltage in DIRECT_PLAY mode,
> +      which outputs sinusoidal waveforms. The value should be equal to the
> +      square root of 2 times the Vrms voltage of the LRA.
> +    minimum: 50000
> +    maximum: 10000000
> +    multipleOf: 50000
> +
> +  qcom,lra-period-us:
> +    description:
> +      LRA actuator initial resonance period in microseconds
> +      (1,000,000 / resonant_freq_hz).  Used to configure T_LRA-based play
> +      rates and the auto-resonance zero-crossing window. It could be also used
> +      as the initial period if the LRA wants to be driven off resonance.
> +    minimum: 5
> +    maximum: 20475
> +    multipleOf: 5
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-names
> +  - qcom,vmax-microvolt
> +  - qcom,lra-period-us
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    pmic {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        haptics@f000 {

No incomplete examples please. Put this in the example for the PMIC.

And please comment on sashiko report. Looks valid to me.

Rob
