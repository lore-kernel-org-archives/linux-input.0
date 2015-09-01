From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: Potential data race in psmouse_interrupt
Date: Tue, 1 Sep 2015 20:46:38 +0200
Message-ID: <CACT4Y+aK=A5dzzT0y+k07x9XFWPbuUk+0xpg+RtzBKw3VJPipQ@mail.gmail.com>
References: <CAAeHK+wZ=fXCRDUvkQdSmFWxU1fqN5suF=P1kL_CT1L8p3ybDg@mail.gmail.com>
 <CAAeHK+wmUwTG=4afGd+LHw7FCcnjsRZY7j_3XnvUYna2Qkx-+A@mail.gmail.com>
 <20150723130844.GA29125@pali> <CAAeHK+xyvq3XnN2FZuO35i+DBDYoi1OFWvHmAdZmC=k7kq9q5Q@mail.gmail.com>
 <20150729115326.GE13518@pali> <CACT4Y+aG1zHHhfUmV_vMh-XsDLqwj3oSH54wobrf77=qyxVUhA@mail.gmail.com>
 <CAKdAkRTtxBNstw+XkOVeY5RPqT8hOOOaA0==-nDiSjYYrV+xWQ@mail.gmail.com>
 <CACT4Y+a5-1LurV1wjwKCUA9neDTCUERgQ=PsoXAaws7FpAWtNw@mail.gmail.com> <CAKdAkRT5ESVh-i7mqcXudY8O0+dNGLxyHgb3LSYT7ft2RiJ=vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKdAkRT5ESVh-i7mqcXudY8O0+dNGLxyHgb3LSYT7ft2RiJ=vg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Andrey Konovalov <andreyknvl@google.com>, Hans de Goede <hdegoede@redhat.com>, Mathias Gottschlag <mgottschlag@gmail.com>, Shailendra Verma <shailendra.capricorn@gmail.com>, Rusty Russell <rusty@rustcorp.com.au>, "Luis R. Rodriguez" <mcgrof@suse.com>, Thomas Hellstrom <thellstrom@vmware.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Kostya Serebryany <kcc@google.com>, Alexander Potapenko <glider@google.com>, ktsan@googlegroups.com
List-Id: linux-input@vger.kernel.org

On Fri, Aug 28, 2015 at 8:32 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Fri, Aug 28, 2015 at 11:08 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
>> On Fri, Aug 28, 2015 at 7:51 PM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>>> On Fri, Aug 28, 2015 at 10:34 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
>>>> Hello,
>>>>
>>>> I am looking at this code in __ps2_command again:
>>>>
>>>> /*
>>>> * The reset command takes a long time to execute.
>>>> */
>>>> timeout = msecs_to_jiffies(command == PS2_CMD_RESET_BAT ? 4000 : 500);
>>>>
>>>> timeout = wait_event_timeout(ps2dev->wait,
>>>>     !(READ_ONCE(ps2dev->flags) & PS2_FLAG_CMD1), timeout);
>>>>
>>>> if (smp_load_acquire(&ps2dev->cmdcnt) &&
>>>>     !(smp_load_acquire(&ps2dev->flags) & PS2_FLAG_CMD1)) {
>>>>               timeout = ps2_adjust_timeout(ps2dev, command, timeout);
>>>>               wait_event_timeout(ps2dev->wait,
>>>>                         !(smp_load_acquire(&ps2dev->flags) &
>>>> PS2_FLAG_CMD), timeout);
>>>> }
>>>>
>>>> if (param)
>>>>     for (i = 0; i < receive; i++)
>>>>               param[i] = ps2dev->cmdbuf[(receive - 1) - i];
>>>>
>>>>
>>>> Here are two moments I don't understand:
>>>> 1. The last parameter of ps2_adjust_timeout is timeout in jiffies (it
>>>> is compared against 100ms). However, timeout is assigned to result of
>>>> wait_event_timeout, which returns 0 or 1. This does not make sense to
>>>> me. What am I missing?
>>>
>>> The fact that wait_event_timeout can return value greater than one:
>>>
>>>  * Returns:
>>>  * 0 if the @condition evaluated to %false after the @timeout elapsed,
>>>  * 1 if the @condition evaluated to %true after the @timeout elapsed,
>>>  * or the remaining jiffies (at least 1) if the @condition evaluated
>>>               ^^^^^^^^^^^^^^^^^^^^^^^^^
>>
>>
>> OK, makes sense now!
>>
>>>> 2. This code pays great attention to timeouts, but in the end I don't
>>>> see how it handles timeouts. That is, if a timeout is happened, we
>>>> still copyout (garbage) from cmdbuf. What am I missing here?
>>>
>>> Once upon a time wait_event() did not return positive value when
>>> timeout expired and then condition satisfied. So we just examine the
>>> final state (psmpouse->cmdcnt should be 0 if command actually
>>> succeeded) and even if we copy in garbage nobody should care since
>>> we'll return error in this case.
>>
>>
>> I see.
>> But the cmdcnt is re-read after copying out response. So it is
>> possible that we read garbage response, but then read cmdcnt==0 and
>> return OK to caller.
>
> That assumes that we actually timed out, and while we were copying the
> data the response finally came.

Right.

>>
>> So far I have something along the following lines to fix data races in libps2.c
>
> I don't know, maybe we should simply move call to
> serio_pause_rx(ps2dev->serio) higher, before we check ps2dev->cmdcnt,
> and move copying of the buffer down, after checking cmdcnt.

I don't know about serio_pause_rx, but copying of response should be
done after checking cmdcnt.
Also you need to use smp_store_release/smp_load_acquire cmdcnt and
flags when they have dependent data. And READ_ONCE/WRITE_ONCE on
shared state otherwise is highly desirable.

>> diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
>> index 7551699..51c747f 100644
>> --- a/drivers/input/serio/libps2.c
>> +++ b/drivers/input/serio/libps2.c
>> @@ -43,7 +43,7 @@ int ps2_sendbyte(struct ps2dev *ps2dev, unsigned
>> char byte, int timeout)
>>
>>          if (serio_write(ps2dev->serio, byte) == 0)
>>                  wait_event_timeout(ps2dev->wait,
>> -                                   !(ps2dev->flags & PS2_FLAG_ACK),
>> +                                   !(READ_ONCE(ps2dev->flags) & PS2_FLAG_ACK),
>>                                     msecs_to_jiffies(timeout));
>>
>>          serio_pause_rx(ps2dev->serio);
>> @@ -187,6 +187,7 @@ int __ps2_command(struct ps2dev *ps2dev, unsigned
>> char *param, int command)
>>          int receive = (command >> 8) & 0xf;
>>          int rc = -1;
>>          int i;
>> +        unsigned char cmdcnt;
>>
>>          if (receive > sizeof(ps2dev->cmdbuf)) {
>>                  WARN_ON(1);
>> @@ -225,23 +226,22 @@ int __ps2_command(struct ps2dev *ps2dev,
>> unsigned char *param, int command)
>>          timeout = msecs_to_jiffies(command == PS2_CMD_RESET_BAT ? 4000 : 500);
>>
>>          timeout = wait_event_timeout(ps2dev->wait,
>> -                                     !(ps2dev->flags &
>> PS2_FLAG_CMD1), timeout);
>> -
>> -        if (ps2dev->cmdcnt && !(ps2dev->flags & PS2_FLAG_CMD1)) {
>> +                !(READ_ONCE(ps2dev->flags) & PS2_FLAG_CMD1), timeout);
>>
>> +        if (READ_ONCE(&ps2dev->cmdcnt) &&
>> +                        !(READ_ONCE(&ps2dev->flags) & PS2_FLAG_CMD1)) {
>>                  timeout = ps2_adjust_timeout(ps2dev, command, timeout);
>>                  wait_event_timeout(ps2dev->wait,
>> -                                   !(ps2dev->flags & PS2_FLAG_CMD), timeout);
>> +                        !(READ_ONCE(&ps2dev->flags) & PS2_FLAG_CMD), timeout);
>
> What all these READ_ONCE()s give us?

I've wrote up the response here:
https://github.com/google/ktsan/wiki/READ_ONCE-and-WRITE_ONCE


>By the way, please either drop ktsan group from public postngs or open
it to post from public.

Sorry, should be public now.
