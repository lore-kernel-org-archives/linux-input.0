From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: PROBLEM: Missing events on thinkpad trackpoint buttons
Date: Sun, 27 Sep 2015 08:14:37 -0400
Message-ID: <CAN+gG=Hrcw=YKGf_No8=FptL3zTGmrR39n1pwk4q0d5Po8RFDg@mail.gmail.com>
References: <CAMmwwr-7fQcMa=DiiCO+GU7R1ZLgh6o2SD40q+gTPmcu=A_8uA@mail.gmail.com>
	<20150820213526.GA10980@localhost>
	<CAMmwwr-uYWurxAQnDdy9hVO-A3PGK92uSmHjYagp5eTXmPnZ_Q@mail.gmail.com>
	<20150820225633.GA12900@localhost>
	<CAKdAkRQwOhQ7ysyAQ3QV=mRfXBvVxC=wrqOhhK1J4YLpWh2hRA@mail.gmail.com>
	<CAMmwwr8ycdXKbrsfe_ameK+ZmdH2yZbUtMtcZrrceSAfsgz_0g@mail.gmail.com>
	<20150820230840.GB12900@localhost>
	<20150820231339.GA7236@localhost>
	<CAN+gG=H88uVbRun=Vs1r1b8jM=wpnC1285BquFpDsh8HQdr07Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33226 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755500AbbI0MOj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 27 Sep 2015 08:14:39 -0400
Received: by wiclk2 with SMTP id lk2so71877024wic.0
        for <linux-input@vger.kernel.org>; Sun, 27 Sep 2015 05:14:38 -0700 (PDT)
In-Reply-To: <CAN+gG=H88uVbRun=Vs1r1b8jM=wpnC1285BquFpDsh8HQdr07Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Gabor Balla <gaborwho@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Stephen Chandler Paul <thatslyude@gmail.com>, Nick Bowler <nbowler@draconx.ca>, Andrew Duggan <andrew.duggan@gmail.com>

[re-sending because my gmail client decided to turn on HTML for all
mails I wrote. Sorry for the duplicate ]

On Sun, Sep 27, 2015 at 8:12 AM, Benjamin Tissoires
<benjamin.tissoires@gmail.com> wrote:
>
>
> On Thu, Aug 20, 2015 at 7:13 PM, Dmitry Torokhov <dmitry.torokhov@gmail.com>
> wrote:
>>
>> On Thu, Aug 20, 2015 at 04:08:40PM -0700, Dmitry Torokhov wrote:
>> > Hi Gabor,
>> >
>> > On Fri, Aug 21, 2015 at 01:05:46AM +0200, Gabor Balla wrote:
>> > > Hi Dmitry,
>> > >
>> > > On Fri, Aug 21, 2015 at 1:01 AM, Dmitry Torokhov
>> > > <dmitry.torokhov@gmail.com> wrote:
>> > > > On Thu, Aug 20, 2015 at 3:56 PM, Dmitry Torokhov
>> > > > <dmitry.torokhov@gmail.com> wrote:
>> > > >> On Fri, Aug 21, 2015 at 12:24:59AM +0200, Gabor Balla wrote:
>> > > >>> Hi Dmitry,
>> > > >>>
>> > > >>> On Thu, Aug 20, 2015 at 11:35 PM, Dmitry Torokhov
>> > > >>> <dmitry.torokhov@gmail.com> wrote:
>> > > >>> > On Thu, Aug 20, 2015 at 10:50:27PM +0200, Gabor Balla wrote:
>> > > [...]
>> > > > Ah, wait, not quite still. So we actually do want to disable
>> > > > gestures
>> > > > when in Absolute mode (non extended). Although frankly I do not
>> > > > think
>> > > > we'll ever see pre 4.0 Synaptics device in a wild.
>> > >
>> > > Also notice there is a function called synaptics_set_disable_gesture
>> > > that can
>> > > change that bit regardless of current mode.
>> >
>> > That attribute is only created when touchpad is used in relative mode,
>> > so should be OK.
>> >
>> > Thanks.
>>
>> How about this one?
>

 Hello Dmitry,

 unfortunately, I have been reported a breakage in libinput this week
 following this patch.
 See https://bugs.freedesktop.org/show_bug.cgi?id=92091

 If you look at the evemu recording with 2 fingers scroll, you will see that
 the kernel sends a slot and a tracking ID for the second finger, but it
 never sends the actual coordinates. Libinput ignores such slot (I'll check
 with Peter what we do in such cases when he will be back from his vacations)
 and this kills the 2 fingers scrolling.

 I believe the fix is worse than the original situation given that this also
 removes all gestures support we can have in libinput.

 And of course, with my turtle speed to test it, this patch is already in
 stable too (I am entirely at fault here :( ).

 Cheers,
 Benjamin

>>
>>
>> Thanks.
>>
>> --
>> Dmitry
>>
>>
>> Input: synaptics - fix handling of disabling gesture mode
>>
>> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>
>> Bit 2 of the mode byte has dual meaning: it can disable reporting of
>> gestures when touchpad works in Relative mode or normal Absolute mode,
>> or it can enable so called Extended W-Mode when touchpad uses enhanced
>> Absolute mode (W-mode). The extended W-Mode confuses our driver and
>> causes missing button presses on some Thinkpads (x250, T450s), so let's
>> make sure we do not enable it.
>>
>> Also, according to the spec W mode "... bit is defined only in Absolute
>> mode on pads whose capExtended capability bit is set. In Relative mode and
>> in TouchPads without this capability, the bit is reserved and should be
>> left at 0.", so let's make sure we respect this requirement as well.
>>
>> Reported-by: Nick Bowler <nbowler@draconx.ca>
>> Suggested-by: Gabor Balla <gaborwho@gmail.com>
>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> ---
>>  drivers/input/mouse/synaptics.c |   12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/input/mouse/synaptics.c
>> b/drivers/input/mouse/synaptics.c
>> index 28daca1..d9c9e41 100644
>> --- a/drivers/input/mouse/synaptics.c
>> +++ b/drivers/input/mouse/synaptics.c
>> @@ -519,14 +519,18 @@ static int synaptics_set_mode(struct psmouse
>> *psmouse)
>>         struct synaptics_data *priv = psmouse->private;
>>
>>         priv->mode = 0;
>> -       if (priv->absolute_mode)
>> +
>> +       if (priv->absolute_mode) {
>>                 priv->mode |= SYN_BIT_ABSOLUTE_MODE;
>> -       if (priv->disable_gesture)
>> +               if (SYN_CAP_EXTENDED(priv->capabilities))
>> +                       priv->mode |= SYN_BIT_W_MODE;
>> +       }
>> +
>> +       if (!(priv->mode & SYN_BIT_W_MODE) && priv->disable_gesture)
>>                 priv->mode |= SYN_BIT_DISABLE_GESTURE;
>> +
>>         if (psmouse->rate >= 80)
>>                 priv->mode |= SYN_BIT_HIGH_RATE;
>> -       if (SYN_CAP_EXTENDED(priv->capabilities))
>> -               priv->mode |= SYN_BIT_W_MODE;
>>
>>         if (synaptics_mode_cmd(psmouse, priv->mode))
>>                 return -1;
>
>
