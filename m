Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4164DD3C9;
	Thu, 15 Oct 2026 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792054274; cv=none; b=gZifHR4UDTiMKaYrr/A0S9jrqoEnkRXVcTw8/PHugn9bgrSB+pKefOAJSKnvBF+3vMoHaoFPr/iHhrhrUXmYckD/G7of9+seWqCpgrr4szJasW3jrYB4YowrHe8RlRD9tYQGQeh0n3U7IpePDl51aXLYxTjz2ZvAO5Ib5ICyxPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792054274; c=relaxed/simple;
	bh=bMwWPEBQCG9rpn7heB52ms+Zuu9YDMaWktIXKrli2ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0B15LoN1nn8GZ3U8t18DQnnmIjw1jOEdnvXADOAN9bYOQdDnU1K8qiqna3E7aldFXTAW4a9UuLliP/5zSLRrCqea5fLCiB+Wa3V48jothHTWbswm/36PLDXOhwWe/VdyB2mYwQkOnZG8QOYR9Q7Nz0Ltx9tWAEdWypsnB+NW2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bl6hpvm2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bl6hpvm2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E04A1F000C5;
	Thu, 15 Oct 2026 08:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792054263;
	bh=tFnV7548W2cYAgOYdNjgr+r0IhqhLRq6V7QIU9EarGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bl6hpvm2/G34jtvGuymyBpQnb30BmSpm41F+bpgLGn/5Qwrknu3j/mc4FWfx1BHOG
	 EsSDzkKASK5ngSqNTxxPAr9OrYIkzzKNWVrO5KI0aNnXkbJB7Xo2+X1wQOrbQrzv7h
	 I+WdAxWYr+oxFHKwU5pCt5/3HGhZVKB/Khbbc+g2lNeDRRqHvXhq1cy8EQ7kbgjwIg
	 sFSKrXXNcFSfGq4RzLt7J04pVBpntNuWQGa4YUZgWMbuNXPMhtqj6vOEFVz6auLTgm
	 8Xrx4LaDLNNk7jmuQ3IDeVheVSOvnd6PsjTSjaurj1WSuvv2jhMuVwCKKZzxTxYDxC
	 zB/0nSVuORqoA==
Date: Thu, 15 Oct 2026 10:50:59 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: wyibo6109@gmail.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	linux-input@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: input: add OnePlus pogo-pin keyboard
Message-ID: <20261015-polite-barnacle-from-valhalla-b218eb@quoll>
References: <20261010143836.173883-1-wyibo6109@gmail.com>
 <20261014135251.11234-1-wyibo6109@gmail.com>
 <20261014135251.11234-2-wyibo6109@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014135251.11234-2-wyibo6109@gmail.com>

On Wed, Oct 14, 2026 at 08:52:50AM -0500, wyibo6109@gmail.com wrote:
> From: Yibo Wang <wyibo6109@gmail.com>
> 
> Binding for the Tinno keyboard MCU used by the OnePlus Pad 3 Pro /
> Pad 4 and OPPO Pad 5 Pro smart keyboards, attached to a tablet UART.
> Describes the supply, TX-gate and wake GPIOs, with a MAINTAINERS entry.
> 
> The compatible names the tablet project the pogo port belongs to
> (caihong, erhai or iceland), which pins the keyboard MCU generation
> and with it the protocol extensions the host may use: the 0x3A general
> sub-commands grew over time, from the caihong (sm8650 era) MCUs with
> neither wake notification nor backlight, through erhai (sm8750 era,
> wake notification) to iceland (sm8850 era, keyboard backlight).
> 
> The touchpad geometry and the product names are fixed per project and
> live in the driver; the common touchscreen properties
> (touchscreen-size-x/y, touchscreen-x-mm/y-mm) remain as an optional
> override if a variant ever needs one.

Why? It's fixed. It cannot be overridden. Your example DTS even shows
that.

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
> index 000000000..fa1579ed5
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
> +  The Tinno keyboard MCU used by the OnePlus Pad 3 Pro / Pad 4 and OPPO
> +  Pad 5 Pro smart keyboards.  It is attached to a tablet UART and speaks
> +  a framed half-duplex protocol over a shared single wire; host
> +  transmission is gated onto the wire by a PMIC GPIO for the duration of
> +  a frame.  The device provides a keyboard matrix, a touchpad and a
> +  keyboard backlight.
> +
> +allOf:
> +  - $ref: /schemas/serial/serial-peripheral-props.yaml#
> +  - $ref: /schemas/input/touchscreen/touchscreen.yaml#

So this is not really needed, drop

> +
> +properties:
> +  compatible:
> +    description: |
> +      Names the tablet project the pogo port belongs to, which pins the
> +      keyboard MCU generation and the protocol extensions the host may
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

Drop all four.

Best regards,
Krzysztof

