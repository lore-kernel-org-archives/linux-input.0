From: Benjamin Franzke <benjaminfranzke@googlemail.com>
Subject: Re: [PATCH 1/2] joydev: Map ABS_{THROTTLE,GAS,BREAK} to positive values.
Date: Sat, 14 Dec 2013 09:16:29 +0100
Message-ID: <CAFc8KeSZpqV0-+=M0ffwjJvYb-v=UtvKTwaD0nBPP2MRyftb6A@mail.gmail.com>
References: <1386749731-6500-1-git-send-email-benjaminfranzke@googlemail.com>
	<CACiKS=QHY6Zq69+zRamZu6xPDUQs0DzNXB8TO_y977fq+qY2pw@mail.gmail.com>
	<CAFc8KeTxX7Wdm5nWGBctwLKew+kmgrJmR0Hdd1cSYStADPFQXQ@mail.gmail.com>
	<CACiKS=TRkEcEXHrB2P9wOfxrYWb8LtJ3S7F+h-OvZeNXYsoxpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:50324 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403Ab3LNIQa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 Dec 2013 03:16:30 -0500
Received: by mail-ie0-f178.google.com with SMTP id lx4so4032645iec.23
        for <linux-input@vger.kernel.org>; Sat, 14 Dec 2013 00:16:29 -0800 (PST)
In-Reply-To: <CACiKS=TRkEcEXHrB2P9wOfxrYWb8LtJ3S7F+h-OvZeNXYsoxpg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ken Phillis Jr <kphillisjr@gmail.com>
Cc: linux-input@vger.kernel.org

2013/12/14 Ken Phillis Jr <kphillisjr@gmail.com>:
> On Sat, Dec 14, 2013 at 12:22 AM, Benjamin Franzke
> <benjaminfranzke@googlemail.com> wrote:
>>
>> I didnt test with games on steam.
>> I've tested with supertuxkart 0.8.1 and jstest.
>>
>> Could you give me a hint, why you think that it breaks(?) input detection?
>>
>> I think SDL2 used evdev, so how should a changed joydev break the
>> correction? (or do you mean in joydev fallback mode?)
>> Searching through the SDL code I guess you refer to this:
>>  http://hg.libsdl.org/SDL/file/a5f8137ccf01/src/joystick/SDL_gamecontroller.c#l133
>> This really looks like a workaround for this brokeness of the joydev
>> correction for triggers,
>> thats why this should be fixed in kernel.
>>
>> It cant really be inteded to map triggers to -32767-32767, and
>> consider this API to not brake application that have workarounds for
>> this.
>> Or is it?
>>
>>
>
>
>
> I believe the more appropriate work around would be to have the
> appropriate mappings setting that are dependent on the device type.
> This is to help improve overall interoperability. I know that most
> xbox 360 devices can directly define the device type with the
> descriptors. That said, Two of the mappings that can work are
> MAP_FLIGHT_STICK and  MAP_RACING_WHEEL.
>
> In the case of the MAP_RACING_WHEEL the following look reasonable enough...
> ABS_WHEEL ( X axis on Left stick )
> ABS_GAS  ( Left trigger )
> ABS_BRAKE ( Right Trigger )

I guess you mean left->brake and right->gas, thats how it is usually used.
I agree that GAS is better suited in combination with BRAKE.
>
> in the case of MAP_FLIGHT_STICK, the following is needed...
> PITCH/ROLL - Axis of Left stick
> POV Hat - Right stick
> Rudder - Left Trigger
> Throttle - Right Trigger.

I think this profiles can be another optimization, but they'll still
need an adjusted default-correction in joydev.
An alternative to these map types would probably be just generic bits
like ABS_TRIGGER_*?

> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
