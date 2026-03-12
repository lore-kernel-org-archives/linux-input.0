Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FE333F5A5
	for <linux-input@vger.kernel.org>; Thu, 12 Mar 2026 00:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773277140; cv=pass; b=GEYmdjnWHtlw7ng/iiUbQ8gkY3S6ubD4hWP6tajqtO5aR916LjbJ6kJFYXvUXfOaRyjzQoOMzAfJGnk/Zaxc4HNRutd/b97B0H2UL80GcnMAVKqnUHPIqxdMQNc0X0g4ZkVgL2M2BwBU/OwLi04hM8h24Wl4zm8qLDoTpTiz+hQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773277140; c=relaxed/simple;
	bh=/U4y6zMTaicCXSRzWDrp1+5aO6aDI934v4bGAGFBGSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFGbksQBxgFgQLrVjFbiGQ32pn58ngKifeM+DyzDmiIGOIbPM7Z9YtVZIlr9G8TYI53qv1Xw5Q/w6AWgaKRLrK6FYxuhVFX4lQsAYgvLmfmKotx/ec9pNyOb7EH1wHV+bTQ7Mvnqstep0rrKXnVXPHcX0IKIj2fCxenjooRTKyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XSmm664+; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XSmm664+"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64ad79dfb7cso638351d50.2
        for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 17:58:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773277136; cv=none;
        d=google.com; s=arc-20240605;
        b=Pb5JFkMpwzwrysNx3AdFjg444GL3kzQzrPm2EfGGPO6ALzNlwlmPe0OVXoPTOmLlF6
         0Q6sInlWVqJZm/h9xuP2YuLL0wuFi81ux4SA2lDDnE393DukwKxnAPC5ObQ1NdtVezjn
         /yeMRn0q5C1DIe3QijTQncOGzD2pHLkpxDz0XysXl2FCwJFHTs6wYwv5JJY1MGkM0tga
         f+PtvNoosdMXMi1b+pTi+/brnHbgS0dWzjGt0W8VzVUmDDe1arQLnHBo8Px5oRovNZGi
         zTjhFQxBjcZQ30cOmnql0cSm/5lBTy3rpmKGAlpBYRzfExCZNKMxSOqLz5BHEoVvDBaZ
         SC5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hm+lu25xFH5D13LzOfbqgKLYsmGame8eJlz+wGxK40k=;
        fh=vlnWt7OY8RKzrECSWV2J9B6extpjKVoXXLkTAxMJn6o=;
        b=Z9NU/Wto9oIq7W3oHPY/PVEHJidMXH4twCnRqbB6nuw4LQL2hHsB1bqsKhCmP9yxn4
         tyP3QPhUEKWTEZ2SbB8wk2/Dga/ZO8RnzQep+y43cSLJVTJkVIfDwGe5b7bpeiFkK8+W
         mrgalnx/BeP1VPdpFdc9YAdZKr0ujQ9DdwIdJssL4nVt0hozG8krC02wnrQSNqZsOs00
         v9hk0v0xJ0SthbAqKH0gFdWjKSqByBOzJ6xzPODoJKqqBkhzG8QlWubUP8LVR6cJH6VM
         pesyuMxM6fkK9EYsu4Du7A25LG2RqXyIZ1NdH2XgyK+qt9hop+ioGEENstxt7dkAKDQQ
         Sgfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773277136; x=1773881936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hm+lu25xFH5D13LzOfbqgKLYsmGame8eJlz+wGxK40k=;
        b=XSmm664+cpfOX++b/WASYI+HDr/mXw8VjWvr3goVQdJDMsHcwWVhGVp3VlY2/EOq/e
         cOCptFmrJaJRPR10fWmyzHERv4q0vwvKrRIGsdPPih2/sO+jNybIXpQmlNawq3p66aNm
         UoIlxrsSumXnUivwq7Cc9bLkwhBiOc7ktlyyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773277136; x=1773881936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hm+lu25xFH5D13LzOfbqgKLYsmGame8eJlz+wGxK40k=;
        b=KXRa/p0oGIobtiOh4muS4weOKdJbmNpfeWRaQRQsY7+1fz2Tx+Qzh7ijkXXX5OGIr/
         28ZoId0RM628oGTKUxKrCIjIMDv94kEpbzlx4KFycqnFgC9YUw/aiFjheNjFBdhyrqTC
         eOx4TG42s55vZUqLpUzJiQUZFjUF6ObOVxe05ssvA4JSNqTyM/D6i0lEQbT7QNhlY5Uj
         NE8gbYDGOGQmn72AdBimzj4saENv8icuvsO+NXeHIqQ0Gd5wMKKsvFkKKEkMfDUexiJ/
         dS4i4PtYiz5wNaP6cH5sUPqBScQRMz42uhzOPlU0hMNsbYFtM2bCj8XrNtVKQwtWV+eV
         1VQg==
X-Forwarded-Encrypted: i=1; AJvYcCXbGegRMt4QpM6MoKgDsa2ZUY66K/2dEFFOTNqSFgSuS4/Ji7uhW/azVtTbPd8pY//7IWMwE5xgdniuPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQiKV0YPJ7FCICBrhWF7le6Eq6arTip/lT1+Ozbbs1uXdhIs/f
	shcGZX5F6oiKvhJm6YIMlqu7vsfMdXen3HJacEJXmEJUuXYOo4k8KZtijP/Pqut/cDia0movS7o
	X/c4WKZJwriFDB9wI9K1+zdgV+MkA+MuejMjzRkJp
X-Gm-Gg: ATEYQzw8/wzL7B4rSYjPA9Xigp0akN9R6qnWzQFLtL+k/ALX/qGzPmaLE4q8lwXosOg
	WBNuYWJTd2YgQzcwF+OsYVdgxVgR840UrttVOYUhrlEeD0BS31upfpgSGOyYqEMYymqfv7hr1qK
	5onkVmP8kwI9LbNsr/N1hNZyFnv+Rw7AUCxGlvXOKuhSW0Y0VonGdFOQrykYGIMunMJMQtrXa3I
	JuCZ/fI4F6s0yJXqQxUWhm6tqqx42XeGm6T8QrNh5bVxM56ArgkSmJMZZnSudGdHPDTv03wrgJG
	0J2O/rLZb8GcQT/vzOnPCe/iXWL17BP5r18u3Rse
X-Received: by 2002:a53:ee54:0:b0:644:60d9:8648 with SMTP id
 956f58d0204a3-64d6587b0dbmr3375090d50.87.1773277136581; Wed, 11 Mar 2026
 17:58:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
 <20260303-send-upstream-v1-9-1515ba218f3d@chromium.org> <CAL_JsqKN45FswZjo+27OzoHMeM7ec3hS7piF7SKNykmXNSmA0g@mail.gmail.com>
 <CAEe3GZHSqepvjjopLwrWX3_n4+RnCeVVQnAO=Swixgu2z3OpUw@mail.gmail.com>
In-Reply-To: <CAEe3GZHSqepvjjopLwrWX3_n4+RnCeVVQnAO=Swixgu2z3OpUw@mail.gmail.com>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Wed, 11 Mar 2026 17:58:45 -0700
X-Gm-Features: AaiRm52dLVPqyen2q9prIqB7vkYq8vC1PiQ2eD_fJkVgOSB27JkdvvaCBQOmlW4
Message-ID: <CAEe3GZE_79Lqtzv4ZRi6zWuV_DgkCREBDcZJjpR+X9OaGZCA2g@mail.gmail.com>
Subject: Fwd: [PATCH 09/12] dt-bindings: input: Document hid-over-spi DT schema
To: Rob Herring <robh@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-spi@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Henry Barnor <hbarnor@chromium.org>, 
	Dmitry Antipov <dmanti@microsoft.com>, Jarrett Schultz <jaschultz@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(Resending to the list. Apologies, I accidentally dropped the CCs on
my initial reply!)

On Tue, Mar 3, 2026 at 5:53=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Mar 3, 2026 at 12:14=E2=80=AFAM Jingyuan Liang <jingyliang@chromi=
um.org> wrote:
> >
> > Documentation describes the required and optional properties for
> > implementing Device Tree for a Microsoft G6 Touch Digitizer that
> > supports HID over SPI Protocol 1.0 specification.
> >
> > The properties are common to HID over SPI.
> >
> > Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> > Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> > Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
> > ---
> >  .../devicetree/bindings/input/hid-over-spi.yaml    | 153 +++++++++++++=
++++++++
> >  1 file changed, 153 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/input/hid-over-spi.yaml =
b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
> > new file mode 100644
> > index 000000000000..b623629ed9d3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
> > @@ -0,0 +1,153 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/input/hid-over-spi.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: HID over SPI Devices
> > +
> > +maintainers:
> > +  - Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > +  - Jiri Kosina <jkosina@suse.cz>
> > +
> > +description: |+
> > +  HID over SPI provides support for various Human Interface Devices ov=
er the
> > +  SPI bus. These devices can be for example touchpads, keyboards, touc=
h screens
> > +  or sensors.
> > +
> > +  The specification has been written by Microsoft and is currently ava=
ilable here:
> > +  https://www.microsoft.com/en-us/download/details.aspx?id=3D103325
> > +
> > +  If this binding is used, the kernel module spi-hid will handle the c=
ommunication
> > +  with the device and the generic hid core layer will handle the proto=
col.
> > +
> > +allOf:
> > +  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - microsoft,g6-touch-digitizer
> > +          - const: hid-over-spi
> > +      - description: Just "hid-over-spi" alone is allowed, but not rec=
ommended.
> > +        const: hid-over-spi
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +    description:
> > +      GPIO specifier for the digitizer's reset pin (active low). The l=
ine must
> > +      be flagged with GPIO_ACTIVE_LOW.
> > +
> > +  vdd-supply:
> > +    description:
> > +      Regulator for the VDD supply voltage.
>
> Is this part of the spec? This won't scale for multiple devices with
> different power rails.

This is not part of the spec but is needed for power management. Is it okay=
 I
mark it as optional? Thank you.

>
> > +
> > +  input-report-header-address:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0
> > +    maximum: 0xffffff
> > +    description:
> > +      A value to be included in the Read Approval packet, listing an a=
ddress of
> > +      the input report header to be put on the SPI bus. This address h=
as 24
> > +      bits.
> > +
> > +  input-report-body-address:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0
> > +    maximum: 0xffffff
> > +    description:
> > +     A value to be included in the Read Approval packet, listing an ad=
dress of
> > +      the input report body to be put on the SPI bus. This address has=
 24 bits.
> > +
> > +  output-report-address:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0
> > +    maximum: 0xffffff
> > +    description:
> > +      A value to be included in the Output Report sent by the host, li=
sting an
> > +      address where the output report on the SPI bus is to be written =
to. This
> > +      address has 24 bits.
> > +
> > +  post-power-on-delay-ms:
> > +    description:
> > +      Optional time in ms required by the device after enabling its re=
gulators
> > +      or powering it on, before it is ready for communication.
>
> Drop. This should be implied by the compatible.

Thank you, I will fix this in v2.

>
> > +
> > +  minimal-reset-delay-ms:
> > +    description:
> > +      Optional minimum amount of time in ms that device needs to be in=
 reset
> > +      state for the reset to take effect.
>
> Drop. This should be implied by the compatible.

I will fix this in v2.

>
> > +
> > +  read-opcode:
> > +  $ref: /schemas/types.yaml#/definitions/uint8
> > +    description:
> > +      Value to be used in Read Approval packets. 1 byte.
> > +
> > +  write-opcode:
> > +  $ref: /schemas/types.yaml#/definitions/uint8
> > +    description:
> > +      Value to be used in Write Approval packets. 1 byte.
>
> Why are these and the address properties above not defined by the
> spec? Do they vary for a specific device? If not, then they should be
> implied by the compatible.

These properties are not defined by the spec:

"The Input Report Address (header or body) and READ opcode are retrieved
from ACPI."

Same for the output report address and write opcode. I will drop these in v=
2.

>
> > +
> > +  hid-over-spi-flags:
> > +  $ref: /schemas/types.yaml#/definitions/uint16
> > +    description:
> > +      16 bits.
> > +      Bits 0-12 - Reserved (must be 0)
> > +      Bit 13 - SPI Write Mode. Possible values -
> > +        * 0b0- Writes are carried out in Single-SPI mode
> > +        * 0b1- Writes are carried out in the Multi-SPI mode specified =
by bits
> > +               14-15
> > +      Bits 14-15 - Multi-SPI Mode. Possible values -
> > +        * 0b00- Single SPI
> > +        * 0b01- Dual SPI
> > +        * 0b10- Quad SPI
>
> We already have SPI properties to define the bus width for read and write=
.

Will fix this in v2.

>
> > +
> > +required:
> > +  - compatible
> > +  - interrupts
> > +  - reset-gpios
> > +  - vdd-supply
> > +  - input-report-header-address
> > +  - input-report-body-address
> > +  - output-report-address
> > +  - read-opcode
> > +  - write-opcode
> > +  - hid-over-spi-flags
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    spi {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +
> > +      hid@0 {
> > +        compatible =3D "hid-over-spi";
> > +        reg =3D <0x0>;
> > +        interrupts-extended =3D <&gpio 42 IRQ_TYPE_EDGE_FALLING>;
> > +        reset-gpios =3D <&gpio 27 GPIO_ACTIVE_LOW>;
> > +        vdd-supply =3D <&pm8350c_l3>;
> > +        pinctrl-names =3D "default";
> > +        pinctrl-0 =3D <&ts_d6_reset_assert &ts_d6_int_bias>;
> > +        input-report-header-address =3D <0x1000>;
> > +        input-report-body-address =3D <0x1004>;
> > +        output-report-address =3D <0x2000>;
> > +        read-opcode =3D <0x0b>;
> > +        write-opcode =3D <0x02>;
> > +        hid-over-spi-flags =3D <0x0000>;
> > +        post-power-on-delay-ms =3D <5>;
> > +        minimal-reset-delay-ms =3D <5>;
> > +      };
> > +    };
> > \ No newline at end of file
>
> Fix this.

Will fix this in v2.

>
> Rob
