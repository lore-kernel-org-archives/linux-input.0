From: Benjamin Tissoires <btissoir@redhat.com>
Subject: Re: hid-multitouch stuck taps, possibly 4.5 regression?
Date: Wed, 16 Mar 2016 09:47:16 +0100
Message-ID: <20160316084716.GR22340@mail.corp.redhat.com>
References: <CALCETrXDiW4ZyHhqt2gWwwgVYmdup27f3MsyEY9y+=EjrgJBJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57387 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965501AbcCPIrW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2016 04:47:22 -0400
Content-Disposition: inline
In-Reply-To: <CALCETrXDiW4ZyHhqt2gWwwgVYmdup27f3MsyEY9y+=EjrgJBJg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>

Hi Andy,

On Mar 15 2016 or thereabouts, Andy Lutomirski wrote:
> Hi-
> 
> In 4.5 and several 4.5 rcs, I see occasional stuck taps (I think) on
> my XPS 13 9350's touchpad.  The effect is that trying to left-click
> ends up middle-clicking.  I think it's a kernel issue and not a
> hardware or libinput issue, but I'm not 100% sure.  I don't think I
> had this issue in 4.4.
> 
> I've attached what I think is an evtest issue of my fixing the issue
> by pressing three fingers down in sequence and then releasing them.
> After doing that, left-clicks worked.

I think I already have been reported the issue here:
https://bugs.freedesktop.org/show_bug.cgi?id=93948

The result was that it was more likely an I2C transport bug than a
hid-multitouch one (see comment #8 in the fdo bug).

You can try to run hid-recorder when you see the problems, and then
parse the output (or just send it to me). There is huge chances that
there will be no events from I2C sending the release.

And again, I am not sure how we could end up debugging this in the
i2c-designware driver :(

Cheers,
Benjamin

> 
> --Andy

> Input driver version is 1.0.1
> Input device ID: bus 0x18 vendor 0x6cb product 0x76ae version 0x100
> Input device name: "DLL0704:01 06CB:76AE Touchpad"
> Supported events:
>   Event type 0 (EV_SYN)
>   Event type 1 (EV_KEY)
>     Event code 272 (BTN_LEFT)
>     Event code 325 (BTN_TOOL_FINGER)
>     Event code 328 (BTN_TOOL_QUINTTAP)
>     Event code 330 (BTN_TOUCH)
>     Event code 333 (BTN_TOOL_DOUBLETAP)
>     Event code 334 (BTN_TOOL_TRIPLETAP)
>     Event code 335 (BTN_TOOL_QUADTAP)
>   Event type 3 (EV_ABS)
>     Event code 0 (ABS_X)
>       Value   1174
>       Min        0
>       Max     1216
>       Resolution      12
>     Event code 1 (ABS_Y)
>       Value    585
>       Min        0
>       Max      680
>       Resolution      12
>     Event code 47 (ABS_MT_SLOT)
>       Value      1
>       Min        0
>       Max        4
>     Event code 53 (ABS_MT_POSITION_X)
>       Value      0
>       Min        0
>       Max     1216
>       Resolution      12
>     Event code 54 (ABS_MT_POSITION_Y)
>       Value      0
>       Min        0
>       Max      680
>       Resolution      12
>     Event code 57 (ABS_MT_TRACKING_ID)
>       Value      0
>       Min        0
>       Max    65535
> Properties:
>   Property type 0 (INPUT_PROP_POINTER)
>   Property type 2 (INPUT_PROP_BUTTONPAD)
> Testing ... (interrupt to exit)
> Event: time 1458078092.092559, type 3 (EV_ABS), code 57 (ABS_MT_TRACKING_ID), value 1658
> Event: time 1458078092.092559, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 359
> Event: time 1458078092.092559, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 327
> Event: time 1458078092.092559, type 1 (EV_KEY), code 325 (BTN_TOOL_FINGER), value 0
> Event: time 1458078092.092559, type 1 (EV_KEY), code 333 (BTN_TOOL_DOUBLETAP), value 1
> Event: time 1458078092.092559, -------------- SYN_REPORT ------------
> Event: time 1458078092.232054, type 3 (EV_ABS), code 47 (ABS_MT_SLOT), value 2
> Event: time 1458078092.232054, type 3 (EV_ABS), code 57 (ABS_MT_TRACKING_ID), value 1659
> Event: time 1458078092.232054, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 625
> Event: time 1458078092.232054, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 270
> Event: time 1458078092.232054, type 1 (EV_KEY), code 333 (BTN_TOOL_DOUBLETAP), value 0
> Event: time 1458078092.232054, type 1 (EV_KEY), code 334 (BTN_TOOL_TRIPLETAP), value 1
> Event: time 1458078092.232054, -------------- SYN_REPORT ------------
> Event: time 1458078092.379317, type 3 (EV_ABS), code 47 (ABS_MT_SLOT), value 0
> Event: time 1458078092.379317, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 931
> Event: time 1458078092.379317, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 287
> Event: time 1458078092.379317, type 3 (EV_ABS), code 0 (ABS_X), value 931
> Event: time 1458078092.379317, type 3 (EV_ABS), code 1 (ABS_Y), value 287
> Event: time 1458078092.379317, -------------- SYN_REPORT ------------
> Event: time 1458078092.758084, type 3 (EV_ABS), code 57 (ABS_MT_TRACKING_ID), value -1
> Event: time 1458078092.758084, type 1 (EV_KEY), code 333 (BTN_TOOL_DOUBLETAP), value 1
> Event: time 1458078092.758084, type 1 (EV_KEY), code 334 (BTN_TOOL_TRIPLETAP), value 0
> Event: time 1458078092.758084, type 3 (EV_ABS), code 0 (ABS_X), value 359
> Event: time 1458078092.758084, type 3 (EV_ABS), code 1 (ABS_Y), value 327
> Event: time 1458078092.758084, -------------- SYN_REPORT ------------
> Event: time 1458078092.852128, type 3 (EV_ABS), code 47 (ABS_MT_SLOT), value 2
> Event: time 1458078092.852128, type 3 (EV_ABS), code 57 (ABS_MT_TRACKING_ID), value -1
> Event: time 1458078092.852128, type 1 (EV_KEY), code 325 (BTN_TOOL_FINGER), value 1
> Event: time 1458078092.852128, type 1 (EV_KEY), code 333 (BTN_TOOL_DOUBLETAP), value 0
> Event: time 1458078092.852128, -------------- SYN_REPORT ------------
> Event: time 1458078093.018994, type 3 (EV_ABS), code 47 (ABS_MT_SLOT), value 1
> Event: time 1458078093.018994, type 3 (EV_ABS), code 57 (ABS_MT_TRACKING_ID), value -1
> Event: time 1458078093.018994, type 1 (EV_KEY), code 330 (BTN_TOUCH), value 0
> Event: time 1458078093.018994, type 1 (EV_KEY), code 325 (BTN_TOOL_FINGER), value 0
> Event: time 1458078093.018994, -------------- SYN_REPORT ------------
> Event: time 1458078093.297313, type 3 (EV_ABS), code 47 (ABS_MT_SLOT), value 0
> Event: time 1458078093.297313, type 3 (EV_ABS), code 57 (ABS_MT_TRACKING_ID), value 1660
> Event: time 1458078093.297313, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 179
> Event: time 1458078093.297313, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 654
> Event: time 1458078093.297313, type 1 (EV_KEY), code 330 (BTN_TOUCH), value 1
> Event: time 1458078093.297313, type 1 (EV_KEY), code 325 (BTN_TOOL_FINGER), value 1
> Event: time 1458078093.297313, type 3 (EV_ABS), code 0 (ABS_X), value 179
> Event: time 1458078093.297313, type 3 (EV_ABS), code 1 (ABS_Y), value 654
> Event: time 1458078093.297313, -------------- SYN_REPORT ------------
> Event: time 1458078093.348801, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 180
> Event: time 1458078093.348801, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 650
> Event: time 1458078093.348801, type 3 (EV_ABS), code 0 (ABS_X), value 180
> Event: time 1458078093.348801, type 3 (EV_ABS), code 1 (ABS_Y), value 650
> Event: time 1458078093.348801, -------------- SYN_REPORT ------------
> Event: time 1458078093.355991, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 649
> Event: time 1458078093.355991, type 3 (EV_ABS), code 1 (ABS_Y), value 649
> Event: time 1458078093.355991, -------------- SYN_REPORT ------------
> Event: time 1458078093.370723, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 648
> Event: time 1458078093.370723, type 3 (EV_ABS), code 1 (ABS_Y), value 648
> Event: time 1458078093.370723, -------------- SYN_REPORT ------------
> Event: time 1458078093.377898, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 647
> Event: time 1458078093.377898, type 3 (EV_ABS), code 1 (ABS_Y), value 647
> Event: time 1458078093.377898, -------------- SYN_REPORT ------------
> Event: time 1458078093.385184, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 646
> Event: time 1458078093.385184, type 3 (EV_ABS), code 1 (ABS_Y), value 646
> Event: time 1458078093.385184, -------------- SYN_REPORT ------------
> Event: time 1458078093.399779, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 645
> Event: time 1458078093.399779, type 3 (EV_ABS), code 1 (ABS_Y), value 645
> Event: time 1458078093.399779, -------------- SYN_REPORT ------------
> Event: time 1458078093.407435, type 1 (EV_KEY), code 272 (BTN_LEFT), value 1
> Event: time 1458078093.407435, -------------- SYN_REPORT ------------
> Event: time 1458078093.450960, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 646
> Event: time 1458078093.450960, type 3 (EV_ABS), code 1 (ABS_Y), value 646
> Event: time 1458078093.450960, -------------- SYN_REPORT ------------
> Event: time 1458078093.458260, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 647
> Event: time 1458078093.458260, type 3 (EV_ABS), code 1 (ABS_Y), value 647
> Event: time 1458078093.458260, -------------- SYN_REPORT ------------
> Event: time 1458078093.465568, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 648
> Event: time 1458078093.465568, type 3 (EV_ABS), code 1 (ABS_Y), value 648
> Event: time 1458078093.465568, -------------- SYN_REPORT ------------
> Event: time 1458078093.472880, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 649
> Event: time 1458078093.472880, type 3 (EV_ABS), code 1 (ABS_Y), value 649
> Event: time 1458078093.472880, -------------- SYN_REPORT ------------
> Event: time 1458078093.480192, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 650
> Event: time 1458078093.480192, type 3 (EV_ABS), code 1 (ABS_Y), value 650
> Event: time 1458078093.480192, -------------- SYN_REPORT ------------
> Event: time 1458078093.487537, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 651
> Event: time 1458078093.487537, type 3 (EV_ABS), code 1 (ABS_Y), value 651
> Event: time 1458078093.487537, -------------- SYN_REPORT ------------
> Event: time 1458078093.502119, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 652
> Event: time 1458078093.502119, type 3 (EV_ABS), code 1 (ABS_Y), value 652
> Event: time 1458078093.502119, -------------- SYN_REPORT ------------
> Event: time 1458078093.538618, type 1 (EV_KEY), code 272 (BTN_LEFT), value 0
> Event: time 1458078093.538618, -------------- SYN_REPORT ------------
> Event: time 1458078093.618865, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 170
> Event: time 1458078093.618865, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 680
> Event: time 1458078093.618865, type 3 (EV_ABS), code 0 (ABS_X), value 170
> Event: time 1458078093.618865, type 3 (EV_ABS), code 1 (ABS_Y), value 680
> Event: time 1458078093.618865, -------------- SYN_REPORT ------------
> Event: time 1458078093.662013, type 3 (EV_ABS), code 57 (ABS_MT_TRACKING_ID), value -1
> Event: time 1458078093.662013, type 1 (EV_KEY), code 330 (BTN_TOUCH), value 0
> Event: time 1458078093.662013, type 1 (EV_KEY), code 325 (BTN_TOOL_FINGER), value 0
> Event: time 1458078093.662013, -------------- SYN_REPORT ------------

