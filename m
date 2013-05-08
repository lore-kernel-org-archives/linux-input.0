From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [RFC 24/26] HID: wiimote: support Nintendo Wii U Pro Controller
Date: Wed, 8 May 2013 17:33:05 +0200
Message-ID: <CANq1E4T9eoBVvbq8J+2ps5CJ-9G1782j7TjanqWLJVUCQ1k60g@mail.gmail.com>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
	<1367788390-29835-25-git-send-email-dh.herrmann@gmail.com>
	<CAFmpkyhFHS1CHDLTRbGdYe5B5XkW-JyavZotvffZT3BnkQSdOA@mail.gmail.com>
	<CANq1E4Q9X7+e_HSbB2Y0GykgJAuF9ui1x1GtssiwOXWKhVUfvQ@mail.gmail.com>
	<CAFmpkyiSw3_mXG-bokbcu-wTUAQmMDBYvqpKQg5eT8Ke+vAPrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:47080 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181Ab3EHPdH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 May 2013 11:33:07 -0400
Received: by mail-ie0-f172.google.com with SMTP id 16so3447491iea.17
        for <linux-input@vger.kernel.org>; Wed, 08 May 2013 08:33:05 -0700 (PDT)
In-Reply-To: <CAFmpkyiSw3_mXG-bokbcu-wTUAQmMDBYvqpKQg5eT8Ke+vAPrA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Todd Showalter <todd@electronjump.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Todd

On Mon, May 6, 2013 at 4:14 PM, Todd Showalter <todd@electronjump.com> wrote:
> On Mon, May 6, 2013 at 1:49 AM, David Herrmann <dh.herrmann@gmail.com> wrote:
>
>>>> The Wii U Pro Controller is a new Nintendo remote device that looks very
>>>> similar to the XBox controller. It has nearly the same features and uses
>>>> the same protocol as the Wii Remote.
>>>
>>>     As with the classic controller, could this please be mapped to the
>>> standard gamepad where possible?
>>
>>> - left stick to ABS_LX, ABS_LY
>>> - right stick to ABS_RX, ABS_RY
>>
>> These make sense to me, indeed.
>>
>>> - dpad to ABS_DX, ABS_DY
>>
>> These are digital buttons on this gamepad. What's wrong with
>> KEY_{left, right, up, down}? Or I would prefer BTN_{left, right, up,
>> down} instead.
>
>     Some of the gamepads in evdev currently map their dpads to
> ABS_HAT0X, ABS_HAT0Y.  For the most part I'd be good with switching
> them to buttons; it's mostly just a matter of choosing a standard and
> sticking to it.  The only argument for making them ABS_ values (other
> than "some of them already do that") is the Sony controllers; the PS2
> and PS3 dpads are actually pressure sensitive, and have an effective
> resolution double that of the analog sticks even before you take the
> deadzone into account.  The PS* analog sticks are very noisy and need
> large deadzones, while the dpad pressure sensitivity is quite stable
> around the center for obvious reasons.

See below, same reasons apply here.

>>> - left trigger to ABS_LTRIG
>>> - right trigger to ABS_RTRIG
>>
>> These are also digital buttons, so what's wrong with BTN_TL/TR?
>
>     They're digital on the classic pro, but they're analog on the
> classic, IIRC.  I believe they also have separate "button" values when
> they bottom out, much like the gamecube controller, but that's beyond
> the scope of the standard gamepad I'm proposing.

What's the problem with using both, ABS _and_ BTN? I don't think we
should do any interpretation in the kernel. Devices that have analog
triggers report ABS_XTRIG, devices with digital triggers report
BTN_TX. Userspace simply needs to listen for both. And if a device
exports both (like the Wii classic controller), they simply export
both and userspace chooses whatever it prefers.

As long as both ABS_XTRIG and BTN_TX are defined to correspond to the
same triggers, I think it's better to use both. Or am I missing
something?

>>> - x to BTN_NORTH
>>> - a to BTN_EAST
>>> - b to BTN_SOUTH
>>> - y to BTN_WEST
>>
>> These make sense to me. At least keyboards also return the American
>> keycodes instead of trying to guess the label. However, if you want
>> "help texts" in your applications, like "press A to continue", you
>> need a user-space helper library, anyway. Otherwise, you cannot be
>> sure this key is labeled "A" on the current device.
>> That's also the reason why I don't think these mappings really help.
>
>     I'd far rather have position-defined buttons and then some sort of
> mapping I could look up to tell me what the label was on the player's
> controller.  I might want to put help text up, but I definitely want
> to read the button.  Besides, with the standard gamepad I'm proposing
> you could throw up a diagram of the controller with (for example) an
> arrow pointing to a blank NORTH button just saying "Menu" or "Battloid
> Mode" or "Use".
>
>     Making a game is often about deciding where to spend your limited
> resources.  Money, time, artwork and programming effort you spend
> customizing the help screens for different controllers is effort not
> being spent on making the part of the game that people play better.

As I said before, I don't really care. I will send v2 with a patch
that introduces these buttons. Lets see what Dmitry thinks.

But we need a user-space library, anyway, to get button-names (as I
explained earlier).

>>> - zl to BTN_LSHOULDER
>>> - zr to BTN_RSHOULDER
>>
>> Again, why not reuse BTN_ZL/ZR?
>
>     Because there are equivalent controls on lots of other gamepads.
> L1/R1 on sony gamepads, LB/RB on xbox 360, and so forth.  Again, it's
> the position and function that matters, not the arbitrary label on the
> button.  The label on the button is only arguably useful for help
> text, but there is *so much* variance in labeling between functionally
> identical hardware that it makes no sense to waste the development
> effort on custom per-controller help text.

No, I meant what's wrong with re-using BTN_ZX for this purpose? Why
introduce new constants? Just say, all new drivers must not use BTN_ZX
if it's not a shoulder button. This avoids introducing BTN_XSHOULDER.

And btw., there is no BTN_ZL/ZR, I meant BTN_TL2/TR2.. sorry for the
confusion, my bad.

>>> - plus to BTN_START
>>> - minus to BTN_SELECT
>>> - home to BTN_SYSTEM
>>
>> The other Nintendo drivers return BTN_MODE for "home". Could you
>> explain what's wrong with that?
>
>     It's not essential; we could make the others do BTN_MODE.  The
> idea is that we've got what's essentially a system request button on
> many gamepads; a button whose job is to bypass the game and bring up
> the underlying OS.  On recent Nintendo controllers (Wii, WiiU) it's
> the "Home" button.  On PS3 it's the playstation logo button.  On XBox
> 360 controllers it's the big glowy X button.
>
>     All of those are attempting to solve the same problem on their
> respective consoles; how does one simply get through a full-screen
> game to talk to the OS when the gamepad is the primary input method
> and all of its functions have game mappings?  The answer in all three
> cases was to put a system button on the controller that games aren't
> allowed to map.
>
>     We're not bound by that, obviously, but in the case of living room
> gaming PCs where we may well have Linux boxes that are being treated
> like game consoles much of the time, having a standardized system
> request button on gamepads that have appropriate hardware is a useful
> abstraction.  I'm suggesting calling it BTN_SYSTEM rather than
> BTN_MODE because to me BTN_MODE implies different things, but it's
> admittedly semantics at that point.

So how about the following?

+static const __u16 wiimod_pro_map[] = {
+       BTN_EAST,          /* WIIMOD_PRO_KEY_A */
+       BTN_SOUTH,          /* WIIMOD_PRO_KEY_B */
+       BTN_NORTH,          /* WIIMOD_PRO_KEY_X */
+       BTN_WEST,          /* WIIMOD_PRO_KEY_Y */
+       BTN_START,      /* WIIMOD_PRO_KEY_PLUS */
+       BTN_SELECT,     /* WIIMOD_PRO_KEY_MINUS */
+       BTN_MODE,       /* WIIMOD_PRO_KEY_HOME */
+       BTN_DLEFT,       /* WIIMOD_PRO_KEY_LEFT */
+       BTN_DRIGHT,      /* WIIMOD_PRO_KEY_RIGHT */
+       BTN_DUP,         /* WIIMOD_PRO_KEY_UP */
+       BTN_DDOWN,       /* WIIMOD_PRO_KEY_DOWN */
+       BTN_TL,         /* WIIMOD_PRO_KEY_TL */
+       BTN_TR,         /* WIIMOD_PRO_KEY_TR */
+       BTN_TL2,        /* WIIMOD_PRO_KEY_ZL */
+       BTN_TR2,        /* WIIMOD_PRO_KEY_ZR */
+       BTN_THUMBL,     /* WIIMOD_PRO_KEY_THUMBL */
+       BTN_THUMBR,     /* WIIMOD_PRO_KEY_THUMBR */
+};

That would introduce BTN_DLEFT/DRIGHT/DUP/DDOWN for D-Pad buttons and
BTN_EAST/SOUTH/NORTH/WEST for action buttons.

If everyone is ok with this, I will resend the patches for
Pro-Controller after the other parts of this series got
applied/acked/nacked/whatever. I will also add some documentation to
src/Documentation/input/ and try to see what we can do about the other
gamepads.

Thanks
David
