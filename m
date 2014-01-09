From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] Input: gamepad - use independent axes for analog D-Pad buttons
Date: Thu, 9 Jan 2014 15:33:44 +0100
Message-ID: <CANq1E4S-FvO0vh_cFfO0vTWx17Cs9Ya=D3Ldw=pGqK8i3_TbHQ@mail.gmail.com>
References: <1387815463-29345-1-git-send-email-ospite@studenti.unina.it>
	<20131230005209.GC11528@core.coreip.homeip.net>
	<20131230122020.ebaaefb09375e371c2178b38@studenti.unina.it>
	<CANq1E4TQJs_pqzL8u_zTneDg6_4Bt_s5DBaCJ1ei+mvhVxpgLQ@mail.gmail.com>
	<20131230185041.GB3278@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:45303 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978AbaAIOdq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jan 2014 09:33:46 -0500
Received: by mail-ie0-f178.google.com with SMTP id lx4so3473465iec.23
        for <linux-input@vger.kernel.org>; Thu, 09 Jan 2014 06:33:45 -0800 (PST)
In-Reply-To: <20131230185041.GB3278@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Antonio Ospite <ospite@studenti.unina.it>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

Hi Dmitry

On Mon, Dec 30, 2013 at 7:50 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Dec 30, 2013 at 12:44:21PM +0100, David Herrmann wrote:
>> Hi
>>
>> On Mon, Dec 30, 2013 at 12:20 PM, Antonio Ospite
>> <ospite@studenti.unina.it> wrote:
>> > On Sun, 29 Dec 2013 16:52:09 -0800
>> > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>> >
>> >> Hi Antonio,
>> >>
>> >> On Mon, Dec 23, 2013 at 05:17:43PM +0100, Antonio Ospite wrote:
>> >> > Model this part of the API after the Sony PlayStation 3 Controller which
>> >> > exposes independent analog values for each one of the D-Pad buttons.
>> >> >
>> >> > The PS3 programming API psl1ght also maps the analog D-Pad buttons
>> >> > individually.
>> >>
>> >> Hmm, even though the hardware is capable of producing independent analog
>> >> values does are they really useful? Looking at my PS3 controller I do
>> >> not think users will be pressing up/down and left/right dpad buttons at
>> >> the same time.
>> >>
>> >
>> > I must agree it's unlikely, while still possible.
>> >
>> >> I'd rather keep using ABS_HAT0X/Y unless there is really good reason for
>> >> introducing new events.
>> >>
>> >
>> > Having analog D-Pad values reported independently was proposed for these
>> > reasons:
>> >
>> >  - it matches _some_ existing hardware closely (that was the main
>> >    reason TBH, to simplify the drivers);
>> >
>> >  - it happens to follow what it's being done for D-Pad digital buttons,
>> >    they are also reported independently.
>> >
>> > However if some other hardware reported D-Pad axis combined already
>> > then I agree that using something like ABS_HAT0X/Y is safer, I see
>> > decomposing HORIZ/VERT into the separate LEFT/RIGHT and UP/DOWN to be
>> > less intuitive (not harder tho).
>> >
>> > Another doubt: David, in the other email you mentioned we could use
>> > ABS_DPAD_HORIZ/VERT, any particular reason to introduce them in place
>> > of ABS_HAT0X/Y?
>>
>> A "HAT" is an axis on the top of a joystick, nothing else. It seems
>> troublesome to overload the definition (which we did for many years).
>> Device-detection based on advertised ABS-bits gets pretty hard if we
>> reuse ABS-bits for different hardware. The most annoying example of
>> what happens is accelerometers being misdetected by Xorg as
>> mouse-input because they reuse ABS_X/Y.
>
> But they are good as joysticks (also ABS_X/ABS_Y). I do not think having
> all unique events for all device types is feasible. Can we provide hints
> (via properties) to lessen ambiguity, like we do with direct/indirect
> pointers for touchscreens/tablets?

Why don't you think it's feasible? For keys we have one definition for
each key, we don't do KEY_0 to KEY_65535 and just use the first few.
I'd really like to see the same for ABS_*. It's troublesome to detect
devices in user-space otherwise. But I guess your concern is rather
about the implementation than the idea. So could you let me know what
exactly makes you think it's not feasible?

The only problem I see is ->absinfo[] getting too big. My solution for
this would be to add a "uint16_t code" to "struct input_absinfo". So
we keep our current limited ABS set and drivers use just these. But to
add semantics, we can define additional/other ABS2_* or ABS_INFO_*
codes which define what axis this exactly is. So the axis-index is
still the limited ABS code, but to get the semantic code we query
input_absinfo.

Adding additional PROP_* bits is imho the wrong way. For instance if
we use ABS_X/Y for absolute touchpad input and the same for an
accelerometer, devices like the steam-controller couldn't report both
in the same device. Even if they set PROP_TOUCHPAD and PROP_GAMEPAD.

I'd like to get this figured out before I send v3 of the ABS2 patches.

Thanks
David
