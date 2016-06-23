From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 3/4] input: touchscreen: mxs-lradc: Add support for
 touchscreen
Date: Thu, 23 Jun 2016 10:24:03 -0700
Message-ID: <20160623172403.GF32561@dtor-ws>
References: <cover.1465396835.git.ksenija.stanojevic@gmail.com>
 <d5853a762d67f2036382d3cfa0cf1d294d6aa5f0.1465396835.git.ksenija.stanojevic@gmail.com>
 <1443695961.58810.3de61248-4cae-4f94-b8a2-ef63c5c3ec1b.open-xchange@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33348 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbcFWRYG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jun 2016 13:24:06 -0400
Content-Disposition: inline
In-Reply-To: <1443695961.58810.3de61248-4cae-4f94-b8a2-ef63c5c3ec1b.open-xchange@email.1und1.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-input@vger.kernel.org, pmeerw@pmeerw.net, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, harald@ccbib.org, fabio.estevam@freescale.com, linux-iio@vger.kernel.org, marex@denx.de

On Wed, Jun 15, 2016 at 11:26:18PM +0200, Stefan Wahren wrote:
> Hi,
> 
> unfortunately i still don't have a touchscreen to test this patch.
> 
> > Ksenija Stanojevic <ksenija.stanojevic@gmail.com> hat am 8. Juni 2016 um 16:48
> > geschrieben:
> > 
> > 
> > Add 4-wire/5-wire touchscreen controller.
> > 
> > Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
> > ---
> > Changes in v2:
> >  - do not change spacing in Kconfig
> >  - remove dev.parent
> >  - rename err_ts_register to error
> >  - combine functions hw_stop and disable_ts so that mxs_lradc_ts_remove
> >    could be deleted.
> >  - add spinlock in struct mxs_lradc_ts to enable locking in interrupt handler.
> >  - only grab irqs that are relevant to touchscreen
> >  - use direct return instead assigning error to touch_ret in probe function.
> >  - change licence to GPL
> >  - add copyright
> > 
> >  drivers/input/touchscreen/Kconfig        |  10 +
> >  drivers/input/touchscreen/Makefile       |   1 +
> >  drivers/input/touchscreen/mxs-lradc-ts.c | 726
> > +++++++++++++++++++++++++++++++
> >  3 files changed, 737 insertions(+)
> >  create mode 100644 drivers/input/touchscreen/mxs-lradc-ts.c
> > 
> > diff --git a/drivers/input/touchscreen/mxs-lradc-ts.c
> > b/drivers/input/touchscreen/mxs-lradc-ts.c
> > new file mode 100644
> > index 0000000..778bb61
> > --- /dev/null
> > +++ b/drivers/input/touchscreen/mxs-lradc-ts.c
> > @@ -0,0 +1,726 @@
> > +/*
> > + * Freescale MXS LRADC driver
> 
> touchscreen driver
> 
> > + *
> > + * Copyright (c) 2012 DENX Software Engineering, GmbH.
> > + * Marek Vasut <marex@denx.de>
> > + * Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > ...
> > +
> > +static struct platform_driver mxs_lradc_ts_driver = {
> > +	.driver	= {
> > +		.name = DRIVER_NAME_TS,
> > +	},
> > +	.probe	= mxs_lradc_ts_probe,
> > +};
> > +module_platform_driver(mxs_lradc_ts_driver);
> > +
> 
> MODULE_DESCRIPTION ?
> MODULE_AUTHOR ?

Once Stefan's comments addressed please add

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

so that it can be merged through MFD tree.

> 
> > +MODULE_LICENSE("GPL");
> > -- 
> > 1.9.1
> >

Thanks.

-- 
Dmitry
