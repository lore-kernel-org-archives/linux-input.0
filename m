From: Benjamin Franzke <benjaminfranzke@googlemail.com>
Subject: Re: [PATCH 1/2] joydev: Map ABS_{THROTTLE,GAS,BREAK} to positive values.
Date: Sat, 14 Dec 2013 07:22:29 +0100
Message-ID: <CAFc8KeTxX7Wdm5nWGBctwLKew+kmgrJmR0Hdd1cSYStADPFQXQ@mail.gmail.com>
References: <1386749731-6500-1-git-send-email-benjaminfranzke@googlemail.com>
	<CACiKS=QHY6Zq69+zRamZu6xPDUQs0DzNXB8TO_y977fq+qY2pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182]:59275 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516Ab3LNGWa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 Dec 2013 01:22:30 -0500
Received: by mail-vc0-f182.google.com with SMTP id lc6so1965395vcb.27
        for <linux-input@vger.kernel.org>; Fri, 13 Dec 2013 22:22:29 -0800 (PST)
In-Reply-To: <CACiKS=QHY6Zq69+zRamZu6xPDUQs0DzNXB8TO_y977fq+qY2pw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ken Phillis Jr <kphillisjr@gmail.com>
Cc: linux-input@vger.kernel.org

I didnt test with games on steam.
I've tested with supertuxkart 0.8.1 and jstest.

Could you give me a hint, why you think that it breaks(?) input detection?

I think SDL2 used evdev, so how should a changed joydev break the
correction? (or do you mean in joydev fallback mode?)
Searching through the SDL code I guess you refer to this:
 http://hg.libsdl.org/SDL/file/a5f8137ccf01/src/joystick/SDL_gamecontroller.c#l133
This really looks like a workaround for this brokeness of the joydev
correction for triggers,
thats why this should be fixed in kernel.

It cant really be inteded to map triggers to -32767-32767, and
consider this API to not brake application that have workarounds for
this.
Or is it?

2013/12/14 Ken Phillis Jr <kphillisjr@gmail.com>:
> On Wed, Dec 11, 2013 at 2:15 AM, Benjamin Franzke
> <benjaminfranzke@googlemail.com> wrote:
>> Gamepads like XInput devices have triggers with a range from
>> e.g. 0 to 255.
>> When the conventional joydev AXES correction/mapping method is used,
>> the default state 0 (i.e. when the user does not press a button or trigger)
>> is mapped to -32767 (and 255 to 32767).
>> You'll get 0 only when pressing the trigger half-way down.
>> This has several drawbacks:
>>  - A trigger is not usable at all when configured to have 2 directions
>>    when there is physically only one.
>>  - Applications that let the user configure joystick input assignments
>>    may register the mapped non-zero default state as a press,
>>    preventing the user from configuring any sensible value.
>>
>> Traditonal calibration e.g. with jscal does not help to get a usable
>> experience either, it'll map the default state to -32767 as well.
>> Only manually editing the calibration data does work currently.
>>
>> This patch tries to fix this issue by calculating a positive-only range for
>> the throttle break and gas ABS bits.
>> Maybe other ABS types need to be added to this scheme as well(?)
>>
>> Note:
>> Although joydev is considered obsolete and people are encouraged to just
>> use evdev, joydev should still be fixed, because
>>  1. many applications still use it.
>>  2. userspace already copies the joydev correction code to evdev (e.g. libSDL).
>>
>> This bug should be fixed here in joydev first, and when we have a good
>> sensible state, this should be propagated to the application/libraries
>> that copied the joydev correction code.
>>
>> Gamepad drivers will need to advertise triggers as THROTTLE,GAS,BREAK instead
>> of e.g. ABS_{RZ,Z} where phyisically appropriate, to make use of this.
>>
>> I've considered changing the current joydev correction calculation for all ABS
>> types, to have only a scaling functionality by default, no translation
>> (all positive values remain positive, negatives negative and zero remains zero),
>> so that drivers would need to expose zero-centered ABS values.
>> It turned out to many drivers would need to be adjusted, which i cant
>> test.
>>
>> Signed-off-by: Benjamin Franzke <benjaminfranzke@googlemail.com>
>
>
> I have serious concerns that this Patch and the Next patch will the
> input detection of the triggers on various games powered by SDL2. Have
> you tested this against games listed on steam that have full
> controller support?
