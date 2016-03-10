From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: report only one button for PenMount 6000 USB
 touchscreen controller
Date: Thu, 10 Mar 2016 17:11:08 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1603101710430.3656@cbobk.fhfr.pm>
References: <1446131389-21759-1-git-send-email-andrew.shadura@collabora.co.uk> <565456F3.8080408@collabora.co.uk> <CAH9NwWfj4pNuqBhYj7ZJQbzqyJ19UpT3iNY8avX-Uu6XLtMW7g@mail.gmail.com> <569514D6.2060204@collabora.co.uk> <56E15E9E.4090107@collabora.co.uk>
 <CAH9NwWcK=J5h++NMSPY6v7RWcVa3=FuPmAEY+_S7vHFMxSXZMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55308 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752360AbcCJQLK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Mar 2016 11:11:10 -0500
In-Reply-To: <CAH9NwWcK=J5h++NMSPY6v7RWcVa3=FuPmAEY+_S7vHFMxSXZMA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Andrew Shadura <andrew.shadura@collabora.co.uk>, Linux Input Mailing List <linux-input@vger.kernel.org>

On Thu, 10 Mar 2016, Christian Gmeiner wrote:

> 2016-03-10 12:46 GMT+01:00 Andrew Shadura <andrew.shadura@collabora.co.uk>:
> > On 12/01/16 15:59, Andrew Shadura wrote:
> >> On 27/11/15 16:18, Christian Gmeiner wrote:
> >>> > 2015-11-24 13:24 GMT+01:00 Andrew Shadura <andrew.shadura@collabora.co.uk>:
> >>>> >> On 29/10/15 16:00, Andrew Shadura wrote:
> >>>>> >>> PenMount 6000 USB resistive touchscreen controller reports it has three
> >>>>> >>> buttons, while in reality it doesn't have any and doesn't support active
> >>>>> >>> styli, and only generates touch events.
> >>>>> >>>
> >>>>> >>> In penmount_input_mapping(), map only the first button (with code 0),
> >>>>> >>> ignore the rest.
> >>>>> >>>
> >>>>> >>> Signed-off-by: Andrew Shadura <andrew.shadura@collabora.co.uk>
> >>>> >>
> >>>> >> Any news on this patch? It'd be cool if it could be merged.
> >>> >
> >>> > I try to get access to the hardware and will test it.
> >> Christian, have you had a chance to test the patch?
> >
> > Ping, once again. Any progress on this?
> 
> Sorry for the long delay. I have applied your patch and the touch
> works as expected.
> 
> No device specified, trying to scan all of /dev/input/event*
> Available devices:
> /dev/input/event0:      Power Button
> /dev/input/event1:      Lid Switch
> /dev/input/event2:      Sleep Button
> /dev/input/event3:      Video Bus
> /dev/input/event4:      DIALOGUE INC PenMount USB
> Select the device event number [0-4]: 4
> Input driver version is 1.0.1
> Input device ID: bus 0x3 vendor 0x14e1 product 0x6000 version 0x101
> Input device name: "DIALOGUE INC PenMount USB"
> Supported events:
>   Event type 0 (EV_SYN)
>   Event type 1 (EV_KEY)
>     Event code 330 (BTN_TOUCH)
>   Event type 3 (EV_ABS)
>     Event code 0 (ABS_X)
>       Value      0
>       Min        0
>       Max     1023
>     Event code 1 (ABS_Y)
>       Value      0
>       Min        0
>       Max     1023
>   Event type 4 (EV_MSC)
>     Event code 4 (MSC_SCAN)
> Properties:
> Testing ... (interrupt to exit)
> 
> Tested-by: Christian Gmeiner <c.gmeiner@bachmann.info

Could you guys please bounce / resend the patch to me? I don't seem to 
see it in my inbox.

Thanks,

-- 
Jiri Kosina
SUSE Labs

