Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C6632E697
	for <linux-input@vger.kernel.org>; Mon, 26 Jan 2026 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769422434; cv=pass; b=pCxVUQ34YUK3wNxN7YZGnVkQtA2l9wQ0tjOxLOG5OjVdvbAQgTa2hb3Pc0I1JXvZiiEn4Vu7ZOBkndyuxzx4ko4iZc6nVGKlPIpM98sXDHQZKrxEFdWDCWMK/49T7wPMdgutKL1JU+bgVyCPYK1bq0bNICHb9LuasRjEQFcc1gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769422434; c=relaxed/simple;
	bh=wy+avasr22mgfIucIYeDtvO+JIZdj7VULkHTn3GuJCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U60zlt1+G/5JNU+WwS0qsxDbJvlAUnr5G2eLbgKGl1045K5PHbaBvieFPESc7jfM5RUj35BdZVlwOYqV8tPBM2AyFeJZcWKdlZyCbqMMPHFYhScw0jIjHv2fiei8sZOZAzxhvIxUhJLmFoJMwsBDLIMDRHBT+BciY85DZhe1UMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elnDSJUZ; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elnDSJUZ"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42fbc305914so3719770f8f.0
        for <linux-input@vger.kernel.org>; Mon, 26 Jan 2026 02:13:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769422431; cv=none;
        d=google.com; s=arc-20240605;
        b=R/+2mOaA+TblI6KsDSQF/qcHzWzpXyP62TnkY4Dk0yf3IGGu8NSwIng/g8H1X7eocH
         zA5XX3Bg8zuaW6evbIDLc0FVlzHE0xt6tU2OzQ46v6Rk+tJben/o+Ws2JSraeO7fNOtq
         2pduyEZmRA28sbgs90U4o8F2VclYWmyfN5koWgq8PNAFAByFDIIxN3P3xXlRMwLcmKMw
         LtIWxoxFMTfClc5zY1bFGTYC4draAXp3Ccnj6fKImBgOCcoykC4q7wCZpMYZ+WyxO/Rt
         Qm4lYLcV5MxSSc9BZKwq9mg/mTYdB3qwEUX6TOCVaxoimmQ2V4/Mj5Z3IqbTpBcNJlV7
         IpUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/9dTPcMDWhfJ1rIvjDmwY/itS6IYJkkuuHjxU9ulEjk=;
        fh=5ULH16AXfcA2fn5KBsMb1Mojd33gQAo3Ag22bksNoGY=;
        b=DLHuun+tt1WB/Efzb141uUu6tomOiWJy5Yc80by94+OXrswPKbv6PdekyVfeCFNHni
         ctmVUhFtk58fw6gG3Yt7AFacyT1v4uZjofxMrfPSYrHA0fzmuc3nZzpBCZKbib8x5wjW
         DMuhIl0AqQ7xnd3TTSvAbvutEo6DeRrXAC7UO7EGXYC5XIIWYu8qEdDej/dC0w21+SkN
         HIpODCCqTKjZhvTxt//l5gUDXmdVeRlT2sZ2gYNpyMlVZBzHymryKHTnNtaZRAAmRZQS
         UNqS8AehPJFyuWKlgcl/9q/LiOujEFbs5POp125sFbD1Em/m5uMInrvSlsWpRYa1MtnK
         4LZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769422431; x=1770027231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9dTPcMDWhfJ1rIvjDmwY/itS6IYJkkuuHjxU9ulEjk=;
        b=elnDSJUZbStbMHWx0dcASZueczLi03SuEJsFL7IWU8wcbnx3DTXbep8uw9YePkzG2a
         MuTQuJRp/opoXbEc0fjd7uRRwemI0apD/kQ8c0wMbhLFwNAl3QHaQWkRhCuYsWR/Xb3p
         aP9cV+le9oVbyg+/15e3VGrLhAQTu2syytcHTQZDHblerrvvYDDdTadSDkScRiZK+FpT
         6j0+uLvSRF6LiCa0AdzaS0s/fRZyF0mMfjv0l6b+i2yZ2+GV5ADc6nxa9nYTAd0NT1ob
         Ho5mTEI/Eb6UPZPt/8nmr9avjBraCnrEeoInuVfPXtgeJOzB5zIK1IkAaebXI3vry6hh
         0J4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769422431; x=1770027231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/9dTPcMDWhfJ1rIvjDmwY/itS6IYJkkuuHjxU9ulEjk=;
        b=ISpN5eMGgve+2AX+Xb+ZKXJ0X6CaPfco+GtswVAB8HeNujUrpbN0uUHJz8DKXn1od/
         MvNUkzdZZLv9h5EFEdmhmYfKS1rLE5HMJPOEltZMeI9wIH51FER7dF6WedVAJZSOasYr
         lnJnf9ZpL39Md2mRxM/k+//9S9mWxns6jUPk/FT2aPlTU/6poUSEI4eFf+/tp+uECwsB
         uc/AoJDyej3RXEHXmtegB8OC7d3FIP58kRC/f94lMVA1hi2tFGpz4KwiQ2y0RW4rFIrS
         /6PyPE97bGIwN1tsQ1SI2Z+bYK8B5Z4hpk/MTYXh1W93gKn0eFmLWxAYHnxUUj8EFxgq
         Jzhg==
X-Forwarded-Encrypted: i=1; AJvYcCW2rDOkmVVhJSRtkuO7rRZl1gq9mw76q6vtiehqsXqQCWtscHwcUuGFvnaOFVugyQiNFnYB1HzR3DzXAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUzq0vva2Iuzki23H63+DZo3iuIHq/iGWR+b99JXDh6MNp4N/o
	RJeSH3jfnS85+GKGnioan3JOEuzAZKj3hH7AERpXRETOwLGsAsY1iW7eClPPX74N6bC0lMv46BK
	L3mfKCKsVGg1UtcictECouhEk4JL/W/A=
X-Gm-Gg: AZuq6aJO1thlFSkJmawQM7qoF3GqaDflfZSYdwGGnlojHQWE09+s/H7qy2s90+OCv5M
	KwDPPZnQZmzErZuq3ELTQ+jVTmaF3SWStRr+nVUpdVb04piMpGo5U73C8/yLrb/UGCBmnes5cDb
	iOCgxoIBM94tPCxeu8ApVazwG1Yo5fdpucxYsKojHtNPSK13RgK0tD7cBY1ViAFzam+iFBBn30G
	j+PC0anGiZ3GP9PEfMgdShN41yRjjdt/JEQkRODFPs9yNDGjfCyn2lopC3SnVOAxtp2wXQW
X-Received: by 2002:a05:6000:3109:b0:435:a464:f468 with SMTP id
 ffacd0b85a97d-435ca1b0a8amr6471509f8f.47.1769422431344; Mon, 26 Jan 2026
 02:13:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125134302.45958-1-clamor95@gmail.com> <20260125134302.45958-3-clamor95@gmail.com>
 <aXc9n_gc7TEFvNA8@smile.fi.intel.com>
In-Reply-To: <aXc9n_gc7TEFvNA8@smile.fi.intel.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 26 Jan 2026 12:13:39 +0200
X-Gm-Features: AZwV_QgQiSXyGE1Y1qrMc2HU_ThQY8l_CasgZEnx0m0QabZgNO42haOxvzkombQ
Message-ID: <CAPVz0n0MM6OcjOWnNBaGk=6eYcb09P0XBFDn+MYHtXXcgkcvQQ@mail.gmail.com>
Subject: Re: [PATCH v1 02/10] regulator: cpcap-regulator: add support for Mot regulators
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
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

=D0=BF=D0=BD, 26 =D1=81=D1=96=D1=87. 2026=E2=80=AF=D1=80. =D0=BE 12:10 Andy=
 Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, Jan 25, 2026 at 03:42:54PM +0200, Svyatoslav Ryhel wrote:
> > Add support for regulator set used in Motorola Mot board, used as a bas=
e
> > for Atrix 4G and Droid X2 smartphones.
>
> ...
>
> > +static const unsigned int sw_mot_val_tbl[] =3D  { 600000, 612500, 6250=
00,
> > +                                             637500, 650000, 662500,
> > +                                             675000, 687500, 700000,
> > +                                             712500, 725000, 737500,
> > +                                             750000, 762500, 775000,
> > +                                             787500, 800000, 812500,
> > +                                             825000, 837500, 850000,
> > +                                             862500, 875000, 887500,
> > +                                             900000, 912500, 925000,
> > +                                             937500, 950000, 962500,
> > +                                             975000, 987500, 1000000,
> > +                                             1012500, 1025000, 1037500=
,
> > +                                             1050000, 1062500, 1075000=
,
> > +                                             1087500, 1100000, 1112500=
,
> > +                                             1125000, 1137500, 1150000=
,
> > +                                             1162500, 1175000, 1187500=
,
> > +                                             1200000, 1212500, 1225000=
,
> > +                                             1237500, 1250000, 1262500=
,
> > +                                             1275000, 1287500, 1300000=
,
> > +                                             1312500, 1325000, 1337500=
,
> > +                                             1350000, 1362500, 1375000=
,
> > +                                             1387500, 1400000, 1412500=
,
> > +                                             1425000, 1437500, 1450000=
,
> > +                                             1462500, 1475000, };
>
> What a style! (Yeah, I see it's being used elsewhere here...)
>

I have just made it in same way the other tables present in here.

> ...
>
> > +     CPCAP_REG(VAUDIO, CPCAP_REG_VAUDIOC, CPCAP_REG_ASSIGN4,
> > +               CPCAP_BIT_VAUDIO_SEL, vaudio_val_tbl,
> > +               0x16, 0x1, 0x5, 0, 0),
>
> > +     { /* sentinel */ },
>
> No trailing comma for sentinel.
>

noted

> > +};
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
