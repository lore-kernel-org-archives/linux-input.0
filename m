From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v2 1/3] Input: gpio-keys - add support for wakeup event action
Date: Tue, 13 Feb 2018 23:25:55 +0100
Message-ID: <CAFqH_52iUc3HQmTSoFQ5FOf5gJECf3nuPY2_ks6NrwFC4oudug@mail.gmail.com>
References: <20180210110907.5504-1-jeffy.chen@rock-chips.com>
 <20180210110907.5504-2-jeffy.chen@rock-chips.com> <20180212221309.GA66974@ban.mtv.corp.google.com>
 <059e2aa9-bf94-517d-a132-abe851ec69f7@collabora.com> <20180213182521.GA51247@rodete-desktop-imager.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180213182521.GA51247@rodete-desktop-imager.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel <linux-kernel@vger.kernel.org>, Brian Norris <briannorris@google.com>, dtor@google.com, Doug Anderson <dianders@google.com>, Thomas Gleixner <tglx@linutronix.de>, Joseph Lo <josephl@nvidia.com>, stephen lu <lumotuwe@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi,

2018-02-13 19:25 GMT+01:00 Brian Norris <briannorris@chromium.org>:
> Hi Enric,
>
> On Tue, Feb 13, 2018 at 11:40:44AM +0100, Enric Balletbo i Serra wrote:
>> On 12/02/18 23:13, Brian Norris wrote:
>> > On Sat, Feb 10, 2018 at 07:09:05PM +0800, Jeffy Chen wrote:
>> >> Add support for specifying event actions to trigger wakeup when using
>> >> the gpio-keys input device as a wakeup source.
>> >>
>> >> This would allow the device to configure when to wakeup the system. For
>> >> example a gpio-keys input device for pen insert, may only want to wakeup
>> >> the system when ejecting the pen.
>> >>
>> >> Suggested-by: Brian Norris <briannorris@chromium.org>
>> >> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> >> ---
>> >>
>> >> Changes in v2:
>> >> Specify wakeup event action instead of irq trigger type as Brian
>> >> suggested.
> [...]
>> Not sure if you were aware but there is also some discussion related to this,
>> maybe we can join the efforts?
>>
>> v1: https://patchwork.kernel.org/patch/10208261/
>> v2: https://patchwork.kernel.org/patch/10211147/
>
> Thanks for the pointers. IIUC, that's talking about a different problem:
> how to utilize a GPIO key in level-triggered mode. That touches similar
> code, but it doesn't really have anything to do with configuring a
> different wakeup trigger type.
>

Right, sorry. I see now what you are doing.

> The two patches would need to be reconciled, if they both are going to
> be merged. But otherwise, I think they're perfectly fine to be separate.
>

Yes, that's why I got confused, I had those patches applied on my tree
and when I tried to apply these failed and I wrongly assumed that were
doing the same. Waiting to test the third version ;)

Thanks,
 Enric

> Brian
