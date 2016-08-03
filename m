From: =?UTF-8?Q?Ksenija_Stanojevi=C4=87?= <ksenija.stanojevic@gmail.com>
Subject: Re: [PATCH v3 1/4] mfd: mxs-lradc: Add support for mxs-lradc MFD
Date: Wed, 3 Aug 2016 22:20:24 +0200
Message-ID: <CAL7P5jJQQeck8YRSEgFzsyqDoqZOhdZ0Vj=CJrHu14JhvBO9Cg@mail.gmail.com>
References: <cover.1466769907.git.ksenija.stanojevic@gmail.com>
 <370a02584386944b465deff5ccc48c8919b23dba.1466769907.git.ksenija.stanojevic@gmail.com>
 <20160628162834.GF29166@dell> <CAL7P5j+NYvUJfu==xQvncyCiw8JHtizOdfyeY1HL6Lb=-wsrWQ@mail.gmail.com>
 <E1bIyD4-0000Jw-2c@stardust.g4.wien.funkfeuer.at> <20160713124935.GC11154@dell>
 <5bddd461-90e3-3116-8d18-fae51bf39310@denx.de> <397621614.8135.5a20a815-9153-4587-9aeb-f2a7fc5a4ff5.open-xchange@email.1und1.de>
 <CAL7P5jJEYUQihe4pynerRUNgVAQzymYbUZEO9BrVdb+-syok-Q@mail.gmail.com>
 <CAL7P5jKG=b0P9T10RX9p0EXR7epTOfKqbMT6nYZkDhnqiAz_jA@mail.gmail.com>
 <CAOMZO5BSUice=2Zioeu9Zrfi5ixhszO9hF1vmFW5FiPKWqkb9w@mail.gmail.com>
 <CAL7P5j+1vOXz8a7zrTN+KDRAJJWr0vPC25o4LcXutagO9wVRNA@mail.gmail.com>
 <d1c121ee-a467-1642-ca75-a9fae90bbfc1@denx.de> <CAL7P5jJxpPUwR+Kf4-9oZ+jbtr_pgFwpAzxtKX-5ojerTL5Mfw@mail.gmail.com>
 <fe810e2f-f721-55af-e5f2-b13569f7a4e4@denx.de> <CAL7P5jKpW0GOa+1uazrQfULAQ_KBTYBB7ztbj-ADo=de=xT2vw@mail.gmail.com>
 <cbe0ea63-89af-011f-cd49-aed402def039@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33656 "EHLO
	mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758258AbcHCUUx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Aug 2016 16:20:53 -0400
In-Reply-To: <cbe0ea63-89af-011f-cd49-aed402def039@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, Stefan Wahren <stefan.wahren@i2se.com>, Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jonathan Cameron <jic23@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, linux-iio@vger.kernel.org, Harald Geyer <harald@ccbib.org>

On Wed, Aug 3, 2016 at 9:57 PM, Marek Vasut <marex@denx.de> wrote:
> On 08/03/2016 09:45 PM, Ksenija Stanojević wrote:
>> On Wed, Aug 3, 2016 at 9:39 PM, Marek Vasut <marex@denx.de> wrote:
>>> On 08/03/2016 09:34 PM, Ksenija Stanojević wrote:
>>>> On Wed, Aug 3, 2016 at 9:13 PM, Marek Vasut <marex@denx.de> wrote:
>>>>> On 08/03/2016 06:45 PM, Ksenija Stanojević wrote:
>>>>>> Hi Fabio,
>>>>>
>>>>> Hi,
>>>>>
>>>>>> On Wed, Aug 3, 2016 at 6:35 PM, Fabio Estevam <festevam@gmail.com> wrote:
>>>>>>> Hi Ksenija,
>>>>>>>
>>>>>>> On Wed, Aug 3, 2016 at 1:32 PM, Ksenija Stanojević
>>>>>>> <ksenija.stanojevic@gmail.com> wrote:
>>>>>>>
>>>>>>>> Can someone with imx23 board send me /proc/interrupts log, I
>>>>>>>> need irq numbers...
>>>>>>>
>>>>>>> Can't you get them from the MX23 Reference Manual (Table 5-1. i.MX23
>>>>>>> Interrupt Sources)?
>>>>>>
>>>>>> I thought it will be more reliable if I asked someone, since numbers from MX28
>>>>>> manual don't match with /proc/interrupts log.
>>>>>>
>>>>> What do you mean they don't match ? Please elaborate.
>>>>
>>>> irqs don't have the same values in Table 5.1 in MX28 manual and in
>>>> /proc/interrupts
>>>> output.
>>>>
>>>> For example:
>>>> touchscreen irq in MX28 manual have these values:
>>>> 10 (source number) and 0x0028 (vector number)
>>>>
>>>> in /proc/interrupts:
>>>> 210:          0         -  10 Edge      mxs-lradc-touchscreen
>>>
>>> I see lradc_touch_irq in the MX28RM is IRQ 10 and it is also 10 in your
>>> /proc/interrupts output . What am I missing ?
>>
>> I was referring to the number of the first column 210, that's the number that
>> I need and cannot find in the Table of the manual.
>
> The first number in /proc/interrupts is the number which Linux maps to
> that particular IRQ line, but that number can be anything, it does not
> (need to) match the hardware in any way. What do you need it for ?

Thanks, I didn't know that. Well I was using the first number to map
irq names to irq number in DEFINE_RES_IRQ_NAMED.
Otherwise I get probe failure:
probe of mxs-lradc-ts failed with error -22

It's because platform_get_irq_byname cannot find irq for the given
irq name.
