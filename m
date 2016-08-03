From: =?UTF-8?Q?Ksenija_Stanojevi=C4=87?= <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/4] mfd: mxs-lradc: Add support for mxs-lradc MFD
Date: Wed, 3 Aug 2016 18:32:13 +0200
Message-ID: <CAL7P5jKG=b0P9T10RX9p0EXR7epTOfKqbMT6nYZkDhnqiAz_jA@mail.gmail.com>
References: <cover.1466769907.git.ksenija.stanojevic@gmail.com>
 <370a02584386944b465deff5ccc48c8919b23dba.1466769907.git.ksenija.stanojevic@gmail.com>
 <20160628162834.GF29166@dell> <CAL7P5j+NYvUJfu==xQvncyCiw8JHtizOdfyeY1HL6Lb=-wsrWQ@mail.gmail.com>
 <E1bIyD4-0000Jw-2c@stardust.g4.wien.funkfeuer.at> <20160713124935.GC11154@dell>
 <5bddd461-90e3-3116-8d18-fae51bf39310@denx.de> <397621614.8135.5a20a815-9153-4587-9aeb-f2a7fc5a4ff5.open-xchange@email.1und1.de>
 <CAL7P5jJEYUQihe4pynerRUNgVAQzymYbUZEO9BrVdb+-syok-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL7P5jJEYUQihe4pynerRUNgVAQzymYbUZEO9BrVdb+-syok-Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Harald Geyer <harald-95f8Dae0BrPYtjvyW6yDsg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi All,

On Tue, Aug 2, 2016 at 7:08 PM, Ksenija Stanojević
<ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi,
>
> On Tue, Aug 2, 2016 at 6:35 PM, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org> wrote:
>> Hi,
>>
>>> Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> hat am 14. Juli 2016 um 17:38 geschrieben:
>>>
>>>
>>> On 07/13/2016 02:49 PM, Lee Jones wrote:
>>> > On Fri, 01 Jul 2016, Harald Geyer wrote:
>>> >
>>> >> Hi Ksenija!
>>> >>
>>> >> Ksenija Stanojević writes:
>>> >>> On Tue, Jun 28, 2016 at 6:28 PM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>>> >>>>> +static int mxs_lradc_add_device(struct platform_device *pdev,
>>> >>>>> +                             struct mxs_lradc *lradc, char *name, int
>>> >>>>> i)
>>> >>>>> +{
>>> >>>>> +     struct mfd_cell *cell;
>>> >>>>> +
>>> >>>>> +     cell = &lradc->cells[i];
>>> >>>>> +     cell->name = name;
>>> >>>>> +     cell->platform_data = lradc;
>>> >>>>> +     cell->pdata_size = sizeof(*lradc);
>>> >>>>> +
>>> >>>>> +     return devm_mfd_add_devices(&pdev->dev, -1, cell, 1, NULL, 0,
>>> >>>>> NULL);
>>> >>>>> +}
>>> >>>>
>>> >>>> Please don't roll your own API.
>>> >>>>
>>> >>>> Use 'struct mfd_cell' like everyone else does.
>>> >>>
>>> >>> It has been suggested in previous reviews to use separate function to
>>> >>> register mfd device, and to make mfd_cell allocate dynamically because
>>> >>> struc mxs-lradc is allocated dynamically.
>>> >>> But I can revrse changes and make mfd_cells allocate staticaly
>>> >>> wthout separate function.
>>> >>
>>> >> I think making mfd_cells members of struct mxs-lradc will address all
>>> >> review comments.
>>> >
>>> > No, please don't do that either.
>>> >
>>> It'd be nice if you explained in detail why not. Otherwise this is just
>>> empty splat.
>>
>> since there is no reply, here is my guess:
>
> Sorry for the delay, I'm currently working on it. I will post another
> version soon.
>
>> static const struct mfd_cell mxs_lradc_devs[] = {
>>         {
>>                 .name = DRIVER_NAME_ADC,
>>         },
>>         {
>>                 .name = DRIVER_NAME_TS,
>>         },
>> };
>>
>> But i'm not sure if we need of_compatible defined here. The intension of this
>> patch series is to keep the DT binding.
>
> I think it needs .resources because in next version DEFINE_RES_IRQ_NAMED
> will be used.
>
>> @Lee: Could you please give us a feedback?
>>
>> @Ksenija: Still motivated for next round?

Can someone with imx23 board send me /proc/interrupts log, I
need irq numbers...

Thanks,
Ksenija
