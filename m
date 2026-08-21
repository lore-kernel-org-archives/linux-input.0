Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB2B2BEC5E
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 13:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787319212; cv=none; b=ByZqUekmWMBJXCJtxTL2t4RjELrSvC8x2I8XwKVOiMH3oeOWR3kWsaI03aLs5jqsQBZETAUxNaNIkYV4Qc2/+HVQ7uPGVoEzxcF8b020gwu8dghWHYbRHkpnQodSXz9GrOModngWkOeiChENUFiJ6yR96wzwYFbHkyBWP3uhbnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787319212; c=relaxed/simple;
	bh=v8CsjtTlJbH6IhjR3MGLZVoC00//W6iARwlKNgfOB8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fTe9qfDql4PxTVBpzMtJEqNCuOnBLgzf+czXAyOjt/D60ZSZBGFg47zHUrcs+txftokNSXz323mQOOF9BdLPPwX87hbIIsUEJOiy/i4DU+aSRppG93+bYGhNyzXZVAW1e5msx5cvgiBRVjirl1KwCkk7b3MBM744Kxs5sKgX7uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BeWWXd0m; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KCzN5n83; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BeWWXd0m";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KCzN5n83"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787319210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BOIQuUfiSHZZcuUxPrwxopvOAJS11fpxImd32Q3kdXE=;
	b=BeWWXd0mwzZudxZREU1eywt8eq2mQE0DSB7lj2omxXpuMx8M3WiN9ANZ27/TBaqctFdG50
	RaSHUhAqN4g6VFCg/fFqrSigijHIKSp5dkdTdv+OFtPAqCT6myS461Ov3rNfPlncBAaOLt
	cjB9/AHoC24Ok0sMqhDqhunFIoeMKbI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-RDHt9YKNP2aDLyLDl1CKJg-1; Fri, 21 Aug 2026 09:33:29 -0400
X-MC-Unique: RDHt9YKNP2aDLyLDl1CKJg-1
X-Mimecast-MFC-AGG-ID: RDHt9YKNP2aDLyLDl1CKJg_1787319206
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5b01f81d9c0so844849e87.1
        for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 06:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787319206; x=1787924006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BOIQuUfiSHZZcuUxPrwxopvOAJS11fpxImd32Q3kdXE=;
        b=KCzN5n83v+fNmadDMJ9a9upWLeABNAgO4clhwYw+PpboVn1KqGU8e7JqBktlysUSx0
         wkMDbHGumQOHtWlXJXNGuTEewZsQX952GJClzeV3J7aoYZWt7pbnMFDqfFYjsSB37sCY
         SRNJ6c/ieVzjjD4PCpbITHxl0xtS6M5bbOVVTUeOlfRAjQCsM37Q3Tt6pYLoevz2/TMU
         oqudX0iyVmSHHoFA4V5+96drWpWVjwomlwC2QogzBfCoUXUfvQb5uYIR40hPt1kbSi8n
         VoIQ6vqqHVnmbTA8Ge2xF9F9OzOH3cCyaEndBvxi8CJUMBWurUp81eWBkAV3cYp3BKAN
         bopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787319206; x=1787924006;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BOIQuUfiSHZZcuUxPrwxopvOAJS11fpxImd32Q3kdXE=;
        b=IP0jPfUXSBlArTtjxkKvOrPi9ROiip3TrxtJSfCynResCB8efJWHMfeg8CDWdYWtco
         Ir/26Xm7cXeg+euXYKj21Ya6PWcL1GAXg8SwjDoittwK2moI94LHA8X72XKKSMjyWGNn
         /UV2RoZSMTTteDj5HWu8oJYMwr9kUTLPBHZlIBlttikgHlRZpblgD/r5OOgPQzjIsR2V
         FKIN/RuokIdCeP8KNUuh9LzX5+OAdIaRFDSDIslC36xI/ixIMQOpSbH2+s4jbB4Dyh5P
         mu0CaQwxOHnHfkW216OoHJiGA8wP3wtyr4YV8qE+2E9KotOlar447yxZ+XoErBpkIy7k
         +4QA==
X-Gm-Message-State: AFuF++kJ96WlXvpAEXLKgqtqX31McuVITholmjebn5inE5mEWHsdCwfY
	DJugTvGn7VCk39PZPyrWRiapoc/VZ1VLxUBplkBX1Sr6njQ5+hsstrc4NvakbU800GmDRdmCL5T
	/Prz7wEb9VdsG20ePW9TMjGnLMlz92lyb481b9jQP/tesaflJ8Lgz1rFhuvzVQjs=
X-Gm-Gg: AR+sD112wTWXd08Tg2QROMq1xYafSdh0wlemRfmUjTS9KGVwfv7X3OUlCJJ2ze1+lTa
	fI14+WUi52PsmZQSwUhfhtH/NuzHW1VPEjUVy0Cwyj/NxBuqwO1jrEZ5S5zL58ttwdBuR1OaGn5
	V5YLMinu4NVxt9kLhFhX9KAM4Dserr9RczNGJjAYFchx2MXuSSgAVmrL2REWdlUMBhRJuROgZmr
	LEBlhN6xiePS2GQkd61qQFH8140wCF7+DF1vKTUXb2EKvQjL1m6UhEeDIMgJRfhgDWcquTPz9mf
	wMjRo6vRaDGbR+Soxtv0lBTuJxb5bpET1g5HtD56BzyTS9mtOpxFLodZmd5T00Mvbe8ZwdWYeom
	kTtKu8kPHew85tL91WjwTL4BVgArYlkg=
X-Received: by 2002:a2e:bea8:0:b0:3a1:b1e4:419c with SMTP id 38308e7fff4ca-3a1b1e4439dmr14635371fa.10.1787319206431;
        Fri, 21 Aug 2026 06:33:26 -0700 (PDT)
X-Received: by 2002:a2e:bea8:0:b0:3a1:b1e4:419c with SMTP id 38308e7fff4ca-3a1b1e4439dmr14635231fa.10.1787319205944;
        Fri, 21 Aug 2026 06:33:25 -0700 (PDT)
Received: from [192.168.1.86] (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a195cce071sm15521331fa.13.2026.08.21.06.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 06:33:24 -0700 (PDT)
Message-ID: <7c04997f-eb7e-4670-bd10-85c918c034b9@redhat.com>
Date: Fri, 21 Aug 2026 16:33:23 +0300
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: input: touchscreen: convert sis_i2c to DT
 schema
To: =?UTF-8?B?yJh0ZWZhbiBHaGXIm3U=?= <stefanghetu9@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260821131039.37525-1-stefanghetu9@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <20260821131039.37525-1-stefanghetu9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/21/26 16:10, Ștefan Ghețu wrote:

> Convert the SiS 9200 family I2C touchscreen binding from free-form
> text to DT schema format.
>
> While at it, fix the example which referenced a non-existent
> "irq-gpios" property; the driver looks up "attn" via
> devm_gpiod_get_optional(), so the correct property is "attn-gpios".
>
> Signed-off-by: Ștefan Ghețu <stefanghetu9@gmail.com>
> ---

Thanks, looks good time me!

Reviewed-by: Mika Penttilä <mpenttil@redhat.com>

>  .../input/touchscreen/sis,9200-ts.yaml        | 61 +++++++++++++++++++
>  .../bindings/input/touchscreen/sis_i2c.txt    | 31 ----------
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 62 insertions(+), 32 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/sis,9200-ts.yaml
>  delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/sis_i2c.txt
>
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/sis,9200-ts.yaml b/Documentation/devicetree/bindings/input/touchscreen/sis,9200-ts.yaml
> new file mode 100644
> index 000000000..5c4806348
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/sis,9200-ts.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/touchscreen/sis,9200-ts.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiS 9200 Family I2C Touchscreen Controller
> +
> +maintainers:
> +  - Mika Penttilä <mpenttil@redhat.com>
> +
> +allOf:
> +  - $ref: touchscreen.yaml#
> +
> +properties:
> +  compatible:
> +    const: sis,9200-ts
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  attn-gpios:
> +    maxItems: 1
> +    description: GPIO pin used as the attention line
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: GPIO pin used to reset the controller
> +
> +  wakeup-source: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        touchscreen@5c {
> +            compatible = "sis,9200-ts";
> +            reg = <0x5c>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&pinctrl_sis>;
> +            interrupt-parent = <&gpio3>;
> +            interrupts = <19 IRQ_TYPE_EDGE_FALLING>;
> +            attn-gpios = <&gpio3 19 GPIO_ACTIVE_LOW>;
> +            reset-gpios = <&gpio2 30 GPIO_ACTIVE_LOW>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/sis_i2c.txt b/Documentation/devicetree/bindings/input/touchscreen/sis_i2c.txt
> deleted file mode 100644
> index 8f5322e01..000000000
> --- a/Documentation/devicetree/bindings/input/touchscreen/sis_i2c.txt
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -* SiS I2C Multiple Touch Controller
> -
> -Required properties:
> -- compatible: must be "sis,9200-ts"
> -- reg: i2c slave address
> -- interrupts: touch controller interrupt (see interrupt
> -  binding [0])
> -
> -Optional properties:
> -- pinctrl-names: should be "default" (see pinctrl binding [1]).
> -- pinctrl-0: a phandle pointing to the pin settings for the
> -  device (see pinctrl binding [1]).
> -- attn-gpios: the gpio pin used as attention line
> -- reset-gpios: the gpio pin used to reset the controller
> -- wakeup-source: touchscreen can be used as a wakeup source
> -
> -[0]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> -[1]: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> -
> -Example:
> -
> -	sis9255@5c  {
> -		compatible = "sis,9200-ts";
> -		reg = <0x5c>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pinctrl_sis>;
> -		interrupt-parent = <&gpio3>;
> -		interrupts = <19 IRQ_TYPE_EDGE_FALLING>;
> -		irq-gpios = <&gpio3 19 GPIO_ACTIVE_LOW>;
> -		reset-gpios = <&gpio2 30 GPIO_ACTIVE_LOW>;
> -	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8014b9f82..88d0cb1d8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24866,7 +24866,7 @@ SIS I2C TOUCHSCREEN DRIVER
>  M:	Mika Penttilä <mpenttil@redhat.com>
>  L:	linux-input@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/input/touchscreen/sis_i2c.txt
> +F:	Documentation/devicetree/bindings/input/touchscreen/sis,9200-ts.yaml
>  F:	drivers/input/touchscreen/sis_i2c.c
>  
>  SIS USB2VGA DRIVER

