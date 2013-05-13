From: Todd Showalter <todd@electronjump.com>
Subject: Re: [RFC 24/26] HID: wiimote: support Nintendo Wii U Pro Controller
Date: Mon, 13 May 2013 13:40:27 -0400
Message-ID: <CAFmpkyhz_G_qRtx46ZXZLs+zG2WFhmv-=gQCv=tOK6ukQ3DZyw@mail.gmail.com>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
	<1367788390-29835-25-git-send-email-dh.herrmann@gmail.com>
	<CAFmpkyhFHS1CHDLTRbGdYe5B5XkW-JyavZotvffZT3BnkQSdOA@mail.gmail.com>
	<CANq1E4Q9X7+e_HSbB2Y0GykgJAuF9ui1x1GtssiwOXWKhVUfvQ@mail.gmail.com>
	<CAFmpkyiSw3_mXG-bokbcu-wTUAQmMDBYvqpKQg5eT8Ke+vAPrA@mail.gmail.com>
	<CANq1E4T9eoBVvbq8J+2ps5CJ-9G1782j7TjanqWLJVUCQ1k60g@mail.gmail.com>
	<CAFmpkyigapfb52ke-8vvKcwqmF8EVsUF8md-0kFTHHDxDzKxRA@mail.gmail.com>
	<20130508170536.GA30057@core.coreip.homeip.net>
	<CAFmpkyj90KoGgLeOqb3x00qBQ7Hmj3Fd_tXuWujx08QueV_9uQ@mail.gmail.com>
	<20130508172604.GB30057@core.coreip.homeip.net>
	<CANq1E4S7F9tZJxXX2i+1h1hkPfiCNhSTkqLw14NhPQ-vJjBtFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qe0-f45.google.com ([209.85.128.45]:34293 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753230Ab3EMRk2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 May 2013 13:40:28 -0400
Received: by mail-qe0-f45.google.com with SMTP id a11so3726520qen.4
        for <linux-input@vger.kernel.org>; Mon, 13 May 2013 10:40:27 -0700 (PDT)
In-Reply-To: <CANq1E4S7F9tZJxXX2i+1h1hkPfiCNhSTkqLw14NhPQ-vJjBtFg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

On Mon, May 13, 2013 at 1:03 PM, David Herrmann <dh.herrmann@gmail.com> wrote:

> I tried to put up some documentation. Comments welcome. If no problems
> arise with it, I will send a proper series later.

    I'd be inclined to add something about the mode button; it's
somewhat special.  Not special in the sense of anything magical
happening in the hardware, just special in the sense that it's the
control that isn't game related.  The hardware that has something that
maps to MODE generally intends the button to mean "pause the game and
let me interact with the OS.".  That's certainly the case for the PS
button on the sixaxis, the backlit X button on the 360 controller and
the home button on the Wii controllers.

    Force feedback is a land of crawling madness and chaos; I'm not
sure there's much right now that can be done to unify it.  You've got
devices with linear motors, rotary motors, speakers, resistance
systems, and combinations of those.  The motor systems are mounted at
different angles in different hardware.  You've potentially got
strange power limitations; there's hardware out there where the
combined draw of all the feedback motors is more than the cable
supplies to the gamepad, so you can't run them all at the same time.
You've got sound feedback vs. rumble feedback vs. active feedback (ie:
the joystick or wheel is actively pushing back against you or trying
to pull you around).  I'd love a unified force feedback system, but
there's so little commonality between devices that I'm not sure
there's any useful set to abstract over.

    I'd be inclined to make two button systems map to BTN_SOUTH and
BTN_EAST; those are the two button that fall most easily under your
thumb with a 4 button gamepad.  BTN_NORTH and BTN_WEST require you to
reach over the other two buttons, which is fine for most people but
less ideal for people with smaller hands.  Even people with large
hands usually find SOUTH and EAST the easiest to reach, so for most
games (at least in my experience) those two buttons wind up being
mapped to the actions we expect people to do the most.  A game might
still have to remap (or throw its hands up and tell you that a two
button controller means you need to keep the keyboard nearby), but I
think making BTN_SOUTH and BTN_EAST the defaults on a 2 button
controller (and adding NORTH or WEST for 3) will be most likely to
work out of the box with most games.

    For the cases where you have buttons in a square pattern rather
than a diamond, yes, I guess we just have to pick a 45 degree rotation
of the compass and live with that.  Having SOUTH and EAST along the
right side makes as much sense as the alternative, so I'm good with
this.

    Could we do explicit BTN_DPAD_UP/DOWN/LEFT/RIGHT?  It feels like
the HAPPY buttons are placeholder defines.

    On the menu pad, I think in practice there's quite often a button
labelled "start".  Granted, it's usually on the right, but see (for
example) the original xbox S controller, where "start" is indeed the
button on the right hand side (and "back" is the one on the left), but
the actual "menu pad" is to the left of the dpad.

    I'd prefer if things were mapped to a pair of digital buttons and
a pair of analog linear pot triggers for the shoulders; that covers a
lot of existing hardware (the xbox series gamepads, wii classic
gamepad, and playstation series gamepad can all be made to fit this
model without undue violence).

    Overall: My complaints are largely minor; there are some tweaks
I'd appreciate, but there's nothing fundamentally wrong here.

                                            Todd.

--
 Todd Showalter, President,
 Electron Jump Games, Inc.
