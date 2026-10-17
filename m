Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9803CB2FD;
	Sat, 17 Oct 2026 18:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792260110; cv=none; b=m2uL+8Xs3ooDU0QqhPWoFBYW6e0A5UKZRUTRgajl7xwE+HWYOEMyPOShRHUQFcSSIRR1z6oyrw+/eAybOAkUi6QQ7m+/g91FLEMlefekfXguBMVf7CyjO2kICZVG4nbvHC8AaQBM3QlAy/njri1WHC1HFFtXtGB+K8JC4sdPUbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792260110; c=relaxed/simple;
	bh=ovdzQPg0KZPJpC8SYBiXxj7Ho0A3Jt0PGcwGBLWGek4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2kVbBqcMWWVqUVzaOwQzUgXD3N9AcIEDKAYYtNV6EaXQdgg81uZISzn/ZgxMBpreatfwkPaAIud8Wo4nYAjKrpMhWG4ghLRarhoqINEJVVNKCAipZFKeqsnzB04A8UecOC2Cx/W50sz8hCWBxwBo9ZYmKKOOie8ktNMoIpfp6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Egin5z6d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Egin5z6d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CD61F000CB;
	Sat, 17 Oct 2026 18:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792260108;
	bh=97pYc+O+9TdLZnqQyCCZ9T422NQvkmilLyx9fsARpLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Egin5z6dkjHv1KedYstFBAZHvUksI1EM2N6isPAi1MDylAHSnKGudPp51CDLFKbJi
	 lNy36BIcpcpUJonBEzGkeDeAiRigrZP/h107Drhlypz7104HdZuliDVSlw7Dmcjxjn
	 Qs6yy5h4tRETSpAKQePve/i8SJw6DBZlEDU/aO4wkJbe8kcaoXQKuqC8bdOsrgnoHq
	 uM3BCLSF7ZQB/UpJIOKn7OY7EJueO6xBKeRkuzdEzbwTG0qrhsVxIdc09YbIX7gGb8
	 f2TdFzcav3rhMaLrNECz7yfojNACcEQCQ4J4eeA8XR956P8EKntSpvtP+z5bHJ3r8A
	 M8rdmBjC2wIXg==
Date: Sat, 17 Oct 2026 20:01:45 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: wyibo6109@gmail.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	linux-input@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: input: add OnePlus pogo-pin keyboard
Message-ID: <20261017-literate-prudent-walrus-dc6dad@quoll>
References: <20261016163859.1070138-1-wyibo6109@gmail.com>
 <20261016163859.1070138-2-wyibo6109@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261016163859.1070138-2-wyibo6109@gmail.com>

On Fri, Oct 16, 2026 at 11:38:58AM -0500, wyibo6109@gmail.com wrote:
> From: Yibo Wang <wyibo6109@gmail.com>
> 
> Binding for the OnePlus Pad 3 Pro / Pad 4 and OPPO Pad 5 Pro pogo-pin
> smart keyboards, built around a Tinno keyboard MCU and attached to a
> tablet UART.  Describes the supply, TX-gate and wake GPIOs, with a
> MAINTAINERS entry.
> 
> The compatible names the tablet project the pogo port belongs to
> (caihong, erhai or iceland), which pins the keyboard generation and
> with it the protocol extensions the host may use: the 0x3A general
> sub-commands grew over time, from the caihong (sm8650 era) keyboards
> with neither wake notification nor backlight, through erhai (sm8750
> era, wake notification) to iceland (sm8850 era, keyboard backlight).
> 
> The keyboard is a fixed physical device, so the touchpad geometry and
> the product names are per-project constants and live in the driver;
> the common touchscreen properties (touchscreen-size-x/y,
> touchscreen-x-mm/y-mm) remain as an optional override if a variant
> ever needs one.
> 
> The binding documentation was prepared with the assistance of an AI
> language model; the technical content was reviewed, adjusted and
> validated by the author.
> 
> Assisted-by: Z.ai:GLM-5.3

LLM

> Signed-off-by: Yibo Wang <wyibo6109@gmail.com>
> ---
>  .../bindings/input/oneplus,pogo-keyboard.yaml | 76 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml b/Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
> new file mode 100644
> index 000000000..78d398912
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2026 Yibo Wang <wyibo6109@gmail.com>
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/oneplus,pogo-keyboard.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: OnePlus / OPPO Pad pogo-pin smart keyboard
> +
> +maintainers:
> +  - Yibo Wang <wyibo6109@gmail.com>
> +
> +description:
> +  The OnePlus Pad 3 Pro / Pad 4 and OPPO Pad 5 Pro pogo-pin smart
> +  keyboards, built around a Tinno keyboard MCU.  The keyboard is
> +  attached to a tablet UART and speaks a framed half-duplex protocol
> +  over a shared single wire; host transmission is gated onto the wire
> +  by a PMIC GPIO for the duration of a frame.  It provides a keyboard
> +  matrix, a touchpad and a keyboard backlight.
> +
> +allOf:
> +  - $ref: /schemas/serial/serial-peripheral-props.yaml#
> +  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
> +
> +properties:
> +  compatible:
> +    description: |
> +      Names the tablet project the pogo port belongs to, which pins the
> +      keyboard generation and the protocol extensions the host may
> +      use: caihong (sm8650 era) supports neither the wake notification
> +      nor a backlight, erhai (sm8750 era) adds the wake notification,
> +      iceland (sm8850 era) adds the keyboard backlight.
> +    enum:
> +      - oneplus,caihong-pogo-keyboard
> +      - oneplus,erhai-pogo-keyboard
> +      - oneplus,iceland-pogo-keyboard
> +
> +  power-gpios:
> +    description:
> +      GPIO enabling the keyboard supply, held high while attached.
> +    maxItems: 1
> +
> +  tx-enable-gpios:
> +    description: GPIO gating host TX onto the shared one-wire bus.
> +    maxItems: 1
> +
> +  wake-gpios:
> +    description: GPIO signalling attach/detach, also used as the wake line.
> +    maxItems: 1
> +
> +  touchscreen-size-x: true
> +  touchscreen-size-y: true
> +  touchscreen-x-mm: true
> +  touchscreen-y-mm: true

We agreed to drop all these.


> +
> +required:
> +  - compatible
> +  - power-gpios
> +  - tx-enable-gpios
> +  - wake-gpios
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    serial {
> +        keyboard {
> +            compatible = "oneplus,iceland-pogo-keyboard";
> +            power-gpios = <&pmic_gpios 12 GPIO_ACTIVE_HIGH>;
> +            tx-enable-gpios = <&pmic2_gpios 6 GPIO_ACTIVE_HIGH>;
> +            wake-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8014b9f82..9c29eb961 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20156,6 +20156,12 @@ S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-dev
>  F:	drivers/usb/misc/onboard_usb_dev.c
>  
> +ONEPLUS POGO-PIN KEYBOARD DRIVER

P > N

> +M:	Yibo Wang <wyibo6109@gmail.com>
> +L:	linux-input@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
> +
>  ONENAND FLASH DRIVER

Best regards,
Krzysztof

