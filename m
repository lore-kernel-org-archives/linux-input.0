Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71174218B5
	for <linux-input@vger.kernel.org>; Thu,  7 May 2026 14:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164939; cv=pass; b=YceUQbrXxPWe1y4r+DNYWKxtIM7SVq5MQgqWGesy16gnn1FhgDdac62QNd2uBlUEReosoUdVMugS3zuFAJ0lrd4lbwbw0lvcm3RJXlglmWkS4mIpLdmsyJH4BkUlJSNtwujYBkVkyzzCg/snJbKAXQBTN/GUi8ndz4KnDvPEOJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164939; c=relaxed/simple;
	bh=QE7XruwSEiu7pgFmsBJ0QOzj6pZbNDale0S5vZ2ZTZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXjTYK0PmkbZmoPx9jMAsGv/A842yWqI510nbCG9fQn4UjxO2TvdN4i79p5NSy9JmyZEhnrd/2C0neGBqITgiCjwjCTjDYUf5Ui8V74d4umIWeyuVvtNzqyrS8Pcw+Ofw33DE6VaQuxlFhofvv2tivrhoXuPY2bHF4DN+Qul/d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pylNWjxF; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pylNWjxF"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so2339743eec.0
        for <linux-input@vger.kernel.org>; Thu, 07 May 2026 07:42:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778164935; cv=none;
        d=google.com; s=arc-20240605;
        b=ZkeWz/W/CGJqcoAqghLfML9LJH8TTKrTvmSyBuL1BrbMgQs17pIKi4BcNKDLghJOwA
         oZ64it3ks1KbVn4pJc0Y21fM6rQUthUjtrU3s1aWGWe6sjSFlKsZxhLfqvd9o8AEBCU3
         yJCC6oJJIIuFDZfj0S8BIIZZ96ZOgAKpMog9rpUEHuVwY2cefWrdym9qGeXRs35I+Ux7
         XI3+J0oHIdRRZuTaCduMxXWkPw5uVEhvhE9JfmTEVncGv1xlKRTmX7HqRFb22em0wCLG
         BvHbrkh1+ar1dPwLD+7ieLNwcnIXjsezqR/gbvj4Gpbn+Eq4l+fqCb0nxtpzLiR/ZnJj
         Gpng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jT3O6et3NT1mqwSybd/qwkVNrO5VzBYtbQaOosZiYdY=;
        fh=QJ6ald1K2Ud3P3DC8B72+nAVwjxL6Jx2r//p/HAHS6g=;
        b=VRrdO1MMCqgT6M1kFp8pD2KEjjXnUsGDPdHowNzP05obM9LMF7sTwfy+1IKJUrZx91
         mJw39j3jQCOpsC+cuL3LljVjV3y+qA1ceve4VHgpD2cv/wcJYVOg2ARr/jOzNkXTVayq
         378saUFy6TvKowDBQ8sE+EFx0KRdFqT1EVaC1ln6W735VzLizepwkVW/N+lCxvmHRpJf
         Lh29WCKjqQGpnrKrElaZJ0sAD8Ay2OipqDcwV+62eB1oiOJccZA/FynE3Zo8uB9Es6RH
         Lk0YvAnNT2nkQW4UfBubWmfpZxQXhVA+y0kHN3/Jh8fTCYh6D+m1wsB3/JafQB72CEZP
         5ATg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778164935; x=1778769735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jT3O6et3NT1mqwSybd/qwkVNrO5VzBYtbQaOosZiYdY=;
        b=pylNWjxFajgQnLuvpice8FN420rhIT/CXDD14B8nn+yFWMnVQLTlR0MuUK0EaqA1ua
         XftwjRPTNQHYkROo2AhuYoikxyZuJpby8vf1xPUxk1wc/PFI5dJue1Ao/REeG01/5gxL
         oLT1P6RRZIhgiHJ8UIo3V5fUSHyLYf1fQuG960lrXLnK5/5ZkRY1hSjuLuoEKW4WBU5H
         KNjo5jf1QZIsH+FlsF/Q9xFzOdukw+aSsQChSwtpu8oeQW2kt38wamn3X1zC7w0A2srI
         WDpcTlRqCZtO0DqJexvqOFdUTpejrcPy69kEPbUEgAGKKYJ7yFVUI+6XE03V14XRdBP3
         rJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778164935; x=1778769735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jT3O6et3NT1mqwSybd/qwkVNrO5VzBYtbQaOosZiYdY=;
        b=giXbhyWJrOBUsUS/PXin9krD/xe/BQJwHxWu83DbJMVWgUVaGTV52DXHkQ7EOjrZvs
         xqu3C3KsK92gvQ94NeMQt4K6PV1ulQwGWBCI6SCUF4Dg8H5+7L411GDIWe+M7u4F7yYw
         oTYJCJ6/jrj+dbdW1TI9DRZiHcxtjWyDHcGrASlWsfL6fjE59mf/6fvVaQvUvWiMDTid
         kl0YRXYuwqrEK75E73egR32Nh8L8nc82Vfus3haUuwQujBrX8IqLXCRXFzBzfh9u6Lx/
         m/Lb6XqvGe1tW2HjeShNIkpxmYrPTNpgQPcDNLxxf/2OP/blQB8xheICN3YwjhENp8Cz
         aW2Q==
X-Forwarded-Encrypted: i=1; AFNElJ9wGXQoykciGnYzj/y4W+Z2RvD0ASMP/K3TUJdjG28XlMgMe3zHMByejYJ0B75tZdQb4y/HTILDMMa8gg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx8ZW3cKVprTK4NMjrOJRTVs3MOcFnFe/XXhtuEiygQqrKUITd
	gC/OnfHoaskrmM/F2BWG6XXTEc2ognes2w6wwb7PvK35h3fVa5oKWjrN7TUhDau5qy3Gu95j77L
	yUarTmm/hkQz8PAtjwmKX9R/6LGJlvIs=
X-Gm-Gg: AeBDiesPOSiwUWdQ+1VJJgHzToVQMo8jI8kEwIayk/4jlXt+0vlmj1bqyFvrASF0LPF
	xlM5RUwqeuBnrzpkE7hSOv4ZymSigvVWZ/86yRIINjdHYQqBrW10MmAnfrTHsFl2n+FiB5k2MVc
	PiVpmsmQK0Apx18zhYb7x2vIABG2cr6kUwXRrO69fcS36gxmS1k6xnH/AlgUKqL9EGxtLA71158
	yk0TrXnJAplhsSd1toLHFEojmg3nkFdiaRNhX47I4dEaj6NvMsmW4LfuSCKm77iVhkYXvpShnzq
	n961/XtFTE7mwZ2mefA=
X-Received: by 2002:a05:693c:2411:b0:2f6:811e:c840 with SMTP id
 5a478bee46e88-2f6811ecdc7mr1706481eec.18.1778164935381; Thu, 07 May 2026
 07:42:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428153611.142816-1-clamor95@gmail.com> <20260428153611.142816-6-clamor95@gmail.com>
 <20260507140519.GO305027@google.com>
In-Reply-To: <20260507140519.GO305027@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 7 May 2026 17:42:03 +0300
X-Gm-Features: AVHnY4JhuQbLfhGWuOYGbOyhNdM9uIu0BiU5APMsX46gUxzYP5nSTtoAi9DOTZo
Message-ID: <CAPVz0n24U3=hwda5BTXUhHiiFHKmWUfLy_nxJp_CFHBHEYDWsA@mail.gmail.com>
Subject: Re: [PATCH v4 5/6 RESEND] mfd: motorola-cpcap: diverge configuration per-board
To: Lee Jones <lee@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Tony Lindgren <tony@atomide.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 7 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 17:05=
 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, 28 Apr 2026, Svyatoslav Ryhel wrote:
>
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
> >
> > Removed st,6556002 as it is no longer applicable to all cases and
> > duplicates motorola,cpcap, which is used as the default composition.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
>
> Changelog?
>
> >  drivers/mfd/motorola-cpcap.c | 101 ++++++++++++++++++++++++++++-------
> >  1 file changed, 83 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.=
c
> > index d8243b956f87..516d1e33affa 100644
> > --- a/drivers/mfd/motorola-cpcap.c
> > +++ b/drivers/mfd/motorola-cpcap.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/mod_devicetable.h>
> > +#include <linux/property.h>
> >  #include <linux/regmap.h>
> >  #include <linux/sysfs.h>
> >
> > @@ -24,10 +25,16 @@
> >  #define CPCAP_REGISTER_SIZE  4
> >  #define CPCAP_REGISTER_BITS  16
> >
> > +struct cpcap_chip_data {
> > +     const struct mfd_cell *mfd_devices;
> > +     unsigned int num_devices;
> > +};
>
> This is a red flag.
>
> >  struct cpcap_ddata {
> >       struct spi_device *spi;
> >       struct regmap_irq *irqs;
> >       struct regmap_irq_chip_data *irqdata[CPCAP_NR_IRQ_CHIPS];
> > +     const struct cpcap_chip_data *cdata;
> >       const struct regmap_config *regmap_conf;
> >       struct regmap *regmap;
> >  };
> > @@ -195,20 +202,6 @@ static int cpcap_init_irq(struct cpcap_ddata *cpca=
p)
> >       return 0;
> >  }
> >
> > -static const struct of_device_id cpcap_of_match[] =3D {
> > -     { .compatible =3D "motorola,cpcap", },
> > -     { .compatible =3D "st,6556002", },
> > -     {},
> > -};
> > -MODULE_DEVICE_TABLE(of, cpcap_of_match);
> > -
> > -static const struct spi_device_id cpcap_spi_ids[] =3D {
> > -     { .name =3D "cpcap", },
> > -     { .name =3D "6556002", },
> > -     {},
> > -};
> > -MODULE_DEVICE_TABLE(spi, cpcap_spi_ids);
> > -
> >  static const struct regmap_config cpcap_regmap_config =3D {
> >       .reg_bits =3D 16,
> >       .reg_stride =3D 4,
> > @@ -241,7 +234,56 @@ static int cpcap_resume(struct device *dev)
> >
> >  static DEFINE_SIMPLE_DEV_PM_OPS(cpcap_pm, cpcap_suspend, cpcap_resume)=
;
> >
> > -static const struct mfd_cell cpcap_mfd_devices[] =3D {
> > +static const struct mfd_cell cpcap_default_mfd_devices[] =3D {
> > +     {
> > +             .name          =3D "cpcap_adc",
> > +             .of_compatible =3D "motorola,cpcap-adc",
> > +     }, {
> > +             .name          =3D "cpcap_battery",
> > +             .of_compatible =3D "motorola,cpcap-battery",
> > +     }, {
> > +             .name          =3D "cpcap-regulator",
> > +             .of_compatible =3D "motorola,cpcap-regulator",
> > +     }, {
> > +             .name          =3D "cpcap-rtc",
> > +             .of_compatible =3D "motorola,cpcap-rtc",
> > +     }, {
> > +             .name          =3D "cpcap-pwrbutton",
> > +             .of_compatible =3D "motorola,cpcap-pwrbutton",
> > +     }, {
> > +             .name          =3D "cpcap-usb-phy",
> > +             .of_compatible =3D "motorola,cpcap-usb-phy",
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
> > +     }, {
> > +             .name          =3D "cpcap-led",
> > +             .id            =3D 4,
> > +             .of_compatible =3D "motorola,cpcap-led-cp",
> > +     }, {
> > +             .name          =3D "cpcap-codec",
> > +     },
> > +};

Lee, would you mind if I convert these mfd_cell structures to use
macros in this commit since I am refactoring them anyway?

> > +
> > +static const struct cpcap_chip_data cpcap_default_data =3D {
> > +     .mfd_devices =3D cpcap_default_mfd_devices,
> > +     .num_devices =3D ARRAY_SIZE(cpcap_default_mfd_devices),
> > +};
> > +
> > +static const struct mfd_cell cpcap_mapphone_mfd_devices[] =3D {
> >       {
> >               .name          =3D "cpcap_adc",
> >               .of_compatible =3D "motorola,mapphone-cpcap-adc",
> > @@ -285,7 +327,12 @@ static const struct mfd_cell cpcap_mfd_devices[] =
=3D {
> >               .of_compatible =3D "motorola,cpcap-led-cp",
> >       }, {
> >               .name          =3D "cpcap-codec",
> > -     }
> > +     },
> > +};
> > +
> > +static const struct cpcap_chip_data cpcap_mapphone_data =3D {
> > +     .mfd_devices =3D cpcap_mapphone_mfd_devices,
> > +     .num_devices =3D ARRAY_SIZE(cpcap_mapphone_mfd_devices),
> >  };
> >
> >  static int cpcap_probe(struct spi_device *spi)
> > @@ -297,9 +344,17 @@ static int cpcap_probe(struct spi_device *spi)
> >       if (!cpcap)
> >               return -ENOMEM;
> >
> > +     cpcap->cdata =3D device_get_match_data(&spi->dev);
> > +     if (!cpcap->cdata)
> > +             return -ENODEV;
> > +
> >       cpcap->spi =3D spi;
> >       spi_set_drvdata(spi, cpcap);
> >
> > @@ -331,16 +382,24 @@ static int cpcap_probe(struct spi_device *spi)
> >       spi->dev.coherent_dma_mask =3D 0;
> >       spi->dev.dma_mask =3D &spi->dev.coherent_dma_mask;
> >
> > -     return devm_mfd_add_devices(&spi->dev, 0, cpcap_mfd_devices,
> > -                                 ARRAY_SIZE(cpcap_mfd_devices), NULL, =
0, NULL);
> > +     return devm_mfd_add_devices(&spi->dev, 0, cpcap->cdata->mfd_devic=
es,
> > +                                 cpcap->cdata->num_devices, NULL, 0, N=
ULL);
> >  }
> >
> > +static const struct of_device_id cpcap_of_match[] =3D {
> > +     { .compatible =3D "motorola,cpcap", .data =3D &cpcap_default_data=
 },
> > +     { .compatible =3D "motorola,mapphone-cpcap", .data =3D &cpcap_map=
phone_data },
>
> We don't allow data from one device registration API (MFD) to be passed
> through another (OF) because it tends to lead to all sorts of "creative
> solutions".  Pass a value instead and match on that in a switch()
> statement like all of the other MFD drivers do.
>
> > +     { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, cpcap_of_match);
> > +
> > +static const struct spi_device_id cpcap_spi_ids[] =3D {
> > +     { .name =3D "cpcap", .driver_data =3D (kernel_ulong_t)&cpcap_defa=
ult_data },
> > +     { .name =3D "mapphone-cpcap", .driver_data =3D (kernel_ulong_t)&c=
pcap_mapphone_data },
> > +     { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(spi, cpcap_spi_ids);
> > +
> >  static struct spi_driver cpcap_driver =3D {
> >       .driver =3D {
> >               .name =3D "cpcap-core",
> > --
> > 2.51.0
> >
> >
>
> --
> Lee Jones
