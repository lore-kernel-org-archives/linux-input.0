From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] Input: gamepad - use independent axes for analog D-Pad buttons
Date: Mon, 30 Dec 2013 12:44:21 +0100
Message-ID: <CANq1E4TQJs_pqzL8u_zTneDg6_4Bt_s5DBaCJ1ei+mvhVxpgLQ@mail.gmail.com>
References: <1387815463-29345-1-git-send-email-ospite@studenti.unina.it>
	<20131230005209.GC11528@core.coreip.homeip.net>
	<20131230122020.ebaaefb09375e371c2178b38@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:55448 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755556Ab3L3LoW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Dec 2013 06:44:22 -0500
Received: by mail-ig0-f171.google.com with SMTP id c10so35172807igq.4
        for <linux-input@vger.kernel.org>; Mon, 30 Dec 2013 03:44:21 -0800 (PST)
In-Reply-To: <20131230122020.ebaaefb09375e371c2178b38@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi

On Mon, Dec 30, 2013 at 12:20 PM, Antonio Ospite
<ospite@studenti.unina.it> wrote:
> On Sun, 29 Dec 2013 16:52:09 -0800
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
>> Hi Antonio,
>>
>> On Mon, Dec 23, 2013 at 05:17:43PM +0100, Antonio Ospite wrote:
>> > Model this part of the API after the Sony PlayStation 3 Controller which
>> > exposes independent analog values for each one of the D-Pad buttons.
>> >
>> > The PS3 programming API psl1ght also maps the analog D-Pad buttons
>> > individually.
>>
>> Hmm, even though the hardware is capable of producing independent analog
>> values does are they really useful? Looking at my PS3 controller I do
>> not think users will be pressing up/down and left/right dpad buttons at
>> the same time.
>>
>
> I must agree it's unlikely, while still possible.
>
>> I'd rather keep using ABS_HAT0X/Y unless there is really good reason for
>> introducing new events.
>>
>
> Having analog D-Pad values reported independently was proposed for these
> reasons:
>
>  - it matches _some_ existing hardware closely (that was the main
>    reason TBH, to simplify the drivers);
>
>  - it happens to follow what it's being done for D-Pad digital buttons,
>    they are also reported independently.
>
> However if some other hardware reported D-Pad axis combined already
> then I agree that using something like ABS_HAT0X/Y is safer, I see
> decomposing HORIZ/VERT into the separate LEFT/RIGHT and UP/DOWN to be
> less intuitive (not harder tho).
>
> Another doubt: David, in the other email you mentioned we could use
> ABS_DPAD_HORIZ/VERT, any particular reason to introduce them in place
> of ABS_HAT0X/Y?

A "HAT" is an axis on the top of a joystick, nothing else. It seems
troublesome to overload the definition (which we did for many years).
Device-detection based on advertised ABS-bits gets pretty hard if we
reuse ABS-bits for different hardware. The most annoying example of
what happens is accelerometers being misdetected by Xorg as
mouse-input because they reuse ABS_X/Y.

Thanks
David
