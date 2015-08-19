From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: PROBLEM: Missing events on thinkpad trackpoint buttons
Date: Wed, 19 Aug 2015 17:34:21 -0400
Message-ID: <CAN+gG=GvaVBb2SKbcNReY0_mfeTkOiBzDaJr3WzfkioM9DpKHw@mail.gmail.com>
References: <CAN_QmVxOaqyZ8fJ29Jtjkb8YnckjQ=q53igOcQuAFmrQG7hiZQ@mail.gmail.com>
	<CAN+gG=GbMrxCUJJJqgROmx6g4jYU+jqW2JKyt3Yz+DL-SMhd8A@mail.gmail.com>
	<CAN+gG=HQ7ViGHSLfBuCSaqPFppOm-9ggEaZFwyXKse7CP_p25A@mail.gmail.com>
	<20150819212748.GB19499@dtor-pixel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:33215 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243AbbHSVeW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Aug 2015 17:34:22 -0400
Received: by oio137 with SMTP id 137so11681403oio.0
        for <linux-input@vger.kernel.org>; Wed, 19 Aug 2015 14:34:22 -0700 (PDT)
In-Reply-To: <20150819212748.GB19499@dtor-pixel>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Nick Bowler <nbowler@draconx.ca>, linux-input <linux-input@vger.kernel.org>, Stephen Chandler Paul <thatslyude@gmail.com>, Andrew Duggan <andrew.duggan@gmail.com>

On Wed, Aug 19, 2015 at 5:27 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Aug 19, 2015 at 09:52:00AM -0400, Benjamin Tissoires wrote:
>> On Tue, Aug 18, 2015 at 3:06 PM, Benjamin Tissoires
>> <benjamin.tissoires@gmail.com> wrote:
>> > Hi Nick,
>> >
>> > thanks for the report.
>> >
>> > On Mon, Aug 17, 2015 at 10:31 PM, Nick Bowler <nbowler@draconx.ca> wrote:
>> >> Hi,
>> >>
>> >> I'm not sure if this is actually a Linux issue but figured I'd at least
>> >> report it here to start...
>> >>
>> >> I have a Lenovo Thinkpad X250, with the newfangled trackpoint buttons.
>> >> I have a problem with missing button press or release events: sometimes
>> >> pressing a button has no effect, and sometimes releasing a button has no
>> >> effect (the latter is especially annoying, as the button remains depressed
>> >> as far as any applications are concerned).
>> >>
>> >> After some testing, the problem apparently depends on the position of my
>> >> hands over the touchpad.  I can reliably reproduce it as follows: place
>> >> two fingers on the touchpad, then press the button repeatedly.  Watching
>> >> with evtest, several events (could be either press or release) will
>> >> simply be missin, although the kernel never does anything weird like
>> >> send two release events in a row.  There are no problems if there are
>> >> 0 or 1 fingers on the touchpad.
>> >>
>> >> My current kernel version is 4.1.6, although the problem occurs in all
>> >> versions that I tried.
>> >>
>> >> Here is the evtest result from placing two fingers on the touchpad, then
>> >> pressing the left trackpoint button 10 times, counting 1 second between
>> >> each press.  As you can see, only 3 presses and 3 release events total
>> >> were sent by the kernel, sometimes with many physical button presses
>> >> between the press and its corresponding release:
>> >
>> > OK, so this is definitively weird. My first idea would be a firmware
>> > problem. I have asked Chandler to reproduce it on his t450 and see if
>> > we observe it on our laptops too.
>>
>> Update on this one : Chandler reproduced it on the t450, so it's
>> likely that all of these sensors are affected. It is still unclear if
>> it is a firmware bug or a driver problem, but the chances are huge
>> that this is a firmware bug. Anyway, that's one more reason to push
>> towards RMI4 over SMBus for these sensors: the bug is not present with
>> this protocol :)
>
> By the way, how are we going to handle Trackpoint (PS/2 device) with
> touchpads in RMI4 mode? I do not recall anything in RMI4 spec, but I
> looked at it quite some time ago.
>

Yes, there is nothing public in the spec for the RMI4 PS/2
pass-through mode. With a little help of Synaptics, Chandler
implemented it (it's function 03):
https://github.com/bentiss/linux/commit/b0cea92f56db9fc521a3ffaad534d91ef33466c8

This might not be the last version I have on my laptop, but it should
be close enough (if you also add the reporting of the extra buttons
that are sent through the GPIO function - 30).

Basically, I am running this code on a day to day basis, and we have
spotted most of the bugs now I think. It is stable and works better
than the PS/2 implementation because we don't have the bugs inherent
to the "report 2 slots but 5 actually".

Cheers,
Benjamin

PS: looks like Chandler beat me at answering
