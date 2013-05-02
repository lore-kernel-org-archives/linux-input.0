From: Todd Showalter <todd@electronjump.com>
Subject: Re: Game Controllers
Date: Thu, 2 May 2013 13:06:59 -0400
Message-ID: <CAFmpkyjO8WwUxOJ2BtULwOTcfYs7sjdWMS_=Fcho996VijEFHg@mail.gmail.com>
References: <CAFmpkyiqcwhbJc2A+Ntyisc_CD2z9ssBUQDv6TKvQCX4ES8DOQ@mail.gmail.com>
	<2483279.JlnWrOX8Uv@dtor-d630.eng.vmware.com>
	<CAFmpkyiS+L6OsGmobjHqqJ8AFNNiDk4DYYFo_1GQx2kV_dam1Q@mail.gmail.com>
	<20130502083547.279d08a3cbd7a115489de4b7@studenti.unina.it>
	<CAFmpkygZ+xvpwp9KQr6O4emk2f1Bn0EBS0WeN1ji0qVUJz2rwA@mail.gmail.com>
	<CANq1E4QstEwpxEReYOsmJhPMED+eWv3SBSEMzYMNVq5Ywme38g@mail.gmail.com>
	<CAFmpkyj+MV0+v8zKiKVAYX4uQHLv3jdCo=VR4nb=-M9NOUGYWg@mail.gmail.com>
	<20130502163824.GA28625@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:46844 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758913Ab3EBRHB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 May 2013 13:07:01 -0400
Received: by mail-la0-f43.google.com with SMTP id ea20so741134lab.2
        for <linux-input@vger.kernel.org>; Thu, 02 May 2013 10:06:59 -0700 (PDT)
In-Reply-To: <20130502163824.GA28625@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, Antonio Ospite <ospite@studenti.unina.it>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Thu, May 2, 2013 at 12:38 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> I wish we have gotten all the mappings correct from the get go, but that
> did not happen, so now we need to move forward. That means that we can
> establish the canonical mapping and try to follow it for the new
> devices, but you still need to support older devices and for that you
> will still need mapping.

    That's why I'm suggesting having /dev/input/gamepad* devices
alongside the equivalent /dev/input/event* devices.  All current users
are either looking at js* or event* device nodes, so as long as those
are left unchanged, nothing breaks.  New users can open gamepad* and
know that they'll get consistent results.

    New devices can support the gamepad mapping so that what gets
exported in event* and js* is in canonical order, and older devices
will just work as they always did.  I strongly suspect once that's in
place you'll find that most users go straight to the new interface.

    I'm also talking to the Wayland folks and offering to do the
gamepad event protocol code, and if /dev/input/gamepad* is available
that's definitely what I plan to feed into the Wayland event system.

>>     Really, what I want is roughly what /dev/input/js* has, but as
>> /dev/input/gamepad* with standardized mapping.
>
> This is understandable but I do not believe this should be done in
> kernel, but rather in userspace.

    I can see why you believe that, but personally I think the kernel
is exactly where it belongs:

- it's a useful abstraction, as useful for games as the standard mouse
and standard keyboard are for other programs -- programs don't have to
call a translation library to remap mouse input

- the current game controller semi-standard, the js* interface, was
really designed for 90s era flight simulator joysticks, and while
gamepads have been wedged into it they aren't a great match

- any mapping library is going to have to be a mirror of the kernel
code, which means it's basically just a lot of duplicated effort with
the added penalty of update lag

    Why not fix the problem at the source?  Creating a
/dev/input/gamepad* device node for each gamepad in addition to the
event* device node solves the whole problem.  It leaves the old
interface intact, it only brings the new interface online for devices
that support it (and have had the appropriate support code added), and
it means that the problem can be tackled piecewise.  At the same time,
it gives us standard behaviour that a game can rely on.

                                       Todd.

--
 Todd Showalter, President,
 Electron Jump Games, Inc.
