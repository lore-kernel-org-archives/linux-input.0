Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BA2311587;
	Mon, 23 Feb 2026 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771865436; cv=none; b=XoHibnay9m3evZ+02FRsRc7ie52UmA9pEBNSnSZAs2IhCh8o/3fq1dZ9dIG4n12p/4dh1otSQ8On+RPqn1aU50aycy/j2YmKpuyl0Sv5pAfLkQCkDbM3h0DTtiAip7jWzQCSdjBjEdJZBxgbUe1d78QHqcF+FH1KgwTz/DQpxK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771865436; c=relaxed/simple;
	bh=5FUFUNNmhYKmjnPqVvGI9LmWINDSSjBLzchYfC+FxkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/oJc7Iyi8YX9XeICuqtYhdwlQYMmY77t4+lBbi4SdPyQTzUgbEvWIuAfIILJXOBvkKtZ6aK5ZCDQ/qNhX+HwNlsOfvFrvcirPNXHwX089t4MKD7+FhCrpx7lrxpFvnpODjvylMfg5jf5Y4eCcJuQkIIzZ2cqklCx1aPbfKcu5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+edlso/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+edlso/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0515C116C6;
	Mon, 23 Feb 2026 16:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771865435;
	bh=5FUFUNNmhYKmjnPqVvGI9LmWINDSSjBLzchYfC+FxkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u+edlso/EZhKaVrGtLVUdZwr8/6tWM1xhc+AifCsZBlF2qIz/jJJhsk09oa3nbnzu
	 ls89/fONxyRxVv/gybux7wNpb17O3gXPVOlJDAsn+VtmUOmFUV6eyoNH0nQW6ZiHaz
	 ecLM2+rC7JKT43JebmsSsThYYecU25Z5LGT3bUPmgyHXbczFkQN9WjmiBT60I6v0Rh
	 K/DLBZfXdJxbDVBNzrYb49dYp7ofaTrMHBi1Dg00nto/4HnqoiISjBu9/lL0zygwjc
	 e5vNZLgmkY2u5arh7Q8PoE9iZh+4ZBqNWxcTSpNexilapSdZQFfn1lxH+8HGWpnEZk
	 Ic5DNdUzNpppQ==
Date: Mon, 23 Feb 2026 10:50:34 -0600
From: Rob Herring <robh@kernel.org>
To: Marc Paolo Sosa <marcpaolo.sosa@analog.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: input: add adi,max16150.yaml
Message-ID: <20260223165034.GA3975976-robh@kernel.org>
References: <20260223-max16150-v1-0-38e2a4f0d0f1@analog.com>
 <20260223-max16150-v1-1-38e2a4f0d0f1@analog.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-max16150-v1-1-38e2a4f0d0f1@analog.com>

On Mon, Feb 23, 2026 at 07:03:39PM +0800, Marc Paolo Sosa wrote:
> Add documentation for device tree bindings for MAX16150/MAX16169
> 
> Signed-off-by: Marc Paolo Sosa <marcpaolo.sosa@analog.com>
> ---
>  .../devicetree/bindings/input/adi,max16150.yaml    | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/adi,max16150.yaml b/Documentation/devicetree/bindings/input/adi,max16150.yaml
> new file mode 100644
> index 000000000000..327811e1ebd4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/adi,max16150.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/adi,max16150.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices MAX16150/MAX16169 nanoPower Pushbutton On/Off Controller
> +
> +maintainers:
> +  - Marc Paolo Sosa <marcpaolo.sosa@analog.com>
> +
> +description:
> +  The MAX16150/MAX16169 is a low-power pushbutton on/off controller with a
> +  switch debouncer and built-in latch. It accepts a noisy input from a
> +  mechanical switch and produces a clean latched output, as well as a one-shot
> +  interrupt output.
> +
> +properties:
> +  compatible:
> +    description:
> +      Specifies the supported device variants. The MAX16150 and MAX16169 are supported.

Drop description.

> +    enum:
> +      - adi,max16150a
> +      - adi,max16150b
> +      - adi,max16169a
> +      - adi,max16169b

What's the diff between a and b? If nothing s/w needs to know about, 
then maybe you don't need to distinguish. 

> +
> +  interrupt-gpio:
> +    maxItems: 1

Use 'interrupts' property.

> +
> +  clr-gpios:
> +    description:
> +      Clear Input. Pulling CLR low deasserts the latched OUT signal. If OUT is
> +      already deasserted when CLR is pulled low, the state of OUT is unchanged.
> +    maxItems: 1
> +
> +  linux,code:
> +    default: KEY_POWER
> +
> +required:
> +  - compatible
> +  - interrupt-gpios
> +  - clr-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/input/linux-event-codes.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    power-button {
> +        compatible = "adi,max16150a";
> +        interrupt-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
> +        clr-gpios = <&gpio 4 GPIO_ACTIVE_LOW>;
> +        linux,code = <KEY_POWER>;
> +    };
> 
> -- 
> 2.34.1
> 
