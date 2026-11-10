Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302428;
	b=AcflF8C9tLHuujxerfPRArGxbMvb1SR3JqG8US3kav9C9idOKqpt8VxQj6mKUXltzXZu
	 juyHqdYqfReEOMwT7cLGGCd6nmLlMOpup9MBs2olE9gi2zHEIsdafdq8pGqjX1Usmwt+S
	 xHvpoSFr08chlGzv7Q7tth4w4zaLTWOudkIjUVEa9d5miylwvs93Ff1Kcl5gvRwUyAgKf
	 XWBhxMaG8zm9YBCXWZmmL9M6ugiGFllJGavdCFFn2AiY8BxwLeYUMwO3t5unYTVv+7i02
	 uhLGP9+VGJeAgrDEnHGxpVIJXRySggvdeW7v+rY0xTfVt1gKM90KLO03Dx+Dal7EfqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302428;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cSWIafk7ikiCCY+OyvdNor7sWV+uHSYsERPSHy5tkIM=;
	b=3vRccQB+mPAwcn5XI+Weac9T1SwIDbuX3qPn94+a+BmJeq0pe9+VGnUwg8QLNdnrUz+u
	 5b1NDqD1U1rki/53ShW1vbPBjFc0A3K/ADq+Dn/PU/u4MlWSaif+yg0a8OiqCNEhV6i0h
	 hxBgZ5Okcu0nbyEIVqwmEOT1XLRizenfzoCsmgdLdfuWT63BnpkVijyDEegSRUD+BdCr9
	 hwVzZ8zzujalAb/Pav6nS/sqX0KF8ZHM57QMrh5lcNiWYbzjv4x2qNBEAfzq7V91unWEU
	 2vmuGdRTGjyYA4LFRCBRk3tT81ESjBeSmHyM9gN8C38TP6PqORq5ynVHXCgJee3o7Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WEdAJIaY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070DA607FB5A;
	Tue, 10 Nov 2026 09:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WEdAJIaY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4AC1F0089F;
	Tue, 10 Nov 2026 09:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302427;
	bh=cSWIafk7ikiCCY+OyvdNor7sWV+uHSYsERPSHy5tkIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WEdAJIaYOybMdnxp8lc5A/tcQ1/l8K75skGyY/pa5rMXczpT03UtV/cTttuq/Uesf
	 UhydKLbscaLxCGDmtfoibbmWWRc9x0IP4cxao7rCCYhRzPoNwPkuwLem4eljHoi9Lo
	 wnLaBje8gtyfehzvLux2So3ofm5WIwEmH+1wZWJXiNWtU/INDo9fmWiyl3EPuxSkKf
	 gwdSSJWD9WW38Sl+GZtqEPEDRXHMdxJmTNdEfyYoal9dG7NKf5mdWl0XSs5eiLEDk9
	 yKCqZ/nFz1B52u7+axUPmWeELgGsbe39k2vv6hLItpHhCYbs3Ur0H7xZv+Ya1UMxHY
	 0aLhi1hftZd0A==
Date: Tue, 10 Nov 2026 10:20:23 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michael Reeves <michael.reeves077@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-input@vger.kernel.org
Subject: Re: [PATCH v5 2/8] dt-bindings: input: apple: Add DockChannel HID
 transport
Message-ID: <20261110-accurate-unselfish-cockle-3a39bd@quoll>
References: <20261108-b4-apple-mtp-keyboard-v5-0-e2c97b82669a@gmail.com>
 <20261108-b4-apple-mtp-keyboard-v5-2-e2c97b82669a@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261108-b4-apple-mtp-keyboard-v5-2-e2c97b82669a@gmail.com>

On Sun, Nov 08, 2026 at 07:25:07AM +0000, Michael Reeves wrote:
> +description:
> +  HID transport for keyboard and trackpad devices connected via the
> +  DockChannel FIFO mailbox on Apple Silicon SoCs. The endpoint includes a
> +  small RTKit coprocessor called MTP which must be booted before the HID
> +  transport becomes available.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:

Just an enum instead of items and const below.

> +          - const: apple,t8112-dockchannel-hid



> +      - items:
> +          - enum:
> +              - apple,t6020-dockchannel-hid
> +              - apple,t6030-dockchannel-hid
> +              - apple,t6031-dockchannel-hid
> +              - apple,t8122-dockchannel-hid
> +          - const: apple,t8112-dockchannel-hid
> +
> +  reg:
> +    items:
> +      - description: Coprocessor ASC registers
> +      - description: Coprocessor SRAM/mailbox registers
> +
> +  reg-names:
> +    items:
> +      - const: asc
> +      - const: sram
> +
> +  mboxes:
> +    items:
> +      - description: ASC mailbox used for RTKit control
> +      - description: DockChannel FIFO mailbox used for HID packets
> +
> +  mbox-names:
> +    items:
> +      - const: asc
> +      - const: dockchannel
> +
> +  iommus:
> +    maxItems: 1
> +
> +  apple,has-stm:
> +    type: boolean
> +    description:
> +      Specifies that the coprocessor provides STM device and serial
> +      number query endpoints that must be ready before registering HID devices.

Isn't this implied by the compatible?

> +
> +  hid-country-code:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      HID country code for the keyboard layout variant.

What is the meaning of values? Do they map to any existing ABI? Like USB
HID? Otherwise, why country code is 32 bit integer instead of ISO3166
codes? As pointed last time, this should go probably to a common hid
schema.

No default? Not required?

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - mboxes
> +  - mbox-names
> +  - iommus
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        hid@24e400000 {
> +            compatible = "apple,t8112-dockchannel-hid";
> +            reg = <0x2 0x4e400000 0x0 0x4000>,
> +                  <0x2 0x4ec00000 0x0 0x100000>;
> +            reg-names = "asc", "sram";
> +            mboxes = <&mtp_mbox>, <&mtp_dockchannel>;
> +            mbox-names = "asc", "dockchannel";
> +            iommus = <&mtp_dart 1>;
> +            apple,has-stm;
> +            hid-country-code = <0>;

Which country is 0? Isn't this just a default?


> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0c1963150f04..41b12717c657 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2714,6 +2714,7 @@ F:	Documentation/devicetree/bindings/gpio/apple,smc-gpio.yaml
>  F:	Documentation/devicetree/bindings/gpu/apple,agx.yaml
>  F:	Documentation/devicetree/bindings/hwmon/apple,smc-hwmon.yaml
>  F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
> +F:	Documentation/devicetree/bindings/input/apple,t8112-dockchannel-hid.yaml
>  F:	Documentation/devicetree/bindings/input/touchscreen/apple,z2-multitouch.yaml
>  F:	Documentation/devicetree/bindings/interrupt-controller/apple,*
>  F:	Documentation/devicetree/bindings/iommu/apple,dart.yaml
> 
> -- 
> 2.56.0
> 
