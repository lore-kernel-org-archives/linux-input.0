From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 1/4] mfd: mxs-lradc: Add support for mxs-lradc MFD
Date: Tue, 27 Sep 2016 19:07:51 -0700
Message-ID: <66EF5E82-AE82-4F05-A67F-2F27F798F30E@gmail.com>
References: <cover.1471524593.git.ksenija.stanojevic@gmail.com> <f968582fe3036a2967ed41494c73c43ac19e4767.1471524593.git.ksenija.stanojevic@gmail.com> <20160831120552.GF8649@dell> <CAL7P5jKx4S-cduxTmNzocD0VrkgzK4vQ+w6G__sWOJMNsoJhCA@mail.gmail.com> <20160927185000.GF21388@dell>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160927185000.GF21388@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, =?UTF-8?Q?Ksenija_Stanojevi=C4=87?= <ksenija.stanojevic@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, =?UTF-8?Q?Marek_Va=C5=A1ut?= <marex@denx.de>, linux-iio@vger.kernel.org, Harald Geyer <harald@ccbib.org>, Stefan Wahren <stefan.wahren@i2se.com>, Fabio Estevam <fabio.estevam@freescale.com>
List-Id: linux-input@vger.kernel.org

On September 27, 2016 11:50:00 AM PDT, Lee Jones <lee.jones@linaro.org> wrote:
>On Sat, 17 Sep 2016, Ksenija Stanojević wrote:
>> On Wed, Aug 31, 2016 at 2:05 PM, Lee Jones <lee.jones@linaro.org>
>wrote:
>> > On Thu, 18 Aug 2016, Ksenija Stanojevic wrote:
>> >
>> > > Add core files for mxs-lradc MFD driver.
>> > >
>> > > Note:  this patch won't compile in iio/testing without this
>patch:
>> > > a8f447be8056 ("mfd: Add resource managed APIs for
>mfd_add_devices")
>> > >
>> > > Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
>> > > ---
>> > > Changes in v5:
>> > >  - use DEFINE_RES_MEM
>> > >  - don't pass ioreammaped adress to platform cells
>> > >  - move comment outside of struct mxs_lradc
>> > >  - change type of argument in mxs_lradc_reg_set,
>mxs_lradc_reg_clear,
>> > >    mxs_lradc_reg_wrt (struct mxs_lradc * -> void __iomem *)
>> > >
>> > > Changes in v4:
>> > >  - update copyright
>> > >  - use DEFINE_RES_IRQ_NAMED
>> > >  - remove mxs_lradc_add_device function
>> > >  - use struct mfd_cell in static form
>> > >  - improve spacing
>> > >  - remove unnecessary comment
>> > >  - remove platform_get_irq
>> > >  - remove touch_ret and use ret instead
>> > >  - rename use_touchscreen to touchscreen_wire
>> > >  - use goto statements
>> > >  - remove irq[13], irq_count and irq_name from struct mxs_lradc
>> > >  - remove all defines from inside the struct definition
>> > >
>> > > Changes in v3:
>> > >  - add note to commit message
>> > >  - move switch statement into if(touch_ret == 0) branch
>> > >  - add MODULE_AUTHOR
>> > >
>> > > Changes in v2:
>> > >  - do not change spacing in Kconfig
>> > >  - make struct mfd_cell part of struct mxs_lradc
>> > >  - use switch instead of if in mxs_lradc_irq_mask
>> > >  - use only necessary header files in mxs_lradc.h
>> > >  - use devm_mfd_add_device
>> > >  - use separate function to register mfd device
>> > >  - change licence to GPL
>> > >  - add copyright
>> > >
>> > >  drivers/mfd/Kconfig           |  17 +++
>> > >  drivers/mfd/Makefile          |   1 +
>> > >  drivers/mfd/mxs-lradc.c       | 255
>++++++++++++++++++++++++++++++++++++++++++
>> > >  include/linux/mfd/mxs-lradc.h | 194
>++++++++++++++++++++++++++++++++
>> > >  4 files changed, 467 insertions(+)
>> > >  create mode 100644 drivers/mfd/mxs-lradc.c
>> > >  create mode 100644 include/linux/mfd/mxs-lradc.h
>
>[...]
>
>> > > +static int mxs_lradc_probe(struct platform_device *pdev)
>> > > +{
>> > > +     const struct of_device_id *of_id;
>> > > +     struct device *dev = &pdev->dev;
>> > > +     struct device_node *node = dev->of_node;
>> > > +     struct mxs_lradc *lradc;
>> > > +     struct mfd_cell *cells = NULL;
>> > > +     int ret = 0;
>> > > +     u32 ts_wires = 0;
>> > > +
>> > > +     lradc = devm_kzalloc(&pdev->dev, sizeof(*lradc),
>GFP_KERNEL);
>> > > +     if (!lradc)
>> > > +             return -ENOMEM;
>> > > +
>> > > +     of_id = of_match_device(mxs_lradc_dt_ids, &pdev->dev);
>> > > +     lradc->soc = (enum mxs_lradc_id)of_id->data;
>> >
>> > Unnecessary cast.
>> 
>> If I remove the cast I get this error:
>> drivers/mfd/mxs-lradc.c:148:13: error: incompatible types when
>> assigning to type ‘enum mxs_lradc_id’ from type ‘const void * const’
>
>Ah, because it's a const.  Fair enough.

No, it's because void * has to be cast to a non-pointer data type explicitly.


Thanks.

-- 
Dmitry
