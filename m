Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D8D397691;
	Wed, 17 Jun 2026 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781692528; cv=none; b=F35cEHtNX9oMF4zPFMQEAl/YQe5KYeQedjxwl/ins+O7R9X1t8uIRScWQ97SASJws7r5L/1rtAH5AxfnljX404ooy/8u6s/iMbfpg0BOzyii3BqCUtznt8d5yLmNdhHeUBfI9eXLuRcZ0GI0oCOjKca1NwfUSRu4DctblwH+IMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781692528; c=relaxed/simple;
	bh=YATjfhdG8QJadKxAXqDFxyb+G7ogx/mrKisCPvJK/Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMitiZ/FXJhj0cJ4CBihAyNpuN6i6zeChNHEtIokZZSaHmBc5hqfJBSBQuufjw20peScG4KSw750SY3rdwsY8WSr4EPf3fWX429egAFraFwZyWeTkA1QSV9oIWK9ZqCEfjpG/j3EhWU6JDwPx+JYI+tY0EpUtP+5stMWEjF04uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0oupw+8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0oupw+8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204911F00A3D;
	Wed, 17 Jun 2026 10:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781692527;
	bh=x8xxlxTGEj0CZoc86q1lnJiZrWKHMAJXTF6mcwFVekw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d0oupw+8bQhJ6FI+Yrv0Ihjwaz7pEJazimtXdMkizqT+nuMUo49bH38tn7eEi1t+l
	 W8JM/I1es5iRk9bhbY6Bxou0oXYnkQsKHH9EbvF1K3urZGqP2nFFYenwVoAEIUJcqX
	 cMY1skh+z51NS1LmBpXR9a+y2wHo810dkHcinx29PPLyGkwv8Pk5UglsLQeXp/PC2g
	 Pj8pptN9nqIBTcbNqcTx8Yy4/blPntbatQoicEvmlm9VVePBn1ox4bawTYrCrgyJe8
	 meCGASEZthtPbzy1pJrJrLfHz/l7BQqS68Nv8JkkNT6hIVsGCJFG2Hlpz4xazrdBGX
	 xrB9LVVVVt+zg==
Date: Wed, 17 Jun 2026 12:35:22 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, David Collins <david.collins@oss.qualcomm.com>, 
	Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, 
	kernel@oss.qualcomm.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: input: Add binding for Qualcomm SPMI
 PMIC haptics
Message-ID: <20260617-wakeful-gorilla-of-feminism-75287c@quoll>
References: <20260616-qcom-spmi-haptics-v1-0-d24e422de6b4@oss.qualcomm.com>
 <20260616-qcom-spmi-haptics-v1-1-d24e422de6b4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260616-qcom-spmi-haptics-v1-1-d24e422de6b4@oss.qualcomm.com>

On Tue, Jun 16, 2026 at 03:08:24AM -0700, Fenglin Wu wrote:
> Add binding document for the haptics module inside Qualcomm PMIH010X.

A nit, subject: drop second/last, redundant "binding for". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23

> 
> Assisted-by: Claude:claude-4-6-sonnet
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> ---
>  .../bindings/input/qcom,spmi-haptics.yaml          | 119 +++++++++++++++++++++
>  1 file changed, 119 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml b/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml
> new file mode 100644
> index 000000000000..0e26d68563dc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml

Filenamem should match compatible.

> @@ -0,0 +1,119 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/qcom,spmi-haptics.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Haptics device inside Qualcomm Technologies, Inc. PMIH010X
> +
> +maintainers:
> +  - Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> +

...

> +properties:
> +  compatible:
> +    const: qcom,pmih010x-haptics

Don't use Claude. It does not understand DT. Please read writing
bindings document or DTS101 slides. You cannot have wildcards.

> +
> +  reg:
> +    items:
> +      - description: HAP_CFG module base address
> +      - description: HAP_PTN module base address
> +
> +  reg-names:
> +    items:
> +      - const: hap-cfg

cfg

> +      - const: hap-ptn

ptn

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    items:
> +      - const: fifo-empty
> +
> +  qcom,vmax-mv:

And claude did not tell you that this is not correct? If so, please
don't use it. It's crap tool if it cannot get the basics of DT (was
mentioned on talks many times, is documented etc).

You need proper suffix.


> +    description:
> +      Maximum allowed output driving voltage in millivolts, rounded to the
> +      nearest 50 mV step. This is the peak driving voltage in DIRECT_PLAY mode
> +      which outputs sinusoidal waveforms. The value should be equal to the square
> +      root of 2 times the Vrms voltage of the LRA.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 50
> +    maximum: 10000
> +
> +  qcom,lra-period-us:
> +    description:
> +      LRA actuator initial resonance period in microseconds
> +      (1,000,000 / resonant_freq_hz).  Used to configure T_LRA-based play
> +      rates and the auto-resonance zero-crossing window.

This does not feel like static characteristic. Isn't period depending on
intensity of vibration you want to have? Why would that be fixed per
board?

> +    minimum: 5
> +    maximum: 20475
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-names
> +  - qcom,vmax-mv
> +  - qcom,lra-period-us
> +

Best regards,
Krzysztof

