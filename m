Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3F732E729
	for <linux-input@vger.kernel.org>; Mon, 26 Jan 2026 10:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769422484; cv=pass; b=ltz2VYVnpn1VBdVLkMbMIwZGiTmTeYN0062anmLBLaUpPbI5ePphlbtIpz5FME+oKdTVMAv5wS2PiJbSiB/+l0OaQmnq5nEe5iICzvKybsBCOaBkM/CiwNEEc8Pw++04VNGuwpYVL2HDCUo7NdpVjCJtz1vM6kqoGWoXuMqmJW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769422484; c=relaxed/simple;
	bh=592arfCzKGEEI9SsaoPXnjPAToUssVCz65hbUHolUeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdJWo80EeSdqmxtqQMFmrQMzaQEhmeA2uUNrgcszJW6E+LdOaRZFsko0ydWJLFViOEOJXyRsl5Wnniwqb+z793eEn1fZtJlvRkbmvIRabHJ2wCn4JF+MQY2r/hN8oqIjwXNl25kxbKbfEY5VEDvVUgc/s56d7zFe45GO6IvhpW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSQ0iVFX; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSQ0iVFX"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48049955f7fso36547855e9.0
        for <linux-input@vger.kernel.org>; Mon, 26 Jan 2026 02:14:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769422481; cv=none;
        d=google.com; s=arc-20240605;
        b=QYn3Td14Ufj0mwUfANe3yNbKyPzW1RHjQ92qdsaQb8Tywr/MJSFgBYYsdcl4ugyx4G
         u1EBTcbu70NB33pPpJ06wnSEeAWnao7ifPvnN0FbqXJZeI/X3Uo8OXHTJ6rAJtvCKHlv
         EZysqqPZIOdqOjYWueTroSSl8fK/8UCu29S3iGcd2VUmOxo9c/f/UIItLBRoKZbk6cil
         lEBy08T77HoUv4bSzpiHwro6TV16vpqvXEtx+dBdbgCLAWuLoAl3M7IDiRYpaqRv+yqq
         +LWslyoj19iMEE0JLaPsNxxOW5qOmHrnVd2AztSH85EblByJMUND5AMKBvue6l1hYIOI
         EJIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5fg+wculjolsM/YfIrc/6Q4VkgefoBAjkv+6Ml7KMXI=;
        fh=ru5/N5wcduq5XpvbCmwteZOyUKo2RfNNEHZRCrBhtwU=;
        b=EgwC98u9M4MPHGJj5yyqTwe7cNU081mziIMaYEybkxVnTMvO13ynuIy05im6DJLTu1
         AKeYnXs1clz6j5v1YCPTcg/S8ho06bcclHMArVpVeLRQjaQ2gPbaRjAydOhd201Dh/d0
         UmPTj4aoSzffXTQTVeFweMkMUoaFBTliGN+vwaIp4LGvKS5Qjou0gjw7pF8LBGbYR31E
         sgvGDeyVb6OcS2LAmMO64MLGWFAZ5KZ9d7Df7Goqq8CkNX3jwUXD0+Dx0A6dC/AQ1R9l
         Mpcp+dhG3tW3Cu8CeckcM/opgY8MMmoqyDSOwaEQ+rVMKe3CnhWT83ZeDPGoevCGhi0U
         Wj2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769422481; x=1770027281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fg+wculjolsM/YfIrc/6Q4VkgefoBAjkv+6Ml7KMXI=;
        b=ZSQ0iVFXMmjK/kc/36PWwYn4SIrOzwzn64dBLWxLogB/IELrzncsWDA2xmecOprrql
         XB02nP+PMTjnLm9+7uQWvkVWfFQuFyJHqwnyyOLewAUvPrxlZ35sX6hdzEHSJJ35tfhy
         GToGY9njBZgbwQmlJnAysa7a9cKAExGnzIgRHVFDt7HTPd8aye5R3dKMj6SoCP9h4nKR
         KjG4ouvwKNB/XLuganokKzr4Sks2DKsa1Wdtyj+5BCGndEPt521lm3uJR1lEjqVWvIQP
         AMUC3K66yaytIOkv7DztJ5qn46kpw5Y220aiMyHvs5louFTljILfK6LpFWjcyNfRmcvM
         Hxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769422481; x=1770027281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5fg+wculjolsM/YfIrc/6Q4VkgefoBAjkv+6Ml7KMXI=;
        b=BoV2lU/9ijEHLP/WtNsl7jtd1fgiz1lnub/OUH8nmn8JWZetV+MSWhlLNE23om2heA
         ZxS0+FF915aGA4i5VA6qVo0xlr35duDvtoClp0MpmINMtcX6PD4J06D3H8ygtwjbMV9a
         uK4nxcKinoYt4BZPOAX9RuR/voaX+fhP4+wgbnGaG2Hh1jqIa9h8vp70LYMbmY547Be2
         ZF7q5agKa5GmOVHMLS5SHkmxcgs6yH0Cyp63/UfeSjU76x9nBFAdHGJNFN151Qd73neU
         orN07/UUe9AIqfqlDf22W1vuDhSW5yEnc6BMPxseeFEkq0LmvRKFZAuBiyDJNesgWmiG
         q/5w==
X-Forwarded-Encrypted: i=1; AJvYcCXShkPS9X8ImBlGgK3ylB8BZCe7If2qZzR7fIUe8WKP1L1xv6ILGhGY3LcZ/M8iU3zdhza6p/tbz3sxTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVzNZhNaHxrCkcXTxEmsTSePY9DotP2+UBHB6RgZz/HsoD0nV+
	U03H0ChjZzPEWFw56+xzQhn9pq+JuygIi9gPrR6phxc0q4pubM1UWSAc3tS60ya5VMpPEOAvbSL
	x1Frb+nEQXQj56bB9+ZN4b0bZgTt3O44=
X-Gm-Gg: AZuq6aKbo+XIdtrJqP8q1xE5qEazjgOnIRRiKQX0Pu+oTOXGEVYTznj6Udk7LlLbBm3
	T4+wuRmv1dqv/HFZ30HBVe6GKrPpUkGcQV8y6t1DyeKedvtZ9Khjy/oN2lgeVN6jQYZqrl4IQs8
	va/iFJTy5GkDeSnNsg5VyTEAzROVml5ZXwyPRFfvpkKKDa2+IFZ4GCH5jRdnX4yx0PKaQJSYfzD
	9L4f4a/eLp/SQESIAccomQP9Wl+NJJwx9oqvgW6vhyRS6iPMwXyEDa4M+AJvXcpk5Le2j3y
X-Received: by 2002:a05:600c:5494:b0:47e:e78a:c833 with SMTP id
 5b1f17b1804b1-4805d064297mr63059575e9.32.1769422481165; Mon, 26 Jan 2026
 02:14:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125134302.45958-1-clamor95@gmail.com> <20260125134302.45958-10-clamor95@gmail.com>
 <aXc-Sklb6QTWLvcE@smile.fi.intel.com>
In-Reply-To: <aXc-Sklb6QTWLvcE@smile.fi.intel.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 26 Jan 2026 12:14:29 +0200
X-Gm-Features: AZwV_QihBi0RBeQR-keWUCWb4tTVxVMg1HeR7j7c13MGT36B2hq70uBMvm9ETsA
Message-ID: <CAPVz0n3QBhi4qmyT2y7J8i_3kXDW3tXtC6D4XQnhz2H2W4-XRA@mail.gmail.com>
Subject: Re: [PATCH v1 09/10] mfd: motorola-cpcap: diverge configuration per-board
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

=D0=BF=D0=BD, 26 =D1=81=D1=96=D1=87. 2026=E2=80=AF=D1=80. =D0=BE 12:13 Andy=
 Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, Jan 25, 2026 at 03:43:01PM +0200, Svyatoslav Ryhel wrote:
> > MFD have rigid subdevice structure which does not allow flexible dynami=
c
> > subdevice linking. Address this by diverging CPCAP subdevice compositio=
n
> > to take into account board specific configuration.
> >
> > Create a common default subdevice composition, rename existing subdevic=
e
> > composition into cpcap_mapphone_mfd_devices since it targets mainly
> > Mapphone board.
>
> ...
>
> > +#include <linux/of.h>
>
> Why?
>
>
> ...
>
> > +     cpcap->cdata =3D of_device_get_match_data(&spi->dev);
>
> device_get_match_data() from property.h.
>

noted

> > +     if (!cpcap->cdata)
> > +             return -ENODEV;
> > +
>
> ...
>
> > +static const struct of_device_id cpcap_of_match[] =3D {
> > +     { .compatible =3D "motorola,cpcap", .data =3D &cpcap_default_data=
 },
> > +     { .compatible =3D "st,6556002", .data =3D &cpcap_default_data },
> > +     { .compatible =3D "motorola,mapphone-cpcap", .data =3D &cpcap_map=
phone_data },
>
> > +     { /* sentinel */ },
>
> No trailing comma for sentinel.
>

noted

> > +};
> > +MODULE_DEVICE_TABLE(of, cpcap_of_match);
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
