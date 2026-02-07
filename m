Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2773358D6
	for <linux-input@vger.kernel.org>; Sat,  7 Feb 2026 17:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770485138; cv=pass; b=O9oAcpoNqP9us2uZlPeMk0ckXQmHxnNe2cMqTafaT81UbG4Y3L7hrWILt96YWpu3JYb/I0+oSAYWrsHW68KJlcOG8mS/hX3I2CeCPnqxGqvLClg2UjqehqX4q90qthofuYoEltazXOxNM3RhjOC1ia4F+yPB7ZBuDHKqJoCrimw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770485138; c=relaxed/simple;
	bh=HEIODAx2+Jyjm0uU9ELdLTTbA84lSwuzGWDVhw7tp58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TnvqNM3Kv2dwMTSwCfcgId5ROpABfNIDvz5Qq0KU3wMkqfYyzXPPx8c25NCWasIzHjiVqX4uGXveu5fAjm0yDOsG07QiMS/NKe1SQ32B/cBUX7jKLTYggLy3FNNqF144GSx05P63ltDOosVaqkk+hyHr7CaCEfrgNhh4BACnA3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5HDNnOg; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5HDNnOg"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so29254785e9.1
        for <linux-input@vger.kernel.org>; Sat, 07 Feb 2026 09:25:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770485137; cv=none;
        d=google.com; s=arc-20240605;
        b=Bs3envfKZ0g7bcIwaCHgY029Ghny44v2UUY9ZlhF4ehNNWjIeoic9lRHm4AL/GEBpP
         FLGR9IDxBg2oTVR45recDudsk4MldcSkmaTB5qzhWeEAGRD21G9TBgbArxniCxFFI1xO
         SLW9F9EksKVtrW2TG0kC0IEne/V99sf6RUrqqjVqqMLDHFKLNMGbEaRRWQJzFE86vNp2
         vteN3qmkj847mZJhd8SdlkUnU4FJwC2ax5+NZPtWufL97TVnSb+HkzwRbXmFh4WN1VGL
         s4yh10KEjlPL5JfayxkVXHmu/nOMCFfYdagugebz10aVcmeAB1ZvsK8qDdCVELyV7ui5
         CVPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sI2SyZ4XJiIDdMOpKUZsjQ6ZCYdtN4FvLlZEhJIfteQ=;
        fh=BIIS9z0X0vE59J8aZhyuEZ4FTikJ/L4KJyItze6w+VY=;
        b=lwCx3czWTQESXstWuUUlDT3C8y2KASWksH2HZj5DLTaVgCzuO4hRdftSA+p13jaPMH
         +91m2mgXlKdCSRJ0BeZOkN27oRiPuHgbQtEUVB0jZywIh2ZjcQruTvQQQQzc9lbcKLI0
         dntR4Wu6GSony0+VsN0g4faV9xO3k7SceqVtC6icveVXRYPWb18G+350Yp8eLe+WcSeK
         o7YrMljWCKsnP9F7ZH38ERFEgoczcH1yYm/QwPApSMYECtTAaBIyVdZRq/hwMESm0cZd
         6qQDg4e3+ylVgdeEfOmLxi4YpyT+xBptJfXv/vSPfQcmg0uCR3ZijpqFmIdmfU76MDHm
         +RDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770485137; x=1771089937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sI2SyZ4XJiIDdMOpKUZsjQ6ZCYdtN4FvLlZEhJIfteQ=;
        b=X5HDNnOgmYojYmhxFSXk5RZ0YjP8oC0DqFnGB6dDKUql4/Qe97IJwHBVdPHRR7lyxa
         AZXGPrbbytIvtHXgDtWnpF+AqktHR3RGBTFjKAYvoZAjt5+yUSCbbKl7aEse2Vvyf4He
         V/XNxvM/aefGXoS7JJhERpOTwLoXP5tZH6QCur6HM980py7diD1fpnx3IfnzJ8jNXkUR
         KAj/PGMn4jgWR13z2inFXANj+W6SIzP0iAwU+SSRnXKnVMm2fDKjG27LcoK84AoUZugz
         pT7vK/TQjPJZpRCmSLinuNX0qCAkCL1kLTqcAGjk+UYP+qi7YSd49F9Ef7Fcqb/s/LO7
         SZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770485137; x=1771089937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sI2SyZ4XJiIDdMOpKUZsjQ6ZCYdtN4FvLlZEhJIfteQ=;
        b=h/ETsKdTHQ28bTVJrcyizluHfGjxY0spPzInm4IzOOK9tkqLIQtWxSB1UbeI3/7cqv
         UE7KaXFTxpuhmv526Z2M2JzwV6ojP7ed1XZYeMqOU36PA1ZRpsdqQmFFqO/CV9BxFqeH
         95UIbKnSrf4KgR4hd/t+jhA9pw1unIxS9pQm5U0P+umBxbzTjHrPOQol9cVZASvL6r9A
         KavWuDHYCQlN2UJclUUYlFqZniLZEn1ujRrsHYyTszVs9/wmCNsZf/VEzQZNUAGb9HgW
         8DJaCmxXkX2nYrBX0/3J1ec1XFmB8UFxuAxQTUD/jt8IwE1pDXdZjE7IVnG5Db++MmhT
         uO2g==
X-Forwarded-Encrypted: i=1; AJvYcCVZ9KAnluj0Rr4CBxxMaEDdgDKOcB6x2FUoKk83QjwkTZ5Qb570XcVFa2a3sa1DYv5mgitZm/OaZhqJkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDmTAzyJgZbSW0JZizJExKXNjjwGVuGIdK0QUC2WWkKmJzBwSv
	hb3L5InfZbSgFZ47xd3zvyGUBFCvVNgnaTSQrjpH4nhX6nN80k1Ua9mkMCxhk9dmWgddzEyky4h
	6cTYd1AhnOh33B2z7zMtoTv2q7nypioc=
X-Gm-Gg: AZuq6aJNT3jWHbkuSuymyajLjxCmtnxG9iyyaYibJuCZqoqfYN54ohS7W66HDOQN/z2
	ecblaJYCHUFId/kdpqB+j9Id4d5RIG98UqUA4FW7KpUCnuIaAUKACaiwx7ztpJUdSGYVPvHQQx0
	PeKq7sK78wlgz0t3U2Hmc5OqN1k5NWFnQNLLBrIUQEU1RdcVtRwB+AnDGqXTljd45tzk107Cunr
	QObWtiSjYDp9utWeciXbgBtLSLy/A7BJniLAmAdAPpjGNTxnoqGh9XhjiniblmRMB3xX330
X-Received: by 2002:a05:600c:3b20:b0:47a:9560:ec28 with SMTP id
 5b1f17b1804b1-4832020df6amr86248735e9.13.1770485136527; Sat, 07 Feb 2026
 09:25:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206172845.145407-1-clamor95@gmail.com> <20260206172845.145407-2-clamor95@gmail.com>
 <20260206230922.GA254792-robh@kernel.org> <CAPVz0n3EGCSLUX7jTLve0x0z4uW1yexViCwkSQLY2d_4r4qkjg@mail.gmail.com>
 <db9115ca-2c8f-4b5e-89ce-f3b934071a59@baylibre.com>
In-Reply-To: <db9115ca-2c8f-4b5e-89ce-f3b934071a59@baylibre.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 7 Feb 2026 19:25:25 +0200
X-Gm-Features: AZwV_Qhk8RolsJvtdrDUiFlMwGmOTQ98t3Sh6iWn13yc2G3IUcR3Ke69B4Ocad0
Message-ID: <CAPVz0n2KwqPw88JVcPzhTQ2n+GKzahkrEThjjrqm0CSdjKTEOw@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] dt-bindings: regulator: cpcap-regulator: convert
 to DT schema
To: David Lechner <dlechner@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Dixit Parmar <dixitparmar19@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D0=B1, 7 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 19:19 David=
 Lechner <dlechner@baylibre.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 2/7/26 3:20 AM, Svyatoslav Ryhel wrote:
> > =D1=81=D0=B1, 7 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 01:09 R=
ob Herring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >>
> >> On Fri, Feb 06, 2026 at 07:28:35PM +0200, Svyatoslav Ryhel wrote:
> >>> Convert devicetree bindings for the Motorola CPCAP MFD regulator subn=
ode
> >>> from TXT to YAML format. Main functionality preserved.
> >>>
>
> ...
>
> >>> +properties:
> >>> +  compatible:
> >>> +    enum:
> >>> +      - motorola,cpcap-regulator
> >>> +      - motorola,mapphone-cpcap-regulator
> >>> +      - motorola,xoom-cpcap-regulator
> >>> +
> >>> +  regulators:
> >>> +    type: object
> >>> +
> >>> +    patternProperties:
> >>> +      "$[A-Z0-9]+^":
> >>
> >> I thought it was said on the last version to list the names. Consideri=
ng
> >> you already have them below, better to put them in schema than prose.
> >> And pretty much all regulator bindings define the names.
> >>
> >
> > What exactly do you propose? All those names will not fit into a
> > single unbreakable line (more than 125 columns in length btw). Patch
> > checker will complain about this. Duplicate pattern properties for
> > every few names? Please be a bit more specific. Thank you!
>
> Making checkpatch happy is not a hard requirement. If you have to
> go over 125 characters for technical reasons, no one is going to
> complain.
>
> I already gave an example on the last version. It is just a regex
> expression. (And note that you didn't fix the $ and ^ either. ^
> means beginning of the line and $ means the end of the line. So
> the pattern currently won't match anything.)
>
> patternProperties:
>   "^(SW1|SW2|SW3|SW4|SW5|...)$":
>
>
> And I hope it is obvious that you are meant to replace ... with the
> rest of the names separated by |.
>

David, thank you for your suggestions and I did not want to offend you
nor Rob, or ignore. Using this large string IMHO feels a bit wrong. No
offence, I will use it if required. At the same time I was
experimenting with possible representation and come up with smth like
this:

    patternProperties:
      "^SW[1-6]$":
        type: object
        $ref: /schemas/regulator/regulator.yaml#
        unevaluatedProperties: false

        required:
          - regulator-name
          - regulator-enable-ramp-delay
          - regulator-min-microvolt
          - regulator-max-microvolt

      "^V(CAM|CSI|DAC|DIG|FUSE|HVIO|SDIO|PLL|RF1|RF2|RFREF)$":
        type: object
        $ref: /schemas/regulator/regulator.yaml#
        unevaluatedProperties: false

        required:
          - regulator-name
          - regulator-enable-ramp-delay
          - regulator-min-microvolt
          - regulator-max-microvolt

      "^V(WLAN1|WLAN2|SIM|SIMCARD|VIB|USB|AUDIO)$":
        type: object
        $ref: /schemas/regulator/regulator.yaml#
        unevaluatedProperties: false

        required:
          - regulator-name
          - regulator-enable-ramp-delay
          - regulator-min-microvolt
          - regulator-max-microvolt

Will this be acceptable? It passes checks
