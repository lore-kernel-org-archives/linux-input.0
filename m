From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 1/4] mfd: mxs-lradc: Add support for mxs-lradc MFD
Date: Thu, 4 Aug 2016 09:31:36 +0100
Message-ID: <20160804083136.GE5243@dell>
References: <cover.1466769907.git.ksenija.stanojevic@gmail.com>
 <370a02584386944b465deff5ccc48c8919b23dba.1466769907.git.ksenija.stanojevic@gmail.com>
 <20160628162834.GF29166@dell>
 <CAL7P5j+NYvUJfu==xQvncyCiw8JHtizOdfyeY1HL6Lb=-wsrWQ@mail.gmail.com>
 <E1bIyD4-0000Jw-2c@stardust.g4.wien.funkfeuer.at>
 <20160713124935.GC11154@dell>
 <5bddd461-90e3-3116-8d18-fae51bf39310@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:33217 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754825AbcHDIaO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Aug 2016 04:30:14 -0400
Received: by mail-wm0-f41.google.com with SMTP id p129so1290388wmp.0
        for <linux-input@vger.kernel.org>; Thu, 04 Aug 2016 01:30:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5bddd461-90e3-3116-8d18-fae51bf39310@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: Harald Geyer <harald@ccbib.org>, Ksenija =?utf-8?Q?Stanojevi=C4=87?= <ksenija.stanojevic@gmail.com>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>, Fabio Estevam <fabio.estevam@freescale.com>

On Thu, 14 Jul 2016, Marek Vasut wrote:

> On 07/13/2016 02:49 PM, Lee Jones wrote:
> > On Fri, 01 Jul 2016, Harald Geyer wrote:
> > 
> > > Hi Ksenija!
> > > 
> > > Ksenija Stanojević writes:
> > > > On Tue, Jun 28, 2016 at 6:28 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > > > > > +static int mxs_lradc_add_device(struct platform_device *pdev,
> > > > > > +                             struct mxs_lradc *lradc, char *name, int i)
> > > > > > +{
> > > > > > +     struct mfd_cell *cell;
> > > > > > +
> > > > > > +     cell = &lradc->cells[i];
> > > > > > +     cell->name = name;
> > > > > > +     cell->platform_data = lradc;
> > > > > > +     cell->pdata_size = sizeof(*lradc);
> > > > > > +
> > > > > > +     return devm_mfd_add_devices(&pdev->dev, -1, cell, 1, NULL, 0, NULL);
> > > > > > +}
> > > > > 
> > > > > Please don't roll your own API.
> > > > > 
> > > > > Use 'struct mfd_cell' like everyone else does.
> > > > 
> > > > It has been suggested in previous reviews to use separate function to
> > > > register mfd device, and to make mfd_cell allocate dynamically because
> > > > struc mxs-lradc is allocated dynamically.
> > > > But I can revrse changes and make mfd_cells allocate staticaly
> > > > wthout separate function.
> > > 
> > > I think making mfd_cells members of struct mxs-lradc will address all
> > > review comments.
> > 
> > No, please don't do that either.
> > 
> It'd be nice if you explained in detail why not. Otherwise this is just
> empty splat.

I already said what needs to be done.

"Use struct mfd_cell", in it's pure/static form.  Don't include it in
any device data struct.

"like everyone else does", look at other driver to see how they do
it.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
