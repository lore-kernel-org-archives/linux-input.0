From: =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>
Subject: Re: Simple approach to write PS3/PS4 usermode driver?
Date: Tue, 16 Feb 2016 21:56:19 +0100
Message-ID: <CAM4jgCrRCUQYZBnhKGhc27UTkyzQS=rJOP4jrdT1UGtLDGqNzQ@mail.gmail.com>
References: <56C2270E.9080603@m-reimer.de>
	<20160215223436.fc5a3f66f82ee49b161099ea@ao2.it>
	<56C37C5A.6030303@m-reimer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:36624 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbcBPU4T (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Feb 2016 15:56:19 -0500
Received: by mail-io0-f179.google.com with SMTP id l127so208011200iof.3
        for <linux-input@vger.kernel.org>; Tue, 16 Feb 2016 12:56:19 -0800 (PST)
In-Reply-To: <56C37C5A.6030303@m-reimer.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manuel Reimer <mail+linux-input@m-reimer.de>
Cc: linux-input <linux-input@vger.kernel.org>

2016-02-16 20:45 GMT+01:00 Manuel Reimer <mail+linux-input@m-reimer.de>:
> On 02/15/2016 10:34 PM, Antonio Ospite wrote:
>>
>> Have you tried loading hid.ko with the ignore_special_drivers=1
>> parameter? I guess that will ignore _all_ special drivers tho, even
>> mouse and keyboard ones.
>
>
> Exactly. And so it is not what I planned to do.
>
>> Alan Ott's hidapi[1] is a better alternative to libusb for hid
>> devices.
>
>
> Of course, but just for fun, I'll at least try to use libusb directly. There
> are many examples on the net. I've already collected some code snippets to
> use.
>
>> I reckon a patched kernel is not an option, is it?
>
>
> The kernel side driver does a great job. It has minor bugs (kernel panic
> when disconnecting controller while in game), but nothing too bad.
>
> My plan is to remap to Xbox gamepad button mapping so games actually work
> with the controller. In fact, I bought a brand new PS4 controller just for
> my driver project. At least so far, I only own the PS3 console.
>
> What I've done so far is to write a daemon which connects to the existing
> event device to get events from there, but this didn't really work as games
> still see the original controller.

Do you mean that games still see the events from the device? In that
case you can grab the event device so you are the only one that can
see the events.

If your problem is that the game only look at the first joystick
device, for SDL games, you can try the SDL_JOYSTICK_DEVICE env var
(set to the event node, not the js node IIRC) to force the use of a
specific joystick.

If the game only open /dev/input/js0, you could try to reserve it
before your gamepad is connected then replace with a new instance of
you daemon. I never had to go that far yet.

I have the same problems with my WiiU gamepad but so far I managed to
make every games work with either xboxdrv+SDL_JOYSTICK_DEVICE or with
SDL_GAMECONTROLLERCONFIG (for modern SDL games).

>
> That's why my current plan is to connect one layer deeper so the original
> event devices aren't created at all.
>
> My reason for userspace is, that it's easier to debug and for the potential
> end user it is easier to install. I just had too much trouble with dkms in
> the past.
>
> Best regards,
>
> Manuel
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
