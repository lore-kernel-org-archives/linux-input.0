From: =?UTF-8?Q?Ksenija_Stanojevi=C4=87?= <ksenija.stanojevic@gmail.com>
Subject: Re: [PATCH v9 1/5] mfd: mxs-lradc: Add support for mxs-lradc MFD
Date: Mon, 14 Nov 2016 19:41:44 +0100
Message-ID: <CAL7P5jK1cCZyELUhv61ySpFH4EAaVwUaNXWd5xcmwiHsT_3Ssw@mail.gmail.com>
References: <cover.1478071676.git.ksenija.stanojevic@gmail.com>
 <c18883dfacaaf40ab98cbb4938d5164a95a817d7.1478071676.git.ksenija.stanojevic@gmail.com>
 <1401051818.290769.fabb549c-29f9-4e5c-a868-650c6df97a1d.open-xchange@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1401051818.290769.fabb549c-29f9-4e5c-a868-650c6df97a1d.open-xchange@email.1und1.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Harald Geyer <harald@ccbib.org>, Fabio Estevam <fabio.estevam@freescale.com>, linux-iio@vger.kernel.org, Marek Vasut <marex@denx.de>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,

On Tue, Nov 8, 2016 at 11:34 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
> > Ksenija Stanojevic <ksenija.stanojevic@gmail.com> hat am 2. November 2016 um
> > 08:38 geschrieben:
> >
> >
> > Add core files for low resolution analog-to-digital converter (mxs-lradc)
> > MFD driver.
> >
> > Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
>
> Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
>
> for Patch 1 + 2
>
> > ---
> > ...
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index 9834e66..057ca15 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -211,3 +211,4 @@ obj-$(CONFIG_INTEL_SOC_PMIC)      += intel-soc-pmic.o
> >  obj-$(CONFIG_MFD_MT6397)     += mt6397-core.o
> >
> >  obj-$(CONFIG_MFD_ALTERA_A10SR)       += altera-a10sr.o
> > +obj-$(CONFIG_MFD_MXS_LRADC)     += mxs-lradc.o
>
> Btw this part won't apply anymore

I think now everyone is approving of this patch series.
Who will take this patch series, Jonathan or Lee?
Should I resend patches?

Thanks,
Ksenija
