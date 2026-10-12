Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2794718C2;
	Mon, 12 Oct 2026 09:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795741; cv=none; b=Lm8wLZhNLu89Pkr7gGeKbpKCsI78OgEdWWy6Eikkv0XAH/rIgFE23ByRPau8W7CKVi7mQg6jVG/o9bD0vq29DpJxnV+45O0lOApzGMaUMAfEM2Q3qUru8019s6e8r2kCCaY5RU9V9/N7pnQWfhKQOdJJnLFZ9k7yQGSu7SWkRZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795741; c=relaxed/simple;
	bh=X22Ii8fVS91w5o1Tbk9+OJ4WQDn9b7L0ZSnEM9egT5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdKEQsfx8VHnVsRBdoe9YlZV9sYTKJuCw/lOUi9OjxmhryEEoGCQEsFXQNpWXboSBejNG+OYesM5YwG5QKOWELF2kNoWTJqoHFtj4dhx0u3fSNrjA49L/+7EXsGH3uc4edH0ltm5u5diJmCYSE+4MbQ5+PQt3cEEAGx3SnP0JaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ajj58E8O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ajj58E8O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE1E1F0089B;
	Mon, 12 Oct 2026 09:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791795739;
	bh=7APZHECUIrtGta9h9OdifIfB94cMsU17ySOM5eqdn08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ajj58E8Oz3R6V64OU5VyD3wwBTJz/+FGXTy+VqcP5xTe5X3seMurF1XpyLNJCuCGM
	 9QqbZ6cgSWC8eHOBhZLFVvL6XzqufT4nyyipM2o6hnyRKFafXFHG2XcHNyLjkOJ2a+
	 H7pV06QDeWaiQyBcN9m6sRMO3mq3Izjl/V+v4OGCIO6pAOq2mhwVgRHKHsxdNKIXsz
	 LVT67HlA1UKasbmjCc6nDa3XL4vK/Wi08uuvJfyu8jCVDtPYVrE6JaMhVZE8JsTpVP
	 iDgNA8wjJtADiRlxrZBtoy2PTrsyW0KB1qWAZ2bJxLUGAVKeU0IloeAxcTE2V0sabP
	 TCclBJv9akXKA==
Date: Mon, 12 Oct 2026 11:02:15 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Miotsuki Mizuno <founder@crepuse.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "icenowy@aosc.io" <icenowy@aosc.io>, 
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: input: touchscreen: add Nsiway NS2009
Message-ID: <20261012-vivacious-mackerel-from-mars-df194a@quoll>
References: <20261009144729.85832-1-founder@crepuse.com>
 <20261011054223.93396-1-founder@crepuse.com>
 <20261011054223.93396-3-founder@crepuse.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261011054223.93396-3-founder@crepuse.com>

On Sun, Oct 11, 2026 at 05:42:29AM +0000, Miotsuki Mizuno wrote:
> Describe the Nsiway NS2009 four-wire resistive touchscreen controller,
> including its optional active-low pen interrupt, power and external
> reference supplies, and touch resistance measurement capabilities.
> 
> Allow the common X-plate resistance and pressure properties. Include
> both an interrupt/supply example and a minimal example for a board with
> an unconnected pen interrupt.
> 
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hm? How Dmitry could suggest you to write bindings for your device?

> Signed-off-by: Mizuno Miotsuki <founder@crepuse.com>

Same problem as v1.

> ---
>  .../input/touchscreen/nsiway,ns2009.yaml      | 104 ++++++++++++++++++
>  MAINTAINERS                                   |   6 +
>  2 files changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/nsiway,ns2009.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/nsiway,ns2009.yaml b/Documentation/devicetree/bindings/input/touchscreen/nsiway,ns2009.yaml
> new file mode 100644
> index 000000000000..43523f40dcb8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/nsiway,ns2009.yaml
> @@ -0,0 +1,104 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/touchscreen/nsiway,ns2009.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nsiway NS2009 resistive touchscreen controller
> +
> +maintainers:
> +  - Mizuno Miotsuki <founder@crepuse.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The NS2009 is a four-wire resistive touchscreen controller connected over
> +  I2C, with a 12-bit ADC, an active-low pen interrupt output, and support
> +  for an external ADC reference voltage. Touch resistance can be calculated
> +  from the X coordinate, Z1 and Z2 measurements, and the X-plate resistance.
> +  Coordinates are 12-bit ADC readings, not display pixel coordinates.
> +
> +allOf:
> +  - $ref: touchscreen.yaml#
> +
> +properties:
> +  compatible:
> +    const: nsiway,ns2009
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Active-low pen interrupt output. Optional when the signal is not
> +      connected.
> +
> +  wakeup-source: true
> +
> +  vdd-supply:
> +    description: Main power supply.
> +
> +  vref-supply:
> +    description: External ADC reference voltage supply.
> +
> +  touchscreen-x-plate-ohms: true
> +  touchscreen-max-pressure: true
> +  touchscreen-fuzz-pressure: true
> +
> +  touchscreen-min-pressure:
> +    minimum: 1
> +    maximum: 4095
> +    default: 80
> +    description:
> +      Minimum raw Z1 reading considered a touch. This is a contact detection
> +      threshold, not a calibrated pressure value. Boards may require a higher
> +      empirically determined threshold than the historical driver default.
> +
> +  touchscreen-min-x: true
> +  touchscreen-min-y: true
> +  touchscreen-size-x: true
> +  touchscreen-size-y: true
> +  touchscreen-fuzz-x: true
> +  touchscreen-fuzz-y: true
> +  touchscreen-inverted-x: true
> +  touchscreen-inverted-y: true
> +  touchscreen-swapped-x-y: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false

Just make it unevaluatedProperties: false and drop all "true"
properties.

> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        touchscreen@48 {
> +            compatible = "nsiway,ns2009";
> +            reg = <0x48>;
> +            touchscreen-min-pressure = <150>;
> +            touchscreen-inverted-y;
> +        };
> +    };
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        touchscreen@48 {
> +            compatible = "nsiway,ns2009";
> +            reg = <0x48>;
> +            interrupt-parent = <&gpio1>;
> +            interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> +            wakeup-source;
> +            vdd-supply = <&vdd>;
> +            vref-supply = <&vref>;
> +            touchscreen-x-plate-ohms = <400>;
> +            touchscreen-max-pressure = <4095>;
> +            touchscreen-fuzz-pressure = <16>;
> +        };
> +    };

One complete example.

Best regards,
Krzysztof

