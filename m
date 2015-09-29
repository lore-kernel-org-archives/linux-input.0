From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: PROBLEM: Missing events on thinkpad trackpoint buttons
Date: Mon, 28 Sep 2015 17:26:40 -0700
Message-ID: <20150929002640.GC30653@dtor-ws>
References: <CAMmwwr-uYWurxAQnDdy9hVO-A3PGK92uSmHjYagp5eTXmPnZ_Q@mail.gmail.com>
 <20150820225633.GA12900@localhost>
 <CAKdAkRQwOhQ7ysyAQ3QV=mRfXBvVxC=wrqOhhK1J4YLpWh2hRA@mail.gmail.com>
 <CAMmwwr8ycdXKbrsfe_ameK+ZmdH2yZbUtMtcZrrceSAfsgz_0g@mail.gmail.com>
 <20150820230840.GB12900@localhost>
 <20150820231339.GA7236@localhost>
 <CAN+gG=H88uVbRun=Vs1r1b8jM=wpnC1285BquFpDsh8HQdr07Q@mail.gmail.com>
 <CAN+gG=Hrcw=YKGf_No8=FptL3zTGmrR39n1pwk4q0d5Po8RFDg@mail.gmail.com>
 <CAKdAkRTC2uvmZNwyZbd5sjPFy5T1s+a=R8YGyg9wevajz8r3HQ@mail.gmail.com>
 <CAN_QmVztquGWimB=5tppOY23onoGdPtrb_YZhVcQnPeHOvG=xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34048 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753789AbbI2A0n (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Sep 2015 20:26:43 -0400
Received: by padhy16 with SMTP id hy16so188135088pad.1
        for <linux-input@vger.kernel.org>; Mon, 28 Sep 2015 17:26:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAN_QmVztquGWimB=5tppOY23onoGdPtrb_YZhVcQnPeHOvG=xQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Bowler <nbowler@draconx.ca>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Gabor Balla <gaborwho@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Stephen Chandler Paul <thatslyude@gmail.com>, Andrew Duggan <andrew.duggan@gmail.com>

On Mon, Sep 28, 2015 at 08:22:02PM -0400, Nick Bowler wrote:
> On 9/28/15, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > On Sun, Sep 27, 2015 at 5:14 AM, Benjamin Tissoires <benjamin.tissoires@gmail.com> wrote:
> >>  I believe the fix is worse than the original situation given that this
> >>  also removes all gestures support we can have in libinput.
> >
> > Umm, I guess I have to claim temporary insanity or something like that
> > with this one: we do need extended W mode to handle multiple touches
> > in the driver and  the patch disabled it ;(
> >
> > Before we revert this, Nick, Gabor, can you tell me what capability
> > bits your touchpads report (in dmesg)?
> 
> Is this the info you're looking for?

Yep, thanks.

> 
>   [    1.225243] psmouse serio1: synaptics: queried max coordinates: x
> [..5712], y [..4780]
>   [    1.256725] psmouse serio1: synaptics: queried min coordinates: x
> [1232..], y [1074..]
>   [    1.316644] psmouse serio1: synaptics: Touchpad model: 1, fw:
> 8.1, id: 0x1e2b1, caps: 0xf002a3/0x943300/0x12e800/0x10000, board id:
> 3075, fw id: 2560
>   [    1.318089] psmouse serio1: synaptics: serio: Synaptics
> pass-through port at isa0060/serio1/input0
>   [    1.356859] input: SynPS/2 Synaptics TouchPad as
> /devices/platform/i8042/serio1/input/input5
>   [    5.135450] psmouse serio2: trackpoint: IBM TrackPoint firmware:
> 0x0e, buttons: 3/3
>   [    5.329582] input: TPPS/2 IBM TrackPoint as
> /devices/platform/i8042/serio1/serio2/input/input7
> 
> Cheers,
>   Nick

-- 
Dmitry
