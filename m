Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B3B1DF736;
	Thu, 15 Oct 2026 20:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095351; cv=none; b=FzKWSZmmxecObMt8wpwwA1MpzSv+hnzpsA7ZlYv90TYezo5hV649Pl5HhEnqOvhytJW4oMfOPeWA6JdbimRwZxRKNdmcEma5zhnyH/bLbw5c6PdoeFS2zoFwzs01nXfIg4VyQ5vc0BHjN84yfXYCwog+P6NWzTYRE3jW+vd+QbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095351; c=relaxed/simple;
	bh=oSltm9idK3HnaWKPb7Wygo/c96CShr/Ox7Wjwpt67Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbp2ie6ml6bKIuJSpKwIu2QInRdVQSKqbcc7t/ZsaJrdY/fmtpGL9nraR/TXvR7M8FCEwx1IWI9/nSV6UzvKdD8Y9TdPyCZp1Wsxc4o7y7k/5TlzSy+qLPGJ9RlI5Y3KY77yp9fQMO4g1A6SQxjYbLLPWHCfjYIPSdY51ZuhBSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWH/FZro; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWH/FZro"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5DD1F000C4;
	Thu, 15 Oct 2026 20:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792095349;
	bh=6Mf+CP8MgReqGg6hHqGvrbor5AhWhA2wwP193zlZpLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KWH/FZrowMlshoFECXu965UkYoGuoM8nYnAQD4H6jEWBtkOIFEK1h3YuuMzf/LCsJ
	 P5aMTHCdeBq5gYjJ78xAj2A1BYnbMac/K1vXbzl7oIZSHm3ilLaEKsAsnvvl2m7nmk
	 CwvEEDqxX68gPJgdAi94McHMuCQHvMnq8ZhIJXwt8W1U5urpBEO7J3lfl2vdpJwDWX
	 WWo/XmseeEDoe0XiCGrnKvblGyfvOtnE7Z7FM2bQN4zOlKSWwSL5V6acpOZHUu3YWt
	 lsey81JwnLbk1c2iJwmvkoNDY7p4EtOJsv2iHTLoIw/OON/cuxeCeYuHyp6Dgj6ZkH
	 Ki97BZgS7t+8w==
Date: Thu, 15 Oct 2026 15:15:47 -0500
From: Rob Herring <robh@kernel.org>
To: wyibo6109@gmail.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: input: add OnePlus pogo-pin keyboard
Message-ID: <20261015201547.GA2868930-robh@kernel.org>
References: <20261014135251.11234-1-wyibo6109@gmail.com>
 <20261015110859.203989-1-wyibo6109@gmail.com>
 <20261015110859.203989-2-wyibo6109@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015110859.203989-2-wyibo6109@gmail.com>

On Thu, Oct 15, 2026 at 06:08:58AM -0500, wyibo6109@gmail.com wrote:
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
> Signed-off-by: Yibo Wang <wyibo6109@gmail.com>
> ---
>  .../bindings/input/oneplus,pogo-keyboard.yaml | 73 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml b/Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
> new file mode 100644
> index 000000000..bab9ff3d3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
> @@ -0,0 +1,73 @@
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
> +description: |

Don't need '|'.

> +  The OnePlus Pad 3 Pro / Pad 4 and OPPO Pad 5 Pro pogo-pin smart
> +  keyboards, built around a Tinno keyboard MCU.  The keyboard is
> +  attached to a tablet UART and speaks a framed half-duplex protocol
> +  over a shared single wire; host transmission is gated onto the wire
> +  by a PMIC GPIO for the duration of a frame.  It provides a keyboard
> +  matrix, a touchpad and a keyboard backlight.

Wrap lines at 80 char.

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
> +    description: GPIO enabling the keyboard supply, held high while attached.
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

As this goes under 'serial' nodes:

serial {

> +    keyboard {
> +        compatible = "oneplus,iceland-pogo-keyboard";
> +        power-gpios = <&pmic_gpios 12 GPIO_ACTIVE_HIGH>;
> +        tx-enable-gpios = <&pmic2_gpios 6 GPIO_ACTIVE_HIGH>;
> +        wake-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
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
> +M:	Yibo Wang <wyibo6109@gmail.com>
> +L:	linux-input@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
> +
>  ONENAND FLASH DRIVER
>  M:	Kyungmin Park <kyungmin.park@samsung.com>
>  L:	linux-mtd@lists.infradead.org
> -- 
> 2.53.0
> 
