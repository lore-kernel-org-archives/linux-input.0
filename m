Received: from mail-oo1-f67.google.com (mail-oo1-f67.google.com [209.85.161.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E557346A15
	for <linux-input@vger.kernel.org>; Sat, 31 Jan 2026 19:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769888794; cv=none; b=qIHK8P4kq5EFie9EQPfow99i1hleU3pMkCewXOtqY8sR9eB54AlAMWAwNHEWxWw0q2nJxbBvhFFyyens5Qz+fg64cVmqxnUj1HdTKBB+GO49hayMJxKWo/sDTOxZ1AfWQ1hE0R6rpb5tfZV/muWUag0yDS4CepECDX3vxZn/mWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769888794; c=relaxed/simple;
	bh=K8YQX8LaOueyeKPe9xY7pRAyIGpZfWO0T3uKpztWwW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f6lsKUP+XD/DbZknU0Yi1fvh4RBsqVSZOsEuYLXBDYMzmVoe7F/wxNakRIlAL87+SwCzW1tn0A2RCdJ+Azs4xlb6snspXHvxlj6WOCfbCDmRQOyeP5JcvpPKh/IWTlkWfuSAPf1m1VgR40kcxR748/6kZy2EIMjmu1dEmbvVMbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sAcfGwyH; arc=none smtp.client-ip=209.85.161.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sAcfGwyH"
Received: by mail-oo1-f67.google.com with SMTP id 006d021491bc7-6631375bf14so852094eaf.1
        for <linux-input@vger.kernel.org>; Sat, 31 Jan 2026 11:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769888790; x=1770493590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=USE7814nD7qzzRAMgxZuZkB6FtznoRYP0SohwFcy9+I=;
        b=sAcfGwyH1OaXM2tfj6vThUweIkIeXGNDFBb1OUzUrMtHzF7y9szC/6DLBEcu+wG9a7
         llDsdNxciCcUv54eHZWzQOWwjuD1aHzfJuGrNqU6TzlkY1QuPKAW7B03VCSGKVGaZ4WP
         QCw2fHOM0e2eFx4mmVmS4T84h7NImteSmA+teYFRg/DaCrQspUDe4iL8B0MT7ES4gxB3
         XsVhyKe8syqNUxQ8LSyBL9JV8ZDoGPIyJhsfBpIcLelMOoEUAoeHbi2XjMgE+7X74tyy
         SOxgQ/HxpsXgeyM+w2vHYizIttm3bq3dAkfsO5DHimJDdlYCrXp1M/Sv4wgos6OqEMn/
         WEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769888790; x=1770493590;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=USE7814nD7qzzRAMgxZuZkB6FtznoRYP0SohwFcy9+I=;
        b=VBhjXzG/SrNaLgQCf1VmQMasK48CSzBjWvWo3W04HYsC5liBkGt38Duh7yCAdvlUmg
         CLV6RiwLPZOYCdA0UPdgbPUq7JVMDRaHdq7cFSRPAfnKKM7CpEcJ4FQGv9MA5WxGsi27
         6puhc6hdxB3qG6FYG+C47ar2BG2twrlOjkBSPTdbNbhtD1FkQZ6g68joODGl7/7gIgdH
         mN4XuA13J470Newdd3Lv6nvJVqNobLYosGXpWjnrccpwH8rJ3c4/O8adR6BNsWUj8Dv3
         fCBrD1zhbRphvX6p6If9VsC+P/Z038ou9XNyoUNYXEh1M7flYM+516GvNpElXefN/Z9C
         aRkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWa3pMc4qFcBmJ385Oj/REjJyuj/IUnrYU1SxUkzpRz1Xkql5fMWAdWmh3kclXypq27sU+eDAUHFUQRvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKXnrK8795NyK+VDqn1gj2ZGLA/UEUqYVHnwTt/XK/uMCxBKo9
	EAXBM0eKJENp9N1pFDBczMpqcU+cfdI/MeRpXrQr2pF6l6YtF+HozJyITl18asWpocw=
X-Gm-Gg: AZuq6aJdcjhZCqjrRYCAqNsMT1nmvimKezVgf/ziRAJB+LoXAZMmPI+GrKhpkPDxHUw
	WXz9caMS1xY1LjJxODeWltSLHMsVXtwsWB1DMN5FpPNZMn5AHo9SSLqDwSa+pp4bz9f6FWHKroz
	4R+KmNIWAO+63A6irU7UYZ93Rs3GlNUTsaZVCb/O+B49FbtdiAZQrnPN5HxQ4Hp9sk7fnUd/xM4
	esvOjjWS1siVPnXhy6FIzGGhHZuOnU83V7B568/YxYrEql6OXuYg45SowwMEoeBZutdFJ6sn+Wj
	ipGVvNVmZ2I1rki1Y+q3/g+1g9XHjeY2n7D2nfEr7TRB+DBL1FVLHcIaF9MHFBVSQjW+IbZeWyV
	12XMtZO1cFC/m+Bx4DKM/U29DnFX3t3ZNXj5eO++5frl+9eGBhmBs2p/LmsuXVZkpYO4DQ4vN7h
	UTusCOFD12sSeuXx8NVrdHtQmGpvkrSGK5MNz0mZEToKNOLZ46XJOuHsehIY9v
X-Received: by 2002:a05:6820:4810:b0:661:1bee:284a with SMTP id 006d021491bc7-663103a4b9amr2983263eaf.28.1769888790423;
        Sat, 31 Jan 2026 11:46:30 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7? ([2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-662f9a18776sm6975873eaf.12.2026.01.31.11.46.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 11:46:29 -0800 (PST)
Message-ID: <d7938728-fded-4d5e-b23d-a8346e3fab46@baylibre.com>
Date: Sat, 31 Jan 2026 13:46:28 -0600
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/10] dt-bindings: regulator: cpcap-regulator: convert
 to schema
To: Svyatoslav Ryhel <clamor95@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Dixit Parmar <dixitparmar19@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-rtc@vger.kernel.org
References: <20260125134302.45958-1-clamor95@gmail.com>
 <20260125134302.45958-2-clamor95@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260125134302.45958-2-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/25/26 7:42 AM, Svyatoslav Ryhel wrote:
> Convert devicetree bindings for the Motorola CPCAP MFD regulator subnode
> from TXT to YAML format. Main functionality preserved and added compatible
> for CPCAP regulator set found in the Mot board.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/regulator/cpcap-regulator.txt    | 35 -------------
>  .../regulator/motorola,cpcap-regulator.yaml   | 51 +++++++++++++++++++
>  2 files changed, 51 insertions(+), 35 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt b/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
> deleted file mode 100644
> index 36f5e2f5cc0f..000000000000
> --- a/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -Motorola CPCAP PMIC voltage regulators
> -------------------------------------
> -
> -Requires node properties:
> -- "compatible" value one of:
> -    "motorola,cpcap-regulator"
> -    "motorola,mapphone-cpcap-regulator"
> -    "motorola,xoom-cpcap-regulator"
> -
> -Required regulator properties:
> -- "regulator-name"
> -- "regulator-enable-ramp-delay"
> -- "regulator-min-microvolt"
> -- "regulator-max-microvolt"
> -
> -Optional regulator properties:
> -- "regulator-boot-on"
> -
> -See Documentation/devicetree/bindings/regulator/regulator.txt
> -for more details about the regulator properties.
> -
> -Example:
> -
> -cpcap_regulator: regulator {
> -	compatible = "motorola,cpcap-regulator";
> -
> -	cpcap_regulators: regulators {
> -		sw5: SW5 {

Old example is missing the required regulator-names property.

> -			regulator-min-microvolt = <5050000>;
> -			regulator-max-microvolt = <5050000>;
> -			regulator-enable-ramp-delay = <50000>;
> -			regulator-boot-on;
> -		};
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml b/Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml
> new file mode 100644
> index 000000000000..b73d32a86904
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/motorola,cpcap-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Motorola CPCAP PMIC regulators
> +
> +maintainers:
> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> +
> +description:
> +  This module is part of the Motorola CPCAP MFD device. For more details
> +  see Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml. The
> +  regulator controller is represented as a sub-node of the PMIC node
> +  on the device tree.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - motorola,cpcap-regulator
> +      - motorola,mapphone-cpcap-regulator
> +      - motorola,mot-cpcap-regulator
> +      - motorola,xoom-cpcap-regulator
> +
> +  regulators:
> +    type: object
> +
> +    patternProperties:
> +      "$[A-Z0-9]+^":

Why not put the valid names here? Or does the node name not actually matter?
(in which case lower case could be allowed too.)

         "^(SW1|SW2|...)$":

And $,^ are swapped.

> +        $ref: /schemas/regulator/regulator.yaml#
> +        type: object
> +        description:
> +          Valid regulator names are SW1, SW2, SW3, SW4, SW5, VCAM, VCSI,
> +          VDAC, VDIG, VFUSE, VHVIO, VSDIO, VPLL, VRF1, VRF2, VRFREF, VWLAN1,
> +          VWLAN2, VSIM, VSIMCARD, VVIB, VUSB, VAUDIO
> +

If these apply to the regulator-name property, it can be written instead as:

  properties:
    regulator-name:
      enum:
        - SW1
        - SW2
        ...


Not sure if it is strictly needed, but this would document the optional
property:

    regulator-boot-on: true

> +        required:
> +          - regulator-name
> +          - regulator-enable-ramp-delay
> +          - regulator-min-microvolt
> +          - regulator-max-microvolt
> +
> +        unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +

Example should go here.

> +...

