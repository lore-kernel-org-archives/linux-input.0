From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: Re: Re: [PATCH] Input: joystick: adi - change msleep to usleep_range
 for small msecs
Date: Sat, 3 Dec 2016 23:20:52 +0530
Message-ID: <CADYu308spQjAqGn71XNu3GcKAQLQGHAODtua3=gxFwK3kY1ABA@mail.gmail.com>
References: <CGME20161128114356epcms5p836ef0c36a1cbb8b68638ed046afbb777@epcms5p8>
 <20161128114356epcms5p836ef0c36a1cbb8b68638ed046afbb777@epcms5p8>
 <20161128134931epcms5p66207a434afe573b432d28fdb69eb7de5@epcms5p6> <20161129065903.GE10549@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35446 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbcLCRuz (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 3 Dec 2016 12:50:55 -0500
In-Reply-To: <20161129065903.GE10549@suse.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "vojtech@ucw.cz" <vojtech@ucw.cz>
Cc: Aniroop Mathur <a.mathur@samsung.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, SAMUEL SEQUEIRA <s.samuel@samsung.com>, Rahul Mahale <r.mahale@samsung.com>

On Tue, Nov 29, 2016 at 12:29 PM, vojtech@ucw.cz <vojtech@ucw.cz> wrote:
> On Mon, Nov 28, 2016 at 01:49:31PM +0000, Aniroop Mathur wrote:
>> Hello Mr. Vojtech Pavlik,
>>
>> On 28 Nov 2016 17:23, "vojtech@ucw.cz" <vojtech@ucw.cz> wrote:
>>  >
>>  > Hi.
>>  >
>>  > ADI_INIT_DELAY/ADI_DATA_DELAY doesn't have to be exact, and a longer
>>  > sleep doesn't matter. In the initilization sequence - first chunk of
>>  > your patch - a way too long delay could in theory make the device fail
>>  > to initialize. What's critical is that the mdelay() calls are precise.
>>  >
>>  > One day I'll open my box of old joystick and re-test these drivers to
>>  > see if they survived the years of kernel infrastructure updates ...
>>  >
>>  > Vojtech
>>  >
>>
>>  Well, it seems to me that there is some kind of confusion, so I'd like to
>>  clarify things about this patch.
>>  As you have mentioned that in the initialization sequence, long delay could
>>  in theory make the device fail to initialize - This patch actually solves
>>  this problem.
>>  msleep is built on jiffies / legacy timers and usleep_range is built on top
>>  of hrtimers so the wakeup will be precise.
>>  Source - https://www.kernel.org/doc/Documentation/timers/timers-howto.txt
>>
>>  For example in initialization sequence, if we use msleep(4), then the process
>>  could sleep for much more than 4 ms, say 6 ms or 10 ms or more depending on
>>  machine architecture. Like on a machine with tick rate / HZ is defined to be
>>  100 so msleep(4) will make the process to sleep for minimum 10 ms.
>>  Whereas usleep_range(4000, 4100) will make sure that the process do not sleep
>>  for more than 4100 us or 4.1 ms. So usleep_range is precise but msleep is not.
>>
>>  Originally, I added you in this patch to request you if you could help to
>>  test this patch or provide contact points of individuals who could help
>>  to test this patch as we do not have the hardware available with us?
>>  Like this driver, we also need to test other joystick drivers as well like
>>  gf2k.c, analog.c, sidewinder.c and gameport driver ns558.c as all have
>>  similar problem.
>>  Original patch link - https://patchwork.kernel.org/patch/9446201/
>>  As we do not have hardware available, so we decided to split patch into
>>  individual drivers and request to person who could support to test this patch
>>
>>  I have also applied the same patch in our driver whose hardware is available
>>  with me and I found that wake up time became precise indeed and so I
>>  decided to apply the same fix in other input subsystem drivers as well.
>
> I do understand what you're trying to achieve. Both ADI_DATA_DELAY and
> ADI_INIT_DELAY are specified as minimum delays. Waiting longer doesn't
> cause any trouble, so the patch doesn't need to change that.
>
> In the initialization sequence, it probably doesn't matter either
> whether we wait longer, hence the distinction between msleep() and
> mdelay() based on positive/negative numbers. The mdelay() needs to be
> exact and the msleep() can be longer. How much longer before it disturbs
> the init sequence I'm not sure, probably quite a bit.
>
> The driver was written a long time before hrtimers existed and as such
> it was written expecting that msleep() can take a longer time.
>

Well I agree that waiting longer shall not cause any trouble. However, using
usleep_range does not cause any harm here either. In fact, usleep_range is
more advantageous to use here as it makes the wake up more precise than
before. So we have little improved connection / initialization time than
before which is a good thing indeed as it improves response time.
Also, same is being used by new device drivers and now some old device
drivers have also changed to ulseep_range for 1- 10 ms range.
Also, it is recommended and mentioned in the kernel documentation to use
usleep_range for 1-10 ms delays.
Explained originally here to why not use msleep for 1-20 ms:
http://lkml.org/lkml/2007/8/3/250

So how about using usleep_range api for short delays here?


> So your patch is most likely not needed, but I should find an ADI device
> and see what happens if I make the sleeps in the init sequence much
> longer.
>

So has it been possible so far to check behavior on large sleeps?

> It'd also be interesting to see if the mdelay()s could be replaced with
> hrtimer-based delays instead, as that would be nicer to the system - if
> they can be precise enough. Also, preemption and maybe interrupts should
> be disabled around the mdelays I suppose - that was not an issue when
> the drivers were written.
>

Absolutely. I was also submitting the next patch to change mdelay to
usleep_range
for appropriate delays because mdelay should be ideally used in atomic context
and not in non-atomic context because of busy-waiting.
In our device drivers, we did change mdelay to usleep_range and we
found it to be
working great.

Thanks.

BR,
Aniroop Mathur


> Vojtech
>
>>
>>  Thank you!
>>
>>  BR,
>>  Aniroop Mathur
>>
>>  > On Mon, Nov 28, 2016 at 11:43:56AM +0000, Aniroop Mathur wrote:
>>  > > msleep(1~20) may not do what the caller intends, and will often sleep longer.
>>  > > (~20 ms actual sleep for any value given in the 1~20ms range)
>>  > > This is not the desired behaviour for many cases like device resume time,
>>  > > device suspend time, device enable time, data reading time, etc.
>>  > > Thus, change msleep to usleep_range for precise wakeups.
>>  > >
>>  > > Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
>>  > > ---
>>  > >  joystick/adi.c | 10 +++++-----
>> > >  1 file changed, 5 insertions(+), 5 deletions(-)
>>  > >
>>  > > diff --git a/joystick/adi.c b/joystick/adi.c
>>  > > index d09cefa..6799bd9 100644
>>  > > --- a/joystick/adi.c
>>  > > +++ b/joystick/adi.c
>>  > > @@ -47,8 +47,8 @@ MODULE_LICENSE("GPL");
>>  > >
>>  > >  #define ADI_MAX_START                200     /* Trigger to packet timeout [200us] */
>>  > >  #define ADI_MAX_STROBE               40      /* Single bit timeout [40us] */
>>  > > -#define ADI_INIT_DELAY               10      /* Delay after init packet [10ms] */
>>  > > -#define ADI_DATA_DELAY               4       /* Delay after data packet [4ms] */
>>  > > +#define ADI_INIT_DELAY               10000   /* Delay after init packet [10ms] */
>>  > > +#define ADI_DATA_DELAY               4000    /* Delay after data packet [4000us] */
>>  > >
>>  > >  #define ADI_MAX_LENGTH               256
>>  > >  #define ADI_MIN_LENGTH               8
>>  > > @@ -319,7 +319,7 @@ static void adi_init_digital(struct gameport *gameport)
>>  > >       for (i = 0; seq[i]; i++) {
>>  > >               gameport_trigger(gameport);
>>  > >               if (seq[i] > 0)
>>  > > -                     msleep(seq[i]);
>>  > > +                     usleep_range(seq[i] * 1000, (seq[i] * 1000) + 100);
>>  > >               if (seq[i] < 0) {
>>  > >                       mdelay(-seq[i]);
>>  > >                       udelay(-seq[i]*14);     /* It looks like mdelay() is off by approx 1.4% */
>>  > > @@ -512,9 +512,9 @@ static int adi_connect(struct gameport *gameport, struct gameport_driver *drv)
>>  > >       gameport_set_poll_handler(gameport, adi_poll);
>>  > >       gameport_set_poll_interval(gameport, 20);
>>  > >
>>  > > -     msleep(ADI_INIT_DELAY);
>>  > > +     usleep_range(ADI_INIT_DELAY, ADI_INIT_DELAY + 100);
>>  > >       if (adi_read(port)) {
>>  > > -             msleep(ADI_DATA_DELAY);
>>  > > +             usleep_range(ADI_DATA_DELAY, ADI_DATA_DELAY + 100);
>>  > >               adi_read(port);
>>  > >       }
>>  > >
>>  > > --
>>  > > 2.6.4.windows.1
>>  >
>>  >
>>  > --
>>  > Vojtech Pavlik
>
>
> --
> Vojtech Pavlik
