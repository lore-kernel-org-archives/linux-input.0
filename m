From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input/serio/i8042: Skip selftest on i8042 controller
 in some ASUS laptops
Date: Wed, 27 Jul 2016 00:21:19 -0700
Message-ID: <CAKdAkRRjk4AfLQ+=LqcnPb6xSbiVvkMBOY9oC37XEU=eb2sg9w@mail.gmail.com>
References: <1469467222-2382-1-git-send-email-marcos.souza.org@gmail.com>
 <20160725182237.GC27415@dtor-ws> <CAH0vN5KRM+KWirV+cp=ANg3=YVFCPzvW-E2T=KQWhm_u5xs5jg@mail.gmail.com>
 <CAH0vN5JonW+PWTS4mY9Jiwp60DuMQsiYCPnrgu+i5YFgU764rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:32997 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbcG0HVU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Jul 2016 03:21:20 -0400
Received: by mail-vk0-f67.google.com with SMTP id s189so165331vkh.0
        for <linux-input@vger.kernel.org>; Wed, 27 Jul 2016 00:21:20 -0700 (PDT)
In-Reply-To: <CAH0vN5JonW+PWTS4mY9Jiwp60DuMQsiYCPnrgu+i5YFgU764rA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcos Souza <marcos.souza.org@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, Jul 26, 2016 at 6:13 PM, Marcos Souza
<marcos.souza.org@gmail.com> wrote:
> Hi Dmitry,
>
> On Mon, Jul 25, 2016 at 3:48 PM, Marcos Souza
> <marcos.souza.org@gmail.com> wrote:
>> Hi Dmitry,
>>
>> On Mon, Jul 25, 2016 at 3:22 PM Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> wrote:
>>>
>>> [ resending to all - mutt is for some reason confused about recipent
>>> list ]
>>> On Mon, Jul 25, 2016 at 02:20:16PM -0300, Marcos Paulo de Souza wrote:
>>> > On suspend/resume cycle, selftest is executed on to reset i8042
>>> > controller. But
>>> > when this is done in these devices, posterior calls to detect/init
>>> > functions
>>> > to elantech driver fails. Skipping selftest fixes this problem.
>>> >
>>> > An easier step to reproduce this problem is adding i8042.reset=1 as a
>>> > kernel
>>> > parameter. On problematic laptops, it'll make the system to start with
>>> > the
>>> > touchpad already stucked, since psmouse_probe forcibly calls the
>>> > selftest function.
>>> >
>>> > This patch was inspired by John Hiesey's change[1].
>>> >
>>> > [1]: https://marc.info/?l=linux-input&m=144312209020616&w=2
>>> >
>>> > Fixes: "ETPS/2 Elantech Touchpad dies after resume from suspend"
>>> > (https://bugzilla.kernel.org/show_bug.cgi?id=7739)
>>>
>>> *sigh* You just cant win, they'll manage to mess up the firmware one way
>>> or another :( Witness:
>>
>>
>> They're experts on messing things up :(
>>
>>>
>>>
>>> "
>>> commit 1ca56e513a9fd356d5a9e0de45dbe0e189e00386
>>> Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>> Date:   Tue Jul 20 20:25:34 2010 -0700
>>>
>>>     Input: i8042 - reset keyboard controller wehen resuming from S2R
>>>
>>>     Some laptops, such as Lenovo 3000 N100, require keyboard controller
>>> reset
>>>     in order to have touchpad operable after suspend to RAM. Even if box
>>> does
>>>     not need the reset it should be safe to do so, so instead of chasing
>>>     after misbehaving boxes and grow DMI tables, let's reset the
>>> controller
>>>     unconditionally.
>>>
>>>     Reported-and-tested-by: Jerome Lacoste <jerome.lacoste@gmail.com>
>>>     Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
>>> "
>>>
>>> so apparently it is not safe to reset the controller on resume. Oh joy.
>>>
>>> The issue I have here is selftest is the same as reset, and we already
>>> have i8042_reset flag, so 2 flags controlling the same functionality is
>>> not great. Could we extend i8042 to an enum, like:
>>>
>>> I8042_RESET_ALWAYS
>>> I8042_RESET_NEVER
>>> I8042_RESET_ON_RESUME (default)
>>>
>>> and have a custom module parameter for it?
>>>
>>> i8042.reset and i8042_reset={1|Y|y} would result in I8042_RESET_ALWAYS
>>> i8042.reset={0|N|n} would result in I8042_RESET_NEVER
>>> Without i8042.reset we just reset it when resuming from S3.
>>>
>>> What do you think?
>>
>>
>> Seems to be a very good approach. I'll send a new version.
>
> You asked me to adapt my previous patch, making it accept:
>
> i8042.reset
> i8042.reset={1,y,Y}
> i8042.reset={0,n,N}
>
> But, when using a charp as module parameter, it doesn't allocate
> memory to i8042_reset when we don't use the equal sign. So, in this
> case I can't tell if the user is using i8042.reset, or don't any
> parameter (in this case it means to use I8042_RESET_ON_RESUME)
>
> So, in this case, should we just change i8042.reset to accept 1,y,n?
> This should solve the problem too (although I think people who already
> use such parameter will complain...)
>
> What do you think?

I think you will have to provide custom parameter parsing method.
psmouse module has one, so you can use it as an example.

Thanks.

-- 
Dmitry
