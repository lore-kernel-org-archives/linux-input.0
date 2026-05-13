Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D52531B837
	for <linux-input@vger.kernel.org>; Wed, 13 May 2026 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690860; cv=pass; b=PN8gFdUVf5QpkwatW6Iy/EpdQeFFFX2MxJ2shZ+WktllVGAfVps2hvNJZIcU4TM9/rGrIrQBaYOpTXwF1wkUSVFkwjcIjPr+TS7vUOg4gyUglKsRXn+kLOqC4zb96lltO491nKiTd+dc+IVtQbFSALIik80ZHg7LftzusnZ2QnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690860; c=relaxed/simple;
	bh=ExnqDUkLINkKlD7+NygXVUJUo+YyZ6a9VvYiVKG7QhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7B7luB17esjRPCrb5HJWGSI8bgNWTbOszk5hsw60iaf/595DUomzi2hnHG1h1+g10Q/R6AeUpKIiPTD7Bjd+3dpkfkhPPoiYwYCmOMMKAEQnepT160C0xmoLykDkF8wMKrPUIXTPycpxSbRdhNh1Es4x2njKF0o41gBI7V1Eog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIZ9PX2m; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIZ9PX2m"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2f30a4601bbso7602424eec.1
        for <linux-input@vger.kernel.org>; Wed, 13 May 2026 09:47:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778690858; cv=none;
        d=google.com; s=arc-20240605;
        b=Uuv1CBL4AfOzgSxmvqPtdnRXiJ2QXpmobkhNv10txuNYsvmiCL5UwTC38MgYRK50bJ
         we3YllHJUQJhklK/B8XRfETAsIwUQpnW3wKB1KThaVlO9HXPqTNKicGT2wv69+UzZ8Hq
         flfWLZeP51Y+UTdeBJR/StWxQJpjYXXWwQH3OitTBlvsFkOMyAE7m2AdRAv0PWrp01gO
         nOIhHxL0sJwBKMzdAU+QEZViUsc99WUsVT3x5Y+zGUpbas4eKnd3Qk9qcAt0k7qLJuJV
         HM4NsUWtTOYAjfg88OyCMSbnVmTaaw0+ojwmiPaVxtOvUk+Bc5Fbmub42XzHWFYH1nvd
         WLug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JerA/KHdCfuyoaygNVbCtHqii4aEtRRNxbe67luduQk=;
        fh=P5mNzV7q5n0hErwehoWY5RHSdwj1kFXwNS7Noi+qMuw=;
        b=bJk4uphKzJ2Q4tjNvsVwPtn9bZ/NcrN7drLakzGANZmZ1qweoj8I0Xg6geXF+95v6v
         1FU2iMp11NNTxOv2k9u1G6rpzaRHWMN3mYSai6dESyFDaFBRiPFlw5gL00GgxckNiQ+0
         u4E32rp+ZcPkVxYBjKHinmANcS1cFXOY5EWvOSUXVclPl6VIrq2JgQBCafH1bg8VVoU9
         06VjiA53/uQB3S0oS36CQIVnGYHySYeEWrbgMKuI86KiGZ+kqOQalo9tlaQIoYdFihM3
         aBDskxDXkN3tOcn1Y45RqDi3usdBdhdaM4+JC/NUG1j6ZAdIGTD8uofXIiWqQ1bZJ2+7
         7rqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778690858; x=1779295658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JerA/KHdCfuyoaygNVbCtHqii4aEtRRNxbe67luduQk=;
        b=lIZ9PX2m+1rVFo5ukZcGjeoyRdBnG2brHCNsvJn3YrWZ0eQ29u1kRVdRQ9/aLLPa9v
         efPhw0n2Fu2v8dULGYccwLniNlpdGlt9CWGx+JcstZ092nDRu3ecYoT60Yif/nC04Xf+
         U8FyuDL8Jg3wxdUVPP2AevdlFjvBulirFKO7dmcUJ0jXz4CMTyDrAwcvhza0b6DzpxKm
         9CvlWUHw+VcpNiEdNQyLQwXy+eVgZ6DU/5gLRhgwaJ303IsKIv0jTgY7TXtD3r44fAoI
         4CLU0R/YZHMxgbNXFvWiigsLLgjn7b5vwFUSHZMBfd50D9Qiwtq7zMYrPy+XF70jQo1R
         +4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778690858; x=1779295658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JerA/KHdCfuyoaygNVbCtHqii4aEtRRNxbe67luduQk=;
        b=q6ttCoxQULTPqXgLaMn5ChR60AobLMj26U3gP967MpD1NfDXBmbUAmUJNqDORRJTVi
         5QiRUjT+FtK0Mgfn0RySrLXCgMzSgluKJwvT0uPgDxzlCUIv0YGnK6WBUpD4rramJ+w7
         p39LLHULxfOLbbDX1he/iTVphcJ9fJa0TnpKsEnlJ8IBrbzMDDOXYmu/5JSYaKvv8sjo
         Uoy4umhAZMjbXgE31dZaJgCXHr5x/8CJqoMHpmuV/nUXnSnBGTzdRD7gKQLajo7ynruo
         mvu4Wl8yKAzQQzbTO+1b9UwHr1z/gL6ZZ+vM/SAQOqHHCPHnRrb6i3lxkK26TD/A7HYM
         Cd/Q==
X-Forwarded-Encrypted: i=1; AFNElJ84TODRzxThDJ27/mCpp7kdxwF1AO2rj38mK8oEcNqQejUmQVjOvMgJnU54pbL7OUXqRPKmfjA4LvLe3w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yykv5bX9vehTrP4i+jRi9abUykdSHnhqddNHLJi6XLUzqY/ca1K
	Wy1wxvy1iKjl8qMsmdcD5wOS9HcibqOmd/tivAYY+whFgIhlYCfMMORZSRMDrFUmPtzGld1sPa/
	JlwSwNDCV4zwnwtEPUNZmBGI4fWEiQH8=
X-Gm-Gg: Acq92OGBMhMXTt4MxhrjppwjcbV0dq9ld+T8KAJZYVAwXBZEEpSN0NRhRf7+n2m/sN5
	krNcZtisg5FylGHgcr1ySF3B1cJ7AZXqRzG8VyD8gLzlCPXVxN2MOXUMZprzY+8ZKOr0Q6PGU3Z
	MHIMUzTnT7qnyFBxXr96s4VovwzPwDkpvRACtviDBwo8JD5EUELbQBIVH1WWi4smVK5sXFvroF6
	qb9kQc7ug2M+cPSp6x/pnGZqda7sdwGHahXg5ZmWMl7D9ECrBTS0JYR8iycj9sDBOJzxHmeh1Xh
	EMgDd5z0
X-Received: by 2002:a05:7300:a984:b0:2dd:5641:f01 with SMTP id
 5a478bee46e88-30155b4d27bmr1845952eec.28.1778690857870; Wed, 13 May 2026
 09:47:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428153611.142816-1-clamor95@gmail.com> <20260428153611.142816-6-clamor95@gmail.com>
 <20260507140519.GO305027@google.com> <CAPVz0n1Ubvj9MHHMcM2BpxAcTCCheMihr3aJUqcDVoi_V0OQ5g@mail.gmail.com>
 <20260513140550.GD305027@google.com>
In-Reply-To: <20260513140550.GD305027@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 13 May 2026 19:47:26 +0300
X-Gm-Features: AVHnY4L_UPed0nI0jqBJd7980GApXqp_CTeeRBwMRPJX6vgRQaMZTKXyU_fde7I
Message-ID: <CAPVz0n0ynA-ab1Frwy2vXsrYPm+SB+0oOoKAiHw9D7BT=+ieDQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/6 RESEND] mfd: motorola-cpcap: diverge configuration per-board
To: Lee Jones <lee@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Tony Lindgren <tony@atomide.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 13 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 17:0=
5 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, 07 May 2026, Svyatoslav Ryhel wrote:
>
> > =D1=87=D1=82, 7 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 1=
7:05 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Tue, 28 Apr 2026, Svyatoslav Ryhel wrote:
> > >
> > > > MFD have rigid subdevice structure which does not allow flexible dy=
namic
> > > > subdevice linking. Address this by diverging CPCAP subdevice compos=
ition
> > > > to take into account board specific configuration.
> > > >
> > > > Create a common default subdevice composition, rename existing subd=
evice
> > > > composition into cpcap_mapphone_mfd_devices since it targets mainly
> > > > Mapphone board.
> > > >
> > > > Removed st,6556002 as it is no longer applicable to all cases and
> > > > duplicates motorola,cpcap, which is used as the default composition=
.
> > > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > >
> > > Changelog?
> > >
> >
> > Changelog is in the cover.
> >
> > > >  drivers/mfd/motorola-cpcap.c | 101 ++++++++++++++++++++++++++++---=
----
> > > >  1 file changed, 83 insertions(+), 18 deletions(-)
> > > >
> > > > diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cp=
cap.c
> > > > index d8243b956f87..516d1e33affa 100644
> > > > --- a/drivers/mfd/motorola-cpcap.c
> > > > +++ b/drivers/mfd/motorola-cpcap.c
> > > > @@ -12,6 +12,7 @@
> > > >  #include <linux/kernel.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/mod_devicetable.h>
> > > > +#include <linux/property.h>
> > > >  #include <linux/regmap.h>
> > > >  #include <linux/sysfs.h>
> > > >
> > > > @@ -24,10 +25,16 @@
> > > >  #define CPCAP_REGISTER_SIZE  4
> > > >  #define CPCAP_REGISTER_BITS  16
> > > >
> > > > +struct cpcap_chip_data {
> > > > +     const struct mfd_cell *mfd_devices;
> > > > +     unsigned int num_devices;
> > > > +};
> > >
> > > This is a red flag.
> > >
> > > >  struct cpcap_ddata {
> > > >       struct spi_device *spi;
> > > >       struct regmap_irq *irqs;
> > > >       struct regmap_irq_chip_data *irqdata[CPCAP_NR_IRQ_CHIPS];
> > > > +     const struct cpcap_chip_data *cdata;
> > > >       const struct regmap_config *regmap_conf;
> > > >       struct regmap *regmap;
> > > >  };
> > > > @@ -195,20 +202,6 @@ static int cpcap_init_irq(struct cpcap_ddata *=
cpcap)
> > > >       return 0;
> > > >  }
> > > >
> > > > -static const struct of_device_id cpcap_of_match[] =3D {
> > > > -     { .compatible =3D "motorola,cpcap", },
> > > > -     { .compatible =3D "st,6556002", },
> > > > -     {},
> > > > -};
> > > > -MODULE_DEVICE_TABLE(of, cpcap_of_match);
> > > > -
> > > > -static const struct spi_device_id cpcap_spi_ids[] =3D {
> > > > -     { .name =3D "cpcap", },
> > > > -     { .name =3D "6556002", },
> > > > -     {},
> > > > -};
> > > > -MODULE_DEVICE_TABLE(spi, cpcap_spi_ids);
> > > > -
> > > >  static const struct regmap_config cpcap_regmap_config =3D {
> > > >       .reg_bits =3D 16,
> > > >       .reg_stride =3D 4,
> > > > @@ -241,7 +234,56 @@ static int cpcap_resume(struct device *dev)
> > > >
> > > >  static DEFINE_SIMPLE_DEV_PM_OPS(cpcap_pm, cpcap_suspend, cpcap_res=
ume);
> > > >
> > > > -static const struct mfd_cell cpcap_mfd_devices[] =3D {
> > > > +static const struct mfd_cell cpcap_default_mfd_devices[] =3D {
> > > > +     {
> > > > +             .name          =3D "cpcap_adc",
> > > > +             .of_compatible =3D "motorola,cpcap-adc",
> > > > +     }, {
> > > > +             .name          =3D "cpcap_battery",
> > > > +             .of_compatible =3D "motorola,cpcap-battery",
> > > > +     }, {
> > > > +             .name          =3D "cpcap-regulator",
> > > > +             .of_compatible =3D "motorola,cpcap-regulator",
> > > > +     }, {
> > > > +             .name          =3D "cpcap-rtc",
> > > > +             .of_compatible =3D "motorola,cpcap-rtc",
> > > > +     }, {
> > > > +             .name          =3D "cpcap-pwrbutton",
> > > > +             .of_compatible =3D "motorola,cpcap-pwrbutton",
> > > > +     }, {
> > > > +             .name          =3D "cpcap-usb-phy",
> > > > +             .of_compatible =3D "motorola,cpcap-usb-phy",
> > > > +     }, {
> > > > +             .name          =3D "cpcap-led",
> > > > +             .id            =3D 0,
> > > > +             .of_compatible =3D "motorola,cpcap-led-red",
> > > > +     }, {
> > > > +             .name          =3D "cpcap-led",
> > > > +             .id            =3D 1,
> > > > +             .of_compatible =3D "motorola,cpcap-led-green",
> > > > +     }, {
> > > > +             .name          =3D "cpcap-led",
> > > > +             .id            =3D 2,
> > > > +             .of_compatible =3D "motorola,cpcap-led-blue",
> > > > +     }, {
> > > > +             .name          =3D "cpcap-led",
> > > > +             .id            =3D 3,
> > > > +             .of_compatible =3D "motorola,cpcap-led-adl",
> > > > +     }, {
> > > > +             .name          =3D "cpcap-led",
> > > > +             .id            =3D 4,
> > > > +             .of_compatible =3D "motorola,cpcap-led-cp",
> > > > +     }, {
> > > > +             .name          =3D "cpcap-codec",
> > > > +     },
> > > > +};
> > > > +
> > > > +static const struct cpcap_chip_data cpcap_default_data =3D {
> > > > +     .mfd_devices =3D cpcap_default_mfd_devices,
> > > > +     .num_devices =3D ARRAY_SIZE(cpcap_default_mfd_devices),
> > > > +};
> > > > +
> > > > +static const struct mfd_cell cpcap_mapphone_mfd_devices[] =3D {
> > > >       {
> > > >               .name          =3D "cpcap_adc",
> > > >               .of_compatible =3D "motorola,mapphone-cpcap-adc",
> > > > @@ -285,7 +327,12 @@ static const struct mfd_cell cpcap_mfd_devices=
[] =3D {
> > > >               .of_compatible =3D "motorola,cpcap-led-cp",
> > > >       }, {
> > > >               .name          =3D "cpcap-codec",
> > > > -     }
> > > > +     },
> > > > +};
> > > > +
> > > > +static const struct cpcap_chip_data cpcap_mapphone_data =3D {
> > > > +     .mfd_devices =3D cpcap_mapphone_mfd_devices,
> > > > +     .num_devices =3D ARRAY_SIZE(cpcap_mapphone_mfd_devices),
> > > >  };
> > > >
> > > >  static int cpcap_probe(struct spi_device *spi)
> > > > @@ -297,9 +344,17 @@ static int cpcap_probe(struct spi_device *spi)
> > > >       if (!cpcap)
> > > >               return -ENOMEM;
> > > >
> > > > +     cpcap->cdata =3D device_get_match_data(&spi->dev);
> > > > +     if (!cpcap->cdata)
> > > > +             return -ENODEV;
> > > > +
> > > >       cpcap->spi =3D spi;
> > > >       spi_set_drvdata(spi, cpcap);
> > > >
> > > > @@ -331,16 +382,24 @@ static int cpcap_probe(struct spi_device *spi=
)
> > > >       spi->dev.coherent_dma_mask =3D 0;
> > > >       spi->dev.dma_mask =3D &spi->dev.coherent_dma_mask;
> > > >
> > > > -     return devm_mfd_add_devices(&spi->dev, 0, cpcap_mfd_devices,
> > > > -                                 ARRAY_SIZE(cpcap_mfd_devices), NU=
LL, 0, NULL);
> > > > +     return devm_mfd_add_devices(&spi->dev, 0, cpcap->cdata->mfd_d=
evices,
> > > > +                                 cpcap->cdata->num_devices, NULL, =
0, NULL);
> > > >  }
> > > >
> > > > +static const struct of_device_id cpcap_of_match[] =3D {
> > > > +     { .compatible =3D "motorola,cpcap", .data =3D &cpcap_default_=
data },
> > > > +     { .compatible =3D "motorola,mapphone-cpcap", .data =3D &cpcap=
_mapphone_data },
> > >
> > > We don't allow data from one device registration API (MFD) to be pass=
ed
> > > through another (OF) because it tends to lead to all sorts of "creati=
ve
> > > solutions".  Pass a value instead and match on that in a switch()
> > > statement like all of the other MFD drivers do.
> > >
> >
> > You don't allow this. I have not seen this enforced anywhere in the
> > kernel except the mfd subsystem. Fine, does not matter, if this makes
> > you happy I will adjust.
>
> Where else would this rule be applicable?  I can't think of anywhere.
>

I have adjusted as you requested and already sent v5.

> --
> Lee Jones
