Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BD140629B
	for <linux-input@vger.kernel.org>; Thu,  7 May 2026 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164578; cv=pass; b=umAmXObyQIMAp4fR5jwF1hd+7279kauwp8HXm68oq8OxDZl0DZnZNDt48s7eMxVhKJxU4r8PY+1qTudJkTEZ5nTXQvRVVmVmOPhhDXncF1YKz0eWVarh7R7NjqERP+Ls3wf/CxvriDaMoZP1tROPww3wICdVFTg0JRC4cYswHbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164578; c=relaxed/simple;
	bh=4Q4gVA5Jd1n6uyC1ZvFQ4rucoXxJLhEiilF2amKyVc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJ6NxyNYq3cDUpie3n6rLtCEqt9xnNdiXI6tmHjBmDV5MWctJrgFKd1G3W/Pvo1KxoKeKSm0FtPvdJ9FOVq01e3hQKMQPhLvxTOxoiTIJ0CDwRO8XT9XyaJZLmz4a4dgeFSVeleTlqb97NZxkT8BfJ/B9eWKFuwV5Tee9+OGAXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDW7JPq7; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDW7JPq7"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2f7ca62a3c4so268105eec.0
        for <linux-input@vger.kernel.org>; Thu, 07 May 2026 07:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778164575; cv=none;
        d=google.com; s=arc-20240605;
        b=JPfe8PKefIA1b6FRSz2Y/CK1LMnqIHSlFm0gk+rtJL5CDKVrzuoMD8+Kwsrznvtrbb
         +7p2QF5a49c0kujU5/4EtM9q/QlNv63eNl66RSxZuKrbEbXqd2LMnxdyOr3Vt2m7+gsZ
         pS5FwY0Aos/D/xctx0eOcziOjR5Geexy3C9Rhy83Kd5OynoI8xYipOnqErzevTPKG4xE
         5x+cv/9n8W/lTRHKmraFcLQwKapoHr8cBvsDDnO6H/G+C8BA6YthG9ULbrdpbK0dqMaZ
         OI0VD/rzPBr5hdx0i3IjbGKoF7DI48Oe+qnfuRaFsRx0fmQEy7DYqJ9keGpxAmoP03Xl
         U8Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tTnB6vEkbQqbTnl4MQ8rpdfcud19RDfiJ5lqADHuqcU=;
        fh=rtQOQfyHCsNAn8fUgMRQxwkwCaaThgaa18YGBplO6NE=;
        b=W3sqE3X1gj9FAcGk08F5Lc+FJ/C3iRNdrrCgi6XQHdCb0Nt1VNwnWfSLaDTTmNSlEH
         MPsTrMvbZzKktqlcMivxK1yCyh4dREHYs5RIoAbfkyP00z/QoLFs0RdGqcqWvvzCcAMs
         NKdFZPT4bfOeqFkSJbm9nudScHfCHvlslI7Qy/uKp/+X+sxhN+wXo4bjuwKkvL/CC2LE
         E7GPq0SnyUxlNn5FOEHv8eAHf6MXJpXOiBwcD30fXaXdj3TyvriuyvE5yLibKF5m9H0T
         34U7g+/a89uTFrlq9ZMstIIAlCD9BLB/HiR5OIO1A+q2P5G3FUMqLzETCjLYzQuGrXYA
         ZRKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778164575; x=1778769375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTnB6vEkbQqbTnl4MQ8rpdfcud19RDfiJ5lqADHuqcU=;
        b=QDW7JPq7xBsH6lYqhvbKiu78exWMcccuTrYmUhktnNeNzlCp++Ysu3NfDUosZ+MS2n
         rEJIWPOzavyHTVgeONqo7VoYJ6arOBLNDvT8MiqCoL5f0/CN6bo/RsRcjoz9XQt+CToc
         LMr3V8dgiwO5LhQ8sn9EyISflfchzqdHKHl3EVGatiOmVw7SL9yolLqDTSbL65475W5B
         jS0IxwyqW70zAho0srUNBVd54FyEBSxIUgCRknUnYG6n4PuswuRgHFaMqFwZ5Uw9O82+
         HLCTgAk6ZrqlvGF/hy0HdyGxMyM2HHl+vseN6V43kuRlb09GjTicJeFdV8vEaD0PqmkK
         7CvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778164575; x=1778769375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tTnB6vEkbQqbTnl4MQ8rpdfcud19RDfiJ5lqADHuqcU=;
        b=Ha8vyBzXdcRDbtXrOjbKZBJWpSOpsyYsC+uYJogvs/RyhJDd1fVz73oDvQ2MbF2i9m
         UAW3NR6eBUzRjetSxYdOUAFnojgLqQVaCC/zKRghMBJyPSoirIQo/rKqiDss/Y7mmlrE
         C6hTekJAVj0SDx6zre+PCae8bZD3KX1DvBmF5wU5D5w1XTqFqG5+lxX3wRKTFNDNip8g
         rVoxAEIjuMqKTjvbTjGoVhmW/xpmbOpeEGyCcG0riJCFKE50MwxpNk+i+A+b1BfOmFdV
         f/jUPJFnUjpIbXv0qUuTa7zUgJ3q+xFk8AXnCSC+HkSGoetHnoZTdP8yZOsuLskUXN1Z
         s9RQ==
X-Forwarded-Encrypted: i=1; AFNElJ/MX8c7ZBo4fX75ctuEq5UitrFrSn2Ysb+6lllFfagRRyMCNY+euJonxVC27ho7k+zxiMBUb3UKptNu3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKcvlB1cuSt22rp4dB8dIb3ScYu6zeVqAOSZPTwQNWfFAD3j+6
	8ou74ek1sKItavDc3hlWw6OwBrcGxdV6wF1cuYPIJt2CNNfbgPJiYhIR/grYkta4jsBHp161y7R
	71DmXl7tP6H06m0yvTybfY2AUY884Jxc=
X-Gm-Gg: AeBDiev/M+6YZ2ICZCU3yC6s0TJMyuuUw0HOB/P3ZyZie8/cxttuCQBvoEQTwEFRkUx
	+fyn24AnLqHnIb5IqpTOyRAgMlWh+CA8YgeF2aCOZacdk/1krND2tjgaDLheND9ZC8aVZkfsRQP
	zqMui8ea9ArhEzYfAuDyp3sk5vh967qpjM+gM7zCe0fopPMfMoln4bJ1jnXQuW+B/ULtBWMKRwC
	iqFg2wYQg2jO2UH2UmrXRQoBEC1IdC8w1ERWtDNDY2WUYGa02jffEf677s5rBahmR8xTzDn/wAo
	f3oQhKR5wI0/IDoTnuI=
X-Received: by 2002:a05:7301:1018:b0:2ea:ed70:3ea8 with SMTP id
 5a478bee46e88-2f54e3802ddmr3907198eec.29.1778164575034; Thu, 07 May 2026
 07:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428153611.142816-1-clamor95@gmail.com> <20260428153611.142816-7-clamor95@gmail.com>
 <20260507140715.GP305027@google.com>
In-Reply-To: <20260507140715.GP305027@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 7 May 2026 17:36:03 +0300
X-Gm-Features: AVHnY4Ipu20JTRjb2M-ehjX65DOmdXWZujrR93JWxLxR9_IHfdzLcTQAicaBOVc
Message-ID: <CAPVz0n2nfRkxg-M+jVfLaXbTO1AR_GtV7e8Vnw32gWTazUjsjQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6 RESEND] mfd: motorola-cpcap: add support for Mot
 CPCAP composition
To: Lee Jones <lee@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Tony Lindgren <tony@atomide.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 7 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 17:07=
 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, 28 Apr 2026, Svyatoslav Ryhel wrote:
>
> > Add a MFD subdevice composition used in Tegra20 based Mot board
> > (Motorola Atrix 4G and Droid X2).
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/mfd/motorola-cpcap.c | 50 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >
> > diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.=
c
> > index 516d1e33affa..fdec92f5c6b0 100644
> > --- a/drivers/mfd/motorola-cpcap.c
> > +++ b/drivers/mfd/motorola-cpcap.c
> > @@ -335,6 +335,54 @@ static const struct cpcap_chip_data cpcap_mapphone=
_data =3D {
> >       .num_devices =3D ARRAY_SIZE(cpcap_mapphone_mfd_devices),
> >  };
> >
> > +/*
> > + * The Mot board features a USB-PHY and charger similar to the ones in
> > + * Mapphone; however, because Mot is based on Tegra20, it is incompati=
ble
> > + * with the existing implementation, which is tightly interconnected w=
ith
> > + * the OMAP USB PHY.
> > + */
> > +static const struct mfd_cell cpcap_mot_mfd_devices[] =3D {
> > +     {
> > +             .name          =3D "cpcap_adc",
> > +             .of_compatible =3D "motorola,mot-cpcap-adc",
> > +     }, {
> > +             .name          =3D "cpcap_battery",
> > +             .of_compatible =3D "motorola,cpcap-battery",
> > +     }, {
> > +             .name          =3D "cpcap-regulator",
> > +             .of_compatible =3D "motorola,mot-cpcap-regulator",
> > +     }, {
> > +             .name          =3D "cpcap-rtc",
> > +             .of_compatible =3D "motorola,cpcap-rtc",
> > +     }, {
> > +             .name          =3D "cpcap-pwrbutton",
> > +             .of_compatible =3D "motorola,cpcap-pwrbutton",
> > +     }, {
> > +             .name          =3D "cpcap-led",
> > +             .id            =3D 0,
> > +             .of_compatible =3D "motorola,cpcap-led-red",
> > +     }, {
> > +             .name          =3D "cpcap-led",
> > +             .id            =3D 1,
> > +             .of_compatible =3D "motorola,cpcap-led-green",
> > +     }, {
> > +             .name          =3D "cpcap-led",
> > +             .id            =3D 2,
> > +             .of_compatible =3D "motorola,cpcap-led-blue",
> > +     }, {
> > +             .name          =3D "cpcap-led",
> > +             .id            =3D 3,
> > +             .of_compatible =3D "motorola,cpcap-led-adl",
>
> MFD_CELL_OF() for all.
>
> > +     }, {
> > +             .name          =3D "cpcap-codec",
> > +     },
>
> MFD_CELL_NAME()
>

I was not aware these macros exist. Thank you for pointing to them.

> > +};
> > +
> > +static const struct cpcap_chip_data cpcap_mot_data =3D {
> > +     .mfd_devices =3D cpcap_mot_mfd_devices,
> > +     .num_devices =3D ARRAY_SIZE(cpcap_mot_mfd_devices),
> > +};
> > +
> >  static int cpcap_probe(struct spi_device *spi)
> >  {
> >       struct cpcap_ddata *cpcap;
> > @@ -389,6 +437,7 @@ static int cpcap_probe(struct spi_device *spi)
> >  static const struct of_device_id cpcap_of_match[] =3D {
> >       { .compatible =3D "motorola,cpcap", .data =3D &cpcap_default_data=
 },
> >       { .compatible =3D "motorola,mapphone-cpcap", .data =3D &cpcap_map=
phone_data },
> > +     { .compatible =3D "motorola,mot-cpcap", .data =3D &cpcap_mot_data=
 },
> >       { /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, cpcap_of_match);
> > @@ -396,6 +445,7 @@ MODULE_DEVICE_TABLE(of, cpcap_of_match);
> >  static const struct spi_device_id cpcap_spi_ids[] =3D {
> >       { .name =3D "cpcap", .driver_data =3D (kernel_ulong_t)&cpcap_defa=
ult_data },
> >       { .name =3D "mapphone-cpcap", .driver_data =3D (kernel_ulong_t)&c=
pcap_mapphone_data },
> > +     { .name =3D "mot-cpcap", .driver_data =3D (kernel_ulong_t)&cpcap_=
mot_data },
> >       { /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(spi, cpcap_spi_ids);
> > --
> > 2.51.0
> >
>
> --
> Lee Jones
