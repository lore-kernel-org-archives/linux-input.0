Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DE0389452
	for <linux-input@vger.kernel.org>; Thu, 26 Feb 2026 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772098705; cv=none; b=dTTvKIos87m2bqONMQhgfwz+5byWRMbIS2Mkn0Jcz0kPw3DBcvASiEMD4E4guwUxS3rZSu9jK+XjM9JeefcmzKxnyrPtLHgVyWtel9mUlcAFwJYoi5mHUK13+m+RFU5EKYS/QD4zc00QJiG1gpKbUkK2ewihYE+OvB7tbQTxGC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772098705; c=relaxed/simple;
	bh=bQVHLE0EDP1RIDb8KEc0btrhfnKqIdLuFVdqmb+6IpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=moOcwKC74B1+lnWhEgwzr8dbmJvemEmz7Xy/N0NrXjDsYBIi/0YAm+ZZsM+GVXTuocipcM6oL5D9pAeV7khTfNWgUFV3IUS3DvOGoYkKVEzcVt52YhHgmQ4Lqh2qea/HglJae7ZaXPk335cEsQFGcGsr6Uychsg9sIYxLzo5MTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-679efb9eb0dso538349eaf.2
        for <linux-input@vger.kernel.org>; Thu, 26 Feb 2026 01:38:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772098703; x=1772703503;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPVOVRPl3lC1zd+IB3b7f4lFe2w4mB21X3pW18EQvEQ=;
        b=gPy8YjqajvXO9ApiG0i0wyN2BrB/SdmI7hQj78p2exIzr5jAd+DAV5upO4a6XiZ7JP
         hdkfk4mSHJwOvHnY6j+FJ9lr7IISnyl6GlbXEWlcgy+p3UvJ7lS0Ee4y8AXTM3tECI9z
         a8NsuRkc9tmL+pkVazSlNLqqAK69kYBYSOuKU5hCnIud7/Z1HeMUaiQgpgievz49WSDv
         cZBewB0fIAzjpsnAdIBzgw0YU7DaUu5NCx329+j8BTSl3+gEuLFZ8/zhnRIP+r0b1WM0
         wiXmsH3E7orWiUE0AMuU5UJyP2Yj1a5HDK8K01sC7jaR5Ci4kps9TG9CQNwqU03d4uq/
         Z3JA==
X-Forwarded-Encrypted: i=1; AJvYcCVvZOFaLgmyEJNdFCwvBMB4n9GMca3NaDCwS7I5819E7x0df6ihwmtT9tevGXdXq1WBW678oxixzrLyAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlPjL3RdwO4wNhjoNo5Q/Dq4CJUqXEPjwWmxgqN1BBFZ8OxsTd
	qeEpJ6um7NiYSf7OImqLBqe/oW5IrxZYRtssHZQ9Oa7HYEOqZ2Hfu5QUuucHWrXQ
X-Gm-Gg: ATEYQzzV4XUMJ9B5VtmyizDj6Ze0z/KA6qArRBywXeT6eTblfBj2yXiA5T4WD4sPNwm
	hfzO/3kCd3563g9GK3lJS7uvC1ePcbbzRdH4WvcrNswdRbhxmWv352mOSiWZ4vDhML4uZ8J2x6D
	PzanyBkYesryEg+4t3FC9rVg8FaU980HgUmKIWzC47UuOku8s10W6XaBvoq3MQ8lTS6u5hYU7oh
	18bMaFoaW4rUdSKK1B4Npe67ijpGLfH1wbYebomiht57ouw4AE0qwG3490er2SJR4X+ECgtjt0e
	YN4EslhOBrskP7CiBN/WGt5l9t8bvw847fuEGQrE3cMFSSkM3Ag4jHkRRlIxQxm/0eoauigc3M7
	+cZgINur00kRo2OX9PzEKYG2C890F13Cob4LR+IOVNGOuadggFrZsqJfPLQLuQGNv9PkT3XeRPS
	uTrXcAQpvufcxdlHO80Ngz+Uqtw9mJ/cDmc86RAYi5WSvvaOKqOpswc2t3fp6Z
X-Received: by 2002:a05:6820:4dc3:b0:663:f65:1c8a with SMTP id 006d021491bc7-679c44e34f1mr10212298eaf.44.1772098703566;
        Thu, 26 Feb 2026 01:38:23 -0800 (PST)
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cf9b24dsm1487713fac.7.2026.02.26.01.38.22
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 01:38:22 -0800 (PST)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-662f5c5507cso608571eaf.3
        for <linux-input@vger.kernel.org>; Thu, 26 Feb 2026 01:38:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUYa8HisCv/vH4vCsCy+ThqdH6Fu2MsELd51ftrKqBaFXbwPifF1tNf/fQDZCO3p4CkqOAhyiCbREYNOA==@vger.kernel.org
X-Received: by 2002:a05:6102:38ce:b0:5ef:a346:a020 with SMTP id
 ada2fe7eead31-5feb2f081dbmr6698399137.17.1772098361695; Thu, 26 Feb 2026
 01:32:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225155409.612478-1-hugo@hugovil.com> <20260225155409.612478-4-hugo@hugovil.com>
In-Reply-To: <20260225155409.612478-4-hugo@hugovil.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Feb 2026 10:32:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVdYX9p9DfDoyMv8qEm52kY51QULkEnuxRBH2OyWyYf6g@mail.gmail.com>
X-Gm-Features: AaiRm50hY6HKs5Dg1D5Z1eUzl_ss50J6M1_HbmNyMG8PvkvLkYn610mEhS3zufM
Message-ID: <CAMuHMdVdYX9p9DfDoyMv8qEm52kY51QULkEnuxRBH2OyWyYf6g@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: input: add GPIO charlieplex keypad
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: robin@protonic.nl, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, dmitry.torokhov@gmail.com, hvilleneuve@dimonoff.com, 
	mkorpershoek@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, lee@kernel.org, 
	alexander.sverdlin@gmail.com, marek.vasut@gmail.com, akurz@blala.de, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Hugo,

On Wed, 25 Feb 2026 at 16:54, Hugo Villeneuve <hugo@hugovil.com> wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> Add DT bindings for GPIO charlieplex keypad.
>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/gpio-charlieplex-keypad.yaml
> @@ -0,0 +1,106 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/input/gpio-charlieplex-keypad.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GPIO charlieplex keypad
> +
> +maintainers:
> +  - Hugo Villeneuve <hvilleneuve@dimonoff.com>
> +
> +description: |
> +  The charlieplex keypad supports N^2)-N different key combinations (where N is
> +  the number of lines). Key presses and releases are detected by configuring
> +  only one line as output at a time, and reading other line states. This process
> +  is repeated for each line. Diodes are required to ensure current flows in only
> +  one direction between any pair of pins.
> +  This mechanism doesn't allow to detect simultaneous key presses.

Indeed, e.g. pressing S1 and S2 simultaneously will show a ghost
S5 keypress.

> +
> +  Wiring example for 3 lines keyboard with 6 switches and 3 diodes:
> +
> +  L0  --+---------------------+----------------------+
> +        |                     |                      |
> +  L1  -------+-----------+---------------------+     |
> +        |    |           |    |                |     |
> +  L2  -------------+----------------+-----+    |     |
> +        |    |     |     |    |     |     |    |     |
> +        |    |     |     |    |     |     |    |     |
> +        |  S1 \  S2 \    |  S3 \  S4 \    |  S5 \  S6 \
> +        |    |     |     |    |     |     |    |     |
> +        |    +--+--+     |    +--+--+     |    +--+--+
> +        |       |        |       |        |       |
> +        |    D1 v        |    D2 v        |    D3 v
> +        |       - (k)    |       - (k)    |       - (k)
> +        |       |        |       |        |       |
> +        +-------+        +-------+        +-------+

Don't you need pull-down resistors on L[0-2], and/or a way to specify
in DT to enable internal poll-down on GPIO controllers that support it?
Some controllers may support internal pull-up only, but I guess that
can be handled using GPIO_ACTIVE_LOW?

> +
> +  L: GPIO line
> +  S: switch
> +  D: diode (k indicates cathode)
> +
> +allOf:
> +  - $ref: input.yaml#
> +  - $ref: /schemas/input/matrix-keymap.yaml#
> +
> +properties:
> +  compatible:
> +    const: gpio-charlieplex-keypad
> +
> +  autorepeat: true
> +
> +  debounce-delay-ms:
> +    default: 5
> +
> +  line-gpios:
> +    description:
> +      List of GPIOs used as lines. The gpio specifier for this property
> +      depends on the gpio controller to which these lines are connected.
> +
> +  linux,keymap: true
> +
> +  poll-interval: true
> +
> +  settling-time-us: true
> +
> +  wakeup-source: true
> +
> +required:
> +  - compatible
> +  - line-gpios
> +  - linux,keymap
> +  - poll-interval
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/input/input.h>
> +
> +    charlieplex-keypad {

"keyboard", as per Devicetree Specification Generic Names
Recommendation.

> +        compatible = "gpio-charlieplex-keypad";
> +        debounce-delay-ms = <20>;
> +        poll-interval = <5>;
> +        settling-time-us = <2>;
> +
> +        line-gpios = <&gpio2 25 GPIO_ACTIVE_HIGH
> +                      &gpio2 26 GPIO_ACTIVE_HIGH
> +                      &gpio2 27 GPIO_ACTIVE_HIGH>;
> +
> +        /* MATRIX_KEY(output, input, key-code) */
> +        linux,keymap = <
> +            /*
> +             * According to wiring diagram above, if L1 is configured as
> +             * output and HIGH, and we detect a HIGH level on input L0,
> +             * then it means S1 is pressed: MATRIX_KEY(L1, L0, KEY...)
> +             */
> +            MATRIX_KEY(1, 0, KEY_F1) /* S1 */
> +            MATRIX_KEY(2, 0, KEY_F2) /* S2 */
> +            MATRIX_KEY(0, 1, KEY_F3) /* S3 */
> +            MATRIX_KEY(2, 1, KEY_F4) /* S4 */
> +            MATRIX_KEY(1, 2, KEY_F5) /* S5 */
> +            MATRIX_KEY(0, 2, KEY_F6) /* S6 */
> +        >;
> +    };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
