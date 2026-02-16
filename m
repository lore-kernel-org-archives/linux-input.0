Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C665A2BFC7B
	for <linux-input@vger.kernel.org>; Mon, 16 Feb 2026 18:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771266174; cv=pass; b=UUZeohttjVgrD/7cv5T5cEoICZ+Fn/KGbf9/oQCvS24+l8zZzTZ3iXFjaSpTyObfCdgjMMjHxlSuBfLInN6NBM/UPwhhXEn/44ql/HOvwpYR8fJx/OcRF0ec0f7mJRHqrkqwTel/JIje/iXXamnkAEFg9As3qfC9iIWxyKt+6F8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771266174; c=relaxed/simple;
	bh=cm1yxjwH9Z28ptmYFhe3IeX8mFESDp5HLnpkx6ZPfcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ckDb1b9BzsIpe2fKQFFI4CtQmn9FThXcZwOj6JX77NctqJOhvyFYax81Ls4nbqNNPqBjx3YO5Uestxt/eU2zDWSUJhuWuvP8uGvqTW+q1OnHIYlnmiq1Kq74YkKbuIDzSllY/h//eoGJJYB311lA4wdKvcs6ZhHp3Q9cckWvyZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrn4c/f9; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrn4c/f9"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4362507f396so3345258f8f.0
        for <linux-input@vger.kernel.org>; Mon, 16 Feb 2026 10:22:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771266171; cv=none;
        d=google.com; s=arc-20240605;
        b=F+i8hDM4aAImrqk33EjTkyjhZAgymBoKkUawmgukFQkYzYV2Q5R+5Ocm4wIM5sBtNa
         ZHvZA00vgIjdGTYd2i91f9aTeI0XS/MG9pwfhALU0hEezIpRdIjwSDSLnGQB+TN+o7vw
         GCrOQClbFtoayy8M2/OuBT5jJwqRppj5+tYvxE/i28RZC73hFltPH/6WGrwxEiAL6uvz
         lBVjGavESo+VWCnfrgAxkw0NYYbs5/L/NnSxnNCW13peJNrFbkZ9nHVAi/CW0tjfVUe6
         Ybl+8ya4IFqnF71xR6FXXRNgyb1kxwnIyABqABLCm5P5cAtM8aH3SXV4FWzgiHey/qct
         p9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lx9sMXC6RQXXITKl7w/e4T7ej5sF4JRPpHYSQw3vBPo=;
        fh=GZEbFe0V5lz+5NGb4uZDyIQvrpYVhwBs3eDXS47lqNs=;
        b=JWSC4HJFwqlNWVtP5MV4khiH+HWjvTZuN2MRDeHst+Z+0PgwLsLapRpwj3CIbEc4CJ
         kPEbuHt49ITy1nkUBg/+1+bn8YWMGBnOLu+wLamNM09wNjKk3PHn9BheM3uWL/zJx1Os
         1rmDxih1dYh/Ryo1mJPsf9O6XOFMNUdUSWikIdCFJk8YFbXMcWTInhZe8jtTNxsxcddy
         oKPoaoZTA9UkSIusr9txnjrGXQEBsIzzqHhAp/zsVHMF7WzrKEFsWQiBsapbD4G5pg+C
         d2tEdok4Q9HGxzBc/z7YElwBp0cupLHU181OSDIUpkapv2WweFiVfg0cyrNZNJrqjoLy
         9PxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771266171; x=1771870971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lx9sMXC6RQXXITKl7w/e4T7ej5sF4JRPpHYSQw3vBPo=;
        b=mrn4c/f9C8iG3KjzBr7WeyIuFe4HbDBR1txqEj8X8i15dnw9KiSGR8KMIrQzttndlj
         mhb3drp9n8nnz3LWvST2aRgAlVQ9V64/xpS1DhR/l1J2RSirIpgmiVCt1SKYdZG0XERx
         GAS+1Nd0P1jdknc7jfxebO9TkTOZfQlv7HXPolkFjS6IF5tBQsYVGijYuS15jgAVtrdd
         Gd52bf+ebNmQeoh0/Ng4lP0kGIVeA9icjrzVqf8HGNk+AZ/5IHVm3VgGrp2Z7XUcpm4c
         IvpX6+6trK50UJVV8xgbhfJ2r55K9Y6E772E1VjnL7FI1VfUJ9s1yHbhhNt2QC0EnXOw
         ZxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771266171; x=1771870971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lx9sMXC6RQXXITKl7w/e4T7ej5sF4JRPpHYSQw3vBPo=;
        b=FG7EWUGFOXacC0AytbAJ9s0gAOd2+J38qcRZu10tY/tPs6+3V2fn8/3oS1dUwGxFrA
         EwxZEvJiOxbPS0nh7232soyOWsYnUzGBgfvISXwm1m0R5nKsTFMhCXmpWbQT5bfFk3Bz
         WYEnNYDuThQHbBIxQm2WbdH7U0HyC3OByZNP2oz4Sj2ahZ7kDSeTofZ/K4JPKTk0Qi6Y
         9oLO1voQK5o2lM1pZTD4ynTRGJMaGvYB6UgPFjJm/17JjjtX9eCf20bxe2YThW57DfCu
         pv+VB82Lkm0Badtc48H6wSIesl3svk7q/ff1SDSlkHBYdZ6z7onJielRQbBJ3nset2a0
         QRdg==
X-Forwarded-Encrypted: i=1; AJvYcCX5hfDcKI55L3R+x/oxhAzDPtByx0nXWrgOHeMHZeECi+JzhD1ziIofpxC6t2ksskQ/ZrQ+Wc7cTvDxxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxD+g1R0qy5VF+9lUBOjUyPUo9r61fovuh1WmiBqn1JUd+KxI3l
	XUnf3YWrkcJVFRmd8f0rupXk0VuXI6CKJuDuIgQZ4mmc7T/JrkWwTUFODVyp88AEBn9FC4MMATO
	aUihY1hVoOMoNddF/rHfIMFfBEfdCMcg=
X-Gm-Gg: AZuq6aIX52TajGCHI3mKPh5c7XNav1HSIdUUB+YWcHrFb8BVMkB5nqE3qHlzF2WvHoj
	JOZ7DLU3GemSg3u7XU5qDNb0ntz3hTO+e8/wVIfUtzPWyJ6ljCyWG+rJ4/T+akIiHVg0Y/XYA/7
	O4XnmfO7Sd/0U2iZwNxGHuVYbbgQWtv+afG8lZ5lc4GSSLPEJjMDs/grHfWdSwr9aoD0yG6aU3O
	a7FXwM41Y4R7wdNzHpJiAot5GDdYuR1ogZn6v5K5GxmGrcbrPOPRsrIFBajBMbbhf0GAH18nnT1
	orWO6H9q
X-Received: by 2002:a05:6000:1a8b:b0:437:8f37:881 with SMTP id
 ffacd0b85a97d-4379791904emr22365422f8f.32.1771266170899; Mon, 16 Feb 2026
 10:22:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260214180959.30714-1-clamor95@gmail.com> <20260214180959.30714-2-clamor95@gmail.com>
 <20260216-sprung-scallop-de7b64bf528c@spud>
In-Reply-To: <20260216-sprung-scallop-de7b64bf528c@spud>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 16 Feb 2026 20:22:38 +0200
X-Gm-Features: AaiRm51tYAHBz4R8xs0e14b6OB9K4x6nBDeDJNAKVOoJXReY0VIDDmGSWevQOtk
Message-ID: <CAPVz0n06+uLCSfY_bYS9v7KJ-hXotye7ej-rze6-Q8_JAF7XVA@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] dt-bindings: embedded-controller: document ASUS
 Transformer EC
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Ion Agorria <ion@agorria.com>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 16 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 20:04 Cono=
r Dooley <conor@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sat, Feb 14, 2026 at 08:09:53PM +0200, Svyatoslav Ryhel wrote:
> > Document embedded controller used in ASUS Transformer device series.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../asus,transformer-ec.yaml                  | 98 +++++++++++++++++++
> >  1 file changed, 98 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/embedded-controll=
er/asus,transformer-ec.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/embedded-controller/asus=
,transformer-ec.yaml b/Documentation/devicetree/bindings/embedded-controlle=
r/asus,transformer-ec.yaml
> > new file mode 100644
> > index 000000000000..670c4c2d339d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/embedded-controller/asus,transf=
ormer-ec.yaml
> > @@ -0,0 +1,98 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/embedded-controller/asus,transforme=
r-ec.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ASUS Transformer's Embedded Controller
> > +
> > +description:
> > +  Several Nuvoton based Embedded Controllers attached to an I2C bus,
> > +  running a custom ASUS firmware, specific to the ASUS Transformer
> > +  device series.
> > +
> > +maintainers:
> > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > +
> > +allOf:
> > +  - $ref: /schemas/power/supply/power-supply.yaml
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - enum:
> > +          - asus,p1801-t-ec-pad
> > +          - asus,sl101-ec-dock
> > +          - asus,tf600t-ec-pad
> > +          - asus,tf701t-ec-pad
> > +
> > +      - items:
> > +          - enum:
> > +              - asus,tf101-ec-dock
> > +              - asus,tf101g-ec-dock
> > +              - asus,tf201-ec-dock
> > +              - asus,tf300t-ec-dock
> > +              - asus,tf300tg-ec-dock
> > +              - asus,tf300tl-ec-dock
> > +              - asus,tf700t-ec-dock
> > +          - const: asus,transformer-ec-dock
> > +
> > +      - items:
> > +          - enum:
> > +              - asus,tf201-ec-pad
> > +              - asus,tf300t-ec-pad
> > +              - asus,tf300tg-ec-pad
> > +              - asus,tf300tl-ec-pad
> > +              - asus,tf700t-ec-pad
> > +          - const: asus,transformer-ec-pad
>
> Can you explain somewhere here what the "dock" and "pad" devices are and
> how they differ? For example, I am currently wondering why tf700t has bot=
h
> "dock" and "pad".

"pad" is used for the controller in the tablet itself in the pad
"dock" is used for the controller in the mobile dock keyboard.
Seems quite obvious.

> Also, why are some of the compatibles permitted standalone? That should
> be mentioned in your commit message too. Also, other than the sl101, the
> standalone ones seem to have the same match data in the mfd driver. Why
> are fallbacks not made use of there?
>

Because standalone compatibles describe a unique hw configuration
which cannot be grouped into something meaningful. asus,p1801-t-ec-pad
is for EC of Tegra30/Intel based p1801-t AIO, asus,sl101-ec-dock is
for EC of Tegra20 slider tablet, asus,tf600t-ec-pad is for altered EC
in Win8 Tegra30 tablet, asus,tf701t-ec-pad is for Tegra114 tablet.
Different generations, different form-factors.

> Since this transformer series seems to have multiple programming models
> for "ec-pad" devices, it calls into question your use of the generic
> fallback compatibles is appropriate and makes it seem like you should be
> using device compatibles as a fallback.

That is redundant.

>
> The rest looks okay other than the filename, which doesn't match any of
> the compatibles that you've got here.
>

How should I call it then?

> Cheers,
> Conor.
>
> > +
> > +  reg:
> > +    description:
> > +      The ASUS Transformer EC has a main I2C address and an associated
> > +      DockRAM device, which provides power-related functions for the
> > +      embedded controller. Both addresses are required for operation.
> > +    minItems: 2
> > +
> > +  reg-names:
> > +    items:
> > +      - const: ec
> > +      - const: dockram
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  request-gpios:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - interrupts
> > +  - request-gpios
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    i2c {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +
> > +      embedded-controller@19 {
> > +        compatible =3D "asus,tf201-ec-dock", "asus,transformer-ec-dock=
";
> > +        reg =3D <0x19>, <0x1b>;
> > +        reg-names =3D "ec", "dockram";
> > +
> > +        interrupt-parent =3D <&gpio>;
> > +        interrupts =3D <151 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +        request-gpios =3D <&gpio 134 GPIO_ACTIVE_LOW>;
> > +
> > +        monitored-battery =3D <&dock_battery>;
> > +      };
> > +    };
> > +...
> > --
> > 2.51.0
> >
