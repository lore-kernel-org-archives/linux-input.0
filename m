Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1441423ED75;
	Fri, 23 Jan 2026 07:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769153241; cv=none; b=LUlXDUvb1AcUPQL1cx4oIHlfdTQoVz3gRcDgoIr4BWA9toiqjeKKev+/FlaYFRACJDkBMO37HhIax2KzMamK4R5NgAKCbgb0D7RaoGlkmb4EF/nnmnDyKY3bDfRYfnq3QCo73UJTaUqjab3wSZopiClVg5kJx6BtIw0Osv0PvgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769153241; c=relaxed/simple;
	bh=79p3z4VPv5mIFODDoINq5qm+b261Wuna9bqtKWhKrN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ncTtcDjWzjxTSkhgrlz6ejZkCD58ch1MCFHlzTqnqDgnjMXLv8CL2Oc3T/Rtoue2OWUtQPZWl6F3u6NNx8DBlX4Ncbm5RfETshEEt6sxkqFAtJVpDY9dD0xYet0DLHHPFkwASLJo5ebuxFn3X57n0PUwDaaVqhHfxwL/AR8kpsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNtoxOix; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNtoxOix"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100F6C4CEF1;
	Fri, 23 Jan 2026 07:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769153240;
	bh=79p3z4VPv5mIFODDoINq5qm+b261Wuna9bqtKWhKrN4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kNtoxOixlGonhX14LDPfAei/Rftnd+oLtSOsbJz6CXD1XC0pdp6FqEWBFYoy+5hRc
	 0zP1sAOn0hy4xa1XVmLr3vPecPZNbhAViCe/KwCbSgrPNaGJEQL0GMtUGX+26WVs1o
	 cSBMeK76QKw4DTSYWv7mTgoNBnOeETcDGiFGlT0xPuuukwArjGzol0gnGUpgYLHUJ0
	 bYTQjkW1LFOZRSjYwqUnzMGEsEO47/5WSGJtqVQS8pNVU/38KO/H506s5jWRY3tgQg
	 ymO61PVzjFNZoIgqBSo2QjRCDon/Ol6GxhmBakQt4Z98t/RFAvRWqkI4sjnxX8syip
	 AMk5Yu4c0VTFA==
Message-ID: <c6fabbcc-4a18-446c-b97e-944cfd23b87e@kernel.org>
Date: Fri, 23 Jan 2026 08:27:17 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] dt-bindings: input: Add TouchNetix aXiom touchscreen
 driver
To: AThomas63 <andrew.thomas@touchnetix.com>, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 mark.satterthwaite@touchnetix.com, m.felsch@pengutronix.de,
 kamel.bouhara@bootlin.com
References: <20260122124819.273188-1-andrew.thomas@touchnetix.com>
 <20260122144052.358956-1-andrew.thomas@touchnetix.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260122144052.358956-1-andrew.thomas@touchnetix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/01/2026 15:40, AThomas63 wrote:
> Add extra changes referenced in the previous patch:

Not relevant.


>  - Add device tree documentation for axiom giving examples for SPI and I2C.
>  - Add tnx vendor prefix.

Please start using b4 or use known (described) workflows with git. Look
at the subject - why is this just one patch not 1/2? Patchsets are made
git format-patch -2 (-vX if needed).

And then:
Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

Tools like b4 or scripts/get_maintainer.pl provide you proper list of
people, so fix your workflow. Tools might also fail if you work on some
ancient tree (don't, instead use mainline) or work on fork of kernel
(don't, instead use mainline). Just use b4 and everything should be
fine, although remember about `b4 prep --auto-to-cc` if you added new
patches to the patchset.

You missed at least devicetree list (maybe more), so this won't be
tested by automated tooling. Performing review on untested code might be
a waste of time.

Please kindly resend and include all necessary To/Cc entries.


> 
> ---
>  .../bindings/input/touchscreen/tnx,axiom.yaml | 90 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  2 files changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/tnx,axiom.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/tnx,axiom.yaml b/Documentation/devicetree/bindings/input/touchscreen/tnx,axiom.yaml
> new file mode 100644
> index 000000000000..dc2ea62999b8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/tnx,axiom.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/touchscreen/tnx,axiom.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TouchNetix aXiom Touchscreen Controller
> +
> +maintainers:
> +  - Andrew Thomas <andrew.thomas@touchnetix.com>
> +
> +description: |


> +  The TouchNetix aXiom series are high-performance touchscreen controllers
> +  supporting various interface methods including I2C and SPI.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - tnx,axiom-i2c
> +      - tnx,axiom-spi

No, these are the same. Use only one describing the device.

No device model? Really?

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  axiom,poll-enable:

There is no such company as axiom. You just said it is tnx.
> +    type: boolean
> +    description: Enable aXiom polling mode instead of interrupt-driven 
> +      reporting.

Anyway, drop entire property. Not a DT suitable, not hardware.

> +
> +  axiom,poll-period:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 10
> +    description: Set the polling period in milliseconds.

Drop entire property.

> +
> +  # Required for SPI
> +  spi-max-frequency: true

Drop. Not needed.

> +
> +  # Common touchscreen properties
> +  touchscreen-size-x: true
> +  touchscreen-size-y: true
> +  touchscreen-inverted-x: true
> +  touchscreen-inverted-y: true
> +  touchscreen-swapped-x-y: true

Drop all.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +allOf:
> +  - $ref: touchscreen.yaml#

Missing ref to spi-periph.

Look at other bindings instead of inventing your own.

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        touchscreen@66 {
> +            compatible = "touchnetix,axiom-i2c";
> +            reg = <0x66>;
> +            interrupt-parent = <&gpio>;
> +            interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
> +            axiom,poll-enable;
> +            axiom,poll-period = <15>;
> +        };
> +    };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        touchscreen@0 {
> +            compatible = "touchnetix,axiom-spi";
> +            reg = <0>;
> +            spi-max-frequency = <4000000>;
> +            interrupt-parent = <&gpio>;
> +            interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index f1d1882009ba..dadfc7036ed7 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1636,6 +1636,8 @@ patternProperties:
>      description: Trusted Logic Mobility
>    "^tmt,.*":
>      description: Tecon Microprocessor Technologies, LLC.
> +  "^tnx,.*":

Domain is touchnetix, so that's your prefix.

> +    description: TouchNetix
>    "^topeet,.*":
>      description: Topeet
>    "^topic,.*":


Best regards,
Krzysztof
