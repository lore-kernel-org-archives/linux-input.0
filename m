Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3675E340DA1
	for <linux-input@vger.kernel.org>; Tue, 10 Feb 2026 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770716277; cv=pass; b=dFZ/sVFZ9d6da3S0oClrptMhi+lbwO/5FQG4h31EOM7acSimQR7JBCRjfAfqlT1upnEqMbc85qy78NZXMnJdpzh/DqZTAVs1TnGCGqW3FIe/6MgZWSnuCaQGcZKl+svbCQGhWiOd7vhPw4rC/rlDP91q28paVk7wl6E5UxpcmDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770716277; c=relaxed/simple;
	bh=7DIMjFeeo3eAla/lQXJGSagwHaW1sDqxPorzkJ5QBmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yx/h912nWcqOdmliyC74pE6bEQi8ntvGHy/kfVBRPxHBHBh+XwlyC0jXZlmPyl51aXkgs5bKhNSO+E0V2Uw19CsHxj9IRDKdvJKHEwmvFIdVqVqY91nNEt/goT7MhCMLuA23MN2OZgoBW7O3ZUqCdLWG6/Vo/cW3YBS459Z2eKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CL5CIkkK; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CL5CIkkK"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-435f177a8f7so3871394f8f.1
        for <linux-input@vger.kernel.org>; Tue, 10 Feb 2026 01:37:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770716274; cv=none;
        d=google.com; s=arc-20240605;
        b=gh4r5zCheo1dgekVhxzPBmrMa1yvdOtlJg4N8x1GaIWBl+mBaDQzDfauCvl6gCtLd4
         2lR/xD6Zec6jG7r3qSQ6M6OSuRqrziY5PkNkCqpGmjEsPopJFQ+q8+PZZgE3aw2QiCST
         gYYF/DOHp213fR4ykg/9fL8ZdHh94aI0/j7czuIz7Lj52gAZZY9O+tKiyZuIoGL7r/C/
         Gy0L7SEAivAiTLp7TqTAAix3twnwKQafkgPODOgFVrCJzjvIWcgR2HL5RgBldGmsn8K7
         t1+QnecNR6aCTPhfu+kha6CeBGc6C5dVYhA8uqpE4+np56D7YW4aCcpY5A/sZa+GZNIK
         NTlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u9Y37ln8xuGFDWitJXwAsleyIOk7cbpvtjoxWooyXWE=;
        fh=GfW4V9HFKM7E7pLXdruW3DGTun1wDscoyns9qnbroiE=;
        b=Olvc7MTszbsoKyCEDSi9NdBj+B/dwTjQgbpY4l1aySrVWOdHYOGrwBtkv0DAwFDkK3
         YTfITE1NXGJG8oYwP5RuFJUkQOBvbBtvubLqIj0SOaWZkST+85EhyCxHxyn6lePHjcUF
         LEjwjqHj9S5MDbPydZPMJDYull8k9X7Z3VHHymuO5WqG6hYdMsXHByBjvw+OLWGubhd1
         sDL6pxeSkXhG38Yc0vjFw6o4NuTzz75XLM366KqdT2m3w3+Mn9r3SuPdKhnHilPPHd9Q
         QwS2Mi1NfF2LObolge9sImYWKmzUKg3FY0JyplPNUY1qvKYMhtKfJLxycX6wzqcAAfJw
         9d4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770716274; x=1771321074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9Y37ln8xuGFDWitJXwAsleyIOk7cbpvtjoxWooyXWE=;
        b=CL5CIkkK5e2UxEC7ncV9OTJi2bZl+QdhePyt+67TuSigo1gDjCyMbV7q9S3UPR9/3K
         55KqN1UTcCBw8Fg+3njGkLNfZTuWEhfQVmkeyOaXOwdMlop7uV1/SpA5I9u2KQV0CChN
         wb1QOKo6OO6hpbkrETmxdRE0W3jd7Xe/kTpUA3pQuG0R3CMma4UJXUo512OYyOcl/rV7
         m317H8PGsd+So0hcIwnESjlK2yRB3idQYtx3+ntJ77oHK3hvWIlZJPlviimoIHNLSJTr
         qj3vkqD0Cirj/mvNz8tOSpkpuGaEFef7snlEMPmUaXuCtv94eWS64RcBZyIn0L2/+eld
         Eyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770716274; x=1771321074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u9Y37ln8xuGFDWitJXwAsleyIOk7cbpvtjoxWooyXWE=;
        b=OIDe3A/XKlvOrAPJ69zgXxIsbXFRFNWis8MvR5hf2EQYgAmsxISNxsA4BAVDRwn6Ly
         lNvr324qnn5Uw7qg6p6lQsDq8qbiORI3DpuVrSjhGxAU58NBSVzGjyeXsWzC+8BdahEx
         8o887+rBN5OJ//YZSkBn+tK+7uEIrSy7RgONy9d0o+8vFYgvqh/a/sRstZp0U4HwQ7W8
         I0w7rMPCj8wiP8l/tE/nV2HF7S9Lbj7MCslKfr6weJvhZ7SbwcQr7Q4zc5YNEkkemhje
         4f1Y9mKtKVc7R5tsNIgU2Gvft1e+OZIYygNKISH2jblHrqjqKr0tersM/U/nMx862lCf
         d0gQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXvUXCK6MaQgR/zNqYegXRmORLx27sntcsQVmHQf+cRnBwbUtnhjCf3N+YwCZvHdYHEK2BIpmAYKoUFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwblwRNZ/IKGZPSSfuqcLnjO/bPsHA/jDY+XYihUiqZgRmvDsV5
	T/E8hSLMCkF2wNxVLgVaUMT047uZi9wbiwrj7fmMguB6wbrMEd/K+gh3IYFDqs1f5/HkuxpJRx9
	7nNE7qr1MYgeOuZQJUzlN6s4ORlH4UNd70A==
X-Gm-Gg: AZuq6aKNoCfwQlR5Vwp4FAdk38Qn8K4smUNOeNfy6F6e7T/uluwuNhGIlVe2P9IB31f
	6PMXRnE5qMqrWJdw1oYJJwiayBWtrzKZd/WlojPle0ptObBSfKI890Jm+zeSdj30bIf1earGdfq
	VVo0gl6l5kFbPo8z+iMstLyjmkgLwTaixNOxDkWTGj+9CZLMTY8kl9Ap9reiaPc+B++3mgckP6E
	W6iV4KyRZEz28AOPPky7JZzygweVkJXE0PLygp+AGwRZ0GgtMy+I1zyzEYpte2osVC4ctgNu9Ly
	UfLfHAjEXqt8DTPPVEk=
X-Received: by 2002:a5d:5f88:0:b0:435:8e14:9877 with SMTP id
 ffacd0b85a97d-436293b11bcmr21266056f8f.60.1770716274221; Tue, 10 Feb 2026
 01:37:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209104407.116426-1-clamor95@gmail.com> <20260209104407.116426-4-clamor95@gmail.com>
 <20260210-sexy-grumpy-sambar-44edd2@quoll>
In-Reply-To: <20260210-sexy-grumpy-sambar-44edd2@quoll>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 10 Feb 2026 11:37:42 +0200
X-Gm-Features: AZwV_QgL826wb_3IChyEYnKxPyG1ZElirm7op-wvlPZ1EK88mg4sg0InNYKSJlk
Message-ID: <CAPVz0n3fizf=r58Fr4YQ6pnjHq5p-7yFz95obss6w6x0bfgnDg@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] dt-bindings: mfd: document ASUS Transformer EC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sebastian Reichel <sre@kernel.org>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Ion Agorria <ion@agorria.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 10 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 11:22 Krzy=
sztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Feb 09, 2026 at 12:44:01PM +0200, Svyatoslav Ryhel wrote:
> > Document embedded controller used in ASUS Transformer device series.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../devicetree/bindings/mfd/asus,ec.yaml      | 152 ++++++++++++++++++
> >  1 file changed, 152 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/asus,ec.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/asus,ec.yaml b/Docum=
entation/devicetree/bindings/mfd/asus,ec.yaml
> > new file mode 100644
> > index 000000000000..1d1a62761b71
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/asus,ec.yaml
>
> EC do not go to MFD, but to dedicated directory (there is such).
>

Noted

> > @@ -0,0 +1,152 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/asus,ec.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ASUS Transformer's Embedded Controller
> > +
> > +description:
> > +  Several Nuvoton based Embedded Controller attached to an I2C bus,
> > +  running a custom ASUS firmware, specific to the Asus Transformer
> > +  device series.
> > +
> > +maintainers:
> > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
>
> Drop oneOf
>

Noted

> > +      - enum:
> > +          - asus,ec-pad  # Pad part of Asus Transformer
> > +          - asus,ec-dock # Dock part of Asus Transformer
>
>
> Compatibles are way too generic. "ec" basically means you document all
> Asus EC, which is for sure not true. You need specific compatible for
> this specific model.
>

Asus were not so generous to provide more specific data, they call
there controllers asusdec and asusped in their sources.

> Missing blank line.
>

noted

> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  request-gpio:
>
> gpio is deprecated. gpios, look at any other binding.
>

noted

> > +    maxItems: 1
> > +
> > +  asus,dockram:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: I2C device used to access power related functions.
> > +
> > +  asus,clear-factory-mode:
> > +    type: boolean
> > +    description: clear Factory Mode bit in EC control register
>
> Why would this be a static/fixed property over lifecycle of all devices?
>

Specify pls.

> > +
> > +  battery:
> > +    type: object
> > +    $ref: /schemas/power/supply/power-supply.yaml
> > +    unevaluatedProperties: false
> > +
> > +    properties:
> > +      compatible:
> > +        const: asus,ec-battery
> > +
> > +    required:
> > +      - compatible
> > +
> > +  charger:
> > +    type: object
> > +    $ref: /schemas/power/supply/power-supply.yaml
> > +    additionalProperties: false
> > +
> > +    properties:
> > +      compatible:
> > +        const: asus,ec-charger
> > +
> > +      monitored-battery: true
> > +
> > +    required:
> > +      - compatible
> > +
> > +  keyboard-ext:
> > +    type: object
> > +    description: top row of multimedia keys
> > +    additionalProperties: false
> > +
> > +    properties:
> > +      compatible:
> > +        const: asus,ec-keys
> > +
> > +    required:
> > +      - compatible
> > +
> > +  led:
> > +    type: object
> > +    additionalProperties: false
> > +
> > +    properties:
> > +      compatible:
> > +        const: asus,ec-led
> > +
> > +    required:
> > +      - compatible
> > +
> > +  serio:
>
> All of these children are pointless - no resources. Drop all of them,
> it's btw explicitly documented rule in writing bindings.
>

They are all needed to be able to disable them individually from the
device tree if needed.

> Best regards,
> Krzysztof
>
