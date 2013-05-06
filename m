From: Todd Showalter <todd@electronjump.com>
Subject: Re: [RFC 24/26] HID: wiimote: support Nintendo Wii U Pro Controller
Date: Mon, 6 May 2013 10:14:52 -0400
Message-ID: <CAFmpkyiSw3_mXG-bokbcu-wTUAQmMDBYvqpKQg5eT8Ke+vAPrA@mail.gmail.com>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
	<1367788390-29835-25-git-send-email-dh.herrmann@gmail.com>
	<CAFmpkyhFHS1CHDLTRbGdYe5B5XkW-JyavZotvffZT3BnkQSdOA@mail.gmail.com>
	<CANq1E4Q9X7+e_HSbB2Y0GykgJAuF9ui1x1GtssiwOXWKhVUfvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qe0-f42.google.com ([209.85.128.42]:65290 "EHLO
	mail-qe0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811Ab3EFOOx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 May 2013 10:14:53 -0400
Received: by mail-qe0-f42.google.com with SMTP id 1so2082904qee.15
        for <linux-input@vger.kernel.org>; Mon, 06 May 2013 07:14:53 -0700 (PDT)
In-Reply-To: <CANq1E4Q9X7+e_HSbB2Y0GykgJAuF9ui1x1GtssiwOXWKhVUfvQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

On Mon, May 6, 2013 at 1:49 AM, David Herrmann <dh.herrmann@gmail.com> wrote:

>>> The Wii U Pro Controller is a new Nintendo remote device that looks very
>>> similar to the XBox controller. It has nearly the same features and uses
>>> the same protocol as the Wii Remote.
>>
>>     As with the classic controller, could this please be mapped to the
>> standard gamepad where possible?
>
>> - left stick to ABS_LX, ABS_LY
>> - right stick to ABS_RX, ABS_RY
>
> These make sense to me, indeed.
>
>> - dpad to ABS_DX, ABS_DY
>
> These are digital buttons on this gamepad. What's wrong with
> KEY_{left, right, up, down}? Or I would prefer BTN_{left, right, up,
> down} instead.

    Some of the gamepads in evdev currently map their dpads to
ABS_HAT0X, ABS_HAT0Y.  For the most part I'd be good with switching
them to buttons; it's mostly just a matter of choosing a standard and
sticking to it.  The only argument for making them ABS_ values (other
than "some of them already do that") is the Sony controllers; the PS2
and PS3 dpads are actually pressure sensitive, and have an effective
resolution double that of the analog sticks even before you take the
deadzone into account.  The PS* analog sticks are very noisy and need
large deadzones, while the dpad pressure sensitivity is quite stable
around the center for obvious reasons.

>> - left trigger to ABS_LTRIG
>> - right trigger to ABS_RTRIG
>
> These are also digital buttons, so what's wrong with BTN_TL/TR?

    They're digital on the classic pro, but they're analog on the
classic, IIRC.  I believe they also have separate "button" values when
they bottom out, much like the gamecube controller, but that's beyond
the scope of the standard gamepad I'm proposing.

>> - x to BTN_NORTH
>> - a to BTN_EAST
>> - b to BTN_SOUTH
>> - y to BTN_WEST
>
> These make sense to me. At least keyboards also return the American
> keycodes instead of trying to guess the label. However, if you want
> "help texts" in your applications, like "press A to continue", you
> need a user-space helper library, anyway. Otherwise, you cannot be
> sure this key is labeled "A" on the current device.
> That's also the reason why I don't think these mappings really help.

    I'd far rather have position-defined buttons and then some sort of
mapping I could look up to tell me what the label was on the player's
controller.  I might want to put help text up, but I definitely want
to read the button.  Besides, with the standard gamepad I'm proposing
you could throw up a diagram of the controller with (for example) an
arrow pointing to a blank NORTH button just saying "Menu" or "Battloid
Mode" or "Use".

    Making a game is often about deciding where to spend your limited
resources.  Money, time, artwork and programming effort you spend
customizing the help screens for different controllers is effort not
being spent on making the part of the game that people play better.

>> - zl to BTN_LSHOULDER
>> - zr to BTN_RSHOULDER
>
> Again, why not reuse BTN_ZL/ZR?

    Because there are equivalent controls on lots of other gamepads.
L1/R1 on sony gamepads, LB/RB on xbox 360, and so forth.  Again, it's
the position and function that matters, not the arbitrary label on the
button.  The label on the button is only arguably useful for help
text, but there is *so much* variance in labeling between functionally
identical hardware that it makes no sense to waste the development
effort on custom per-controller help text.

>> - plus to BTN_START
>> - minus to BTN_SELECT
>> - home to BTN_SYSTEM
>
> The other Nintendo drivers return BTN_MODE for "home". Could you
> explain what's wrong with that?

    It's not essential; we could make the others do BTN_MODE.  The
idea is that we've got what's essentially a system request button on
many gamepads; a button whose job is to bypass the game and bring up
the underlying OS.  On recent Nintendo controllers (Wii, WiiU) it's
the "Home" button.  On PS3 it's the playstation logo button.  On XBox
360 controllers it's the big glowy X button.

    All of those are attempting to solve the same problem on their
respective consoles; how does one simply get through a full-screen
game to talk to the OS when the gamepad is the primary input method
and all of its functions have game mappings?  The answer in all three
cases was to put a system button on the controller that games aren't
allowed to map.

    We're not bound by that, obviously, but in the case of living room
gaming PCs where we may well have Linux boxes that are being treated
like game consoles much of the time, having a standardized system
request button on gamepads that have appropriate hardware is a useful
abstraction.  I'm suggesting calling it BTN_SYSTEM rather than
BTN_MODE because to me BTN_MODE implies different things, but it's
admittedly semantics at that point.

                                                Todd.

--
 Todd Showalter, President,
 Electron Jump Games, Inc.
