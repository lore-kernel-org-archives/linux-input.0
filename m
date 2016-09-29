From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 1/4] mfd: mxs-lradc: Add support for mxs-lradc MFD
Date: Thu, 29 Sep 2016 01:00:17 +0100
Message-ID: <20160929000016.GS21388@dell>
References: <cover.1471524593.git.ksenija.stanojevic@gmail.com>
 <f968582fe3036a2967ed41494c73c43ac19e4767.1471524593.git.ksenija.stanojevic@gmail.com>
 <20160831120552.GF8649@dell>
 <CAL7P5jKx4S-cduxTmNzocD0VrkgzK4vQ+w6G__sWOJMNsoJhCA@mail.gmail.com>
 <20160927185000.GF21388@dell>
 <66EF5E82-AE82-4F05-A67F-2F27F798F30E@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <66EF5E82-AE82-4F05-A67F-2F27F798F30E-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ksenija =?utf-8?Q?Stanojevi=C4=87?= <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Marek =?utf-8?B?VmHFoXV0?= <marex-ynQEQJNshbs@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harald Geyer <harald-95f8Dae0BrPYtjvyW6yDsg@public.gmane.org>, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, 27 Sep 2016, Dmitry Torokhov wrote:

> On September 27, 2016 11:50:00 AM PDT, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> >On Sat, 17 Sep 2016, Ksenija Stanojević wrote:
> >> On Wed, Aug 31, 2016 at 2:05 PM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >wrote:
> >> > On Thu, 18 Aug 2016, Ksenija Stanojevic wrote:
> >> >
> >> > > Add core files for mxs-lradc MFD driver.
> >> > >
> >> > > Note:  this patch won't compile in iio/testing without this
> >patch:
> >> > > a8f447be8056 ("mfd: Add resource managed APIs for
> >mfd_add_devices")
> >> > >
> >> > > Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> > > ---
> >> > > Changes in v5:
> >> > >  - use DEFINE_RES_MEM
> >> > >  - don't pass ioreammaped adress to platform cells
> >> > >  - move comment outside of struct mxs_lradc
> >> > >  - change type of argument in mxs_lradc_reg_set,
> >mxs_lradc_reg_clear,
> >> > >    mxs_lradc_reg_wrt (struct mxs_lradc * -> void __iomem *)
> >> > >
> >> > > Changes in v4:
> >> > >  - update copyright
> >> > >  - use DEFINE_RES_IRQ_NAMED
> >> > >  - remove mxs_lradc_add_device function
> >> > >  - use struct mfd_cell in static form
> >> > >  - improve spacing
> >> > >  - remove unnecessary comment
> >> > >  - remove platform_get_irq
> >> > >  - remove touch_ret and use ret instead
> >> > >  - rename use_touchscreen to touchscreen_wire
> >> > >  - use goto statements
> >> > >  - remove irq[13], irq_count and irq_name from struct mxs_lradc
> >> > >  - remove all defines from inside the struct definition
> >> > >
> >> > > Changes in v3:
> >> > >  - add note to commit message
> >> > >  - move switch statement into if(touch_ret == 0) branch
> >> > >  - add MODULE_AUTHOR
> >> > >
> >> > > Changes in v2:
> >> > >  - do not change spacing in Kconfig
> >> > >  - make struct mfd_cell part of struct mxs_lradc
> >> > >  - use switch instead of if in mxs_lradc_irq_mask
> >> > >  - use only necessary header files in mxs_lradc.h
> >> > >  - use devm_mfd_add_device
> >> > >  - use separate function to register mfd device
> >> > >  - change licence to GPL
> >> > >  - add copyright
> >> > >
> >> > >  drivers/mfd/Kconfig           |  17 +++
> >> > >  drivers/mfd/Makefile          |   1 +
> >> > >  drivers/mfd/mxs-lradc.c       | 255
> >++++++++++++++++++++++++++++++++++++++++++
> >> > >  include/linux/mfd/mxs-lradc.h | 194
> >++++++++++++++++++++++++++++++++
> >> > >  4 files changed, 467 insertions(+)
> >> > >  create mode 100644 drivers/mfd/mxs-lradc.c
> >> > >  create mode 100644 include/linux/mfd/mxs-lradc.h
> >
> >[...]
> >
> >> > > +static int mxs_lradc_probe(struct platform_device *pdev)
> >> > > +{
> >> > > +     const struct of_device_id *of_id;
> >> > > +     struct device *dev = &pdev->dev;
> >> > > +     struct device_node *node = dev->of_node;
> >> > > +     struct mxs_lradc *lradc;
> >> > > +     struct mfd_cell *cells = NULL;
> >> > > +     int ret = 0;
> >> > > +     u32 ts_wires = 0;
> >> > > +
> >> > > +     lradc = devm_kzalloc(&pdev->dev, sizeof(*lradc),
> >GFP_KERNEL);
> >> > > +     if (!lradc)
> >> > > +             return -ENOMEM;
> >> > > +
> >> > > +     of_id = of_match_device(mxs_lradc_dt_ids, &pdev->dev);
> >> > > +     lradc->soc = (enum mxs_lradc_id)of_id->data;
> >> >
> >> > Unnecessary cast.
> >> 
> >> If I remove the cast I get this error:
> >> drivers/mfd/mxs-lradc.c:148:13: error: incompatible types when
> >> assigning to type ‘enum mxs_lradc_id’ from type ‘const void * const’
> >
> >Ah, because it's a const.  Fair enough.
> 
> No, it's because void * has to be cast to a non-pointer data type explicitly.

You're right.  My bad!  I was getting confused by the fact that you
don't need to cast when you allocate a value *to* a void *.  Senior
moment, please ignore!

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
