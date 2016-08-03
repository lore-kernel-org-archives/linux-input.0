From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v3 1/4] mfd: mxs-lradc: Add support for mxs-lradc MFD
Date: Wed, 3 Aug 2016 21:39:58 +0200
Message-ID: <fe810e2f-f721-55af-e5f2-b13569f7a4e4@denx.de>
References: <cover.1466769907.git.ksenija.stanojevic@gmail.com>
 <370a02584386944b465deff5ccc48c8919b23dba.1466769907.git.ksenija.stanojevic@gmail.com>
 <20160628162834.GF29166@dell>
 <CAL7P5j+NYvUJfu==xQvncyCiw8JHtizOdfyeY1HL6Lb=-wsrWQ@mail.gmail.com>
 <E1bIyD4-0000Jw-2c@stardust.g4.wien.funkfeuer.at>
 <20160713124935.GC11154@dell> <5bddd461-90e3-3116-8d18-fae51bf39310@denx.de>
 <397621614.8135.5a20a815-9153-4587-9aeb-f2a7fc5a4ff5.open-xchange@email.1und1.de>
 <CAL7P5jJEYUQihe4pynerRUNgVAQzymYbUZEO9BrVdb+-syok-Q@mail.gmail.com>
 <CAL7P5jKG=b0P9T10RX9p0EXR7epTOfKqbMT6nYZkDhnqiAz_jA@mail.gmail.com>
 <CAOMZO5BSUice=2Zioeu9Zrfi5ixhszO9hF1vmFW5FiPKWqkb9w@mail.gmail.com>
 <CAL7P5j+1vOXz8a7zrTN+KDRAJJWr0vPC25o4LcXutagO9wVRNA@mail.gmail.com>
 <d1c121ee-a467-1642-ca75-a9fae90bbfc1@denx.de>
 <CAL7P5jJxpPUwR+Kf4-9oZ+jbtr_pgFwpAzxtKX-5ojerTL5Mfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL7P5jJxpPUwR+Kf4-9oZ+jbtr_pgFwpAzxtKX-5ojerTL5Mfw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Ksenija_Stanojevi=c4=87?= <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harald Geyer <harald-95f8Dae0BrPYtjvyW6yDsg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 08/03/2016 09:34 PM, Ksenija Stanojević wrote:
> On Wed, Aug 3, 2016 at 9:13 PM, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> wrote:
>> On 08/03/2016 06:45 PM, Ksenija Stanojević wrote:
>>> Hi Fabio,
>>
>> Hi,
>>
>>> On Wed, Aug 3, 2016 at 6:35 PM, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>> Hi Ksenija,
>>>>
>>>> On Wed, Aug 3, 2016 at 1:32 PM, Ksenija Stanojević
>>>> <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>>
>>>>> Can someone with imx23 board send me /proc/interrupts log, I
>>>>> need irq numbers...
>>>>
>>>> Can't you get them from the MX23 Reference Manual (Table 5-1. i.MX23
>>>> Interrupt Sources)?
>>>
>>> I thought it will be more reliable if I asked someone, since numbers from MX28
>>> manual don't match with /proc/interrupts log.
>>>
>> What do you mean they don't match ? Please elaborate.
> 
> irqs don't have the same values in Table 5.1 in MX28 manual and in
> /proc/interrupts
> output.
> 
> For example:
> touchscreen irq in MX28 manual have these values:
> 10 (source number) and 0x0028 (vector number)
> 
> in /proc/interrupts:
> 210:          0         -  10 Edge      mxs-lradc-touchscreen

I see lradc_touch_irq in the MX28RM is IRQ 10 and it is also 10 in your
/proc/interrupts output . What am I missing ?

-- 
Best regards,
Marek Vasut
