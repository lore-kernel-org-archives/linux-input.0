Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A1430C62A
	for <linux-input@vger.kernel.org>; Sat,  7 Feb 2026 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770456030; cv=pass; b=LW6Ce2ZXSxwW2+fB49az0Ws66TP5Lxua/keGT0jfVLuBYhnlkHSsuOsxPEhAyTmJXvCvRHoCgF2/dJkLxfXlnVeqrpi4H/wD9JFrDIJB1lbm88cLtCEgJIFKVd1bHMdFckg7h7hA6DZWn9lnrlYybdqdW1lxC6X4k3oXQFNogWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770456030; c=relaxed/simple;
	bh=cy4A7rvGum9/P7zJXPm/8IWM6o1KPiGpFPtqRktj2bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCsInZ7aDYThWCjHAEFxNE1yuLRgXv0g/ppb2t5c5AyLyqLBe8bn3BQbJwyR1OJGtDEFpUkooqrRFvAcMK1dMxJYBqbODUHppjWXwtsmEWHOEBuCuDCaiprkqQ0kULKhssEucZnIBhF0Q2u1+Z+QINRURuYJA7kpvBW3At+UNYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9mit3MZ; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9mit3MZ"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-435a11957f6so2286475f8f.0
        for <linux-input@vger.kernel.org>; Sat, 07 Feb 2026 01:20:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770456028; cv=none;
        d=google.com; s=arc-20240605;
        b=i9tuLpbe4/lmO6HU4DSQghrPEbZA1EHZcSEacRpISvZbD8Y8tUG+/jP2haA/ar9Y48
         BVIaKlJHcZ1/FRV89f4qym97PDpL3UdHDzlRnuGFGsHsBf6L/VYWhVqZOQ/Vb2vvUVKV
         dg206unTBgom7GoSqWdKP1N/Pl1cIRxTSwjnmGpenu4RviW52wK3VLc437dVqysfZJZO
         QAsCh0sODIBcUJbm4fSbOCL8/7wCnrgQVop2rYhLtYJZLyytmdCEgdbVuN/k1X0Oj7jf
         kHo6aVMm9qwcjLl1fVO8TlqillQnYBsYWS0lyXliniSBw+Gbm5VJphawNiva4VEW4eZB
         1vpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5IniXECrOUfTc9Ybm/eSbm1Y2H5SJTil/wMGC8X/eL8=;
        fh=NhWPiHOul+cMhac36YDzQ+DyZ8ARDP9wXqwKxgANTM0=;
        b=I10HKIfcr5q/un7wT4OfVnopHM+YkWCUhfYaLByINAbVzPTewSkuo3CNF5Xms6jGR1
         xyxBscFClgYOeXWjrvkvCBQ4dNS/9DaqUkR6sSmBbLTHQrFuM43pJgym0QpZ8YWiixXP
         GzYzHhOJGlov4eySyDZW8jBjyuUCrhrYi+Ogi6im9s9JSecqq0N5jKrkY0t3lx3nR920
         BaFqzPnM0rt2h4Y9r6ELIA2KVCs3BqRx+ZOR/s23Xx3gBP1bO5hfZQ+yYSXyMonjqg1j
         dGPlG0I06GWQsa/ozFVSrxV0nhO3Rh5gxe4f3g7+RLupv3uJ1/zUcZobT07QvWxZZIem
         TD0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770456028; x=1771060828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IniXECrOUfTc9Ybm/eSbm1Y2H5SJTil/wMGC8X/eL8=;
        b=M9mit3MZkAsemcuc0rx+tkFJRXH41lDCpolqqqmcfzoAziQ7iZjf2hNp14NjkNGi1e
         znDdtO0EsfcFMPJAJIWhvEVpNaCnsyuiR57grujXQ5NF9fqX20NFe1Ch8YFN5B9/sBCw
         gMrIDDWMJxD9JuwQwGVloWUymTCZ0LF2Mpvou8kyZM6G0u1KGsj2aXyZW9vqyoFj3v6s
         Rch6GLnAEiCjUIryml15QasvQ9USVuZrScLw5bmRGBMGB0O3eX8UR0w3M/kBrQi2d8vl
         zke/BRX+BwQuwOwBfdvH/auRKEAdwyn+LVR924ZdSMzCvWGTsRfBXcx72p0i1Co5zynU
         Hz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770456028; x=1771060828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5IniXECrOUfTc9Ybm/eSbm1Y2H5SJTil/wMGC8X/eL8=;
        b=U4s3Kk7ui1s1/QQUCkZ1wU09uaYdlu80sK40kJ3P3FgTW3XS+xUX1C47chOs+Nuon+
         UFjbvkqhG+t+PXClesej+KLdaDp2uLqgklhlr2bHMKBc3fErV/EB9E8M6ovdVNBcia2l
         hEO24lTZB//BrOwMx8L6syTN1Gin0Y1SKmftvnjVaawDuHhug/qmfYDsniUzcIiEhP6y
         BOJheBfmGQWYMI14PctKfu36OSJoHdtP0CLHv1d35ZlJmTHxbwjGTERmcy9p0RnIeP9m
         VYJdJZii21LfanBQiZStKCoaemvM7gax1oa6r1C/0GidEce9PYn1/yGaxhK6B7YHuwRS
         7kxw==
X-Forwarded-Encrypted: i=1; AJvYcCV4JE+lPSNilqrrCMY/tOygOgBaxp6bKMTPCMWeaPRsygh3Ue5J8L0MZ5K0f2MUgbXr7C61+AKX/IHi6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfCoWhSkJg6O9aAYusQL6vVdYhoh+w1ChCGX+R3aRBrL47xM9g
	yeEff8inC64/dSLLky/VcQ9WAP6f0N+alJ2Ob8T5agg0vcwbeu4TmAC6rioSV35LNeFy+soUUD4
	WDeQgb1ziR44jz32LJNBJNeMXyiAjUZY=
X-Gm-Gg: AZuq6aLF4LZfZ5w6P9JEQf0hvAtVszXG8iu/3ssxd8rM/xX0TnDCTZ4JkqHK4AUB8Ya
	uuq2JEOEZZNpD6hp4yJpPRdJtkzvPjo3W6nrWmiSFPDy/zp/hKllCE0xbSubyZ/TtzutJ0MMTbp
	As0sOZOx6pO8Ox6YbOd6WNtI8HbBilKnVmLtkEdGlAtJn0roxENngIhxHrwikXmGmzCObQCYFEB
	9acD6os2sQmQFI/QWmTSw6jj3vPvupDO9ogrCkblWh9lH2xdCpUZXalQS2QOKkr7LfgrvAg
X-Received: by 2002:a05:6000:420e:b0:435:d84f:4853 with SMTP id
 ffacd0b85a97d-4362938b24dmr7580007f8f.35.1770456028155; Sat, 07 Feb 2026
 01:20:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206172845.145407-1-clamor95@gmail.com> <20260206172845.145407-2-clamor95@gmail.com>
 <20260206230922.GA254792-robh@kernel.org>
In-Reply-To: <20260206230922.GA254792-robh@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 7 Feb 2026 11:20:15 +0200
X-Gm-Features: AZwV_QgS3-zSft7PiK4Y7AUbYQceyqA5VWBqSZgT2tr_s54EIIDfm21b-58zfy0
Message-ID: <CAPVz0n3EGCSLUX7jTLve0x0z4uW1yexViCwkSQLY2d_4r4qkjg@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] dt-bindings: regulator: cpcap-regulator: convert
 to DT schema
To: Rob Herring <robh@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Dixit Parmar <dixitparmar19@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D0=B1, 7 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 01:09 Rob H=
erring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Fri, Feb 06, 2026 at 07:28:35PM +0200, Svyatoslav Ryhel wrote:
> > Convert devicetree bindings for the Motorola CPCAP MFD regulator subnod=
e
> > from TXT to YAML format. Main functionality preserved.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../bindings/regulator/cpcap-regulator.txt    | 35 -------------
> >  .../regulator/motorola,cpcap-regulator.yaml   | 50 +++++++++++++++++++
> >  2 files changed, 50 insertions(+), 35 deletions(-)
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
> > index 000000000000..50bc57f06b51
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/regulator/motorola,cpcap-regula=
tor.yaml
> > @@ -0,0 +1,50 @@
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
> > +      - motorola,xoom-cpcap-regulator
> > +
> > +  regulators:
> > +    type: object
> > +
> > +    patternProperties:
> > +      "$[A-Z0-9]+^":
>
> I thought it was said on the last version to list the names. Considering
> you already have them below, better to put them in schema than prose.
> And pretty much all regulator bindings define the names.
>

What exactly do you propose? All those names will not fit into a
single unbreakable line (more than 125 columns in length btw). Patch
checker will complain about this. Duplicate pattern properties for
every few names? Please be a bit more specific. Thank you!

> > +        $ref: /schemas/regulator/regulator.yaml#
> > +        type: object
> > +        description:
> > +          Valid regulator names are SW1, SW2, SW3, SW4, SW5, VCAM, VCS=
I,
> > +          VDAC, VDIG, VFUSE, VHVIO, VSDIO, VPLL, VRF1, VRF2, VRFREF, V=
WLAN1,
> > +          VWLAN2, VSIM, VSIMCARD, VVIB, VUSB, VAUDIO
> > +
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
> > +...
> > --
> > 2.51.0
> >
