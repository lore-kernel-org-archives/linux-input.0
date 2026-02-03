Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32492FF65B
	for <linux-input@vger.kernel.org>; Tue,  3 Feb 2026 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770130997; cv=pass; b=EBpHtJscixCevvs56KX+c2qGTBUVNbQHIugM715AA+NIR0dM1VfR5/o0IS8krJJGDuuZ7en7egI2hHk5JTSw76y3pTXuCvvxRisyFJlZUHH7X8X+0qGQHWP9SwEaaulsQeo5XQUW+wNTFp0tcPk+hQEJ8NSM6rNNOYGFuA92Jc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770130997; c=relaxed/simple;
	bh=s6TMw/t8TwmZ9hTFL0cXJhHoIVq+ti2CBVZ7v8bG9vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2gr3aLhj0hZe3mlvWl81Bnp7b6TK77nYppeQ66b8VxJTkzq75gcHm21x2j2UHbdicXjRyps2cUjHwB0/X7d4nnHlPe+4aRt42YvYV0sY+kSCjIGFDZ9+bnXSpZMgbNIWXbCO2cSfyaxP4jm7FGjb88gt+XVmwGk/gBabEQMA3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L26QmPr3; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L26QmPr3"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so46474925e9.3
        for <linux-input@vger.kernel.org>; Tue, 03 Feb 2026 07:03:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770130994; cv=none;
        d=google.com; s=arc-20240605;
        b=DyacYwtt/VcxQWGGWP65yXP231FERB3DiYjgHZCoCA00vnKhTNIiqSWnYlBC7wpkR6
         wvvv/V/Y/HCf7KXGh93eXiDsXcMAwwQ1rrRjA9H2vJF3nbOCT1L5pM5fJe9ONKyZgIUd
         FZjZz3XSsuQJ0z567Fh8cJOtsXBl7P8JeHYGGtEq5LAvSKH7XwwggXPCn4fNViJJXe25
         g7EDKW756FYG0Qeb/Zl7RNwsfFWpcn0QmjCN1M8Pq+VJ1ABREPROTRrkV4StPf+4RsbJ
         sA6oSfXsaj7hO3feqUbpJ3oMfM38LMG+8z5a2O0mxdEBcfTdHo8ciL1ljzXZbdRgsLrZ
         xf5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VGIYTuEUulJeU0/OSREhm3zUfZwfDji51fjUfoXxiEM=;
        fh=D1LqzMUVWjkaB+ofvAYiZkIRBsbcAy1Y9Tp/k1WxEvE=;
        b=O5YpoiWYae+18xLstLDvMW2ZG+PKHdUn4Q0EbrBQLOT52zfXgRzzvKMnrsjjhN25p0
         DvuC3VSvApyD0rOzVeL+5BM3+JT99R8SQAmPevwt4T+KSad1k6AhUq9sT1k0ElfLYmJD
         HmFNvwfEghP1hk/eXWLqd1dCMEgGu4UWlEsdEZyTf6P1Cb/tAJ/SfUK7oFbfglNpDn76
         MlDwChk6r9tckwyUcQHc7mRlsPJwpV8RRNbtIwQEaN0pamvrkVlxu+2ZUJYeJBplYUeX
         QzslQupNrtcB3CgeIaN10EuhK+ybGfI5uMf0vYdx6gB2WJJHy9eLC5SgT0EBqKCjAjr1
         gTxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770130994; x=1770735794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGIYTuEUulJeU0/OSREhm3zUfZwfDji51fjUfoXxiEM=;
        b=L26QmPr3F2q4pZ10zq18C2Zy/c+5gclgQWPEw3YiAjWIFfHdVu3mMc5tlVwMrA+DCr
         V3duTPPiPCJv5jbIddMXKjwyc+0ThfFfnNetQMq3i0vvskDtUB61AEt2ejE6wlxhyrHT
         I+WCwkHgRlH8hgxJdfA58sc36mH5NS816iQv8CwxHJK4xuxv580QrVoj53btHyu9kIlJ
         u5aC2S/18T3MVNWgwobOJvegNRouijG1I9cJ6d++XXjSw2Ubqt/Vmr3s1a8KyYRcZqpV
         /hyYFwwAqSwFFSLq5slW8ZmJ5U0vKqACnguiOTZe2w//Hws/1DXUaJGStvWdDuFx4KTw
         ieJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770130994; x=1770735794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VGIYTuEUulJeU0/OSREhm3zUfZwfDji51fjUfoXxiEM=;
        b=EkxEA4wt3mmYyuFN/6VADM1mxfoQYom5eVEbcryO7QmmsF4MXyojgartZh+0Phvoze
         oRePU5ehCauGszHEwUP0i4sQxljzJWThk5IBEg46FfWWk8W8/4yovSVov33KMKaBXOOg
         yprgVDFI0XC8KgkJwATaLLyW7zOb+aZKieysbypKwwfsjxS2/S+ecdb8Yis2mILLupTY
         8fId4BQ/cyRUfgmBHZZhmFQ4uvZuC7cJhWx997qKPZRejSBhFKmB5jXWd5XeVY61JZSy
         Pb8IzFhg8HWV+annqTLu9EzlhIp+jWMiIc6LY8CI4J9Oqlat4w7DzIbE30iMlA0cYGMK
         eKeg==
X-Forwarded-Encrypted: i=1; AJvYcCUxCejWSv+dOHmvqhzcsgJa2lNsqJvICqJWGaHoMo4brrlVAxAQIYsfmONGgMllJyve8YClj3ntZ+90tg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+YQ2JlpHhod3PdR25EMLQWRxxL2MB7d6ioumZPQrH5IC7qk+q
	JPVVwIceQZTX/8SxDgsWm0bGyny4Xy2nwpTeMX/bQ3gz1LCMzO/ohKtNTfLOle0oHUNcFv4RgMF
	V/963/dV30k57F45DNvUVtCPTVX0VZZ0=
X-Gm-Gg: AZuq6aKunPLUyD8WYIJPm1tCv3Yb41CoKvZMpsxRzBxGWeq7HBqt70rSkUWGi7pChtc
	sw+ufx2KwehYZp81FUrd2VeFVVHIa24TaBMSyKwZpTUPtp4YC4VSocxvDSrLyWOxBQyZxUv8//h
	UkwOt4+Zp7fOvAZj+HVZGqWd03cET1Que/kAexwdlDLiSr6ReY8SPyEJayBkEsWSTP7FPdqa+iw
	mPdTXBukao2rXIIweR5zxHoopbhhm3k/gLEPXTNhZYD3yo+cCQQ3NOYkCPUKWyuHapQfs8yU4HS
	dKXH0Gs=
X-Received: by 2002:a05:6000:2892:b0:432:8504:b8a9 with SMTP id
 ffacd0b85a97d-435f3ab4f69mr24923375f8f.62.1770130993838; Tue, 03 Feb 2026
 07:03:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125134302.45958-1-clamor95@gmail.com> <20260125134302.45958-8-clamor95@gmail.com>
 <8bd89524-dfc3-43b0-b0f2-cdb1cd51e1ac@baylibre.com> <CAPVz0n25ukBJ6=hmmR9nd4MBoPkHaHQ+ZHMXYxghYZdkB28_sg@mail.gmail.com>
 <20260203150136.GA2294714-robh@kernel.org>
In-Reply-To: <20260203150136.GA2294714-robh@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 3 Feb 2026 17:03:02 +0200
X-Gm-Features: AZwV_QhOrUmL6-YXtCaWdQ-PpGGpcikpM7Wb1yHtElG5VPVf7VhpylKKUQiQ_9M
Message-ID: <CAPVz0n0rG5XDUi-sr75rw_++kBbfyAfpMH0DoONZPmUKHfLfCg@mail.gmail.com>
Subject: Re: [PATCH v1 07/10] dt-bindings: input: cpcap-pwrbutton: convert to schema
To: Rob Herring <robh@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Dixit Parmar <dixitparmar19@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 3 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 17:01 Rob H=
erring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, Feb 01, 2026 at 09:07:07AM +0200, Svyatoslav Ryhel wrote:
> > =D1=81=D0=B1, 31 =D1=81=D1=96=D1=87. 2026=E2=80=AF=D1=80. =D0=BE 22:02 =
David Lechner <dlechner@baylibre.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On 1/25/26 7:42 AM, Svyatoslav Ryhel wrote:
> > > > Convert power button devicetree bindings for the Motorola CPCAP MFD=
 from
> > > > TXT to YAML format. This patch does not change any functionality; t=
he
> > > > bindings remain the same.
> > > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  .../bindings/input/cpcap-pwrbutton.txt        | 20 ------------
> > > >  .../input/motorola,cpcap-pwrbutton.yaml       | 32 +++++++++++++++=
++++
> > > >  2 files changed, 32 insertions(+), 20 deletions(-)
> > > >  delete mode 100644 Documentation/devicetree/bindings/input/cpcap-p=
wrbutton.txt
> > > >  create mode 100644 Documentation/devicetree/bindings/input/motorol=
a,cpcap-pwrbutton.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/input/cpcap-pwrbutto=
n.txt b/Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
> > > > deleted file mode 100644
> > > > index 0dd0076daf71..000000000000
> > > > --- a/Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
> > > > +++ /dev/null
> > > > @@ -1,20 +0,0 @@
> > > > -Motorola CPCAP on key
> > > > -
> > > > -This module is part of the CPCAP. For more details about the whole
> > > > -chip see Documentation/devicetree/bindings/mfd/motorola-cpcap.txt.
> > > > -
> > > > -This module provides a simple power button event via an Interrupt.
> > > > -
> > > > -Required properties:
> > > > -- compatible: should be one of the following
> > > > -   - "motorola,cpcap-pwrbutton"
> > > > -- interrupts: irq specifier for CPCAP's ON IRQ
> > > > -
> > > > -Example:
> > > > -
> > > > -&cpcap {
> > > > -     cpcap_pwrbutton: pwrbutton {
> > > > -             compatible =3D "motorola,cpcap-pwrbutton";
> > > > -             interrupts =3D <23 IRQ_TYPE_NONE>;
> > > > -     };
> > > > -};
> > > > diff --git a/Documentation/devicetree/bindings/input/motorola,cpcap=
-pwrbutton.yaml b/Documentation/devicetree/bindings/input/motorola,cpcap-pw=
rbutton.yaml
> > > > new file mode 100644
> > > > index 000000000000..643f6b2b1f13
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/input/motorola,cpcap-pwrbut=
ton.yaml
> > > > @@ -0,0 +1,32 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/input/motorola,cpcap-pwrbutton.=
yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Motorola CPCAP PMIC power key
> > > > +
> > > > +maintainers:
> > > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > > > +
> > > > +description:
> > > > +  This module is part of the Motorola CPCAP MFD device. For more d=
etails
> > > > +  see Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml. T=
he
> > > > +  power key is represented as a sub-node of the PMIC node on the d=
evice
> > > > +  tree.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: motorola,cpcap-pwrbutton
> > > > +
> > > > +  interrupts:
> > > > +    minItems: 1
> > >
> > > Should this be maxItems: 1?
> > >
> > > > +    description: CPCAP's ON interrupt
> > >
> > > Or I suppose:
> > >
> > >   items:
> > >     - description: ...
> > >
> >
> > Both options are perfectly fine for me, and I lean towards using
> > "items: desc" but I would like to hear what schema maintainers would
> > say, which layout is preferred in this case.
>
> Either is fine. 'description' is fine if you have something specific
> about the interrupt to say. Saying what the interrupt is for is
> specific. So 'description' is good in this case.
>

Noted, thank you.

> Rob
