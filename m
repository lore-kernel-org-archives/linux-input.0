Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5DB44E037;
	Fri,  9 Oct 2026 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791552137; cv=none; b=dhzu9FptNsOw+N8Tl5yNWAwddbPq4FGh9eNaW3cZB1/Djh5J3tEwLZxCK+IbHuQ6hnEVn7ZV3F18ds+4qg7an5qyhZyHan3/Q6XulKuxL3GeKaGEa6te4k/r2XhKInCT9Zp3u7tKkxc6FQlJLhxfKct8yhxpzkWNKBEkzqWvMNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791552137; c=relaxed/simple;
	bh=8qdU8cuLjGqqFd+/MED18daRxRSHDFMgb3xSEwS55Tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XoM3oSPBp+hsI7NUOxBwB/M3jNEEay4reccgbOZr5P9+9AxtpJAuOe4HYOE0LRJCYnpbNTLqO1DlMrmKNbD/JeYZch6a5wySngcMuwx0/GSGU6dcpBJJP3G9a8uEMe9rGvEQ61srh6FgzUMD4jLXISkFmfOEjL08k40WuvzSzOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7UgMt2W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7UgMt2W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02551F000FF;
	Fri,  9 Oct 2026 13:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791552135;
	bh=4WWqvJFHHfgVldJDJeEk1X97sBKOxnPJkE2IGIR0ioc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=d7UgMt2WI6B5pPIypbTGL29L/nUnl1aDsyeJSFykn9mIHgLJTunYhFQtzabKoNUZT
	 XESAG7fTxzwQTnE98D7N7zXgMaylrf2132d9OZpzDitlCsxRkmntdV59ecAmrco36E
	 +ctBBEVI04mzpOaWJv4qMOGNfgwHFEipx5tKSunDISYD7Mpf3emJAEV6e+Wv+DkN3e
	 pf4IohDc/SOm8dgOz0GppCZU0PrZ08Pl9z6e9PHulSVFlFzjWA337NefNeqRB5XuRo
	 zsgVTK8V6Hm5VCX+9TkFC3B957Q7uBPi+7aUw/6Xh0ZEps55rMSiZCZGfoq9IpwYsh
	 I2USibefOaK+Q==
Message-ID: <3541554a-ddac-494d-84ac-c8d485023bd3@kernel.org>
Date: Fri, 9 Oct 2026 15:22:09 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: input: add OnePlus pogo-pin keyboard
 binding
To: wyibo6109@gmail.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-input@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261009122046.551915-1-wyibo6109@gmail.com>
 <20261009122046.551915-2-wyibo6109@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261009122046.551915-2-wyibo6109@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/10/2026 14:20, wyibo6109@gmail.com wrote:

A nit, subject: drop second/last, redundant "binding". The "dt-bindings"
prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23


> +  touchpad-xy-max:
> +    description: Touchpad maximum X and Y coordinates in units.
> +    items:
> +      - description: maximum X
> +      - description: maximum Y
> +    minItems: 2
> +    maxItems: 2

None of this was tested. Anyway, use existing properties from
touchscreen schema for example or actually better explain why this is
not deducible from the compatible.

> +
> +  touchpad-xy-resolution:
> +    description: Touchpad X and Y resolution in units per millimetre.
> +    items:
> +      - description: X resolution
> +      - description: Y resolution
> +    minItems: 2
> +    maxItems: 2
> +
> +required:
> +  - compatible
> +  - power-gpios
> +  - tx-enable-gpios
> +  - wake-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    serial {
> +        #address-cells = <1>;
> +        #size-cells = <0>;

Drop node

> +
> +        keyboard {
> +            compatible = "oneplus,pogo-keyboard";
> +            power-gpios = <&pmic_gpios 12 GPIO_ACTIVE_HIGH>;
> +            tx-enable-gpios = <&pmic2_gpios 6 GPIO_ACTIVE_HIGH>;
> +            wake-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
> +            touchpad-xy-max = <2560 1440>;
> +            touchpad-xy-resolution = <24 25>;
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8014b9f82..e978a26c1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20149,6 +20149,13 @@ S:	Maintained
>  T:	git git://linuxtv.org/media.git
>  F:	drivers/media/i2c/ov9734.c
>  
> +ONEPLUS POGO-PIN KEYBOARD DRIVER
> +M:	Yibo Wang <wyibo6109@gmail.com>
> +L:	linux-input@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
> +F:	drivers/input/keyboard/oneplus-pogo-kbd.c

There is no such file.

> +
>  ONBOARD USB HUB DRIVER
>  M:	Matthias Kaehlcke <mka@chromium.org>
>  L:	linux-usb@vger.kernel.org


Best regards,
Krzysztof
