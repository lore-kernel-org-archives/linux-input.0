Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99B433B96B;
	Mon, 20 Apr 2026 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776693581; cv=none; b=gj/qbZZc2VZ4SWZhn7fdO3BnggphWVsu0hSmSI85IO7EM+DkR+6OUJCF1CWK0QelvOy+gvCFirQKv7CHKpxmLvoYP9CwhWXbMNVLsFiGkFPf+51EqUtbnj0ZsSJV0MexFLVE7XU1Me43HaFz3KcMAppHUTxnC/BKi2f1wxOmaoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776693581; c=relaxed/simple;
	bh=Qk9FZ+oE67kJLcTv95A0xV7cOG1EF5353kmvzuVgTDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NH4GWG+ujAlmGy56TYmSsLRa2Ro0VvTZ4A5H8AuEywYXYjeSqoJVa/1BD+FAadLrwBRr6InTUKH22KORxqIzm4rs+pS7emrfQTrZRs/4MmD7XEW8tp1JHz0hIEY+KyNHkIs9P+LNQkBUjva100ZhsCbH4kCmj3noxzEjsDq8KG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqlIbT6l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqlIbT6l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D565CC19425;
	Mon, 20 Apr 2026 13:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776693581;
	bh=Qk9FZ+oE67kJLcTv95A0xV7cOG1EF5353kmvzuVgTDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hqlIbT6lADMqJHJ/rJXvZi6LNNCmlpyO1aFuHxlfDVxj5EDiAfdCCIlzSJIo+s93R
	 U8K4GgRUKufbTYa/uhNXVeuyfUZTTxFlbFAOmLIx5HgEp5NFDM3jKaUj/nxwrxLcPR
	 mLYIyYsGFWs2Dd7d5Q1iHUJYSNfEFZsOd2YFoPBvZcpifCNzw8AweXdSRK60kY95O7
	 Dx/hFbbQUVUle55Tgs1rVwo+xn4TI9XfCA0Rox72qK01lpWzbxfAWQe4Y4Q6eoeqfa
	 VuzbUPmbfkY3rjqLCGhoI98VRGppWsYrtSHAyVlTKum102BaSQsKNcuyQC6Zoqpp+p
	 mGR1RP7TicAAw==
Date: Mon, 20 Apr 2026 15:59:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Harpreet Saini <sainiharpreet29@yahoo.com>
Cc: Rob Herring <robh@kernel.org>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: input: Add PixArt PAJ7620 gesture
 sensor
Message-ID: <20260420-impossible-muscular-junglefowl-5ec64c@quoll>
References: <20260418062241.104697-1-sainiharpreet29@yahoo.com>
 <20260418062241.104697-2-sainiharpreet29@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260418062241.104697-2-sainiharpreet29@yahoo.com>

On Sat, Apr 18, 2026 at 02:22:32AM -0400, Harpreet Saini wrote:
> The binding include mandatory power supplies (vdd, vbus, vled)

Drop this part

> and optional GPIO controller properties to describe the hardware's
> ability to repurpose SPI pins opeating in I2C mode.

And just explain what is the purpose of GPIO controller - is this a GPIO
controller?

Plus language typo, run spell check.

> 
> Signed-off-by: Harpreet Saini <sainiharpreet29@yahoo.com>
> ---
>  .../bindings/input/pixart,paj7620.yaml        | 79 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  2 files changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/pixart,paj7620.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/pixart,paj7620.yaml b/Documentation/devicetree/bindings/input/pixart,paj7620.yaml
> new file mode 100644
> index 000000000000..ad051cf641a6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/pixart,paj7620.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/pixart,paj7620.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PixArt PAJ7620 Gesture Sensor
> +
> +maintainers:
> +  - Harpreet Saini <sainiharpreet29@yahoo.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The PixArt PAJ7620 is a gesture recognition sensor with an integrated
> +  infrared LED and CMOS array. It communicates over an I2C interface and
> +  provides gesture data via a dedicated interrupt pin.
> +
> +properties:
> +  compatible:
> +    const: pixart,paj7620
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Main power supply.
> +
> +  vbus-supply:
> +    description: I/O and I2C bus power supply.
> +
> +  vled-supply:
> +    description: Power for the integrated IR LED.
> +
> +  linux,keycodes:
> +    minItems: 9
> +    maxItems: 9
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      List of keycodes mapping to the 9 supported gestures.
> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - vdd-supply
> +  - vbus-supply
> +  - vled-supply
> +

Missing allOf: with $ref to input.yaml schema. You use its properties.

Commit description said SPI, so missing ref to spi-peripheral-props.

> +additionalProperties: false

And this should be then unevaluatedProperties: false.

Best regards,
Krzysztof

