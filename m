From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: PROBLEM: Missing events on thinkpad trackpoint buttons
Date: Tue, 18 Aug 2015 15:06:42 -0400
Message-ID: <CAN+gG=GbMrxCUJJJqgROmx6g4jYU+jqW2JKyt3Yz+DL-SMhd8A@mail.gmail.com>
References: <CAN_QmVxOaqyZ8fJ29Jtjkb8YnckjQ=q53igOcQuAFmrQG7hiZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:32941 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956AbbHRTGo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Aug 2015 15:06:44 -0400
Received: by wijp15 with SMTP id p15so108386474wij.0
        for <linux-input@vger.kernel.org>; Tue, 18 Aug 2015 12:06:42 -0700 (PDT)
In-Reply-To: <CAN_QmVxOaqyZ8fJ29Jtjkb8YnckjQ=q53igOcQuAFmrQG7hiZQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Bowler <nbowler@draconx.ca>
Cc: linux-input <linux-input@vger.kernel.org>, Stephen Chandler Paul <thatslyude@gmail.com>

Hi Nick,

thanks for the report.

On Mon, Aug 17, 2015 at 10:31 PM, Nick Bowler <nbowler@draconx.ca> wrote:
> Hi,
>
> I'm not sure if this is actually a Linux issue but figured I'd at least
> report it here to start...
>
> I have a Lenovo Thinkpad X250, with the newfangled trackpoint buttons.
> I have a problem with missing button press or release events: sometimes
> pressing a button has no effect, and sometimes releasing a button has no
> effect (the latter is especially annoying, as the button remains depressed
> as far as any applications are concerned).
>
> After some testing, the problem apparently depends on the position of my
> hands over the touchpad.  I can reliably reproduce it as follows: place
> two fingers on the touchpad, then press the button repeatedly.  Watching
> with evtest, several events (could be either press or release) will
> simply be missin, although the kernel never does anything weird like
> send two release events in a row.  There are no problems if there are
> 0 or 1 fingers on the touchpad.
>
> My current kernel version is 4.1.6, although the problem occurs in all
> versions that I tried.
>
> Here is the evtest result from placing two fingers on the touchpad, then
> pressing the left trackpoint button 10 times, counting 1 second between
> each press.  As you can see, only 3 presses and 3 release events total
> were sent by the kernel, sometimes with many physical button presses
> between the press and its corresponding release:

OK, so this is definitively weird. My first idea would be a firmware
problem. I have asked Chandler to reproduce it on his t450 and see if
we observe it on our laptops too.

At the same time, could you please make a ps2emu-record log of your
touchpad when you reproduce the bug?
You can grab the sources here: https://github.com/Lyude/ps2emu
Ideally, if you could run evemu or evtest at the same time to record
what your kernel sees, that would be even better

This should help knowing if the firmware is sending the right packets
or if the driver is ignoring them.

Cheers,
Benjamin

>
>   Input driver version is 1.0.1
>   Input device ID: bus 0x11 vendor 0x2 product 0xa version 0x0
>   Input device name: "TPPS/2 IBM TrackPoint"
>   Supported events:
>     Event type 0 (EV_SYN)
>     Event type 1 (EV_KEY)
>       Event code 272 (BTN_LEFT)
>       Event code 273 (BTN_RIGHT)
>       Event code 274 (BTN_MIDDLE)
>     Event type 2 (EV_REL)
>       Event code 0 (REL_X)
>       Event code 1 (REL_Y)
>   Properties:
>     Property type 0 (INPUT_PROP_POINTER)
>     Property type 5 (?)
>   Testing ... (interrupt to exit)
>   Event: time 1439863173.241278, type 1 (EV_KEY), code 272 (BTN_LEFT), value 1
>   Event: time 1439863173.241278, -------------- SYN_REPORT ------------
>   Event: time 1439863180.610511, type 1 (EV_KEY), code 272 (BTN_LEFT), value 0
>   Event: time 1439863180.610511, -------------- SYN_REPORT ------------
>   Event: time 1439863182.162257, type 1 (EV_KEY), code 272 (BTN_LEFT), value 1
>   Event: time 1439863182.162257, -------------- SYN_REPORT ------------
>   Event: time 1439863185.749212, type 1 (EV_KEY), code 272 (BTN_LEFT), value 0
>   Event: time 1439863185.749212, -------------- SYN_REPORT ------------
>   Event: time 1439863187.145478, type 1 (EV_KEY), code 272 (BTN_LEFT), value 1
>   Event: time 1439863187.145478, -------------- SYN_REPORT ------------
>   Event: time 1439863189.162652, type 1 (EV_KEY), code 272 (BTN_LEFT), value 0
>   Event: time 1439863189.162652, -------------- SYN_REPORT ------------
>
> For reference: the same test was repeated with only one finger on the
> touchpad; all events are delivered properly in this case:
>
>   Input driver version is 1.0.1
>   Input device ID: bus 0x11 vendor 0x2 product 0xa version 0x0
>   Input device name: "TPPS/2 IBM TrackPoint"
>   Supported events:
>     Event type 0 (EV_SYN)
>     Event type 1 (EV_KEY)
>       Event code 272 (BTN_LEFT)
>       Event code 273 (BTN_RIGHT)
>       Event code 274 (BTN_MIDDLE)
>     Event type 2 (EV_REL)
>       Event code 0 (REL_X)
>       Event code 1 (REL_Y)
>   Properties:
>     Property type 0 (INPUT_PROP_POINTER)
>     Property type 5 (?)
>   Testing ... (interrupt to exit)
>   Event: time 1439863147.840979, type 1 (EV_KEY), code 272 (BTN_LEFT), value 1
>   Event: time 1439863147.840979, -------------- SYN_REPORT ------------
>   Event: time 1439863147.919313, type 1 (EV_KEY), code 272 (BTN_LEFT), value 0
>   Event: time 1439863147.919313, -------------- SYN_REPORT ------------
>   Event: time 1439863149.198783, type 1 (EV_KEY), code 272 (BTN_LEFT), value 1
>   Event: time 1439863149.198783, -------------- SYN_REPORT ------------
>   Event: time 1439863149.285873, type 1 (EV_KEY), code 272 (BTN_LEFT), value 0
>   Event: time 1439863149.285873, -------------- SYN_REPORT ------------
>   Event: time 1439863150.673035, type 1 (EV_KEY), code 272 (BTN_LEFT), value 1
>   Event: time 1439863150.673035, -------------- SYN_REPORT ------------
>   Event: time 1439863150.780064, type 1 (EV_KEY), code 272 (BTN_LEFT), value 0
>   Event: time 1439863150.780064, -------------- SYN_REPORT ------------
>   Event: time 1439863152.204741, type 1 (EV_KEY), code 272 (BTN_LEFT), value 1
>   Event: time 1439863152.204741, -------------- SYN_REPORT ------------
>   Event: time 1439863152.321820, type 1 (EV_KEY), code 272 (BTN_LEFT), value 0
>   Event: time 1439863152.321820, -------------- SYN_REPORT ------------
>   Event: time 1439863153.698388, type 1 (EV_KEY), code 272 (BTN_LEFT), value 1
>   Event: time 1439863153.698388, -------------- SYN_REPORT ------------
>   Event: time 1439863153.834195, type 1 (EV_KEY), code 272 (BTN_LEFT), value 0
>   Event: time 1439863153.834195, -------------- SYN_REPORT ------------
>   Event: time 1439863155.181776, type 1 (EV_KEY), code 272 (BTN_LEFT), value 1
>   Event: time 1439863155.181776, -------------- SYN_REPORT ------------
>   Event: time 1439863155.308142, type 1 (EV_KEY), code 272 (BTN_LEFT), value 0
>   Event: time 1439863155.308142, -------------- SYN_REPORT ------------
>   Event: time 1439863156.723367, type 1 (EV_KEY), code 272 (BTN_LEFT), value 1
>   Event: time 1439863156.723367, -------------- SYN_REPORT ------------
>   Event: time 1439863156.849475, type 1 (EV_KEY), code 272 (BTN_LEFT), value 0
>   Event: time 1439863156.849475, -------------- SYN_REPORT ------------
>   Event: time 1439863158.294692, type 1 (EV_KEY), code 272 (BTN_LEFT), value 1
>   Event: time 1439863158.294692, -------------- SYN_REPORT ------------
>   Event: time 1439863158.419989, type 1 (EV_KEY), code 272 (BTN_LEFT), value 0
>   Event: time 1439863158.419989, -------------- SYN_REPORT ------------
>   Event: time 1439863159.846138, type 1 (EV_KEY), code 272 (BTN_LEFT), value 1
>   Event: time 1439863159.846138, -------------- SYN_REPORT ------------
>   Event: time 1439863159.962375, type 1 (EV_KEY), code 272 (BTN_LEFT), value 0
>   Event: time 1439863159.962375, -------------- SYN_REPORT ------------
>   Event: time 1439863161.591024, type 1 (EV_KEY), code 272 (BTN_LEFT), value 1
>   Event: time 1439863161.591024, -------------- SYN_REPORT ------------
>   Event: time 1439863161.688792, type 1 (EV_KEY), code 272 (BTN_LEFT), value 0
>   Event: time 1439863161.688792, -------------- SYN_REPORT ------------
>
> Any thoughts?
>
> Thanks,
>   Nick
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
