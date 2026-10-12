Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FD2433E81;
	Mon, 12 Oct 2026 11:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791804657; cv=none; b=uY99BdQ5pD/pxPNSAdci15K38qU2Mz7rHV0Uy6Ih/Y1XSPMteeC+6t1yCrlCePrD9gWIgyLY33UEovbOY6d2kD2l9IHGIqyWOu/tD2Z9LCBdFwqJSvsez5H/1R+40rNgqf70XWmR86xNe2IfWsAvYY7Qiv8yRCmTBk80EocJnXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791804657; c=relaxed/simple;
	bh=aPTcmEQ1Ydtv4b0A7IBonKTbkGaEEkXqccFtk2eJeF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m4224pF7N9v3Ug8rWHGOAsH/k34E2HOwqejCro7BdOjV4dG5aSjbnJaGq1Vps97SiLujjmWvsyctQ8RUBr+FBNwNvtPto3NItYa3kcZ+qxxEtVqnN9UQX1MCvFezqDqdcrwxNJCX8v8DygXFfQeFvttnc3cWmvxQGvmkFO/+QJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9CBeuFz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9CBeuFz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15F41F0089B;
	Mon, 12 Oct 2026 11:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791804655;
	bh=nYLAzRdGcx+Pa1SC0TaGogrsY7RGl2b/LoCCYazp4iI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=k9CBeuFzlXo74TbZIfXSWENGaS2ldExc95bJj+Rs33Kre3ZGctNRikXKMcTwkw7ua
	 zwV0VrqOI2qoZMM7HHlRerKomGs609/TpwgOdmGYRUEu9xVY6nuLJqnL64eBrN4u5m
	 oo1QuTzdaPjQWaMI0yw7qnE+pdkKlHuSHIEJ4A8X1d3C0zteEREKasmr9O3J5ikubP
	 BbDB+NXm04S8VD1w41EOlf5Gw79Exug3hl3NdzAxRV1CgL1ouOsHyFPDKWsqBQ786n
	 gEBlebxBuIhpbOBkEU8hXHES83exCickuKVUYI3gzyakax3xx+HX7Am8Yb6cGodJo9
	 EacTou0lpDJkg==
Message-ID: <0a486a08-8d6c-4ca5-8a54-e7499630095c@kernel.org>
Date: Mon, 12 Oct 2026 13:30:48 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] dt-bindings: input: touchscreen: samsung,s6sy761: Add
 S6SY791 and reset GPIO
To: Lukas Timmermann <foss@timmermann.space>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
References: <20261011-lat3st-google-raven-touch-upstream-v1-0-2a9f55159b9e@timmermann.space>
 <20261011-lat3st-google-raven-touch-upstream-v1-1-2a9f55159b9e@timmermann.space>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261011-lat3st-google-raven-touch-upstream-v1-1-2a9f55159b9e@timmermann.space>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/2026 14:44, Lukas Timmermann wrote:
> S6SY791 is the SPI-based counterpart of S6SY761. The register map and
> commands are identical for the subset the kernel currently implements.
> Therefore add S6SY791 as a related touch controller.
> 
> Optionally, the reset line can be controlled on some boards,
> such as the Google Pixel 6 Pro (raven).
> 
> Also reference spi-peripheral-props for the SPI bus properties.
> 
> Signed-off-by: Lukas Timmermann <foss@timmermann.space>
> ---
>  .../input/touchscreen/samsung,s6sy761.yaml         | 37 +++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.yaml b/Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.yaml
> index 1ffd17af3c53..d24f35038934 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.yaml
> @@ -8,13 +8,17 @@ title: Samsung S6SY761 touchscreen controller
>  
>  maintainers:
>    - Andi Shyti <andi.shyti@kernel.org>
> +  - Lukas Timmermann <foss@timmermann.space>
>  
>  allOf:
>    - $ref: touchscreen.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>  
>  properties:
>    compatible:
> -    const: samsung,s6sy761
> +    enum:
> +      - samsung,s6sy761
> +      - samsung,s6sy791
>  
>    reg:
>      maxItems: 1
> @@ -22,9 +26,19 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  reset-gpios:
> +    maxItems: 1
> +    description: GPIO connected to the reset pin of the controller
> +
>    avdd-supply: true
>    vdd-supply: true
>  
> +  spi-max-frequency: true

Drop

> +
> +  spi-cpha: true
> +
> +  spi-cpol: true

These two should be probably required for the new device.

> +
>  unevaluatedProperties: false
>  
>  required:



Best regards,
Krzysztof
