From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v9 1/5] mfd: mxs-lradc: Add support for mxs-lradc MFD
Date: Tue, 15 Nov 2016 10:26:08 +0000
Message-ID: <20161115102608.GE4094@dell>
References: <cover.1478071676.git.ksenija.stanojevic@gmail.com>
 <c18883dfacaaf40ab98cbb4938d5164a95a817d7.1478071676.git.ksenija.stanojevic@gmail.com>
 <1401051818.290769.fabb549c-29f9-4e5c-a868-650c6df97a1d.open-xchange@email.1und1.de>
 <CAL7P5jK1cCZyELUhv61ySpFH4EAaVwUaNXWd5xcmwiHsT_3Ssw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38528 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966682AbcKOKXO (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 15 Nov 2016 05:23:14 -0500
Received: by mail-wm0-f49.google.com with SMTP id f82so158910359wmf.1
        for <linux-input@vger.kernel.org>; Tue, 15 Nov 2016 02:23:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAL7P5jK1cCZyELUhv61ySpFH4EAaVwUaNXWd5xcmwiHsT_3Ssw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ksenija =?utf-8?Q?Stanojevi=C4=87?= <ksenija.stanojevic@gmail.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, linux-input@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Harald Geyer <harald@ccbib.org>, Fabio Estevam <fabio.estevam@freescale.com>, linux-iio@vger.kernel.org, Marek Vasut <marex@denx.de>, linux-kernel <linux-kernel@vger.kernel.org>

On Mon, 14 Nov 2016, Ksenija Stanojević wrote:

> Hi,
> 
> On Tue, Nov 8, 2016 at 11:34 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> >
> > > Ksenija Stanojevic <ksenija.stanojevic@gmail.com> hat am 2. November 2016 um
> > > 08:38 geschrieben:
> > >
> > >
> > > Add core files for low resolution analog-to-digital converter (mxs-lradc)
> > > MFD driver.
> > >
> > > Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
> >
> > Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
> >
> > for Patch 1 + 2
> >
> > > ---
> > > ...
> > > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > > index 9834e66..057ca15 100644
> > > --- a/drivers/mfd/Makefile
> > > +++ b/drivers/mfd/Makefile
> > > @@ -211,3 +211,4 @@ obj-$(CONFIG_INTEL_SOC_PMIC)      += intel-soc-pmic.o
> > >  obj-$(CONFIG_MFD_MT6397)     += mt6397-core.o
> > >
> > >  obj-$(CONFIG_MFD_ALTERA_A10SR)       += altera-a10sr.o
> > > +obj-$(CONFIG_MFD_MXS_LRADC)     += mxs-lradc.o
> >
> > Btw this part won't apply anymore
> 
> I think now everyone is approving of this patch series.
> Who will take this patch series, Jonathan or Lee?
> Should I resend patches?

Send patch-set again with all the Acks you've collected.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
