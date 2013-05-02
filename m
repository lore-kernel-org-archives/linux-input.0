From: Todd Showalter <todd@electronjump.com>
Subject: Re: Game Controllers
Date: Thu, 2 May 2013 11:37:48 -0400
Message-ID: <CAFmpkyhtrby3OR7zFq3af6SKEBu24AD47bF2y9gdqMWnwgbG9Q@mail.gmail.com>
References: <CAFmpkyiqcwhbJc2A+Ntyisc_CD2z9ssBUQDv6TKvQCX4ES8DOQ@mail.gmail.com>
	<2483279.JlnWrOX8Uv@dtor-d630.eng.vmware.com>
	<CAFmpkyiS+L6OsGmobjHqqJ8AFNNiDk4DYYFo_1GQx2kV_dam1Q@mail.gmail.com>
	<20130502083547.279d08a3cbd7a115489de4b7@studenti.unina.it>
	<CAFmpkygZ+xvpwp9KQr6O4emk2f1Bn0EBS0WeN1ji0qVUJz2rwA@mail.gmail.com>
	<CANq1E4QstEwpxEReYOsmJhPMED+eWv3SBSEMzYMNVq5Ywme38g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:45821 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932164Ab3EBPhu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 May 2013 11:37:50 -0400
Received: by mail-lb0-f175.google.com with SMTP id w20so663831lbh.34
        for <linux-input@vger.kernel.org>; Thu, 02 May 2013 08:37:48 -0700 (PDT)
In-Reply-To: <CANq1E4QstEwpxEReYOsmJhPMED+eWv3SBSEMzYMNVq5Ywme38g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Antonio Ospite <ospite@studenti.unina.it>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Thu, May 2, 2013 at 10:09 AM, David Herrmann <dh.herrmann@gmail.com> wrote:

> What do you do with devices that don't provide these buttons? (like
> the Wii Remote) What do you do with HID devices which include the
> mapping in their HID-descriptor (you need fixup HID-descriptors for
> each and every incompatible device..)? What do you do with input
> devices that are half gamepad, half mouse (or whatever..)?

    Regardless of how they identify themselves, devices that don't
provide the base gamepad functionality don't meet the standard, so
they don't need to conform.  The wii remote can also be used as a
mouse (it has buttons, it can (sort of) sense screen position), but it
doesn't make sense to bend the mouse protocol to support them.

    With mice, we're reasonably lucky in that the HID spec mostly
makes devices do the right thing, but consider the case of the
trackball on my desk, the Kensington Slimblade.  It has four buttons,
and fakes a scroll wheel with clockwise and counterclockwise rotation
of the ball.  It presents itself as a HID mouse.  Except the third and
fourth buttons, rather than coming over the wire as buttons, are
actually set as bits in hid->usage.  The kernel driver maps them to
BTN_MIDDLE and BTN_SIDE (see hid-kensington.c::31-32), and nothing
except the kernel needs to care.

> The thing is, I doubt that there is a good "generic" gamepad idea that
> we can use as a model. Yes, the three major gamepads may be very
> similar, but the kernel supports a lot more devices. Are you only
> interested in GamePad-like devices? What do you want to do with
> devices that can be used as a gamepad, but also as another device? If
> you change them, you might make their "native" mapping very weird.
> For instance, the WiiRemote can be used as gamepad (expecially if used
> with extension devices), but also as a totally different input device
> with accelerometer and IR cam. So you can map the extension
> analog-button as ABS_X/Y, but that means, the accelerometer cannot be
> mapped as ABS_X/Y. So this means the accelerometer API breaks (and is
> inconsistent with other devices). And so on...

    There's a very good gamepad abstraction; it's the common set of
controls between:

- the ps3 sixaxis
- the xbox controller
- the xbox 360 controller
- the ouya controller
- the wii classic controller
- all the OEM 360 controllers

    That covers a whole lot of ground, and as a game developer it
covers most of the ground I care about for most games that aren't
keyboard/mouse.

    Sure, you can configure the wiimote in a lot of ways.  As a game
developer on the Wii (which I am; I've a Wii devkit right here), I
care about the controller configurations because it's the standard
controller on the system.  As a game developer on the PC, I couldn't
care less about it; there are probably less than a hundred people in
the world trying to play games with the Wii controller in Linux.  Most
of the people connecting Wii controllers to Linux boxes are doing
something entirely else with them.

    The standard gamepad (2 sticks, dpad, 2 triggers, 2 shoulder
buttons, 4 face buttons, start button, system button, stick click
buttons) is well established; the PS3 uses it, the XBox 360 uses it,
the Wii has it in the Classic controller, the Ouya uses it, the
GameStick uses it, all the OEM console game controllers use it, the
PS2 used it, the GameCube used it... I'll be fairly surprised if the
next XBox and the PS4 don't use it as well.  It is now as standard as
an input device as the 3 button plus scrollwheel mouse.

    All it lacks is a rigorous HID standard, which is why we have the
mess we have now.

> So please, go ahead and fix all the broken drivers that report wrong
> values. I think everyone here would appreciate that a lot. But you
> must know that it is hard work. You need to check all the different
> device-revisions, verify that other devices don't break just because
> your gamepad-revision returns other values. You might need
> backwards-compatible keymaps, module-flags and so on.
> Many of the device drivers were written by hobby-developers so their
> devices work. Many of them might not be around anymore or only have
> time to fix bugs.

    I'm not afraid of the work; it's more a question of whether I can
dig up the hardware to test these things.  I've an xbox controller, a
360 controller, and a ps3 controller.  I've also got Wii controllers,
but my Linux box doesn't have bluetooth.

    Ok, here's a question: could gamepad-like devices have two dev
entries?  One that exported the full raw device, and one that
responded to EVIOCGNAME with "Standard Gamepad"?  That way, the raw
device in all its glory would be available for anything that wanted to
understand the device, and games that just wanted bog standard console
gamepad controls could have it without having to jump through hoops.

    It would also mean we could just leave the raw interface alone, so
that if anyone is counting on it it doesn't change.

    The only hassle would be supplying some way for a game that cared
about both to know that (say) /dev/input/event15 and
/dev/input/event16 were actually different views of the same device.

> So if you want reliable gamepads, the easiest way is a user-space
> mapping based on device-names. This guarantees you get the expected
> buttons. Adding support for new devices is a matter of few lines of
> code. And it normally takes >1 month for a device driver gets included
> in the kernel, so you have enough time adding the support to your
> user-space side.
> This also allows you to easily support devices that are no gamepads,
> but would make sense with your applications.
>
> I would really appreciate, if you help fixing those drivers instead of
> using the user-space mappings. But I just want to warn you, that it is
> more work than you might think.
>
> Cheers
> David



--
 Todd Showalter, President,
 Electron Jump Games, Inc.
