Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B05236EA9B
	for <linux-input@vger.kernel.org>; Sat, 31 Jan 2026 20:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769889782; cv=none; b=sWeMJ1b8snMoOzPvkLuIKZp86XFP6/FAY1EBPq2gZOBh1tuQmi1/OYTWFJ4d4fr9txN+NxfDhHmbYKNxmxY+7zIthJI4m2NXH0evnJnY6rOZP48KvaRuoF9+/K2h8fk+1/a/1DGP4UUGOky3uQS0SaoMigA6VHfhmkN6oK5lCoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769889782; c=relaxed/simple;
	bh=u1yuFWr3eI3cUhJQh3ws4Rrs2CjchEuu5iwWD3RXNzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptbvxFZiIqXOkrQ+tF6VVWHznSrwGKas3mcGNQFAVIPxn79poA443dyTlNdXtXsZ1plIBfxYJ6KhCNwz74BwjxtEMXKdJO7/Y+yWyQxHJVI+25Nqg0vJWZfO6X0AKvywZIdHBJb+lXMtDgPAtVWZvFJ8UpgVB2cyk+z7aLwU9Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QpNA5llk; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QpNA5llk"
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7d148dd3421so1240037a34.0
        for <linux-input@vger.kernel.org>; Sat, 31 Jan 2026 12:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769889778; x=1770494578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dZjM9shHX4YFsvwKhFAe/sG0x6/ZZidUkV5AzO3KYmk=;
        b=QpNA5llkqAKdONL1eN3bd44/voICoGhTF7xLpjtkeaVlNru5AnslVcS8/AwXpiytTf
         I2UeNTRtpPlIq/+3FgpsFnQrRXvHBdE3Rx2CnjopYmqWSOoLOki6RFJAyf1hZ8bd8c/T
         Olsi+9QlG3fd+jZDGDJ19qV4pkVb2L4YirnGEmS52FpZnBDuzG285N4XheaCK2LqQriv
         y6D3/q7DKt+3I1clNCZZAAwZAsuhikMDruktXp0KPq/NkBgDWl3Kr1hZVS4uHeC+P5ry
         rFTpLReo9FvJ1SHJTpWsZxUsbfs6FcFvpZRQfVsIqIcZbCL0laSA8nzuAKjgFW517Qzy
         dBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769889778; x=1770494578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZjM9shHX4YFsvwKhFAe/sG0x6/ZZidUkV5AzO3KYmk=;
        b=ImHsJ08m6pG9R6nFX0hVKQOopfkrJb4q267Cw3sWzprR4CMVAw1WHR5rjeoqxWVcd5
         FBKt6orTA2mkyDCyIxE8A/oJPvDO/wCC5RMcbf/QVDpCYFdwLp4eeSCczuDrtJnxonn1
         Wvh5nPDz7TAMehGyCJ+ZDuJE35qt8G+Iw72OKt9lt/AaGAJDQYT2Zy98b/2nVcOx3E8q
         ZpEdl0Cz3aEJcKV+lEvKYFrPgrzHWnuJXKA63sTYAD+5fiyXc0h9T0BJ37A0FteQ6xTz
         PiUDlIK/ZlVGvyQqFjqMFAfM3Juse9DQaT2HFkVTCs3+1vFh0eUDllFDfX0SxzreCk3q
         TB7A==
X-Forwarded-Encrypted: i=1; AJvYcCVuq0Uaj60rjeVZ3wCxzjQ18VmXkYp9BGZ9tEGsT5FMh5MBWggrb6T0y+60nS+19B4yciGT1IRKESndBg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0SAxe4uQ4/bnPoJgreFMV7GOlFAeOwEt5Rgw6CM4aXzNDQVe5
	GYTkLKSbkG2us7LbFqyZ6xvhrGkpzFAhJpiF7ELOsU9ETubtvatkDjYj0ZzCLZw+mUY=
X-Gm-Gg: AZuq6aIR36+3oyZ4EdM/x8aHmWEo1EYujKVw10XpsbREesyGbSynCA8pUE+Tl+iOLPw
	v7KzoZGmDLDW00y3ORVjp9wQmUiFSQ1d65AUDW6BHwzzZYB/Dgul78ZpbkXh2NmxmrGVTKtRqkZ
	q254mNJR4CzMPzzpXeUAy37KNX8E4k/k7heO+b1g529FpolGEusZUj++yeAtye/JcnesVK/+tU0
	WP0SIFhJLQG3hhRMnAkVlzNNMW0dM32H6/IoCpJGVe+Z/MQ6IJYwUGi3CtiQI8c/oVW78AXeG6i
	UMEfYttQULNr3tLSkxRrQm2OiRuQUB7/y58Ybh7OZK0rpbIS6/qgkoj5r0016PwrFuJIe9qKiGp
	bYdFs40xm6Xoqomu14Zo2cwSDg/zRftk0n53ji67sNOHB+aeNOyBMG3jKmn57JTTPjHp+4ht8vo
	buGxk5yExQBDw2UE0CosI+c0isOk8ErDDjtbzZp1FWWEumj+77X0EBhFpD9Ec4Th5HBf44Rfw=
X-Received: by 2002:a05:6830:2b09:b0:7cf:d14f:a4aa with SMTP id 46e09a7af769-7d1a531026bmr4075358a34.20.1769889778127;
        Sat, 31 Jan 2026 12:02:58 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7? ([2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c67065esm7795242a34.6.2026.01.31.12.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 12:02:57 -0800 (PST)
Message-ID: <8bd89524-dfc3-43b0-b0f2-cdb1cd51e1ac@baylibre.com>
Date: Sat, 31 Jan 2026 14:02:56 -0600
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/10] dt-bindings: input: cpcap-pwrbutton: convert to
 schema
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
 <20260125134302.45958-8-clamor95@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260125134302.45958-8-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/25/26 7:42 AM, Svyatoslav Ryhel wrote:
> Convert power button devicetree bindings for the Motorola CPCAP MFD from
> TXT to YAML format. This patch does not change any functionality; the
> bindings remain the same.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/input/cpcap-pwrbutton.txt        | 20 ------------
>  .../input/motorola,cpcap-pwrbutton.yaml       | 32 +++++++++++++++++++
>  2 files changed, 32 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
>  create mode 100644 Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt b/Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
> deleted file mode 100644
> index 0dd0076daf71..000000000000
> --- a/Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -Motorola CPCAP on key
> -
> -This module is part of the CPCAP. For more details about the whole
> -chip see Documentation/devicetree/bindings/mfd/motorola-cpcap.txt.
> -
> -This module provides a simple power button event via an Interrupt.
> -
> -Required properties:
> -- compatible: should be one of the following
> -   - "motorola,cpcap-pwrbutton"
> -- interrupts: irq specifier for CPCAP's ON IRQ
> -
> -Example:
> -
> -&cpcap {
> -	cpcap_pwrbutton: pwrbutton {
> -		compatible = "motorola,cpcap-pwrbutton";
> -		interrupts = <23 IRQ_TYPE_NONE>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml b/Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml
> new file mode 100644
> index 000000000000..643f6b2b1f13
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/motorola,cpcap-pwrbutton.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Motorola CPCAP PMIC power key
> +
> +maintainers:
> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> +
> +description:
> +  This module is part of the Motorola CPCAP MFD device. For more details
> +  see Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml. The
> +  power key is represented as a sub-node of the PMIC node on the device
> +  tree.
> +
> +properties:
> +  compatible:
> +    const: motorola,cpcap-pwrbutton
> +
> +  interrupts:
> +    minItems: 1

Should this be maxItems: 1?

> +    description: CPCAP's ON interrupt

Or I suppose:

  items:
    - description: ...


> +
> +required:
> +  - compatible
> +  - interrupts
> +
> +additionalProperties: false
> +

example: ...

> +...

