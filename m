From: Todd Showalter <todd@electronjump.com>
Subject: Re: Game Controllers
Date: Mon, 29 Apr 2013 20:46:47 -0400
Message-ID: <CAFmpkyiS+L6OsGmobjHqqJ8AFNNiDk4DYYFo_1GQx2kV_dam1Q@mail.gmail.com>
References: <CAFmpkyiqcwhbJc2A+Ntyisc_CD2z9ssBUQDv6TKvQCX4ES8DOQ@mail.gmail.com>
	<2483279.JlnWrOX8Uv@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:35240 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759379Ab3D3Aqt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Apr 2013 20:46:49 -0400
Received: by mail-qc0-f169.google.com with SMTP id t2so3472795qcq.0
        for <linux-input@vger.kernel.org>; Mon, 29 Apr 2013 17:46:48 -0700 (PDT)
In-Reply-To: <2483279.JlnWrOX8Uv@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Mon, Apr 29, 2013 at 5:04 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

>>     I'm a game developer, and I'm interested in discussing changes in
>> the way gamepad input is handled at the evdev and device level; is
>> this the correct place to do that?
>
> It might or it might not. It would be great if you could tell a bit about
> your issues.

    My primary concern is game controllers (specifically gamepads).
I'd like to see a standard game controller (something akin to the
input functionality of the xbox 360 controller) become a first-class
input citizen alongside the keyboard and mouse.  My argument is
essentially that amongst the major gamepads (the ps3 6axis controller,
the xbox 360 controller, the xbox controller, the wii classic
controller, the ouya controller, and various OEM versions and
imitations of the same) there is a lot of common functionality that is
worth exposing as a standard gamepad the same way systems now expose a
standard mouse.

    My proposed standard gamepad is:

- left stick (2d vector, each component [-1.0f .. 1.0f])
- right stick (2d vector, each component [-1.0f .. 1.0f])
- left trigger (1d vector, [-1.0f .. 1.0f])
- right trigger (1d vector, [-1.0f .. 1.0f])
- dpad
- start button
- system button (home on wii, ps on ps3, glowy x on xbox 360)
- four face buttons (north, south, east, west)
- two shoulder buttons
- two stick click buttons

    What I'd like to request at the evdev level is that things which
are gamepads export these values in standard offsets, so that:

EV_ABS 0 == left stick x
EV_ABS 1 == left stick y
EV_ABS 2 == right stick x
EV_ABS 3 == right stick y
EV_ABS 4 == dpad x
EV_ABS 5 == dpad y
EV_ABS 6 == left trigger
EV_ABS 7 == right trigger

    Or some similar defined order.  I'd like buttons to be similarly mapped:

BTN_START == start button
BTN_WEST == xbox x, ps square
BTN_NORTH == xbox y, ps triangle
BTN_EAST == xbox b, ps circle
BTN_SOUTH == xbox a, ps x
BTN_TL == xbox tl, ps l1
BTN_TR == xbox tr, ps r1
BTN_MODE == xbox glowy x, ps ps
BTN_THUMBL == stick click l
BTN_THUMBR == stick click r

    I'm aware that the xbox and xbox 360 controllers are already
largely mapped this way, but the ps3 controller is not, at least from
what I can tell, and I have no other gamepad hardware to test.  My
goal here is to make it so that something reading an evdev gamepad
stream doesn't need to know what kind of hardware device is backing it
*if* all the reader cares about is the standard gamepad functionality.

    The analogy here is mice; while you can get mice with variable DPI
settings, macro engines and loads of buttons or scroll wheels, normal
applications don't have to query the mouse type to know how the core
functionality is mapped.  If all I want in a game is the left stick
for movement, the bottom face button for jump and the right face
button for shoot, I shouldn't have to be querying the controller to
figure out how those are mapped.  I should be able to take ABS_X and
ABS_Y for the left stick, BTN_SOUTH for jump and BTN_EAST for shoot,
and it should map to the proper buttons and stick regardless of
whether the player has an xbox controller, a logitech controller, a
ps3 controller or a wiimote with a classic controller plugged in.

    There are several advantages of doing this remapping at the driver
level, but the most important ones from my point of view are that it
is simplest to do near the source, and it makes supporting a standard
gamepad as part of (for instance) Wayland a much simpler and thinner
translation layer.  I want to do this through a Wayland (or X11) event
protocol because I want my game (which may be running mods or scripts
downloaded from forums) to be as isolated as possible from the
elevated privileges that opening evdev streams requires.

    So, that's my issue, really; I'd like a standardized core gamepad
protocol in Linux, and I'm talking to people at every level of the
stack to see if I can make it happen.

                                       Todd.

--
 Todd Showalter, President,
 Electron Jump Games, Inc.
