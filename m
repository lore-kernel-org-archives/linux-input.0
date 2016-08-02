From: =?UTF-8?Q?Ksenija_Stanojevi=C4=87?= <ksenija.stanojevic@gmail.com>
Subject: Re: [PATCH v3 1/4] mfd: mxs-lradc: Add support for mxs-lradc MFD
Date: Tue, 2 Aug 2016 19:08:07 +0200
Message-ID: <CAL7P5jJEYUQihe4pynerRUNgVAQzymYbUZEO9BrVdb+-syok-Q@mail.gmail.com>
References: <cover.1466769907.git.ksenija.stanojevic@gmail.com>
 <370a02584386944b465deff5ccc48c8919b23dba.1466769907.git.ksenija.stanojevic@gmail.com>
 <20160628162834.GF29166@dell> <CAL7P5j+NYvUJfu==xQvncyCiw8JHtizOdfyeY1HL6Lb=-wsrWQ@mail.gmail.com>
 <E1bIyD4-0000Jw-2c@stardust.g4.wien.funkfeuer.at> <20160713124935.GC11154@dell>
 <5bddd461-90e3-3116-8d18-fae51bf39310@denx.de> <397621614.8135.5a20a815-9153-4587-9aeb-f2a7fc5a4ff5.open-xchange@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35045 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935720AbcHBRIV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Aug 2016 13:08:21 -0400
In-Reply-To: <397621614.8135.5a20a815-9153-4587-9aeb-f2a7fc5a4ff5.open-xchange@email.1und1.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, linux-iio@vger.kernel.org, Marek Vasut <marex@denx.de>, Harald Geyer <harald@ccbib.org>

Hi,

On Tue, Aug 2, 2016 at 6:35 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Hi,
>
>> Marek Vasut <marex@denx.de> hat am 14. Juli 2016 um 17:38 geschrieben:
>>
>>
>> On 07/13/2016 02:49 PM, Lee Jones wrote:
>> > On Fri, 01 Jul 2016, Harald Geyer wrote:
>> >
>> >> Hi Ksenija!
>> >>
>> >> Ksenija Stanojević writes:
>> >>> On Tue, Jun 28, 2016 at 6:28 PM, Lee Jones <lee.jones@linaro.org> wrote:
>> >>>>> +static int mxs_lradc_add_device(struct platform_device *pdev,
>> >>>>> +                             struct mxs_lradc *lradc, char *name, int
>> >>>>> i)
>> >>>>> +{
>> >>>>> +     struct mfd_cell *cell;
>> >>>>> +
>> >>>>> +     cell = &lradc->cells[i];
>> >>>>> +     cell->name = name;
>> >>>>> +     cell->platform_data = lradc;
>> >>>>> +     cell->pdata_size = sizeof(*lradc);
>> >>>>> +
>> >>>>> +     return devm_mfd_add_devices(&pdev->dev, -1, cell, 1, NULL, 0,
>> >>>>> NULL);
>> >>>>> +}
>> >>>>
>> >>>> Please don't roll your own API.
>> >>>>
>> >>>> Use 'struct mfd_cell' like everyone else does.
>> >>>
>> >>> It has been suggested in previous reviews to use separate function to
>> >>> register mfd device, and to make mfd_cell allocate dynamically because
>> >>> struc mxs-lradc is allocated dynamically.
>> >>> But I can revrse changes and make mfd_cells allocate staticaly
>> >>> wthout separate function.
>> >>
>> >> I think making mfd_cells members of struct mxs-lradc will address all
>> >> review comments.
>> >
>> > No, please don't do that either.
>> >
>> It'd be nice if you explained in detail why not. Otherwise this is just
>> empty splat.
>
> since there is no reply, here is my guess:

Sorry for the delay, I'm currently working on it. I will post another
version soon.

> static const struct mfd_cell mxs_lradc_devs[] = {
>         {
>                 .name = DRIVER_NAME_ADC,
>         },
>         {
>                 .name = DRIVER_NAME_TS,
>         },
> };
>
> But i'm not sure if we need of_compatible defined here. The intension of this
> patch series is to keep the DT binding.

I think it needs .resources because in next version DEFINE_RES_IRQ_NAMED
will be used.

> @Lee: Could you please give us a feedback?
>
> @Ksenija: Still motivated for next round?
>
> Regards
> Stefan
>
>>
>> --
>> Best regards,
>> Marek Vasut

Regards,
Ksenija
