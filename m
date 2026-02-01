Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F022D2491
	for <linux-input@vger.kernel.org>; Sun,  1 Feb 2026 07:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769929642; cv=pass; b=Tympt9S3uyzeCs3xqvswk5DLDMezS/5fKwea/jTNiCbIKbTDLxhLtmZszclLpt1ajLSRqVhWVyB3ICXBFNrze6l/sUFdENMFyLk3ZmAFlO24hTd7uqM/pM+LTGNRsQtF3F04Wt7Fi7Aum3pbVfIAm20Jj43PYVwzXQRAa5jDIIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769929642; c=relaxed/simple;
	bh=m43UbkmbLBc3R/MOJSbzoCwEFQ3lxNZqdfln+hRLhHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X9sXreIwsqCVSkzQ4oLR4JudSRiWaj3ZifwxzY6YE3DzguVFqSa7Bv+TSUbGJVkkq3N/6rw9GB6HO6SFZ5l3dMBR0vu9LZUnP5NZbgJajJVheibdzB27qtw3wS3HLj9DBDN3BdoDGPMZ8UESoMYzeTlRtK1BSYJ1gNlqtNn4b/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIY8ZJP3; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIY8ZJP3"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso28676785e9.0
        for <linux-input@vger.kernel.org>; Sat, 31 Jan 2026 23:07:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769929639; cv=none;
        d=google.com; s=arc-20240605;
        b=S30ijjje+CO33eVxi8ZgLekL7lX5zAduPXVnsdE0ifxqvv9XT865TsydsYTb4Qq7Ex
         j9FrP8xikTZBtD9VgkDYTZqAK3u9ApiMy2H1tBTXO9TlRntCvicHMa68AdIqdS+/w1Iw
         eH3TwY3ByHAcN1ugbSJFUO6uj9Rcs9hC1AyFs1hZpF0GR/5wK+hBvEGgRx6gokRDYMhb
         xRjbhyn1lpceWICTyjGJXnO1WG8IT09CNjwPGg4Toudz6peXiYQp0SzZ40oVy6+4R1YN
         b42Pwej8xOLJefhWI5iswLvCN0bSFue3gMqj8bi9Mg43DZGZZUCCz0/Lp6ldSVuFToxS
         ekVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VgA1XtNopgDhPd28c1FlWpyjNQUNZlwtx4L9F82W03M=;
        fh=knpNGDTRl2hEUlM2Rzjc73Ts+GEHvM40ER//JgPGC4Q=;
        b=CPYwAb27/ltN3BBXfGxiGcUPpBfiE3sW9pozJXakcwYdTpe655BrHO/e9WlR0sdAls
         +BXfCyuIV99iOUSvu/i4jNZvbLtw8xUaDu+7JNQgaQgvBWyP9zCnZ3e78Dnx8y53LrR6
         QwP4/H2DunNFCLtHOuDqlAEZqfzgZnzWBwNG1WnfaWuyOt2NGR6mspFAcr8LFCHyGXPm
         s/w716yXyYSNvXBFWVDd9H75pzXF/K2cJP8jOejc7rYTTIF4H5/kP/9S+YdtcQfoEOKC
         LNe08wZhA9se3do6TcG+17F9Tua/IcO6ocb7rTvNWW3gEKCMiGFlb3UU1atI4EMcDijK
         owZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769929639; x=1770534439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgA1XtNopgDhPd28c1FlWpyjNQUNZlwtx4L9F82W03M=;
        b=jIY8ZJP3nRcpBxAvG6e4g5y/0jzG2yQja7zNQQwx0ztOh3n4P49jiYL9GbTx11wHjD
         hbS0CAjHHYArQfTGirQGaM1u6uNbwpcv7QK0M/Onoq7aQBcS01uHg46DLIVPiRd5oY8u
         1q1UPrgCB9TwrMJ12g73KCeA0d57kCCi6wVONFCAnkHGzYYWF11m8BogQDZGrj4Udn5P
         o9m8EY3WyadvMbmsRKnRC0X6VO72Es9JRQNIxim/MRb/3v91ZTssIO3WD2igXDg6sWP8
         sXGtjy+Oyx7SfzY+Q4pCHPjCqdHkmxBsJndOJQvTagzfa2DQwyBGxnr0eNVC/4UHXSJB
         s+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769929639; x=1770534439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VgA1XtNopgDhPd28c1FlWpyjNQUNZlwtx4L9F82W03M=;
        b=B0EkvX+TDsbR1JsUJ7AoRJ4vcYLF+CAaUA95SvULtwAfEQ4POIuL8c5GE++nuae0sX
         JXZK+dMcc+bhyNjywZ1seuMfrkKZ/kXSmjgWXH3xSvAbVkc09JEonulZCy+qDTPmpCYp
         BRi8otwGKAZ2uWJN6g1y3a0pFu6xorXQJXVYpHGZRItr9gRlX0Gc81hUAf46GT36P4cK
         8W79+LIZmH8qMDrnfZBEYYA0aYGBu4VWvc1XMxIFMEHynAI+EYhwpBsj4/V4/mKpJ3pp
         31UTLTgwEMjpVehP0TrpoHKBkqYLgDr9I2hn/VWVh3Kr1al6MnLtYGVNEBbXFIyyqNjf
         3rnw==
X-Forwarded-Encrypted: i=1; AJvYcCVS2PlRX2n7ld9bVI2VyR9f3WBMWY4PjfRCRelyaz5D4ZZr07inY6NcIfj1FQ2T70PjojyJsO0yDImBnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwaqGAeSUkNi60kdP6LxZaURklf9A8zDFZ5O5LT9Ds2exySap7d
	pFpWqnsfxKm/Z+97UldiNaagiOVa6htD3lClrIfYjKVOlqP3b/Q4eoEvGL6nRZNDedqY7AT0+CL
	WbnpGIk/z1f0vuTbjX6A1/XrVUJ7embE=
X-Gm-Gg: AZuq6aKw091Lh+wwlqPibk7w6XUBNACSmNvcZaoAEsNSelc+kiJ7p9J0weZlM437nmr
	1SU/OPc/FO4cTxsQ+OwHPuyX9FXRktARQ05rqe/QVRV1fMFIXWhy737ItiX+llX2O/2vj8xs3KD
	LUG/0SB/ya7XbhW3UbHq4rn5pAiIYfnQOEu4ggq+VnlWNmQKQJT5JBlawclXoh943TaO57SOuX2
	MhrA4Ob3yzdJtizgDoyRzIGivjP5VsLoY4EkWhhCXOCavfFRG3Jc3ZDiSA61b8JxFZHhTAC
X-Received: by 2002:a05:600c:6092:b0:47a:7fdd:2906 with SMTP id
 5b1f17b1804b1-482db45441fmr96523965e9.12.1769929638889; Sat, 31 Jan 2026
 23:07:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125134302.45958-1-clamor95@gmail.com> <20260125134302.45958-8-clamor95@gmail.com>
 <8bd89524-dfc3-43b0-b0f2-cdb1cd51e1ac@baylibre.com>
In-Reply-To: <8bd89524-dfc3-43b0-b0f2-cdb1cd51e1ac@baylibre.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 1 Feb 2026 09:07:07 +0200
X-Gm-Features: AZwV_QgiEH1CnR4Y5eJqYT3-6LdT1ghmK5ngGD3UdwSwjKt6ss6U4z-A2BxtD6Q
Message-ID: <CAPVz0n25ukBJ6=hmmR9nd4MBoPkHaHQ+ZHMXYxghYZdkB28_sg@mail.gmail.com>
Subject: Re: [PATCH v1 07/10] dt-bindings: input: cpcap-pwrbutton: convert to schema
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

=D1=81=D0=B1, 31 =D1=81=D1=96=D1=87. 2026=E2=80=AF=D1=80. =D0=BE 22:02 Davi=
d Lechner <dlechner@baylibre.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 1/25/26 7:42 AM, Svyatoslav Ryhel wrote:
> > Convert power button devicetree bindings for the Motorola CPCAP MFD fro=
m
> > TXT to YAML format. This patch does not change any functionality; the
> > bindings remain the same.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../bindings/input/cpcap-pwrbutton.txt        | 20 ------------
> >  .../input/motorola,cpcap-pwrbutton.yaml       | 32 +++++++++++++++++++
> >  2 files changed, 32 insertions(+), 20 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/input/cpcap-pwrbu=
tton.txt
> >  create mode 100644 Documentation/devicetree/bindings/input/motorola,cp=
cap-pwrbutton.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/input/cpcap-pwrbutton.tx=
t b/Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
> > deleted file mode 100644
> > index 0dd0076daf71..000000000000
> > --- a/Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
> > +++ /dev/null
> > @@ -1,20 +0,0 @@
> > -Motorola CPCAP on key
> > -
> > -This module is part of the CPCAP. For more details about the whole
> > -chip see Documentation/devicetree/bindings/mfd/motorola-cpcap.txt.
> > -
> > -This module provides a simple power button event via an Interrupt.
> > -
> > -Required properties:
> > -- compatible: should be one of the following
> > -   - "motorola,cpcap-pwrbutton"
> > -- interrupts: irq specifier for CPCAP's ON IRQ
> > -
> > -Example:
> > -
> > -&cpcap {
> > -     cpcap_pwrbutton: pwrbutton {
> > -             compatible =3D "motorola,cpcap-pwrbutton";
> > -             interrupts =3D <23 IRQ_TYPE_NONE>;
> > -     };
> > -};
> > diff --git a/Documentation/devicetree/bindings/input/motorola,cpcap-pwr=
button.yaml b/Documentation/devicetree/bindings/input/motorola,cpcap-pwrbut=
ton.yaml
> > new file mode 100644
> > index 000000000000..643f6b2b1f13
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.=
yaml
> > @@ -0,0 +1,32 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/input/motorola,cpcap-pwrbutton.yaml=
#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Motorola CPCAP PMIC power key
> > +
> > +maintainers:
> > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > +
> > +description:
> > +  This module is part of the Motorola CPCAP MFD device. For more detai=
ls
> > +  see Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml. The
> > +  power key is represented as a sub-node of the PMIC node on the devic=
e
> > +  tree.
> > +
> > +properties:
> > +  compatible:
> > +    const: motorola,cpcap-pwrbutton
> > +
> > +  interrupts:
> > +    minItems: 1
>
> Should this be maxItems: 1?
>
> > +    description: CPCAP's ON interrupt
>
> Or I suppose:
>
>   items:
>     - description: ...
>

Both options are perfectly fine for me, and I lean towards using
"items: desc" but I would like to hear what schema maintainers would
say, which layout is preferred in this case.

>
> > +
> > +required:
> > +  - compatible
> > +  - interrupts
> > +
> > +additionalProperties: false
> > +
>
> example: ...
>
> > +...
>
