Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01DA1F5842;
	Tue, 27 Jan 2026 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523370; cv=none; b=sbnDw2Sej4NszpYp5pDQKq1gzmAA/jEQPuOEOU1utCxCAGgG5Kf1Akqcnb98KvP9sAsYr0umymxmQexrqCOcH/6In3czJxnDdJ/ec1+95nifhSyOQp+uhmAdARN9l3LT55eisOQBDCzlBn8XT/tkPTAUT14vq7UpMChlDaVpjqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523370; c=relaxed/simple;
	bh=n45w/e+eBxNQzW3Y3a27ZkR2bgkFWFyAg7LB/8ubdr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ea1JXtqxuLWeIDkuZtmjaVsCUvUqg5UmhFiC9+EBytotJqP4XClsE8yaBD5snPv1HtPPtce5et8PVriL0hUYRckAUOLyafKsz8iUJy0QsKQo4cQYK82gLz3SY1VW/0YcB5vk4E7284uAHeaWV1+9NEPCjsg+7qw9CIMs6FA+308=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyY4dNMr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyY4dNMr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D196C116C6;
	Tue, 27 Jan 2026 14:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769523370;
	bh=n45w/e+eBxNQzW3Y3a27ZkR2bgkFWFyAg7LB/8ubdr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AyY4dNMr5eqHXSWq7PuRhGoNRgh82QPvdnFJ0MiS/3gvl05gNyD+M7W8DebnsIeOc
	 4RHGorjc1pYx9EWlBR4EIenTVKAg373EEUz/y4TRL3ROVF/sVwGMdDL12GRX9/zUJ/
	 /jC6nb1vW58Hz2c51r8ila3EsuIBq08E8jGYKOZ3dkHPGbjnDPDj3w4pEbE4ALdd+y
	 jqGX8dNecIQUv0Be0aRt0xcbk/WbEQfPFo72FVAWyEHC8qn65wgXrL0VJioJe/iw6G
	 0sBDZ2gnlvSX0o1U0xD9N0Z+clKyMUaBJ5mAWU4RkpLGqn8rpiv1fk7ogWgFL2VcmD
	 q+6A84AxFpvdQ==
Date: Tue, 27 Jan 2026 08:16:09 -0600
From: Rob Herring <robh@kernel.org>
To: Andrew Thomas <andrew.thomas@touchnetix.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH 1/2] dt-bindings: input: touchscreen: add TouchNetix
 aXiom device tree
Message-ID: <20260127141609.GA1565784-robh@kernel.org>
References: <20260126-axiom-driver-submission3-v1-0-d462c4a608e3@touchnetix.com>
 <20260126-axiom-driver-submission3-v1-1-d462c4a608e3@touchnetix.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126-axiom-driver-submission3-v1-1-d462c4a608e3@touchnetix.com>

On Mon, Jan 26, 2026 at 04:38:23PM +0000, Andrew Thomas wrote:
> ---

Also needs a commit message and S-o-b.

>  .../bindings/input/touchscreen/tnx,axiom.yaml      | 70 ++++++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml       |  2 +
>  2 files changed, 72 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/tnx,axiom.yaml b/Documentation/devicetree/bindings/input/touchscreen/tnx,axiom.yaml
> new file mode 100644
> index 000000000000..7b532471c17f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/tnx,axiom.yaml
> @@ -0,0 +1,70 @@
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

Don't need '|' if no formatting to preserve.

> +  The TouchNetix aXiom series are high-performance touchscreen controllers
> +  supporting various interface methods including I2C and SPI.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - tnx,axiom
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: Both IRQ_TYPE_LEVEL_LOW and IRQ_TYPE_EDGE_FALLING are supported
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +allOf:
> +  - $ref: touchscreen.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
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
> +            compatible = "tnx,axiom-i2c";
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
> +            compatible = "tnx,axiom-spi";
> +            reg = <0>;
> +            interrupt-parent = <&gpio>;
> +            interrupts = <24 IRQ_TYPE_EDGE_FALLING>;
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
> +    description: TouchNetix
>    "^topeet,.*":
>      description: Topeet
>    "^topic,.*":
> 
> -- 
> 2.43.0
> 
