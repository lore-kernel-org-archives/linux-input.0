Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2302C1584
	for <linux-input@vger.kernel.org>; Fri, 13 Mar 2026 01:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773364470; cv=pass; b=SgI9dgiMT6oi24lkp3uyPsK+uah4hBttuRFKQ2YAN4Pcv1gjcd7PQnbBwoHd1Yy/xOwaNNfrlT9p6+TAsZLYY6ynOODJmq4bTLauSmC3N08toK6EMhh8m92O/hLhBttK6DCElBXc3x+AhoAOlpfRa3jB59kDgnIrPEZ+HebDHlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773364470; c=relaxed/simple;
	bh=psKktp/nup6nZMgzTPATdryw8+DhKQuOchQeXOfmWq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iclFscgev9P+QbXR+1Q7Q8+i+F16SNpIcSad6KaBbl7M3t6pAJ3wUXWQL+iddRRR0Tqn26s2Lxgm3VZLt4lEVINVp9Ar01RQsSsI/5XvWBl75i5oDfUw8YpDmgLxAYLvpAHqvq9ou5qQn3gt8K+DkGMH1qJjWkIZh3j67wlddEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QNMdAt9O; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QNMdAt9O"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64ca9ec3ee7so1961824d50.3
        for <linux-input@vger.kernel.org>; Thu, 12 Mar 2026 18:14:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773364466; cv=none;
        d=google.com; s=arc-20240605;
        b=KDBUcjfrJQyOcjjkkH+dW/6WtzluxMNhgqg/U2buc7TN6idSA3sOAgSBsAakBc6AK/
         SqnNb/5Mdp2XqTX1qPIxMmWH/g4dig2Lqltef3zDqaTkF+z8BXOssS4Qfp2vy0Y1NnrM
         /6RC3AbrSTfyI2QOYBN00o3AzQZNZqLxsJCG6r7x6T0yQ68v4UBseJ/LKha37ZTnJAHY
         /C/hOAheS3yo0xHqffhOfjD7s+rfOmhjyLwEKw/hWEiteRu5t7XagkBmDkNpd+RC/Zm/
         zsgyaDxJ5jDG1Azo7F394H40kcpv1s8hr23bSmOFcWaG7p3XaQX59W9YSQRJ6vYGq57r
         OBRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XsVwh2464IoFcXnN+yaN2QavLIXog4pSrjEAjn/PCrA=;
        fh=JC53rS/hN2HIWLkr5Lf1qMt5XU1vRUrSWtWpobApjLA=;
        b=cth0N2RtNjJxTVQeYXS4RM5q5MK3orttyMZ6sFaq3SG+zKqOGYnn76LRSH8m+qZO5p
         QxKkODx/zHYOYVqggqwcegt2eXsXrifnYRN1fmfe1og9pF8ZXA62zGRzjRFk2Zp0f2R2
         /Oid7jbrqVxvLjxK4qeUVn3Q/G2qa8wrjqS6z/vXfg9gj7sJLEmnNtX5f+b9WosTulEj
         YbUzf2dncgwKhhYP0K2gyfOmul7FbuSAaCexsKORvfkg4L5XyDVTs2VP/tyLazQytinU
         NY6iFZoEYlOwo6efaxcMLp3RfetR2Z5ZmDG4LeLitVMIzSv4f8Rt5I8IxnB4hTnhLpGk
         67BQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773364466; x=1773969266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsVwh2464IoFcXnN+yaN2QavLIXog4pSrjEAjn/PCrA=;
        b=QNMdAt9Ov1YHfhL+lLr19x1w72S5dTMgRwKkyoaA/JlGg5OOeJKuh6tX/82tkcetHs
         65Qk4HvMBWhISc/eX8p2x8FTB9nC4218HQsRNK0aVyl6D2CHXn44UDN9Pnh9iPYk0uHJ
         HpDnW+Rk0E/JsHQjcdolwdxyt7gOkCR+SgoPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773364466; x=1773969266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XsVwh2464IoFcXnN+yaN2QavLIXog4pSrjEAjn/PCrA=;
        b=J/yUjQ6sEYEJvEhTSJOnjNH+O8ZmBn9QinsbLSNk0rWJYEXngPAMX1qfBmJG3YF7go
         wrf3uo02pPEvenR8P2XVWMv9LQRaoyYQACwA21UmSP1BmsuvVkYZ0Ln3rOuAspJ8L0x7
         l7Z++qP0oe+f18lX8SJm2HJeilG8YuCZ7EgUpMSMF33gMP1s4gKzBO7VHSV5+yB4jeDt
         FCWIYZEXyVYHxeY3kwE7vZXfBcHAZVcKG2lZrLdGMk86xeEpEsTLiuxZxipB9ueBhXMV
         ROaayTViT7f5OPvPesZ2x6n/dBWMzokTM6oWMMHbc74PT05R5RbqntRDcZxdKSqgQ9KM
         7gfA==
X-Forwarded-Encrypted: i=1; AJvYcCXb0vLl8NYUS21osUQOXiOD+GFos2y62FRa8vjDz9Rzxnx5pQJknvTJx/aqP+Q/mPxZ30SRaTWH9uBMjA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yytk/9A2+FqL1gmz0y4moqmtsR2fbSWSvOZot94v1RirEM1osE6
	ZVJFHFzzNwGQcCopdVYpl0OjQ3JTsFMS5XFBpx2U7qMFYz1AyBgKikN8A0KomsO7I9KUyY1bu1r
	OSXvpgmJiSnid/WGCcL64jzDuFxsbOQ65xK72kIc2
X-Gm-Gg: ATEYQzxOgm19qZXtRfx3D6ZVx3QN/FSJLsbDTwUFwlGnAiKt1sNVgbf667cc6YYlMgE
	nu8klBUfnrGxbvaTptE36CKSVqkKMGNQhjz0nb63jdxjDTanveR07nIGqg/CYbGiudtIT2K81QP
	rq9568fHt6LFWcHSnpf9/riKYrraAP4WU9Va53ic1xPo4sw2n+l/bpw6OsVsIjNEnKYF1r5eQ+X
	rvMOvOBqgnrZV68wXxZgfBqRYgmlEk4hWNGKBPwpLTNit9f3v9w/yuLR6G5o42VWoVM9obG8Kl7
	lamhDs+g1iayJkNXfNYnz7i7M9dBp5h9pV5fyHeF
X-Received: by 2002:a05:690e:4397:b0:64c:a4ab:e4e8 with SMTP id
 956f58d0204a3-64e62f82e22mr1347986d50.20.1773364466142; Thu, 12 Mar 2026
 18:14:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
 <20260303-send-upstream-v1-9-1515ba218f3d@chromium.org> <CAL_JsqKN45FswZjo+27OzoHMeM7ec3hS7piF7SKNykmXNSmA0g@mail.gmail.com>
 <CAEe3GZHSqepvjjopLwrWX3_n4+RnCeVVQnAO=Swixgu2z3OpUw@mail.gmail.com> <CAEe3GZE_79Lqtzv4ZRi6zWuV_DgkCREBDcZJjpR+X9OaGZCA2g@mail.gmail.com>
In-Reply-To: <CAEe3GZE_79Lqtzv4ZRi6zWuV_DgkCREBDcZJjpR+X9OaGZCA2g@mail.gmail.com>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Thu, 12 Mar 2026 18:14:14 -0700
X-Gm-Features: AaiRm53z2pwybc4kbLAIMgl_PixN23FG-WeD36EXTB7vuwi5JCVo-2fq7v7lJcI
Message-ID: <CAEe3GZEOYCFRfz8W3p2_JpYrRTfqSzp7mdGtS+wMHP7oYgSHDA@mail.gmail.com>
Subject: Re: [PATCH 09/12] dt-bindings: input: Document hid-over-spi DT schema
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

On Wed, Mar 11, 2026 at 5:58=E2=80=AFPM Jingyuan Liang <jingyliang@chromium=
.org> wrote:
>
> (Resending to the list. Apologies, I accidentally dropped the CCs on
> my initial reply!)
>
> On Tue, Mar 3, 2026 at 5:53=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
> >
> > On Tue, Mar 3, 2026 at 12:14=E2=80=AFAM Jingyuan Liang <jingyliang@chro=
mium.org> wrote:
> > >
> > > Documentation describes the required and optional properties for
> > > implementing Device Tree for a Microsoft G6 Touch Digitizer that
> > > supports HID over SPI Protocol 1.0 specification.
> > >
> > > The properties are common to HID over SPI.
> > >
> > > Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> > > Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> > > Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
> > > ---
> > >  .../devicetree/bindings/input/hid-over-spi.yaml    | 153 +++++++++++=
++++++++++
> > >  1 file changed, 153 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/input/hid-over-spi.yam=
l b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
> > > new file mode 100644
> > > index 000000000000..b623629ed9d3
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
> > > @@ -0,0 +1,153 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/input/hid-over-spi.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: HID over SPI Devices
> > > +
> > > +maintainers:
> > > +  - Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > +  - Jiri Kosina <jkosina@suse.cz>
> > > +
> > > +description: |+
> > > +  HID over SPI provides support for various Human Interface Devices =
over the
> > > +  SPI bus. These devices can be for example touchpads, keyboards, to=
uch screens
> > > +  or sensors.
> > > +
> > > +  The specification has been written by Microsoft and is currently a=
vailable here:
> > > +  https://www.microsoft.com/en-us/download/details.aspx?id=3D103325
> > > +
> > > +  If this binding is used, the kernel module spi-hid will handle the=
 communication
> > > +  with the device and the generic hid core layer will handle the pro=
tocol.
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - items:
> > > +          - enum:
> > > +              - microsoft,g6-touch-digitizer
> > > +          - const: hid-over-spi
> > > +      - description: Just "hid-over-spi" alone is allowed, but not r=
ecommended.
> > > +        const: hid-over-spi
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  reset-gpios:
> > > +    maxItems: 1
> > > +    description:
> > > +      GPIO specifier for the digitizer's reset pin (active low). The=
 line must
> > > +      be flagged with GPIO_ACTIVE_LOW.
> > > +
> > > +  vdd-supply:
> > > +    description:
> > > +      Regulator for the VDD supply voltage.
> >
> > Is this part of the spec? This won't scale for multiple devices with
> > different power rails.
>
> This is not part of the spec but is needed for power management. Is it ok=
ay I
> mark it as optional? Thank you.
>
> >
> > > +
> > > +  input-report-header-address:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    minimum: 0
> > > +    maximum: 0xffffff
> > > +    description:
> > > +      A value to be included in the Read Approval packet, listing an=
 address of
> > > +      the input report header to be put on the SPI bus. This address=
 has 24
> > > +      bits.
> > > +
> > > +  input-report-body-address:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    minimum: 0
> > > +    maximum: 0xffffff
> > > +    description:
> > > +     A value to be included in the Read Approval packet, listing an =
address of
> > > +      the input report body to be put on the SPI bus. This address h=
as 24 bits.
> > > +
> > > +  output-report-address:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    minimum: 0
> > > +    maximum: 0xffffff
> > > +    description:
> > > +      A value to be included in the Output Report sent by the host, =
listing an
> > > +      address where the output report on the SPI bus is to be writte=
n to. This
> > > +      address has 24 bits.
> > > +
> > > +  post-power-on-delay-ms:
> > > +    description:
> > > +      Optional time in ms required by the device after enabling its =
regulators
> > > +      or powering it on, before it is ready for communication.
> >
> > Drop. This should be implied by the compatible.
>
> Thank you, I will fix this in v2.
>
> >
> > > +
> > > +  minimal-reset-delay-ms:
> > > +    description:
> > > +      Optional minimum amount of time in ms that device needs to be =
in reset
> > > +      state for the reset to take effect.
> >
> > Drop. This should be implied by the compatible.
>
> I will fix this in v2.
>
> >
> > > +
> > > +  read-opcode:
> > > +  $ref: /schemas/types.yaml#/definitions/uint8
> > > +    description:
> > > +      Value to be used in Read Approval packets. 1 byte.
> > > +
> > > +  write-opcode:
> > > +  $ref: /schemas/types.yaml#/definitions/uint8
> > > +    description:
> > > +      Value to be used in Write Approval packets. 1 byte.
> >
> > Why are these and the address properties above not defined by the
> > spec? Do they vary for a specific device? If not, then they should be
> > implied by the compatible.
>
> These properties are not defined by the spec:
>
> "The Input Report Address (header or body) and READ opcode are retrieved
> from ACPI."
>
> Same for the output report address and write opcode. I will drop these in=
 v2.

Hi Rob,

Please disregard my previous reply about dropping the read/write opcodes an=
d
input/output addresses. The spec does not define these fields. Instead, it =
says
these values are retrieved from ACPI _DSM methods. If we remove them from
the binding, the driver is not very generic. Would it be okay to keep them?

>
> >
> > > +
> > > +  hid-over-spi-flags:
> > > +  $ref: /schemas/types.yaml#/definitions/uint16
> > > +    description:
> > > +      16 bits.
> > > +      Bits 0-12 - Reserved (must be 0)
> > > +      Bit 13 - SPI Write Mode. Possible values -
> > > +        * 0b0- Writes are carried out in Single-SPI mode
> > > +        * 0b1- Writes are carried out in the Multi-SPI mode specifie=
d by bits
> > > +               14-15
> > > +      Bits 14-15 - Multi-SPI Mode. Possible values -
> > > +        * 0b00- Single SPI
> > > +        * 0b01- Dual SPI
> > > +        * 0b10- Quad SPI
> >
> > We already have SPI properties to define the bus width for read and wri=
te.
>
> Will fix this in v2.
>
> >
> > > +
> > > +required:
> > > +  - compatible
> > > +  - interrupts
> > > +  - reset-gpios
> > > +  - vdd-supply
> > > +  - input-report-header-address
> > > +  - input-report-body-address
> > > +  - output-report-address
> > > +  - read-opcode
> > > +  - write-opcode
> > > +  - hid-over-spi-flags
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +    #include <dt-bindings/gpio/gpio.h>
> > > +
> > > +    spi {
> > > +      #address-cells =3D <1>;
> > > +      #size-cells =3D <0>;
> > > +
> > > +      hid@0 {
> > > +        compatible =3D "hid-over-spi";
> > > +        reg =3D <0x0>;
> > > +        interrupts-extended =3D <&gpio 42 IRQ_TYPE_EDGE_FALLING>;
> > > +        reset-gpios =3D <&gpio 27 GPIO_ACTIVE_LOW>;
> > > +        vdd-supply =3D <&pm8350c_l3>;
> > > +        pinctrl-names =3D "default";
> > > +        pinctrl-0 =3D <&ts_d6_reset_assert &ts_d6_int_bias>;
> > > +        input-report-header-address =3D <0x1000>;
> > > +        input-report-body-address =3D <0x1004>;
> > > +        output-report-address =3D <0x2000>;
> > > +        read-opcode =3D <0x0b>;
> > > +        write-opcode =3D <0x02>;
> > > +        hid-over-spi-flags =3D <0x0000>;
> > > +        post-power-on-delay-ms =3D <5>;
> > > +        minimal-reset-delay-ms =3D <5>;
> > > +      };
> > > +    };
> > > \ No newline at end of file
> >
> > Fix this.
>
> Will fix this in v2.
>
> >
> > Rob
