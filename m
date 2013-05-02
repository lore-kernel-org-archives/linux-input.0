From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Game Controllers
Date: Thu, 2 May 2013 11:29:36 -0700
Message-ID: <20130502182935.GD28625@core.coreip.homeip.net>
References: <CAFmpkyiqcwhbJc2A+Ntyisc_CD2z9ssBUQDv6TKvQCX4ES8DOQ@mail.gmail.com>
 <2483279.JlnWrOX8Uv@dtor-d630.eng.vmware.com>
 <CAFmpkyiS+L6OsGmobjHqqJ8AFNNiDk4DYYFo_1GQx2kV_dam1Q@mail.gmail.com>
 <20130502083547.279d08a3cbd7a115489de4b7@studenti.unina.it>
 <CAFmpkygZ+xvpwp9KQr6O4emk2f1Bn0EBS0WeN1ji0qVUJz2rwA@mail.gmail.com>
 <CANq1E4QstEwpxEReYOsmJhPMED+eWv3SBSEMzYMNVq5Ywme38g@mail.gmail.com>
 <CAFmpkyj+MV0+v8zKiKVAYX4uQHLv3jdCo=VR4nb=-M9NOUGYWg@mail.gmail.com>
 <20130502163824.GA28625@core.coreip.homeip.net>
 <CAFmpkyjO8WwUxOJ2BtULwOTcfYs7sjdWMS_=Fcho996VijEFHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f50.google.com ([209.85.210.50]:62959 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761663Ab3EBS3k (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 May 2013 14:29:40 -0400
Received: by mail-da0-f50.google.com with SMTP id i23so426937dad.23
        for <linux-input@vger.kernel.org>; Thu, 02 May 2013 11:29:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAFmpkyjO8WwUxOJ2BtULwOTcfYs7sjdWMS_=Fcho996VijEFHg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Todd Showalter <todd@electronjump.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, Antonio Ospite <ospite@studenti.unina.it>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Thu, May 02, 2013 at 01:06:59PM -0400, Todd Showalter wrote:
> On Thu, May 2, 2013 at 12:38 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> 
> > I wish we have gotten all the mappings correct from the get go, but that
> > did not happen, so now we need to move forward. That means that we can
> > establish the canonical mapping and try to follow it for the new
> > devices, but you still need to support older devices and for that you
> > will still need mapping.
> 
>     That's why I'm suggesting having /dev/input/gamepad* devices
> alongside the equivalent /dev/input/event* devices.  All current users
> are either looking at js* or event* device nodes, so as long as those
> are left unchanged, nothing breaks.  New users can open gamepad* and
> know that they'll get consistent results.
> 
>     New devices can support the gamepad mapping so that what gets
> exported in event* and js* is in canonical order, and older devices
> will just work as they always did.  I strongly suspect once that's in
> place you'll find that most users go straight to the new interface.
> 
>     I'm also talking to the Wayland folks and offering to do the
> gamepad event protocol code, and if /dev/input/gamepad* is available
> that's definitely what I plan to feed into the Wayland event system.
> 
> >>     Really, what I want is roughly what /dev/input/js* has, but as
> >> /dev/input/gamepad* with standardized mapping.
> >
> > This is understandable but I do not believe this should be done in
> > kernel, but rather in userspace.
> 
>     I can see why you believe that, but personally I think the kernel
> is exactly where it belongs:
> 
> - it's a useful abstraction, as useful for games as the standard mouse
> and standard keyboard are for other programs -- programs don't have to
> call a translation library to remap mouse input

That is because all mice generate standard events. Note that mice users
do not have a dedicated interface (mousedev is legacy and nothing
remotely modern is using it).

You only need to translate for devices that do not generate the events
you are expecting.

> 
> - the current game controller semi-standard, the js* interface, was
> really designed for 90s era flight simulator joysticks, and while
> gamepads have been wedged into it they aren't a great match

Completely agree. The js interface was here way before we had the
current input subsystem with evdev interface that is proved to be
flexible enough. So when evdev was created joydev was implemented to
keep compatibility with older software. Newer software again is expected
to use evdev exclusively (from kernel POV, there can/should be userspace
layers on top).

> 
> - any mapping library is going to have to be a mirror of the kernel
> code, which means it's basically just a lot of duplicated effort with
> the added penalty of update lag

The library can do much more than that. You also need to calibrate the
device (per user), adjust it to user's tastes and so on. Maybe you have
a user that is left-handed and you'd like to remap some keys? It is
certainly not kernel's job.

There also should not be lag if new devices follow the agreed upon
mapping.

> 
>     Why not fix the problem at the source?  Creating a
> /dev/input/gamepad* device node for each gamepad in addition to the
> event* device node solves the whole problem.  It leaves the old
> interface intact, it only brings the new interface online for devices
> that support it (and have had the appropriate support code added), and
> it means that the problem can be tackled piecewise.  At the same time,
> it gives us standard behaviour that a game can rely on.

The same thing can be done in a library. Libraries are easier then
kernels, you do not need to consume memory until needed and you do not
need to do the conversion if it is not needed. And it should be possible
to update the library whereas with kernel you mist likely need to reboot
the box.

Why do people believe that patching the kernel is easier than updating
userspace?

Thanks.

-- 
Dmitry
