From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: PROBLEM: Missing events on thinkpad trackpoint buttons
Date: Mon, 28 Sep 2015 15:52:50 -0700
Message-ID: <CAKdAkRTC2uvmZNwyZbd5sjPFy5T1s+a=R8YGyg9wevajz8r3HQ@mail.gmail.com>
References: <CAMmwwr-7fQcMa=DiiCO+GU7R1ZLgh6o2SD40q+gTPmcu=A_8uA@mail.gmail.com>
	<20150820213526.GA10980@localhost>
	<CAMmwwr-uYWurxAQnDdy9hVO-A3PGK92uSmHjYagp5eTXmPnZ_Q@mail.gmail.com>
	<20150820225633.GA12900@localhost>
	<CAKdAkRQwOhQ7ysyAQ3QV=mRfXBvVxC=wrqOhhK1J4YLpWh2hRA@mail.gmail.com>
	<CAMmwwr8ycdXKbrsfe_ameK+ZmdH2yZbUtMtcZrrceSAfsgz_0g@mail.gmail.com>
	<20150820230840.GB12900@localhost>
	<20150820231339.GA7236@localhost>
	<CAN+gG=H88uVbRun=Vs1r1b8jM=wpnC1285BquFpDsh8HQdr07Q@mail.gmail.com>
	<CAN+gG=Hrcw=YKGf_No8=FptL3zTGmrR39n1pwk4q0d5Po8RFDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35935 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167AbbI1Wwv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Sep 2015 18:52:51 -0400
Received: by oibi136 with SMTP id i136so8855404oib.3
        for <linux-input@vger.kernel.org>; Mon, 28 Sep 2015 15:52:50 -0700 (PDT)
In-Reply-To: <CAN+gG=Hrcw=YKGf_No8=FptL3zTGmrR39n1pwk4q0d5Po8RFDg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Gabor Balla <gaborwho@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Stephen Chandler Paul <thatslyude@gmail.com>, Nick Bowler <nbowler@draconx.ca>, Andrew Duggan <andrew.duggan@gmail.com>

On Sun, Sep 27, 2015 at 5:14 AM, Benjamin Tissoires
<benjamin.tissoires@gmail.com> wrote:
> [re-sending because my gmail client decided to turn on HTML for all
> mails I wrote. Sorry for the duplicate ]
>
> On Sun, Sep 27, 2015 at 8:12 AM, Benjamin Tissoires
> <benjamin.tissoires@gmail.com> wrote:
>>
>>
>> On Thu, Aug 20, 2015 at 7:13 PM, Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> wrote:
>>>
>>> On Thu, Aug 20, 2015 at 04:08:40PM -0700, Dmitry Torokhov wrote:
>>> > Hi Gabor,
>>> >
>>> > On Fri, Aug 21, 2015 at 01:05:46AM +0200, Gabor Balla wrote:
>>> > > Hi Dmitry,
>>> > >
>>> > > On Fri, Aug 21, 2015 at 1:01 AM, Dmitry Torokhov
>>> > > <dmitry.torokhov@gmail.com> wrote:
>>> > > > On Thu, Aug 20, 2015 at 3:56 PM, Dmitry Torokhov
>>> > > > <dmitry.torokhov@gmail.com> wrote:
>>> > > >> On Fri, Aug 21, 2015 at 12:24:59AM +0200, Gabor Balla wrote:
>>> > > >>> Hi Dmitry,
>>> > > >>>
>>> > > >>> On Thu, Aug 20, 2015 at 11:35 PM, Dmitry Torokhov
>>> > > >>> <dmitry.torokhov@gmail.com> wrote:
>>> > > >>> > On Thu, Aug 20, 2015 at 10:50:27PM +0200, Gabor Balla wrote:
>>> > > [...]
>>> > > > Ah, wait, not quite still. So we actually do want to disable
>>> > > > gestures
>>> > > > when in Absolute mode (non extended). Although frankly I do not
>>> > > > think
>>> > > > we'll ever see pre 4.0 Synaptics device in a wild.
>>> > >
>>> > > Also notice there is a function called synaptics_set_disable_gesture
>>> > > that can
>>> > > change that bit regardless of current mode.
>>> >
>>> > That attribute is only created when touchpad is used in relative mode,
>>> > so should be OK.
>>> >
>>> > Thanks.
>>>
>>> How about this one?
>>
>
>  Hello Dmitry,
>
>  unfortunately, I have been reported a breakage in libinput this week
>  following this patch.
>  See https://bugs.freedesktop.org/show_bug.cgi?id=92091
>
>  If you look at the evemu recording with 2 fingers scroll, you will see that
>  the kernel sends a slot and a tracking ID for the second finger, but it
>  never sends the actual coordinates. Libinput ignores such slot (I'll check
>  with Peter what we do in such cases when he will be back from his vacations)
>  and this kills the 2 fingers scrolling.
>
>  I believe the fix is worse than the original situation given that this also
>  removes all gestures support we can have in libinput.
>

Umm, I guess I have to claim temporary insanity or something like that
with this one: we do need extended W mode to handle multiple touches
in the driver and  the patch disabled it ;(

Before we revert this, Nick, Gabor, can you tell me what capability
bits your touchpads report (in dmesg)?

Thanks.

-- 
Dmitry
