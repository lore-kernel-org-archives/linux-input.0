Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604281FE451
	for <linux-input@vger.kernel.org>; Sun,  1 Feb 2026 07:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769929292; cv=pass; b=MuzsX3Qw69fJPKqtr98RszOn6PkEFFHe4Obl2jOeSGlLaqv9Jjdf7IABXURRkVzbhMXUPD4Qbohgs5DYRCd4yotyXdLoNtsNFe1BA73Mujqklhee0NfCA/2VCx0x2AKpJrppGn2zowt6CDahFehRwmwWSvsUUMZbDqOz2cUblro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769929292; c=relaxed/simple;
	bh=4lwxL+MX5lYgnvQjumgh4AurnaGrE32hCgCl0vhDOYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rC/20tbM1MSQE3YLV2KBK4ex9deEU34f9Bz47b1oxccsfEtFPPdYYj3xmJPb9bIlL8PMlwQ1mYkK91mvkAhoGUd/ng+055cWZqQWL6oWH7xHJd1Ts208Y8RM8IvSUNHmVTltgAHbN97U1szlAWFVVCat1STTEUgyreWAzLVkapk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jn9EfSA6; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jn9EfSA6"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43284ed32a0so1825555f8f.3
        for <linux-input@vger.kernel.org>; Sat, 31 Jan 2026 23:01:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769929290; cv=none;
        d=google.com; s=arc-20240605;
        b=UuVFnqcm6vasoMLzo7DBCuXtHzEAC1c9CHXnWMb1m2CwdGSv2HILW+oBqH5nzjuDSh
         c2/WwasnyBosHif5hCwK5ME7t870QD1CssUD2M+BBhWWQUefSLMAToUoHsYad64vkkIo
         ZzMYltCoCPZMAb7DHqj9Q0GcK+hKbPxoXhJLPu/ojTihKDpZo7kzPIiGBfUwH2f7W0BV
         xhTmuX1rWmjyKmY/KoOPxelwkelnnLvaYReR8ob2isaTaKjY4Jcj9ow0VlP6EhNot7U7
         rXy1E+/AXR/zfTGULkMF+cD5F03Oe5R1jThLpr4K4tGkW16LWYe47bgPM1tEVzgdio8v
         MVvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ru6T+Kx+o+wF1O0sdT4WJIlvaSW/GAs5TSwcPEqdU2s=;
        fh=9IHR1o8uGXYFoPxyp0Th8SJKTw8ZTKBHMNSXpV526ns=;
        b=R6nhkxw7k7olPOoPdIrgTbBtQE/uiHgTQO9O+mOm7plO46or+uem7tfOlUffQEl6uE
         0r4zbQbs/TaPPIjVVINA+75yc6AdlZB7Xt4hx/q4HTCf4nJiyzX65rA2HUNmtb2ITlIn
         mTsob+qfPCvSH/ysOCZGJm+nEX8163G4qyxPVKfnXZDJ6+rw+LBSEpXR0eA/mAbjFxFq
         r0CY/jvmS+rliZNVQ2FJpHi0UCjeXPeH+8tVqN6d8qiQt36msnYpFBoHKOgr9RiWsL5Q
         bV3zCmxnbKVca1FZe5yEYpL12VkksCwWlOqAvrQUlmo6mKqLQV8QM5UQfhMrHe6wFG8I
         H4QQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769929290; x=1770534090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ru6T+Kx+o+wF1O0sdT4WJIlvaSW/GAs5TSwcPEqdU2s=;
        b=Jn9EfSA6fRuIVKLr4AaDLNSKBNL8pNLIzAn3ZvhMvVaTDKFsq+ipWeCMRNkekMrUgb
         A0Ln5mZ3LggiURzzV2WBXJxP6cuuWXb9TNIlrGVNUxwCIIaEem1gpptyrSPCZ5IlMDzt
         5fUbTS5GA6rBJL/oI1+pxmc1I/uBvhnJp+aO2sGBmNMcyl/Xyo7jAV9n5GbMdfk+o807
         NMKhRMYdWew37MtphMm6TqfcCIju0X+RKLvk8Vsd43Yo681J0zRY+sepZFOjGN7tkDRF
         PWC+YPRkx8zVPqfVGZwbFfwyirHPDJ+z/+3WyyRp0uY1XpuaRpWj7vuJVPrx6xv4dztz
         aa4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769929290; x=1770534090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ru6T+Kx+o+wF1O0sdT4WJIlvaSW/GAs5TSwcPEqdU2s=;
        b=LMrQeopdoHby7hLTVGxPtd6HwwpG/dNuppH1SS3IW61O8NX/aDM6k4iI0a7lF4Fd1Z
         p4rUdaZ6zaWY8eYLzaBP/HqypDZTfkMQgCyC9Xigznv9zsKoA+9PYJrlUFNg8JUR7ewX
         HbIB+M9ho/aTZGajNt3kAoCXPhEHoTT54Vvc3jEp6boc95UYb+w4nRJpSpZa5IeKCoQp
         flXWzYJJ854qVq+DmI/jegWVV/xLAmqejGQnJ9Q+mj2tOWVmmVTBhJzIZbedLxDNG9Mo
         qfDWbSMB8tQKmRdIh9fhNilbixOLGeq3hOrLn1wsOYe0mSXWRiX1XmCyggbu8jTOKqKo
         dqjw==
X-Forwarded-Encrypted: i=1; AJvYcCUIHuYfbxXy/VV3Gor3ztMxy4qQ0bozC/U0WTozPrrEpwDCsUMavIGYKMWcAVrSo0CQF3KLeUkLkGaAHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzntSUBkG449JZa7lXH5JUpbR9vFVHfntO+kyV3r1fV0sPQlQhv
	T9py0Dt3aOejO8rssee2zF5HY69LyZFq50hs2scovdb/kXiJw5uQs2LlUhCxncl3nrKCuxl77Jx
	FsANcR69r+lczT8Ol1yJ2dj3v0iptGus=
X-Gm-Gg: AZuq6aJVjd66pf7RVUv0T6NLu0BEiw3ejxRu/JGfSoZac+Y3pgBDlmv6E/gnXdL9Q3+
	OLCshaIMamuWTbvczUzChxchHGHBvJITcJqKnIN4MFauVKbQY56tnUUEJHo2NqA0NfA1jzCHOgp
	ZBOjb/oYY6wRWeUitYJss1A4Tk7qeVEqOxV2uCxYxtApKCFfcaqjTXRNGhmtjdo8N1CSZOihzvC
	lpmJv8Unaj96Dx+lQry0Tssk1tpBo3N8ovM4xGuDJ9G2QUkGRaVtOQilksVnPkgB0nXnlOc
X-Received: by 2002:a5d:5f54:0:b0:435:693e:c03e with SMTP id
 ffacd0b85a97d-435f3a7e60emr11130004f8f.19.1769929289499; Sat, 31 Jan 2026
 23:01:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125134302.45958-1-clamor95@gmail.com> <20260125134302.45958-2-clamor95@gmail.com>
 <d7938728-fded-4d5e-b23d-a8346e3fab46@baylibre.com>
In-Reply-To: <d7938728-fded-4d5e-b23d-a8346e3fab46@baylibre.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 1 Feb 2026 09:01:18 +0200
X-Gm-Features: AZwV_QgtHi-_En-5pR0mvFW293XW7g0IV-2szoIz-T-UyTapQDFggPFL8QY1fqE
Message-ID: <CAPVz0n205rKSAq2Jbtahn6xW2MYgSm61qxjRbsSs_4RBSEs34Q@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] dt-bindings: regulator: cpcap-regulator: convert
 to schema
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Dixit Parmar <dixitparmar19@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D0=B1, 31 =D1=81=D1=96=D1=87. 2026=E2=80=AF=D1=80. =D0=BE 21:46 Davi=
d Lechner <dlechner@baylibre.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 1/25/26 7:42 AM, Svyatoslav Ryhel wrote:
> > Convert devicetree bindings for the Motorola CPCAP MFD regulator subnod=
e
> > from TXT to YAML format. Main functionality preserved and added compati=
ble
> > for CPCAP regulator set found in the Mot board.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../bindings/regulator/cpcap-regulator.txt    | 35 -------------
> >  .../regulator/motorola,cpcap-regulator.yaml   | 51 +++++++++++++++++++
> >  2 files changed, 51 insertions(+), 35 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/regulator/cpcap-r=
egulator.txt
> >  create mode 100644 Documentation/devicetree/bindings/regulator/motorol=
a,cpcap-regulator.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/regulator/cpcap-regulato=
r.txt b/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
> > deleted file mode 100644
> > index 36f5e2f5cc0f..000000000000
> > --- a/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
> > +++ /dev/null
> > @@ -1,35 +0,0 @@
> > -Motorola CPCAP PMIC voltage regulators
> > -------------------------------------
> > -
> > -Requires node properties:
> > -- "compatible" value one of:
> > -    "motorola,cpcap-regulator"
> > -    "motorola,mapphone-cpcap-regulator"
> > -    "motorola,xoom-cpcap-regulator"
> > -
> > -Required regulator properties:
> > -- "regulator-name"
> > -- "regulator-enable-ramp-delay"
> > -- "regulator-min-microvolt"
> > -- "regulator-max-microvolt"
> > -
> > -Optional regulator properties:
> > -- "regulator-boot-on"
> > -
> > -See Documentation/devicetree/bindings/regulator/regulator.txt
> > -for more details about the regulator properties.
> > -
> > -Example:
> > -
> > -cpcap_regulator: regulator {
> > -     compatible =3D "motorola,cpcap-regulator";
> > -
> > -     cpcap_regulators: regulators {
> > -             sw5: SW5 {
>
> Old example is missing the required regulator-names property.
>
> > -                     regulator-min-microvolt =3D <5050000>;
> > -                     regulator-max-microvolt =3D <5050000>;
> > -                     regulator-enable-ramp-delay =3D <50000>;
> > -                     regulator-boot-on;
> > -             };
> > -     };
> > -};
> > diff --git a/Documentation/devicetree/bindings/regulator/motorola,cpcap=
-regulator.yaml b/Documentation/devicetree/bindings/regulator/motorola,cpca=
p-regulator.yaml
> > new file mode 100644
> > index 000000000000..b73d32a86904
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/regulator/motorola,cpcap-regula=
tor.yaml
> > @@ -0,0 +1,51 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/regulator/motorola,cpcap-regulator.=
yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Motorola CPCAP PMIC regulators
> > +
> > +maintainers:
> > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > +
> > +description:
> > +  This module is part of the Motorola CPCAP MFD device. For more detai=
ls
> > +  see Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml. The
> > +  regulator controller is represented as a sub-node of the PMIC node
> > +  on the device tree.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - motorola,cpcap-regulator
> > +      - motorola,mapphone-cpcap-regulator
> > +      - motorola,mot-cpcap-regulator
> > +      - motorola,xoom-cpcap-regulator
> > +
> > +  regulators:
> > +    type: object
> > +
> > +    patternProperties:
> > +      "$[A-Z0-9]+^":
>
> Why not put the valid names here? Or does the node name not actually matt=
er?
> (in which case lower case could be allowed too.)
>
>          "^(SW1|SW2|...)$":
>
> And $,^ are swapped.
>

This is an interesting suggestion, maybe schema maintainers can
suggest how to approach this? Node name and case matters, list of
possible names is in the description.

> > +        $ref: /schemas/regulator/regulator.yaml#
> > +        type: object
> > +        description:
> > +          Valid regulator names are SW1, SW2, SW3, SW4, SW5, VCAM, VCS=
I,
> > +          VDAC, VDIG, VFUSE, VHVIO, VSDIO, VPLL, VRF1, VRF2, VRFREF, V=
WLAN1,
> > +          VWLAN2, VSIM, VSIMCARD, VVIB, VUSB, VAUDIO
> > +
>
> If these apply to the regulator-name property, it can be written instead =
as:
>

Regulator name does not matter, any name is acceptible.

>   properties:
>     regulator-name:
>       enum:
>         - SW1
>         - SW2
>         ...
>
>
> Not sure if it is strictly needed, but this would document the optional
> property:
>
>     regulator-boot-on: true
>

this is covered by common regulator schema, along with other possible
regulator properties

> > +        required:
> > +          - regulator-name
> > +          - regulator-enable-ramp-delay
> > +          - regulator-min-microvolt
> > +          - regulator-max-microvolt
> > +
> > +        unevaluatedProperties: false
> > +
> > +required:
> > +  - compatible
> > +
> > +additionalProperties: false
> > +
>
> Example should go here.
>
> > +...
>
