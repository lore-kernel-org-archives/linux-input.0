Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE64246BF
	for <linux-input@vger.kernel.org>; Mon, 16 Feb 2026 19:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771269295; cv=pass; b=Zre9SaU+cAnorgZdJiNAROeITzkhKJQYkCd2IIqcqJaOs6YmDAnsuUELQUeyDmyBGxnr+CJ0sN5C4ez89ym7qATRvZYriaAhQZPnXAcyIU1gSvT9CU2VaYZJvIngkhuqxxNgpvZJWh6JBGx9B9iVr+fABPowBNZgGoHUwE8b3L8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771269295; c=relaxed/simple;
	bh=6roQzUPN6oF3NP6XZiyAscAXoZCFMtBPdLph18EvMsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIqOdxogD3iEgKaHxsZw3z3DLWVIGg7npbxzlG3f8u6Pfop53Lzey9GKhWm9cUJkLRTwm9MpW9vxyo+Y19eG2Iaevllg5mdbPR8cdxFPg028zvZAA9gs3aeMW3UMtXMWH77B0ZDYP4IJ1cbMdColiemKfeaXwSuSMoVXtGYdKQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBraj7yv; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBraj7yv"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-483487335c2so33159415e9.2
        for <linux-input@vger.kernel.org>; Mon, 16 Feb 2026 11:14:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771269292; cv=none;
        d=google.com; s=arc-20240605;
        b=BHcJRM794Lvs4lO6kTX47nQBPc+daABgxRffwnSZfxXPGSCDzSKc+d4wo1zKXRnJTa
         TqRsdlEXVSIsOGeuBtA0/yByYyCgnF7sJcZduoX4OPwRgMJTFf0YVXWbOZdaBJaXJbkI
         RzQ/pD1ZFGYsD8ZB81VRiiOltqQC+9KGumvaFFX3XYPRNYZVH8dBg4OuREZ7i6/DvKI9
         gWEaYfqV3VpGSNQdd/IdPXH8HNie7ap+PtFx76LT8c8Fijpyi3QpG59StPR39PHK9wSg
         otNe4QVRgeuMqxybvth2wjZ27oGaJg31g31lasocoRzO9etdzd3gVXmuAfJbVw9lBCbJ
         wXow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8HzOcCRMFSbyhDqPBsCkdLqSYse4L0GDbUboaIwjmC0=;
        fh=MM+9B3IewOfvoZpnq33OX5ltCGiF2yAaMsPdUz9Achs=;
        b=CV3eGa2SZzEbb0akR82oMPXKoErTH4f5ZhlSs/DIhI65QRrnLHSCWonLgkYcqhO5NI
         HEU2rvuCpo/TyW8rmt7GcK59bypLBFYCrA/fT5vLvIm4391pifatWVqZar+g2tiBIgnZ
         /zaT9jTnVNUeVap4DVIzKIH+4IpNA2nbv14mvqL7cXrZ11xpS5NzTbh9FRE6iM2ORbRB
         A889JEiQNHW+VckW8nAQVsP16Z2ULCzrIRU00AARFDE1/aEeTnNeRGPLmxMuUo+XPiGk
         fp9z164XCx/ooj4PfsvEkJGyTI5VOC17t7YcBD0wkTEZL3d9HAzl7OhV51sVvzli2mw7
         IWFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771269292; x=1771874092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HzOcCRMFSbyhDqPBsCkdLqSYse4L0GDbUboaIwjmC0=;
        b=gBraj7yvq+F0JdwUJQGHi4JwvgYHX8PH+X4t8HtCuAQ0MX6rh0TxmgG7XZcamn5M/7
         pNyAMs4ysjDh3rD1Zbnw2niCR29cCHjIwUgnh0pG+0yub7kWA44vmiGZcmRqwvBRQTnE
         kyL6bUN2OUdP0VeNwbzytm8+luO1vUgRk0sq4GPcz6ikxpB7jGHYdusz58VOTbZFJfx6
         SM153meyBkL+zq08mPcj+KpaRd32z7XbntEgJ3NJzb/aU9u4KEIAjg+Ns4KHdeU/zUT+
         W6PfHFSD7BiB/kbNHoHX42pXTHcUp0oau9UnwKBzjZ/LOWgXXI6b1sw09yHmm/nhSm4J
         ikZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771269292; x=1771874092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8HzOcCRMFSbyhDqPBsCkdLqSYse4L0GDbUboaIwjmC0=;
        b=JnThS1dFM18O7vvfsk6M0EclZM+dX7LvLqc4EcigLuONrQ0BHr3RRuHYnfI2aNuTB4
         CTBqv2zG146F0CfmtSHPCL/dMBNdr6PFIzqP/2CF5p267PMN6wGD8InuYrLmDtx0f8ys
         18A60ydDxUozfSowouomXWddSOV2+vFH+iXBxXFhDi1PMgk4o7dVYZrJGau9YLptwzXS
         BNzw+Fh3cLVssfEpggD0+8YDx+moWBRyAWR6Oe8klp+Lz958e7aPFaMdBuQuPifStHGl
         b8swVC8+rmIqTwQOZwORmeeIMvnd3ZKZckYi+WSQox32q3aCV4mdv3r7uGLbBrpeSEQL
         cvIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIGiuEw0qYokWOSl+mVED75SVzYrzVTelabV4TVa9Ti3rqhbd8YHn2X/IXKhlnlmXHj8UNWS9iw/yvXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQk4FQtJslhc6V/FS8btY5h5Jnhj3xr6KgHfaxhEXThN9j6+2R
	zcxar4nJ97xDMx1aVYWTMUShxQQavY/fdezTLMzFmHImrsmGDvcwYbfJwwnXwDvS2BGEYg6dDAB
	3yFVQLds/pdcuuzSytdJnhcfsZ5feskE=
X-Gm-Gg: AZuq6aI9O6DiivCFgOu5ejbcNUXJ56UlHDM1IcWvF0RD+rOgL/jYjiaiT1c0yKQsakl
	iBYSJUlPqqYqVF26AxEra3LixLZMuW+B/dlgwEB/ryOLknK8oSog352V7Fn99yn1lLNP7/0H/oB
	c0ZGPOfxApDh7B6WS4XUzKwXECikU5/wK+0frmn4Mwa/3ogft0uE2RVNGb5HAAYT7/CqXtM5254
	NKe4Zf8QtogS0ZMCN8TcBsaai42xnFbObSX5zEKRMj00e5HcJzSnrZUYYD02Lf0sT4BdQo3Om7W
	1NJnGkAw
X-Received: by 2002:a05:600d:6413:20b0:483:79ad:f3b9 with SMTP id
 5b1f17b1804b1-48379adf60amr118355585e9.28.1771269292113; Mon, 16 Feb 2026
 11:14:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260214180959.30714-1-clamor95@gmail.com> <20260214180959.30714-2-clamor95@gmail.com>
 <20260216-sprung-scallop-de7b64bf528c@spud> <CAPVz0n06+uLCSfY_bYS9v7KJ-hXotye7ej-rze6-Q8_JAF7XVA@mail.gmail.com>
 <20260216-plunder-defense-de11cf56dd3d@spud>
In-Reply-To: <20260216-plunder-defense-de11cf56dd3d@spud>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 16 Feb 2026 21:14:40 +0200
X-Gm-Features: AaiRm53pjJr4DTXWQu3qeK8s5InrNWpSnyhcexyGL2cJPzW4JG4-eMOhlmVuupI
Message-ID: <CAPVz0n0-LbTUZBCaO=oN3PpPLpwAqzNo29r687pKY8NbEE9giA@mail.gmail.com>
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

=D0=BF=D0=BD, 16 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 20:50 Cono=
r Dooley <conor@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Feb 16, 2026 at 08:22:38PM +0200, Svyatoslav Ryhel wrote:
> > =D0=BF=D0=BD, 16 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 20:04 =
Conor Dooley <conor@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Sat, Feb 14, 2026 at 08:09:53PM +0200, Svyatoslav Ryhel wrote:
> > > > Document embedded controller used in ASUS Transformer device series=
.
> > > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  .../asus,transformer-ec.yaml                  | 98 +++++++++++++++=
++++
> > > >  1 file changed, 98 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/embedded-cont=
roller/asus,transformer-ec.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/embedded-controller/=
asus,transformer-ec.yaml b/Documentation/devicetree/bindings/embedded-contr=
oller/asus,transformer-ec.yaml
> > > > new file mode 100644
> > > > index 000000000000..670c4c2d339d
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/embedded-controller/asus,tr=
ansformer-ec.yaml
> > > > @@ -0,0 +1,98 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/embedded-controller/asus,transf=
ormer-ec.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: ASUS Transformer's Embedded Controller
> > > > +
> > > > +description:
> > > > +  Several Nuvoton based Embedded Controllers attached to an I2C bu=
s,
> > > > +  running a custom ASUS firmware, specific to the ASUS Transformer
> > > > +  device series.
> > > > +
> > > > +maintainers:
> > > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > > > +
> > > > +allOf:
> > > > +  - $ref: /schemas/power/supply/power-supply.yaml
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    oneOf:
> > > > +      - enum:
> > > > +          - asus,p1801-t-ec-pad
> > > > +          - asus,sl101-ec-dock
> > > > +          - asus,tf600t-ec-pad
> > > > +          - asus,tf701t-ec-pad
> > > > +
> > > > +      - items:
> > > > +          - enum:
> > > > +              - asus,tf101-ec-dock
> > > > +              - asus,tf101g-ec-dock
> > > > +              - asus,tf201-ec-dock
> > > > +              - asus,tf300t-ec-dock
> > > > +              - asus,tf300tg-ec-dock
> > > > +              - asus,tf300tl-ec-dock
> > > > +              - asus,tf700t-ec-dock
> > > > +          - const: asus,transformer-ec-dock
> > > > +
> > > > +      - items:
> > > > +          - enum:
> > > > +              - asus,tf201-ec-pad
> > > > +              - asus,tf300t-ec-pad
> > > > +              - asus,tf300tg-ec-pad
> > > > +              - asus,tf300tl-ec-pad
> > > > +              - asus,tf700t-ec-pad
> > > > +          - const: asus,transformer-ec-pad
> > >
> > > Can you explain somewhere here what the "dock" and "pad" devices are =
and
> > > how they differ? For example, I am currently wondering why tf700t has=
 both
> > > "dock" and "pad".
> >
> > "pad" is used for the controller in the tablet itself in the pad
> > "dock" is used for the controller in the mobile dock keyboard.
> > Seems quite obvious.
>
> To someone intimately familiar with the devices maybe. Not to the people
> you have to justify your patches to. Your response implies that this is
> some sort of thing that's like a surface, but please put an explicit
> explanation into the binding somewhere as to what each compatible is
> for.

Ok, fair.

>
> > > Also, why are some of the compatibles permitted standalone? That shou=
ld
> > > be mentioned in your commit message too. Also, other than the sl101, =
the
> > > standalone ones seem to have the same match data in the mfd driver. W=
hy
> > > are fallbacks not made use of there?
> > >
> >
> > Because standalone compatibles describe a unique hw configuration
> > which cannot be grouped into something meaningful. asus,p1801-t-ec-pad
> > is for EC of Tegra30/Intel based p1801-t AIO, asus,sl101-ec-dock is
> > for EC of Tegra20 slider tablet, asus,tf600t-ec-pad is for altered EC
> > in Win8 Tegra30 tablet, asus,tf701t-ec-pad is for Tegra114 tablet.
> > Different generations, different form-factors.
>
> I don't see any reasons here that eliminate fallback compatibles.
> +       { .compatible =3D "asus,p1801-t-ec-pad", .data =3D &asus_ec_pad_c=
harger_data },
> +       { .compatible =3D "asus,tf600t-ec-pad", .data =3D &asus_ec_pad_ch=
arger_data },
> +       { .compatible =3D "asus,tf701t-ec-pad", .data =3D &asus_ec_pad_ch=
arger_data },
> +       { }
> Three of them use the same match data, so you need to explain why you've
> made these three standalone when all the others that share a programming
> model got a generic fallback. Fallback usage is based on programming
> model, not based on whether the devices are a physically different, so
> your explanation must reflect this.
>
> > > Since this transformer series seems to have multiple programming mode=
ls
> > > for "ec-pad" devices, it calls into question your use of the generic
> > > fallback compatibles is appropriate and makes it seem like you should=
 be
> > > using device compatibles as a fallback.
> >
> > That is redundant.
>
> I don't understand how that is a response to what I said.
>

in other words you propose this:

properties:
  compatible:
    oneOf:
      - items:
          - enum:
              - asus,sl101-ec-dock
              - asus,tf101-ec-dock
              - asus,tf101g-ec-dock
              - asus,tf201-ec-dock
              - asus,tf300t-ec-dock
              - asus,tf300tg-ec-dock
              - asus,tf300tl-ec-dock
              - asus,tf700t-ec-dock
          - const: asus,transformer-ec-dock

      - items:
          - enum:
              - asus,p1801-t-ec-pad
              - asus,tf201-ec-pad
              - asus,tf300t-ec-pad
              - asus,tf300tg-ec-pad
              - asus,tf300tl-ec-pad
              - asus,tf700t-ec-pad
              - asus,tf600t-ec-pad
              - asus,tf701t-ec-pad
          - const: asus,transformer-ec-pad

And in the driver add match to every single entry of enums?

> > > The rest looks okay other than the filename, which doesn't match any =
of
> > > the compatibles that you've got here.
> > >
> >
> > How should I call it then?
>
> Make it match a compatible, just like any other binding.
