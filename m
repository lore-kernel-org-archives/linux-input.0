From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Letux-kernel] [PATCH 5/5] input: twl6040-vibra: remove mutex
Date: Wed, 20 Apr 2016 21:00:33 +0200
Message-ID: <808B3D54-B347-47F0-8C9A-CC85518392E9@goldelico.com>
References: <cover.1461009340.git.hns@goldelico.com> <592912a81a86fe0c9b5eaf3407cc5c4e1bfef9fe.1461009340.git.hns@goldelico.com> <20160418212048.GB1006@dtor-ws> <6E9FA6EF-660C-44AE-8BF4-03A21F0DB043@goldelico.com> <20160419080150.GB13933@dtor-ws> <3B181EC4-29FA-4C65-B33A-CC0D09E26E4D@goldelico.com> <F2C0A9CB-843C-4A4D-92FD-CA1DBBF3EC41@goldelico.com> <20160420174951.GB28831@dtor-ws> <0856AEFF-8278-4660-ADE1-0D83EA7CAF18@goldelico.com> <20160420181548.GC28831@dtor-ws>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160420181548.GC28831@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, kernel@pyra-handheld.com, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

> Am 20.04.2016 um 20:15 schrieb Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> 
> On Wed, Apr 20, 2016 at 08:10:28PM +0200, H. Nikolaus Schaller wrote:
>> Hi,
>> 
>>> Am 20.04.2016 um 19:49 schrieb Dmitry Torokhov <dmitry.torokhov@gmail.com>:
>>> 
>>> On Wed, Apr 20, 2016 at 11:22:53AM +0200, H. Nikolaus Schaller wrote:
>>>> 
>>>>> Am 19.04.2016 um 10:08 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
>>>>> 
>>>>> 
>>>>>> Am 19.04.2016 um 10:01 schrieb Dmitry Torokhov <dmitry.torokhov@gmail.com>:
>>>>>> 
>>>>>> On Tue, Apr 19, 2016 at 09:49:01AM +0200, H. Nikolaus Schaller wrote:
>>>>>>> 
>>>>>>>> Am 18.04.2016 um 23:20 schrieb Dmitry Torokhov <dmitry.torokhov@gmail.com>:
>>>>>>>> 
>>>>>>>> On Mon, Apr 18, 2016 at 09:55:41PM +0200, H. Nikolaus Schaller wrote:
>>>>>>>>> The mutex does not seem to be needed.
>>>>>>>> 
>>>>>>>> twl6040_vibra_suspend() and vibra_play_work() may run concurrently, no?
>>>>>>> 
>>>>>>> Hm. I don't know about the rule that would give an answer to this question...
>>>>>> 
>>>>>> Sorry, that was actually a statement, not really a question.
>>>>> 
>>>>> Indeed. In doubt about the answer we should take measures for the worst case.
>>>>> 
>>>>>> It is
>>>>>> possible (although very unlikely) that userspace posts play request and
>>>>>> workqueue will not run until after suspend callback.
>>>>>> 
>>>>>> Thinking about it some more I wonder if we better do what
>>>>>> twl6040_vibra_close() does and cancel the work before shutting off the
>>>>>> device, so that there is no chance of work executing after suspend
>>>>>> callback and reenabling the device. This way we can indeed remove the
>>>>>> mutex.
>>>>> 
>>>>> Ok, I am fine with this.
>>>>> 
>>>>> Will post an update ASAP.
>>>> 
>>>> While doing testing I did run again into another locking related issue which I
>>>> had not yet tried to address with my patch set. It is a:
>>>> 
>>>> 	BUG: scheduling while atomic
>>>> 
>>>> report which sometimes ends in a kernel panic.
>>>> 
>>>> I have attached such a log. vibra.py is here:
>>>> 
>>>> 	http://git.goldelico.com/?p=gta04-kernel.git;a=blob;f=Letux/root/vibra.py;hb=refs/heads/letux-4.6-rc4
>>>> 
>>>> Basically it does an ioctl(EVIOCSFF) which triggers vibra_play.
>>>> 
>>>> Maybe, can you decipher from the log what the reason could be?
>>>> 
>>>> I only conjecture that it happens when vibra_play tries to read the regmap
>>>> of the twl6040 to get twl6040_get_vibralr_status (which has no pendant
>>>> in the twl4030 driver).
>>>> 
>>>> Do we have to configure the twl6040 regmap differently?
>>> 
>>> Right, vibra_play is called with interrupts disabled (that's why we have
>>> workqueue to enable/disable regulators, etc, when we start or stop
>>> vibration), so twl6040_get_vibralr_status() should not sleep, but
>>> apparently it does.
>> 
>> Yes, regmap using i2c communication may sleep.
>> 
>>> Maybe the check for audio configuration should be
>>> moved into vibra_play_work().
>> 
>> Hm. It is there to disable while in audio routing mode, but
>> a workqueue can't report error values back to the scheduling thread...
> 
> Nothing checks result of ->play() anyways, so that -EBUSY was completly
> useless.

Ah, indeed:

http://lxr.free-electrons.com/source/drivers/input/ff-memless.c#L410

> 
>> 
>> So we can either silently make vibra not work (or just report
>> in the kernel log) if "Vibra is configured for audio".
> 
> We might want to ratelimit that message.

Or not report it at all.

> 
>> 
>> Or we need to get a different mechanism to know the vibra status.
>> 
>> Hm.
>> 
>> Research shows that it regmap was introduced long ago but between 3.11 and
>> 3.12 a private cache for these control registers was removed.
>> 
>> http://lxr.free-electrons.com/source/drivers/mfd/twl6040.c?v=3.11#L66
>> http://lxr.free-electrons.com/source/drivers/mfd/twl6040.c?v=3.11#L85
>> http://lxr.free-electrons.com/source/drivers/mfd/twl6040.c?v=3.11#L462
>> 
>> This had been non-blocking and was probably there exactly to protect
>> against this locking issue!
>> 
>> After removing the private cache the code must rely on twl6040_get_vibralr_status
>> not fetching from the chip.
>> 
>> Ah, this correlates to that I see this issue only once and then everything
>> works.
>> 
>> This means we have to fetch the current vibra control registers once
>> outside of vibra_play(). Probably during probing by a single call to
>> twl6040_get_vibralr_status() and ignoring the result.
>> 
>> After it has been fetched once (to know any status from the last reboot)
>> the regmap should track all changes arriving through the sound subsystem
>> (audio vibra enable) and the call to twl6040_get_vibralr_status in interrupt
>> context should no longer block.
>> 
>> Does this sound reasonable?

I think if the -EBUSY isn't evaluated at all, it is simpler to move this test
to the worker. This has the benefit of avoiding a potential race between
changing the vibra source selection (e.g. through amixer) and running the
work function.

> 
> Yes, as long as you document this so that it does not get removed by
> mistake later.

I will prepare a patch and test asap.

BR and thanks,
Nikolaus
