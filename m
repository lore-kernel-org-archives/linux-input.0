Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97C0331A65
	for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771327439; cv=none; b=Sl99QO3OwneklUTFrfYfo6vXZks7uqnJZQv+C2nG0ktA3dYSZf8FKUSu+k0T14a08CqhRhz3OSA1nZ/JFJb0w41CQfmQHGPxCgrzW4kYhOeY+WlOT85vAZ/JJtifElYfMApHEqlQJA3bdmtZalvyORE+f6PlseDKQChLEh6pp0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771327439; c=relaxed/simple;
	bh=bvMCKzjSdNRLDXP2YG0zNiGofwkPC1h2YSOCCwfB2W0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=d0oXY5ropcAZuC1NyI8dXpfWgtR+RhbPDMLI8c5o+KhBDO9s6y+pF7Gt5o6O8JBrfq1+1BDhiq/B2IPUav1aEw5IiKA8w9wslTJMh4jcOkCF4oIb5A0YOByZEsiTigztc6Sp+wzryfhDY7D89YMrXvQliUi6mUkrcRTIq3EqLsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrV9oxPB; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrV9oxPB"
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-65baa72399fso5521146a12.0
        for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 03:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771327434; x=1771932234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XZQyHeREapolcjQia1InNcB2r3IZhhNtVTrC1gmVA/o=;
        b=VrV9oxPB5Mf23su6A0z6yOQG9T36cbFt5MWUzR8j6+VOep8t7UIyLzF8Gf15QcO/kn
         WXjJlNV+sbDMobLLr7o6VTBGp0HKz/RweFMH+Ad+b2h08p+XLaoTYzzr8meCOaNaVh/o
         V2K24zGVwRcbFSuqz4DEY4OWuQx9jxM98ArmltmG1+Dw86HLC3f5xbrJoIkli3PoYe/f
         7aXUTmEke2uH6uU6BuN7h8298I5PAHw7vXU0TNZlEndKoe+rANp02aO8NvjTqVE/bXk2
         AIkQAbn+Gx2J1rIyLHDZd5lgabzRkFC6+4YfmUUSBVKFrE3R6pdkv3cau7UejJbQ166x
         5J4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771327434; x=1771932234;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZQyHeREapolcjQia1InNcB2r3IZhhNtVTrC1gmVA/o=;
        b=qwJnShoDCAiCMgcGhscC4maFsLKHZyEF8RYBrIvdjmpEf9YFdBiJSos6HN7mutaTpV
         tE3aqcS55m93WxfV9YehatUlP/SJYKntFEsspGKJVv6h09eZkPYz/axk7fkd4sKf7A+8
         wH9CxcXxyd51ug92pz/S1CaD99xJzlm51PBPd8HCj+k6jJJxG0YInt8QwwF4BBr1Cp4y
         yMFs3wyMPxCirIf1lPEU3y9OYcyERsTx6fH2W9UGhQ2bsQGtt+kVav7NDLPw5i/sBTmy
         HOdan+J0ZrVU6v95sr0ZdSdVnxI97m6JBKLEmxg7G91hLqlI+4huWaF6N6ERCfPT6V8h
         cSAg==
X-Forwarded-Encrypted: i=1; AJvYcCXUfKBB0glfKpTKYTwaUaFQy+ci0r++JS0xQ6B4SQgxq4REqC2N5n+rs7HZv6L3lJMTTAwOidKJmu6fHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEKlLZKwFr2SLC1CdZ7EfpySn5pqRIJZPB8xjKnN+g1t11CUwa
	Li6yPg2E5huX/lftR7NltvPW6+ZiOjKPsSEEqz2a9ZS6DR10qsLOWc9g8SlUFFWO
X-Gm-Gg: AZuq6aJsptujaGtrpmSLdOqUxIrx/9Y0dok64TNXsGW7kggaKFA4UJ3MunoHicIUPds
	bQSO8iRtb6Vsd49jFHn084nBk81WFTZYii4pw8XZtSXp4MVphSUefy2zr7EjUvoTDsbURJrJGYf
	vYYQQjY9494gKgPoIboRwNr/oSpoliJ5Kp/35RdMzYHPWcsuXxPVHYRUwAhfcvtu2ZGwlxpa7fR
	//8s2ACSK5fCT/NXFj+UvhLbXHJr+w9aawIYEKxaGB4C/gvHWbZRvTapoZwqBw4FN9pdMfbUc7S
	UI93N0qvmGZCzcvAFaUK2kIoQt6xmP3yYbs26uEeFxfJ2mTGvQafBaViskSLqOjQrFGSlCE52v3
	GD8Dciaae/i9WLejNrHMjgMqJikN4iPUW8Iz0SUY7k524X6Ztp/Bu4QNCSRI4uJ6aDpFIvEMJ92
	33+eZi9nYjxRViabXb2Rad23cxAgP1p34=
X-Received: by 2002:a05:6402:254a:b0:659:4d41:9f4e with SMTP id 4fb4d7f45d1cf-65bc785e248mr4815234a12.11.1771327434040;
        Tue, 17 Feb 2026 03:23:54 -0800 (PST)
Received: from ehlo.thunderbird.net ([178.137.63.129])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65bad29d471sm2404863a12.9.2026.02.17.03.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 03:23:53 -0800 (PST)
Date: Tue, 17 Feb 2026 13:23:06 +0200
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Conor Dooley <conor@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Ion Agorria <ion@agorria.com>,
 =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_1/7=5D_dt-bindings=3A_embedded?=
 =?US-ASCII?Q?-controller=3A_document_ASUS_Transformer_EC?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20260217-vowed-botany-b1c47c7e40b8@spud>
References: <20260214180959.30714-1-clamor95@gmail.com> <20260214180959.30714-2-clamor95@gmail.com> <20260216-sprung-scallop-de7b64bf528c@spud> <CAPVz0n06+uLCSfY_bYS9v7KJ-hXotye7ej-rze6-Q8_JAF7XVA@mail.gmail.com> <20260216-plunder-defense-de11cf56dd3d@spud> <CAPVz0n0-LbTUZBCaO=oN3PpPLpwAqzNo29r687pKY8NbEE9giA@mail.gmail.com> <20260217-vowed-botany-b1c47c7e40b8@spud>
Message-ID: <55C30023-4175-48F2-BCB0-12EC23C48F01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



17 =D0=BB=D1=8E=D1=82=D0=BE=D0=B3=D0=BE 2026=E2=80=AF=D1=80=2E 13:05:09 GM=
T+02:00, Conor Dooley <conor@kernel=2Eorg> =D0=BF=D0=B8=D1=88=D0=B5:
>On Mon, Feb 16, 2026 at 09:14:40PM +0200, Svyatoslav Ryhel wrote:
>> =D0=BF=D0=BD, 16 =D0=BB=D1=8E=D1=82=2E 2026=E2=80=AF=D1=80=2E =D0=BE 20=
:50 Conor Dooley <conor@kernel=2Eorg> =D0=BF=D0=B8=D1=88=D0=B5:
>> >
>> > On Mon, Feb 16, 2026 at 08:22:38PM +0200, Svyatoslav Ryhel wrote:
>> > > =D0=BF=D0=BD, 16 =D0=BB=D1=8E=D1=82=2E 2026=E2=80=AF=D1=80=2E =D0=
=BE 20:04 Conor Dooley <conor@kernel=2Eorg> =D0=BF=D0=B8=D1=88=D0=B5:
>> > > >
>> > > > On Sat, Feb 14, 2026 at 08:09:53PM +0200, Svyatoslav Ryhel wrote:
>> > > > > Document embedded controller used in ASUS Transformer device se=
ries=2E
>> > > > >
>> > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>> > > > > ---
>> > > > >  =2E=2E=2E/asus,transformer-ec=2Eyaml                  | 98 +++=
++++++++++++++++
>> > > > >  1 file changed, 98 insertions(+)
>> > > > >  create mode 100644 Documentation/devicetree/bindings/embedded-=
controller/asus,transformer-ec=2Eyaml
>> > > > >
>> > > > > diff --git a/Documentation/devicetree/bindings/embedded-control=
ler/asus,transformer-ec=2Eyaml b/Documentation/devicetree/bindings/embedded=
-controller/asus,transformer-ec=2Eyaml
>> > > > > new file mode 100644
>> > > > > index 000000000000=2E=2E670c4c2d339d
>> > > > > --- /dev/null
>> > > > > +++ b/Documentation/devicetree/bindings/embedded-controller/asu=
s,transformer-ec=2Eyaml
>> > > > > @@ -0,0 +1,98 @@
>> > > > > +# SPDX-License-Identifier: (GPL-2=2E0 OR BSD-2-Clause)
>> > > > > +%YAML 1=2E2
>> > > > > +---
>> > > > > +$id: http://devicetree=2Eorg/schemas/embedded-controller/asus,=
transformer-ec=2Eyaml#
>> > > > > +$schema: http://devicetree=2Eorg/meta-schemas/core=2Eyaml#
>> > > > > +
>> > > > > +title: ASUS Transformer's Embedded Controller
>> > > > > +
>> > > > > +description:
>> > > > > +  Several Nuvoton based Embedded Controllers attached to an I2=
C bus,
>> > > > > +  running a custom ASUS firmware, specific to the ASUS Transfo=
rmer
>> > > > > +  device series=2E
>> > > > > +
>> > > > > +maintainers:
>> > > > > +  - Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>> > > > > +
>> > > > > +allOf:
>> > > > > +  - $ref: /schemas/power/supply/power-supply=2Eyaml
>> > > > > +
>> > > > > +properties:
>> > > > > +  compatible:
>> > > > > +    oneOf:
>> > > > > +      - enum:
>> > > > > +          - asus,p1801-t-ec-pad
>> > > > > +          - asus,sl101-ec-dock
>> > > > > +          - asus,tf600t-ec-pad
>> > > > > +          - asus,tf701t-ec-pad
>> > > > > +
>> > > > > +      - items:
>> > > > > +          - enum:
>> > > > > +              - asus,tf101-ec-dock
>> > > > > +              - asus,tf101g-ec-dock
>> > > > > +              - asus,tf201-ec-dock
>> > > > > +              - asus,tf300t-ec-dock
>> > > > > +              - asus,tf300tg-ec-dock
>> > > > > +              - asus,tf300tl-ec-dock
>> > > > > +              - asus,tf700t-ec-dock
>> > > > > +          - const: asus,transformer-ec-dock
>> > > > > +
>> > > > > +      - items:
>> > > > > +          - enum:
>> > > > > +              - asus,tf201-ec-pad
>> > > > > +              - asus,tf300t-ec-pad
>> > > > > +              - asus,tf300tg-ec-pad
>> > > > > +              - asus,tf300tl-ec-pad
>> > > > > +              - asus,tf700t-ec-pad
>> > > > > +          - const: asus,transformer-ec-pad
>
>> > > > Also, why are some of the compatibles permitted standalone? That =
should
>> > > > be mentioned in your commit message too=2E Also, other than the s=
l101, the
>> > > > standalone ones seem to have the same match data in the mfd drive=
r=2E Why
>> > > > are fallbacks not made use of there?
>> > > >
>> > >
>> > > Because standalone compatibles describe a unique hw configuration
>> > > which cannot be grouped into something meaningful=2E asus,p1801-t-e=
c-pad
>> > > is for EC of Tegra30/Intel based p1801-t AIO, asus,sl101-ec-dock is
>> > > for EC of Tegra20 slider tablet, asus,tf600t-ec-pad is for altered =
EC
>> > > in Win8 Tegra30 tablet, asus,tf701t-ec-pad is for Tegra114 tablet=
=2E
>> > > Different generations, different form-factors=2E
>> >
>> > I don't see any reasons here that eliminate fallback compatibles=2E
>> > +       { =2Ecompatible =3D "asus,p1801-t-ec-pad", =2Edata =3D &asus_=
ec_pad_charger_data },
>> > +       { =2Ecompatible =3D "asus,tf600t-ec-pad", =2Edata =3D &asus_e=
c_pad_charger_data },
>> > +       { =2Ecompatible =3D "asus,tf701t-ec-pad", =2Edata =3D &asus_e=
c_pad_charger_data },
>> > +       { }
>> > Three of them use the same match data, so you need to explain why you=
've
>> > made these three standalone when all the others that share a programm=
ing
>> > model got a generic fallback=2E Fallback usage is based on programmin=
g
>> > model, not based on whether the devices are a physically different, s=
o
>> > your explanation must reflect this=2E
>> >
>> > > > Since this transformer series seems to have multiple programming =
models
>> > > > for "ec-pad" devices, it calls into question your use of the gene=
ric
>> > > > fallback compatibles is appropriate and makes it seem like you sh=
ould be
>> > > > using device compatibles as a fallback=2E
>> > >
>> > > That is redundant=2E
>> >
>> > I don't understand how that is a response to what I said=2E
>> >
>>=20
>> in other words you propose this:
>>=20
>> properties:
>>   compatible:
>>     oneOf:
>>       - items:
>>           - enum:
>>               - asus,sl101-ec-dock
>>               - asus,tf101-ec-dock
>>               - asus,tf101g-ec-dock
>>               - asus,tf201-ec-dock
>>               - asus,tf300t-ec-dock
>>               - asus,tf300tg-ec-dock
>>               - asus,tf300tl-ec-dock
>>               - asus,tf700t-ec-dock
>>           - const: asus,transformer-ec-dock
>>=20
>>       - items:
>>           - enum:
>>               - asus,p1801-t-ec-pad
>>               - asus,tf201-ec-pad
>>               - asus,tf300t-ec-pad
>>               - asus,tf300tg-ec-pad
>>               - asus,tf300tl-ec-pad
>>               - asus,tf700t-ec-pad
>>               - asus,tf600t-ec-pad
>>               - asus,tf701t-ec-pad
>>           - const: asus,transformer-ec-pad
>>=20
>> And in the driver add match to every single entry of enums?
>
>No, I was talking about removing the generic compatibles entirely, since
>they are not suitably generic to cover all devices at the point of
>addition=2E So like:
>

Actually, they all can be grouped under asus,transformer-ec fallback if th=
at is needed, both pad and dock EC have the same core functions just differ=
ent set of cells=2E And then in the driver each compatible will get a dedic=
ated matching data=2E Will this work?

properties:
  compatible:
      - items:
          - enum:
              - asus,p1801-t-ec-pad
              - asus,sl101-ec-dock
              - asus,tf101-ec-dock
              - asus,tf101g-ec-dock
              - asus,tf201-ec-dock
              - asus,tf201-ec-pad
              - asus,tf300t-ec-dock
              - asus,tf300t-ec-pad
              - asus,tf300tg-ec-dock
              - asus,tf300tg-ec-pad
              - asus,tf300tl-ec-dock
              - asus,tf300tl-ec-pad
              - asus,tf700t-ec-dock
              - asus,tf700t-ec-pad
              - asus,tf600t-ec-pad
              - asus,tf701t-ec-pad
          - const: asus,transformer-ec

And them schema name will match the genetic compatible=2E

>items:
>  - enum:
>      - asus,tf101-ec-dock
>      - asus,tf101g-ec-dock
>      - asus,tf201-ec-dock
>      - asus,tf300t-ec-dock
>      - asus,tf300tg-ec-dock
>      - asus,tf300tl-ec-dock
>  - const: asus,tf700t-ec-dock
>
>and
>
>items:
>  - enum:
>      - asus,p1801-t-ec-pad
>      - asus,tf600t-ec-pad
>  - const: asus,tf701t-ec-pad
>
>I dunno about these particular devices, but if there's already two
>programming models for these devices, what's to stop there being more
>added if/when a new generation of produces arrives?

There will be no new devices with this EC, last one was around 2013=2E
