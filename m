From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: Game Controllers
Date: Thu, 2 May 2013 19:54:40 +0200
Message-ID: <CANq1E4RRFNPZ-z86yny89hViMWREpG1f1in5O3kT8usHO57YAQ@mail.gmail.com>
References: <CAFmpkyiqcwhbJc2A+Ntyisc_CD2z9ssBUQDv6TKvQCX4ES8DOQ@mail.gmail.com>
	<2483279.JlnWrOX8Uv@dtor-d630.eng.vmware.com>
	<CAFmpkyiS+L6OsGmobjHqqJ8AFNNiDk4DYYFo_1GQx2kV_dam1Q@mail.gmail.com>
	<20130502083547.279d08a3cbd7a115489de4b7@studenti.unina.it>
	<CAFmpkygZ+xvpwp9KQr6O4emk2f1Bn0EBS0WeN1ji0qVUJz2rwA@mail.gmail.com>
	<20130502170103.GC28625@core.coreip.homeip.net>
	<CAFmpkygr5c-munK9ix=exq4KRgDEUbP+OP_AABuuTR1P_2V1-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:63228 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760857Ab3EBRyl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 May 2013 13:54:41 -0400
Received: by mail-ia0-f174.google.com with SMTP id e36so687164iag.33
        for <linux-input@vger.kernel.org>; Thu, 02 May 2013 10:54:40 -0700 (PDT)
In-Reply-To: <CAFmpkygr5c-munK9ix=exq4KRgDEUbP+OP_AABuuTR1P_2V1-g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Todd Showalter <todd@electronjump.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi Todd

On Thu, May 2, 2013 at 7:35 PM, Todd Showalter <todd@electronjump.com> wrote:
> On Thu, May 2, 2013 at 1:01 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> On Thu, May 02, 2013 at 09:46:44AM -0400, Todd Showalter wrote:
>>>
>>> left stick: ABS_X, ABS_Y
>>> right stick: ABS_RX, ABS_RY
>>
>> Not sure about this one. Originally RX, RY and RZ were introduces for
>> device having more than 3 degress of freedom; and RX is used by many
>> joystick devices. We'd ether need a property bit to distinguish gamepad
>> from a joystick or simply ass ABS_X2, ABS_Y2 etc for the second stick.
>
>     I'd be happy to have ABS_LX, ABS_LY and ABS_RX, ABS_RY, I was just
> looking at what was available in input.h and what the xbox pads were
> already doing.  Likewise, mapping the dpad as HAT0X, HAT0Y is a little
> wierd and ABS_DX, ABS_DY would probably be better.
>
>>> dpad: ABS_HAT0X, ABS_HAT0Y
>>> left trigger: ABS_Z
>>
>> Huh?
>>
>>> right trigger: ABS_RZ
>>
>> Not at all. These are not absolute events but rather buttons, so let's
>> define them as such.
>
>     Most game controllers these days (including ps3 and xbox/xbox 360)
> have analog shoulder triggers.  On Microsoft, LT and RT are analog
> (0..255) and LB and RB are digital.  On ps3, L1, L2, R1 and R2 are
> actually pressure sensitive and are exported both as analog (0..255)
> and digital; I figured we'd treat LR1 as digital, LR2 as analog.  The
> Wii Classic controller has L and R analog, ZL and ZR digital, though
> IIRC the Classic Pro controller has L and R as digital.
>
>     Here's a complete mapping for some well known controllers:
>
> left stick
>   - ps3, xbox, xbox360, wiiclassic, ouya -- left stick
>
> right stick
>   - ps3, xbox, xbox360, wiiclassic, ouya -- right stick
>
> dpad
>   - ps3, xbox, xbox360, wiiclassic, ouya -- dpad
>
> shoulder analog triggers
>   - ps3 -- L2, R2, use pressure values
>   - xbox, xbox360 -- LT, RT
>   - wiiclassic -- L, R
>   - ouya -- unsure what they're called, but it has them
>
> shoulder digital buttons
>   - ps3 -- L1, R1
>   - xbox, xbox360 -- LB, RB
>   - wiiclassic -- ZL, ZR
>   - ouya -- unsure what they're called, but it has them
>
> face buttons (NORTH, EAST, SOUTH, WEST)
>   - ps3 -- triangle, circle, x, square
>   - xbox, xbox360 -- Y, B, A, X
>   - wiiclassic -- x, a, b, y
>   - ouya -- Y, A, O, U
>
> stick buttons
>   - ps3, xbox, xbox360, wiiclassic -- left stick click, right stick click
>   - ouya -- unsure if this is supported,
>
> start button
>   - ps3, xbox, xbox360, wiiclassic -- start
>   - ouya -- not present, developers are asking for one
>
> system button
>   - ps3 -- playstation logo button
>   - xbox -- not available
>   - xbox360 -- glowy x button
>   - ouya -- system (U) button
>
> select button -- arguable
>   - ps3, wiiclassic -- select
>   - xbox, xbox360 -- back
>   - ouya -- not present, developers are asking for one
>
>                                       Todd.

How about a new input property that marks devices that follow general
rules as such? So for instance:
  INPUT_PROP_DEV_MOUSE
  INPUT_PROP_DEV_KEYBOARD
  INPUT_PROP_DEV_GAMEPAD
  INPUT_PROP_DEV_JOYSTICK
And so on. And then we can decide on a generic mapping for each. We
only set these properties on devices that follow the generic mapping.
Devices that don't have these flags set are non-generic or have weird
keymaps. This would also solve problems were the xserver thinks some
gamepads or accelerometers are a mouse (or similar).

This allows user-space to detect generic devices. For all other device
types, they need special support, anyway. They can still use the same
heuristics that they use now, but we can try to provide a generic flag
to avoid these often wrong heuristics.
I talked with Kay (udev maintainer) and he was really opposed to huge
udev black/white-lists that mark devices as generic MOUSE, KEYBOARD,
TOUCHPAD, ... These kernel properties would really help, but require
agreement on a generic mapping.

And as Dmitry noted, we cannot change legacy drivers due to backwards
compatibility. A separate /dev/input/gamepad* interface just wastes
resources when all you want is just a different and consistent
mapping.
Why not try to create a /usr/share/gamepad/*.map filetype and let
distros ship these files. Your game can then parse these into a table
and use the mappings for all legacy gamepads.
Or provide a "enable_legacy_mapping=true" module option for legacy
gamepad-drivers which allows to switch between different mappings
(even though that would be a global flag).

I still think the problems with user-space mappings can be solved. And
we should avoid wasting kernel memory for an interface that does
nothing more than change button-mappings.

Cheers
David
