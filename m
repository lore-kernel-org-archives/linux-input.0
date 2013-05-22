From: Todd Showalter <todd@electronjump.com>
Subject: Re: [RFC 24/26] HID: wiimote: support Nintendo Wii U Pro Controller
Date: Wed, 22 May 2013 12:18:23 -0400
Message-ID: <CAFmpkyi935z7tkaYB99HtpsU8wRNA=eu3HeLF6OZ2vW0iVX5EQ@mail.gmail.com>
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
	<CAFmpkyhz_G_qRtx46ZXZLs+zG2WFhmv-=gQCv=tOK6ukQ3DZyw@mail.gmail.com>
	<CANq1E4RH2VpR9KwpykGCZxEH97xHeSKgMA=5h97HUc6TKhJS1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qe0-f46.google.com ([209.85.128.46]:39706 "EHLO
	mail-qe0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543Ab3EVQSY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 May 2013 12:18:24 -0400
Received: by mail-qe0-f46.google.com with SMTP id 1so1117414qee.19
        for <linux-input@vger.kernel.org>; Wed, 22 May 2013 09:18:23 -0700 (PDT)
In-Reply-To: <CANq1E4RH2VpR9KwpykGCZxEH97xHeSKgMA=5h97HUc6TKhJS1w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

On Wed, May 22, 2013 at 8:10 AM, David Herrmann <dh.herrmann@gmail.com> wrote:

> I think the kernel provides a pretty nice FF interface. It even
> provides emulations for the different kinds of FF if not all are
> supported by hardware. Anyway, that's beyond the scope of this
> definition and mostly belongs to joysticks. Gamepads normally only
> have rumble-motors, don't they?

    From an end-use point of view, (at least on casual reading, which
is as much as I can claim to have done at this point), the problem
with the force feedback API is that you find out what something is by
enumerating its capabilities, but the capabilities aren't specific
enough.

    Let's say I have a controller with two rotary motors.  I can
examine the FF caps and see that there are two motors, and possibly
even infer a little about them, but I don't think I can tell what
direction they are mounted in and how strong they are.

    There were some games on the PS2/PS3 that did some clever tricks
with force feedback; subtle stuff like making the controller fake a
gentle heartbeat that got faster and more uneven the more hurt your
character got, or gave feedback in time to the soundtrack.  To do that
really effectively, you need to understand the power, positioning,
response speed and orientation of the force feedback device.  Without
that complex understanding all you can really do is buzz or thump in a
fairly generic way.

> I wanted to have BTN_NORTH/A/GAMEPAD mapped for all gamepads, but
> you're right, the commercial systems use SOUTH/EAST for all trivial
> operations. I will change this and see whether we can get another key
> that is always mapped (probably BTN_SOUTH? and make this an alias for
> BTN_GAMEPAD).

    Sounds good.

> I changed the menu-pad definition a little bit. 1-button PADs map to
> BTN_START, 2-button pads to START and SELECT. BTN_MODE is no longer
> mapped as 3rd button but instead is a special button to acknowledge
> the fact that it is mostly some fancy branded button that isn't mapped
> by applications.
> So the menu-pad no longer _has_ to be in the middle, but I still map
> the right button to START and the left to SELECT to keep the "map by
> position, not by label" definition.

    Ok.

>>     I'd prefer if things were mapped to a pair of digital buttons and
>> a pair of analog linear pot triggers for the shoulders; that covers a
>> lot of existing hardware (the xbox series gamepads, wii classic
>> gamepad, and playstation series gamepad can all be made to fit this
>> model without undue violence).
>
> Ugh? I don't understand what you mean here.

    If you look at (for example) the XBox 360 controller, it has two
digital shoulder buttons (LB and RB, IIRC) and two analog shoulder
triggers (LT and RT).  The Wii Classic controller has the same; L and
R are analog, ZL and ZR are digital.  The PS series controllers have
four pressure sensitive buttons (L1, L2, R1, R2) which can be digital
or analog depending on whether you read the button bit or the pressure
sensor byte.  Other controllers all map onto this model reasonably
well.

    It's not ideal, but it's a fairly close.

> Thanks a lot! Unfortunately, I don't have all hardware at home so I
> can only test the Nintendo devices. However, I am trying to assemble a
> list of supported gamepads and how they are mapped. This will give us
> a better overview and we can see whether this definition actually
> makes sense.

    I've an original XBox S controller (with a Lik Sang USB adapter),
an XBox 360 wired controller (Microsoft-branded), a PS3 controller
(Sony-branded, but has to be plugged in since I don't have bluetooth),
and can probably dig up my gamecube/ps2/dreamcast USB adapter if given
time.

                                           Todd.

--
 Todd Showalter, President,
 Electron Jump Games, Inc.
